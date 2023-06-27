Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09877402FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 20:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjF0SMz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 14:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjF0SMA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:12:00 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB292D57;
        Tue, 27 Jun 2023 11:11:48 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-443628ee79dso914430137.1;
        Tue, 27 Jun 2023 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687889507; x=1690481507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQrySK1ZT+LbbRMNZlZ2lWn/isV1vrbKMhcsTS1OQBo=;
        b=ccscMLZMEwPohsP0JL0F0FqIN8zX0+vDczPhemjc6yR/jzlE4nT8d6b6k92Vguqt4d
         NESTNiXaU1ZEduS+rja8/5KnMT02uHBmx+PiS19hu+O10kphzNynKJF/GO6rbGL6PcTD
         XlyoSgihlwPqX0TIDgifW7fG9zonE2kjltpP+tXy56upzsOijWOnx8wDjXFsnqQ5nFs1
         cGZ2Nj0iSu5AoXQk6zb77Dt89hpFM+vNyzErzp5VFJg91zRDBa4m6eQ16lc9+VDc3NtQ
         4HHjBg/L4qk6e7X047uUZt34MrJ1hWCg+XcHlqRGX5WZuBE4vIL1kgvt6YLh8/CC7C7I
         /8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889507; x=1690481507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQrySK1ZT+LbbRMNZlZ2lWn/isV1vrbKMhcsTS1OQBo=;
        b=Bki/LSu4lHJSQTAGPK1cPx3tn3eCSqn5QlbwFB99eRZi3lzmCUvl5fAIfiL63Bk6HZ
         sOtDWa7z7tOYU2JijQy8mm9RBGNk2rfJsp+eHS74LHdtyfGYkRSWHnUGWQBtS5z2Sp/3
         jHNswGe0lti2WRcJKwWctha+Y5Egp9jamFF0B2Ha9yony7HpzOgybz7tnfKSp/YZP001
         tnKegXtw4PaQfsOuRcO8bWqFpcwZz30ApXNhwn57c8AamBwkRQRk+JdvNTxPlYAX+jBl
         3gfwhMX8rsGv7V+c0DA6XhAvi8/USmYRPx/lZ3TDiDNFKLihZgiCvkMzy5ONXdVOZgjR
         aXIQ==
X-Gm-Message-State: AC+VfDwXmEWccLDzS13Mts2sQQbtCGAGM85wXfRcFvw4iOmL5sAeqUp+
        d8NyEDiJ4LFd+PDiRtb34sIWVYvU2y40jWt7IGs=
X-Google-Smtp-Source: ACHHUZ7g3WdXBL8i2HWww82h1ZkvwZgKVpE6YLuuxJPjlHuKztlRK9wvZ2F43bYjSZNa0fHvzlm7DkhK1z5BSRbDhaY=
X-Received: by 2002:a05:6102:1cf:b0:43d:c0d5:ed27 with SMTP id
 s15-20020a05610201cf00b0043dc0d5ed27mr15223175vsq.32.1687889506864; Tue, 27
 Jun 2023 11:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxh7i_s4R9pFJPENALdWGG5-dDhqPLEUXuJqSoHraktFiA@mail.gmail.com>
 <cover.1687884029.git.nabijaczleweli@nabijaczleweli.xyz> <4206d7388fdbee87053c9655919096225a461423.1687884031.git.nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <4206d7388fdbee87053c9655919096225a461423.1687884031.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Jun 2023 21:11:35 +0300
Message-ID: <CAOQ4uxj5hvSKUURaspF3hDPA99y_+0GAv0OWsVPPhhKKtcJe8w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] splice: fsnotify_access(fd)/fsnotify_modify(fd) in vmsplice
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
> Same logic applies here: this can fill up the pipe and pollers that rely
> on getting IN_MODIFY notifications never wake up.
>
> Fixes: 983652c69199 ("splice: report related fsnotify events")
> Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffy=
js3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
> Link: https://bugs.debian.org/1039488
> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xy=
z>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/splice.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/splice.c b/fs/splice.c
> index e16f4f032d2f..0eb36e93c030 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1346,6 +1346,9 @@ static long vmsplice_to_user(struct file *file, str=
uct iov_iter *iter,
>                 pipe_unlock(pipe);
>         }
>
> +       if (ret > 0)
> +               fsnotify_access(file);
> +
>         return ret;
>  }
>
> @@ -1375,8 +1378,10 @@ static long vmsplice_to_pipe(struct file *file, st=
ruct iov_iter *iter,
>         if (!ret)
>                 ret =3D iter_to_pipe(iter, pipe, buf_flag);
>         pipe_unlock(pipe);
> -       if (ret > 0)
> +       if (ret > 0) {
>                 wakeup_pipe_readers(pipe);
> +               fsnotify_modify(file);
> +       }
>         return ret;
>  }
>
> --
> 2.39.2
>
