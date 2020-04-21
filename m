Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED411B1EFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 08:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgDUGsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 02:48:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726748AbgDUGsP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:48:15 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03L6Vv1V054263
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2020 02:48:14 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gmvgh7qq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2020 02:48:14 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 21 Apr 2020 07:47:26 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Apr 2020 07:47:24 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03L6m8K960817714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 06:48:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B068111C04C;
        Tue, 21 Apr 2020 06:48:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A02211C05E;
        Tue, 21 Apr 2020 06:48:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.176.252])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Apr 2020 06:48:07 +0000 (GMT)
Subject: Re: [Bug 207367] Accraid / aptec / Microsemi / ext4 / larger then
 16TB
To:     Dave Chinner <david@fromorbit.com>
Cc:     bugzilla-daemon@bugzilla.kernel.org, linux-ext4@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <bug-207367-13602@https.bugzilla.kernel.org/>
 <bug-207367-13602-zdl9QZH6DN@https.bugzilla.kernel.org/>
 <20200421042039.BF8074C046@d06av22.portsmouth.uk.ibm.com>
 <20200421050850.GB27860@dread.disaster.area>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 21 Apr 2020 12:18:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200421050850.GB27860@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20042106-0016-0000-0000-000003086D7B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042106-0017-0000-0000-0000336C82C3
Message-Id: <20200421064807.4A02211C05E@d06av25.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_01:2020-04-20,2020-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210052
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On 4/21/20 10:38 AM, Dave Chinner wrote:
> On Tue, Apr 21, 2020 at 09:50:38AM +0530, Ritesh Harjani wrote:
>> Hello All,
>>
>> On 4/21/20 5:21 AM, bugzilla-daemon@bugzilla.kernel.org wrote:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=207367
>>>
>>> --- Comment #3 from Christian Kujau (lists@nerdbynature.de) ---
>>> On Mon, 20 Apr 2020, bugzilla-daemon@bugzilla.kernel.org wrote:
>>>> with kernel 5.7 only volumes under 16TB can be mount.
>>>
>>> While this bug report is still missing details, I was able to reproduce
>>> this issue. Contrary to the subject line, it is not hardware related at
>>> all.
>>>
>>> Linux 5.5 (Debian), creating a 17 TB sparse device (4 GB backing device):
>>>
>>>    $ echo "0 36507222016 zero" | dmsetup create zero0
>>>    $ echo "0 36507222016 snapshot /dev/mapper/zero0 /dev/vdb p 128" | \
>>>      dmsetup create sparse0
>>>
>>>    $ mkfs.ext4 -F /dev/mapper/sparse0
>>>    Creating filesystem with 4563402752 4k blocks and 285212672 inodes
>>>    Creating journal (262144 blocks): done
>>>
>>>    $ mount -t ext4 /dev/mapper/sparse0 /mnt/disk/
>>>    $ df -h /mnt/disk/
>>>    Filesystem      Size  Used Avail Use% Mounted on
>>>    /dev/mapper/sparse0   17T   24K   17T   1% /mnt/disk
>>>
>>>
>>> The same fails on 5.7-rc2 (vanilla) with:
>>>
>>>
>>> ------------[ cut here ]------------
>>> would truncate bmap result
>>> WARNING: CPU: 0 PID: 640 at fs/iomap/fiemap.c:121
>>> iomap_bmap_actor+0x3a/0x40
>>
>> Sorry about not seeing this through in the first place.
>>
>> So the problem really is that the iomap_bmap() API
>> gives WARNING and does't return the physical block address in case
>> if the addr is > INT_MAX. (I guess this could be mostly since
>> the ioctl_fibmap() passes a user integer pointer and users of
>> iomap_bmap() may mostly be coming from ioctl path till now).
> 
> No, it's because bmap is fundamentally broken when it comes to block
> ranges > INT_MAX. The filesystem in question is a >16TB filesystem,
> so the block range for that filesystem is >32bits, and hence usage
> of bmap in the jbd2 code is broken.

IIUC, what you meant is that bmap in general as a interface is broken
because if some user tries to call this interface via an ioctl for a
file which is placed beyond 32 bits on a filesystem, then it truncates
the results (basically gives us wrong results). Also this means
as a user interface this was not designed properly keeping the block
addresses range in mind (that someday it will extent beyong 32 bits).


Due to above reason, we don't make iomap_bmap() API return the
u64 addr in it's argument, even though it is capable of doing that.
Is that the reason?
And this is because since the overall interface from userspace side is
broken and so we want to get rid of that.


