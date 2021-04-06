Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67158355501
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 15:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344423AbhDFNYc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 09:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344421AbhDFNY1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:24:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DB0C06175F;
        Tue,  6 Apr 2021 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f4jEdkYkDZJ5f2u9VP2My1ps7db6iinBkMfF3gC5aBI=; b=u7DWfRiOyvtEDwgutwpf0dg2UH
        xV/bSu0KlGb1KxI9tVs6/x1J97VeDRZARmkqsDQPu2QSJzu9jwXHTgcx9mVjP1tbY03n2vVbb3t++
        TqPlmaCaVaaAT6rf1gVpf8/oMOwOXho/Jdk7TF0REZ9XYWCcyDEMpTLg5hbyuZ/bkDRzNXv85nqjR
        9xK4XT4bRQT83ja0iqnhoIz652f/ztcsobT6R15FVKQwywMemeyo5j1rtMw60HuUsCncvtp3oQmPU
        TK/El01eW4JiE85xB0IHZWhJGw9PT7s9de98IJGTcl6/lfA6trIWifuXf7AqQg9PiDI1YpHgyK91q
        Eg5l8ztQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTlff-00Cqnr-SP; Tue, 06 Apr 2021 13:23:18 +0000
Date:   Tue, 6 Apr 2021 14:23:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v6 02/27] mm: Add folio_pgdat and folio_zone
Message-ID: <20210406132307.GA3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:03PM +0100, Matthew Wilcox (Oracle) wrote:
> These are just convenience wrappers for callers with folios; pgdat and
> zone can be reached from tail pages as well as head pages.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
