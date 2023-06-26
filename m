Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9449373E60D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjFZRO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjFZRO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:14:27 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FF5610C0;
        Mon, 26 Jun 2023 10:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687799662;
        bh=amdb1mPfMsiRmJBm8Eo09Eid0hPoWdxAGT5Zxy6Ft/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZWXPCQTWw623Q1vNv+xoIPOLumVdCGoXhA34p7bmbWUlqxfk7aEHff5ginUKhvfCT
         NqSKAvzs0byFrBDSFis97ckUcRPZ271Tulc7EHqcTi167+eAOFykJlnWgSlEJlSFuQ
         XTLRWxdBJlR6NgqPtWfzGlDxJSeZgAia0K4LVfno8iJeBT11yFzhtYDMig/Gtzaka6
         1ir6IFISFNHk+9BpSvh7T8ESPP5iDpM0rHJ0m3lHFfhy3FmCs413WI7KSppjRvNXWY
         0XiDkP2b/UikPNZnR0tHEEg4r0L8w8Jv8AeVOyb77KJT3QDwuGdbZG4uTm6lFeZHyb
         B8/ARNKYvOaww==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 6B7961812;
        Mon, 26 Jun 2023 19:14:22 +0200 (CEST)
Date:   Mon, 26 Jun 2023 19:14:21 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>
Subject: Re: splice(-> FIFO) never wakes up inotify IN_MODIFY?
Message-ID: <hjsfjimeuwnfz4xip3lthehuntabxc7tdbiopfzvk6vb4er7ur@3vb3r77wfeym>
References: <jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux>
 <CAOQ4uxhut2NHc+MY-XOJay5B-OKXU2X5Fe0-6-RCMKt584ft5A@mail.gmail.com>
 <ndm45oojyc5swspfxejfq4nd635xnx5m35otsireckxp6heduh@2opifgi3b3cw>
 <CAOQ4uxgCrxMKO7ZgAriMkKU-aKnShN+CG0XqP-yYFiyR=Os82A@mail.gmail.com>
 <jbg6kfxwniksrgnmnxr7go5kml2iw3tucnnbe4pqhvi4in6wlo@z6m4tcanewmk>
 <CAOQ4uxjizutWR37dm5RxiBY_L-bVHndJYaK_CHi88ZTT0DNpjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b55wfdvnqlf24i5q"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjizutWR37dm5RxiBY_L-bVHndJYaK_CHi88ZTT0DNpjg@mail.gmail.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--b55wfdvnqlf24i5q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 07:21:16PM +0300, Amir Goldstein wrote:
> On Mon, Jun 26, 2023 at 6:12=E2=80=AFPM Ahelenia Ziemia=C5=84ska
> <nabijaczleweli@nabijaczleweli.xyz> wrote:
> >
> > On Mon, Jun 26, 2023 at 05:53:46PM +0300, Amir Goldstein wrote:
> > > > So is it really true that the only way to poll a pipe is a
> > > > sleep()/read(O_NONBLOCK) loop?
> > > I don't think so, but inotify is not the way.
> > So what is? What do the kernel developers recommend as a way to see if a
> > file is written to, and that file happens to be a pipe?
> >
> > FTR, I've opened the symmetric Debian#1039488:
> >   https://bugs.debian.org/1039488
> > against coreutils, since, if this is expected, and writing to a pipe
> > should not generate write events on that pipe, then tail -f is currently
> > broken on most systems.
> First of all, it is better to mention that you are trying to fix a real
> world use case when you are reporting a kernel misbehavior.
I hadn't actually realised this affected coreutils tail as well before
re-testing it today.

> What this makes me wonder is, if tail -f <fifo> is broken as you claim
> it is, how is it that decades go by without anyone noticing this problem?
Most people don't use cat(1) that splice(2)s, I do;
even if they do, they probably haven't filled the whole buffer so the
missed splice(2) write was potentially covered by a later write(2) write.

