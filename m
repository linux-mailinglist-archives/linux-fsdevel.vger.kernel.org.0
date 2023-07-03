Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715E1745F5C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 17:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjGCPCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 11:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjGCPCW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:02:22 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56623E66;
        Mon,  3 Jul 2023 08:02:20 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-443512ad63cso1290268137.2;
        Mon, 03 Jul 2023 08:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688396539; x=1690988539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmhfsBnP5TnQGVV43HN+iWLywWBIkUwhqQA8Ozygf2E=;
        b=mSOYWWcDvgqwmBY7RX64wTJewCnM5Oh0sUT2TZRw9dnmd8pUMl+PzA5NtW/04pR/sz
         7VqGGQg5Nh58pJ5cJWeofMCrZO5AQBQLuH9o8myJhmv3HCeWr8E/Awj33nLbLz58dcXh
         Fuugp8t75xUIy5bo6KdiR35lXcQuuXdbCtgyqAOBgNP4AUq2okyiMMEovwo1TqaMfTot
         vSYETfRrOwJOJGwppodQSNwlh4spsWeAJSD3ysA/K/R2Db1QdwZovVRbW/3vqcHXiQ+n
         MFIf8lDRMIBqnttXd9qsglxVxsGnBFGvKrs2gYHxk3Jn4cscUcX+74DWv6OlYJ4VNvZS
         Opnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688396539; x=1690988539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmhfsBnP5TnQGVV43HN+iWLywWBIkUwhqQA8Ozygf2E=;
        b=MNnLES8Q+u3XwOIFmzH0JWqGc57VRUKFE6K/Rp4A/dTr4IUCDeF3xR4kWIMgr6qVFf
         z8TwxyFcR6dYqdL4klFuFkG9wRLu7lVRLbzGM02VuBq/tL0jwK0zbk64HVs5b1mUVtx2
         DsTV3ifSWz32ehnVtF37fHMt5JXbH2N6bjTNAAwa6YCGBoh0JBDgF/apocWCP9ticJHn
         LOR7by/Tj+S1rO8H3Vfj+bRxsaQBaSNJJPqKEf5FPSz/LPU9DNKkvdcQd8aXw5HB/T6O
         bvtUFZi+hSSk97JtkYNVHWu74876B2XJhRH6BvqaUOwDk5FvjBiNGuJiMFEpV7qD8f71
         vZMw==
X-Gm-Message-State: ABy/qLaXLuJWrB4QFXN9YOcY1gQQNBKiyFzriCInQ2wdfOPb9K2WZMm9
        uIW76BeWGnV80PidsSYovpk8I1rbcKeCZJ2zQS4=
X-Google-Smtp-Source: APBJJlHFxT1XA4LURpEBez1NMK8U5bzASTggtZiMxCi3TI5Wfqbk01Sau1s9iG9rLloep9aBraAH38fFTGMvLC4m+vg=
X-Received: by 2002:a67:e3b0:0:b0:443:677e:246e with SMTP id
 j16-20020a67e3b0000000b00443677e246emr4461579vsm.5.1688396539008; Mon, 03 Jul
 2023 08:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688393619.git.nabijaczleweli@nabijaczleweli.xyz> <604ec704d933e0e0121d9e107ce914512e045fad.1688393619.git.nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <604ec704d933e0e0121d9e107ce914512e045fad.1688393619.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 3 Jul 2023 18:02:07 +0300
Message-ID: <CAOQ4uxi=M08f3zRFf8xzHo=0VjP+O7Qkih_GNQs50jv4S8VCaA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] splice: always fsnotify_access(in),
 fsnotify_modify(out) on success
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Jul 3, 2023 at 5:42=E2=80=AFPM Ahelenia Ziemia=C5=84ska
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
> Acked-by: Jan Kara <jack@suse.cz>
> ---
>  fs/splice.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/fs/splice.c b/fs/splice.c
> index 3e06611d19ae..6ae6da52eba9 100644
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
> @@ -1182,18 +1180,11 @@ long do_splice(struct file *in, loff_t *off_in, s=
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
> -
> -               return ret;
> -       }
> -
> -       if (opipe) {
> +       } else if (opipe) {
>                 if (off_out)
>                         return -ESPIPE;
>                 if (off_in) {
> @@ -1209,18 +1200,24 @@ long do_splice(struct file *in, loff_t *off_in, s=
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

I must have missed this in previous reviews -
mixing if {} else (without {}) is an anti pattern that causes bugs.

No need to send v6 just for this - it can be fixed up on commit.

>
> -               return ret;
> +       if (ret > 0) {
> +               /*
> +                * Generate modify out before access in:
> +                * do_splice_from() may've already sent modify out,
> +                * and this ensures the events get merged.
> +                */
> +               fsnotify_modify(out);
> +               fsnotify_access(in);
>         }
>
> -       return -EINVAL;
> +       return ret;
>  }
>
>  static long __do_splice(struct file *in, loff_t __user *off_in,
> --
> 2.39.2
>
