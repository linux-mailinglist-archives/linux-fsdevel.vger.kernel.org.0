Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE63153E35
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 06:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgBFF0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 00:26:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbgBFF03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 00:26:29 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0165JR1v098680
        for <linux-fsdevel@vger.kernel.org>; Thu, 6 Feb 2020 00:26:28 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhn52d6g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 00:26:27 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 6 Feb 2020 05:26:25 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Feb 2020 05:26:22 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0165QLVw46727308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Feb 2020 05:26:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D09C6A4054;
        Thu,  6 Feb 2020 05:26:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4BBCA405F;
        Thu,  6 Feb 2020 05:26:19 +0000 (GMT)
Received: from [9.199.159.144] (unknown [9.199.159.144])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Feb 2020 05:26:19 +0000 (GMT)
Subject: Re: [RFCv2 0/4] ext4: bmap & fiemap conversion to use iomap
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com
References: <cover.1580121790.git.riteshh@linux.ibm.com>
 <20200130160018.GC3445353@magnolia>
 <20200205124750.AE9DDA404D@d06av23.portsmouth.uk.ibm.com>
 <20200205155733.GH6874@magnolia>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 6 Feb 2020 10:56:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200205155733.GH6874@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020605-0020-0000-0000-000003A771A1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020605-0021-0000-0000-000021FF3F2A
