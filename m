Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156A03B1322
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 07:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhFWFSi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 01:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWFSh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 01:18:37 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D73C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 22:16:20 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id i17so1368182ilj.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 22:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RUuzLpPpNaTHGrl9wO5UOlPhFkkQSWrB9EoKffEGYJM=;
        b=OrQv5gAiuDN3EuYIxbpX5SqxUe2Gk9Kag84zT43Wn9QkW2lAgDIMXyY713cO8EF4eY
         nWDcCeFoU6gyP6F5Tvh5iKm3cytzQ+q+B87yasJ1JRXFIjl/EdJWfSD5AaGvLq2Phz23
         GgPxTe4vcGtnBAZ3cVv4Colh3QRlzCPor25qDuP+3duy+hvSmS0ubGa0MkN9offl+1G6
         fPrFnyWFD5iwKBLV/uH+D7w6mcsn0XWQUoaDlWm7X0JEk0bm4rZmEsLJbc0O1NXI5L36
         lNcPdHqVUevAAtqqo5eWhoZV9VcK1rzJDLAWM+xSXlPjsnHr5DDxgrSpdrzocka8rgAo
         GZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUuzLpPpNaTHGrl9wO5UOlPhFkkQSWrB9EoKffEGYJM=;
        b=UIlmRGB1fmwuYxmQfAoStbtOT2512Y51oFcvbCe0qt7SIA36CLTVShHk6hmXWLMa3m
         +B2idtpzzKAe7e1NoJZUgXJw2o9iZUdthDyJGF1CcPlLVcu4DU1ZUZj4+x9UZIBQcH2J
         wAP01ua8ShTM6H6eCFgJc/n8o+T+fMeWJ2MKEWluB4qtMYDK0hZbSvv3Z++m9QRyOsxr
         qXionET1haol/iDXioIoMnxzjQ99SF2q6oLQzTaSfVy8QOiXjgXJGsYT5xvUZcY4zKSB
         OK/SYNlUInTa/r74lMciL1Mnwdl6l4JPFtQXgaHIKG1JDUoaq+0uMyOABI+yX6TTk7qG
         zJ0w==
X-Gm-Message-State: AOAM532P0DNZH74pmFnvhul6noim2irUacf2yyJSFNtUwTjw3VpZ/ljf
        PdW3Cy6nuC7ENEjMqGgmHQQX+akH8VQWr5KSg0NECjw3TNk=
X-Google-Smtp-Source: ABdhPJz1q4E+HmeTIaZburxFUW7QyrSrVTB8Y7QbVw+3FUhNJRUq5bBRxV2Yj2N2HpMtbYgXjhh7Mo54JxGE0k24Urk=
X-Received: by 2002:a92:874b:: with SMTP id d11mr1525904ilm.137.1624425380165;
 Tue, 22 Jun 2021 22:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210622194300.2617430-1-kbusch@kernel.org>
In-Reply-To: <20210622194300.2617430-1-kbusch@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Jun 2021 08:16:09 +0300
Message-ID: <CAOQ4uxiCUd3SjThiX31L8JFgRAvemcMgtzfZJY1aXGwANNJ6Mg@mail.gmail.com>
Subject: Re: [PATCH] vfs: explicitly include fileattr.h dependency
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Jens Axboe :" <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 10:47 PM Keith Busch <kbusch@kernel.org> wrote:
>
> linux/fileattr.h has an implicit requirement that linux/fs.h be included
> first. Make that dependency explicit.
>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jens Axboe: <axboe@kernel.dk>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  include/linux/fileattr.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
> index 9e37e063ac69..34e153172a85 100644
> --- a/include/linux/fileattr.h
> +++ b/include/linux/fileattr.h
> @@ -3,6 +3,8 @@
>  #ifndef _LINUX_FILEATTR_H
>  #define _LINUX_FILEATTR_H
>
> +#include <linux/fs.h>
> +
>  /* Flags shared betwen flags/xflags */
>  #define FS_COMMON_FL \
>         (FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
> --

Thinking out loud:
Would it be better to split out the flag definitions to uapi/linux/fileattr.h
and include it from here and from uapi/linux/fs.h?

Will that cause UAPI pain??

Thanks,
Amir.
