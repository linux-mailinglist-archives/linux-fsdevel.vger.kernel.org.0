Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0041D3A7708
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 08:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhFOG12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 02:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhFOG11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 02:27:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD544C061574;
        Mon, 14 Jun 2021 23:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UOHRIpBkAkDRl0BGWB4kuvFPTUP08G/68bWuq+ypS88=; b=qZDwlyU8MooRSro57jBu9fs1Du
        YivK/XasX1eB0MJ+WL3m+HtuGw0tzVTzzDwj9hqsmSz/XgLogcS1fvYBCog3zUGPtpaRuqF33QxO6
        eXKnpLCIOzrUrEcJ1izalLoaGrVaxmb0jJLY3emSMV8BWyZHfI4UdCbP8/0IFHyqLG9Nj1B84897v
        h15tyPPRspPeadmjaPX0suHbLbdC6sV/8MIDsczYwBa6xe8ylcWJxXUlGXXb/+KuiqHhSDCNQtZZy
        ZSao2e7RtG6CK40nDU+sG/EYEPT6LJ02LSTCzKSGoS/qkYVRNBGVlOUNB4VmxipFQjAvGTPSEgzk+
        I1WE9JqA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lt2VK-006AB2-Uv; Tue, 15 Jun 2021 06:25:01 +0000
Date:   Tue, 15 Jun 2021 07:24:54 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 01/33] mm: Convert get_page_unless_zero() to return
 bool
Message-ID: <YMhHtrbKu+iwoacE@infradead.org>
References: <20210614201435.1379188-1-willy@infradead.org>
 <20210614201435.1379188-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614201435.1379188-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 09:14:03PM +0100, Matthew Wilcox (Oracle) wrote:
> atomic_add_unless() returns bool, so remove the widening casts to int
> in page_ref_add_unless() and get_page_unless_zero().  This causes gcc
> to produce slightly larger code in isolate_migratepages_block(), but
> it's not clear that it's worse code.  Net +19 bytes of text.

Strange.  Anyway, this looks like the right type, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
