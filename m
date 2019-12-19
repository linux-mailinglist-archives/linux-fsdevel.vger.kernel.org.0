Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB16125BA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 07:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfLSGzB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 01:55:01 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45198 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfLSGzB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 01:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576738500; x=1608274500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L+ilHZYja3Uqxdg3nCQXwKyTdE3PSSxtheSKQrT27+8=;
  b=doXKsLXUXdeOv2YontQZwTWsnedEfBYgV2NDxC/k3ZKFlNia3inVs5pV
   RliLydKgBKad1muaQWCUrfbVdnsG+CcPMvP/WvpBJqckJlTzU+tv1lpsz
   QsMJ8L0BrcFEgCsOPnOs9HQ2/VwqKpZ6C8C44IZEXFYk3dECiXnzMg4J3
   cJOT04xaBoyr7xPBIdq9G/YGmL8khLUeU4l3S+jE5V8DhakaNHaBz2IJe
   9fxvD062SGudB3R7W6GBsjTFy0ykjisRSii6PAd61d3IpjJ7ZxsV9gOOm
   Q9G8fGp+/v6kOxiEeX3iv5y3JC1up4P2NYW/mKvfa+d09AML5BxRhrH4m
   Q==;
IronPort-SDR: cJcysuiOas5ZEWlPCr9ljWtWQNZ94wX0m8/1K2xOsy3wugh59lLGRosWj9Zd9Y9f/mWJ4iPtJR
 sN0x9sUvbdBQV560zlf+DaaZ1qmWXaF6HQl9+Y6DNYhHO6h32QzeWjXrWKgwtiCRFgpUR5B4PU
 4uQjBUfbq1lN8o4b8gnsj3Z6Y8QpAWM3IYVaS2LU/CVgfAZRMoY108GogFRrN+Hl6qUZQkRd2B
 IDpgx98Tyi8GXmmDnPxqol/XrdgQkHBwdAleG1HMlSVuX6SupJazMvhLH4GuYZ+9wzs0Lxhc51
 NzM=
X-IronPort-AV: E=Sophos;i="5.69,330,1571673600"; 
   d="scan'208";a="127312665"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2019 14:55:00 +0800
IronPort-SDR: diTOML4Mg8aYTqVZ4ef28LUo5gzGXuxgVdvO1K/8AAlTW3T3NB0cVMdK4R+rqiT+r9Uhp85Lb0
 T5IIowAv6QAebQyMx7UsaB5hBMrcUThVo15RveUpRJUuiKPSF7kzYK7aAKygDnKyQE+2rWc2hX
 Er4eGEISWJdCcpJGpekREXuZoG9o+bn9AoLR8IHvRv990PAn27TeOBa74yGfl2IZ4yp07iHimK
 rOKDY/4taBHDQCfVXK8qlpqcyKeUhEFhIbweN3+wew1imUHLlAADDeXeFqhv6xtpWPMgJGl1QM
 FH04t0w+Q8LafxzsDw/mxT/W
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 22:49:00 -0800
IronPort-SDR: Tk/Rr6/fI21CpFaZNHMbGcP56TOuiEtHBiiV+d2jhY/u5GJcxFjsOfldC91zssPm0f0Ap9ZUPU
 JXAMYkvpJ+LqUk6AP9SwcvFu6ur90et/S72rbLSJ4CV+Kn8Q2C4hGiipZO6OzWipdLUrjTuH4x
 VhFDEkQOwMShzwdUBJR/aUXbiyl0xl+e2LA7YzRRx0Hx7wTyqmqQEo1GNUnrYgu+Hf6ePz+Xv9
 I7RtfNv13F/1usiPv7+ZVOnmj5eMhMqDpULc4dfWv7QLJi8J25LsAsGqzjiB7WhsGtQBn2QyjF
 nTQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with SMTP; 18 Dec 2019 22:54:58 -0800
Received: (nullmailer pid 2722299 invoked by uid 1000);
        Thu, 19 Dec 2019 06:54:57 -0000
Date:   Thu, 19 Dec 2019 15:54:57 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 15/28] btrfs: serialize data allocation and submit IOs
Message-ID: <20191219065457.rhd4wcycylii33c3@naota.dhcp.fujisawa.hgst.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-16-naohiro.aota@wdc.com>
 <b11ca55e-adb6-6aa7-4494-cffafedb487f@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b11ca55e-adb6-6aa7-4494-cffafedb487f@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 02:49:44PM -0500, Josef Bacik wrote:
