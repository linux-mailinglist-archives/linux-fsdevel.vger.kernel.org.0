Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C68D3CAD68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244278AbhGOUA7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 16:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243656AbhGOT6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:58:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C346C0F26D6;
        Thu, 15 Jul 2021 12:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xC8DljMX6jPiCBBniTFXOHl2A2ewgqoXw4uH8qyzMag=; b=MOtcPjtAXCs2oACFlahWOPLKoY
        Lvt0RONl9f7YL7xrXRQHwSjaZNrafoJScpQm/i6tccTFEqCyQY5ZDwVT1Q2cWhAYytemoBR9isLcF
        DoIUoYzGee1obbhcKv6NKJVxH/ouD469zvzlNBP/F5YebCVKrJRQgyX1ickTY66eoSebcPQp6d8qn
        gK4Tk1ZBPIpLdvd3co4z6p4YhJa1VLO4pu1hbizTwtffnTBBVOSbNYsIHxDSzZClYt0RsTZ13tsog
        udTWf8R5H7OxQ0aNtrOgyp3svkQva6xrt2fHP7Te9SprdxyQRrndjAai5zDoq44HF+FfUQKVgnL5N
        iDGNV72A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m47CH-003j8q-Pq; Thu, 15 Jul 2021 19:39:32 +0000
Date:   Thu, 15 Jul 2021 20:39:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Request for folios
Message-ID: <YPCO1SuMyZ6j4Gno@casper.infradead.org>
References: <3398985.1626104609@warthog.procyon.org.uk>
 <20210713191101.b38013786e36286e78c9648c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713191101.b38013786e36286e78c9648c@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 13, 2021 at 07:11:01PM -0700, Andrew Morton wrote:
> > Also, is it possible to get the folios patchset in a stable public git branch
> > that I can base my patches upon?
> 
> I guess Willy's tree, but I doubt if the folio patches will be reliably
> stable for some time (a few weeks?)

So, how about I put the 89 patches which I want to merge this merge
window into a git branch which Dave can develop against?  Andrew can
pull that branch into mmotm when it's sufficiently settled for his taste.

In order for that to look good in Linus' tree, either Dave can send a
pull request which includes all of the folio patches, or I can send a
pull request early in the merge window (or even before the merge window
opens) which includes those 89 patches.

That would mean the patches wouldn't have Andrew's sign-off on them, but I
could add a R-b from Andrew to all of them if that's the right way to go.
