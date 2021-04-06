Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54352355691
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 16:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345143AbhDFO0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 10:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhDFO0J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:26:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F535C06174A;
        Tue,  6 Apr 2021 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LhIPpgiu3IunGK9kWoKLuEzxpJl7JYNX6ujUKfF3uzA=; b=Suq2pCTc3wv08U6mvKbyu9Rser
        5GX7i48KZIwT8vBbwj7ni8zlHmjSugiwPrl+xcYv6ZKfubM2po5pHncENHJuAirLyZZVWMWU42cCA
        Q0yiKrjR2wX4bTemLze010X8gzReHd3oxKn4W0WbyterEq/j/cMguLJgOzpcG1zmA8XLui14jHA13
        C4/EOLdJUa+14g/bPsNjmmD2RK5LRq0bauTHtkJ/uczCpYlaFnLbflDASpfWt++lX/1v23gydHU3U
        HkfMz6IJiHju//g1MRaZQaf89QAqHHZaqVCRqqMR3PtYIAsym20sdi3CkDENTGIjkY8e90eqHxo2K
        aKJPd14w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTmdh-00Cvsj-TS; Tue, 06 Apr 2021 14:25:16 +0000
Date:   Tue, 6 Apr 2021 15:25:09 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 27/27] mm/filemap: Convert page wait queues to be
 folios
Message-ID: <20210406142509.GZ3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-28-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-28-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:28PM +0100, Matthew Wilcox (Oracle) wrote:
> Reinforce that if we're waiting for a bit in a struct page, that's
> actually in the head page by changing the type from page to folio.
> Increases the size of cachefiles by two bytes, but the kernel core
> is unchanged in size.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
