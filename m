Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB144A9CA1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 17:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376348AbiBDQBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 11:01:47 -0500
Received: from verein.lst.de ([213.95.11.211]:41815 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231664AbiBDQBq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:01:46 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9C75E68AA6; Fri,  4 Feb 2022 17:01:40 +0100 (CET)
Date:   Fri, 4 Feb 2022 17:01:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
Message-ID: <20220204160140.GA6817@lst.de>
References: <20220203153843.szbd4n65ru4fx5hx@garbanzo> <CGME20220203165248uscas1p1f0459e548743e6be26d13d3ed8aa4902@uscas1p1.samsung.com> <20220203165238.GA142129@dhcp-10-100-145-180.wdc.com> <20220203195155.GB249665@bgt-140510-bm01> <863d85e3-9a93-4d8c-cf04-88090eb4cc02@nvidia.com> <2bbed027-b9a1-e5db-3a3d-90c40af49e09@opensource.wdc.com> <9d5d0b50-2936-eac3-12d3-a309389e03bf@nvidia.com> <20220204082445.hczdiy2uhxfi3x2g@ArmHalley.local> <4d5410a5-93c3-d73c-6aeb-2c1c7f940963@nvidia.com> <befa49b3-7606-a3ce-24f7-e184e3df41a3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <befa49b3-7606-a3ce-24f7-e184e3df41a3@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 04, 2022 at 03:15:02PM +0100, Hannes Reinecke wrote:
>> ZNS kernel code testing is also done on QEMU, I've also fixed
>> bugs in the ZNS kernel code which are discovered on QEMU and I've not
>> seen any issues with that. Given that simple copy feature is way smaller
>> than ZNS it will less likely to suffer from slowness and etc (listed
>> above) in QEMU.
>>
>> my point is if we allow one, we will be opening floodgates and we need
>> to be careful not to bloat the code unless it is _absolutely
>> necessary_ which I don't think it is based on the simple copy
>> specification.
>>
>
> I do have a slightly different view on the nvme target code; it should 
> provide the necessary means to test the nvme host code.
> And simple copy is on of these features, especially as it will operate as 
> an exploiter of the new functionality.

Well, in general I'd like to have every useful feature supported in
nvmet, because it serves both testing and production.  If a feature
isn't all that useful (and there are lots of those in nvme these days)
we don't need to support in nvmet, but probably neither in the host code.
