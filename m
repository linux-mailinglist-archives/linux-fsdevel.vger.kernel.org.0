Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22463A6B47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbhFNQJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 12:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbhFNQJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:09:47 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32264C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jun 2021 09:07:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l1so17481277ejb.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jun 2021 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MNFWmm34MZytbVprgUqS0jda1g7ZVugrknZ1TlYtDUQ=;
        b=dXOpEReFQg7wxCEciDmPS8hg+xqA1WcwdZEuSGxmkOK9XEgFlPkXNXXZgJ/3NJsbMp
         Wg+q2rExZaTxTDSEzdg7Opcj14+Is2NjQX546+BRiVwbmsFEaiJFFNhyglTnVyRY/lwC
         4tWZs/2fMAq7L/3T1qKt6XPJdyf5GYyoxdDaHb8emgFi3yJJL/XPq2AkP65Dwt08r0rl
         W5XLzU1tjknpMp9uXty/svjU1SOX49Ijsb7QjsoVnDLeGenKbIXN2395pr43Nfy7oipD
         yjfUL9h9dbdlEIPkuZ6jcg+nS8TUv29a5xwP5l2GamHvnFvrB034UC7ajFvq5yaSeyQ4
         waLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MNFWmm34MZytbVprgUqS0jda1g7ZVugrknZ1TlYtDUQ=;
        b=H/hz5oyac1bIDwVa1ya1xZS+YE4BFIf24HKmF9hImsA3Rfovj0QwASBBebRgTJqH7U
         X0zTIQXaf2+PprTU8s6u6FC4IyL9nUDBjIevMUYYKX4PUOh/c5wvYhCoFT8NnxBmBUbp
         gGqok6Bt9PsmLh3+MxqZ6R+69Jvb2xlTKKIGSdEVQWZOjnH1BExMsglEaH9uKzOkgWr1
         qERD+TGOHh9dIZWDNTlOsxB38nlvgxXC4Zrz/BxfxwdnzTlD9divzFci7oe7Yk/LLY3v
         5alCXa1ZvJLxAg4BAKbDAMexmreclSED/s1L+AacwMS/06YtJyzBRN/WKCgGiDELSVSB
         fDKg==
X-Gm-Message-State: AOAM5324BrNeQe+yLmRh7wF0ZQikn23zYiBN5ussjiCvMt+sw04kqDkW
        kqSLnBhGzel2RfxTsEuyEA==
X-Google-Smtp-Source: ABdhPJwX3iEKNIeEi0O2uxmQbWz1orJGi2aByHnwYZUCUgIPB6464igySWPOIiWEDysOY7JTQvG9Vw==
X-Received: by 2002:a17:906:1815:: with SMTP id v21mr15849724eje.376.1623686847826;
        Mon, 14 Jun 2021 09:07:27 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.135])
        by smtp.gmail.com with ESMTPSA id e22sm9503078edu.35.2021.06.14.09.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 09:07:27 -0700 (PDT)
Date:   Mon, 14 Jun 2021 19:07:25 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     dhowells@redhat.com
Cc:     linux-afs@lists.infradead.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] afs: fix tracepoint string placement with built-in AFS
Message-ID: <YMd+vR5Z2e24b3VV@localhost.localdomain>
References: <YLAXfvZ+rObEOdc/@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YLAXfvZ+rObEOdc/@localhost.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping!

Currently "perf record -e [tracepoint]" is unusable if AFS is builtin.

On Fri, May 28, 2021 at 01:04:46AM +0300, Alexey Dobriyan wrote:
> I was adding custom tracepoint to the kernel, grabbed full F34 kernel
> .config, disabled modules and booted whole shebang as VM kernel.
> 
> Then did
> 
> 	perf record -a -e ...
> 
> It crashed:
> 
> 	general protection fault, probably for non-canonical address 0x435f5346592e4243: 0000 [#1] SMP PTI
> 	CPU: 1 PID: 842 Comm: cat Not tainted 5.12.6+ #26
> 	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
> 	RIP: 0010:t_show+0x22/0xd0
> 
> Then reproducer was narrowed to 
> 
> 	# cat /sys/kernel/tracing/printk_formats
> 
> Original F34 kernel with modules didn't crash.
> 
> So I started to disable options and after disabling AFS everything
> started working again.
> 
> The root cause is that AFS was placing char arrays content into a section
> full of _pointers_ to strings with predictable consequences.
> 
> Non canonical address 435f5346592e4243 is "CB.YFS_" which came from
> CM_NAME macro.
> 
> The fix is to create char array and pointer to it separatedly.
> 
> Steps to reproduce:
> 
> 	CONFIG_AFS=y
> 	CONFIG_TRACING=y
> 
> 	# cat /sys/kernel/tracing/printk_formats
> 
> Signed-off-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>
> ---
> 
>  fs/afs/cmservice.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/fs/afs/cmservice.c
> +++ b/fs/afs/cmservice.c
> @@ -30,8 +30,9 @@ static void SRXAFSCB_TellMeAboutYourself(struct work_struct *);
>  static int afs_deliver_yfs_cb_callback(struct afs_call *);
>  
>  #define CM_NAME(name) \
> -	char afs_SRXCB##name##_name[] __tracepoint_string =	\
> -		"CB." #name
> +	const char afs_SRXCB##name##_name[] = "CB." #name;		\
> +	static const char *_afs_SRXCB##name##_name __tracepoint_string =\
> +		afs_SRXCB##name##_name
>  
>  /*
>   * CB.CallBack operation type