So what I would still like to understand is- that bmap() internal kernel
function can definitely handle the sector_t block addresses, right?
Isn't the bmap() kernel function was designed for this purpose in mind,
to help internal kernel callers to provide with u64 block addresses?

But for e.g. here, when jbd2 calls for bmap(), it will eventually
call for ext4_bmap() -> iomap_bmap(). Now even though this
chain is capable of handling u64 addresses, but it's the iomap_bmap()
which doesn't provide this. So the question simply is why?

Sorry about my query here, it is to only to understand more about this
and to not force in anyway to change iomap_bmap() to just get this working.


> 
> Basically, jbd2 needs fixing to be able to map blocks that are at
> higher offsets than bmap can actually report.
> 
>> FYI - I do see that bmap() is also used by below APIs/subsystem.
>> Not sure if any of subsystems mentioned below may still fail later
>> if the underlying FS moved to iomap_bmap() interface or for
>> any existing callers of iomap_bmap() :-
>>
>> 1. mm/page-io.c (generic_swapfile_activate() func)
> 
> Filesystems using iomap infrastructure should be providing
> aops->swap_activate() to map swapfile extents via
> iomap_swapfile_activate() (e.g. see xfs_iomap_swapfile_activate()),
> not using generic_swapfile_activate().
> 
>> 2. fs/cachefiles/rdwr.c
> 
> Known problem, work being done to stop using bmap() here
> 
>> 3. fs/ecryptfs/mmap.c
> 
> Just a wrapper to pass ->bmap calls through to the lower layer.
> 
>> 4. fs/jbd2/journal.c
> 
> Broken on filesystems where the journal file might be placed beyond
> a 32 bit block number, iomap_bmap() just makes that obvious. Needs
> fixing.
> 
> You also missed f2fs copy-n-waste using it for internal swapfile
> mapping:
> 
> /* Copied from generic_swapfile_activate() to check any holes */
> 
> That needs fixing, too.
> 
> And you missed the MD bitmap code uses bmap() to map it's bitmap
> storage file, which means that is broken is the bitmap file is on a
> filesystem/block device > 16TB, too...
> 
>> But the changes done in ext4 to move to iomap_bmap() interface
>> resulted in this issue since jbd2 tries to find the block mapping
>> of on disk journal inode of ext4 and on a larger filesystem
>> this may fail given the design of iomap_bmap() to not
>> return addr if > INT_MAX.
>>
>> So as I see it there are 3 options from here. Wanted to put this
>> on mailing list for discussion.
>>
>> 1. Make changes in iomap_bmap() to return the block address mapping.
>> But I still would like to mention that iomap designers may not agree
>> with this here Since the direction in general is to get rid of bmap()
>> interface anyways.
> 
> Nope. bmap() is broken. Get rid of it.
> 
>> 2. Revert the patch series of "bmap & fiemap to move to iomap interface"
>> (why fiemap too? - since if we decide to revert bmap anyways,
>> then we better fix the performance numbers report too coming from
>> fiemap. Also due to 3rd option below since if iomap_bmap() is
>> not changed, then we better keep both of this interface as is until
>> we get the solution like 3 below.)
> 
> The use of bmap was broken prior to this conversion - shooting
> the messenger doesn't fix the problem. Get rid of bmap().
> 
>> 3. To move to a new internal API like fiemap. But we need to change
>> fiemap in a way that it should also be allowed to used by internal
>> kernel APIs. Since as of now fiemap_extent struct is assumed to be
>> a user pointer.
> 
> Fiemap cannot be used this way. It's a diagnostic interface that

Sure.

> provides no guarantee of coherency or atomicity, so you can't use it
> in this way in userspace or the kernel.

hmm. Yes, I guess even with FIEMAP_FLAG_SYNC what it mostly could
provide is to make sure the dirty data goes and sit on disk.
But I guess it won't provide guarantee that in case if the data
is journalled then it is moved to it's right location on disk
before the results are returned to user.
So I understood the coherency part. But why do you say atomicity? How
does bmap() interface provides atomicity() ?


> 
> IMO, the correct thing to do is for the caller to supply jbd with a
> block mapping callback. i.e. jbd2_journal_init_inode() gets called
> from both ext4 and ocfs2 with a callback that does the block mapping
> for that specific filesystem. Indeed, jbd2 will need to cache that
> callback, because it needs to call it to map journal blocks when
> committing transactions....

Sure thanks for this. Somehow I feel that the callback will be
a similar API to what a_ops->bmap() does today.

So from jbd2 perspective will the new block mapping callback
needs same level of coherency and atomicity guarantee?



Thanks
-ritesh

