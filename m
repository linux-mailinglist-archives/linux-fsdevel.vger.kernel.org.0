Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F157402DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 20:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjF0SK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 14:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjF0SK2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:10:28 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C42D2976;
        Tue, 27 Jun 2023 11:10:23 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-783eef15004so1249161241.3;
        Tue, 27 Jun 2023 11:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687889421; x=1690481421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxAO7TkpAopVR9RFBa3ieNMWyhRAiu+znyikTlS1Z8c=;
        b=S9BFeKqM99KjDoFbnkBHX7/8AHDKJT+eQUCHhBmo31QVx/NLnXo0dWbYVh+wmbA6du
         NDcGrFkPjA3FHlr4BaU79GX3HeApMPCTZU8A3WofOsB0tlLsG3ogtMVEsgnh6hV7KKSv
         aXfxUKSTl2imkTZdrS1aDFIsyjs+hyjpUOAvKf1IluqvFAhw99Yvxhd3UDThpu4IKceY
         N6K438qlgtuQA4AxmOawC6UvSW/gntAHYeq4YrZ6QBtRpP7UmqKXyg2zgYH2lgy4LTWl
         AqqCUPoFdzGKIuWGt9tYq/cTBX5+SSsFTo9cvgWRxmbwhwyaQ5wsARdDKB2NN7qhu2I4
         5SaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889421; x=1690481421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxAO7TkpAopVR9RFBa3ieNMWyhRAiu+znyikTlS1Z8c=;
        b=VgEz8TXsLD/b+ibNMMgNHrhKI2yIwL3kNhR3ixMPHHQ+gFonsPvF3ktyRrjgsvtJkX
         CUvWOgGnpZ+7aFY53JacJWrUPzRvsYqdKDRrsmvapAPc8Bjgit7GnRNHjg3mqN1f8Uld
         BFPfcvAV7TEnlVlfR/RQhKTnK18APeM504Cql8JCuzyC+RPjsKGWehpfKA0c2wIkHiRP
         phKMR1NTmH/3IUT8WSY0j4lEwmFiZEeCKEtyZHdNQXlDONCpJYzKz2Zx53zVMZK9waYG
         I6XU9mmI94Rg71UO0QaHN7YVxdqBEP+k/LGB/KdhMMhGKUMRhCkGcwU/ZOJWuNALPdwu
         T7ew==
X-Gm-Message-State: AC+VfDwR+tGx5kC28puG0BDDNBI8CmVN0PTh6N/nse43OlxpYBf4TLlZ
        k5OjYsZfxiaeMyORS+sD/NxPyJwARhL+/P1loz8=
X-Google-Smtp-Source: ACHHUZ7Zb8q/wCFi7zM0Qpj8qjr4TMQP1fy8LFuCyoWu+IF10Wr8+ar35SEqKibBYA4ztGVokdLySX7Aiz+qp9DZOso=
X-Received: by 2002:a67:ff89:0:b0:440:d2dc:fbdf with SMTP id
 v9-20020a67ff89000000b00440d2dcfbdfmr7661864vsq.9.1687889421090; Tue, 27 Jun
 2023 11:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxh7i_s4R9pFJPENALdWGG5-dDhqPLEUXuJqSoHraktFiA@mail.gmail.com>
 <cover.1687884029.git.nabijaczleweli@nabijaczleweli.xyz> <8827a512f0974b9f261887d344c3b1ffde7b21e5.1687884031.git.nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <8827a512f0974b9f261887d344c3b1ffde7b21e5.1687884031.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Jun 2023 21:10:09 +0300
Message-ID: <CAOQ4uxj3j7gMJSojkdfe+8fQrKtJtY7wBY1UOHtQUuQ_WMjObA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] splice: always fsnotify_access(in),
 fsnotify_modify(out) on success
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
> The current behaviour caused an asymmetry where some write APIs
> (write, sendfile) would notify the written-to/read-from objects,
> but splice wouldn't.
>
> This affected userspace which uses inotify, most notably coreutils
> tail -f, to monitor pipes.
> If the pipe buffer had been filled by a splice-family function:
>   * tail wouldn't know and thus wouldn't service the pipe, and
>   * all writes to the pipe would block because it's full,
> thus service was denied.
> (For the particular case of tail -f this could be worked around
>  with ---disable-inotify.)
>
> Fixes: 983652c69199 ("splice: report related fsnotify events")
> Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffy=
js3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
> Link: https://bugs.debian.org/1039488
> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xy=
z>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/splice.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/fs/splice.c b/fs/splice.c
> index 3e06611d19ae..e16f4f032d2f 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1154,10 +1154,8 @@ long do_splice(struct file *in, loff_t *off_in, st=
ruct file *out,
>                 if ((in->f_flags | out->f_flags) & O_NONBLOCK)
>                         flags |=3D SPLICE_F_NONBLOCK;
>
> -               return splice_pipe_to_pipe(ipipe, opipe, len, flags);
> -       }
> -
> -       if (ipipe) {
> +               ret =3D splice_pipe_to_pipe(ipipe, opipe, len, flags);
> +       } else if (ipipe) {
>                 if (off_in)
>                         return -ESPIPE;
>                 if (off_out) {
> @@ -1182,18 +1180,15 @@ long do_splice(struct file *in, loff_t *off_in, s=
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
> -       }
> -
> -       if (opipe) {
> +               // splice_write-> already marked out
> +               // as modified via vfs_iter_write()
> +               goto noaccessout;
> +       } else if (opipe) {
>                 if (off_out)
>                         return -ESPIPE;
>                 if (off_in) {
> @@ -1209,18 +1204,20 @@ long do_splice(struct file *in, loff_t *off_in, s=
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
> +       } else
> +               return -EINVAL;
>
> -               return ret;
> -       }
> +       if (ret > 0)
> +               fsnotify_modify(out);
> +noaccessout:
> +       if (ret > 0)
> +               fsnotify_access(in);
>

As I wrote, I don't like this special case.
I prefer that we generate double IN_MODIFY than
having to maintain unreadable code.

Let's see what Jan has to say about this.

Thanks,
Amir.
