Return-Path: <linux-fsdevel+bounces-78501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDE1M4NXoGkNigQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:24:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE521A7748
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91ABF30FB136
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E743AE6E9;
	Thu, 26 Feb 2026 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZtP1RCuR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QYRaxa/n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZtP1RCuR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QYRaxa/n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251D3A1CE9
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115145; cv=none; b=PwWj94KiUneCiR1vPKdY7kUp5DFpbUuf3phFsuqwQ4a7HuRU8IMpwFhs+ZlC96wh5fdP5a6xZ5695h/1wonl3q02lW049eeHNWOggcBV4lX4P5Hz8qEW6ay0Fy4ycIQXqgC4jbBeU3gc6S+QfCtSBZxCTK7javRS/+MG6l68eOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115145; c=relaxed/simple;
	bh=pRfFaoGT95EAsuc4WXtdXqvF8QhYNGoRZHP6PwWoLLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgUmM4199UYKKrZmsYGJ8/yaHbSnbdIfXo+zwywsR44qRLBXuRGKKKh9NXX65TzSg/zMlnDxU9cKndwmB03NcXbGqTMMrwHGAg7dU4vN9elnH1BInak9Fg9q45vQKwchf62l00veljH7x4ykCLFGtC/dAKI70m6/m/xYMgJAGZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZtP1RCuR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QYRaxa/n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZtP1RCuR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QYRaxa/n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 206954D354;
	Thu, 26 Feb 2026 14:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772115141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ftiUnHXjqLIFYFzmI/lZ0QKea8z368J3BkEPmetYTQo=;
	b=ZtP1RCuRCVtYXETTqw4kXO6jXhvriK+a2s5Af4R/aX+aHbpbM+/ai5RzK6CFQcC+c4pTin
	qHEpmRWeQcBHXu6mQKIq8X1cOHQH8HMdqC8ZtyZTeYAwDzAObrC0l65ExqGhLK7pOPOjx8
	ja7ls5XhHw/IqPOMTjxqb2P2GCf+ffU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772115141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ftiUnHXjqLIFYFzmI/lZ0QKea8z368J3BkEPmetYTQo=;
	b=QYRaxa/nEUW57IJlTTMpN1HWCX2j7qf8qtQ5UUlqtmZhgyyRueyIN0bV6J1hH8tGdHvDSU
	d+Qx49X3SRsyvBDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZtP1RCuR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="QYRaxa/n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772115141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ftiUnHXjqLIFYFzmI/lZ0QKea8z368J3BkEPmetYTQo=;
	b=ZtP1RCuRCVtYXETTqw4kXO6jXhvriK+a2s5Af4R/aX+aHbpbM+/ai5RzK6CFQcC+c4pTin
	qHEpmRWeQcBHXu6mQKIq8X1cOHQH8HMdqC8ZtyZTeYAwDzAObrC0l65ExqGhLK7pOPOjx8
	ja7ls5XhHw/IqPOMTjxqb2P2GCf+ffU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772115141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ftiUnHXjqLIFYFzmI/lZ0QKea8z368J3BkEPmetYTQo=;
	b=QYRaxa/nEUW57IJlTTMpN1HWCX2j7qf8qtQ5UUlqtmZhgyyRueyIN0bV6J1hH8tGdHvDSU
	d+Qx49X3SRsyvBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 155F33EA62;
	Thu, 26 Feb 2026 14:12:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O9AsBcVUoGkDCQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Feb 2026 14:12:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CDC90A0A27; Thu, 26 Feb 2026 15:12:20 +0100 (CET)
Date: Thu, 26 Feb 2026 15:12:20 +0100
From: Jan Kara <jack@suse.cz>
To: Chia-Ming Chang <chiamingc@synology.com>
Cc: jack@suse.cz, amir73il@gmail.com, serge@hallyn.com, 
	ebiederm@xmission.com, n.borisov.lkml@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, robbieko <robbieko@synology.com>
Subject: Re: [PATCH] inotify: fix watch count leak when
 fsnotify_add_inode_mark_locked() fails
Message-ID: <nepvz4vbmesn3cqfkpyak6hxuzk6twoistaqehp2eokcbgbmad@wp2muiyz2bxj>
References: <20260224093442.3076294-1-chiamingc@synology.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224093442.3076294-1-chiamingc@synology.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78501-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,suse.cz:dkim,synology.com:email];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,hallyn.com,xmission.com,vger.kernel.org,synology.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4DE521A7748
X-Rspamd-Action: no action

On Tue 24-02-26 17:34:42, Chia-Ming Chang wrote:
> When fsnotify_add_inode_mark_locked() fails in inotify_new_watch(),
> the error path calls inotify_remove_from_idr() but does not call
> dec_inotify_watches() to undo the preceding inc_inotify_watches().
> This leaks a watch count, and repeated failures can exhaust the
> max_user_watches limit with -ENOSPC even when no watches are active.
> 
> Prior to commit 1cce1eea0aff ("inotify: Convert to using per-namespace
> limits"), the watch count was incremented after fsnotify_add_mark_locked()
> succeeded, so this path was not affected. The conversion moved
> inc_inotify_watches() before the mark insertion without adding the
> corresponding rollback.
> 
> Add the missing dec_inotify_watches() call in the error path.
> 
> Fixes: 1cce1eea0aff ("inotify: Convert to using per-namespace limits")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chia-Ming Chang <chiamingc@synology.com>
> Signed-off-by: robbieko <robbieko@synology.com>

Thanks! I've added the patch to my tree.

								Honza

> ---
>  fs/notify/inotify/inotify_user.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index b372fb2c56bd..0d813c52ff9c 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -621,6 +621,7 @@ static int inotify_new_watch(struct fsnotify_group *group,
>  	if (ret) {
>  		/* we failed to get on the inode, get off the idr */
>  		inotify_remove_from_idr(group, tmp_i_mark);
> +		dec_inotify_watches(group->inotify_data.ucounts);
>  		goto out_err;
>  	}
>  
> -- 
> 2.34.1
> 
> 
> Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

