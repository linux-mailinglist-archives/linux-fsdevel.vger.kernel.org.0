Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA42285EDC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 14:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgJGMOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 08:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgJGMOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:14:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72533C061755;
        Wed,  7 Oct 2020 05:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s4UilG6Sl2Rsfj9NHP9dIrdgWr3hqMiEJaDMFtsfOeU=; b=vCaRoH3tn+we2RmIkRug2tKA7V
        yRCG/6X1ujuxY30IUd97poAj2SRQHnub1blvHuy/far+tgDUqmR4VB+sQKZ0OzyTSMNawHo3bN/4n
        mW0wu9waYDLgmyIMH2VJTKEm85ACual/Jrj95MQdjfp0AzCVDU6CHYv33ZmbE2Tc9+/SukfVT4pqa
        6EuIRwfuXEgCqt0AiEC/sNKf3e301UkTttFJpGgWdyJ8IAnpHfM0sHumPrpUYO5LtqnVQPE9fFuz8
        DkIm9FlGcnaWHDjlaLKM349u6G4z3H7fgJ8cxaQwXnlonPeha/UbAE2b23B1GI5PI7JmKwUq/RhjO
        qGiE3oxw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQ8Ko-00029R-Ub; Wed, 07 Oct 2020 12:14:18 +0000
Date:   Wed, 7 Oct 2020 13:14:18 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: soft limit zone-append sectors as well
Message-ID: <20201007121418.GA8144@infradead.org>
References: <2358a1f93c2c2f9f7564eb77334a7ea679453deb.1602062387.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2358a1f93c2c2f9f7564eb77334a7ea679453deb.1602062387.git.johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 07, 2020 at 06:20:05PM +0900, Johannes Thumshirn wrote:
> Martin rightfully noted that for normal filesystem IO we have soft limits
> in place, to prevent them from getting too big and not lead to
> unpredictable latencies. For zone append we only have the hardware limit
> in place.
> 
> Cap the max sectors we submit via zone-append to the maximal number of
> sectors if the second limit is lower.
> 
> Link: https://lore.kernel.org/linux-btrfs/yq1k0w8g3rw.fsf@ca-mkp.ca.oracle.com
> Reported-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
