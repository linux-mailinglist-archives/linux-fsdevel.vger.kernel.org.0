Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1EA3A7716
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 08:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFOG3o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 02:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhFOG3n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 02:29:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB855C061574;
        Mon, 14 Jun 2021 23:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=NPnGyhkNa3ew7XfHqRc/bZuSnA
        dYdMwOtqBnWry/mDMKes9RxTsZCfAhssF7P3vmNNegW69NIAMqFffAIR3DyJ51ewqe6xYxCHtVC1r
        AYJFrXNQ979xZqw7A+sq/1jvPMuDOPhWy1ZxueONkgZNAQhEZQZAAkPOZfbRJvoysxgu48B5f/gAa
        LbqDrI/Ml8FYYQNND/MuFCNr40tnKt/9IiD2QCj38h7w3nHPzxlZ7okE+XJz4Xxnh2ZpoFH5IhObZ
        jI060SFgB6aFQfG5e0W9loPFHk9oU1lUga9w0EwJJN3pQR8/ZgoMTlrTMzYH4i14hlf+5AlRJdyVV
        o6JaAAhQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lt2XV-006AIf-QI; Tue, 15 Jun 2021 06:27:13 +0000
Date:   Tue, 15 Jun 2021 07:27:09 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v11 11/33] mm/lru: Add folio LRU functions
Message-ID: <YMhIPbNvFt3ZrIf7@infradead.org>
References: <20210614201435.1379188-1-willy@infradead.org>
 <20210614201435.1379188-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614201435.1379188-12-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
