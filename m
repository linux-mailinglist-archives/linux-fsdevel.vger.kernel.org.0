Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11F2A5946A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 08:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfF1GxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 02:53:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57060 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfF1GxA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:53:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S6ma39137515;
        Fri, 28 Jun 2019 06:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=QxpF7A7VqqYgUBiGg3AYtQoXMzS/FBMwBgDKlFdbQkU=;
 b=ITpBzfxGhhOymg0jtX5qWEr7fjEkdRmORNUhOC7/LII86xAnUYKLiSv7vH4cA66z1lsh
 JZCsbvCfY5l3b/UmtPZXSZzPriNh5Om5xS9z2yaqaohZucrwiiU54baHBc8izoNqYSO9
 Kv6powxhtMYdEXswjVTyXV22h7a+4Yhc5CzvT2+b8yhePlTVQhoo6zJYjnxlM5Y1q8QD
 aoq6CbloLKpyJElNgyxYYThFzvWkpo03SZFs4VeJ+H/tiJ9HVUhhzctZ2A0vROBWV8Nb
 6snchyjGAjpPmk2teWBJrjtUlmgY2JkO1ra6vbLE4WErZegECnUtKhtSkNa/vrBrYKTR sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t9brtky9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 06:52:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S6pxCh020750;
        Fri, 28 Jun 2019 06:52:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2t99f5dvq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 06:52:48 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5S6qkGM024129;
        Fri, 28 Jun 2019 06:52:46 GMT
Received: from dhcp-10-186-50-241.sg.oracle.com (/10.186.50.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 23:52:45 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 09/19] btrfs: limit super block locations in HMZONED mode
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <SN6PR04MB52315AB9E229D0BAAB930D5B8CFC0@SN6PR04MB5231.namprd04.prod.outlook.com>
Date:   Fri, 28 Jun 2019 14:52:40 +0800
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <57A75561-4582-4711-8A1E-1B45F673BF14@oracle.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-10-naohiro.aota@wdc.com>
 <0ca3c475-fe10-4135-ddc9-7a82cc966d9a@oracle.com>
 <SN6PR04MB52315AB9E229D0BAAB930D5B8CFC0@SN6PR04MB5231.namprd04.prod.outlook.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280077
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On 28 Jun 2019, at 2:39 PM, Naohiro Aota <Naohiro.Aota@wdc.com> wrote:
>=20
> On 2019/06/28 12:56, Anand Jain wrote:
>> On 7/6/19 9:10 PM, Naohiro Aota wrote:
>>> When in HMZONED mode, make sure that device super blocks are located =
in
>>> randomly writable zones of zoned block devices. That is, do not =
write super
>>> blocks in sequential write required zones of host-managed zoned =
block
>>> devices as update would not be possible.
>>=20
>>   By design all copies of SB must be updated at each transaction,
>>   as they are redundant copies they must match at the end of
>>   each transaction.
>>=20
>>   Instead of skipping the sb updates, why not alter number of
>>   copies at the time of mkfs.btrfs?
>>=20
>> Thanks, Anand
>=20
> That is exactly what the patched code does. It updates all the SB
> copies, but it just avoids writing a copy to sequential writing
> required zones. Mkfs.btrfs do the same. So, all the available SB
> copies always match after a transaction. At the SB location in a
> sequential write required zone, you will see zeroed region (in the
> next version of the patch series), but that is easy to ignore: it
> lacks even BTRFS_MAGIC.
>=20

 Right, I saw the related Btrfs-progs patches at a later time,
 there are piles of emails after a vacation.;-)

> The number of SB copy available on HMZONED device will vary
> by its zone size and its zone layout.


Thanks, Anand

