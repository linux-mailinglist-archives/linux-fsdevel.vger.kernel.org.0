Return-Path: <linux-fsdevel+bounces-3042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7652B7EF6DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 18:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F4F280F01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 17:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B31843153;
	Fri, 17 Nov 2023 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="jsT/88/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40820D71
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 09:15:48 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2D728361EB7
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 17:15:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a263.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D011F36155D
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 17:15:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1700241346; a=rsa-sha256;
	cv=none;
	b=uRbgiCgounk+KPtarvecMI3QfYwcJi/1cb9jFTKdGLreLU9nfi4tK5G9CIfIVN8bE/elD+
	ha6wlg8Ot/HfVHjf2LAKlwkz8AX+J+/3jgbamTFszDAn0/vKqcGcOVwUcNs1dTFSdbhB74
	smo5SkOKjdG7r+BHVxVgzgpxWC3NUtZvbXsKmwM7cUZ4XDlWyn3H3Uu8dZtA9ZcclN2ZQy
	DezpflEoKpBEcurwm6wnJM3vCm+5COaEY+Wm9Sxu8XRIp2+guO0DqWwNu+CUUnYitm6Zbi
	FtvTkZC89tlqZd/w/jaONhdAHAhL69GX4I8R4hMIQkUwA9i1IVmUZeKY7Z4Rug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1700241346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=inVhZeX/fAccosfVCJ2beEae0IVFxx54RqA8dyLxVMw=;
	b=KU5WMoP/Cb/QEAHTBq6vCCvizjyvN/0WyDlt68+T1X2fE3YhEbivXwyswZnPO/vmmj3R+F
	4f9buUYm3mgMM/9g8JrWIAnxKOdu+n+dErZjeV+o8+x//kP44dYwnzXruSQpQ4hEhqB+Az
	O2t8BYS5dcHNw5968XCbIHmUNJ8ISSACrzE91hxvqWyd0FOt+zNlRoit9mQm8XZmdJjHgO
	6dRCXvNXrfs/22gJLuJRm77KJzya4YfSDgF8lxGMDsQPD2d+7mpQjmP2kNOoOS221Ew52H
	0HP7fQUiWYmke2C0dASo+vqFB+JAHwDxRQ1agT8UCXjtq+CbeFTyt1SM51srQg==
ARC-Authentication-Results: i=1;
	rspamd-7f8878586f-cltsb;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Keen-Drop: 6f9dd5a1620d25ce_1700241347021_1056988758
X-MC-Loop-Signature: 1700241347021:3268150453
X-MC-Ingress-Time: 1700241347021
Received: from pdx1-sub0-mail-a263.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.116.85.10 (trex/6.9.2);
	Fri, 17 Nov 2023 17:15:47 +0000
