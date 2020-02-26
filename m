Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B904170570
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 18:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgBZRFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 12:05:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbgBZRFH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RoCLmknvsOG65QXIhh4xiHuf4xfOWj6VnF+GxnaICfs=; b=oX9nzWXovMYD4UTYLkNhs6PXBa
        oIB9l5x5rtHW1JoDiVI6sOyxW7pJ+HyHEsqAwBDopdMOX7IegyH2lw3JVaGwbReLlEYe8saCtdFib
        M7Wpw/yMgU+xN7ib/6htSPNuyVSh8XVMA942gkBCgwUqvdbj2PwflJ2ei/wXMKFoREUPGZLiBoFPK
        1KgJZHw9KD6DbIQSIwjsPjElCP3rOgFw7aIr7acjWVWU83b6RP6rL50zYGbqiD5lL7hZbwE/dzxfk
        2uEaq3GU9vyXSZqJ2PbKMXlmDRBpvqc22XRN+TzMCxrEOJXNLtrFXf3lpGMd1qTNR4zkO5cza/wX3
        aydJpzDg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j707P-0007Yw-IT; Wed, 26 Feb 2020 17:05:07 +0000
Date:   Wed, 26 Feb 2020 09:05:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v8 17/25] btrfs: Convert from readpages to readahead
Message-ID: <20200226170507.GC22837@infradead.org>
References: <20200225214838.30017-1-willy@infradead.org>
 <20200225214838.30017-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225214838.30017-18-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 25, 2020 at 01:48:30PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Implement the new readahead method in btrfs.  Add a readahead_page_batch()
> to optimise fetching a batch of pages at once.

readahead_page_batch() isn't added in this patch anymore.

Otherwise this looks good to me, although I don't feel confident
enough to give a Reviewed-by for btrfs code.
