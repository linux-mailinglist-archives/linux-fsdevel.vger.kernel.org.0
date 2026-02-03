Return-Path: <linux-fsdevel+bounces-76128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH/QMkaOgWl/HAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 06:57:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3775BD4DDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 06:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E1CB30FEDE1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 05:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D013F366DC9;
	Tue,  3 Feb 2026 05:52:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2FA3570CC;
	Tue,  3 Feb 2026 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770097931; cv=none; b=ldolhVCOgPkZJYAwzaRbNqx5vCdxm6a34lJ+nTkpsjslfpONGxmACu5JqdSSPoaLnxkMh+BvXELmIw4UvV212LvHBhElorAQ2ljaEp+j0hhn6gA0EC8jlp/heRxDjwa861HuZkJiF0CnJwhFGsKmQxtWFyZVNChEfbgTJ209mB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770097931; c=relaxed/simple;
	bh=covcoWKGkx2DdlrIWRqTVHiB5w+hIh68pRPRhNKy4TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNKhGdk2RLPpaPIEpCeuzrBNiKoKrAEYVuctW5hCh6VJBcK6jY082n3L4Gn+jxb05YxgXJEs5zDq65Xl+80xUNsoQ+xl1ku3EqDYs7Y3zyHCqw1OjMiXMcWZHKpTeBUvjcQUbM5f7VZwyGsHJlW+/mdMAYVGmLAl7mMhTHbonZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D045A68AFE; Tue,  3 Feb 2026 06:52:05 +0100 (CET)
Date: Tue, 3 Feb 2026 06:52:05 +0100
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
Subject: Re: [PATCH v6 05/16] ntfs: update super block operations
Message-ID: <20260203055205.GC16426@lst.de>
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-6-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202220202.10907-6-linkinjeon@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-76128-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 3775BD4DDF
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 07:01:51AM +0900, Namjae Jeon wrote:
> This patch updates the super block operations to support the new mount
> API, and enable full read-write support. It refactors the mount process
> to use fs_context, implements synchronization and shutdown operations.
> 
> Key changes include:
>  - Implements the new mount API by introducing context-based helpers
>     (ntfs_init_fs_context(), ntfs_get_tree(), ntfs_reconfigure()) and
>     migrating option parsing to fs_parser, supporting new options.
>  - Adds ntfs_sync_fs() and ntfs_shutdown() to super_operations.
>  - Updates ntfs_statfs() to provide statistics using atomic counters
>     for free clusters and MFT records.
>  - Introduces a background workqueue ntfs_wq for asynchronous free
>     cluster calculation (ntfs_calc_free_cluster()).
>  - Implements ntfs_write_volume_label() to allow changing the volume label.

Suggested tweak to the commit message:

Update the super block operations to support the new fs_context-based
mount API, full read-write support including ->sync_fs, and file system
shutdown support.

Update ntfs_statfs() to provide statistics using atomic counters for free
clusters and MFT records.

Introduce a background workqueue for asynchronous free cluster
calculation (XXXXX: please add a sentence here why is is useful / needed)

Implement ntfs_write_volume_label() to allow changing the volume label.

With that:


Reviewed-by: Christoph Hellwig <hch@lst.de>

