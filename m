Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F597D3D90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 12:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfJKKjq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 06:39:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55948 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfJKKjq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VPowYaaQeufsgbQpNT8qO9wU/pDjPBckYc+AN8WzdnU=; b=acf7neqFCemrbbHYbcPIUzMr+
        6HhjMRxLTwTRh2qG0EXpgvB15jVYN8gLCXvHHakytDT3WXY6gOZhvYMT/SSwKagf2IYOrB2X4Zz94
        ek4KCZn9/MBOp7lBnt/q4VUh2utVrDiUPNMLU/5IF1ftJS6TpfxjkcO7YF8YN/Hs4zbrm8z6pOwH3
        GY6JDE/Ap+mQ9wvsmcn8kIY+Z2EpgDUQBkiHVJgUOQzL3SeIvE4XTDe1GehkAkBNbn1h86TtL/EOX
        i+J1nO8EG5nk5I0EyO1QRBQYKW2cAszC+4f1wPKYHwCyHJ9+mucahclXRFQjDgIqerkBvgWKniZEv
        cqUA1Qmxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsKo-0005Rh-49; Fri, 11 Oct 2019 10:39:46 +0000
Date:   Fri, 11 Oct 2019 03:39:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 21/26] xfs: remove mode from xfs_reclaim_inodes()
Message-ID: <20191011103946.GC12811@infradead.org>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-22-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-22-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:19PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Because it's always SYNC_WAIT now.

Not really new in your series, but can use rename it to
xfs_reclaim_all_inodes if you touch all callers anyway? 
