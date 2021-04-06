Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D04355668
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 16:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhDFOUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 10:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345106AbhDFOTe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:19:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C0C06174A;
        Tue,  6 Apr 2021 07:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V+mqfpmyni1DXeDGcSt6JYGkbc6/W+OzefrSF68qbTE=; b=g0OnYJeNojI0tGUvC+/4CLfykg
        xYbJMOKwNOzr2MNKGY1c2R4yQlIX5CAs1ntHuh8nZNTFNmFxZNdrxNbTylg/il/BUo00nWsH1BSBm
        bvMeQoTSAVUPjb6YnmfDzGUyrBKaOAy8aVxhcdsH5wTfggIdsI7hfZaUFhVLXszX2PDDeKV6hdqC2
        PZGhI65Nv3C2HIGTR9Q1s9BVnaLmxiJdUFVL91loH0NMVvsVC6q59ocGNFy5NlelxKbC0Xsj/fiy/
        xbRYMuN+4pyXzEet/t6p/4CvFbZm4Q+a3pG+1pHyGu+94kLYfCnuwMMTKBwMp5oa55q7F27ZPiqNz
        E3TAk6oA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTmXB-00CvJR-0x; Tue, 06 Apr 2021 14:18:27 +0000
Date:   Tue, 6 Apr 2021 15:18:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 24/27] mm/writeback: Add wait_for_stable_folio
Message-ID: <20210406141825.GW3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-25-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-25-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:25PM +0100, Matthew Wilcox (Oracle) wrote:
> Move wait_for_stable_page() into the folio compatibility file.
> wait_for_stable_folio() avoids a call to compound_head() and is 14 bytes
> smaller than wait_for_stable_page() was.  The net text size grows by 24
> bytes as a result of this patch.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
