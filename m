Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AD92243E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 21:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgGQTKa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 15:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbgGQTK0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:10:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC886C0619D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 12:10:25 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so12114645wrj.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 12:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/3tZLNgSUaBUOYFtarysCRR7+220ug8Q6HlgI7Nzn9o=;
        b=cCAmvlsUDJwZwJmRNK+H8fKklO9LVaNEl+TESiR0wM/9WOl4gqHrJeLLeokHptEi2Z
         mfVfnI/DQ8lbV43KW3fF7PXHYTWvLqhPUhdCtFftcUTV+1kYZkNMZ9L6n2F4V2hhM24M
         ygVUtqyThgYUVvXc2UchbsmG8Ns2cFz4iS3+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/3tZLNgSUaBUOYFtarysCRR7+220ug8Q6HlgI7Nzn9o=;
        b=abe7zMLd0z3e1mwuHQcIbHgjDFEXytXBYYw7nIdAUWQi0xNtyrBqNbLRWn+m9JuYpG
         /lle6YfRHv5DJut04deMK6GKBS7q5gP4AujYZi21ShZXbiilwC8p39LqtaCONG5EgvO9
         TNL4lkX28wm0n8+gG80fyF9ndyA6lWtrFWc7YKPLONP6SoriAQ9BZdgvBedC2WoHkC3c
         SSirUrj8pdMweKSE/HO5cNG/FzE484Bj4QPIFo4RVURJ4ZIDzvyWFQhXoYzD37xGBYcu
         hDh7uwYoonCC+t/oXzE/+u2xMZ9VuCc40NsXkWqumnltw2bj2YwS3PM1+6FUrMKHpm98
         CcTg==
X-Gm-Message-State: AOAM532LrANUPl6e6BjamMuN4bXcPjjkSbNsqp0DcLI+N69Q5jjgXZsD
        0ZDzmD6yx1BET1WzQ3X7GXDvcCI2iXuygQ==
X-Google-Smtp-Source: ABdhPJyTAxDc4h0eRMxzqWDfGCUf8nSKoi7XGTE2dPrI2YcN6sHaJsCTxBwiuKYEbrxnK+MdFSrF2g==
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr11463924wrw.111.1595013024363;
        Fri, 17 Jul 2020 12:10:24 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c15sm15320664wme.23.2020.07.17.12.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 12:10:23 -0700 (PDT)
Subject: Re: [PATCH 03/13] fs/kernel_read_file: Remove FIRMWARE_EFI_EMBEDDED
 enum
To:     Kees Cook <keescook@chromium.org>
Cc:     stable@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-4-keescook@chromium.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <8ee5f0f1-8eae-510a-a3bb-7420a3fca001@broadcom.com>
Date:   Fri, 17 Jul 2020 12:10:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717174309.1164575-4-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020-07-17 10:42 a.m., Kees Cook wrote:
> The "FIRMWARE_EFI_EMBEDDED" enum is a "where", not a "what". It
> should not be distinguished separately from just "FIRMWARE", as this
> confuses the LSMs about what is being loaded. Additionally, there was
> no actual validation of the firmware contents happening.
>
> Fixes: e4c2c0ff00ec ("firmware: Add new platform fallback mechanism and firmware_request_platform()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
> To aid in backporting, this change is made before moving
> kernel_read_file() to separate header/source files.
> ---
>   drivers/base/firmware_loader/fallback_platform.c | 2 +-
>   include/linux/fs.h                               | 3 +--
>   2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
> index 685edb7dd05a..6958ab1a8059 100644
> --- a/drivers/base/firmware_loader/fallback_platform.c
> +++ b/drivers/base/firmware_loader/fallback_platform.c
> @@ -17,7 +17,7 @@ int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
>   	if (!(opt_flags & FW_OPT_FALLBACK_PLATFORM))
>   		return -ENOENT;
>   
> -	rc = security_kernel_load_data(LOADING_FIRMWARE_EFI_EMBEDDED);
> +	rc = security_kernel_load_data(LOADING_FIRMWARE);
>   	if (rc)
>   		return rc;
>   
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 95fc775ed937..f50a35d54a61 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2993,11 +2993,10 @@ static inline void i_readcount_inc(struct inode *inode)
>   #endif
>   extern int do_pipe_flags(int *, int);
>   
> -/* This is a list of *what* is being read, not *how*. */
> +/* This is a list of *what* is being read, not *how* nor *where*. */
>   #define __kernel_read_file_id(id) \
>   	id(UNKNOWN, unknown)		\
>   	id(FIRMWARE, firmware)		\
> -	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
>   	id(MODULE, kernel-module)		\
>   	id(KEXEC_IMAGE, kexec-image)		\
>   	id(KEXEC_INITRAMFS, kexec-initramfs)	\

