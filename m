Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204671AC0CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 14:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635115AbgDPMMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 08:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634744AbgDPMM0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:12:26 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9412C061A0C;
        Thu, 16 Apr 2020 05:12:25 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id j188so1094170vkc.2;
        Thu, 16 Apr 2020 05:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=9UKw5GscgAiWbaFyaogHtun3HlxTWK7ujAK5b+6nb5A=;
        b=KvhE0wh/BoWkZh/vbqAjnW46zESXkHi/3xStk1gicdsOZzCnefVz8OsNJMk8w0z6Da
         qR5CEINXZFImdzJsOQvtD+ghoTjAnV4pKKBK3Plop/g1LXZQ5hEdhv2jhLp1X6D8xzZF
         L6jFZTJwbitic2MOhhmdo9V0IsbK0CtRIEgWxTgBD6JU00QsjBNYQYvT0pOGnLGHU7tV
         kh/a57j3R3EsoTQ5MBRvq+B5T4I7ogO/5a0oMlbe3AUGTMRgxlgeDQy4EzJtGz8Tn6ss
         VPOs1jQxvywk+jGuEhpVpssloOAVgKpbd9VcxRrX4OAbc/zhs1r7yiSn9d8w3B62HKUA
         ukhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=9UKw5GscgAiWbaFyaogHtun3HlxTWK7ujAK5b+6nb5A=;
        b=hpqJ03CMyBkCTAIWPeddSOgUCIiUBthWVIUw3mcZMo1g6paWEf8gc3RFvXvwkgteFa
         8Q+4xDHhk2tSna5wj1E+t/hRU9cg9NQv7GsqP74wQvjsQTEWPBTZUfxvCyT1h/8HJpf1
         Hmve4eveJCZkGQPxu2F7CaMislUUbO48iWLlCgFjhmD41LuWCWMOy1yt6xdKccTI/Xep
         gKhXoxn9LNFgXSJ4yHOTI5WL5dmA6MsX6x8hVngSWwMkSKvBn+qbqXMYUkqLwmGnJU0W
         aHQI11Lm3VjrAt1MuhFed8iaL6DhvkpaLX4eDn1jTgbJQfgrhkZlrri5BFcD4g9Eku9b
         u1oQ==
X-Gm-Message-State: AGi0PuahkW5WZ9v51p9XzXeRcKrxIANLHWaf0afHrOm8gX4NPdeeuiCN
        LFZ1lEPfv247QOkSQoD1YZTEk46HbbZw8w/3gzk=
X-Google-Smtp-Source: APiQypLKYcjiCYYIWyYO+Q8kAD5gNoQVCoXjVji7/jQ4NJU12A4C7JaqcgJuczlrhIpwsXEdO5A/dNI9zXWNnfPyU5Q=
X-Received: by 2002:ac5:c4d0:: with SMTP id a16mr22844151vkl.46.1587039144696;
 Thu, 16 Apr 2020 05:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <1564542193-89171-1-git-send-email-yi.zhang@huawei.com>
In-Reply-To: <1564542193-89171-1-git-send-email-yi.zhang@huawei.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 16 Apr 2020 14:12:12 +0200
Message-ID: <CAKgNAkivz=qXpLTPt5qbGHn0_zH-ReQ76LKhnoRd5zZuudu1NQ@mail.gmail.com>
Subject: Re: [PATCH] io_getevents.2: Add EINVAL for case of timeout parameter
 out of range
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-man <linux-man@vger.kernel.org>, linux-aio@kvack.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        bcrl@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Moyer <jmoyer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        deepa.kernel@gmail.com, wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Zhangyi,

On Wed, 31 Jul 2019 at 04:57, zhangyi (F) <yi.zhang@huawei.com> wrote:
>
> io_[p]getevents syscall should return -EINVAL if timeout is out of
> range, update description of this error return value.
>
> Link: https://lore.kernel.org/lkml/1564451504-27906-1-git-send-email-yi.zhang@huawei.com/


It appears that the kernel patch to implement this check was never
merged. Do you know what happened to it?

Thanks,

Michael

> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
>  man2/io_getevents.2 | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/man2/io_getevents.2 b/man2/io_getevents.2
> index 0eb4b385e..5560bb8ee 100644
> --- a/man2/io_getevents.2
> +++ b/man2/io_getevents.2
> @@ -73,8 +73,9 @@ Interrupted by a signal handler; see
>  .TP
>  .B EINVAL
>  \fIctx_id\fP is invalid.
> -\fImin_nr\fP is out of range or \fInr\fP is
> -out of range.
> +\fImin_nr\fP is out of range or \fInr\fP is out of range, or
> +\fItimeout\fP is out of range (\fItv_sec\fP was less than zero, or
> +\fItv_nsec\fP was not less than 1,000,000,000).
>  .TP
>  .B ENOSYS
>  .BR io_getevents ()
> --
> 2.20.1
>


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
