Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65E5355534
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 15:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344507AbhDFNcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 09:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344503AbhDFNc2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:32:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960F7C06174A;
        Tue,  6 Apr 2021 06:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=RYJ6frEpZUJr27qVejksR34O7u
        wG2/jAVs8IPjopYrsyR5swGCtYmJ29UWcxWdy63ogNxOVdoaDOdbV9sGnwNSiyXPmbD4iowUbajW3
        YvW0rvYj70+ANMYAxdT3GcoumgntHAh4NjLKK7nCxy2POyyfcVZg+Y3nV0BAP/gkUlNBrenIyxrOh
        dCoV5t0rMwoNa500NzcEeqc6Q7k+TBzhMBekdyxjOElDqifv31g/CJLqkl4wA30vFsDwLrffzx6eA
        COlSlujR+jBGUYOYB63k5Bo9KzqOqri6pTvBDRLQhUcxMStKqoT32wo4Nv5GlLFQN0Z/s1d1bHBk1
        Ps8MLA3A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTlo6-00Cral-Ap; Tue, 06 Apr 2021 13:31:52 +0000
Date:   Tue, 6 Apr 2021 14:31:50 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v6 06/27] mm: Add put_folio
Message-ID: <20210406133150.GE3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-7-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
