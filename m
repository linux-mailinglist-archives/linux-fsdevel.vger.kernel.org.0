Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478497402D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 20:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjF0SDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 14:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjF0SDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:03:31 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74641E5B;
        Tue, 27 Jun 2023 11:03:30 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-784f7f7deddso1404417241.3;
        Tue, 27 Jun 2023 11:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687889009; x=1690481009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnGF7hW1RzNznswwuvCHQcYtw/RCT6vHLe0ato2wfTg=;
        b=d38ul6ybkBlmaIIjHkncAdDDJh0KIRsNWwwvHwYwbBHKU+Xu3EfBWqAZS8jazRMQQN
         Cw9pUdl82AUXoruwZQK1YawnXR07ukE3iLz5deZC6HKSU2WuZuQEIpfQJsUbcOm6mVxK
         D0eE90h+qLtE6pnkAuVe5aATNTlknhVdHqwJ2TM4RHB+6S182KpzpYKCA/7c90x/FirT
         L33fkhc/rA8qzpdMvjj6PdaW19eXr9DEdyMQXQRMBjaue3DMkwUuH1ATwYqe2M1DNsVh
         yLEPWqLZv0bO3W6W/4ts5oxowpwXRFHnfBxO9fU4ufrzo+07gzUeKWJAzawpbV7qD4g0
         UGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889009; x=1690481009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnGF7hW1RzNznswwuvCHQcYtw/RCT6vHLe0ato2wfTg=;
        b=Z5hg0kYDZmy8jkFcREJA7ORRUDVPL4ttMt4uJwGRzUyVY+CFKwlmvQ0TMRHtjKndDk
         Nz+xJCKI8weVrdD0gqBbZCT4LeG9kBuAL1W7ND76Pb0MDTUnVZL5BnH1We7D9FpuVUz0
         Wvodz8+r9LSCjUQc3sw8tXnGM0oLuw4xI7Q95qJvSaYRPfDK+Fhu/0m4TyO+JUQ5a8kX
         YVm+7dvPKjYYGJ05p05Ib1akdy+XuxirJxJrt9EksCB3O76qO9hlrUK37FUMFFy5u/N4
         ILQpnFVLhmGJj28xO+qPU5F/Nf553mTMFwR5ORD2z/R8QGnUCCtkVI1HslSZpuTShZsF
         OYGA==
X-Gm-Message-State: AC+VfDzyyKbhfy3ZWIVo1FgwbhFqOUinQa6K82ZkpRuophr6JsbdBjsO
        rWCKWgIw0k7RsVPDDR5DaiHQZlETTyaLbkk99X4=
X-Google-Smtp-Source: ACHHUZ5W7Ud2Mh/ONm5AIRaqLRJqVe7z1xNd+UMK67Bhtk17zj2Hbqo61d9gMa7fLvANRVZJHji+DURVSLqK3bYiKg0=
X-Received: by 2002:a05:6102:367a:b0:440:b1f3:b476 with SMTP id
 bg26-20020a056102367a00b00440b1f3b476mr14145323vsb.17.1687889009354; Tue, 27
 Jun 2023 11:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxh7i_s4R9pFJPENALdWGG5-dDhqPLEUXuJqSoHraktFiA@mail.gmail.com>
 <cover.1687884029.git.nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <cover.1687884029.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Jun 2023 21:03:17 +0300
Message-ID: <CAOQ4uxg38PDSEWARiWpDBvuYC4szj3R3ZkoLkO76Ap6nKjTRTA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3+1] fanotify accounting for fs/splice.c
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@vger.kernel.org
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

On Tue, Jun 27, 2023 at 7:55=E2=80=AFPM Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> In 1/3 I've applied if/else if/else tree like you said,
> and expounded a bit in the message.
>
> This is less pretty now, however, since it turns out that

If my advice turns out to be bad, then please drop it.

