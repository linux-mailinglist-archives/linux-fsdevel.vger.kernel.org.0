Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07BDFD7A87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 17:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbfJOPwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 11:52:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbfJOPwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wGs4rPfPy9vZBUIIyWospwNFjdTYCGPuvjv05Sr6wcs=; b=mI1Hg2GGevOaJcrCtNQ5hSJQM
        u5448CKfxFVyOczflX9z07FwUZNalkHG5GLxN9hTF1AFswRx1SOOJC0RUS+SknltZWeOCiCkaGG31
        HgBDnH0By9XsD5IZLGx7uNehkFAVo0Dg0mlpy11oQC11ZjKdplFjXAAfH7mwvnupUbmXKqi+3XVRb
        6vUbwphgCbPEW+UFc5EptbJeaOT9CSPe5Li5FCT5z6WQztBAR0yvhCbK5v1eCT885ajS2FFzCL9x/
        BDrZed28Z/+D7m83fLHmjiLH2ew2gviDPSy4oUU8Z4Ne4xyC/VT2cwzeUET0G7BOx7zTaQgxhMwxJ
        Jm5FqLs0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKP7Y-0004ZN-QE; Tue, 15 Oct 2019 15:52:24 +0000
Date:   Tue, 15 Oct 2019 08:52:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: iomap: use SECTOR_SIZE instead of 512 in iomap_page definition
Message-ID: <20191015155224.GA16024@infradead.org>
References: <123556d7-968c-70a6-1049-38b2f279f5a1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <123556d7-968c-70a6-1049-38b2f279f5a1@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:39:36AM -0500, Eric Sandeen wrote:
> iomap_page_create() initializes the uptodate bitmap using the SECTOR_SIZE
> macro, so use that in the definition as well, for consistency and safety.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> Last time there was a concern about pulling in blkdev.h just for this,
> but that's already been done now, so try again.

Note that the iomap writepage series, which is hopefully about to be
merged moves this declaration around.
