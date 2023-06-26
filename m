Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741DD73EAAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 20:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjFZS6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 14:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjFZS6B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:58:01 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAB697;
        Mon, 26 Jun 2023 11:58:00 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7943be26e84so298630241.2;
        Mon, 26 Jun 2023 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687805879; x=1690397879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SzVxHDYUQI9U3S9jsDL5NpiHMSOSpk32ONITy9TUMU=;
        b=HdjLnrY19qRAbALIy9lLZh3xLd+yI+AeX+TorbRNl+etDSf/zlkS+56KtZDsPVEQjW
         OSCX2Yc5c9WKJZjll3wxQEfNezn32KVo7Jp7nmg/RIhhzyLoi4rxgT6kFQHo1L4SB9TX
         sfB7uIcsfH8V/ZAfqg/1SWuWmPZMtaHLbi7pE7KlU7KT+H7vdbLYJHnOlNjTT1EA6naa
         CBXzl0qLQyEbazyOGR3ZpqzIc4rqOSjI0u1UAuuWXM8RoHi9u4H6MTJFsVThTNC0LGSy
         WpKVc+8d5l1f53IQHm6yuEZwIpdkIqPPMeA9Tdw+SHEKMGJhy22cjrqXiYnGAQogTtKS
         iibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687805879; x=1690397879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SzVxHDYUQI9U3S9jsDL5NpiHMSOSpk32ONITy9TUMU=;
        b=NWlAlnBBUHrhY0ilux+/1x8ljqecaR+EDyzNN2cQTbrBwX6zPy/8ejsmPAiB4NFTWR
         CfuPEakTKYdwRddDP4rGU4arsTbGTgetrEINHeFI1p+EYuHL9SZxk/FKoNEecXgjJcJ0
         0GR0GcrbHM7CgNR8eBnUe5EQ2dJzRLwVgG7A21rBIEOQVH+3Sin+8GXrxNpsHMGvO20v
         FIZdunjuSbNEpV0OnRAy4BWNLN5jiy/mGAeO4+FVe3p7DFeetLVOApBI1J+uWVR4vhYq
         H3XQgoPq3IkzpnAP5ltYomlEfqTXD5ApgM01UV6ClmDmGzHBCUUI98OE6nTZsyGs6ZgW
         O4zg==
X-Gm-Message-State: AC+VfDwgoJtgs3aRSP5OdjziBkwkWjggfKWpwC0XHr0aBwKJ91jWU5CH
        Zc85rg7PnPg0bJDcsuyC1fgmsLRXfwOJ15fxaxI=
X-Google-Smtp-Source: ACHHUZ4eJxhim0i08Nf3gxZpaq6PSHAHYS++YLcZ91k769Ly0QQo+qOIq15zxTIbqe7rGuECiqWBb490sRN+4d70VEQ=
X-Received: by 2002:a67:b403:0:b0:443:5b37:a5a5 with SMTP id
 x3-20020a67b403000000b004435b37a5a5mr1517781vsl.34.1687805879006; Mon, 26 Jun
 2023 11:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux>
 <CAOQ4uxhut2NHc+MY-XOJay5B-OKXU2X5Fe0-6-RCMKt584ft5A@mail.gmail.com>
 <ndm45oojyc5swspfxejfq4nd635xnx5m35otsireckxp6heduh@2opifgi3b3cw>
 <CAOQ4uxgCrxMKO7ZgAriMkKU-aKnShN+CG0XqP-yYFiyR=Os82A@mail.gmail.com>
 <jbg6kfxwniksrgnmnxr7go5kml2iw3tucnnbe4pqhvi4in6wlo@z6m4tcanewmk>
 <CAOQ4uxjizutWR37dm5RxiBY_L-bVHndJYaK_CHi88ZTT0DNpjg@mail.gmail.com> <hjsfjimeuwnfz4xip3lthehuntabxc7tdbiopfzvk6vb4er7ur@3vb3r77wfeym>
