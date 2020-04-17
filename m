Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9231AE1CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 18:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgDQQEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 12:04:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54003 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729704AbgDQQEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:04:23 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03HG3Q4N001660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 12:03:27 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3F88342013D; Fri, 17 Apr 2020 12:03:26 -0400 (EDT)
Date:   Fri, 17 Apr 2020 12:03:26 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
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
Subject: Re: [PATCH v7 00/11] Introduce Zone Append for writing to zoned
 block devices
Message-ID: <20200417160326.GK5187@mit.edu>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 17, 2020 at 09:15:25PM +0900, Johannes Thumshirn wrote:
> The upcoming NVMe ZNS Specification will define a new type of write
> command for zoned block devices, zone append.
> 
> When when writing to a zoned block device using zone append, the start
> sector of the write is pointing at the start LBA of the zone to write to.
> Upon completion the block device will respond with the position the data
> has been placed in the zone. This from a high level perspective can be
> seen like a file system's block allocator, where the user writes to a
> file and the file-system takes care of the data placement on the device.

What sort of reordering can take place due to I/O schedulers and or
racing write appends from different CPU's?  Is it purely the
userspace's responsibility to avoid racings writes to a particular
zone?

						- Ted
