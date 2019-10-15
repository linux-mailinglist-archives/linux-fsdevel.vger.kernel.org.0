Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38B88D7AFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 18:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfJOQQx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 12:16:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbfJOQQw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9iYF9cRkISxYXYSSm1GKnAEO8Tf9HaYNerpZs46i+mA=; b=o1akRSK3HdttiP9AR0GcQOdSI
        TQuOowvTxtTQGnJVnFOsETaDZECVq+Gp7n9gQIkTgcYaYL9pWthR5eZ0uuXouiKA/6IAlBWBMKYXM
        MNDswTEsmjjW/1OKvOsQim14YsrhM01GMGnxa6HLdJct16qJX3I/S6aOqqAUFvJgWR+IjFqRX3Nfp
        jnRCAa0YH0sDxNVndzqCrCuWKx/rRdzK+rv5C0HKTxVyzTbqSBBSBRHC429349ueL2EWIYX1tTWqs
        WeNeQoGe27yhkDR7siv5kZfUeLoZJkb/dvt5axhuaQsRD3c695Rv1fPD2N0YftB0XZ4XsEDU7fM0F
        TmfEFgScA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKPVD-0000lh-Mk; Tue, 15 Oct 2019 16:16:51 +0000
Date:   Tue, 15 Oct 2019 09:16:51 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: iomap: use SECTOR_SIZE instead of 512 in iomap_page definition
Message-ID: <20191015161651.GG32665@bombadil.infradead.org>
References: <123556d7-968c-70a6-1049-38b2f279f5a1@redhat.com>
 <20191015155224.GA16024@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015155224.GA16024@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 08:52:24AM -0700, Christoph Hellwig wrote:
> On Tue, Oct 15, 2019 at 10:39:36AM -0500, Eric Sandeen wrote:
> > iomap_page_create() initializes the uptodate bitmap using the SECTOR_SIZE
> > macro, so use that in the definition as well, for consistency and safety.
> > 
> > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > ---
> > 
> > Last time there was a concern about pulling in blkdev.h just for this,
> > but that's already been done now, so try again.
> 
> Note that the iomap writepage series, which is hopefully about to be
> merged moves this declaration around.

... and the support-multiple-page-sizes patches make it dynamically
allocated ;-)
