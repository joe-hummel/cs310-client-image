#! /usr/bin/env python3

import os
import pathlib
import json

import click

from fullGSapi.cli.login import login, check_login
from fullGSapi.cli.submit import submit
from fullGSapi.cli.utils import login_token_path_option, LoginTokens, get_tokens, getListOfFiles

@click.group()
@click.option('--debug/--no-debug', default=False)
@login_token_path_option
@click.pass_context
def cli(ctx: click.Context, debug: bool, tokenpath: str):
    """
    This is the tool for submitting CS211 assignments.
    """
    ctx.ensure_object(dict)
    ctx.obj["TOKENPATH"] = tokenpath
    ctx.obj["TOKEN"] = None
    ctx.obj["DEBUG"] = debug


@click.command()
@click.argument("course_id", required=True)
@click.argument("project_id", required=True)
@click.argument("files", nargs=-1, type=click.Path(exists=True))
@click.pass_context
def submit(ctx, course_id: str, project_id: str, files: click.Path):
    """
    Submit FILES to the indicated assignment on Gradescope.

    Requires FILES to contain all expected files for the indicated assignment.
    """
    
    tokens: LoginTokens = get_tokens(ctx)

    submission_id = None
    gsFull = tokens.gsFullapi
    gsAPI = tokens.gsAPI

    click.echo("Collecting files...")

    # Check that no directories are included
    for filename in files:
        if not os.path.isfile(filename):
            click.echo(f"ERROR: '{filename}' is not a file. Only submit files, not directories.")
            return

    # Create dictionary of file contents
    files_dict = {}
    for filename in files:
        click.echo(f"\t{os.path.basename(filename)}")
        files_dict[os.path.basename(filename)] = open(filename, 'rb').read()

    # Send everything to gradescope
    click.echo("Uploading programming submission...")
    res = gsAPI.upload_programming_submission(course_id, project_id, None, files_dict=files_dict)

    if res.ok:
        click.echo("\tSuccess!")
        try:
            data = json.loads(res.content)
            submission_id = data['id']
            print(f"Submission URL: https://www.gradescope.com/courses/{course_id}/assignments/{project_id}/submissions/{submission_id}")
        except Exception as e:
            print(e)
            import traceback
            traceback.print_exc()
            click.echo(f"Failed to parse response: {res.content}!")
    else:
        click.echo("Failed!")
        click.echo(res.content)


cli.add_command(login)
cli.add_command(check_login)
cli.add_command(submit)

if __name__ == '__main__':
    cli()