> Thanks,
>=20
>>=20
>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>> ---
>>>   fs/btrfs/disk-io.c     | 11 +++++++++++
>>>   fs/btrfs/disk-io.h     |  1 +
>>>   fs/btrfs/extent-tree.c |  4 ++++
>>>   fs/btrfs/scrub.c       |  2 ++
>>>   4 files changed, 18 insertions(+)
>>>=20
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index 7c1404c76768..ddbb02906042 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -3466,6 +3466,13 @@ struct buffer_head =
*btrfs_read_dev_super(struct block_device *bdev)
>>>   	return latest;
>>>   }
>>>=20
>>> +int btrfs_check_super_location(struct btrfs_device *device, u64 =
pos)
>>> +{
>>> +	/* any address is good on a regular (zone_size =3D=3D 0) device =
*/
>>> +	/* non-SEQUENTIAL WRITE REQUIRED zones are capable on a zoned =
device */
>>> +	return device->zone_size =3D=3D 0 || =
!btrfs_dev_is_sequential(device, pos);
>>> +}
>>> +
>>>   /*
>>>    * Write superblock @sb to the @device. Do not wait for =
completion, all the
>>>    * buffer heads we write are pinned.
>>> @@ -3495,6 +3502,8 @@ static int write_dev_supers(struct =
btrfs_device *device,
>>>   		if (bytenr + BTRFS_SUPER_INFO_SIZE >=3D
>>>   		    device->commit_total_bytes)
>>>   			break;
>>> +		if (!btrfs_check_super_location(device, bytenr))
>>> +			continue;
>>>=20
>>>   		btrfs_set_super_bytenr(sb, bytenr);
>>>=20
>>> @@ -3561,6 +3570,8 @@ static int wait_dev_supers(struct btrfs_device =
*device, int max_mirrors)
>>>   		if (bytenr + BTRFS_SUPER_INFO_SIZE >=3D
>>>   		    device->commit_total_bytes)
>>>   			break;
>>> +		if (!btrfs_check_super_location(device, bytenr))
>>> +			continue;
>>>=20
>>>   		bh =3D __find_get_block(device->bdev,
>>>   				      bytenr / BTRFS_BDEV_BLOCKSIZE,
>>> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
>>> index a0161aa1ea0b..70e97cd6fa76 100644
>>> --- a/fs/btrfs/disk-io.h
>>> +++ b/fs/btrfs/disk-io.h
>>> @@ -141,6 +141,7 @@ struct extent_map *btree_get_extent(struct =
btrfs_inode *inode,
>>>   		struct page *page, size_t pg_offset, u64 start, u64 len,
>>>   		int create);
>>>   int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);
>>> +int btrfs_check_super_location(struct btrfs_device *device, u64 =
pos);
>>>   int __init btrfs_end_io_wq_init(void);
>>>   void __cold btrfs_end_io_wq_exit(void);
>>>=20
>>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>>> index 3d41d840fe5c..ae2c895d08c4 100644
>>> --- a/fs/btrfs/extent-tree.c
>>> +++ b/fs/btrfs/extent-tree.c
>>> @@ -267,6 +267,10 @@ static int exclude_super_stripes(struct =
btrfs_block_group_cache *cache)
>>>   			return ret;
>>>   	}
>>>=20
>>> +	/* we won't have super stripes in sequential zones */
>>> +	if (cache->alloc_type =3D=3D BTRFS_ALLOC_SEQ)
>>> +		return 0;
>>> +
>>>   	for (i =3D 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
>>>   		bytenr =3D btrfs_sb_offset(i);
>>>   		ret =3D btrfs_rmap_block(fs_info, cache->key.objectid,
>>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>>> index f7b29f9db5e2..36ad4fad7eaf 100644
>>> --- a/fs/btrfs/scrub.c
>>> +++ b/fs/btrfs/scrub.c
>>> @@ -3720,6 +3720,8 @@ static noinline_for_stack int =
scrub_supers(struct scrub_ctx *sctx,
>>>   		if (bytenr + BTRFS_SUPER_INFO_SIZE >
>>>   		    scrub_dev->commit_total_bytes)
>>>   			break;
>>> +		if (!btrfs_check_super_location(scrub_dev, bytenr))
>>> +			continue;
>>>=20
>>>   		ret =3D scrub_pages(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, =
bytenr,
>>>   				  scrub_dev, BTRFS_EXTENT_FLAG_SUPER, =
gen, i,
>>>=20
>>=20
>>=20
>=20

