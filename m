Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C66601A008F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 00:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgDFWGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 18:06:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56138 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFWGM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:06:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036M3wxJ128123;
        Mon, 6 Apr 2020 22:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=xDN8q8wp40bDgTqf0pLYF/OA1LPeCmVrjLg2TCugABo=;
 b=gIVZW/f3ye+9prRMQ28G4Jz1SRi66O6BfFdAavnHUyvXNS4khDtL3m5Ku7Od/AmSg1lx
 ZfFfLY5C7EJntaRRsruMGMA6peZ0aEyUBXqcSpVgWl97fUmO9t0nFs16sYfV5mS/CQ3e
 P5gebWHLleWdbnrA8tFYky1sT54xj9lTEJwp3s+UQTPRen4sVp+cpRmi1fEvVbNDwBxn
 zfBeUss9uzFFzchBGshvDnQQYKIWy7zM2IPYVWDCQ7KKIigJF9PyEu2lgETzTgcuVDPW
 VhomLopiEVItw4PfJxPWTlI7VxOCAm1eX9ztz2Mgtzeqdpi45iBkfaoCf7rlsKka85xz ZA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 306hnr1jkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 22:06:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036M2QnL116473;
        Mon, 6 Apr 2020 22:06:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30839r9ky5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 22:06:01 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 036M5xwS029765;
        Mon, 6 Apr 2020 22:05:59 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 15:05:59 -0700
Subject: Re: kernel BUG at mm/hugetlb.c:LINE!
To:     syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mszeredi@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <000000000000b4684e05a2968ca6@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <aa7812b8-60ae-8578-40db-e71ad766b4d3@oracle.com>
Date:   Mon, 6 Apr 2020 15:05:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <000000000000b4684e05a2968ca6@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060166
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060166
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/5/20 8:06 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    1a323ea5 x86: get rid of 'errret' argument to __get_user_x..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=132e940be00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8c1e98458335a7d1
> dashboard link: https://syzkaller.appspot.com/bug?extid=d6ec23007e951dadf3de
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12921933e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172e940be00000
> 
> The bug was bisected to:
> 
> commit e950564b97fd0f541b02eb207685d0746f5ecf29
> Author: Miklos Szeredi <mszeredi@redhat.com>
> Date:   Tue Jul 24 13:01:55 2018 +0000
> 
>     vfs: don't evict uninitialized inode
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=115cad33e00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=135cad33e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=155cad33e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com
> Fixes: e950564b97fd ("vfs: don't evict uninitialized inode")
> 
> overlayfs: upper fs does not support xattr, falling back to index=off and metacopy=off.
> ------------[ cut here ]------------
> kernel BUG at mm/hugetlb.c:3416!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 7036 Comm: syz-executor110 Not tainted 5.6.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__unmap_hugepage_range+0xa26/0xbc0 mm/hugetlb.c:3416
> Code: 00 48 c7 c7 60 37 35 88 e8 57 b4 a2 ff e9 b3 fd ff ff e8 cd 90 c6 ff 0f 0b e9 c4 f7 ff ff e8 c1 90 c6 ff 0f 0b e8 ba 90 c6 ff <0f> 0b e8 b3 90 c6 ff 83 8c 24 c0 00 00 00 01 48 8d bc 24 a0 00 00
> RSP: 0018:ffffc900017779b0 EFLAGS: 00010293
> RAX: ffff88808cf5c2c0 RBX: ffffffff8c641c08 RCX: ffffffff81ac50b4
> RDX: 0000000000000000 RSI: ffffffff81ac58a6 RDI: 0000000000000007
> RBP: 0000000020000000 R08: ffff88808cf5c2c0 R09: ffffed10129d8111
> R10: ffffed10129d8110 R11: ffff888094ec0887 R12: 0000000000003000
> R13: 0000000000000000 R14: 0000000020003000 R15: 0000000000200000
> FS:  00000000013c0880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000140 CR3: 0000000093554000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  __unmap_hugepage_range_final+0x30/0x70 mm/hugetlb.c:3507
>  unmap_single_vma+0x238/0x300 mm/memory.c:1296
>  unmap_vmas+0x16f/0x2f0 mm/memory.c:1332
>  exit_mmap+0x2aa/0x510 mm/mmap.c:3126
>  __mmput kernel/fork.c:1082 [inline]
>  mmput+0x168/0x4b0 kernel/fork.c:1103
>  exit_mm kernel/exit.c:477 [inline]
>  do_exit+0xa51/0x2dd0 kernel/exit.c:780
>  do_group_exit+0x125/0x340 kernel/exit.c:891
>  __do_sys_exit_group kernel/exit.c:902 [inline]
>  __se_sys_exit_group kernel/exit.c:900 [inline]
>  __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:900
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3

