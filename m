Return-Path: <linux-fsdevel+bounces-2698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B037E793B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 07:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746D91C20D5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 06:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED70A63C0;
	Fri, 10 Nov 2023 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D563A8
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 06:23:56 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3138F6F84;
	Thu,  9 Nov 2023 22:23:54 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SRTKn1lQVzfb9S;
	Fri, 10 Nov 2023 14:23:41 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 10 Nov 2023 14:23:51 +0800
Message-ID: <95e79046-f148-4ac2-8fd6-1379a78e744b@huawei.com>
Date: Fri, 10 Nov 2023 14:23:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next V2] proc: support file->f_pos checking in mem_lseek
To: kernel test robot <lkp@intel.com>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <akpm@linux-foundation.org>, <oleg@redhat.com>,
	<jlayton@kernel.org>, <dchinner@redhat.com>, <cyphar@cyphar.com>,
	<shr@devkernel.io>
CC: <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<yangerkun@huawei.com>
References: <20231109102658.2075547-1-wozizhi@huawei.com>
 <202311101239.ihy4cKpf-lkp@intel.com>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <202311101239.ihy4cKpf-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500020.china.huawei.com (7.185.36.49)
X-CFilter-Loop: Reflected

I have missed fallthrough, and will fix it in V3.

Thanks,
Zizhi Wo

在 2023/11/10 12:34, kernel test robot 写道:
> Hi WoZ1zh1,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on next-20231108]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/WoZ1zh1/proc-support-file-f_pos-checking-in-mem_lseek/20231109-103353
> base:   next-20231108
> patch link:    https://lore.kernel.org/r/20231109102658.2075547-1-wozizhi%40huawei.com
> patch subject: [PATCH -next V2] proc: support file->f_pos checking in mem_lseek
> config: um-allnoconfig (https://download.01.org/0day-ci/archive/20231110/202311101239.ihy4cKpf-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311101239.ihy4cKpf-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311101239.ihy4cKpf-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     In file included from fs/proc/base.c:68:
>     In file included from include/linux/swap.h:9:
>     In file included from include/linux/memcontrol.h:13:
>     In file included from include/linux/cgroup.h:26:
>     In file included from include/linux/kernel_stat.h:9:
>     In file included from include/linux/interrupt.h:11:
>     In file included from include/linux/hardirq.h:11:
>     In file included from arch/um/include/asm/hardirq.h:5:
>     In file included from include/asm-generic/hardirq.h:17:
>     In file included from include/linux/irq.h:20:
>     In file included from include/linux/io.h:13:
>     In file included from arch/um/include/asm/io.h:24:
>     include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       547 |         val = __raw_readb(PCI_IOBASE + addr);
>           |                           ~~~~~~~~~~ ^
>     include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>           |                                                         ~~~~~~~~~~ ^
>     include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
>        37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>           |                                                   ^
>     In file included from fs/proc/base.c:68:
>     In file included from include/linux/swap.h:9:
>     In file included from include/linux/memcontrol.h:13:
>     In file included from include/linux/cgroup.h:26:
>     In file included from include/linux/kernel_stat.h:9:
>     In file included from include/linux/interrupt.h:11:
>     In file included from include/linux/hardirq.h:11:
>     In file included from arch/um/include/asm/hardirq.h:5:
>     In file included from include/asm-generic/hardirq.h:17:
>     In file included from include/linux/irq.h:20:
>     In file included from include/linux/io.h:13:
>     In file included from arch/um/include/asm/io.h:24:
>     include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
>           |                                                         ~~~~~~~~~~ ^
>     include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
>        35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>           |                                                   ^
>     In file included from fs/proc/base.c:68:
>     In file included from include/linux/swap.h:9:
>     In file included from include/linux/memcontrol.h:13:
>     In file included from include/linux/cgroup.h:26:
>     In file included from include/linux/kernel_stat.h:9:
>     In file included from include/linux/interrupt.h:11:
>     In file included from include/linux/hardirq.h:11:
>     In file included from arch/um/include/asm/hardirq.h:5:
>     In file included from include/asm-generic/hardirq.h:17:
>     In file included from include/linux/irq.h:20:
>     In file included from include/linux/io.h:13:
>     In file included from arch/um/include/asm/io.h:24:
>     include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       584 |         __raw_writeb(value, PCI_IOBASE + addr);
>           |                             ~~~~~~~~~~ ^
>     include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
>           |                                                       ~~~~~~~~~~ ^
>     include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
>           |                                                       ~~~~~~~~~~ ^
>     include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       692 |         readsb(PCI_IOBASE + addr, buffer, count);
>           |                ~~~~~~~~~~ ^
>     include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       700 |         readsw(PCI_IOBASE + addr, buffer, count);
>           |                ~~~~~~~~~~ ^
>     include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       708 |         readsl(PCI_IOBASE + addr, buffer, count);
>           |                ~~~~~~~~~~ ^
>     include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       717 |         writesb(PCI_IOBASE + addr, buffer, count);
>           |                 ~~~~~~~~~~ ^
>     include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       726 |         writesw(PCI_IOBASE + addr, buffer, count);
>           |                 ~~~~~~~~~~ ^
>     include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       735 |         writesl(PCI_IOBASE + addr, buffer, count);
>           |                 ~~~~~~~~~~ ^
>>> fs/proc/base.c:912:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>       912 |         case SEEK_SET:
>           |         ^
>     fs/proc/base.c:912:2: note: insert '__attribute__((fallthrough));' to silence this warning
>       912 |         case SEEK_SET:
>           |         ^
>           |         __attribute__((fallthrough));
>     fs/proc/base.c:912:2: note: insert 'break;' to avoid fall-through
>       912 |         case SEEK_SET:
>           |         ^
>           |         break;
>     13 warnings generated.
> 
> 
> vim +912 fs/proc/base.c
> 
>     903	
>     904	loff_t mem_lseek(struct file *file, loff_t offset, int orig)
>     905	{
>     906		loff_t ret = 0;
>     907	
>     908		spin_lock(&file->f_lock);
>     909		switch (orig) {
>     910		case SEEK_CUR:
>     911			offset += file->f_pos;
>   > 912		case SEEK_SET:
>     913			/* to avoid userland mistaking f_pos=-9 as -EBADF=-9 */
>     914			if ((unsigned long long)offset >= -MAX_ERRNO)
>     915				ret = -EOVERFLOW;
>     916			break;
>     917		default:
>     918			ret = -EINVAL;
>     919		}
>     920		if (!ret) {
>     921			if (offset < 0 && !(unsigned_offsets(file))) {
>     922				ret = -EINVAL;
>     923			} else {
>     924				file->f_pos = offset;
>     925				ret = file->f_pos;
>     926				force_successful_syscall_return();
>     927			}
>     928		}
>     929	
>     930		spin_unlock(&file->f_lock);
>     931		return ret;
>     932	}
>     933	
> 