In-Reply-To: <hjsfjimeuwnfz4xip3lthehuntabxc7tdbiopfzvk6vb4er7ur@3vb3r77wfeym>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 26 Jun 2023 21:57:47 +0300
Message-ID: <CAOQ4uxj_DLm8_stRJPR7i8bp9aJ5VtjzWqHL2egCTKe3M-6KSw@mail.gmail.com>
Subject: Re: splice(-> FIFO) never wakes up inotify IN_MODIFY?
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 8:14=E2=80=AFPM Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> On Mon, Jun 26, 2023 at 07:21:16PM +0300, Amir Goldstein wrote:
> > On Mon, Jun 26, 2023 at 6:12=E2=80=AFPM Ahelenia Ziemia=C5=84ska
> > <nabijaczleweli@nabijaczleweli.xyz> wrote:
> > >
> > > On Mon, Jun 26, 2023 at 05:53:46PM +0300, Amir Goldstein wrote:
> > > > > So is it really true that the only way to poll a pipe is a
> > > > > sleep()/read(O_NONBLOCK) loop?
> > > > I don't think so, but inotify is not the way.
> > > So what is? What do the kernel developers recommend as a way to see i=
f a
> > > file is written to, and that file happens to be a pipe?
> > >
> > > FTR, I've opened the symmetric Debian#1039488:
> > >   https://bugs.debian.org/1039488
> > > against coreutils, since, if this is expected, and writing to a pipe
> > > should not generate write events on that pipe, then tail -f is curren=
tly
> > > broken on most systems.
> > First of all, it is better to mention that you are trying to fix a real
> > world use case when you are reporting a kernel misbehavior.
> I hadn't actually realised this affected coreutils tail as well before
> re-testing it today.
>
> > What this makes me wonder is, if tail -f <fifo> is broken as you claim
> > it is, how is it that decades go by without anyone noticing this proble=
m?
> Most people don't use cat(1) that splice(2)s, I do;
> even if they do, they probably haven't filled the whole buffer so the
> missed splice(2) write was potentially covered by a later write(2) write.
>
> > When looking at tail source code I see:
> >
> > /* Mark as '.ignore'd each member of F that corresponds to a
> >    pipe or fifo, and return the number of non-ignored members.  */
> > static size_t
> > ignore_fifo_and_pipe (struct File_spec *f, size_t n_files)
> > {
> >   /* When there is no FILE operand and stdin is a pipe or FIFO
> >      POSIX requires that tail ignore the -f option.
> >      Since we allow multiple FILE operands, we extend that to say: with=
 -f,
> >      ignore any "-" operand that corresponds to a pipe or FIFO.  */
> >
> > and it looks like tail_forever_inotify() is not being called unless
> > there are non pipes:
> >
> >   if (forever && ignore_fifo_and_pipe (F, n_files))
> >     {
> >
> > The semantics of tail -f on a pipe input would be very odd, because
> > the writer would need to close before tail can figure out which are
> > the last lines.
> The semantics of tail -f for FIFOs are formalised in POSIX, which says
> (Issue 8 Draft 3):
>   115551  =E2=88=92f If the input file is a regular file or if the file o=
perand specifies a FIFO, do not
>   115552     terminate after the last line of the input file has been cop=
ied, but read and copy
>   115553     further bytes from the input file when they become available=
. If no file operand is
>   115554     specified and standard input is a pipe or FIFO, the =E2=88=
=92f option shall be ignored. If the
>   115555     input file is not a FIFO, pipe, or regular file, it is unspe=
cified whether or not the =E2=88=92f
>   115556     option shall be ignored.
> coreutils sensibly interprets these in accordance with
>   https://www.mail-archive.com/austin-group-l@opengroup.org/msg11402.html
>
> There are no special provisions for pipes/FIFOs before the input is
> exhausted, correct: tail is two programs in one; the first bit reads the
> input(s) to completion and outputs the bit you wanted, the second bit
> (-f) keeps reading the inputs from where the first bit left off.
>
> (Note that tail with -c +123 and -n +123 doesn't "care" what lines are
>  last, and just copies from byte/line 123, but that's beside the point.
>  Indeed, "tail -c+1 fifo > log" is the idealised log collection program
>  from before: many programs may write to fifo, and all output is
>  collected in log.)
>
> But yes: tail -f fifo first reads the entire "contents" of fifo
> (where for pipes this is defined as "until all writers hang up"),
> then continues reading fifo and copying whatever it reads.
> On a strict single-file implementation you can get away with reading and
> then sleeping when you get 0 (this is what traditional UNIX tails do).
>
> When you have multiple files, well, you want to poll them, and since
> pipes are unpollable, to avoid waking up every second and reading every
> unpollable input file to see if you got something (regular files, fifos),
> you use inotify(7) (coreutils) or kqueue(2) (NetBSD, probably others)
> to tell you when there's data.
>
> If inotify(7) for pipes worked, the entire coreutils tail -f semantic
> is implementable as a single poll(2):
>   * of each individual pollable (sockets, chardevs)
>   * of inotify of unpollables   (pipes, regular files)
>   * of pidfd                    (if --pid)
> this is very attractive. Naturally, I could also fall back to just a
> poll of pollables and pidfd with a second timeout if there are pipes in
> the inputs, but you see how this is sub-optimal for no real good reason.
> And, well, coreutils tail doesn't do this, so it's vulnerable.
>

Thanks for the explanation.

> > So honestly, we could maybe add IN_ACCESS/IN_MODIFY for the
> > splice_pipe_to_pipe() case, but I would really like to know what
> > the real use case is.
> And splice_file_to_pipe() which is what we're hitting here.
> The real use case is as I said: I would like to be able to poll pipes
> with inotify instead of with sleep()/read().
>
> > Another observation is that splice(2) never used to report any
> > inotify events at all until a very recent commit in v6.4
> > 983652c69199 ("splice: report related fsnotify events")
> > but this commit left out the splice_pipe_to_pipe() case.
> >
> > CC the author of the patch to ask why this case was left
> > out and whether he would be interested in fixing that.
> I'm reading the discussion following
> <20230322062519.409752-1-cccheng@synology.com> as
> "people just forget to add inotify hooks to their I/O routines as a rule"=
,
> thus my guess on why it was left out was "didn't even cross my mind"
> (or, perhaps "didn't think we even supported fsnotify for pipes").
>
> Below you'll find a scissor-patch based on current linus HEAD;
> I've tested it works as-expected for both tty-to-pipe and pipe-to-pipe
> splices in my original reproducer.
> -- >8 --
> From: =3D?UTF-8?q?Ahelenia=3D20Ziemia=3DC5=3D84ska?=3D
>  <nabijaczleweli@nabijaczleweli.xyz>
> Date: Mon, 26 Jun 2023 19:02:28 +0200
> Subject: [PATCH] splice: always fsnotify_access(in), fsnotify_modify(out)=
 on
>  success
>
> The current behaviour caused an asymmetry where some write APIs
> (write, sendfile) would notify the written-to/read-from objects,
> but splice wouldn't.
>
> This affected userspace which used inotify, like coreutils tail -f.
>
> Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffy=
js3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xy=
z>

(Create dependency in case they should be backported)

Fixes: 983652c69199 ("splice: report related fsnotify events")

Makes sense.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/splice.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/fs/splice.c b/fs/splice.c
> index 3e06611d19ae..94fae24f9d54 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1154,7 +1154,8 @@ long do_splice(struct file *in, loff_t *off_in, str=
uct file *out,
>                 if ((in->f_flags | out->f_flags) & O_NONBLOCK)
>                         flags |=3D SPLICE_F_NONBLOCK;
>
> -               return splice_pipe_to_pipe(ipipe, opipe, len, flags);
> +               ret =3D splice_pipe_to_pipe(ipipe, opipe, len, flags);
> +               goto notify;
>         }
>
>         if (ipipe) {
> @@ -1182,15 +1183,12 @@ long do_splice(struct file *in, loff_t *off_in, s=
truct file *out,
>                 ret =3D do_splice_from(ipipe, out, &offset, len, flags);
>                 file_end_write(out);
>
> -               if (ret > 0)
> -                       fsnotify_modify(out);
> -
>                 if (!off_out)
>                         out->f_pos =3D offset;
>                 else
>                         *off_out =3D offset;
>
> -               return ret;
> +               goto notify;
>         }
>
>         if (opipe) {
> @@ -1209,18 +1207,23 @@ long do_splice(struct file *in, loff_t *off_in, s=
truct file *out,
>
>                 ret =3D splice_file_to_pipe(in, opipe, &offset, len, flag=
s);
>
> -               if (ret > 0)
> -                       fsnotify_access(in);
> -
>                 if (!off_in)
>                         in->f_pos =3D offset;
>                 else
>                         *off_in =3D offset;
>
> -               return ret;
> +               goto notify;
>         }
>
>         return -EINVAL;
> +
> +notify:
> +       if (ret > 0) {
> +               fsnotify_access(in);
> +               fsnotify_modify(out);
> +       }
> +
> +       return ret;
>  }
>
>  static long __do_splice(struct file *in, loff_t __user *off_in,
> --
> 2.39.2
>
