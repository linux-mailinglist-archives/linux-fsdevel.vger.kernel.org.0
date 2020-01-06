Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1854013148D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 16:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgAFPPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 10:15:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34574 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgAFPPU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:15:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so50006481wrr.1;
        Mon, 06 Jan 2020 07:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zTQSaUx9fY9N5fiG62F+7SM0UDzGL6HAVdcpx53+n90=;
        b=cWvJ0hUJN/7su+kb3ylfeBXNSVRKFL/Ht5gOkGAE6PXYxHmSNi0Tux3zKIPXxb0A//
         8W8kKdL3/Am33w5EX/YnhVV9WI4nDpzd6/i01V2323cciQgjlyqCRXEAffJV5t03GIPO
         CYpLD/zp+ndGI32uFUbtvlyJkswTd2218CXcmQ9zUAoJKbUiRzfKkg2W2dSpTgIgBwGs
         t3wpmk7dFDIv3c42swffAWKB4//RmnyRMDdooB/zfYedKmP5R+VLN/8FbIcyH88Z++VU
         T8B/yPTlLqtnhoP2artOpVm/VDcQLJSx98qR7TZFnYMfEJy8hv7+NGaGPKnmUqQ6cn0G
         Z5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zTQSaUx9fY9N5fiG62F+7SM0UDzGL6HAVdcpx53+n90=;
        b=Jxi1+JY+ijLoyv61D9ijlH3rxEiPlpVw+AtRnT1hoUF5Xr4VHMM6vNrkc6jrlgFc0m
         TU4uSOShcO99W+1QysdT4+Ri/jPLzfvpXlSLtjAD0kSIPS7aghFlB8mwpsNS5FJfuWJ+
         /WKxhiVNksq2okD/VeSX/phZouLKBtN1GfvC/XQEydWu67w6KHPBx7Sn/X3unLHeVweq
         QIMJBhZ5rw1YzBY718OCD+51PcVdMZUOfN+cv+baBvwmgiicneo8mJmbbaXLU1HsauAw
         SXf8MvfcTlPOn9386RyNL7951RJ/Sjaq3iQ65cKpiaes6in88Fu0ZEQj4zXJjVspbOx+
         gtGQ==
X-Gm-Message-State: APjAAAUAqf3Rxi2JCXOZiIkY77MrzkmCAUClYFv/3eHXKAmJd6Nq2zWZ
        6thm18pW6a6EPjSIuXBlpQ==
X-Google-Smtp-Source: APXvYqyNeCBfGcSY8tzYao6Gf9lT0qkr1r3n6MMW2yaYqWla2aP861L3uIRX5g58cqiOezdEr2W3OQ==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr103340897wrq.176.1578323718007;
        Mon, 06 Jan 2020 07:15:18 -0800 (PST)
Received: from avx2 ([46.53.249.49])
        by smtp.gmail.com with ESMTPSA id v3sm73919574wru.32.2020.01.06.07.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 07:15:17 -0800 (PST)
Date:   Mon, 6 Jan 2020 18:15:14 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v6 00/10] proc: modernize proc to support multiple
 private instances
Message-ID: <20200106151514.GA382@avx2>
References: <20191225125151.1950142-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191225125151.1950142-1-gladkov.alexey@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  	hidepid=	Set /proc/<pid>/ access mode.
>  	gid=		Set the group authorized to learn processes information.
> +	pidonly=	Show only task related subset of procfs.

I'd rather have

	mount -t proc -o set=pid

so that is can be naturally extended to 

	mount -t proc -o set=pid,sysctl,misc

> +static int proc_dir_open(struct inode *inode, struct file *file)
> +{
> +	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
> +
> +	if (proc_fs_pidonly(fs_info) == PROC_PIDONLY_ON)
> +		return -ENOENT;
> +
> +	return 0;
> +}
> +
>  /*
>   * These are the generic /proc directory operations. They
>   * use the in-memory "struct proc_dir_entry" tree to parse
> @@ -338,6 +357,7 @@ static const struct file_operations proc_dir_operations = {
>  	.llseek			= generic_file_llseek,
>  	.read			= generic_read_dir,
>  	.iterate_shared		= proc_readdir,
> +	.open			= proc_dir_open,

This should not be necessary: if lookup and readdir filters work
then ->open can't happen.

>  static int proc_reg_open(struct inode *inode, struct file *file)
>  {
> +	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
>  	struct proc_dir_entry *pde = PDE(inode);
>  	int rv = 0;
>  	typeof_member(struct file_operations, open) open;
>  	typeof_member(struct file_operations, release) release;
>  	struct pde_opener *pdeo;
>  
> +	if (proc_fs_pidonly(fs_info) == PROC_PIDONLY_ON)
> +		return -ENOENT;

Ditto. Can't open what can't be looked up.

> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> +/* definitions for hide_pid field */
> +enum {
> +	HIDEPID_OFF	  = 0,
> +	HIDEPID_NO_ACCESS = 1,
> +	HIDEPID_INVISIBLE = 2,
> +	HIDEPID_NOT_PTRACABLE = 3, /* Limit pids to only ptracable pids */
> +};

These should live in uapi/ as they _are_ user interface to mount().
