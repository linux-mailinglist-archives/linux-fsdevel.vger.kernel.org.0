Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2DA1663CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 18:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgBTRE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 12:04:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19544 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728336AbgBTRE5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:04:57 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KH1BYN178815
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 12:04:56 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ucn9w53-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 12:04:54 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 20 Feb 2020 17:04:25 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Feb 2020 17:04:22 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01KH36VG59768906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 17:03:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDFD45204F;
        Thu, 20 Feb 2020 17:03:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.92.174])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 80C3E52051;
        Thu, 20 Feb 2020 17:03:04 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [RFCv2 0/4] ext4: bmap & fiemap conversion to use iomap
To:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        cmaiolino@redhat.com
References: <cover.1580121790.git.riteshh@linux.ibm.com>
 <20200130160018.GC3445353@magnolia>
 <20200205124750.AE9DDA404D@d06av23.portsmouth.uk.ibm.com>
 <20200205155733.GH6874@magnolia>
 <20200206052619.D4BBCA405F@b06wcsmtp001.portsmouth.uk.ibm.com>
 <20200206102254.GK14001@quack2.suse.cz>
Date:   Thu, 20 Feb 2020 22:33:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200206102254.GK14001@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022017-0008-0000-0000-00000354D537
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022017-0009-0000-0000-00004A75E5DE
Message-Id: <20200220170304.80C3E52051@d06av21.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_04:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200126
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/6/20 3:52 PM, Jan Kara wrote:
> On Thu 06-02-20 10:56:18, Ritesh Harjani wrote:
>>
>>
>> On 2/5/20 9:27 PM, Darrick J. Wong wrote:
>>> On Wed, Feb 05, 2020 at 06:17:44PM +0530, Ritesh Harjani wrote:
>>>>
>>>>
>>>> On 1/30/20 11:04 PM, Ritesh Harjani wrote:
>>>>>
>>>>>
>>>>> On 1/30/20 9:30 PM, Darrick J. Wong wrote:
>>>>>> On Tue, Jan 28, 2020 at 03:48:24PM +0530, Ritesh Harjani wrote:
>>>>>>> Hello All,
>>>>>>>
>>>>>>> Background
>>>>>>> ==========
>>>>>>> There are RFCv2 patches to move ext4 bmap & fiemap calls to use
>>>>>>> iomap APIs.
>>>>>>> This reduces the users of ext4_get_block API and thus a step
>>>>>>> towards getting
>>>>>>> rid of buffer_heads from ext4. Also reduces a lot of code by
>>>>>>> making use of
>>>>>>> existing iomap_ops (except for xattr implementation).
>>>>>>>
>>>>>>> Testing (done on ext4 master branch)
>>>>>>> ========
>>>>>>> 'xfstests -g auto' passes with default mkfs/mount configuration
>>>>>>> (v/s which also pass with vanilla kernel without this patch). Except
>>>>>>> generic/473 which also failes on XFS. This seems to be the test
>>>>>>> case issue
>>>>>>> since it expects the data in slightly different way as compared
>>>>>>> to what iomap
>>>>>>> returns.
>>>>>>> Point 2.a below describes more about this.
>>>>>>>
>>>>>>> Observations/Review required
>>>>>>> ============================
>>>>>>> 1. bmap related old v/s new method differences:-
>>>>>>>       a. In case if addr > INT_MAX, it issues a warning and
>>>>>>>          returns 0 as the block no. While earlier it used to return the
>>>>>>>          truncated value with no warning.
>>>>>>
>>>>>> Good...
>>>>>>
>>>>>>>       b. block no. is only returned in case of iomap->type is
>>>>>>> IOMAP_MAPPED,
>>>>>>>          but not when iomap->type is IOMAP_UNWRITTEN. While with
>>>>>>> previously
>>>>>>>          we used to get block no. for both of above cases.
>>>>>>
>>>>>> Assuming the only remaining usecase of bmap is to tell old bootloaders
>>>>>> where to find vmlinuz blocks on disk, I don't see much reason to map
>>>>>> unwritten blocks -- there's no data there, and if your bootloader writes
>>>>>> to the filesystem(!) then you can't read whatever was written there
>>>>>> anyway.
>>>>>
>>>>> Yes, no objection there. Just wanted to get it reviewed.
>>>>>
>>>>>
>>>>>>
>>>>>> Uh, can we put this ioctl on the deprecation list, please? :)
>>>>>>
>>>>>>> 2. Fiemap related old v/s new method differences:-
>>>>>>>       a. iomap_fiemap returns the disk extent information in exact
>>>>>>>          correspondence with start of user requested logical
>>>>>>> offset till the
>>>>>>>          length requested by user. While in previous implementation the
>>>>>>>          returned information used to give the complete extent
>>>>>>> information if
>>>>>>>          the range requested by user lies in between the extent mapping.
>>>>>>
>>>>>> This is a topic of much disagreement.  The FIEMAP documentation says
>>>>>> that the call must return data for the requested range, but *may* return
>>>>>> a mapping that extends beyond the requested range.
>>>>>>
>>>>>> XFS (and now iomap) only return data for the requested range, whereas
>>>>>> ext4 has (had?) the behavior you describe.  generic/473 was an attempt
>>>>>> to enforce the ext4 behavior across all filesystems, but I put it in my
>>>>>> dead list and never run it.
>>>>>>
>>>>>> So it's a behavioral change, but the new behavior isn't forbidden.
>>>>>
>>>>> Sure, thanks.
>>>>>
>>>>>>
>>>>>>>       b. iomap_fiemap adds the FIEMAP_EXTENT_LAST flag also at the last
>>>>>>>          fiemap_extent mapping range requested by the user via fm_length (
>>>>>>>          if that has a valid mapped extent on the disk).
>>>>>>
>>>>>> That sounds like a bug.  _LAST is supposed to be set on the last extent
>>>>>> in the file, not the last record in the queried dataset.
>>>>>
>>>>> Thought so too, sure will spend some time to try fixing it.
>>>>
>>>> Looked into this. I think below should fix our above reported problem with
>>>> current iomap code.
>>>> If no objection I will send send PATCHv3 with below fix as the first
>>>> patch in the series.
>>>>
>>>> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
>>>> index bccf305ea9ce..ee53991810d5 100644
>>>> --- a/fs/iomap/fiemap.c
>>>> +++ b/fs/iomap/fiemap.c
>>>> @@ -100,7 +100,12 @@ int iomap_fiemap(struct inode *inode, struct
>>>> fiemap_extent_info *fi,
>>>>           }
>>>>
>>>>           if (ctx.prev.type != IOMAP_HOLE) {
>>>> -               ret = iomap_to_fiemap(fi, &ctx.prev, FIEMAP_EXTENT_LAST);
>>>> +               u32 flags = 0;
>>>> +               loff_t isize = i_size_read(inode);
>>>> +
>>>> +               if (ctx.prev.offset + ctx.prev.length >= isize)
>>>
>>> What happens if ctx.prev actually is the last iomap in the file, but
>>> isize extends beyond that?  e.g.,
>>>
>>> # xfs_io -f -c 'pwrite 0 64k' /a
>>> # truncate -s 100m /a
>>> # filefrag -v /a
>>
>> Err.. should never miss this truncate case.
>>
>> Digging further, I see even generic_block_fiemap() does not take care of
>> this case if the file isize is extended by truncate.
>> It happens to mark _LAST only based on i_size_read(). It seems only ext*
>> family and hpfs filesystem seems to be using this currently.
>> And gfs2 was the user of this api till sometime back before it finally
>> moved to use iomap_fiemap() api.
>>
>>
>>>
>>> I think we need the fiemap variant of the iomap_begin functions to pass
>>> a flag in the iomap that the fiemap implementation can pick up.
>>
>> Sure, let me do some digging on this one. One challenge which I think would
>> be for filesystems to tell *efficiently* on whether this is the
>> last extent or not (without checking on every iomap_begin call about,
>> if there exist a next extent on the disk by doing more I/O - that's why
>> *efficiently*).
>>
>> If done then -
>> we could use IOMAP_FIEMAP as the flag to pass to iomap_begin functions
>> and it could return us the iomap->type marked with IOMAP_EXTENT_LAST which
>> could represent that this is actually the last extent on disk for
>> this inode.
> 
> So I think IOMAP_EXTENT_LAST should be treated as an optional flag. If the
> fs can provide it in a cheap way, do so. Otherwise don't bother. Because
> ultimately, the FIEMAP caller has to deal with not seeing IOMAP_EXTENT_LAST
> anyway (e.g. if the file has no extents or if someone modifies the file
> between the calls). So maybe we need to rather update the documentation
> that the IOMAP_EXTENT_LAST is best-effort only?
> 

So I was making some changes along the above lines and I think we can 
take below approach for filesystem which could determine the
_EXTENT_LAST relatively easily and for cases if it cannot
as Jan also mentioned we could keep the current behavior as is and let
iomap core decide the last disk extent.

For this -
1. We could use IOMAP_FIEMAP flag approach to pass this flag to 
->iomap_begin fs functions. But we also will need
IOMAP_F_EXTENT_LAST & IOMAP_F_EXTENT_NOT_LAST flag for filesystem
to tell that whether this is the last extent or not.
IOMAP_F_EXTENT_NOT_LAST is also needed so that FS can tell to iomap
that the FS is capable of letting the iomap core know that whether
it is the last extent or not. If this is not specified then iomap core
will retain it's current behavior to mark FIEMAP_EXTENT_LAST.

Now in this case for ext4 we could simply call ext4_map_blocks second
time with the next lblk to map to see if there exist a next mapping or
any hole. Here again if the next lblk is a hole which is less
the INT_MAX blocks then again it will mean that the current is not the
last extent mapping. With that we could determine if the current mapping
is the last extent mapping or not.

In case of non-extent based mapping, we still may not be able to detect
the last disk block very easily. Because ext4_map_blocks may just give
mapping upto the next direct block.
(e.g. in case if the file is data followed by a hole - case described
by Darrick above)
I see generic_block_fiemap also does not detect the last block mapping
correctly and relies on i_size_read(inode) for that.

So to keep the ext4_fiemap behavior same when
moving to iomap framework, we can make the above changes where in
_EXTENT_LAST will be mainly set by FS for extent based mapping and for 
non-extent it will let the iomap current code determine last mapped
extent/block.

But - as per Jan in above comment, if the caller anyways have to always
determine that whether it is the last extent or not, then I am not sure
whether we should add this extra complexity or not, but I guess
this should be mainly so that the current behavior of ext4_fiemap should 
not change while moving to iomap. Your thoughts pls?


Raw version of ext4_iomap_begin_report implementation to determine last 
extent, which I am currently testing based on above
discussed idea... will post the full version soon. But wanted to
get some initial feedback on this one.


diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0f8a196d8a61..85c755f2989b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3520,6 +3520,25 @@ static bool ext4_iomap_is_delalloc(struct inode 
*inode,
         return true;
  }

+static bool ext4_is_last_extent(struct inode *inode, ext4_lblk_t lblk)
+{
+       int ret;
+       bool delalloc = false;
+       struct ext4_map_blocks map;
+       unsigned int len = INT_MAX;
+
+       map.m_lblk = lblk;
+       map.m_len = len;
+
+       ret = ext4_map_blocks(NULL, inode, &map, 0);
+
+       if (ret == 0)
+               delalloc = ext4_iomap_is_delalloc(inode, &map);
+       if (ret > 0 || delalloc || map.m_len < len)
+               return false;
+       return true;
+}
+
  static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
                                    loff_t length, unsigned int flags,
                                    struct iomap *iomap, struct iomap 
*srcmap)
@@ -3548,16 +3567,36 @@ static int ext4_iomap_begin_report(struct inode 
*inode, loff_t offset,
         map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
                           EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;

+
+       if ((flags & IOMAP_FIEMAP) &&
+           !ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+               if (offset >= i_size_read(inode)) {
+                       map.m_flags = 0;
+                       map.m_pblk = 0;
+                       goto set_iomap;
+               }
+       }
+
         ret = ext4_map_blocks(NULL, inode, &map, 0);

         if (ret < 0)
                 return ret;
         if (ret == 0)
                 delalloc = ext4_iomap_is_delalloc(inode, &map);

+set_iomap:
         ext4_set_iomap(inode, iomap, &map, offset, length);
         if (delalloc && iomap->type == IOMAP_HOLE)
                 iomap->type = IOMAP_DELALLOC;

+       if (flags & IOMAP_FIEMAP &&
+           ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+               ext4_lblk_t lblk = map.m_lblk + map.m_len;
+               if (ext4_is_last_extent(inode, lblk)) {
+                       iomap->flags |= IOMAP_F_EXTENT_LAST;
+               } else {
+                       iomap->flags |= IOMAP_F_EXTENT_NOT_LAST;
+               }
+       }
         return 0;
  }



-ritesh

