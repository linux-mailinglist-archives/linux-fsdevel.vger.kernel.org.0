Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6703CB119
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 05:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhGPDYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 23:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhGPDYt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 23:24:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B05C06175F;
        Thu, 15 Jul 2021 20:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HjGRoc3/OqzyLh9Nr2BjY7Bgu7b4RzBA6Qr+2SpfJvE=; b=tUuRsJ33AjA2ugN3txWiyXZt+x
        WE4UgVX90LCGZamtHp4iHC69QF1b5S+p17M/LPQWha2GjlTTogNQXC0miZqf2UdgYaPRsqCCb+enw
        mLxRp+6F/X5cPmHK15rJeiTBStUXuuAj+wPNOnUPpuDmmC2Zrm6AJMgdTmncPpoAdnAINhH1SBBHF
        /QI8vYG8ajOr799yuRu+HhJ7F65HzsNIV5Hc4KX4K0KMGGfkrEk6LZqkbt3v+VSxBEObQGPkj0rWs
        SvPBryeTtuawDHWhK1GFZ20xKUngDK9XVXoLfxwprXLIKRnzvvTxdQOJ6P1JyQqSDGdV1R9vNapU8
        JEEzXztA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4EPl-0046HX-Dr; Fri, 16 Jul 2021 03:21:30 +0000
Date:   Fri, 16 Jul 2021 04:21:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 097/138] iomap: Pass the iomap_page into
 iomap_set_range_uptodate
Message-ID: <YPD7NQvXMhR1D6jU@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-98-willy@infradead.org>
 <20210715212105.GH22357@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715212105.GH22357@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 02:21:05PM -0700, Darrick J. Wong wrote:
> On Thu, Jul 15, 2021 at 04:36:23AM +0100, Matthew Wilcox (Oracle) wrote:
> > All but one caller already has the iomap_page, and we can avoid getting
> > it again.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Took me a while to distinguish iomap_iop_set_range_uptodate and
> iomap_set_range_uptodate, but yes, this looks pretty simple.

Not my favourite naming, but it's a preexisting condition ;-)

Honestly I'd like to rename iomap to blkmap or something.
And iomap_page is now hilariously badly named.  But that's kind
of tangential to everything else here.
