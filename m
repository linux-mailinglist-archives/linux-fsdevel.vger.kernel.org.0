Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D970716C29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 20:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjE3SWC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 14:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjE3SV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 14:21:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF81FF;
        Tue, 30 May 2023 11:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685470916; x=1717006916;
  h=date:from:to:cc:subject:message-id;
  bh=cxvJZD0mWTbcPlz8XjjrAt5OXYm/YdsfjEZbFbCffNI=;
  b=hNNHy8vCMm0qFxiZopKFRQeZrNGTvpvMYhX+0GPmeGFGK64L3x8qGesP
   q9lc6WEZ3k3Y7efTZqVssArtQ0jLTkGKAAyw7LpiGC/dCPAB9TvIICn9S
   NyC1Q1xEQj611drFwxXZZLA+NoWPXX1tm/e9r/yVE/LPDdlZ4O849yfRL
   3xI/OZIBd6hhO+nTGK7bfKRXPyrPMwngT/jxksYrsVh7xtsbehJEInUHW
   pGNM0D8+XWNZuVc54itkIRpgRnxo7oTVOTdEkLw+MR9Jg7cbKkacEe5kN
   v26DKmSJgGAiEsjdmYkNTDG+QIs6IktfH2PjanekClZWcwYW8nbiHPat6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="383267123"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="383267123"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 11:21:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="709727323"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="709727323"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 May 2023 11:21:35 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q43yR-0000jV-12;
        Tue, 30 May 2023 18:21:35 +0000
Date:   Wed, 31 May 2023 02:21:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        dri-devel@lists.freedesktop.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: [linux-next:master] BUILD REGRESSION
 8c33787278ca8db73ad7d23f932c8c39b9f6e543
Message-ID: <20230530182123.UilBt%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 8c33787278ca8db73ad7d23f932c8c39b9f6e543  Add linux-next specific files for 20230530

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202305070840.X0G3ofjl-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

