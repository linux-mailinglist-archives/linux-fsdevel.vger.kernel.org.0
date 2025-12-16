Return-Path: <linux-fsdevel+bounces-71452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B89A4CC17FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 09:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0131330480B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 08:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421EE34D3AA;
	Tue, 16 Dec 2025 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HrHFjfx8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RKRw3307";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1iKonsRc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XuuYJdpK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CBA34D394
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872948; cv=none; b=QGUovHib70f+gYBhiPaZK786AkVMPscPH9+K6Csexi3zpThmkx6ai4SdFtIkFo8Sns3gENVfrsc27YDD96k7XHN9Q9PF5RE1IdC5SbEcyxUM4tdt2L7nFYKF6I3ybnUU71Jc4w4aPndjg1zGWsEfG80lJR/DlQn0OddU1J31jz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872948; c=relaxed/simple;
	bh=aCNdM5OmfdOsvgxyF5ci+06ftbcERdjgXnBbIfQ7NL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJm0vBTo6HeBSOS+b7bv8bdrsL/9yWmQ/bLoiba8ptJRdN9Pih7XFFXui7Hn5eV81r1UG/8KR0mDntxANN0zFX3W9GPQRarp5soA+0fvxZ7BoycEkrMuUEMzXOPQmAg41yzppx3HjJYr3xBJDmJAOfukHxPyPlc8rnCIGT7ikps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HrHFjfx8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RKRw3307; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1iKonsRc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XuuYJdpK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5800A33691;
	Tue, 16 Dec 2025 08:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765872937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OQwyudFiYLw9a9VovEqJ9I783SOffROchg5HSdsCFE0=;
	b=HrHFjfx8R1cIB/gvYTU71BiMzUSEivJxQphHzywX9PvYjtoUT/fYTd6xp4o8FVTuPX1fAM
	r24fcXDqEPGqAxcSYzncotwxUJ0W9WxWm0QNGhosw+Y669zqrLKW035WRniW1OezGeqmpq
	7snkfO8WjvVwXnNr0Aac8+NFG9uL8q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765872937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OQwyudFiYLw9a9VovEqJ9I783SOffROchg5HSdsCFE0=;
	b=RKRw3307JYGZ/apkRWJ1/6aTsLexDKWXeKGWtqOy72hpBGNxygy4g++7nViT+BGnFUG4UZ
	UaC6Nm5ScNswIwBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1iKonsRc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XuuYJdpK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765872936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OQwyudFiYLw9a9VovEqJ9I783SOffROchg5HSdsCFE0=;
	b=1iKonsRczx3XtDGyhOr9vyl8IgQmMqkt0To8Kwj6C9eNZFybb/Beqz/ohTGZZ7x8c5HnNi
	A1DQfbAVXASkQXXygy9QxNuyS+XlkZ0bt1r4AZ40VFuQT04toZ71XpYODfnJRaBAAnTYIK
	jDnsk/maBWoyQD/Jz4Y3LNOQ50ja+3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765872936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OQwyudFiYLw9a9VovEqJ9I783SOffROchg5HSdsCFE0=;
	b=XuuYJdpKR7p7r3c1LDxO0ui4AzXL6Hze4yx4Ijzja9G/Tnhma1yy34PwbWR6hJdk4Td/ww
	Gg6aaHVwBrfn5vAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BB093EA63;
	Tue, 16 Dec 2025 08:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BaqCEigVQWl3dgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Dec 2025 08:15:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E54E2A09E1; Tue, 16 Dec 2025 09:15:35 +0100 (CET)
Date: Tue, 16 Dec 2025 09:15:35 +0100
From: Jan Kara <jack@suse.cz>
To: Joel Granados <joel.granados@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hams@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] sysctl: Remove unused ctl_table forward declarations
Message-ID: <gkuyseuq2v4y2dl5niufwx2egwrk5a6nhrn7k5vspaorfz5jny@q5mz763kegl5>
References: <20251215-jag-sysctl_fw_decl-v1-1-2a9af78448f8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215-jag-sysctl_fw_decl-v1-1-2a9af78448f8@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 5800A33691
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Mon 15-12-25 16:25:19, Joel Granados wrote:
> Remove superfluous forward declarations of ctl_table from header files
> where they are no longer needed. These declarations were left behind
> after sysctl code refactoring and cleanup.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Apologies for such a big To: list. My idea is for this to go into
> mainline through sysctl; get back to me if you prefer otherwise. On the
> off chance that this has a V2, let me know if you want to be removed
> from the To and I'll make that happen
> ---
>  include/linux/fs.h      | 1 -
>  include/linux/hugetlb.h | 2 --
>  include/linux/printk.h  | 1 -
>  include/net/ax25.h      | 2 --
>  4 files changed, 6 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 04ceeca12a0d5caadb68643bf68b7a78e17c08d4..77f6302fdced1ef7e61ec1b35bed77c77b294124 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3487,7 +3487,6 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
>  ssize_t simple_attr_write_signed(struct file *file, const char __user *buf,
>  				 size_t len, loff_t *ppos);
>  
> -struct ctl_table;
>  int __init list_bdev_fs_names(char *buf, size_t size);
>  
>  #define __FMODE_EXEC		((__force int) FMODE_EXEC)
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 019a1c5281e4e6e04a9207dff7f7aa58c9669a80..18d1c4ecc4f948b179679b8fcc7870f3d466a4d9 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -16,8 +16,6 @@
>  #include <linux/userfaultfd_k.h>
>  #include <linux/nodemask.h>
>  
> -struct ctl_table;
> -struct user_struct;
>  struct mmu_gather;
>  struct node;
>  
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 45c663124c9bd3b294031d839f1253f410313faa..63d516c873b4c412eead6ee4eb9f90a5c28f630c 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -78,7 +78,6 @@ extern void console_verbose(void);
>  /* strlen("ratelimit") + 1 */
>  #define DEVKMSG_STR_MAX_SIZE 10
>  extern char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE];
> -struct ctl_table;
>  
>  extern int suppress_printk;
>  
> diff --git a/include/net/ax25.h b/include/net/ax25.h
> index a7bba42dde153a2aeaf010a7ef8b48d39d15a835..beec9712e9c71d4be90acb6fc7113022527bc1ab 100644
> --- a/include/net/ax25.h
> +++ b/include/net/ax25.h
> @@ -215,8 +215,6 @@ typedef struct {
>  	unsigned short		slave_timeout;		/* when? */
>  } ax25_dama_info;
>  
> -struct ctl_table;
> -
>  typedef struct ax25_dev {
>  	struct list_head	list;
>  
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251215-jag-sysctl_fw_decl-58c718715c8c
> 
> Best regards,
> -- 
> Joel Granados <joel.granados@kernel.org>
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

