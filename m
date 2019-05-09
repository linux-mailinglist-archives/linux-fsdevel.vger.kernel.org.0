Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB34818D18
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 17:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfEIPjK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 11:39:10 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41388 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfEIPjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 11:39:10 -0400
Received: by mail-oi1-f195.google.com with SMTP id y10so2223690oia.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2019 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pRrwlxjj+nqUwQKzCVPQDW+zUXQGGWC5tBHdWs2mPtI=;
        b=gb5pAJWKRsBwdzipU8w3qhL3oH6jyQ6/SVOIpLg2g1C8IEY9O6GY8vCXM1WJHJDIW4
         WP6K8wNXsr+CBjsIfqtnAcjSH6rKs03wUQTObwjaVERsPRRKhg9wfTe0fhXkaz5EDoou
         lRwIwP9dd+KN5OoOzT9u7n4TPwuAU3JDFU4CbyFJ1uvyA3i/drmFY+Hwed25XMXUWDY4
         ofrdVFM5mTXTJPFIdMXwJqTnoXvbqH/bvIlp9oBQCk+Ll065GA27EQpcr/JKyTayZxCF
         QVbvdZ13RLA5wJGTaW9nwREVJYRNGKjl5hl3agSy7QY7St/ZlmtPSAOI2OgJ5e+Bszzn
         BqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pRrwlxjj+nqUwQKzCVPQDW+zUXQGGWC5tBHdWs2mPtI=;
        b=ogvboMaE30SS3CPhwE0C28C4V3mwrGSnBbXlSoHkAB3Q0w8dJhmstvQZx9Ru+rqVpM
         TDr5DvGl2edt6k4cZLYt5MoMV/O0wWmJ+C2ruL4g+ux0dsm00mMF8CosGKmOkVwOOjMp
         EpWNX/Sh4d4CUjw0xSTSoAZySOHZh/o4UrknfI4qiPqAadk4+Evq4BOWYOXCDhQXbxIh
         mmL6eqH/G7u8mKED+CqjVlYost/NvC9ZTsEEXNhIgJl/LFzTht8J3CzIQHMdzUfTEgsV
         N0DL8hCQDoruYkQeaciRQmU4ZV0fSUELufXgSS2vDS52P8j71aVFVWersHQvud0PjfXC
         V87A==
X-Gm-Message-State: APjAAAXhM3GsyEAVdyl4NjDd67gSHAKxVMkKi671V7Ei71DVFBTML0ky
        wtS2WMtq0rOgsaiHyOyDKjc1sg==
X-Google-Smtp-Source: APXvYqzAB/c0Nn91nrkOtM4l2ZUflo45O57TS9/QSjBdu3Wqo1fajxgoMsNWpaoeLq5rUn7ZexZanA==
X-Received: by 2002:aca:fd47:: with SMTP id b68mr1800995oii.12.1557416349306;
        Thu, 09 May 2019 08:39:09 -0700 (PDT)
Received: from brauner.io ([172.56.6.91])
        by smtp.gmail.com with ESMTPSA id e31sm996126ote.61.2019.05.09.08.39.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 09 May 2019 08:39:08 -0700 (PDT)
Date:   Thu, 9 May 2019 17:39:04 +0200
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] fsopen: use square brackets around "fscontext"
Message-ID: <20190509153902.tqkoooxtviafrla5@brauner.io>
References: <20190508152509.13336-1-christian@brauner.io>
 <20190508152509.13336-2-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190508152509.13336-2-christian@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 08, 2019 at 05:25:09PM +0200, Christian Brauner wrote:
> Make the name of the anon inode fd "[fscontext]" instead of "fscontext".
> This is minor but most core-kernel anon inode fds carry square brackets
> around their name (cf. [1]). For the sake of consistency lets do the same

This "(cf. [1])" reference was supposed to point to the list below. But
since I rewrote the paragraph it can simply be dropped.  Sorry for the
oversight.

Christian

> for the mount api:
> 
> [eventfd]
> [eventpoll]
> [fanotify]
> [fscontext]
> [io_uring]
> [pidfd]
> [signalfd]
> [timerfd]
> [userfaultfd]
> 
> Signed-off-by: Christian Brauner <christian@brauner.io>
> ---
>  fs/fsopen.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index a38fa8c616cf..83d0d2001bb2 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -92,7 +92,7 @@ static int fscontext_create_fd(struct fs_context *fc)
>  {
>  	int fd;
>  
> -	fd = anon_inode_getfd("fscontext", &fscontext_fops, fc,
> +	fd = anon_inode_getfd("[fscontext]", &fscontext_fops, fc,
>  			      O_RDWR | O_CLOEXEC);
>  	if (fd < 0)
>  		put_fs_context(fc);
> -- 
> 2.21.0
> 
