Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC934CF273
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 08:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbiCGHN1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 02:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbiCGHN1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:13:27 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D96A2BD5;
        Sun,  6 Mar 2022 23:12:32 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B69D810E1573;
        Mon,  7 Mar 2022 18:12:30 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nR7Xh-002VjO-1q; Mon, 07 Mar 2022 18:12:29 +1100
Date:   Mon, 7 Mar 2022 18:12:29 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Message-ID: <20220307071229.GR3927073@dread.disaster.area>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <20220304001022.GJ3927073@dread.disaster.area>
 <YiKOQM+HMZXnArKT@bombadil.infradead.org>
 <20220304224257.GN3927073@dread.disaster.area>
 <YiKY6pMczvRuEovI@bombadil.infradead.org>
 <20220305073321.5apdknpmctcvo3qj@ArmHalley.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220305073321.5apdknpmctcvo3qj@ArmHalley.localdomain>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6225b060
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=8nJEP1OIZ-IA:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8
        a=CKYOmrA5lEgVFmPlPJ4A:9 a=wPNLvfGTeEIA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 05, 2022 at 08:33:21AM +0100, Javier González wrote:
> On 04.03.2022 14:55, Luis Chamberlain wrote:
> > On Sat, Mar 05, 2022 at 09:42:57AM +1100, Dave Chinner wrote:
> > > On Fri, Mar 04, 2022 at 02:10:08PM -0800, Luis Chamberlain wrote:
> > > > On Fri, Mar 04, 2022 at 11:10:22AM +1100, Dave Chinner wrote:
> > > > > On Wed, Mar 02, 2022 at 04:56:54PM -0800, Luis Chamberlain wrote:
> > > > > > Thinking proactively about LSFMM, regarding just Zone storage..
> > > > > >
> > > > > > I'd like to propose a BoF for Zoned Storage. The point of it is
> > > > > > to address the existing point points we have and take advantage of
> > > > > > having folks in the room we can likely settle on things faster which
> > > > > > otherwise would take years.
> > > > > >
> > > > > > I'll throw at least one topic out:
> > > > > >
> > > > > >   * Raw access for zone append for microbenchmarks:
> > > > > >   	- are we really happy with the status quo?
> > > > > > 	- if not what outlets do we have?
> > > > > >
> > > > > > I think the nvme passthrogh stuff deserves it's own shared
> > > > > > discussion though and should not make it part of the BoF.
> > > > >
> > > > > Reading through the discussion on this thread, perhaps this session
> > > > > should be used to educate application developers about how to use
> > > > > ZoneFS so they never need to manage low level details of zone
> > > > > storage such as enumerating zones, controlling write pointers
> > > > > safely for concurrent IO, performing zone resets, etc.
> > > >
> > > > I'm not even sure users are really aware that given cap can be different
> > > > than zone size and btrfs uses zone size to compute size, the size is a
> > > > flat out lie.
> > > 
> > > Sorry, I don't get what btrfs does with zone management has anything
> > > to do with using Zonefs to get direct, raw IO access to individual
> > > zones.
> > 
> > You are right for direct raw access. My point was that even for
> > filesystem use design I don't think the communication is clear on
> > expectations. Similar computation need to be managed by fileystem
> > design, for instance.
> 
> Dave,
> 
> I understand that you point to ZoneFS for this. It is true that it was
> presented at the moment as the way to do raw zone access from
> user-space.
> 
> However, there is no users of ZoneFS for ZNS devices that I am aware of
> (maybe for SMR this is a different story).  The main open-source
> implementations out there for RocksDB that are being used in production
> (ZenFS and xZTL) rely on either raw zone block access or the generic
> char device in NVMe (/dev/ngXnY).

That's exactly the situation we want to avoid.

You're talking about accessing Zoned storage by knowing directly
about how the hardware works and interfacing directly with hardware
specific device commands.

This is exactly what is wrong with this whole conversation - direct
access to hardware is fragile and very limiting, and the whole
purpose of having an operating system is to abstract the hardware
functionality into a generally usable API. That way when something
new gets added to the hardware or something gets removed, the
applications don't because they weren't written with that sort of
hardware functionality extension in mind.

I understand that RocksDB probably went direct to the hardware
because, at the time, it was the only choice the developers had to
make use of ZNS based storage. I understand that.

However, I also understand that there are *better options now* that
allow applications to target zone storage in a way that doesn't
expose them to the foibles of hardware support and storage protocol
specifications and characteristics.

The generic interface that the kernel provides for zoned storage is
called ZoneFS. Forget about the fact it is a filesystem, all it
does is provide userspace with a named zone abstraction for a zoned
device: every zone is an append-only file.

That's what I'm trying to get across here - this whole discussion
about zone capacity not matching zone size is a hardware/
specification detail that applications *do not need to know about*
to use zone storage. That's something taht Zonefs can/does hide from
applications completely - the zone files behave exactly the same
from the user perspective regardless of whether the hardware zone
capacity is the same or less than the zone size.

Expanding access the hardware and/or raw block devices to ensure
userspace applications can directly manage zone write pointers, zone
capacity/space limits, etc is the wrong architectural direction to
be taking. The sort of *hardware quirks* being discussed in this
thread need to be managed by the kernel and hidden from userspace;
userspace shouldn't need to care about such wierd and esoteric
hardware and storage protocol/specification/implementation
differences.

IMO, while RocksDB is the technology leader for ZNS, it is not the
model that new applications should be trying to emulate. They should
be designed from the ground up to use ZoneFS instead of directly
accessing nvme devices or trying to use the raw block devices for
zoned storage. Use the generic kernel abstraction for the hardware
like applications do for all other things!

> This is because having the capability to do zone management from
> applications that already work with objects fits much better.

ZoneFS doesn't absolve applications from having to perform zone
management to pack it's objects and garbage collect stale storage
space.  ZoneFS merely provides a generic, file based, hardware
independent API for performing these zone management tasks.

> My point is that there is space for both ZoneFS and raw zoned block
> device. And regarding !PO2 zone sizes, my point is that this can be
> leveraged both by btrfs and this raw zone block device.

On that I disagree - any argument that starts with "we need raw
zoned block device access to ...." is starting from an invalid
premise. We should be hiding hardware quirks from userspace, not
exposing them further.

IMO, we want writing zone storage native applications to be simple
and approachable by anyone who knows how to write to append-only
files.  We do not want such applications to be limited to people who
have deep and rare expertise in the dark details of, say, largely
undocumented niche NVMe ZNS specification and protocol quirks.

ZoneFS provides us with a path to the former, what you are
advocating is the latter....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
