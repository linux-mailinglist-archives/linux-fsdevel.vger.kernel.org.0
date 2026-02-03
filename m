Return-Path: <linux-fsdevel+bounces-76126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAIqF12LgWnuGwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 06:45:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F34D4CB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 06:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41CE1303CA7F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 05:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A2136680D;
	Tue,  3 Feb 2026 05:44:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3378246798;
	Tue,  3 Feb 2026 05:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770097472; cv=none; b=Qb65r9xJfak4MZ6jgqWPQHnvZeUFMuMuTNXb7kyMK8nrEkP/J6WT1cGMYAxzRtTYXgbmbOh5x60Lb2Rq07ojLEZeVXdiW2Dt8nEUPsP22dO5tiV76Dmc4kApctc1l6NrkWZ94c7/XUGEbYY3anI+3/s/jgq3TrEOEKVa+32b5kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770097472; c=relaxed/simple;
	bh=VXeZ4uK69CMQdNhIvU66lKaWOORCKSLS9UioJ4x1yVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXC88Zzha+jK1IcDiZdWiOHGlrI+VRD+zPSfNQJXubHy27dKfpcBfOaJrexMhrHkUZbZNl7qUiBYLn8rILzqN0Q8kMsGvqL/NXtL/YPAvzwDJiF3l6bFxP1r0obFLrF5kPCUpv2LskBtAugKk2Xvx8c5xBh15afNhdFG63rmxCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2177068AFE; Tue,  3 Feb 2026 06:44:27 +0100 (CET)
Date: Tue, 3 Feb 2026 06:44:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com
Subject: Re: [PATCH v6 02/16] Documentation: filesystems: update NTFS
 driver documentation
Message-ID: <20260203054426.GA16426@lst.de>
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-3-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202220202.10907-3-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76126-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com,vger.kernel.org,lge.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2F34D4CB4
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 07:01:48AM +0900, Namjae Jeon wrote:
> Update the NTFS driver documentation (Documentation/filesystems/ntfs.rst)
> to reflect the current implementation state after switching to iomap and
> folio instead buffer-head.
> 
> Changes include:

"Changes include" doesn't really add much value, and feels like AI
slop.

I'd rewrite the message as:

Update the NTFS driver documentation to reflect the update implementation.
Remove outdated sections (web site, old features list, known bugs,
volume/stripe sets with MD/DM driver, limitations of old driver), add a
concise overview of current driver features and long-term maintenance
focus, add a utilities support section pointing to ntfsprogs-plus project
and update mount options list with current supported options.

I'd probably also move this last in the series.

> +nls=name		Deprecated option.  Still supported but please use
> +                        iocharset=name in the future.

A lot of these mount options sections starts the first line with tab
indentation and then continue with spaces only.  Please stick to one
of them.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