> iter_file_splice_write() already marks the out fd as written because it
> writes to it via vfs_iter_write(), and that sent a double notification.
>
> $ git grep -F .splice_write | grep -v iter_file_splice_write
> drivers/char/mem.c:     .splice_write   =3D splice_write_null,
> drivers/char/virtio_console.c:  .splice_write =3D port_fops_splice_write,
> fs/fuse/dev.c:  .splice_write   =3D fuse_dev_splice_write,
> fs/gfs2/file.c: .splice_write   =3D gfs2_file_splice_write,
> fs/gfs2/file.c: .splice_write   =3D gfs2_file_splice_write,
> fs/overlayfs/file.c:    .splice_write   =3D ovl_splice_write,
> net/socket.c:   .splice_write =3D generic_splice_sendpage,
> scripts/coccinelle/api/stream_open.cocci:    .splice_write =3D splice_wri=
te_f,
>
> Of these, splice_write_null() doesn't mark out as written
> (but it's for /dev/null so I think this is expected),
> and I haven't been able to visually confirm whether
> port_fops_splice_write() and generic_splice_sendpage() do.
>
> All the others delegate to iter_file_splice_write().
>

All this is very troubling to me.
It translates to a mental model that I cannot remember and
cannot maintain for fixes whose value are still questionable.

IIUC, the only thing you need to change in do_splice() for
making your use case work is to add fsnotify_modify()
for the splice_pipe_to_pipe() case. Right?

So either make the change that you need, or all the changes
that are simple to follow without trying to make the world
consistent - these pipe iterators business is really messy.
I don't know if avoiding a double event (which is likely not visible)
is worth the complicated code that is hard to understand.

> In 2/3 I fixed the vmsplice notification placement
> (access from pipe, modify to pipe).
>
> I'm following this up with an LTP patch, where only sendfile_file_to_pipe
> passes on 6.1.27-1 and all tests pass on v6.4 + this patchset.
>

Were these tests able to detect the double event?
Maybe it's not visible because double consequent events get merged.

> Ahelenia Ziemia=C5=84ska (3):
>   splice: always fsnotify_access(in), fsnotify_modify(out) on success
>   splice: fsnotify_access(fd)/fsnotify_modify(fd) in vmsplice
>   splice: fsnotify_access(in), fsnotify_modify(out) on success in tee
>
>  fs/splice.c | 43 +++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
>
>
> Interdiff against v2:
> diff --git a/fs/splice.c b/fs/splice.c
> index 3234aaa6e957..0427f0a91c7d 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1155,10 +1155,7 @@ long do_splice(struct file *in, loff_t *off_in, st=
ruct file *out,
>                         flags |=3D SPLICE_F_NONBLOCK;
>
>                 ret =3D splice_pipe_to_pipe(ipipe, opipe, len, flags);
> -               goto notify;
> -       }
> -
> -       if (ipipe) {
> +       } else if (ipipe) {
>                 if (off_in)
>                         return -ESPIPE;
>                 if (off_out) {
> @@ -1188,10 +1185,10 @@ long do_splice(struct file *in, loff_t *off_in, s=
truct file *out,
>                 else
>                         *off_out =3D offset;
>
> -               goto notify;
> -       }
> -
> -       if (opipe) {
> +               // ->splice_write already marked out
> +               // as modified via vfs_iter_write()
> +               goto noaccessout;

That's too ugly IMO.
Are you claiming that the code in master is wrong?
Because in master there is fsnotify_modify(out) for (ipipe) case.

> +       } else if (opipe) {
>                 if (off_out)
>                         return -ESPIPE;
>                 if (off_in) {
> @@ -1211,17 +1208,14 @@ long do_splice(struct file *in, loff_t *off_in, s=
truct file *out,
>                         in->f_pos =3D offset;
>                 else
>                         *off_in =3D offset;
> +       } else
> +               return -EINVAL;
>
> -               goto notify;
> -       }
> -
> -       return -EINVAL;
> -
> -notify:
> -       if (ret > 0) {
> -               fsnotify_access(in);
> +       if (ret > 0)
>                 fsnotify_modify(out);
> -       }
> +noaccessout:
> +       if (ret > 0)
> +               fsnotify_access(in);
>

Not to mention that it should be nomodifyout, but I dislike this
"common" code that it not common at all, so either just handle
the pipe_to_pipe case to fix your use case or leave this code
completely common ignoring the possible double events.

Thanks,
Amir.
