Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0911F3DCF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 16:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgFIOTE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 10:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgFIOTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:19:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0585C05BD1E;
        Tue,  9 Jun 2020 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FBLwkRXMTc6vHgytia3rUnElGSA+xmDAjdkBwfrqI+A=; b=HBEISCPLcFCYG6+JfomMD4NZnr
        2ADrh+/oQuHTMV84JQmnVfvOF6Qw1uEqloRvzK23R40M6iC23fXJl5kOvmMG+tkcFWvJY7ZmV75i5
        qiYbDa9XfCQEYT5lUdd9jnTqw3xP6Rcf71cGAVKgPh2vaFOknBltrXWwSPPKUzBJPKRRWLydhK4wz
        YsAuuIpq5hZDPlH5gtCAngRfNFjiThqfURj1e1vy1QkfCavzMzy8H8KdfNT90Di24vSNqd6RueyHE
        gCmAyS/Ya914HqFqNqcry5CWweb9IMZQCtC5BrR8y2uXg7SD9MZxXr5SOaef/wKShT8ZRs364tKQj
        a0rLVNSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jif5E-0004vp-5D; Tue, 09 Jun 2020 14:18:32 +0000
Date:   Tue, 9 Jun 2020 07:18:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/6] blktrace: annotate required lock on
 do_blk_trace_setup()
Message-ID: <20200609141832.GA14176@infradead.org>
References: <20200608170127.20419-1-mcgrof@kernel.org>
 <20200608170127.20419-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608170127.20419-5-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 08, 2020 at 05:01:24PM +0000, Luis Chamberlain wrote:
> Ensure it is clear which lock is required on do_blk_trace_setup().
> 
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
