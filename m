Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743AA2540FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 10:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgH0Ig1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 04:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgH0Ig0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:36:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3495CC061264;
        Thu, 27 Aug 2020 01:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o5+xPEQxoEEyAdnso83ls1nfUNx+yX31JYi8krguPtk=; b=UK69VdUqhTbBTdlbAAxYMJtxrl
        entONaNmGq3w0fuYxiC9Tjlpd+IhsF4BIQ0MiASfoj9j2ql78Jaqh1V3HwyO1hsMnFfJayIL9oPQS
        aAFZTzXMprC4RwQYFKBSzISZ0FzIZryxYKojdslclEqMr2gmc6PHD2bmbYhCRkCO1cvjOPGf5TKdw
        3rtdVl6HR8OJUQ34E2dmxOZm/i+KXH1mYQI7FMWH0Fc1wO224Y7IpYp6xIIbDjLcVQ8G+8425ygry
        ohbiO+F3qMGneAOLudfVIQ8QQknoVuXTH/wb4RXGKNvzZrzb0vO8iPbDz0iw5NBQY/bnevpbdOaJA
        2S3RuaWQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBDOS-0003qi-L9; Thu, 27 Aug 2020 08:36:24 +0000
Date:   Thu, 27 Aug 2020 09:36:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] iomap: Convert write_count to byte count
Message-ID: <20200827083624.GD11067@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-8-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 03:55:08PM +0100, Matthew Wilcox (Oracle) wrote:
> Instead of counting bio segments, count the number of bytes submitted.
> This insulates us from the block layer's definition of what a 'same page'
> is, which is not necessarily clear once THPs are involved.

Looks good (module the field naming as comment on the previous patch):

Reviewed-by: Christoph Hellwig <hch@lst.de>