>On 12/12/19 11:09 PM, Naohiro Aota wrote:
>>To preserve sequential write pattern on the drives, we must serialize
>>allocation and submit_bio. This commit add per-block group mutex
>>"zone_io_lock" and find_free_extent_zoned() hold the lock. The lock is kept
>>even after returning from find_free_extent(). It is released when submiting
>>IOs corresponding to the allocation is completed.
>>
>>Implementing such behavior under __extent_writepage_io() is almost
>>impossible because once pages are unlocked we are not sure when submiting
>>IOs for an allocated region is finished or not. Instead, this commit add
>>run_delalloc_hmzoned() to write out non-compressed data IOs at once using
>>extent_write_locked_rage(). After the write, we can call
>>btrfs_hmzoned_data_io_unlock() to unlock the block group for new
>>allocation.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>
>Have you actually tested these patches with lock debugging on?  The 
>submit_compressed_extents stuff is async, so the unlocker owner will 
>not be the lock owner, and that'll make all sorts of things blow up.  
>This is just straight up broken.

Yes, I have ran xfstests on this patch series with lockdeps and
KASAN. There was no problem with that.

For non-compressed writes, both allocation and submit is done in
run_delalloc_zoned(). Allocation is done in cow_file_range() and
submit is done in extent_write_locked_range(), so both are in the same
context, so both locking and unlocking are done by the same execution
context.

For compressed writes, again, allocation/lock is done under
cow_file_range() and submit is done in extent_write_locked_range() and
unlocked all in submit_compressed_extents() (this is called after
compression), so they are all in the same context and the lock owner
does the unlock.

>I would really rather see a hmzoned block scheduler that just doesn't 
>submit the bio's until they are aligned with the WP, that way this 
>intellligence doesn't have to be dealt with at the file system layer.  
>I get allocating in line with the WP, but this whole forcing us to 
>allocate and submit the bio in lock step is just nuts, and broken in 
>your subsequent patches.  This whole approach needs to be reworked.  
>Thanks,
>
>Josef

We tried this approach by modifying mq-deadline to wait if the first
queued request is not aligned at the write pointer of a zone. However,
running btrfs without the allocate+submit lock with this modified IO
scheduler did not work well at all. With write intensive workloads, we
observed that a very long wait time was very often necessary to get a
fully sequential stream of requests starting at the write pointer of a
zone. The wait time we observed was sometimes in larger than 60 seconds,
at which point we gave up.

While we did not extensively dig into the fundamental root cause,
these potentially long wait times can come from a large number of
reasons: page cache writeback behavior, kernel process scheduling,
device IO congestion and writeback throttling, sync, transaction
commit of btrfs, and cgroup use could make everything even worse. In
the worst case scenario, a number of out-of-ordered requests could get
stuck in the IO scheduler, preventing forward progress in the case of
a memory reclaim writeback, causing the OOM killer to start happily
killing application processes. Furthermore, IO error handling becomes
a nightmare as the block layer scheduler would need to issue report
zones commands to re-sync the zone wp in case of write error. And that
is also in addition to having to track other zone commands that change
a zone wp such as reset zone and finish zone.

Considering all this, handling the sequential write constraint at the
file system layer by ensuring that write BIOs are issued in the correct
order starting from a zone WP is far simpler and removes dependencies on
other features such as cgroup, congestion control and other throttling
mechanisms. The IO scheduler can always dispatch to the device the
requests it received without any waiting time, ensuring forward progress.

The mq-deadline IO scheduler supports not only regular block devices but
also zoned block devices and it is the default scheduler for them, and
other schedulers that are not zone compliant cannot be selected (one
cannot change to kyber nor bfq). This ensure that the default system
behavior will be correct as long as the user (the FS) respects the
sequential write rule.

The previous approach I proposed using a btrfs request reordering stage
was indeed very invasive, and similarly the block layer scheduler
changes, could cause problems with cgroups etc. The new approach of this
path using locking to have atomic allocate+bio issuing results in
per-zone sequential write patterns, no matter what happens around it. It
is less invasive and rely on the sequential allocation of blocks for the
ordering of write IOs, so there is no explicit reordering, so no
additional overhead. f2fs implementation uses a similar approach since
kernel 4.10 and has proven to be very solid.

In light of these arguments and explanation, do you still think the
allocate zone locking approach is still not acceptable ?
