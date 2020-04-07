Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588E01A1236
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 18:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDGQyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 12:54:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42440 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgDGQyU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xyvC0zHB9QmZ9Gh+rPLMD8+WbkHV9x5ewqL8s/T8/mI=; b=V37nCWQbGr6w7MZg0X96KWeXpx
        LJXSRc8J2WYkKuqWj/RyGZl0uNrNQJxryUBpfZ2A1fq/Rgm6KSsLGuzQ6mb8YkjDN2et7eQ6ihNoK
        zLMgGrDR+qzRIpmPGDldEi6Z1lQl6TCrzgk7mx/0SZGmUCam+tkunQlfc36spfaX7l9cqVddwBwjx
        OLzwOW3aqPL+1c5WN/YbODSJzglEg30k+HgqSakKi4D0vepTEK8meAa4PAXz/kmOsH/AdiV3D+LCC
        ietfoy6x2zYgqqj/hvS4mnN5muvghIzz6+reZx09pGsb1l8VUStqhqr5eAY8diS6z1BisTBq1crGm
        SCyQLY6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLrUR-0008LT-Ux; Tue, 07 Apr 2020 16:54:19 +0000
Date:   Tue, 7 Apr 2020 09:54:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 03/10] block: introduce blk_req_zone_write_trylock
Message-ID: <20200407165419.GD13893@infradead.org>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
 <20200403101250.33245-4-johannes.thumshirn@wdc.com>
 <20200407165350.GC13893@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407165350.GC13893@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 07, 2020 at 09:53:50AM -0700, Christoph Hellwig wrote:
> So this new callback is exectured just before blk_revalidate_zone_cb
> returns and thus control is transferred back to the driver.  What
> speaks against just implementing this logic after the callback returns?
> ->report_zones is not just called for validation, but does that matter?
> If yes we can pass a flag, which still seems a bit better than a
> code flow with multiple callbacks.

Sorry, that reply should have been for the next patch.
