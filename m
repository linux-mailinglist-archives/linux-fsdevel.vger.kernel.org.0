Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F0C29CB6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 22:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374329AbgJ0Vn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 17:43:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:19570 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S374314AbgJ0VnZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 17:43:25 -0400
IronPort-SDR: 3QI8nhnbkn4KTAAplQjPV1Mh9lZ6TBz4Ub4uF1S4OrH6lXIJlv2KrPdC21r02MRRbs9G3nLSjU
 yjDAgp5jmC6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="148021783"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="gz'50?scan'50,208,50";a="148021783"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 14:43:23 -0700
IronPort-SDR: uSd18dFLFLZebEuj00GEKoujsP1YMTKSiyRtSUHlnBFxYqrEuaQE9rr1kPhmRcPxkLtUMOJG+1
 h19Lcg04zFmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="gz'50?scan'50,208,50";a="468492344"
Received: from lkp-server02.sh.intel.com (HELO 74b0a1e0e619) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 27 Oct 2020 14:43:19 -0700
Received: from kbuild by 74b0a1e0e619 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXWkQ-000075-EO; Tue, 27 Oct 2020 21:43:18 +0000
Date:   Wed, 28 Oct 2020 05:42:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Woodhouse <dwmw2@infradead.org>, bonzini@redhat.com
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] kvm/eventfd: Drain events from eventfd in
 irqfd_wakeup()
Message-ID: <202010280552.K3ls9tQi-lkp@intel.com>
References: <20201027135523.646811-4-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20201027135523.646811-4-dwmw2@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi David,

I love your patch! Yet something to improve:

[auto build test ERROR on vfio/next]
[also build test ERROR on vhost/linux-next linus/master kvm/linux-next v5.10-rc1 next-20201027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/David-Woodhouse/Allow-in-kernel-consumers-to-drain-events-from-eventfd/20201027-215658
base:   https://github.com/awilliam/linux-vfio.git next
config: s390-randconfig-r023-20201027 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project f2c25c70791de95d2466e09b5b58fc37f6ccd7a4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/0day-ci/linux/commit/dc45dd9af28fede8f8dd29b705b90f78cf87538c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review David-Woodhouse/Allow-in-kernel-consumers-to-drain-events-from-eventfd/20201027-215658
        git checkout dc45dd9af28fede8f8dd29b705b90f78cf87538c
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:72:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:119:21: note: expanded from macro '__swab32'
           ___constant_swab32(x) :                 \
                              ^
   include/uapi/linux/swab.h:21:12: note: expanded from macro '___constant_swab32'
           (((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |            \
                     ^
   In file included from arch/s390/kvm/../../../virt/kvm/eventfd.c:12:
   In file included from include/linux/kvm_host.h:32:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:36:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:72:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:119:21: note: expanded from macro '__swab32'
           ___constant_swab32(x) :                 \
                              ^
   include/uapi/linux/swab.h:22:12: note: expanded from macro '___constant_swab32'
           (((__u32)(x) & (__u32)0xff000000UL) >> 24)))
                     ^
   In file included from arch/s390/kvm/../../../virt/kvm/eventfd.c:12:
   In file included from include/linux/kvm_host.h:32:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:36:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:72:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:120:12: note: expanded from macro '__swab32'
           __fswab32(x))
                     ^
   In file included from arch/s390/kvm/../../../virt/kvm/eventfd.c:12:
   In file included from include/linux/kvm_host.h:32:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:36:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:72:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> arch/s390/kvm/../../../virt/kvm/eventfd.c:197:23: error: incompatible pointer types passing 'struct eventfd_ctx **' to parameter of type 'struct eventfd_ctx *'; remove & [-Werror,-Wincompatible-pointer-types]
                   eventfd_ctx_do_read(&irqfd->eventfd, &cnt);
                                       ^~~~~~~~~~~~~~~
   include/linux/eventfd.h:44:46: note: passing argument to parameter 'ctx' here
   void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
                                                ^
   20 warnings and 1 error generated.

vim +197 arch/s390/kvm/../../../virt/kvm/eventfd.c

   180	
   181	/*
   182	 * Called with wqh->lock held and interrupts disabled
   183	 */
   184	static int
   185	irqfd_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
   186	{
   187		struct kvm_kernel_irqfd *irqfd =
   188			container_of(wait, struct kvm_kernel_irqfd, wait);
   189		__poll_t flags = key_to_poll(key);
   190		struct kvm_kernel_irq_routing_entry irq;
   191		struct kvm *kvm = irqfd->kvm;
   192		unsigned seq;
   193		int idx;
   194	
   195		if (flags & EPOLLIN) {
   196			u64 cnt;
 > 197			eventfd_ctx_do_read(&irqfd->eventfd, &cnt);
   198	
   199			idx = srcu_read_lock(&kvm->irq_srcu);
   200			do {
   201				seq = read_seqcount_begin(&irqfd->irq_entry_sc);
   202				irq = irqfd->irq_entry;
   203			} while (read_seqcount_retry(&irqfd->irq_entry_sc, seq));
   204			/* An event has been signaled, inject an interrupt */
   205			if (kvm_arch_set_irq_inatomic(&irq, kvm,
   206						      KVM_USERSPACE_IRQ_SOURCE_ID, 1,
   207						      false) == -EWOULDBLOCK)
   208				schedule_work(&irqfd->inject);
   209			srcu_read_unlock(&kvm->irq_srcu, idx);
   210		}
   211	
   212		if (flags & EPOLLHUP) {
   213			/* The eventfd is closing, detach from KVM */
   214			unsigned long iflags;
   215	
   216			spin_lock_irqsave(&kvm->irqfds.lock, iflags);
   217	
   218			/*
   219			 * We must check if someone deactivated the irqfd before
   220			 * we could acquire the irqfds.lock since the item is
   221			 * deactivated from the KVM side before it is unhooked from
   222			 * the wait-queue.  If it is already deactivated, we can
   223			 * simply return knowing the other side will cleanup for us.
   224			 * We cannot race against the irqfd going away since the
   225			 * other side is required to acquire wqh->lock, which we hold
   226			 */
   227			if (irqfd_is_active(irqfd))
   228				irqfd_deactivate(irqfd);
   229	
   230			spin_unlock_irqrestore(&kvm->irqfds.lock, iflags);
   231		}
   232	
   233		return 0;
   234	}
   235	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--9amGYk9869ThD9tj
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
rgEA

--9amGYk9869ThD9tj--
