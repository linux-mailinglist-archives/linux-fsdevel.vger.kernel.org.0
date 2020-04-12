Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352911A5DB4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Apr 2020 11:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDLJRX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Apr 2020 05:17:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbgDLJRX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Apr 2020 05:17:23 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03C93X72025308
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Apr 2020 05:17:23 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30b96s0k6h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Apr 2020 05:17:23 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Sun, 12 Apr 2020 10:17:04 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 12 Apr 2020 10:17:01 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03C9HG3N49152136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Apr 2020 09:17:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 353A9A4055;
        Sun, 12 Apr 2020 09:17:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7282A404D;
        Sun, 12 Apr 2020 09:17:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.84.25])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 12 Apr 2020 09:17:13 +0000 (GMT)
Subject: Re: WARNING in iomap_apply
To:     syzbot <syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, darrick.wong@oracle.com,
        hch@infradead.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
References: <00000000000048518b05a2fef23a@google.com>
 <20200411161439.GE21484@bombadil.infradead.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sun, 12 Apr 2020 14:47:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200411161439.GE21484@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20041209-0012-0000-0000-000003A308E4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041209-0013-0000-0000-000021E03930
Message-Id: <20200412091713.B7282A404D@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-12_02:2020-04-11,2020-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004120084
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/11/20 9:44 PM, Matthew Wilcox wrote:
> On Sat, Apr 11, 2020 at 12:39:13AM -0700, syzbot wrote:
>> The bug was bisected to:
>>
>> commit d3b6f23f71670007817a5d59f3fbafab2b794e8c
>> Author: Ritesh Harjani <riteshh@linux.ibm.com>
>> Date:   Fri Feb 28 09:26:58 2020 +0000
>>
>>      ext4: move ext4_fiemap to use iomap framework
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c62a57e00000
>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=15c62a57e00000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11c62a57e00000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com
>> Fixes: d3b6f23f7167 ("ext4: move ext4_fiemap to use iomap framework")
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 7023 at fs/iomap/apply.c:51 iomap_apply+0xa0c/0xcb0 fs/iomap/apply.c:51
> 
> This is:
> 
>          if (WARN_ON(iomap.length == 0))
>                  return -EIO;
> 
> and the call trace contains ext4_fiemap() so the syzbot bisection looks
> correct.

I think I know what could be going wrong here.

So the problem happens when we have overlayfs mounted on top of ext4.
Now overlayfs might be supporting max logical filesize which is more
than what ext4 could support (i.e. sb->s_maxbytes for overlayfs must
be greater than compared to ext4). So that's why the check in func
ioctl_fiemap -> fiemap_check_ranges() couldn't truncate to logical
filesize which the actual underlying filesystem supports.

@All,
Do you think we should make overlayfs also check for 
fiemap_check_ranges()? Not as part of this fix, but as a later
addition to overlayfs? Please let me know, I could also make that patch.


Now coming back to ext4. I guess since the min_t() is returning
EXT4_MAX_LOGICAL_BLOCK as the min value among the two. That then
followed by +1 is resulting into a overflow of unsigned int and it is 
becoming 0. Hence the warning in iomap_apply of iomap.length == 0.

Note (there are 2 points mentioned below). Please check both.

1. I think below diff should fix this reported problem. Do you agree?

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e416096fc081..d630ec7a9c8e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3424,6 +3424,7 @@ static int ext4_iomap_begin(struct inode *inode, 
loff_t offset, loff_t length,
         int ret;
         struct ext4_map_blocks map;
         u8 blkbits = inode->i_blkbits;
+       loff_t len;

         if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
                 return -EINVAL;
@@ -3435,8 +3436,11 @@ static int ext4_iomap_begin(struct inode *inode, 
loff_t offset, loff_t length,
          * Calculate the first and last logical blocks respectively.
          */
         map.m_lblk = offset >> blkbits;
-       map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
+       len = min_t(loff_t, (offset + length - 1) >> blkbits,
                           EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+       if (len > EXT4_MAX_LOGICAL_BLOCK)
+               len = EXT4_MAX_LOGICAL_BLOCK;
+       map.m_len = len;

         if (flags & IOMAP_WRITE)
                 ret = ext4_iomap_alloc(inode, &map, flags);
@@ -3524,6 +3528,7 @@ static int ext4_iomap_begin_report(struct inode 
*inode, loff_t offset,
         bool delalloc = false;
         struct ext4_map_blocks map;
         u8 blkbits = inode->i_blkbits;
+       loff_t len

         if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
                 return -EINVAL;
@@ -3541,8 +3546,11 @@ static int ext4_iomap_begin_report(struct inode 
*inode, loff_t offset,
          * Calculate the first and last logical block respectively.
          */
         map.m_lblk = offset >> blkbits;
-       map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
+       len = min_t(loff_t, (offset + length - 1) >> blkbits,
                           EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+       if (len > EXT4_MAX_LOGICAL_BLOCK)
+               len = EXT4_MAX_LOGICAL_BLOCK;
+       map.m_len = len;

         /*
          * Fiemap callers may call for offset beyond s_bitmap_maxbytes.


2. One other discrepancy which I noted is, in function
ext4_iomap_begin_** v/s ext4_map_blocks().
In ext4_iomap_begin_** we check, if offset(in terms of blocksize units)
is greater than EXT4_MAX_LOGICAL_BLOCK, if yes, then return -EINVAL.

Whereas in function ext4_map_blocks() we check, if offset is greater
then equal to EXT_MAX_BLOCKS, if yes, then return -EFSCORRUPTED.

Now both EXT_MAX_BLOCKS and EXT4_MAX_LOGICAL_BLOCK are same.
So if actually offset == EXT4_MAX_LOGICAL_BLOCK then we end up
returning -EFSCORRUPTED. Which do you also think is wrong?
The request may come to map just the last logical block of file
which is EXT4_MAX_LOGICAL_BLOCK, no?


The history of the change in ext4_map_blocks for checking EXT_MAX_BLOCKS
goes back to this patch.

https://lore.kernel.org/patchwork/patch/461641/

I will have to read more about it and see all the references
of EXT_MAX_BLOCKS to tell why the discrepancy. But if someone
already knows about this, please let me know.


But the diff mentioned in point 1 above should fix the problem
reported at hand. I can address this 2nd point once I go and look
at all references of EXT_MAX_BLOCKS. But nevertheless,
I wanted to make sure I this is logged in this mail.

-ritesh


> 
>>   iomap_fiemap+0x184/0x2c0 fs/iomap/fiemap.c:88
>>   _ext4_fiemap+0x178/0x4f0 fs/ext4/extents.c:4860
>>   ovl_fiemap+0x13f/0x200 fs/overlayfs/inode.c:467
>>   ioctl_fiemap fs/ioctl.c:226 [inline]
>>   do_vfs_ioctl+0x8d7/0x12d0 fs/ioctl.c:715

