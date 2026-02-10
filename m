Return-Path: <linux-fsdevel+bounces-76836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHNQMQsYi2ljPgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 12:35:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9D811A4CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 12:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A29C3032CF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 11:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D94D31A545;
	Tue, 10 Feb 2026 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gixFV//b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PVwc0Ufl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gixFV//b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PVwc0Ufl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB042319877
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770723287; cv=none; b=JCCoUxCN2qUosfB9i8sDgQ3prNPMjA3lJAGfTuB4USaY1GNY1igP/Wzy2UY5qAJF4BJUBUJaPkT/TLFrtluYZKXpLtJZW6Xz6sATMFpZ/JHx4o8Vg+7DIgo/64mtc6yW0UGb5Mkj4O9c4kOFGnoaFTj+OnGsG++wMPVSEZqvR8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770723287; c=relaxed/simple;
	bh=LIZGLVzAtKY4eG08TLkoHF3u8fpfEzdGlD00SWSZZRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5xbKUbxJliM/FMQ8RJo3cT4xbKnUExyx3l1ZmfyrU+Orf5Kfy/wVuLoz8X4tylEGA/FMP4LYlwH2L2xavSPQxDppCAvz6TAT9fiLwmIy0GgPU5LvY9ZsGFdM1ACriGs45679jFCJ4ukv4Db8rOF1UqwOjtCX0PMDsK11OUCiOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gixFV//b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PVwc0Ufl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gixFV//b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PVwc0Ufl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 393805BD45;
	Tue, 10 Feb 2026 11:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770723284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfn2qjL1D8vXXgggI0IUON3J0sqZ4k9eIkuYo3kYIws=;
	b=gixFV//bAGobWLq1KIPX6Xlq46VQ5gCQ7bw7u3V5XGU3xVgt0jX4VbrUu2vSbpgxh+df7f
	oDA1ipDmThOsVe0QIhgnGO+5KVzNoARsTiAakdxc/qjI0rPWyUGrHIyhTjHmae3mmidvpr
	6PUsjEMUgXEtMk8fWJmQhMeFsxoBH7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770723284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfn2qjL1D8vXXgggI0IUON3J0sqZ4k9eIkuYo3kYIws=;
	b=PVwc0UflLaNH3Axqd8dUReYaoMdwolFcEk96sDVhSkZ9GY6RDmdy1kr8zRR7JZv+MQdNcQ
	vyq7PsBHv9cbGmBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770723284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfn2qjL1D8vXXgggI0IUON3J0sqZ4k9eIkuYo3kYIws=;
	b=gixFV//bAGobWLq1KIPX6Xlq46VQ5gCQ7bw7u3V5XGU3xVgt0jX4VbrUu2vSbpgxh+df7f
	oDA1ipDmThOsVe0QIhgnGO+5KVzNoARsTiAakdxc/qjI0rPWyUGrHIyhTjHmae3mmidvpr
	6PUsjEMUgXEtMk8fWJmQhMeFsxoBH7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770723284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfn2qjL1D8vXXgggI0IUON3J0sqZ4k9eIkuYo3kYIws=;
	b=PVwc0UflLaNH3Axqd8dUReYaoMdwolFcEk96sDVhSkZ9GY6RDmdy1kr8zRR7JZv+MQdNcQ
	vyq7PsBHv9cbGmBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81A3D3EA62;
	Tue, 10 Feb 2026 11:34:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XRmBDtEXi2lXFAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 10 Feb 2026 11:34:41 +0000
Date: Tue, 10 Feb 2026 22:34:31 +1100
From: David Disseldorp <ddiss@suse.de>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Dmitry Safonov <0x7f454c46@gmail.com>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] initramfs: correctly handle space in path on cpio
 list generation
Message-ID: <20260210223431.6bf63673.ddiss@suse.de>
In-Reply-To: <20260209153800.28228-1-ansuelsmth@gmail.com>
References: <20260209153800.28228-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76836-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ddiss@suse.de,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim,gen_initramfs.sh:url]
X-Rspamd-Queue-Id: 6F9D811A4CE
X-Rspamd-Action: no action

[cc'ing fsdevel]

On Mon,  9 Feb 2026 16:37:58 +0100, Christian Marangi wrote:

> The current gen_initramfs.sh and gen_init_cpio.c tools doesn't correctly
> handle path or filename with space in it. Although highly discouraged,

"highly discouraged" isn't really appropriate here; the kernel generally
doesn't care whether or not a filename carries whitespace.
The limitation here is specifically the gen_init_cpio manifest format,
which is strictly space-separated.

> Linux also supports filename or path with whiespace and currently this
> will produce error on generating and parsing the cpio_list file as the
> pattern won't match the expected variables order. (with gid or mode
> parsed as string)
> 
> This was notice when creating an initramfs with including the ALSA test
> files and configuration that have whitespace in both some .conf and even
> some symbolic links.
> 
> Example error:

The error messages don't really add any value here.
<snip>

> To correctly handle this problem, rework the gen_initramfs.sh and
> gen_init_cpio.c to guard all the path with "" to handle all kind of
> whitespace for filename/path.
> 
> The default_cpio_list is also updated to follow this new pattern.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  usr/default_cpio_list |  6 +++---
>  usr/gen_init_cpio.c   | 10 +++++-----
>  usr/gen_initramfs.sh  | 27 +++++++++++++++++++--------
>  3 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/usr/default_cpio_list b/usr/default_cpio_list
> index 37b3864066e8..d4a66b4aa7f7 100644
> --- a/usr/default_cpio_list
> +++ b/usr/default_cpio_list
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  # This is a very simple, default initramfs
>  
> -dir /dev 0755 0 0
> -nod /dev/console 0600 0 0 c 5 1
> -dir /root 0700 0 0
> +dir "/dev" 0755 0 0
> +nod "/dev/console" 0600 0 0 c 5 1
> +dir "/root" 0700 0 0
> diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
> index b7296edc6626..ca5950998841 100644
> --- a/usr/gen_init_cpio.c
> +++ b/usr/gen_init_cpio.c
> @@ -166,7 +166,7 @@ static int cpio_mkslink_line(const char *line)
>  	int gid;
>  	int rc = -1;
>  
> -	if (5 != sscanf(line, "%" str(PATH_MAX) "s %" str(PATH_MAX) "s %o %d %d", name, target, &mode, &uid, &gid)) {
> +	if (5 != sscanf(line, "\"%" str(PATH_MAX) "[^\"]\" \"%" str(PATH_MAX) "[^\"]\" %o %d %d", name, target, &mode, &uid, &gid)) {

This breaks parsing of existing manifest files, so is unacceptable
IMO. If we really want to go down the route of having gen_init_cpio
support space-separated paths, then perhaps a new --field-separator
parameter might make sense. For your specific workload it seems that
simply using an external cpio archiver with space support (e.g. GNU
cpio --null) would make sense. Did you consider going down that
path?

Thanks, David

