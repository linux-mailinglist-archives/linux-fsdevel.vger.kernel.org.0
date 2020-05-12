Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA7B1CFA1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 18:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgELQEN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 12:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgELQEM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 12:04:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2AFC061A0C;
        Tue, 12 May 2020 09:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y7BSP3BlQ61Lb6dN81uzMsCFbdus5l/4uVt1/IWDFJo=; b=cKUpxpJ0u2DERhN04TX7WHJLSN
        FMUPWssMl6aaphrFgb4INIz6Z3m5iJegCgjSwBjUBQK6ZzSQpyK1PVNNoh+76wcuJsf9kZNIJUUPu
        Nc6NnaEuH3BCG9Hj+Rg4/306w2OrJqIzCIORyBK1VHJOiPss72MTmN6htGytW1LjJv62Sm5ArJlzE
        hlr8dxqdgfLLaRuXUqH840+kyAYq1mqskKo4GfXuYwEFI+egZ4+dS0578harKdIMSqthfxoXz5ys2
        3/dQMRQ7kOI2mxLVjgbicKxGbUkhNsOUgd5RY3UwOi8X9wjbBRV+9qJLbaI14VUid9vG2tFB1MHPd
        PV2CfNWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYXO6-00067e-3n; Tue, 12 May 2020 16:04:10 +0000
Date:   Tue, 12 May 2020 09:04:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v11 00/10] Introduce Zone Append for writing to zoned
 block devices
Message-ID: <20200512160410.GA22624@infradead.org>
References: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
 <20200512131748.GA15699@infradead.org>
 <yq14ksl2ldd.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq14ksl2ldd.fsf@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 09:01:18AM -0700, Martin K. Petersen wrote:
> I suspect this series going to clash with my sd revalidate surgery. I
> may have to stick that in a postmerge branch based on Jens' tree.

Where is that series?  I don't remember any changes in that area.

> 
> -- 
> Martin K. Petersen	Oracle Linux Engineering
---end quoted text---
