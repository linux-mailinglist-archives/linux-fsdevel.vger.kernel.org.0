Return-Path: <linux-fsdevel+bounces-14733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1BC87E7E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 12:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AB11F24878
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 11:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640432EB1D;
	Mon, 18 Mar 2024 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G+tRNaqg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZFsIMxDV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G+tRNaqg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZFsIMxDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F4932C96;
	Mon, 18 Mar 2024 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759608; cv=none; b=MAnkQ/s7QUFjsIftlvAWSA1AAf8YaKjwBE8HZTuxqU939BXlv0T3Czusm2k17Jz5qoOeF/sKcjAhUv7cKCyVWVGINY1A1fWME8LnuZP+2o5Ei7HP3/9cOvPHi/bkFEEG7g3quAnkMex4iWbmM+rZdNMB3JPAupNQHm7oZIzSQes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759608; c=relaxed/simple;
	bh=YZx9GXg0tDDNlNzR8UzVCTrXSLavpryJxBHzC57m6wM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hydPNHqr+oh4r5QiwtAvT963dLWP+KQzUY2hD/gau5czyf1EsnMM5Poe0xomvXbyAb6HjjU/gkf+puONdjqPtwFt/7rXWbH4ifyTrmLJRKRSW0sZ3EtR6KmmywpxTdNN1kAMMHsKDV07hzGVTOvFIg2o8rMEGS5jyGKIWcEW4dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G+tRNaqg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZFsIMxDV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G+tRNaqg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZFsIMxDV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3EFC13493B;
	Mon, 18 Mar 2024 11:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710759605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RFsuoAxFVWNzTLEUjOV3WiF5FuGebsZI6nE5Ta2mC2E=;
	b=G+tRNaqgZQg4yeuXdZLxANxuN4va+gbo2QThgGptull48FX+ppuN0TDm63BntMQCpghAPj
	1pLf0+TF6y1k0EUZUn73OpZ1tPIJui4DgTC4y9QX5nlIpBiSV6xgLPWuPJfFqJ6/uibGi7
	cPDtamo1AYkseP1RDLKIzkYH59WjVDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710759605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RFsuoAxFVWNzTLEUjOV3WiF5FuGebsZI6nE5Ta2mC2E=;
	b=ZFsIMxDVYCTv5gp9wrXl3fuR80/po2DhOjWjuzQvRjVi/KZmuGhUQ0FRTVC6xAtKDDwxby
	1lX1FBUGpdpswnBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710759605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RFsuoAxFVWNzTLEUjOV3WiF5FuGebsZI6nE5Ta2mC2E=;
	b=G+tRNaqgZQg4yeuXdZLxANxuN4va+gbo2QThgGptull48FX+ppuN0TDm63BntMQCpghAPj
	1pLf0+TF6y1k0EUZUn73OpZ1tPIJui4DgTC4y9QX5nlIpBiSV6xgLPWuPJfFqJ6/uibGi7
	cPDtamo1AYkseP1RDLKIzkYH59WjVDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710759605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RFsuoAxFVWNzTLEUjOV3WiF5FuGebsZI6nE5Ta2mC2E=;
	b=ZFsIMxDVYCTv5gp9wrXl3fuR80/po2DhOjWjuzQvRjVi/KZmuGhUQ0FRTVC6xAtKDDwxby
	1lX1FBUGpdpswnBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0756B1349D;
	Mon, 18 Mar 2024 11:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3Ln0KrIe+GVpbQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 18 Mar 2024 11:00:02 +0000
Date: Mon, 18 Mar 2024 21:59:55 +1100
From: David Disseldorp <ddiss@suse.de>
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM ATTEND] Over-the-wire data compression
Message-ID: <20240318215955.47e408bf@echidna>
In-Reply-To: <20240315122231.ktyx3ebd5mulo5or@quack3>
References: <rnx34bfst5gyomkwooq2pvkxsjw5mrx5vxszhz7m4hy54yuma5@huwvwzgvrrru>
	<20240315122231.ktyx3ebd5mulo5or@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: 6.89
X-Spamd-Result: default: False [6.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[50.43%]
X-Spam-Level: ******
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

Hi Enzo,

...
> On Thu 14-03-24 15:14:49, Enzo Matsumiya wrote:
> > Hello,
> > 
> > Having implemented data compression for SMB2 messages in cifs.ko, I'd
> > like to attend LSF/MM to discuss:
> > 
> > - implementation decisions, both in the protocol level and in the
> >   compression algorithms; e.g. performance improvements, what could,
> >   if possible/wanted, turn into a lib/ module, etc
> > 
> > - compression algorithms in general; talk about algorithms to determine
> >   if/how compressible a blob of data is
> >     * several such algorithms already exist and are used by on-disk
> >       compression tools, but for over-the-wire compression maybe the
> >       fastest one with good (not great nor best) predictability
> >       could work?

Ideally there could be some overlap between on-disk and over-the-wire
compression algorithm support. That could allow optimally aligned /
sized IOs to avoid unnecessary compression / decompression cycles on an
SMB server / client if the underlying filesystem supports encoded I/O
via e.g. BTRFS_IOC_ENCODED_READ/WRITE.

IIUC, we currently have:
SMB: LZ77, LZ77+Huffman (DEFLATE?), LZNT1, LZ4
Btrfs: zlib/DEFLATE, LZO, Zstd
Bcachefs: zlib/DEFLATE, LZ4, Zstd. Currently no encoded I/O support.

Cheers, David

