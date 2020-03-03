Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F41E217840D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 21:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbgCCUbv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 15:31:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731151AbgCCUbu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R4fltXhc1AgDmBEaAlZkK4e2FHblSj9UMQm1yxSRRZ8=; b=oDX6EKAhem5TcZV2zenuM4LtHG
        XScSDk4EEL3AGGCVsLKd8k4tqdSfozl+lVD3TJIoIxnnpu5f3BNeoVVexh6O1pDWtg+3OWifQEDCH
        f6xqbDBTeQjwYyxf3o98MtqgYXseL4E+GQ/y64cra6oCSWk/q4lTlTR2whaexaggIaB7NIaS11W0y
        zXzOUDDQzOYEMobZC0rgDPTiRzr7L7wv6HRZwuAvhDS8RpRsQxxyV3msjdWv15Jb03Z/vo7KnwT9k
        6tqX53+efg81c7inTFXgvgH0m9DDsCD5pJWIdauAU8zs7hhe7ib07n7YH2MP1PLSfld3bgFVKkBqQ
        CB1TntAA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9ECk-0003D6-MC; Tue, 03 Mar 2020 20:31:50 +0000
Date:   Tue, 3 Mar 2020 12:31:50 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Simplify /proc/$pid/maps implementation
Message-ID: <20200303203150.GU29971@bombadil.infradead.org>
References: <20200229165910.24605-1-willy@infradead.org>
 <20200303195650.GB17768@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303195650.GB17768@avx2>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 10:56:50PM +0300, Alexey Dobriyan wrote:
> On Sat, Feb 29, 2020 at 08:59:05AM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Back in 2005, we merged a patch from Akamai that sped up /proc/$pid/maps
> > by using f_version to stash the user virtual address that we'd just
> > displayed.  That wasn't necessary; we can just use the private *ppos for
> > the same purpose.  There have also been some other odd choices made over
> > the years that use the seq_file infrastructure in some non-idiomatic ways.
> > 
> > Tested by using 'dd' with various different 'bs=' parameters to check that
> > calling ->start, ->stop and ->next at various offsets work as expected.
> 
> /proc part looks OK, I only ask to include this description into first
> patch, so it doesn't get lost. Often 0/N patch is the most interesting
> part of a series.

I'm perfectly fine with this justification for the patch series being
lost.  I think this is the least interesting part of what I wrote.  And
will be the least interesting part for future researchers ... "Why did
this code get converted to behave exactly the same way as all the other
code" isn't really an interesting question.

