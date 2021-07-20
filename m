Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1573CFE6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 17:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbhGTPRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 11:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241892AbhGTOzS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:55:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24149601FD;
        Tue, 20 Jul 2021 15:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626795356;
        bh=6WWbHG/Fa5709pODcaChGeaGj3p2RG9Qp8c92oe20zI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JQKtkHgtu6oCFgE8fW9thT3eytInZV3idh1LlWRc/P0FRUiv8NTrsAeqyvPR0tk/z
         SDRabWk8G6xfWiZf36Rj0S2TFnEp3Ov1e+odU8Ld39pdfNN3ZmiSGlST3OvHnFtjx2
         OY7l50V5VXFeqfqVhKMLPOoHsJU5yWsQdpboDBTH9exrO64daiyQtBpU/W8qJ7BMYb
         c0ZyP8452/1RH3t7P70w8nDGP41Z7tlQOjutKH2mfwi5bkOW8Rx3wAeDcL7y8RbRhz
         EcPGzNjnZF7cLbi7QT/jvxOBfsB0+0qYju73pgV88ubSipoKUbl/1JNMtAytQX8myD
         SWCbbC145IMAg==
Date:   Tue, 20 Jul 2021 18:35:50 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 000/138] Memory folios
Message-ID: <YPbtVvnow+4I4ytS@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <YParbk8LxhrZMExc@kernel.org>
 <YPbEax52N7OBQCZp@casper.infradead.org>
 <YPbpBv30NqeQPqPK@kernel.org>
 <YPbqcQ9i/Vi7ivEE@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPbqcQ9i/Vi7ivEE@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 04:23:29PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 20, 2021 at 06:17:26PM +0300, Mike Rapoport wrote:
> > On Tue, Jul 20, 2021 at 01:41:15PM +0100, Matthew Wilcox wrote:
> > > On Tue, Jul 20, 2021 at 01:54:38PM +0300, Mike Rapoport wrote:
> > > > Most of the changelogs (at least at the first patches) mention reduction of
> > > > the kernel size for your configuration on x86. I wonder, what happens if
> > > > you build the kernel with "non-distro" configuration, e.g. defconfig or
> > > > tiny.config?
> > > 
> > > I did an allnoconfig build and that reduced in size by ~2KiB.
> > > 
> > > > Also, what is the difference on !x86 builds?
> > > 
> > > I don't generally do non-x86 builds ... feel free to compare for
> > > yourself!
> > 
> > I did allnoconfig and defconfig for arm64 and powerpc.
> > 
> > All execpt arm64::defconfig show decrease by ~1KiB, while arm64::defconfig
> > was actually increased by ~500 bytes.
> 
> Which patch did you go up to for that?  If you're going past patch 50 or
> so, then you're starting to add functionality (ie support for arbitrary
> order pages), so a certain amount of extra code size might be expected.
> I measured 6KB at patch 32 or so, then between patch 32 & 50 was pretty
> much a wash.

I've used folio_14 tag:

commit 480552d0322d855d146c0fa6fdf1e89ca8569037 (HEAD, tag: folio_14)
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Wed Feb 5 11:27:01 2020 -0500

    mm/readahead: Add multi-page folio readahead
 
-- 
Sincerely yours,
Mike.
