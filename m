Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED71914DFFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 18:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgA3RfJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 12:35:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727285AbgA3RfJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 12:35:09 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UHU48n048578
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2020 12:35:08 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xu5qcgvq4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2020 12:35:07 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 30 Jan 2020 17:35:05 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Jan 2020 17:35:01 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00UHZ0Aq34472044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 17:35:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E06642045;
        Thu, 30 Jan 2020 17:35:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B5944203F;
        Thu, 30 Jan 2020 17:34:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.50.205])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jan 2020 17:34:57 +0000 (GMT)
Subject: Re: [RFCv2 0/4] ext4: bmap & fiemap conversion to use iomap
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com
References: <cover.1580121790.git.riteshh@linux.ibm.com>
 <20200130160018.GC3445353@magnolia>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 30 Jan 2020 23:04:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200130160018.GC3445353@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20013017-0008-0000-0000-0000034E4ABB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013017-0009-0000-0000-00004A6ECBFF
Message-Id: <20200130173458.2B5944203F@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-30_05:2020-01-28,2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300122
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/30/20 9:30 PM, Darrick J. Wong wrote:
> On Tue, Jan 28, 2020 at 03:48:24PM +0530, Ritesh Harjani wrote:
>> Hello All,
>>
>> Background
>> ==========
>> There are RFCv2 patches to move ext4 bmap & fiemap calls to use iomap APIs.
>> This reduces the users of ext4_get_block API and thus a step towards getting
>> rid of buffer_heads from ext4. Also reduces a lot of code by making use of
>> existing iomap_ops (except for xattr implementation).
>>
>> Testing (done on ext4 master branch)
>> ========
>> 'xfstests -g auto' passes with default mkfs/mount configuration
>> (v/s which also pass with vanilla kernel without this patch). Except
>> generic/473 which also failes on XFS. This seems to be the test case issue
>> since it expects the data in slightly different way as compared to what iomap
>> returns.
>> Point 2.a below describes more about this.
>>
>> Observations/Review required
>> ============================
>> 1. bmap related old v/s new method differences:-
>> 	a. In case if addr > INT_MAX, it issues a warning and
>> 	   returns 0 as the block no. While earlier it used to return the
>> 	   truncated value with no warning.
> 
> Good...
> 
>> 	b. block no. is only returned in case of iomap->type is IOMAP_MAPPED,
>> 	   but not when iomap->type is IOMAP_UNWRITTEN. While with previously
>> 	   we used to get block no. for both of above cases.
> 
> Assuming the only remaining usecase of bmap is to tell old bootloaders
> where to find vmlinuz blocks on disk, I don't see much reason to map
> unwritten blocks -- there's no data there, and if your bootloader writes
> to the filesystem(!) then you can't read whatever was written there
> anyway.

Yes, no objection there. Just wanted to get it reviewed.


> 
> Uh, can we put this ioctl on the deprecation list, please? :)
> 
>> 2. Fiemap related old v/s new method differences:-
>> 	a. iomap_fiemap returns the disk extent information in exact
>> 	   correspondence with start of user requested logical offset till the
>> 	   length requested by user. While in previous implementation the
>> 	   returned information used to give the complete extent information if
>> 	   the range requested by user lies in between the extent mapping.
> 
> This is a topic of much disagreement.  The FIEMAP documentation says
> that the call must return data for the requested range, but *may* return
> a mapping that extends beyond the requested range.
> 
> XFS (and now iomap) only return data for the requested range, whereas
> ext4 has (had?) the behavior you describe.  generic/473 was an attempt
> to enforce the ext4 behavior across all filesystems, but I put it in my
> dead list and never run it.
> 
> So it's a behavioral change, but the new behavior isn't forbidden.

Sure, thanks.

> 
>> 	b. iomap_fiemap adds the FIEMAP_EXTENT_LAST flag also at the last
>> 	   fiemap_extent mapping range requested by the user via fm_length (
>> 	   if that has a valid mapped extent on the disk).
> 
> That sounds like a bug.  _LAST is supposed to be set on the last extent
> in the file, not the last record in the queried dataset.

Thought so too, sure will spend some time to try fixing it.


