Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D52BD1A5F52
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Apr 2020 18:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgDLQUG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Apr 2020 12:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgDLQUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Apr 2020 12:20:06 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Apr 2020 12:20:06 EDT
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B09C0A3BF1;
        Sun, 12 Apr 2020 09:13:06 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03CGA4xS067338;
        Sun, 12 Apr 2020 16:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=k/PHXmE1tFF4uwo/11j/QXvuGih1LNDMw3dj5UKLqms=;
 b=CTGwsCdJuFJ4C3jpBtgQYXWIBjyk4Nxfl4g0rFUjZ86pwSO0kHA/le2EEn+q1XQ3v+fz
 DToJZKVvciAyWzzsM0P/kf3DJqLcOnHIBD/CQayRWbCXBXJFqudQHPaYs/2v/XnkCHG8
 hNByy//xNMT4y5VMRGWyVgR+/RQq/R+C6I5xLSUR1SHPZ+lB7KTFc/h41jMJ4OxUDvyN
 lUop2aISJrE0fPbrXnS/gwJxjVRp0vMu+A0CxYYIn+EA1/MZCj8YVxyy8Dpzo0oTwL/C
 FflEbLKOm+xJn6uGE6/lSrZEi/W/fls0pejZ590XmT/2aXGuIH/XrMzksQ/mPSf3khVB Mg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30b5ukud8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Apr 2020 16:12:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03CGBbEU009877;
        Sun, 12 Apr 2020 16:12:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30bqcbfd6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Apr 2020 16:12:37 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03CGCT5R016047;
        Sun, 12 Apr 2020 16:12:30 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 12 Apr 2020 09:12:29 -0700
Date:   Sun, 12 Apr 2020 09:12:27 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com>,
        hch@infradead.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        riteshh@linux.ibm.com, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: WARNING in iomap_apply
Message-ID: <20200412161227.GE6749@magnolia>
References: <00000000000048518b05a2fef23a@google.com>
 <20200411092558.20856-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411092558.20856-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9589 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004120148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9589 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004120147
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 11, 2020 at 05:25:58PM +0800, Hillf Danton wrote:
> 
> On Sat, 11 Apr 2020 00:39:13 -0700
> > syzbot found the following crash on:
> > 
> > HEAD commit:    7e634208 Merge tag 'acpi-5.7-rc1-2' of git://git.kernel.or..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=127ebeb3e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=12205d036cec317f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=77fa5bdb65cc39711820
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1196f257e00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c336c7e00000
> > 
> > The bug was bisected to:
> > 
> > commit d3b6f23f71670007817a5d59f3fbafab2b794e8c
> > Author: Ritesh Harjani <riteshh@linux.ibm.com>
> > Date:   Fri Feb 28 09:26:58 2020 +0000
> > 
> >     ext4: move ext4_fiemap to use iomap framework
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c62a57e00000
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=15c62a57e00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11c62a57e00000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com
> > Fixes: d3b6f23f7167 ("ext4: move ext4_fiemap to use iomap framework")
> > 
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 7023 at fs/iomap/apply.c:51 iomap_apply+0xa0c/0xcb0 fs/iomap/apply.c:51
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 0 PID: 7023 Comm: syz-executor296 Not tainted 5.6.0-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x188/0x20d lib/dump_stack.c:118
> >  panic+0x2e3/0x75c kernel/panic.c:221
> >  __warn.cold+0x2f/0x35 kernel/panic.c:582
> >  report_bug+0x27b/0x2f0 lib/bug.c:195
> >  fixup_bug arch/x86/kernel/traps.c:175 [inline]
> >  fixup_bug arch/x86/kernel/traps.c:170 [inline]
> >  do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
> >  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
> >  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
> > RIP: 0010:iomap_apply+0xa0c/0xcb0 fs/iomap/apply.c:51
> > Code: ff e9 0e fd ff ff e8 23 30 96 ff 0f 0b e9 07 f7 ff ff e8 17 30 96 ff 0f 0b 49 c7 c4 fb ff ff ff e9 35 f9 ff ff e8 04 30 96 ff <0f> 0b 49 c7 c4 fb ff ff ff e9 22 f9 ff ff e8 f1 2f 96 ff 0f 0b e9
> > RSP: 0018:ffffc90000f87968 EFLAGS: 00010293
> > RAX: ffff8880a1b00480 RBX: ffffc90000f879c8 RCX: ffffffff81dcf934
> > RDX: 0000000000000000 RSI: ffffffff81dd016c RDI: 0000000000000007
> > RBP: 0000000000000000 R08: ffff8880a1b00480 R09: ffffed1015cc70fc
> > R10: ffff8880ae6387db R11: ffffed1015cc70fb R12: 0000000000000000
> > R13: ffff888085e716b8 R14: 0000000000000000 R15: ffffc90000f87b50
> >  iomap_fiemap+0x184/0x2c0 fs/iomap/fiemap.c:88
> >  _ext4_fiemap+0x178/0x4f0 fs/ext4/extents.c:4860
> >  ovl_fiemap+0x13f/0x200 fs/overlayfs/inode.c:467
> >  ioctl_fiemap fs/ioctl.c:226 [inline]
> >  do_vfs_ioctl+0x8d7/0x12d0 fs/ioctl.c:715
> >  ksys_ioctl+0xa3/0x180 fs/ioctl.c:761
> >  __do_sys_ioctl fs/ioctl.c:772 [inline]
> >  __se_sys_ioctl fs/ioctl.c:770 [inline]
> >  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
> >  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> >  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> 
> Check out-of-bound parameters.

No SOB, this patch cannot be taken.

> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -70,6 +70,9 @@ int iomap_fiemap(struct inode *inode, st
>  	struct fiemap_ctx ctx;
>  	loff_t ret;
>  
> +	if (start < 0 || len < 0)
> +		return -EINVAL;

FIEMAP parameters ought to be range-checked in ioctl_fiemap().

--D

> +
>  	memset(&ctx, 0, sizeof(ctx));
>  	ctx.fi = fi;
>  	ctx.prev.type = IOMAP_HOLE;
> 
