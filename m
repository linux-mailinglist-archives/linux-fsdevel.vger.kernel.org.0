Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E04E1B1D52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 06:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgDUEUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 00:20:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41684 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbgDUEUr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 00:20:47 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03L43SUR089715
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2020 00:20:46 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gmua2473-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2020 00:20:46 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 21 Apr 2020 05:20:21 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Apr 2020 05:20:19 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03L4KfaC14942436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 04:20:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18EF04C050;
        Tue, 21 Apr 2020 04:20:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF8074C046;
        Tue, 21 Apr 2020 04:20:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.92.243])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Apr 2020 04:20:39 +0000 (GMT)
Subject: Re: [Bug 207367] Accraid / aptec / Microsemi / ext4 / larger then
 16TB
To:     bugzilla-daemon@bugzilla.kernel.org, linux-ext4@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
References: <bug-207367-13602@https.bugzilla.kernel.org/>
 <bug-207367-13602-zdl9QZH6DN@https.bugzilla.kernel.org/>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 21 Apr 2020 09:50:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <bug-207367-13602-zdl9QZH6DN@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20042104-0012-0000-0000-000003A85743
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042104-0013-0000-0000-000021E5A337
Message-Id: <20200421042039.BF8074C046@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_09:2020-04-20,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210033
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello All,

On 4/21/20 5:21 AM, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=207367
> 
> --- Comment #3 from Christian Kujau (lists@nerdbynature.de) ---
> On Mon, 20 Apr 2020, bugzilla-daemon@bugzilla.kernel.org wrote:
>> with kernel 5.7 only volumes under 16TB can be mount.
> 
> While this bug report is still missing details, I was able to reproduce
> this issue. Contrary to the subject line, it is not hardware related at
> all.
> 
> Linux 5.5 (Debian), creating a 17 TB sparse device (4 GB backing device):
> 
>   $ echo "0 36507222016 zero" | dmsetup create zero0
>   $ echo "0 36507222016 snapshot /dev/mapper/zero0 /dev/vdb p 128" | \
>     dmsetup create sparse0
> 
>   $ mkfs.ext4 -F /dev/mapper/sparse0
>   Creating filesystem with 4563402752 4k blocks and 285212672 inodes
>   Creating journal (262144 blocks): done
> 
>   $ mount -t ext4 /dev/mapper/sparse0 /mnt/disk/
>   $ df -h /mnt/disk/
>   Filesystem      Size  Used Avail Use% Mounted on
>   /dev/mapper/sparse0   17T   24K   17T   1% /mnt/disk
> 
> 
> The same fails on 5.7-rc2 (vanilla) with:
> 
> 
> ------------[ cut here ]------------
> would truncate bmap result
> WARNING: CPU: 0 PID: 640 at fs/iomap/fiemap.c:121
> iomap_bmap_actor+0x3a/0x40

Sorry about not seeing this through in the first place.

So the problem really is that the iomap_bmap() API
gives WARNING and does't return the physical block address in case
if the addr is > INT_MAX. (I guess this could be mostly since
the ioctl_fibmap() passes a user integer pointer and users of
iomap_bmap() may mostly be coming from ioctl path till now).

FYI - I do see that bmap() is also used by below APIs/subsystem.
Not sure if any of subsystems mentioned below may still fail later
if the underlying FS moved to iomap_bmap() interface or for
any existing callers of iomap_bmap() :-

1. mm/page-io.c (generic_swapfile_activate() func)
2. fs/cachefiles/rdwr.c
3. fs/ecryptfs/mmap.c
4. fs/jbd2/journal.c


But the changes done in ext4 to move to iomap_bmap() interface
resulted in this issue since jbd2 tries to find the block mapping
of on disk journal inode of ext4 and on a larger filesystem
this may fail given the design of iomap_bmap() to not
return addr if > INT_MAX.

So as I see it there are 3 options from here. Wanted to put this
on mailing list for discussion.

1. Make changes in iomap_bmap() to return the block address mapping.
But I still would like to mention that iomap designers may not agree
with this here Since the direction in general is to get rid of bmap()
interface anyways.

2. Revert the patch series of "bmap & fiemap to move to iomap interface"
(why fiemap too? - since if we decide to revert bmap anyways,
then we better fix the performance numbers report too coming from
fiemap. Also due to 3rd option below since if iomap_bmap() is
not changed, then we better keep both of this interface as is until
we get the solution like 3 below.)

3. To move to a new internal API like fiemap. But we need to change
fiemap in a way that it should also be allowed to used by internal
kernel APIs. Since as of now fiemap_extent struct is assumed to be
a user pointer.

(But the 3rd option as I see, won't be possible given the time frame to
fix this issue. Also note if we decide to revert the changes, then the
long term path would be to work on making fiemap used by internal kernel
APIs too).

struct fiemap_extent_info {
	unsigned int fi_flags;		/* Flags as passed from user */
	unsigned int fi_extents_mapped;	/* Number of mapped extents */
	unsigned int fi_extents_max;	/* Size of fiemap_extent array */
	struct fiemap_extent __user *fi_extents_start; /* Start of
							fiemap_extent array */
};


-ritesh

