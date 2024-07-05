Return-Path: <linux-fsdevel+bounces-23206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8137928A73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93BA32868C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 14:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDA216B391;
	Fri,  5 Jul 2024 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Ybe/2mjn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2736A16A930;
	Fri,  5 Jul 2024 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720188866; cv=none; b=YV1Q2MvnbvBLRV9PNGAxiXmgDU1P+Z+enc8c8R21KZj9xyUwAofS6cos0MJRhjXbTHCBn/N7V2fTu9gG7ZNcdHi3qNr5aDJY++w0bIsy58lfk3yDSiBTqYGT6UqJJWsbREKA3hsKRLOus0pmPx3S5bkmgCPfiDtvT6IaBHftW0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720188866; c=relaxed/simple;
	bh=4u1fCGzpoTy0cqNxVUPbdfkN8u8Ks22XOTMqt4mqnTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKxpXAIPjNekNzZMBb/duf2iIzcb09XLdqu0Ahu1eU5PuRu8QQeI/psabY9CeqcGOiVID5XjLe3sLP5Fzk9FIkhHy7t5u9ITWLBuj7ahJfnhVRvnUwUedHuZtykcB7rHzcddoIu+Dmu1AfQO/9ZzxGTGp8xgkQ9GehBtG2/cSQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Ybe/2mjn; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WFwW00hDJz9smF;
	Fri,  5 Jul 2024 16:14:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1720188860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y1Y4p2xqqd6gS24EgCZ1kgyTpBC+2Zys7nr/Eng5dRc=;
	b=Ybe/2mjnsGCnkb6nxXo8R7NDwbb1VLDonzraFe0Y4P8Otu6MUwQ7yH2u1wZxowOgnNSVb6
	tuQZA2bzQHTGmJTxNPvLBiFzYWgR1V18M8Zu2doB7FTv1VKcHYiTPuTHwR26A7Fay8UCzN
	DXFOd5J68bmcpNFFRGBPmWOhGwFsv5RJ9/fOxxws+B8VK/L6w2SWXcKWDWphR6xGBFt0Mq
	TVBLc++d1EEbDBeo/3DhQ0zgsHRlZcqwsbkDNBryOpfp2HZg2f6aajyKF8j3ITopkqnwAg
	Mam5ttaaDbXSjdYTI6ejz4oemihqdGG4a1ZPJubXdXZirBcgfrEzSelTqyVJcQ==
Date: Fri, 5 Jul 2024 14:14:14 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>, chandan.babu@oracle.com,
	djwong@kernel.org, brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <20240705141414.72yy6m75aajmlhvt@quentin>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <cb644a36-67a7-4692-b002-413e70ac864a@arm.com>
 <Zoa9rQbEUam467-q@casper.infradead.org>
 <Zocc+6nIQzfUTPpd@dread.disaster.area>
 <Zoc2rCPC5thSIuoR@casper.infradead.org>
 <Zod3ZQizBL7MyWEA@dread.disaster.area>
 <20240705132418.gk7oeucdisat3sq5@quentin>
 <1e0e89ea-3130-42b0-810d-f52da2affe51@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e0e89ea-3130-42b0-810d-f52da2affe51@arm.com>
X-Rspamd-Queue-Id: 4WFwW00hDJz9smF

> >>
> >>> If the device is
> >>> asking for a blocksize > PAGE_SIZE and CONFIG_TRANSPARENT_HUGEPAGE is
> >>> not set, you should also decline to mount the filesystem.
> >>
> >> What does CONFIG_TRANSPARENT_HUGEPAGE have to do with filesystems
> >> being able to use large folios?
> >>
> >> If that's an actual dependency of using large folios, then we're at
> >> the point where the mm side of large folios needs to be divorced
> >> from CONFIG_TRANSPARENT_HUGEPAGE and always supported.
> >> Alternatively, CONFIG_TRANSPARENT_HUGEPAGE needs to selected by the
> >> block layer and also every filesystem that wants to support
> >> sector/blocks sizes larger than PAGE_SIZE.  IOWs, large folio
> >> support needs to *always* be enabled on systems that say
> >> CONFIG_BLOCK=y.
> > 
> > Why CONFIG_BLOCK? I think it is enough if it comes from the FS side
> > right? And for now, the only FS that needs that sort of bs > ps 
> > guarantee is XFS with this series. Other filesystems such as bcachefs 
> > that call mapping_set_large_folios() only enable it as an optimization
> > and it is not needed for the filesystem to function.
> > 
> > So this is my conclusion from the conversation:
> > - Add a dependency in Kconfig on THP for XFS until we fix the dependency
> >   of large folios on THP
> 
> THP isn't supported on some arches, so isn't this effectively saying XFS can no
> longer be used with those arches, even if the bs <= ps? I think while pagecache
> large folios depend on THP, you need to make this a mount-time check in the FS?
> 
> But ideally, MAX_PAGECACHE_ORDER would be set to 0 for
> !CONFIG_TRANSPARENT_HUGEPAGE so you can just check against that and don't have
> to worry about THP availability directly.

Yes, that would be better. We should have a way to probe it during mount
time without requiring any address_space mapping. We could have a helper
something as follows:

static inline unsigned int mapping_max_folio_order_supported()
{
    if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
      return 0;
    return MAX_PAGECACHE_ORDER;
}

This could be used by the FS to verify during mount time.

> 
> Willy; Why is MAX_PAGECACHE_ORDER set to 8 when THP is disabled currently?
> 

This appeared in this patch with the following comment:
https://lore.kernel.org/linux-fsdevel/20230710130253.3484695-8-willy@infradead.org/
 
+/*
+ * There are some parts of the kernel which assume that PMD entries
+ * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
+ * limit the maximum allocation order to PMD size.  I'm not aware of any
+ * assumptions about maximum order if THP are disabled, but 8 seems like
+ * a good order (that's 1MB if you're using 4kB pages)
+ */ 

> > - Add a BUILD_BUG_ON(XFS_MAX_BLOCKSIZE > MAX_PAGECACHE_ORDER)
> > - Add a WARN_ON_ONCE() and clamp the min and max value in
> >   mapping_set_folio_order_range() ?
> > 
> > Let me know what you all think @willy, @dave and @ryan.
> > 
> > --
> > Pankaj
> 

