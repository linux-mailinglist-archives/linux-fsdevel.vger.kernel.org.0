Return-Path: <linux-fsdevel+bounces-76127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D/DIRSMgWl/HAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 06:48:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CF8D4CCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 06:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 824B73024153
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 05:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B86C207A0B;
	Tue,  3 Feb 2026 05:47:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947754A21;
	Tue,  3 Feb 2026 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770097671; cv=none; b=SMX4f1BozZkhaxIa2B09dsD+S76f9ToqZ7R4alkLC6mya6hEPAp6GArWZ37bP+YC1P73cis2xPb3K32rCV7SSBgB7kv/GG/+Iz6f3iTd8+j51tmSb6Lhz89vqqzkY1zIabi3VNysTU0JMn2JIh2r1Hjts2QMb1MMR2yva1EFn+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770097671; c=relaxed/simple;
	bh=3QtomF8SyQRjr5UaqDtTnEi8/wfCnb6XzYPyXG4qqAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAugDYe8WkQL8bBl+wpkLQHoSDc/PaGjZWpu41WYG5PTUeGQvQmzjPoUbujbtaWPPmBEgL7b1Qs49vyaTa6IYtRpJSDw89VfBtwHfCx+G8vZIovStCGqCGSu7sGqIU9s9yzqtiwTADwN8krve0y5/DuNOXvTdpZASMEnJa7k2NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B075268AFE; Tue,  3 Feb 2026 06:47:42 +0100 (CET)
Date: Tue, 3 Feb 2026 06:47:41 +0100
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
Subject: Re: [PATCH v6 04/16] ntfs: update in-memory, on-disk structures
 and headers
Message-ID: <20260203054741.GB16426@lst.de>
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-5-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202220202.10907-5-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76127-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9CF8D4CCF
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 07:01:50AM +0900, Namjae Jeon wrote:
> This patch updates the NTFS filesystem driver's in-memory and on-disk
> structures.
> 
> Key changes include:
> 
>  - Reorganize the comments in headers for better readability. (Fix the
>    warnings from checkpatch.pl also)
>  - Refactoring of core structures ntfs_inode and ntfs_volume to
>    support new features such as iomap, and others.
>  - Introduction of `iomap` infrastructure (iomap.h) and initial
>    support for reparse points (reparse.h) and EA attribute(ea.h)
>  - Remove unnecessary types.h and endian.h headers.

Key changes include once again does not really add value here, and
a lot of maintainers hate the "This patch" wording.

Suggested alternate version:

Update the NTFS filesystem driver's in-memory and on-disk structures:

  - Introduce the `iomap` infrastructure and initial support for reparse
    points and EA attribute.
  - Refactor the core ntfs_inode and ntfs_volume structures to support
    new features such as iomap.
  - Remove the unnecessary types.h and endian.h headers.
  - Reorganize the comments in headers for better readability, including
    fixing warnings from checkpatch.pl.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

