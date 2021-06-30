Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0022F3B8349
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 15:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbhF3Njk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 09:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbhF3Njk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:39:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7A9C061756;
        Wed, 30 Jun 2021 06:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fwxAe5Jj4nUADGQ3NnZuU6s3gb4g0NHrvfY343FArro=; b=wBXbhN9bolWpPd/0O5AcbOMwl3
        eH8G40RWYk4EUOxl/3O2HuBFmrrDBoEhAuVeXobOqWw31yzwJOblUvyB03dh7LD4GLsoaBtJN9bem
        cpxNzqOFizQLTuXo1imD3hGoXBsUn3ddnjKbWPIv6Xvg3WXnUXeq60KAs66jLf2sJ/UzlFm441ikP
        1eXps7onJv/674Bylhe3cT7Mq1hYSFbdyW274t29dWyBjSK3W0CZO4og5VtcGJKPh7atOr7Yoy/Iw
        6cv2kzihbRl6XCCbossxXRTPMs8fH/sFLdqefVE/B2fKOryj3BVjZnJ2s2ByCPWK3OPaAucb2iSRy
        COoYedcg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyaNe-005OGB-1L; Wed, 30 Jun 2021 13:36:02 +0000
Date:   Wed, 30 Jun 2021 14:35:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH 1/2] iomap: Don't create iomap_page objects for inline
 files
Message-ID: <YNxzOkOifYIIR0HW@casper.infradead.org>
References: <20210628172727.1894503-1-agruenba@redhat.com>
 <20210628172727.1894503-2-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628172727.1894503-2-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 28, 2021 at 07:27:26PM +0200, Andreas Gruenbacher wrote:
> In iomap_readpage_actor, don't create iop objects for inline inodes.
> Otherwise, iomap_read_inline_data will set PageUptodate without setting
> iop->uptodate, and iomap_page_release will eventually complain.
> 
> To prevent this kind of bug from occurring in the future, make sure the
> page doesn't have private data attached in iomap_read_inline_data.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
