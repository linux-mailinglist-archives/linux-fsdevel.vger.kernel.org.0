Return-Path: <linux-fsdevel+bounces-23389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821B792BAAD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4D01F24340
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 13:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBB415FA96;
	Tue,  9 Jul 2024 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="rnbT/omf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B495E15ECCC;
	Tue,  9 Jul 2024 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530528; cv=none; b=FLTIGT0AHxYyeXodzTkJysAx7DgKQ2otJI9TycLBLX+c8j9K2ZwJAxEGRcbLD81rlsU0X+BcWB+hN2PnqnxDDwrdiHyO/dIc4GBtQdfSAILDQ3RsqZPX0i2YjDRRA0nYWCgsiELhIF4ZLS53EKrUXCO5kB5ojW0W+9XAoV92+8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530528; c=relaxed/simple;
	bh=oBqg1HWvx9VQJgCxwdtvSjPNgabEY0G/wHeFdZGNcvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmuoSrYlmpSPP3n2xJIlCm5LtP5433mFo0vS+wnqDX5v0dh3/U8lBDbAWVzIGzYxeLn8wgZ6onW20qfzwyFWWMpvuzwtGD3YLe+uC+wxEuiD/IJSApcYdjbTzCudlL19zzcbCmQZOs+JsASVb3dkHTtqIpAGeeoC9t5deP4Kt34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=rnbT/omf; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WJLsJ3lh3z9svX;
	Tue,  9 Jul 2024 15:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1720530516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=67waOcRdhuokGC1VsAI1CleG4DFk7wy8/plFNIGbEQs=;
	b=rnbT/omfpIWc1cek0uLglNB0CURzcvikih+bJ3m6P/4wM6UjSyplrz4+ochoizAsH5se0w
	wMEdrtgnPu7x3OvUpcLKPl0CY6ALJyWxR2ED/M2Md6tiZhzgBMQ3JSB16Sf1xTmr86OdLh
	JPVtQTjmadQc3jkabF4vTfdwjznCGQVRc+F2rrzM48h4WP29rwBVOw7+mEs0/lbnO9wa/T
	LDaGSNh5Y525D/WXzWpp0vkUdXjt7/4TVXuVnRvwGR2aTfuL5r4jaOAmvMBzxJTAOM5cfI
	cyx08zOgyd1HczCYcjOUSFxHFGMzHlIDkXrrX7kYOH0+EYNno+VgEx8mp7PYVg==
Date: Tue, 9 Jul 2024 13:08:31 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>, chandan.babu@oracle.com,
	djwong@kernel.org, brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <20240709130831.5qdozpts44igmsn6@quentin>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <cb644a36-67a7-4692-b002-413e70ac864a@arm.com>
 <Zoa9rQbEUam467-q@casper.infradead.org>
 <Zocc+6nIQzfUTPpd@dread.disaster.area>
 <Zoc2rCPC5thSIuoR@casper.infradead.org>
 <Zod3ZQizBL7MyWEA@dread.disaster.area>
 <20240705132418.gk7oeucdisat3sq5@quentin>
 <1e0e89ea-3130-42b0-810d-f52da2affe51@arm.com>
 <ZoxvzXA1wcGDlQS2@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoxvzXA1wcGDlQS2@dread.disaster.area>

> > > 
> > > Why CONFIG_BLOCK? I think it is enough if it comes from the FS side
> > > right? And for now, the only FS that needs that sort of bs > ps 
> > > guarantee is XFS with this series. Other filesystems such as bcachefs 
> > > that call mapping_set_large_folios() only enable it as an optimization
> > > and it is not needed for the filesystem to function.
> > > 
> > > So this is my conclusion from the conversation:
> > > - Add a dependency in Kconfig on THP for XFS until we fix the dependency
> > >   of large folios on THP
> > 
> > THP isn't supported on some arches, so isn't this effectively saying XFS can no
> > longer be used with those arches, even if the bs <= ps?
> 
> I'm good with that - we're already long past the point where we try

From my cursory review, I can see that the following arch supports THP
(* indicates it has some dependency on other Kconfig parameter):

arc*, arm*, arm64, loongarch, mips*, powerpc*, riscv*, s390, sparc, x86.

and the following do not have THP support:

alpha, csky, hexagon, m68k, microblaze, nios2, openrisc, parisc, sh, um,
xtensa.

Looks like the arch that do not THP support are either old or embedded
processor that target mainly 32-bit architecture.

So are we OK with?

diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
index d41edd30388b7..be2c1c0e9fe8b 100644
--- a/fs/xfs/Kconfig
+++ b/fs/xfs/Kconfig
@@ -5,6 +5,7 @@ config XFS_FS
        select EXPORTFS
        select LIBCRC32C
        select FS_IOMAP
+       select TRANSPARENT_HUGEPAGE
        help
          XFS is a high performance journaling filesystem which originated
          on the SGI IRIX platform.  It is completely multi-threaded, can

> to support XFS on every linux platform. Indeed, we've recent been
> musing about making XFS depend on 64 bit only - 32 bit systems don't
> have the memory capacity to run the full xfs tool chain (e.g.
> xfs_repair) on filesystems over about a TB in size, and they are
> greatly limited in kernel memory and vmap areas, both of which XFS
> makes heavy use of. Basically, friends don't let friends use XFS on
> 32 bit systems, and that's been true for about 20 years now.
> 
> Our problem is the test matrix - if we now have to explicitly test
> XFS both with and without large folios enabled to support these
> platforms, we've just doubled our test matrix. The test matrix is
> already far too large to robustly cover, so anything that requires
> doubling the number of kernel configs we have to test is, IMO, a
> non-starter.
> 
> That's why we really don't support XFS on 32 bit systems anymore and
> why we're talking about making that official with a config option.
> If we're at the point where XFS will now depend on large folios (i.e
> THP), then we need to seriously consider reducing the supported
> arches to just those that support both 64 bit and THP. If niche
> arches want to support THP, or enable large folios without the need
> for THP, then they can do that work and then they get XFS for
> free.
> 
> Just because an arch might run a Linux kernel, it doesn't mean we
> have to support XFS on it....

The other option is we can expose a simple helper from page cache as
follows:

static inline unsigned int mapping_max_folio_order_supported()
{
    if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
      return 0;
    return MAX_PAGECACHE_ORDER;
}

This could be used to know the maximum order supported at mount time and
deny mounting for LBS configs if max folio supported is less than the
block size being requested.

