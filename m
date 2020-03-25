Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 963091922FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 09:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgCYIkb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 04:40:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgCYIkb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h5hpNPfmMzO0qwGMReM4jVIBMBMcWpn40WL8el6WfJ4=; b=LmE+Tm3MJYRXXkp5z3JzAHVGuZ
        ffkeBa5uRK4MHD3ABne/71XmUAFBw0V6X6Hv0mXzXkKMnd7YLgOaTU7zJMx+X+tDr3z9rZBpHlR1z
        aKPebzJ25am4a5foJ+qm285MD4eXsZYsRX/UY8gKgLrncXGxWLrMfujvvz2lcZDW3xoiqeDioLuy1
        quXCUxq+ty/lG8giFZsvEERVF97LuFEVQ38+JLVFYOoidj3QKjnOvixkUceiljg5TqpephqA7sEPr
        TOzW9WWXN2UoAILIfw7LJ1/lSR3Wg+NTKpuhllCSbsovVVxFkL+xbOZyb5DtoybnqsJSHDdJu9NDg
        Z6k+BCcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH1aQ-0007C6-4n; Wed, 25 Mar 2020 08:40:30 +0000
Date:   Wed, 25 Mar 2020 01:40:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 01/11] block: factor out requeue handling from
 dispatch code
Message-ID: <20200325084030.GB11943@infradead.org>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
 <20200324152454.4954-2-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324152454.4954-2-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:24:44AM +0900, Johannes Thumshirn wrote:
> Factor out the requeue handling from the dispatch code, this will make
> subsequent addition of different requeueing schemes easier.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Jens, can you pick this up?  I think it already is a nice improvement
even without the rest of the series.
