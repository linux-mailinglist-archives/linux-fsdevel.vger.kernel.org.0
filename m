Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320242A9471
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 11:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgKFKhK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 05:37:10 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40078 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFKhJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604659029; x=1636195029;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=6ksMgc/F3G8qOPN4C4UCBkalYr5jkWPHCnOyOQwS1bc=;
  b=FpvSe7NbpYHqSvyiMaA1qJr7R0H0h/PNtrtDIvKJBExiaibVb/NBudJK
   KuZHlWSGeji3vs6zoNdA4wuzk8pJqjH+Z9nYopsa3q/AmZshuzziul+Z2
   I9oRU45crYIBtp+AfQKuV8aJZfc0W4gPQcM797Q7GMg4X31NGtAl8CHH6
   RqrMo4iQAvjZwQkkuZY2IsZzPZLk2c/pb61JBCK7nh7inpRgIkGAqkgVr
   kIIzRcxxPsSUU5ChtYDW/5wDVWEKVnuN/pmqVSDOWhOTTIxMX0HaXwfQ5
   NhVCflxL8FgyCET8LiH5EqtOJ6q/W5RUSrikntelgcB1KvqkA2LQv8zhr
   Q==;
IronPort-SDR: A4giQlcaNh5QWn0nAi0CZI18pZGZ5Rdct8iQtyghywuGFqbwdqswTvbVOR/Elmw5gbvq+85LlP
 LWVWtNBq/T8DZaStlx7YufPMlhsexdBXGQKui0sSJxnSq9zRzuApCK3g/FLoz8kpSqteOlMg9p
 Y/rpBguP0eZ6+TkfJgyDkHQW9bahonIMu0D4/etA8akn29fHISF054pcDEjzBzG25/xujYLhRy
 EWCTgyPt5Sz+53kGcOkflWAiFQaBylrCaA+wycvZNc/HIH2EM6gS16D8SgL00cGbBTglbI0BiA
 Taw=
X-IronPort-AV: E=Sophos;i="5.77,456,1596470400"; 
   d="scan'208";a="262014293"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2020 18:37:08 +0800
IronPort-SDR: VTGRSvGPIlmw6W0f83729dZsYm9b3arlQo44FgY6RqPBAyWH97XjBVSr80LM+/bacAYsh6ry06
 +xT0uaZhVMBa07XL+WZjasYYk29pgoTGTkZ5WpfTWnYcG+6YZL7nwSKhyl82N8z8MeVm1EUZMp
 8MqS/9Fk4piuWLBoziKQ2Y7eUYcNQYJqO+hUQXrgXp7RXXoYYnPOaCRu0uci1Dnxte8RQeJgNF
 3Cj/xGptqtVuEMtR0ElPPUI5vR63I98rBoUi6e0Lk8sb1HtAF1oNEQSBL2oLH8DbEViTSHlzf3
 qDUhX00TTthQXeLR/j+2Cv2s
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 02:22:01 -0800
IronPort-SDR: QMF2WcXsB1BJ/Nwr192UXy9evJTz8/2oBPbk16XrxZFC6Ob5oIZvWZojOLJR4fkTHX6A4zFMTN
 FBahhYn7FdwsnhG5O2kz5O6xyyHUyFVnUK/DWXJkN52CAo3cLgOTT4Yl79mZPkt+kh/ygMQvmm
 Wp9RVDUesJ9Ddnr9bQLGb4WBm8QdnC7wEon6XT0w9fQRyzHmnGyDd3G1Xbr+P7MwVqcn66KkIS
 Jo1UPEtiylc1Q8TDOM5iuHoUUUYGOt1mcvrReBfG+rZmS5ncVpnYdLefIHGNF6HT4rtboaehnT
 tDU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 06 Nov 2020 02:37:07 -0800
Received: (nullmailer pid 2000443 invoked by uid 1000);
        Fri, 06 Nov 2020 10:37:07 -0000
Date:   Fri, 6 Nov 2020 19:37:07 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        hare@suse.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 11/41] btrfs: implement log-structured superblock for
 ZONED mode