> 
>> But if the user
>> 	   requested for more fm_length which could not be mapped in the last
>> 	   fiemap_extent, then the flag is not set.
> 
> Yes... if there were more extents to map than there was space in the map
> array, then _LAST should remain unset to encourage userspace to come
> back for the rest of the mappings.
> 
> (Unless maybe I'm misunderstanding here...)
> 
>> e.g. output for above differences 2.a & 2.b
>> ===========================================
>> create a file with below cmds.
>> 1. fallocate -o 0 -l 8K testfile.txt
>> 2. xfs_io -c "pwrite 8K 8K" testfile.txt
>> 3. check extent mapping:- xfs_io -c "fiemap -v" testfile.txt
>> 4. run this binary on with and without these patches:- ./a.out (test_fiemap_diff.c) [4]
>>
>> o/p of xfs_io -c "fiemap -v"
>> ============================================
>> With this patch on patched kernel:-
>> testfile.txt:
>>   EXT: FILE-OFFSET      BLOCK-RANGE          TOTAL FLAGS
>>     0: [0..15]:         122802736..122802751    16 0x800
>>     1: [16..31]:        122687536..122687551    16   0x1
>>
>> without patch on vanilla kernel (no difference):-
>> testfile.txt:
>>   EXT: FILE-OFFSET      BLOCK-RANGE          TOTAL FLAGS
>>     0: [0..15]:         332211376..332211391    16 0x800
>>     1: [16..31]:        332722392..332722407    16   0x1
>>
>>
>> o/p of a.out without patch:-
>> ================
>> riteshh-> ./a.out
>> logical: [       0..      15] phys: 332211376..332211391 flags: 0x800 tot: 16
>> (0) extent flag = 2048
>>
>> o/p of a.out with patch (both point 2.a & 2.b could be seen)
>> =======================
>> riteshh-> ./a.out
>> logical: [       0..       7] phys: 122802736..122802743 flags: 0x801 tot: 8
>> (0) extent flag = 2049
>>
>> FYI - In test_fiemap_diff.c test we had
>> a. fm_extent_count = 1
>> b. fm_start = 0
>> c. fm_length = 4K
>> Whereas when we change fm_extent_count = 32, then we don't see any difference.
>>
>> e.g. output for above difference listed in point 1.b
>> ====================================================
>>
>> o/p without patch (block no returned for unwritten block as well)
>> =========Testing IOCTL FIBMAP=========
>> File size = 16384, blkcnt = 4, blocksize = 4096
>>    0   41526422
>>    1   41526423
>>    2   41590299
>>    3   41590300
>>
>> o/p with patch (0 returned for unwritten block)
>> =========Testing IOCTL FIBMAP=========
>> File size = 16384, blkcnt = 4, blocksize = 4096
>>    0          0          0
>>    1          0          0
>>    2   15335942      29953
>>    3   15335943      29953
>>
>>
>> Summary:-
>> ========
>> Due to some of the observational differences to user, listed above,
>> requesting to please help with a careful review in moving this to iomap.
>> Digging into some older threads, it looks like these differences should be fine,
>> since the same tools have been working fine with XFS (which uses iomap based
>> implementation) [1]
>> Also as Ted suggested in [3]: Fiemap & bmap spec could be made based on the ext4
>> implementation. But since all the tools also work with xfs which uses iomap
>> based fiemap, so we should be good there.
> 
> <nod> Thanks for the worked example output. :)

Thanks for the review. :)

ritesh


> 
> --D
> 
>>
>> References of some previous discussions:
>> =======================================
>> [1]: https://www.spinics.net/lists/linux-fsdevel/msg128370.html
>> [2]: https://www.spinics.net/lists/linux-fsdevel/msg127675.html
>> [3]: https://www.spinics.net/lists/linux-fsdevel/msg128368.html
>> [4]: https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/tools/test_fiemap_diff.c
>> [RFCv1]: https://www.spinics.net/lists/linux-ext4/msg67077.html
>>
>>
>> Ritesh Harjani (4):
>>    ext4: Add IOMAP_F_MERGED for non-extent based mapping
>>    ext4: Optimize ext4_ext_precache for 0 depth
>>    ext4: Move ext4 bmap to use iomap infrastructure.
>>    ext4: Move ext4_fiemap to use iomap infrastructure
>>
>>   fs/ext4/extents.c | 288 +++++++---------------------------------------
>>   fs/ext4/inline.c  |  41 -------
>>   fs/ext4/inode.c   |   6 +-
>>   3 files changed, 49 insertions(+), 286 deletions(-)
>>
>> -- 
>> 2.21.0
>>

