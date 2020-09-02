Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E521425AEEB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgIBPbi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:31:38 -0400
Received: from verein.lst.de ([213.95.11.211]:32841 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbgIBPbf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:31:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4B24C68B05; Wed,  2 Sep 2020 17:31:30 +0200 (CEST)
Date:   Wed, 2 Sep 2020 17:31:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Denis Efremov <efremov@linux.com>,
        Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 05/19] swim: use bdev_check_media_change
Message-ID: <20200902153129.GA2304@lst.de>
References: <20200902141218.212614-1-hch@lst.de> <20200902141218.212614-6-hch@lst.de> <SN4PR0401MB359876A023673111737EB7BE9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB359876A023673111737EB7BE9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 02, 2020 at 03:30:14PM +0000, Johannes Thumshirn wrote:
> Looks good,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> > +static int floppy_revalidate(struct gendisk *disk);
> 
> Completely unrelated to this series but, this is the 3rd floppy 
> driver in the series defining it's own floppy_revalidate() and 
> naming it floppy_revalidate().
> 
> This makes grepping and reviewing a pain.

Yes, I noticed it as well.  They also use the floppy_ prefix for
various other methods.

> 
---end quoted text---
