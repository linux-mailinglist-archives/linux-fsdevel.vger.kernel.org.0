Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC9E339F35
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 17:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhCMQsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 11:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbhCMQsL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 11:48:11 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08654C061574;
        Sat, 13 Mar 2021 08:48:11 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g25so5561946wmh.0;
        Sat, 13 Mar 2021 08:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=UfOMLxmUyQcwgS34AoT07P9W4cs3zKs94K9jdksHQTw=;
        b=uszpdiaYi6bnoTCkRKtmAwO5PgWMdz99WxeoGFSw9EXUWw8EVbYM7sbmdSYSOICxdU
         MbCbxpX6dRprtAuyQvSVCzEBvn3/EfCXOzLAW9ylozoNWOqFO0TU85+q1ACW3mb1ALwf
         gr+P9oi8sRM0W+c/VUIlz7o+RnB3/KsqI95w+sEY/5b98XGK7itYSnAWg6ydrmZMGCsf
         wWim2NhIzCWB8ZSTJK5ZFLW02ombuCG3Hcn1DGP3BWwIkXRfwSLDzazKgLtZUZhtN+GE
         Wd4AbAHjOmZvQMUBzFst7uUFEyExR4MsUb2a5VMvSyX5rNgE5FTof8UNPgvf4jcYuukN
         aJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UfOMLxmUyQcwgS34AoT07P9W4cs3zKs94K9jdksHQTw=;
        b=fQbntSCQp/07tDRl9/xQtXziqBrIZRcbfm1b/85xxQGIJhmfL6MG3XvQAlrnDbMqRP
         edfuVcbfgoHdtECg2j1jBrBgoDFgmEmOhmyNnUhfW73SErxA7KQ98/lheLZ+vTXrHGAo
         ROVNoGSxcPJt4VNAhYHwxegu49lL+04/QAPJmDPoD80BXy/zd/SQtgPIt9JqA5GuMJ5o
         IOcLbhprxDXmmpsWcZokZjr0Txjsx6rppFEVfQLRy9cjOKwqf827bcHdKwyH7IzgGVPr
         AXyg9OOsfWFA5DZ6iDif8UOzKF5ZmlwEDIQ/EcPNMssDmNk2QYCEfFvTn/sdw6JX/00h
         tc1Q==
X-Gm-Message-State: AOAM5339rGHGO2bL2syswH33qFnoLbbqXEjLXBrE1qiUspiuVhsfNoT4
        0ovoNmu6YSchgaIyEHbB4acd9Zq1Ji+PCw==
X-Google-Smtp-Source: ABdhPJyJHRLN8g6rF3pmyIiSaCigFiYyuMRxogHK4Q21jtySmzNaYa3hJDnWVUNW0Z5VmG1lRbpvVA==
X-Received: by 2002:a1c:e041:: with SMTP id x62mr18135106wmg.95.1615654089641;
        Sat, 13 Mar 2021 08:48:09 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id b17sm12876591wrt.17.2021.03.13.08.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Mar 2021 08:48:09 -0800 (PST)
To:     Willem de Bruijn <willemb@google.com>
Cc:     linux-man <linux-man@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Subject: epoll_wait.2: epoll_pwait2(2) prototype
Message-ID: <eb42faba-2235-4536-df49-795ef2719552@gmail.com>
Date:   Sat, 13 Mar 2021 17:48:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Willem,

I checked that the prototype of the kernel epoll_pwait2() syscall is 
different from the one we recently merged; it has one more parameter 
'size_t sigsetsize':

$ grep_syscall epoll_pwait2
fs/eventpoll.c:2272:
SYSCALL_DEFINE6(epoll_pwait2, int, epfd, struct epoll_event __user *, 
events,
		int, maxevents, const struct __kernel_timespec __user *, timeout,
		const sigset_t __user *, sigmask, size_t, sigsetsize)
fs/eventpoll.c:2326:
COMPAT_SYSCALL_DEFINE6(epoll_pwait2, int, epfd,
		       struct epoll_event __user *, events,
		       int, maxevents,
		       const struct __kernel_timespec __user *, timeout,
		       const compat_sigset_t __user *, sigmask,
		       compat_size_t, sigsetsize)
include/linux/compat.h:540:
asmlinkage long compat_sys_epoll_pwait2(int epfd,
			struct epoll_event __user *events,
			int maxevents,
			const struct __kernel_timespec __user *timeout,
			const compat_sigset_t __user *sigmask,
			compat_size_t sigsetsize);
include/linux/syscalls.h:389:
asmlinkage long sys_epoll_pwait2(int epfd, struct epoll_event __user 
*events,
				 int maxevents,
				 const struct __kernel_timespec __user *timeout,
				 const sigset_t __user *sigmask,
				 size_t sigsetsize);

I'm could fix the prototype, but maybe there are more changes needed for 
the manual page.

Would you mind fixing it?

Thanks,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
