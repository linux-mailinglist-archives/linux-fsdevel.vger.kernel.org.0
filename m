Return-Path: <linux-fsdevel+bounces-79805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBYGKnzvrmkWKQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 17:04:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FB423C64B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 17:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFC8830426A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281223C1995;
	Mon,  9 Mar 2026 15:48:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7226323ABA8;
	Mon,  9 Mar 2026 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071283; cv=none; b=BNp5quXlDq/kM6MJwr5EaRTv/sG0q3tNYGjHjOr6tzl6tuFPhzeda0Gvi6MO4dsNaqbWis0vQ1qTF0ED1P3Zyk4Uc7MohWFq8UzooK+osOW+UXNwbDp7Z6gK/YNoAOjSNsb8B0QMPFYMajoOa1Y3h5tOm+eNTZRHyYMvYcKUOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071283; c=relaxed/simple;
	bh=mEIWqwGbrW27d8D2B++HR9GmKX1wltJ+IazL+DWKnVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyouDTdYKfGtpIsD0CQeRMsH0t63JdM3O7c2qxkLLz24jS954If8VEUAg7i/osCQtO9d4Y/vxvju6rGaJijV6DdY7oxFVptPJy7abNXFoyRG9pP/g3awAImsMQhD183+yMrzl5W2dishOU9gwMyVDhlxLiTibB8zF+q1e4tyW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C6B2568C7B; Mon,  9 Mar 2026 16:40:47 +0100 (CET)
Date: Mon, 9 Mar 2026 16:40:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: brauner@kernel.org, hch@lst.de, djwong@kernel.org, jack@suse.cz,
	cem@kernel.org, kbusch@kernel.org, axboe@kernel.dk,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com, Hans Holmberg <hans.holmberg@wdc.com>
Subject: Re: [PATCH v2 0/5] write streams and xfs spatial isolation
Message-ID: <20260309154047.GA18538@lst.de>
References: <CGME20260309053425epcas5p32886580a4fbe646ceee66f2864970e9f@epcas5p3.samsung.com> <20260309052944.156054-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309052944.156054-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Queue-Id: 12FB423C64B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_SPAM(0.00)[0.300];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lst.de:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79805-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action

This is laking numbers to justify all the changes.

From previous experiments the most important isolations is to put
the file system log and metadata into a separate stream each, which
would be the first step before exposing user knobs.

And once we look into application optimizations I think your best bet is
to resurrect the FDP/write streams support for zoned XFS that Hans and I
did and posted in reply to one of Keith' iterations of the write stream
patches.  This will reuse all the intelligent placement decisions we've
put into that allocator.  Once that is done we can look into exposing the
write streams already inherent in that to user space, but we really
should be doing all the ground work first.  And maybe some of this can
apply to the conventional allocator, but given that it has no way to
track the placement unit sizes I'm a bit doubtful that the results will
look great.


