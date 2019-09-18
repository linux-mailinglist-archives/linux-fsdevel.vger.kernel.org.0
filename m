Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 800E1B6FC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 01:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfIRXsh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 19:48:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfIRXsh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 19:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c/M6xmbjhA5kdZWFA1C98tnb2ENEAojyudEyYzGg0Jk=; b=rp5ONWHRQI3PtnhNOgVuIzbZp
        euFJ5EGOoMuY2lvGJU2OscwO2sDRQwbBC6t2+r2287NuXvZkU8Te9J3JogkP6qDLWAiYMLbuekp7+
        TctU1H1qORa00nVptiF7wnWrX6QeVaFFiwI4oi8npc54JoDkVVtol5PG6Z79Uc7041CM8f4FJP35x
        7yHNulGa+6wRbBXlM1rv116+i8ahT96bi8cAIKWq+lrtCaIu+Af0OvArFiu4q9bXSCzoxV7YecIVc
        vBgVGmll1xlZhLUH2nTQQhQSv83ydkXpMFWxg3IykFPnDb+X0+fyZXX7FhxXrnYvL3jeAEmHaLvw4
        fXzeHN1fA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAjga-00082Q-A3; Wed, 18 Sep 2019 23:48:36 +0000
Date:   Wed, 18 Sep 2019 16:48:36 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/5] fs: Introduce i_blocks_per_page
Message-ID: <20190918234836.GD9880@bombadil.infradead.org>
References: <20190821003039.12555-1-willy@infradead.org>
 <20190821003039.12555-2-willy@infradead.org>
 <20190918211439.GB2229799@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918211439.GB2229799@magnolia>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 02:14:39PM -0700, Darrick J. Wong wrote:
> On Tue, Aug 20, 2019 at 05:30:35PM -0700, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > This helper is useful for both large pages in the page cache and for
> > supporting block size larger than page size.  Convert some example
> > users (we have a few different ways of writing this idiom).
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Seems pretty straightforward, modulo whatever's going on with the kbuild
> robot complaint (is there something wrong, or is it just that obnoxious
> header check thing?)

It doesn't apply patches on top of the -mm tree for some reason.  So
it has no idea about the page_size() macro that's sitting in -mm at the
moment.

> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks.
