Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CAB1B37C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 08:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgDVGrh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 02:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgDVGrh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 02:47:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D034C03C1A6;
        Tue, 21 Apr 2020 23:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=XVDlIMDV3+CJFmB747dLXHJxJa
        0DPC6sne++CB6jKZk6/HMCsWl3shPuMTuB7+oyh2+Z9zEjQubnUAVmF9uKhx7Jk/tCfiesj4rA8gT
        3FGaJw2Y+kyHN0NzjvVeCn/MEHtL/9DDzSXzUySjJp86uuAznhXaFRHHiQRrU11y0iREf2EsyQ33J
        RrOUxzxTqGG0Y+TMorOLgwi/szqPJqCgRgnsz/bKnxx8Nu2GeNhfRMjHoZ4Ue1Th5GplxsmaJy2lt
        G6FGdiTvMsFooTGQi44rd60XjohndeFeVL0OgzfqIhFIYS50KVy57UhIckdEsRWSPbdjyVCSdYlUr
        CR5xftlg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR9AW-0007zM-J4; Wed, 22 Apr 2020 06:47:36 +0000
Date:   Tue, 21 Apr 2020 23:47:36 -0700
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
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v7 06/11] block: Modify revalidate zones
Message-ID: <20200422064736.GI20318@infradead.org>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
 <20200417121536.5393-7-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417121536.5393-7-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
