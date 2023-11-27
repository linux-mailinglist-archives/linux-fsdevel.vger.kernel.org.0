Return-Path: <linux-fsdevel+bounces-3870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4E07F9713
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 02:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBF31C20895
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 01:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB73139A;
	Mon, 27 Nov 2023 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D424AE8;
	Sun, 26 Nov 2023 17:13:52 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SdnfL40kBz4f3k6S;
	Mon, 27 Nov 2023 09:13:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 54F621A0C6B;
	Mon, 27 Nov 2023 09:13:49 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDX2hBD7WNlrI8oCA--.40143S3;
	Mon, 27 Nov 2023 09:13:42 +0800 (CST)
Subject: Re: [PATCH -next] block: remove field 'bd_inode' from block_device
To: Greg KH <gregkh@linuxfoundation.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, ming.lei@redhat.com, axboe@kernel.dk,
 roger.pau@citrix.com, colyli@suse.de, kent.overstreet@gmail.com,
 joern@lazybastard.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, sth@linux.ibm.com, hoeppner@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, clm@fb.com,
 josef@toxicpanda.com, dsterba@suse.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org, nico@fluxnic.net, xiang@kernel.org, chao@kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, agruenba@redhat.com, jack@suse.com,
 konishi.ryusuke@gmail.com, dchinner@redhat.com, linux@weissschuh.net,
 min15.li@samsung.com, dlemoal@kernel.org, willy@infradead.org,
 akpm@linux-foundation.org, p.raghav@samsung.com, hare@suse.de,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 gfs2@lists.linux.dev, linux-nilfs@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231125093912.141486-1-yukuai1@huaweicloud.com>
 <2023112544-subpanel-national-58e5@gregkh>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6ef798a6-8c0c-16b0-9991-b461258eb7d4@huaweicloud.com>
Date: Mon, 27 Nov 2023 09:13:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2023112544-subpanel-national-58e5@gregkh>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDX2hBD7WNlrI8oCA--.40143S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw48Jw4DZF43tw18tFWrKrg_yoW5ZFW8pr
	W3GFZ5AFyq9ry7uF4IqF1xXryrJ3Wku3y3JrySyw10vrWYvF12gryvyr93uFy8ZrZ7tr4j
	qF1aq34vkr18CrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j
	6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2023/11/25 22:32, Greg KH Ð´µÀ:
> On Sat, Nov 25, 2023 at 05:39:12PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> block_devcie is allocated from bdev_alloc() by bdev_alloc_inode(), and
>> currently block_device contains a pointer that point to the address of
>> inode, while such inode is allocated together:
>>
>> bdev_alloc
>>   inode = new_inode()
>>    // inode is &bdev_inode->vfs_inode
>>   bdev = I_BDEV(inode)
>>    // bdev is &bdev_inode->bdev
>>   bdev->inode = inode
>>
>> Add a new helper to get address of inode from bdev by add operation
>> instead of memory access, which is more efficiency. Also prepare to
>> add a new field 'bd_flags' in the first cacheline(64 bytes).
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/bdev.c                       | 39 +++++++++++++++++-------------
>>   block/blk-zoned.c                  |  4 +--
>>   block/fops.c                       |  4 +--
>>   block/genhd.c                      |  8 +++---
>>   block/ioctl.c                      |  8 +++---
>>   block/partitions/core.c            |  9 ++++---
>>   drivers/block/xen-blkback/xenbus.c |  2 +-
>>   drivers/md/bcache/super.c          |  2 +-
>>   drivers/mtd/devices/block2mtd.c    | 12 ++++-----
>>   drivers/s390/block/dasd_ioctl.c    |  2 +-
>>   drivers/scsi/scsicam.c             |  2 +-
>>   fs/bcachefs/util.h                 |  2 +-
>>   fs/btrfs/disk-io.c                 |  6 ++---
>>   fs/btrfs/volumes.c                 |  4 +--
>>   fs/btrfs/zoned.c                   |  2 +-
>>   fs/buffer.c                        |  8 +++---
>>   fs/cramfs/inode.c                  |  2 +-
>>   fs/erofs/data.c                    |  2 +-
>>   fs/ext4/dir.c                      |  2 +-
>>   fs/ext4/ext4_jbd2.c                |  2 +-
>>   fs/ext4/super.c                    |  8 +++---
>>   fs/gfs2/glock.c                    |  2 +-
>>   fs/gfs2/ops_fstype.c               |  2 +-
>>   fs/jbd2/journal.c                  |  3 ++-
>>   fs/jbd2/recovery.c                 |  2 +-
>>   fs/nilfs2/segment.c                |  2 +-
>>   include/linux/blk_types.h          | 10 ++++++--
>>   include/linux/blkdev.h             |  4 +--
>>   include/linux/buffer_head.h        |  4 +--
>>   29 files changed, 86 insertions(+), 73 deletions(-)
> 
> You should do this as a patch series, add the helper function that does
> nothing, convert all the different portions of the kernel as different
> patches, and _then_ change the implementation of the block layer to
> handle the change in the structure.
> 
> Otherwise this is going to be hard to get accepted.

Okay, thanks for the adivce, I'll do that in v2.

By the way, I was thinking that this patch is quite simple, and doesn't
worth spliting into 10+ patches,
> 
> Also, one note:
> 
>> @@ -85,6 +84,13 @@ struct block_device {
>>   #define bdev_kobj(_bdev) \
>>   	(&((_bdev)->bd_device.kobj))
>>   
>> +static inline struct inode *bdev_inode(struct block_device *bdev)
>> +{
>> +	void *inode = bdev + 1;
> 
> That's crazy, if something changes, this will keep working yet the
> kernel will break and no one will know why.
> 
> Please use container_of(), that's what it is there for, this exact type
> of thing.  Or if not, are you just assuming that the memory location
> right after bdev is the inode?  That's a tough assumption, how are you
> going to assure it really stays there?

Struct bdev_inode never changes since commit 8fbd544cbca5 ("[PATCH]
bdev: add I_BDEV()") from 2004, and I think it won't change unless
there is a different way to manage lifetime of block_device.

And the 'bdev + 1' is copied from blk_mq_rq_to_pdu(), however, I aggre
that use container_of() is better and I will use it in v2.

Thanks,
Kuai

> 
> thanks,
> 
> greg k-h
> .
> 