This is not new and certainly not caused by commit e950564b97fd.

hugetlbf only operates on huge page aligned and sized files/mappings.
To make sure this happens, the mmap code contians the following to 'round
up' length to huge page size:

	if (!(flags & MAP_ANONYMOUS)) {
		audit_mmap_fd(fd, flags);
		file = fget(fd);
		if (!file)
			return -EBADF;
		if (is_file_hugepages(file))
			len = ALIGN(len, huge_page_size(hstate_file(file)));
		retval = -EINVAL;
		if (unlikely(flags & MAP_HUGETLB && !is_file_hugepages(file)))
			goto out_fput;
	} else if (flags & MAP_HUGETLB) {
		struct user_struct *user = NULL;
		struct hstate *hs;

		hs = hstate_sizelog((flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
		if (!hs)
			return -EINVAL;

		len = ALIGN(len, huge_page_size(hs));

However, in this syzbot test case the 'file' is in an overlayfs filesystem
created as follows:

mkdir("./file0", 000)                   = 0
mount(NULL, "./file0", "hugetlbfs", MS_MANDLOCK|MS_POSIXACL, NULL) = 0
chdir("./file0")                        = 0
mkdir("./file1", 000)                   = 0
mkdir("./bus", 000)                     = 0
mkdir("./file0", 000)                   = 0
mount("\177ELF\2\1\1", "./bus", "overlay", 0, "lowerdir=./bus,workdir=./file1,u"...) = 0

The routine is_file_hugepages() is just comparing the file ops to huegtlbfs:

	if (file->f_op == &hugetlbfs_file_operations)
		return true;

Since the file is in an overlayfs, file->f_op == ovl_file_operations.
Therefore, length will not be rounded up to huge page size and we create a
mapping with incorrect size which leads to the BUG.

Because of the code in mmap, the hugetlbfs mmap() routine assumes length is
rounded to a huge page size.  I can easily add a check to hugetlbfs mmap
to validate length and return -EINVAL.  However, I think we really want to
do the 'round up' earlier in mmap.  This is because the man page says:

   Huge page (Huge TLB) mappings
       For mappings that employ huge pages, the requirements for the arguments
       of  mmap()  and munmap() differ somewhat from the requirements for map‐
       pings that use the native system page size.

       For mmap(), offset must be a multiple of the underlying huge page size.
       The system automatically aligns length to be a multiple of the underly‐
       ing huge page size.

Since the location for the mapping is chosen BEFORE getting to the hugetlbfs
mmap routine, we can not wait until then to round up the length.  Is there a
defined way to go from a struct file * to the underlying filesystem so we
can continue to do the 'round up' in early mmap code?

One other thing I noticed with overlayfs is that it does not contain a
specific get_unmapped_area file_operations routine.  I would expect it to at
least check for and use the get_unmapped_area of the underlying filesystem?
Can someone comment if this is by design?
In the case of hugetlbfs, get_unmapped_area is even provided by most
architectures.  So, it seems like we would like/need to be calling the correct
routine.
-- 
Mike Kravetz
