Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E63355683
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 16:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbhDFOWX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 10:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhDFOWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:22:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97105C06174A;
        Tue,  6 Apr 2021 07:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=RynB5y7I5mMzngvG6dvcT08c6S
        hdfOQ6Eo23lFE4uuRzgQcC+lyIiZn6mkUEw9h0Q46dZmIAHQIoZADkMsdAITtq8xMem12NHLl85Y6
        0OZUg+5nxmT5MziellYEKbIJYDAsXKtegOYGDSsYcUFzY5ZEwl4fm0GBSl+jMVva9m+L/xQhOurka
        DcANwmjjVJmw1t5KV1rCbNoiRmxYLlc/LjFRYnJZHDdB149MLKGV0RrvclQQCrDm5d8R3AZP7dRjr
        koVxkm8vRP3AOn6SP44FOVfDQzcPIhaWG49Be9BaLsKOlnkVhM3LM/Cd7cmLrN54DOiapDNAdCZks
        awTCvlAA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTmYe-00CvNL-Ap; Tue, 06 Apr 2021 14:20:16 +0000
Date:   Tue, 6 Apr 2021 15:19:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 25/27] mm/filemap: Convert wait_on_page_bit to
 wait_on_folio_bit
Message-ID: <20210406141956.GX3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-26-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-26-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
