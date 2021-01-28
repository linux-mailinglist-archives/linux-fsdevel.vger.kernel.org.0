Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C47E30719D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 09:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhA1IeC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 03:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhA1Idi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:33:38 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A156C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 00:32:58 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id w187so2595020vsw.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 00:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RYzJJ+GDoVT+oxwms9uCAe+M5WMBmADotrwHjh34zKA=;
        b=KVbix2aDBGlz8oq/L1j44y4bFJvMxmMkjnjAj4TOJmVVIFxxmWLM2EVez23JnHzOL4
         AvLJgvU6QlQphxeeO5piGo3ZD0GY7yD9kwmDr8N7IDe75eOiJelG6xfrSinMS4EqmZWl
         /8Lx0h4xwa3yEOWKt4Dsmf8MFI+AtODjuAGlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RYzJJ+GDoVT+oxwms9uCAe+M5WMBmADotrwHjh34zKA=;
        b=c6KJFUGsxhnwIyWplRLXeNRbfTetS+1gonb5kqF/LKOnv1SkHrTKdHXVzENlfNqo1K
         Kgo3oGDCd6Kx8wLzZ6CD3WV4889x2hLIH724C5rdBhAhlVkT171BGEeFOCZ6ZY8KurJE
         HqXx50WlTjU8D6jcOzJQ+dew2TmtMdfGhBXkMjVZ+1EelT6vIlbCPH8eGmC+6EyM8YII
         F+ALi9k9IMN97DC3eTY1S5P5mIk/VsmGz7cwOAcMGayICA9D2c+ddSyQ+5hQTr8ygll8
         2ogM9YVkbDQRWGUBliajqnHXoqS40kVZH4xZPadcbOZRqyfdgcQwUxttw0oYzrfQfaS8
         APxg==
X-Gm-Message-State: AOAM531tcn08yEn0hLy+kynq6TrOxQOSeoX1ikbQneZGCvr/RX0rxgMk
        taAMyqtf33C5V9abxndupxMp82+zmAgACMX4Jzo30Q==
X-Google-Smtp-Source: ABdhPJynZ/gSFd6TRD0z5IRxsB8lpPJ+iK3ni4FWpPdpVggGM9VvATV6wqo8FB8tBKwZ3Hl6uM1rQQhtnOj8tjZF56w=
X-Received: by 2002:a67:ea05:: with SMTP id g5mr10799454vso.47.1611822777582;
 Thu, 28 Jan 2021 00:32:57 -0800 (PST)
MIME-Version: 1.0
References: <1611800401-9790-1-git-send-email-bingjingc@synology.com>
In-Reply-To: <1611800401-9790-1-git-send-email-bingjingc@synology.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 28 Jan 2021 09:32:47 +0100
Message-ID: <CAJfpegtDbDzSCgv-D66-5dAA=pDxMGN_aMTVcNPzWNibt2smLw@mail.gmail.com>
Subject: Re: [PATCH 3/3] parser: add unsigned int parser
To:     bingjingc <bingjingc@synology.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cccheng@synology.com, robbieko@synology.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 3:21 AM bingjingc <bingjingc@synology.com> wrote:
>
> From: BingJing Chang <bingjingc@synology.com>
>
> Will be used by fs parsing options
>
> Reviewed-by: Robbie Ko<robbieko@synology.com>
> Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
> Signed-off-by: BingJing Chang <bingjingc@synology.com>
> ---
>  fs/isofs/inode.c       | 16 ++--------------
>  fs/udf/super.c         | 16 ++--------------
>  include/linux/parser.h |  1 +
>  lib/parser.c           | 22 ++++++++++++++++++++++
>  4 files changed, 27 insertions(+), 28 deletions(-)
>
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index 342ac19..21edc42 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -335,18 +335,6 @@ static const match_table_t tokens = {
>         {Opt_err, NULL}
>  };
>
> -static int isofs_match_uint(substring_t *s, unsigned int *res)
> -{
> -       int err = -ENOMEM;
> -       char *buf = match_strdup(s);
> -
> -       if (buf) {
> -               err = kstrtouint(buf, 10, res);
> -               kfree(buf);
> -       }
> -       return err;
> -}

I don't see how adding this function and removing it in the same
series makes any sense.

Why not make this the first patch in the series, simplifying everything?

And while at it the referenced fuse implementation can also be
converted (as a separate patch).

Thanks,
Miklos