Message-ID: <20201106103707.m726huqfkfruoxdo@naota.dhcp.fujisawa.hgst.com>
References: <cover.1604065156.git.naohiro.aota@wdc.com>
 <eca26372a84d8b8ec2b59d3390f172810ed6f3e4.1604065695.git.naohiro.aota@wdc.com>
 <20201103141035.GZ6756@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201103141035.GZ6756@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 03:10:35PM +0100, David Sterba wrote:
>On Fri, Oct 30, 2020 at 10:51:18PM +0900, Naohiro Aota wrote:
>> Superblock (and its copies) is the only data structure in btrfs which has a
>> fixed location on a device. Since we cannot overwrite in a sequential write
>> required zone, we cannot place superblock in the zone. One easy solution is
>> limiting superblock and copies to be placed only in conventional zones.
>> However, this method has two downsides: one is reduced number of superblock
>> copies. The location of the second copy of superblock is 256GB, which is in
>> a sequential write required zone on typical devices in the market today.
>> So, the number of superblock and copies is limited to be two.  Second
>> downside is that we cannot support devices which have no conventional zones
>> at all.
>>
>> To solve these two problems, we employ superblock log writing. It uses two
>> zones as a circular buffer to write updated superblocks. Once the first
>> zone is filled up, start writing into the second buffer. Then, when the
>> both zones are filled up and before start writing to the first zone again,
>> it reset the first zone.
>>
>> We can determine the position of the latest superblock by reading write
>> pointer information from a device. One corner case is when the both zones
>> are full. For this situation, we read out the last superblock of each
>> zone, and compare them to determine which zone is older.
>>
>> The following zones are reserved as the circular buffer on ZONED btrfs.
>>
>> - The primary superblock: zones 0 and 1
>> - The first copy: zones 16 and 17
>> - The second copy: zones 1024 or zone at 256GB which is minimum, and next
>>   to it
>>
>> If these reserved zones are conventional, superblock is written fixed at
>> the start of the zone without logging.
>
>I don't have a clear picture here.
>
>In case there's a conventional zone covering 0 and 1st copy (64K and
>64M) it'll be overwritten. What happens for 2nd copy that's at 256G?
>sb-log?
>
>For all-sequential drive, the 0 and 1st copy are in the first zone.
>You say 0 and 1, but how come if the minimum zone size we ever expect is
>256M?

On zoned device, we always reserve the above zones (0, 1, 16, 17, 1024,
1025 (or zones at 256G)) regardless of it is sequential or conventional.
And, if the reserved zones is conventional, we write a superblock always at
the beginning of the reserved zone. So, if a drive have 32
conventional zones, superblocks are placed at the beginning of zone 0 and
zone 16. And, zone 1024 and 1025 are written with sb-log.

>
>The circular buffer comprises zones covering all superblock copies? I
>mean one buffer for 2 or more sb copies? The problem is that we'll have
>just one copy of the current superblock. Or I misunderstood.

A circular buffer consists with a pair of the zones, so we'll have three
sb-logs for each on zone pairs 0 & 1, zones 16 & 17, and 1024 & 1025.

>
>My idea is that we have primary zone, unfortunatelly covering 2
>superblocks but let it be. Second zone contains 2nd superblock copy
>(256G), we can assume that devices will be bigger than that.
>
>Then the circular buffers happen in each zone, so first one will go from
>offset 64K up to the zone size (256M or 1G).  Second zone rotates from
>offset 0 to end of the zone.
>
>The positive outcome of that is that both zones contain the latest
>superblock after succesful write and their write pointer is slightly out
>of sync, so they never have to be reset at the same time.
>
>In numbers:
>- first zone 64K .. 256M, 65520 superblocks
>- second zone 256G .. 245G+256M, 65536 superblocks
>
>The difference is 16 superblock updates, which should be enough to let
>the zone resets happen far apart.

Hmm, this makes the minimal FS size requirement to 256 GB to survive a
crash after resetting the first zone... So, that's why we have two zones as
a circular buffer.