include/drm/drm_print.h:456:39: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/arm64/kvm/mmu.c:147:3-9: preceding lock on line 140
fs/smb/client/cifsfs.c:982 cifs_smb3_do_mount() warn: possible memory leak of 'cifs_sb'
fs/smb/client/cifssmb.c:4089 CIFSFindFirst() warn: missing error code? 'rc'
fs/smb/client/cifssmb.c:4216 CIFSFindNext() warn: missing error code? 'rc'
fs/smb/client/connect.c:2725 cifs_match_super() error: 'tlink' dereferencing possible ERR_PTR()
fs/smb/client/connect.c:2924 generic_ip_connect() error: we previously assumed 'socket' could be null (see line 2912)
fs/smb/server/oplock.c:1013 find_same_lease_key() warn: missing error code 'err'
fs/smb/server/smb2pdu.c:529 smb2_allocate_rsp_buf() warn: Please consider using kvzalloc instead of kvmalloc
fs/smb/server/smb2pdu.c:6070 smb2_read_pipe() warn: Please consider using kvzalloc instead of kvmalloc
fs/smb/server/smb2pdu.c:6222 smb2_read() warn: Please consider using kvzalloc instead of kvmalloc
fs/smb/server/smb2pdu.c:6371 smb2_write_rdma_channel() warn: Please consider using kvzalloc instead of kvmalloc
fs/smb/server/smb_common.c:350 smb1_allocate_rsp_buf() warn: Please consider using kzalloc instead of kmalloc
fs/smb/server/transport_ipc.c:232 ipc_msg_alloc() warn: Please consider using kvzalloc instead of kvmalloc
fs/smb/server/transport_ipc.c:271 handle_response() warn: Please consider using kvzalloc instead of kvmalloc
fs/smb/server/vfs.c:431 ksmbd_vfs_stream_write() warn: Please consider using kvzalloc instead of kvmalloc
fs/smb/server/vfs.c:833 ksmbd_vfs_listxattr() warn: Please consider using kvzalloc instead of kvmalloc
kernel/events/uprobes.c:478 uprobe_write_opcode() warn: passing zero to 'PTR_ERR'
m68k-linux-ld: section .rodata VMA [00001000,001556af] overlaps section .text VMA [00000400,006ed04f]
mm/mempolicy.c:1222 new_folio() error: uninitialized symbol 'address'.

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-randconfig-c031-20230530
|   `-- arch-arm64-kvm-mmu.c:preceding-lock-on-line
|-- i386-allyesconfig
|   `-- include-drm-drm_print.h:error:format-ld-expects-argument-of-type-long-int-but-argument-has-type-size_t-aka-unsigned-int
|-- i386-randconfig-m021-20230530
|   |-- fs-smb-client-cifsfs.c-cifs_smb3_do_mount()-warn:possible-memory-leak-of-cifs_sb
|   |-- fs-smb-client-cifssmb.c-CIFSFindFirst()-warn:missing-error-code-rc
|   |-- fs-smb-client-cifssmb.c-CIFSFindNext()-warn:missing-error-code-rc
|   |-- fs-smb-client-connect.c-cifs_match_super()-error:tlink-dereferencing-possible-ERR_PTR()
|   `-- fs-smb-client-connect.c-generic_ip_connect()-error:we-previously-assumed-socket-could-be-null-(see-line-)
|-- m68k-randconfig-m031-20230530
|   `-- m68k-linux-ld:section-.rodata-VMA-00001556af-overlaps-section-.text-VMA-00000ed04f
|-- s390-randconfig-s031-20230530
|   `-- mm-filemap.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
`-- x86_64-randconfig-m001-20230530
    |-- fs-smb-client-cifsfs.c-cifs_smb3_do_mount()-warn:possible-memory-leak-of-cifs_sb
    |-- fs-smb-client-cifssmb.c-CIFSFindFirst()-warn:missing-error-code-rc
    |-- fs-smb-client-cifssmb.c-CIFSFindNext()-warn:missing-error-code-rc
    |-- fs-smb-client-connect.c-cifs_match_super()-error:tlink-dereferencing-possible-ERR_PTR()
    |-- fs-smb-client-connect.c-generic_ip_connect()-error:we-previously-assumed-socket-could-be-null-(see-line-)
    |-- fs-smb-server-oplock.c-find_same_lease_key()-warn:missing-error-code-err
    |-- fs-smb-server-smb2pdu.c-smb2_allocate_rsp_buf()-warn:Please-consider-using-kvzalloc-instead-of-kvmalloc
    |-- fs-smb-server-smb2pdu.c-smb2_read()-warn:Please-consider-using-kvzalloc-instead-of-kvmalloc
    |-- fs-smb-server-smb2pdu.c-smb2_read_pipe()-warn:Please-consider-using-kvzalloc-instead-of-kvmalloc
    |-- fs-smb-server-smb2pdu.c-smb2_write_rdma_channel()-warn:Please-consider-using-kvzalloc-instead-of-kvmalloc
    |-- fs-smb-server-smb_common.c-smb1_allocate_rsp_buf()-warn:Please-consider-using-kzalloc-instead-of-kmalloc
    |-- fs-smb-server-transport_ipc.c-handle_response()-warn:Please-consider-using-kvzalloc-instead-of-kvmalloc
    |-- fs-smb-server-transport_ipc.c-ipc_msg_alloc()-warn:Please-consider-using-kvzalloc-instead-of-kvmalloc
    |-- fs-smb-server-vfs.c-ksmbd_vfs_listxattr()-warn:Please-consider-using-kvzalloc-instead-of-kvmalloc
    |-- fs-smb-server-vfs.c-ksmbd_vfs_stream_write()-warn:Please-consider-using-kvzalloc-instead-of-kvmalloc
    |-- kernel-events-uprobes.c-uprobe_write_opcode()-warn:passing-zero-to-PTR_ERR
    `-- mm-mempolicy.c-new_folio()-error:uninitialized-symbol-address-.

elapsed time: 721m

configs tested: 159
configs skipped: 6

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                  randconfig-r004-20230530   gcc  
arc                  randconfig-r043-20230530   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230530   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r034-20230530   clang
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r006-20230530   clang
hexagon              randconfig-r041-20230530   clang
hexagon              randconfig-r045-20230530   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230530   clang
i386                 randconfig-i002-20230530   clang
i386                 randconfig-i003-20230530   clang
i386                 randconfig-i004-20230530   clang
i386                 randconfig-i005-20230530   clang
i386                 randconfig-i006-20230530   clang
i386                 randconfig-i011-20230530   gcc  
i386                 randconfig-i012-20230530   gcc  
i386                 randconfig-i013-20230530   gcc  
i386                 randconfig-i014-20230530   gcc  
i386                 randconfig-i015-20230530   gcc  
i386                 randconfig-i016-20230530   gcc  
i386                 randconfig-i051-20230530   clang
i386                 randconfig-i052-20230530   clang
i386                 randconfig-i053-20230530   clang
i386                 randconfig-i054-20230530   clang
i386                 randconfig-i055-20230530   clang
i386                 randconfig-i056-20230530   clang
i386                 randconfig-i061-20230530   clang
i386                 randconfig-i062-20230530   clang
i386                 randconfig-i063-20230530   clang
i386                 randconfig-i064-20230530   clang
i386                 randconfig-i065-20230530   clang
i386                 randconfig-i066-20230530   clang
i386                 randconfig-i071-20230530   gcc  
i386                 randconfig-i072-20230530   gcc  
i386                 randconfig-i073-20230530   gcc  
i386                 randconfig-i074-20230530   gcc  
i386                 randconfig-i075-20230530   gcc  
i386                 randconfig-i076-20230530   gcc  
i386                 randconfig-i081-20230530   gcc  
i386                 randconfig-i082-20230530   gcc  
i386                 randconfig-i083-20230530   gcc  
i386                 randconfig-i084-20230530   gcc  
i386                 randconfig-i085-20230530   gcc  
i386                 randconfig-i086-20230530   gcc  
i386                 randconfig-i091-20230530   clang
i386                 randconfig-i092-20230530   clang
i386                 randconfig-i093-20230530   clang
i386                 randconfig-i094-20230530   clang
i386                 randconfig-i095-20230530   clang
i386                 randconfig-i096-20230530   clang
i386                 randconfig-r016-20230530   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r025-20230530   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230530   gcc  
microblaze   buildonly-randconfig-r004-20230530   gcc  
microblaze   buildonly-randconfig-r005-20230530   gcc  
microblaze           randconfig-r022-20230530   gcc  
microblaze           randconfig-r033-20230530   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                 randconfig-r013-20230530   clang
mips                           xway_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230530   gcc  
openrisc     buildonly-randconfig-r003-20230530   gcc  
openrisc             randconfig-r005-20230530   gcc  
openrisc             randconfig-r012-20230530   gcc  
openrisc             randconfig-r036-20230530   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r021-20230530   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230530   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230530   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230530   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r006-20230530   gcc  
sh                   randconfig-r035-20230530   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r023-20230530   gcc  
sparc64              randconfig-r032-20230530   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230530   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230530   clang
x86_64               randconfig-a002-20230530   clang
x86_64               randconfig-a003-20230530   clang
x86_64               randconfig-a004-20230530   clang
x86_64               randconfig-a005-20230530   clang
x86_64               randconfig-a006-20230530   clang
x86_64               randconfig-a011-20230530   gcc  
x86_64               randconfig-a012-20230530   gcc  
x86_64               randconfig-a013-20230530   gcc  
x86_64               randconfig-a014-20230530   gcc  
x86_64               randconfig-a015-20230530   gcc  
x86_64               randconfig-a016-20230530   gcc  
x86_64               randconfig-r031-20230530   clang
x86_64               randconfig-x051-20230530   gcc  
x86_64               randconfig-x052-20230530   gcc  
x86_64               randconfig-x053-20230530   gcc  
x86_64               randconfig-x054-20230530   gcc  
x86_64               randconfig-x055-20230530   gcc  
x86_64               randconfig-x056-20230530   gcc  
x86_64               randconfig-x061-20230530   gcc  
x86_64               randconfig-x062-20230530   gcc  
x86_64               randconfig-x063-20230530   gcc  
x86_64               randconfig-x064-20230530   gcc  
x86_64               randconfig-x065-20230530   gcc  
x86_64               randconfig-x066-20230530   gcc  
x86_64               randconfig-x071-20230530   clang
x86_64               randconfig-x072-20230530   clang
x86_64               randconfig-x073-20230530   clang
x86_64               randconfig-x074-20230530   clang
x86_64               randconfig-x075-20230530   clang
x86_64               randconfig-x076-20230530   clang
x86_64               randconfig-x081-20230530   clang
x86_64               randconfig-x082-20230530   clang
x86_64               randconfig-x083-20230530   clang
x86_64               randconfig-x084-20230530   clang
x86_64               randconfig-x085-20230530   clang
x86_64               randconfig-x086-20230530   clang
x86_64               randconfig-x091-20230530   gcc  
x86_64               randconfig-x092-20230530   gcc  
x86_64               randconfig-x093-20230530   gcc  
x86_64               randconfig-x094-20230530   gcc  
x86_64               randconfig-x095-20230530   gcc  
x86_64               randconfig-x096-20230530   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r003-20230530   gcc  
xtensa               randconfig-r024-20230530   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
