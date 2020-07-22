Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4ED2291AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 09:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbgGVHHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 03:07:08 -0400
Received: from verein.lst.de ([213.95.11.211]:55085 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgGVHHI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:07:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C926B6736F; Wed, 22 Jul 2020 09:07:03 +0200 (CEST)
Date:   Wed, 22 Jul 2020 09:07:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH 02/14] drbd: remove dead code in device_to_statistics
Message-ID: <20200722070703.GA25590@lst.de>
References: <20200722062552.212200-1-hch@lst.de> <20200722062552.212200-3-hch@lst.de> <SN4PR0401MB3598495DA5AF46CAF019BDC69B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598495DA5AF46CAF019BDC69B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 22, 2020 at 07:03:21AM +0000, Johannes Thumshirn wrote:
> On 22/07/2020 08:28, Christoph Hellwig wrote:
> > Ever since the switch to blk-mq, a lower device not use by VM
>                                            in-use/used? ~^

Yeah, this should be used.

> Also this looks like the last user of 'dev_lower_blocked' so it could
> be removed from device_statistics if it's not an ABI (not sure with this
> netlink stuff).

As far as I can tell this is a netlink user ABI.
