Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07678123F55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 07:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfLRGAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 01:00:37 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32327 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRGAh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 01:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576648836; x=1608184836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fSOC8DItLFC2k9tNIUo01mC1E+iJ6rdd7oR/An7kxGo=;
  b=Os/TrqohqktW1id67FUHS3VioMxrhACM0VSFirWvvTT1e3Pa9xBe20To
   uUT6v9ReR9bjRS3/X5MB2TArRO4PwJc7GFQQXU879qYYNJGilDprQq7/H
   eKiF+yIVWKNLBt7JbtQ+apgRQa0CbLdijrUalB5fBEejxeYIVgtMxXIEL
   H0r1bJa+Xqvh7ReYXbwpzzYQIhSCF+Ae+McyEUjbX9gm0rZ4ajvMExk2v
   ZoQnxsK5ZyugNW7uhMaeY4JtC0GnEYT+X4BY/Iyhumhw1QgJY2GuZ+4JO
   qJSs2eP0/drJegSc69sZVcws2s+6Juw9ig/7TZQSLJuAx5BYjS5ksAUz7
   g==;
IronPort-SDR: xDYB64wK9rr2XgQ+Oi+CrjuAV8KS9+uL8+kSzvz5qtOUX7T/4VK0Op3QP6YC0TijlHd6Fmwn/8
 aQDysYiru0JaqcMV8yr0KSo/RGB3SeWOe9cu/0VuEdpGbqj6Fwg29t8PpRt28qj3hM35wPwY25
 QKE08XUkHGmDd0YO9qaaaN+BjLLqrw6epyqaZsQzMKOEj76SmOvsMGqmImRA5jkZb1Q5bGBH9F
 ANfBwqsnDdXTOq7lbFdKZk2Q18rs0Ufos4oK9yCIe5jfBEedVh13MyH+tqLpkbsyY8Ttz2UI77
 wyA=
X-IronPort-AV: E=Sophos;i="5.69,328,1571673600"; 
   d="scan'208";a="126383091"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2019 14:00:36 +0800
IronPort-SDR: U/g4g3pcurrRCBMJ1cQ6iBnGwqxFPcMIqBmeMM1/MyytWOe5tj4hF6ifhar7hUyi0f6eEtEiTK
 sNJDj7mX+51yFeFKgdFo/8j0hDb9KBVCtoE9PdIt3finipb7Qn2u58JHDoZcfP3QxtZCCey1SU
 DtiGWIj1jHzxlHzo1I7/+t7Ovlrhxrk/mfw4y4I9ypRGlc30eCV6N/jYsDVW7VvfUDZcGuiBC7
 X7MPjR1fCz/FW8XnJhLMGgM0MrGK3DKNKUvtzaxFwtGrfU9LFjpqiAcJn3rjERhjZNutbahgqJ
 A4+FEKsDigS+RIqwbZSZvEAB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 21:54:59 -0800
IronPort-SDR: 7mrb9L1dQ23lJTAu2FJulnZL64qPqq2QEYxeVcawIXoIGSQrtjnJEuJWD3K0sn7aPV60trVh5i
 Cre24t9gx14azt7RqRhBxNPuc3MEP5CZU1yCGzdZ0NeNPW8cICrKyA21gTESCto1qBHEWqSYrU
 sqs8zlAMWwArVVLg1HP78nb9oeXnZ08ZgC5lEip5HMMd6zwZt/l9ICIlIMoKikG3q0KbcWvMaz
 FMFUWp30YLhl3giBxgtblv+9yYcVzUG/A01cQ42quILjcXdTA8OutiMHZgvYsTvQ4Z1sTXJdyM
 ZA8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with SMTP; 17 Dec 2019 22:00:34 -0800
Received: (nullmailer pid 877601 invoked by uid 1000);
        Wed, 18 Dec 2019 06:00:33 -0000
Date:   Wed, 18 Dec 2019 15:00:33 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 23/28] btrfs: support dev-replace in HMZONED mode
Message-ID: <20191218060033.ubfidtuhvzdbkk3o@naota.dhcp.fujisawa.hgst.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-24-naohiro.aota@wdc.com>
 <2157b1bb-a64b-eed3-0451-09a8480d0db2@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2157b1bb-a64b-eed3-0451-09a8480d0db2@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 04:05:25PM -0500, Josef Bacik wrote:
>On 12/12/19 11:09 PM, Naohiro Aota wrote:
>>We have two type of I/Os during the device-replace process. One is a I/O to
>>"copy" (by the scrub functions) all the device extents on the source device
>>to the destination device.  The other one is a I/O to "clone" (by
>>handle_ops_on_dev_replace()) new incoming write I/Os from users to the
>>source device into the target device.
>>
>>Cloning incoming I/Os can break the sequential write rule in the target
>>device. When write is mapped in the middle of a block group, that I/O is
>>directed in the middle of a zone of target device, which breaks the
>>sequential write rule.
>>
>>However, the cloning function cannot be simply disabled since incoming I/Os
>>targeting already copied device extents must be cloned so that the I/O is
>>executed on the target device.
>>
>>We cannot use dev_replace->cursor_{left,right} to determine whether bio is
>>going to not yet copied region.  Since we have time gap between finishing
>>btrfs_scrub_dev() and rewriting the mapping tree in
>>btrfs_dev_replace_finishing(), we can have newly allocated device extent
>>which is never cloned nor copied.
>>
>>So the point is to copy only already existing device extents. This patch
>>introduces mark_block_group_to_copy() to mark existing block group as a
>>target of copying. Then, handle_ops_on_dev_replace() and dev-replace can
>>check the flag to do their job.
>>
>>Device-replace process in HMZONED mode must copy or clone all the extents
>>in the source device exctly once.  So, we need to use to ensure allocations
>>started just before the dev-replace process to have their corresponding
>>extent information in the B-trees. finish_extent_writes_for_hmzoned()
>>implements that functionality, which basically is the removed code in the
>>commit 042528f8d840 ("Btrfs: fix block group remaining RO forever after
>>error during device replace").
>>
>>This patch also handles empty region between used extents. Since
>>dev-replace is smart to copy only used extents on source device, we have to
>>fill the gap to honor the sequential write rule in the target device.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>
>Can you split up the copying part and the cloning part into different 
>patches, this is a bear to review.  Also I don't quite understand the 
>zeroout behavior. It _looks_ like for cloning you are doing a zeroout 
>for the gap between the last wp position and the current cloned bio, 
>which makes sense, but doesn't this gap exist because copying is 
>ongoing?  Can you copy into a zero'ed out position?  Or am I missing 
>something here?  Thanks,
>
>Josef

OK, I will split this in the next version. (but, it's mostly "copying"
part)

Let me clarify first that I am using "copying" for copying existing
extents to the new device and "cloning" for cloning a new incoming BIO
to the new device.

For zeroout, it is for "copying" which is done with the scrub code to
copy existing extents on the source devie to the destination
device. Since copying or scrub only scans for living extents, there
can be a gap between two living extents. So, we need to fill a gap
with zeroout to make the writing stream sequential.

And "cloning" is only done for new block groups or already fully
copied block groups. So there is no gaps for them because the
allocator and the IO locks ensures the sequential allocation and
submit.

Thanks,
