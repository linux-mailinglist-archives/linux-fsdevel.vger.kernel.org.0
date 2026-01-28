Return-Path: <linux-fsdevel+bounces-75705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CiwAQrQeWnezgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 09:59:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D5D9E8AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 09:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7351D3001A5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 08:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398C033B6F0;
	Wed, 28 Jan 2026 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JnYAkSuI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="elNprXqe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JnYAkSuI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="elNprXqe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB8433AD9C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590786; cv=none; b=U13qBZznBK6ECnFz+yBbr6RTa4Tq9qa8dwC/3yOXXRRTYsy51OJsZoQTvOxKBilO/5txgvxIYEAGX7SbCCQE8G9ud4P3h2Hs8TM+/rTVxgUX8qB9yq+Mlty4MJA6PYJeqReKc+D9HRnc552v1coNGghg1tyV25x5TEm0JBHf5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590786; c=relaxed/simple;
	bh=mSv90U0wIMCWoy7hnlcNIgDZMv5YbcR61tIBxSJ9IGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nm8YtwShqUPJk1AzC58yX7kj2NIWM5rvDBFkh/gnHSY8aIF699ToXgV8c5uNuvik4+yj40c38W4eFSqBzGVPeT91HBavJoPCF8d+XzTT8pqLxFEOe/1csUggRcOMK1LYwcTp9YZBmiVW1p0HpmZdGmDSylcVXgDKCJRnPncOm3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JnYAkSuI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=elNprXqe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JnYAkSuI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=elNprXqe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F9D85BCED;
	Wed, 28 Jan 2026 08:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769590783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Uxffqvd5LN+UDfiLv/3C5JZpMfXNPICA0RWLfdrfk8=;
	b=JnYAkSuI5T9vJcjoO7rdZfh+l2745JMI8vi2xEp/02z1ROWBoXR0EXkP22dWxvHCm9XMJ5
	vrUKItUQ4q55bQzo6X5WjrjJBQx6ooguiV7keHZH4boujaDu7r0j6mgvjz2VSk45gux6AY
	8+N+1u4KCkskWSurNJa7sKdObS43xe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769590783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Uxffqvd5LN+UDfiLv/3C5JZpMfXNPICA0RWLfdrfk8=;
	b=elNprXqeZeoBnztSuJffrag9ndmAoB6WFXHzbLxi0qtlxqeVJOdgkgZZ4PEgYQewDaqlyQ
	dhCfmbA47WSX8aCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769590783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Uxffqvd5LN+UDfiLv/3C5JZpMfXNPICA0RWLfdrfk8=;
	b=JnYAkSuI5T9vJcjoO7rdZfh+l2745JMI8vi2xEp/02z1ROWBoXR0EXkP22dWxvHCm9XMJ5
	vrUKItUQ4q55bQzo6X5WjrjJBQx6ooguiV7keHZH4boujaDu7r0j6mgvjz2VSk45gux6AY
	8+N+1u4KCkskWSurNJa7sKdObS43xe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769590783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Uxffqvd5LN+UDfiLv/3C5JZpMfXNPICA0RWLfdrfk8=;
	b=elNprXqeZeoBnztSuJffrag9ndmAoB6WFXHzbLxi0qtlxqeVJOdgkgZZ4PEgYQewDaqlyQ
	dhCfmbA47WSX8aCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A9BA3EA61;
	Wed, 28 Jan 2026 08:59:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FCxIDv/PeWlZPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Jan 2026 08:59:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F0752A0A1B; Wed, 28 Jan 2026 09:59:42 +0100 (CET)
Date: Wed, 28 Jan 2026 09:59:42 +0100
From: Jan Kara <jack@suse.cz>
To: Shawn Landden <slandden@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: isofs: support full length file names (255 instead of 253)
Message-ID: <ko6jrl6kzfwym5kqqqywgrksvq3qgmom64rxwpfp4v4cdabdks@yxlnt36utuan>
References: <CA+49okq0ouJvAx0=txR_gyNKtZj55p3Zw4MB8jXZsGr4bEGjRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+49okq0ouJvAx0=txR_gyNKtZj55p3Zw4MB8jXZsGr4bEGjRA@mail.gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75705-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 24D5D9E8AC
X-Rspamd-Action: no action

On Tue 27-01-26 09:05:52, Shawn Landden wrote:
> commit 561453fdcf0dd8f4402f14867bf5bd961cb1704d (HEAD -> master)
> Author: shawn landden <slandden@gmail.com>
> Date:   Thu Jan 15 21:44:11 2026 +0000
> 
>     isofs: support full length file names (255 instead of 253)
>     Linux file names can be up to 255 characters in
>     length (256 characters with the NUL), but the code
>     here only supports 253 characters.
> 
>     I tested a different version of this patch a few
>     years back when I fumbled across this bug, but
>     this version has not been tested.
> 
>     As mentioned by Jan Kara, the Rockridge standard
>     to ECMA119/ISO9660 has no limit of file name length,
>     but this limits file names to the traditional 255
>     NAME_MAX value.
> 
>     Signed-off-by: Shawn Landden <slandden@gmail.com>

Thanks! I've merged the patch to my tree.

								Honza

> 
> diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
> index 576498245b9d..094778d77974 100644
> --- a/fs/isofs/rock.c
> +++ b/fs/isofs/rock.c
> @@ -271,7 +271,7 @@ int get_rock_ridge_filename(struct iso_directory_record *de,
>                                 break;
>                         }
>                         len = rr->len - 5;
> -                       if (retnamlen + len >= 254) {
> +                       if (retnamlen + len > NAME_MAX) {
>                                 truncate = 1;
>                                 break;
>                         }
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

