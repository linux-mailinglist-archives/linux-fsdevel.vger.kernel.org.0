Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8B973F483
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 08:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjF0G2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 02:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjF0G2A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:28:00 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5E6E5F;
        Mon, 26 Jun 2023 23:27:57 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-47193e20887so1437967e0c.3;
        Mon, 26 Jun 2023 23:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687847277; x=1690439277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gF8aIuRYtNs3jc1wnHqRPI29mBVuzl+wPTZVNGx3iDA=;
        b=N/rhcDEqiqMw327Eu9TXoay0oLfU1pTvA42z8+pNh5liF4riVKNuvSS0ZmhJfDDCFf
         DrC5XQK6cF6C4Km8BWn3QeU2Oz5LSEIgde7UbzCpxrOObIAAzx/CV6ucyhnJxq6u3nHL
         KQi9rPqOAK8m/X9/PWpDAyW2ikzI7jbTY0UeJuYvmX2b8NSoNXpwIHPxjR3liGO54uzq
         LGMZ+bttssX3b9DlOJJIwj3uhwDgjRHW+Rd6D0wYhwwdFOg9WuZiSDmHsyo4DzffMbJ2
         USL/BBbaobw1IyioMGcu7Y6KLzOgeECPRwXcUUnP0AWLy2r4Bm0bzksx81TQXQZ8mruk
         RcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687847277; x=1690439277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gF8aIuRYtNs3jc1wnHqRPI29mBVuzl+wPTZVNGx3iDA=;
        b=QLnfAgiCJWuDirW2NagBbDOX3h0igbko+Ri0CDD5ktFYyalNYlZIxDrHnFFmILweUG
         00uxcjlz9BixPV7MRD0VOPHS5sviQOvsFCW3rwNGafafukQDSp0Ms1oQgJaPjTKAyNku
         QmMOmsoi5gxHJha1k5Ojsqae2b57GFfuH8aaRTqwGCL6JGdiZhhBOVtYWOqnpUxxP51/
         N4+ogmf6NKbtnv5p47JyAgAzUiHtE3ugNGzZWOjCvMREn/3R5appA/JrFBCG+G9UzX/S
         iC3/NQvNXPqJLVSey+G1eUcIJnjW2q4uD9sWMRHug56X1WDjxLtCicJCIKXq6+ETSyMw
         ucgg==
X-Gm-Message-State: AC+VfDwgBjW0JBcpNt+5+MAKhOuMs0FFuh0EnBDr/RH5xun+Kr+q5pNE
        zYLsVd5Tz5OhnhTPaH/UcDJ37jpxCJu6UXMmGMvSMDWkysI=
X-Google-Smtp-Source: ACHHUZ4JZ3EivcEs/4+W31dFvfZRYQLbKMKcAqiPTVbFRU+UuPfL6AHx4mSpodqp32hk4fn+En6D8s496ISPgcj93eA=
X-Received: by 2002:a67:fe93:0:b0:440:c9cd:364c with SMTP id
 b19-20020a67fe93000000b00440c9cd364cmr10240052vsr.13.1687847276916; Mon, 26
 Jun 2023 23:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxj_DLm8_stRJPR7i8bp9aJ5VtjzWqHL2egCTKe3M-6KSw@mail.gmail.com>
 <raezzuhjjoddoc5tsln2bg3rkudczwou4jjfq6noeawrtn6jre@uvf4rikifzpx>
In-Reply-To: <raezzuhjjoddoc5tsln2bg3rkudczwou4jjfq6noeawrtn6jre@uvf4rikifzpx>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Jun 2023 09:27:45 +0300
Message-ID: <CAOQ4uxiFPw-Os+Beo+F8wA1Ebc_28gTQawjob-U6PcVCwte_rg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] splice: fsnotify_modify(fd) in vmsplice
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

On Tue, Jun 27, 2023 at 2:09=E2=80=AFAM Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> Same logic applies here: this can fill up the pipe and pollers that rely
> on getting IN_MODIFY notifications never wake up.
>
> Fixes: 983652c69199 ("splice: report related fsnotify events")
> Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffy=
js3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xy=
z>
> ---
>  fs/splice.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/splice.c b/fs/splice.c
> index 94fae24f9d54..a18274209dc1 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1447,6 +1447,9 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iov=
ec __user *, uiov,
>         else
>                 error =3D vmsplice_to_user(f.file, &iter, flags);
>
> +       if (error > 0)
> +               fsnotify_modify(f.file);
> +

Wow, that is a twisted syscall, it does either write or read on the pipe
depending on whether it was open for read or write.

so you need to move fsnotify_modify() into vmsplice_to_pipe() and
add fsnotify_access() to vmsplice_to_user().

Thanks,
Amir.