> When looking at tail source code I see:
>=20
> /* Mark as '.ignore'd each member of F that corresponds to a
>    pipe or fifo, and return the number of non-ignored members.  */
> static size_t
> ignore_fifo_and_pipe (struct File_spec *f, size_t n_files)
> {
>   /* When there is no FILE operand and stdin is a pipe or FIFO
>      POSIX requires that tail ignore the -f option.
>      Since we allow multiple FILE operands, we extend that to say: with -=
f,
>      ignore any "-" operand that corresponds to a pipe or FIFO.  */
>=20
> and it looks like tail_forever_inotify() is not being called unless
> there are non pipes:
>=20
>   if (forever && ignore_fifo_and_pipe (F, n_files))
>     {
>=20
> The semantics of tail -f on a pipe input would be very odd, because
> the writer would need to close before tail can figure out which are
> the last lines.
The semantics of tail -f for FIFOs are formalised in POSIX, which says
(Issue 8 Draft 3):
  115551  =E2=88=92f If the input file is a regular file or if the file ope=
rand specifies a FIFO, do not
  115552     terminate after the last line of the input file has been copie=
d, but read and copy
  115553     further bytes from the input file when they become available. =
If no file operand is
  115554     specified and standard input is a pipe or FIFO, the =E2=88=92f=
 option shall be ignored. If the
  115555     input file is not a FIFO, pipe, or regular file, it is unspeci=
fied whether or not the =E2=88=92f
  115556     option shall be ignored.
coreutils sensibly interprets these in accordance with
  https://www.mail-archive.com/austin-group-l@opengroup.org/msg11402.html

There are no special provisions for pipes/FIFOs before the input is
exhausted, correct: tail is two programs in one; the first bit reads the
input(s) to completion and outputs the bit you wanted, the second bit
(-f) keeps reading the inputs from where the first bit left off.

(Note that tail with -c +123 and -n +123 doesn't "care" what lines are
 last, and just copies from byte/line 123, but that's beside the point.
 Indeed, "tail -c+1 fifo > log" is the idealised log collection program
 from before: many programs may write to fifo, and all output is
 collected in log.)

But yes: tail -f fifo first reads the entire "contents" of fifo
(where for pipes this is defined as "until all writers hang up"),
then continues reading fifo and copying whatever it reads.
On a strict single-file implementation you can get away with reading and
then sleeping when you get 0 (this is what traditional UNIX tails do).

When you have multiple files, well, you want to poll them, and since
pipes are unpollable, to avoid waking up every second and reading every
unpollable input file to see if you got something (regular files, fifos),
you use inotify(7) (coreutils) or kqueue(2) (NetBSD, probably others)
to tell you when there's data.

If inotify(7) for pipes worked, the entire coreutils tail -f semantic
is implementable as a single poll(2):
  * of each individual pollable (sockets, chardevs)
  * of inotify of unpollables   (pipes, regular files)
  * of pidfd                    (if --pid)
this is very attractive. Naturally, I could also fall back to just a
poll of pollables and pidfd with a second timeout if there are pipes in
the inputs, but you see how this is sub-optimal for no real good reason.
And, well, coreutils tail doesn't do this, so it's vulnerable.

> So honestly, we could maybe add IN_ACCESS/IN_MODIFY for the
> splice_pipe_to_pipe() case, but I would really like to know what
> the real use case is.
And splice_file_to_pipe() which is what we're hitting here.
The real use case is as I said: I would like to be able to poll pipes
with inotify instead of with sleep()/read().

> Another observation is that splice(2) never used to report any
> inotify events at all until a very recent commit in v6.4
> 983652c69199 ("splice: report related fsnotify events")
> but this commit left out the splice_pipe_to_pipe() case.
>=20
> CC the author of the patch to ask why this case was left
> out and whether he would be interested in fixing that.
I'm reading the discussion following
<20230322062519.409752-1-cccheng@synology.com> as
"people just forget to add inotify hooks to their I/O routines as a rule",
thus my guess on why it was left out was "didn't even cross my mind"
(or, perhaps "didn't think we even supported fsnotify for pipes").

Below you'll find a scissor-patch based on current linus HEAD;
I've tested it works as-expected for both tty-to-pipe and pipe-to-pipe
splices in my original reproducer.
-- >8 --
=46rom: =3D?UTF-8?q?Ahelenia=3D20Ziemia=3DC5=3D84ska?=3D
 <nabijaczleweli@nabijaczleweli.xyz>
Date: Mon, 26 Jun 2023 19:02:28 +0200
Subject: [PATCH] splice: always fsnotify_access(in), fsnotify_modify(out) on
 success

The current behaviour caused an asymmetry where some write APIs
(write, sendfile) would notify the written-to/read-from objects,
but splice wouldn't.

This affected userspace which used inotify, like coreutils tail -f.

Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs=
3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 fs/splice.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 3e06611d19ae..94fae24f9d54 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1154,7 +1154,8 @@ long do_splice(struct file *in, loff_t *off_in, struc=
t file *out,
 		if ((in->f_flags | out->f_flags) & O_NONBLOCK)
 			flags |=3D SPLICE_F_NONBLOCK;
=20
-		return splice_pipe_to_pipe(ipipe, opipe, len, flags);
+		ret =3D splice_pipe_to_pipe(ipipe, opipe, len, flags);
+		goto notify;
 	}
=20
 	if (ipipe) {
@@ -1182,15 +1183,12 @@ long do_splice(struct file *in, loff_t *off_in, str=
uct file *out,
 		ret =3D do_splice_from(ipipe, out, &offset, len, flags);
 		file_end_write(out);
=20
-		if (ret > 0)
-			fsnotify_modify(out);
-
 		if (!off_out)
 			out->f_pos =3D offset;
 		else
 			*off_out =3D offset;
=20
-		return ret;
+		goto notify;
 	}
=20
 	if (opipe) {
@@ -1209,18 +1207,23 @@ long do_splice(struct file *in, loff_t *off_in, str=
uct file *out,
=20
 		ret =3D splice_file_to_pipe(in, opipe, &offset, len, flags);
=20
-		if (ret > 0)
-			fsnotify_access(in);
-
 		if (!off_in)
 			in->f_pos =3D offset;
 		else
 			*off_in =3D offset;
=20
-		return ret;
+		goto notify;
 	}
=20
 	return -EINVAL;
+
+notify:
+	if (ret > 0) {
+		fsnotify_access(in);
+		fsnotify_modify(out);
+	}
+
+	return ret;
 }
=20
 static long __do_splice(struct file *in, loff_t __user *off_in,
--=20
2.39.2


--b55wfdvnqlf24i5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSZx2wACgkQvP0LAY0m
WPF7ow/8DJFZiBtowlD7Knds3uqv8cUJKjXB/RGZCju4FvHaxGoU50H5SxRSx4Zd
7tZOYV14Y9CgBF14lBJ3k1qH5+2gxE4XLwUT6kijo2uHE/sHzdgTwciqLMd6Hb8r
O0jy9xsbiemK8SQWVZDpZ708X/qzIycQj19kwzMi2ceRHh+UTTyTHr2WGx8wEfh3
RSx34ebxcsPMQSKcA3irq4kYQXTn9dBA8X287Zy2C6BKC/B/t+cDUaqk+S3fdUjP
RU7lTuWnugh+42Q8mC9zbTaEoWgGsRfVCq9xdOgp94LOiTwnpI+bK6kYXEdZSscZ
iFZ/Fzhjwwkt2bmyq55XR914VaMvgmMcL+x2W0KEIi3OdJ5FdHNSpbj+QyLk9WPL
Dt563G7aoX+jdx/H+l/kzcO74sE9ZTd0MYCnR3q1OlhQhzVOgZJvOF/YiSL9biEN
fXDYSb9Ms6ql/2Nr1V5sk9yZLbugqUlQIDxL/lWHLQlXK7UNCxePlqNhEXkLOatS
IsKABjEs35iQa3lTVSLcPebp/liJLYtUDsT77swpNLPpRdme/5/0PKAMUrvu4uFa
mITvuknEIP2WbybR28QJ4zDwS6/1YQtqBNqMUmfHSUupuWN+j9NdlnPJBaTFsupY
+1pzkuBjBFJHpycp4b3XSk37weN30K7EmDCnnheq8FTx5D737EQ=
=Qxn/
-----END PGP SIGNATURE-----

--b55wfdvnqlf24i5q--
