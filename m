Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B2A1A4258
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 07:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgDJF6f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 01:58:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgDJF6f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 01:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tVDFAQy0GfDOukYPJW4ZPu7TUMtuz/n3F/EhfThjKv0=; b=dmUj16NDNtaJ2sI/r6Qbk7vQTc
        +QRQzA90XetTRqD1ZLa3ko4HkygAGd2x7Xaj0U963tJzZZGGJC1K+fC+UJs1nzLbS3FKkC9+zgQr7
        HGqOKA2T9BM6KgmPkGsLjId0S5ngSTrmUZIS8mM5+MNNG6958tOUQlhFkBUDFXakEN4uFwVwg6VTA
        o1T6EhrSp2gEw8UlxOaOGgsBPhXSJXzhxMY4sTygwTr1EESwsmZD5dV1rS5pO+lLUu6JzWPA6Ez2D
        WQGRL/PMWsQlZqObr7j1gAfA9YIATxQAVnd2n1DzarFh5A15t5BHcATm7DGgarGYmR3EaGlBJLsFy
        cBkCtfXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMmgU-00033Y-T6; Fri, 10 Apr 2020 05:58:34 +0000
Date:   Thu, 9 Apr 2020 22:58:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 06/10] scsi: export scsi_mq_free_sgtables
Message-ID: <20200410055834.GA4791@infradead.org>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
 <20200409165352.2126-7-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409165352.2126-7-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good, althrough we really don't need the extern for the
prototype in the header (that also applies to a few other patches in
the series):

Reviewed-by: Christoph Hellwig <hch@lst.de>
