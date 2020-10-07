Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0316D285B81
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 11:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgJGJC4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 05:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgJGJC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 05:02:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFE2C061755;
        Wed,  7 Oct 2020 02:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5QC7k6EvX6qlS0uhkywbX+lj9lEfh/hB7JYRnRGAhSU=; b=Hj+FKeEn6eAmLS3TobSxVX+AXR
        8xGKRlxYQXixEBXF1tmpVjKRE8jOARDzIxyhWdTAELTTOxJ3e8sksDscUrU65jZ8NXyarD+S9lIZE
        dcCfUbPjRQR1Q6kWmRPjLjOVSGVGtrwo6i97QrybJNKxENnLzK6GHrbr0YaDMD0NI332f7+wgwPTR
        hPteIzys2jCjyX8lIzcrrsmFjcW5DeWsPcTMFjo5mkiGqn5EdRQ6Nh5UaLaJPGlVFPH7bUt+Scqp8
        S9QkTVDmnslpgIaiMsUku+8oYtCZHiwmPfHsVdDx81lnBQOGZsO0rbsigryhMQQyJi6+xzGDdZtnl
        O2rxZVxQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQ5LZ-0007kQ-4p; Wed, 07 Oct 2020 09:02:53 +0000
Date:   Wed, 7 Oct 2020 10:02:53 +0100
From:   "hch@infradead.org" <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: make maximum zone append size configurable
Message-ID: <20201007090253.GA29719@infradead.org>
References: <8fe2e364c4dac89e3ecd1234fab24a690d389038.1601993564.git.johannes.thumshirn@wdc.com>
 <CY4PR04MB375140F36014D95A7AA439A8E70D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20201007055024.GB16556@infradead.org>
 <CY4PR04MB375165E4F35DB78390ED5D84E70A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <SN4PR0401MB359836DA6CBC1D7590CFEAB99B0A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB359836DA6CBC1D7590CFEAB99B0A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 07, 2020 at 09:01:57AM +0000, Johannes Thumshirn wrote:
> Like this?

Yes, that looks perfect.