Received: from kmjvbox.templeofstupid.com (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a263.dreamhost.com (Postfix) with ESMTPSA id 4SX3Sy3vS4zQX
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 09:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1700241346;
	bh=inVhZeX/fAccosfVCJ2beEae0IVFxx54RqA8dyLxVMw=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=jsT/88/jwEQkkHbMM14g08oYTPVsPSLC5QXxNdLyyj/W/994T8FIe3INBpIV9XbDZ
	 +tJyewo1QYMVH1P5EDRx2R+CmHUg2vTSybb64vEiz3UnHMxmcPu/zg4nl2pnwXX8eq
	 8Zl5ylRaBR0bz1kGSfILSjKQNCyZQUM2ixYmrffvzlHhDf8NRFpNxZCUPIq4SfJtM9
	 M/6X+lpsDS/xYMLJrvVDSl2rh7klYQQ5Gu7QWR+kMNFpO6YwaqJilnPG0ig0IMo+HP
	 CYYd7AMtJcEUc7S/Xm4ntoNMB5D28K8nDZIHnH3/N8c4h9krpqXtyXKhVdfZzaNUNa
	 CVOGxwsZxVLsw==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e00ba
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Fri, 17 Nov 2023 09:15:43 -0800
Date: Fri, 17 Nov 2023 09:15:43 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: =?utf-8?B?5ZGo57un5bOw?= <zhoujifeng@kylinos.com.cn>
Cc: kernel test robot <oliver.sang@intel.com>,
	oe-lkp <oe-lkp@lists.linux.dev>, lkp <lkp@intel.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	ltp <ltp@lists.linux.it>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	miklos <miklos@szeredi.hu>
Subject: Re: [PATCH v2] fuse: Track process write operations in both direct
 and writethrough modes
Message-ID: <20231117171543.GA2085@templeofstupid.com>
References: <202311161627.5a936995-oliver.sang@intel.com>
 <tencent_357A64C125E563CC20B58A87@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_357A64C125E563CC20B58A87@qq.com>

On Fri, Nov 17, 2023 at 11:06:10AM +0800, 周继峰 wrote:
> Hi Miklos,
> 
> On Thu, Nov 16, 2023 at 4:43 PM kernel test robot <oliver.sang@intel.com> wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed "BUG:KASAN:slab-out-of-bounds_in_fuse_evict_inode" on:
> >
> > commit: 6772e9ddfc996544d6a22e72eddf7510ac2999fc ("[PATCH v2] fuse: Track process write operations in both direct and writethrough modes")
> > url: https://github.com/intel-lab-lkp/linux/commits/Zhou-Jifeng/fuse-Track-process-write-operations-in-both-direct-and-writethrough-modes/20231107-163300
> > base: https://git.kernel.org/cgit/linux/kernel/git/mszeredi/fuse.git for-next
> > patch link: https://lore.kernel.org/all/20231107081350.14472-1-zhoujifeng@kylinos.com.cn/
> > patch subject: [PATCH v2] fuse: Track process write operations in both direct and writethrough modes
> >
> > in testcase: ltp
> > version: ltp-x86_64-14c1f76-1_20230715
> > with following parameters:
> >
> >         disk: 1HDD
> >         fs: xfs
> >         test: fs-03
> >
> >
> >
> > compiler: gcc-12
> > test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202311161627.5a936995-oliver.sang@intel.com
> >
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20231116/202311161627.5a936995-oliver.sang@intel.com
> >
> >
> > [  608.279527][ T5411] ==================================================================
> > [  608.279697][ T5411] BUG: KASAN: slab-out-of-bounds in fuse_evict_inode+0x15c/0x4a0 [fuse]
> > [  608.279871][ T5411] Write of size 4 at addr ffff888092af0dc8 by task fs_fill/5411
> > [  608.280019][ T5411]
> > [  608.280082][ T5411] CPU: 1 PID: 5411 Comm: fs_fill Not tainted 6.6.0-rc2-00004-g6772e9ddfc99 #1
> > [  608.280252][ T5411] Hardware name: Hewlett-Packard p6-1451cx/2ADA, BIOS 8.15 02/05/2013
> > [  608.280409][ T5411] Call Trace:
> > [  608.280494][ T5411]  <TASK>
> > [  608.280570][ T5411]  dump_stack_lvl+0x36/0x50
> > [  608.280674][ T5411]  print_address_description+0x2c/0x3a0
> > [  608.280808][ T5411]  ? fuse_evict_inode+0x15c/0x4a0 [fuse]
> > [  608.280935][ T5411]  print_report+0xba/0x2b0
> > [  608.281034][ T5411]  ? kasan_addr_to_slab+0xd/0x90
> > [  608.281140][ T5411]  ? fuse_evict_inode+0x15c/0x4a0 [fuse]
> > [  608.281266][ T5411]  kasan_report+0xc7/0x100
> > [  608.281604][ T5411]  ? fuse_evict_inode+0x15c/0x4a0 [fuse]
> > [  608.281763][ T5411]  kasan_check_range+0xfc/0x1a0
> > [  608.281871][ T5411]  fuse_evict_inode+0x15c/0x4a0 [fuse]
> > [  608.281994][ T5411]  evict+0x29b/0x5e0
> > [  608.282086][ T5411]  ? lookup_one_qstr_excl+0x23/0x150
> > [  608.282201][ T5411]  do_unlinkat+0x34f/0x5a0
> > [  608.282300][ T5411]  ? __x64_sys_rmdir+0xf0/0xf0
> > [  608.282404][ T5411]  ? 0xffffffff81000000
> > [  608.282498][ T5411]  ? strncpy_from_user+0x6a/0x230
> > [  608.282611][ T5411]  ? getname_flags+0x8d/0x430
> > [  608.282724][ T5411]  __x64_sys_unlink+0xa9/0xf0
> > [  608.282827][ T5411]  do_syscall_64+0x38/0x80
> > [  608.282928][ T5411]  entry_SYSCALL_64_after_hwframe+0x5e/0xc8
> > [  608.283052][ T5411] RIP: 0033:0x7f6ba18898a7
> > [  608.283574][ T5411] Code: f0 ff ff 73 01 c3 48 8b 0d 56 85 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 29 85 0d 00 f7 d8 64 89 01 48
> > [  608.283947][ T5411] RSP: 002b:00007f6ba178ae48 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
> > [  608.284142][ T5411] RAX: ffffffffffffffda RBX: 00007f6b94000b70 RCX: 00007f6ba18898a7
> > [  608.284321][ T5411] RDX: 0000000000000000 RSI: 0000000000000039 RDI: 00007f6ba178ae90
> > [  608.284503][ T5411] RBP: 00007f6ba178ae90 R08: 0000000000000000 R09: 0000000000000073
> > [  608.284681][ T5411] R10: 0000000000000000 R11: 0000000000000246 R12: 0000562b20532004
> > [  608.284862][ T5411] R13: 0000000000000039 R14: 0000000000000000 R15: 00007f6ba178ae90
> > [  608.285050][ T5411]  </TASK>
> > [  608.285150][ T5411]
> > [  608.285237][ T5411] The buggy address belongs to the object at ffff888092af0b40
> > [  608.285237][ T5411]  which belongs to the cache fuse_inode of size 824
> > [  608.285514][ T5411] The buggy address is located 648 bytes inside of
> > [  608.285514][ T5411]  allocated 824-byte region [ffff888092af0b40, ffff888092af0e78)
> > [  608.285794][ T5411]
> > [  608.285883][ T5411] The buggy address belongs to the physical page:
> > [  608.286036][ T5411] page:00000000c8edd8aa refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x92af0
> > [  608.286258][ T5411] head:00000000c8edd8aa order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > [  608.286455][ T5411] memcg:ffff8881f087ff01
> > [  608.286572][ T5411] flags: 0xfffffc0000840(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
> > [  608.286753][ T5411] page_type: 0xffffffff()
> > [  608.286867][ T5411] raw: 000fffffc0000840 ffff8881019c9e00 dead000000000122 0000000000000000
> > [  608.287685][ T5411] raw: 0000000000000000 0000000080110011 00000001ffffffff ffff8881f087ff01
> > [  608.287877][ T5411] page dumped because: kasan: bad access detected
> > [  608.288035][ T5411]
> > [  608.288121][ T5411] Memory state around the buggy address:
> > [  608.288261][ T5411]  ffff888092af0c80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [  608.288443][ T5411]  ffff888092af0d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [  608.288624][ T5411] >ffff888092af0d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [  608.288803][ T5411]                                               ^
> > [  608.288932][  T291] tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread4/AOF", iov, 512): ENOSPC
> > [  608.288950][ T5411]  ffff888092af0e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [  608.288953][ T5411]  ffff888092af0e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [  608.288984][  T291]
> > [  608.289107][ T5411] ==================================================================
> > [  608.289285][ T5411] Disabling lock debugging due to kernel taint
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
> >
> 
> I carefully analyzed the patch I submitted, and I feel that the error in the ltp test has nothing to do with the "[PATCH v2] fuse: Track process write operations in both direct and writethrough modes" patch. Can you give me some guidance on the cause of the error?

This looks like another incidence of a bug in a patch I sent to Miklos.
The fix for that was applied to fuse/for-next on 2023-11-10.  Looking
through the test logs attached to the report, it seems the robot used a
build from 11-08 which predates the fix.  If there's a way to instruct
the robot to re-run the test against the latest head of fuse/for-next,
I'd expect this to resolve.

-K

