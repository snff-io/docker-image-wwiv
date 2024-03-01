# WWIV BBS in a Box

Run your very own [WWIV][] BBS in a container.  This `Dockerfile` will
build WWIV from the [git repository][git].

[wwiv]: http://www.wwivbbs.org/
[git]: https://github.com/wwivbbs/wwiv/

## Building the image

If you want to pull the image from the Docker registry you may skip
this step.

The following command will build an image named `wwiv`, using the
current `master` branch:

    docker build -t wwiv .

You can build a specific commit by passing in the `git_refspec` build
argument, e.g. to build using commit `97770bd`:

    docker build --arg git_refspec=97770bd -t wwiv .

## Running the image

Create a volume in which you will store your BBS configuration data:

    docker volume create wwiv

Now boot a container from the image you built in the previous step,
mounting your volume on `/srv/wwiv`:

    docker run -it -v wwiv:/srv/wwiv --name wwiv <imagename>

Where `<imagename>` is whatever you named your image in the previous
step (`wwiv` if you used the example command line verbatim), or
`larsks/wwiv` if you want to pull the image from the Docker registry.

The first time you run the image it will automatically run the WWIV
`init` program to create the initial configuration.  You *must* select
`W` from the main menu in order to configure the WWIV server process
(`wwivd`).

Subsequent runs using the same volume will directly start the `wwivd`
process.

## Interacting with a running container

When your BBS is running, you can execute commands inside the
container using the `docker exec` command. For example, to log in to
the BBS locally:

    docker exec -it -u wwiv wwiv /opt/wwiv/bbs


## UPDATES jazam 050124

Recommenedations;

NOTE: The ENTRYPOINT script has changed considerably and looks for `WWIV_MODE`. If there is no `WWIV_MODE` specified and you are running interactivly, you'll get a nice menu. If you set `WWIV_MODE` to `"config"` you'll get wwivconfig, if you set it to `"wfc"`, you'll get a "working" wfc screen / local instance. `WWIV_MODE=""` or anything `else` runs wwivd.

1) Make sure to create and set the `VOLUME` to `wwiv`: `docker volume create wwiv`

THEN

2) NEW BBS: `config.sh`: modify the ports in `config.sh` and run in to configure bbs/wwivd. Exit the config, stop and remove container. Saving config is seems finicky.

THEN

4) `wfc.sh`: run this for a "working" wfc screen! The "S" menu option shows a cool status screen that actually works! You can leave this running if you like.

THEN

5) `wwivd.sh`: this is your local test/production script. Check the ports for production interference/readiness before running.

THEN

3) `config.sh`: ongoing; check the ports in config (to not override your production ports) and run for an instance of wwivconfig you can leave open and see what saves dynamically. 

