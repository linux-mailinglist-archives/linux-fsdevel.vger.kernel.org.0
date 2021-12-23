Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2F747E04C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347084AbhLWIVz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347081AbhLWIVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:21:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8F8C061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eBF80fKD420Drqb9lA6abgmdqkTul58p81NqzNkrxSQ=; b=eU9wx1u+e3qAd1IW1kBoZLnpku
        ll0PzDCWU6y7yaVZT7ECZKed/Zs+rwDMstUuy4lkdDipbJaZd1OurKa1wOoMrJq0A1YvTh+VZngSk
        g7aiRCLTiIJrX9PqIqwFjTVSDrUO17bFs3HGbPbogbnXcXAXYaP0HFsHN8s4sKOFgGuJ64jD5EzRL
        egUt6zuHs+yz1UOJHPwFfSb5JEzhQnK4+HonjMQPOpI9BRADuEECsxASsZCl6DZznojGcmoh3xVsD
        HP529MU1HIq0gDsgwxLRnLADJoHOuAerOG/Kxn3uqRGDrQeP9fczLwdURQ5Acg5vpysCvJimCRoDR
        oyZUz2bA==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0JMF-00CCfX-Bz; Thu, 23 Dec 2021 08:21:51 +0000
Date:   Thu, 23 Dec 2021 09:21:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 37/48] truncate: Convert invalidate_inode_pages2_range()
 to use a folio
Message-ID: <YcQxnAOfLBbDuWFZ@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-38-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-38-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:45AM +0000, Matthew Wilcox (Oracle) wrote:
> If we're going to unmap a folio, we have to be sure to unmap the entire
> folio, not just the part of it which lies after the search index.
> 
> We cannot yet remove the struct page from invalidate_inode_pages2_range()
> because the page pointer in the pvec might be a shadow/dax/swap entry
> instead of actually a page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