Message-Id: <20200206052619.D4BBCA405F@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060040
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/5/20 9:27 PM, Darrick J. Wong wrote:
> On Wed, Feb 05, 2020 at 06:17:44PM +0530, Ritesh Harjani wrote:
>>
>>
>> On 1/30/20 11:04 PM, Ritesh Harjani wrote:
>>>
>>>
>>> On 1/30/20 9:30 PM, Darrick J. Wong wrote:
>>>> On Tue, Jan 28, 2020 at 03:48:24PM +0530, Ritesh Harjani wrote:
>>>>> Hello All,
>>>>>
>>>>> Background
>>>>> ==========
>>>>> There are RFCv2 patches to move ext4 bmap & fiemap calls to use
>>>>> iomap APIs.
>>>>> This reduces the users of ext4_get_block API and thus a step
>>>>> towards getting
>>>>> rid of buffer_heads from ext4. Also reduces a lot of code by
>>>>> making use of
>>>>> existing iomap_ops (except for xattr implementation).
>>>>>
>>>>> Testing (done on ext4 master branch)
>>>>> ========
>>>>> 'xfstests -g auto' passes with default mkfs/mount configuration
>>>>> (v/s which also pass with vanilla kernel without this patch). Except
>>>>> generic/473 which also failes on XFS. This seems to be the test
>>>>> case issue
>>>>> since it expects the data in slightly different way as compared
>>>>> to what iomap
>>>>> returns.
>>>>> Point 2.a below describes more about this.
>>>>>
>>>>> Observations/Review required
>>>>> ============================
>>>>> 1. bmap related old v/s new method differences:-
>>>>>      a. In case if addr > INT_MAX, it issues a warning and
>>>>>         returns 0 as the block no. While earlier it used to return the
>>>>>         truncated value with no warning.
>>>>
>>>> Good...
>>>>
>>>>>      b. block no. is only returned in case of iomap->type is
>>>>> IOMAP_MAPPED,
>>>>>         but not when iomap->type is IOMAP_UNWRITTEN. While with
>>>>> previously
>>>>>         we used to get block no. for both of above cases.
>>>>
>>>> Assuming the only remaining usecase of bmap is to tell old bootloaders
>>>> where to find vmlinuz blocks on disk, I don't see much reason to map
>>>> unwritten blocks -- there's no data there, and if your bootloader writes
>>>> to the filesystem(!) then you can't read whatever was written there
>>>> anyway.
>>>
>>> Yes, no objection there. Just wanted to get it reviewed.
>>>
>>>
>>>>
>>>> Uh, can we put this ioctl on the deprecation list, please? :)
>>>>
>>>>> 2. Fiemap related old v/s new method differences:-
>>>>>      a. iomap_fiemap returns the disk extent information in exact
>>>>>         correspondence with start of user requested logical
>>>>> offset till the
>>>>>         length requested by user. While in previous implementation the
>>>>>         returned information used to give the complete extent
>>>>> information if
>>>>>         the range requested by user lies in between the extent mapping.
>>>>
>>>> This is a topic of much disagreement.  The FIEMAP documentation says
>>>> that the call must return data for the requested range, but *may* return
>>>> a mapping that extends beyond the requested range.
>>>>
>>>> XFS (and now iomap) only return data for the requested range, whereas
>>>> ext4 has (had?) the behavior you describe.  generic/473 was an attempt
>>>> to enforce the ext4 behavior across all filesystems, but I put it in my
>>>> dead list and never run it.
>>>>
>>>> So it's a behavioral change, but the new behavior isn't forbidden.
>>>
>>> Sure, thanks.
>>>
>>>>
>>>>>      b. iomap_fiemap adds the FIEMAP_EXTENT_LAST flag also at the last
>>>>>         fiemap_extent mapping range requested by the user via fm_length (
>>>>>         if that has a valid mapped extent on the disk).
>>>>
>>>> That sounds like a bug.  _LAST is supposed to be set on the last extent
>>>> in the file, not the last record in the queried dataset.
>>>
>>> Thought so too, sure will spend some time to try fixing it.
>>
>> Looked into this. I think below should fix our above reported problem with
>> current iomap code.
>> If no objection I will send send PATCHv3 with below fix as the first
>> patch in the series.
>>
>> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
>> index bccf305ea9ce..ee53991810d5 100644
>> --- a/fs/iomap/fiemap.c
>> +++ b/fs/iomap/fiemap.c
>> @@ -100,7 +100,12 @@ int iomap_fiemap(struct inode *inode, struct
>> fiemap_extent_info *fi,
>>          }
>>
>>          if (ctx.prev.type != IOMAP_HOLE) {
>> -               ret = iomap_to_fiemap(fi, &ctx.prev, FIEMAP_EXTENT_LAST);
>> +               u32 flags = 0;
>> +               loff_t isize = i_size_read(inode);
>> +
>> +               if (ctx.prev.offset + ctx.prev.length >= isize)
> 
> What happens if ctx.prev actually is the last iomap in the file, but
> isize extends beyond that?  e.g.,
> 
> # xfs_io -f -c 'pwrite 0 64k' /a
> # truncate -s 100m /a
> # filefrag -v /a

Err.. should never miss this truncate case.

Digging further, I see even generic_block_fiemap() does not take care of
this case if the file isize is extended by truncate.
It happens to mark _LAST only based on i_size_read(). It seems only ext*
family and hpfs filesystem seems to be using this currently.
And gfs2 was the user of this api till sometime back before it finally
moved to use iomap_fiemap() api.


> 
> I think we need the fiemap variant of the iomap_begin functions to pass
> a flag in the iomap that the fiemap implementation can pick up.

Sure, let me do some digging on this one. One challenge which I think 
would be for filesystems to tell *efficiently* on whether this is the
last extent or not (without checking on every iomap_begin call about,
if there exist a next extent on the disk by doing more I/O - that's why
*efficiently*).

If done then -
we could use IOMAP_FIEMAP as the flag to pass to iomap_begin functions
and it could return us the iomap->type marked with IOMAP_EXTENT_LAST 
which could represent that this is actually the last extent on disk for
this inode.


-ritesh

> 
> --D
> 
>> +                       flags |= FIEMAP_EXTENT_LAST;
>> +               ret = iomap_to_fiemap(fi, &ctx.prev, flags);
>>                  if (ret < 0)
>>                          return ret;
>>          }
>>
>>
>> -ritesh
>>
>>
>>>
>>>
>>>>
>>>>> But if the user
>>>>>         requested for more fm_length which could not be mapped in
>>>>> the last
>>>>>         fiemap_extent, then the flag is not set.
>>>>
>>>> Yes... if there were more extents to map than there was space in the map
>>>> array, then _LAST should remain unset to encourage userspace to come
>>>> back for the rest of the mappings.
>>>>
>>>> (Unless maybe I'm misunderstanding here...)
>>>>
>>>>> e.g. output for above differences 2.a & 2.b
>>>>> ===========================================
>>>>> create a file with below cmds.
>>>>> 1. fallocate -o 0 -l 8K testfile.txt
>>>>> 2. xfs_io -c "pwrite 8K 8K" testfile.txt
>>>>> 3. check extent mapping:- xfs_io -c "fiemap -v" testfile.txt
>>>>> 4. run this binary on with and without these patches:- ./a.out
>>>>> (test_fiemap_diff.c) [4]
>>>>>
>>>>> o/p of xfs_io -c "fiemap -v"
>>>>> ============================================
>>>>> With this patch on patched kernel:-
>>>>> testfile.txt:
>>>>>    EXT: FILE-OFFSET      BLOCK-RANGE          TOTAL FLAGS
>>>>>      0: [0..15]:         122802736..122802751    16 0x800
>>>>>      1: [16..31]:        122687536..122687551    16   0x1
>>>>>
>>>>> without patch on vanilla kernel (no difference):-
>>>>> testfile.txt:
>>>>>    EXT: FILE-OFFSET      BLOCK-RANGE          TOTAL FLAGS
>>>>>      0: [0..15]:         332211376..332211391    16 0x800
>>>>>      1: [16..31]:        332722392..332722407    16   0x1
>>>>>
>>>>>
>>>>> o/p of a.out without patch:-
>>>>> ================
>>>>> riteshh-> ./a.out
>>>>> logical: [       0..      15] phys: 332211376..332211391 flags:
>>>>> 0x800 tot: 16
>>>>> (0) extent flag = 2048
>>>>>
>>>>> o/p of a.out with patch (both point 2.a & 2.b could be seen)
>>>>> =======================
>>>>> riteshh-> ./a.out
>>>>> logical: [       0..       7] phys: 122802736..122802743 flags:
>>>>> 0x801 tot: 8
>>>>> (0) extent flag = 2049
>>>>>
>>>>> FYI - In test_fiemap_diff.c test we had
>>>>> a. fm_extent_count = 1
>>>>> b. fm_start = 0
>>>>> c. fm_length = 4K
>>>>> Whereas when we change fm_extent_count = 32, then we don't see
>>>>> any difference.
>>>>>
>>>>> e.g. output for above difference listed in point 1.b
>>>>> ====================================================
>>>>>
>>>>> o/p without patch (block no returned for unwritten block as well)
>>>>> =========Testing IOCTL FIBMAP=========
>>>>> File size = 16384, blkcnt = 4, blocksize = 4096
>>>>>     0   41526422
>>>>>     1   41526423
>>>>>     2   41590299
>>>>>     3   41590300
>>>>>
>>>>> o/p with patch (0 returned for unwritten block)
>>>>> =========Testing IOCTL FIBMAP=========
>>>>> File size = 16384, blkcnt = 4, blocksize = 4096
>>>>>     0          0          0
>>>>>     1          0          0
>>>>>     2   15335942      29953
>>>>>     3   15335943      29953
>>>>>
>>>>>
>>>>> Summary:-
>>>>> ========
>>>>> Due to some of the observational differences to user, listed above,
>>>>> requesting to please help with a careful review in moving this to iomap.
>>>>> Digging into some older threads, it looks like these differences
>>>>> should be fine,
>>>>> since the same tools have been working fine with XFS (which uses
>>>>> iomap based
>>>>> implementation) [1]
>>>>> Also as Ted suggested in [3]: Fiemap & bmap spec could be made
>>>>> based on the ext4
>>>>> implementation. But since all the tools also work with xfs which
>>>>> uses iomap
>>>>> based fiemap, so we should be good there.
>>>>
>>>> <nod> Thanks for the worked example output. :)
>>>
>>> Thanks for the review. :)
>>>
>>> ritesh
>>>
>>>
>>>>
>>>> --D
>>>>
>>>>>
>>>>> References of some previous discussions:
>>>>> =======================================
>>>>> [1]: https://www.spinics.net/lists/linux-fsdevel/msg128370.html
>>>>> [2]: https://www.spinics.net/lists/linux-fsdevel/msg127675.html
>>>>> [3]: https://www.spinics.net/lists/linux-fsdevel/msg128368.html
>>>>> [4]: https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/tools/test_fiemap_diff.c
>>>>>
>>>>> [RFCv1]: https://www.spinics.net/lists/linux-ext4/msg67077.html
>>>>>
>>>>>
>>>>> Ritesh Harjani (4):
>>>>>     ext4: Add IOMAP_F_MERGED for non-extent based mapping
>>>>>     ext4: Optimize ext4_ext_precache for 0 depth
>>>>>     ext4: Move ext4 bmap to use iomap infrastructure.
>>>>>     ext4: Move ext4_fiemap to use iomap infrastructure
>>>>>
>>>>>    fs/ext4/extents.c | 288 +++++++---------------------------------------
>>>>>    fs/ext4/inline.c  |  41 -------
>>>>>    fs/ext4/inode.c   |   6 +-
>>>>>    3 files changed, 49 insertions(+), 286 deletions(-)
>>>>>
>>>>> -- 
>>>>> 2.21.0
>>>>>
>>

