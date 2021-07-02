Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF63B3B9D7C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 10:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhGBI1C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 04:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhGBI06 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:26:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A67C061762
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jul 2021 01:24:26 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id hc16so14856466ejc.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jul 2021 01:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=dDRz6/VYbMyas+o8OnxP0VGQdhTZbTnmcDCVY0Sy0dc=;
        b=n8vtxksLgY0C+Bm7yrRzOj6uGpzrtB23sZ3EKbPYqHZvO063ENz6gFO3cC5ONUkSAv
         rPxKks3l7H7GzRwz3cGB4JPnWbY+xZZGbJiBv2JY/CBvbp+Bb3nGU4vDx0mno80ldJts
         RPDp/CZPw8LYkovm7lOxjsLwrPU8jpqxBmUePPjitNYQQkhhV0WmR2u0qAqpmu59g41h
         mgXPgU02XnrNmPSvzoksKcroEekqa7fgRQB4veP7UJ+5dEee9SmmxS/cirWBnq7SOCZy
         XCAz/tMz/q89XJ1DhQ9tEaKEfxbmvYv5aIFJNNRzbsOAhoPt3csmUb0TZskZgQNxW52s
         mJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=dDRz6/VYbMyas+o8OnxP0VGQdhTZbTnmcDCVY0Sy0dc=;
        b=lZ2bgUslyWNdT2lv0Ra/k6fJ55YfaQzeTbbas3g4/QHmeGyIpzcFkLO4WRoWnHOXBN
         sRRBORU4JiZtI+9GGWTS9lB+h5Lv+UOK2y3pcbixK/GFVjreiWhwebuUHP3U7dRdUDZ3
         uFTT69x8yyltL14SVbXkXqTAGqnRmBTWhLFxZ13qu6Ag8FTdv6TChyuWUSzvoRNWWHAG
         b98DGcy2yTlL/BpY+k1oQGqFy7CEt9sV3FEGScxvtmB4INnHfpTcWZRD0ESQbWCPJWGc
         HWecVMh3ekgwBxAOt3YnYoKNBWSnTACV5Fr2Hk3dgxouAoRvCnCfKe9h+vou72sHdsj2
         tnoQ==
X-Gm-Message-State: AOAM530e64U6OBLyq15egIIMI0mbefEZjQLbLO0L9aNz8Hv5SWbg6JAc
        iMHoIdd78EdiWwxStiMxvIz0XBiT/WsopqNUjfX1SnCQnibbg2pL
X-Google-Smtp-Source: ABdhPJwhCSd4v8T+xr+NvxT2dvOKhn4ioo2C6Q+ti2+Vk/CyqZ4l08msHnK8tHrgXt3ge/2qYQRU9F51rlK2eVZU/dk=
X-Received: by 2002:a17:906:bc83:: with SMTP id lv3mr4104231ejb.133.1625214263610;
 Fri, 02 Jul 2021 01:24:23 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 2 Jul 2021 13:54:12 +0530
Message-ID: <CA+G9fYuBvh-H8Vqp58j-coXUD8p1A6h2it_aZdRiYcN2soGNdg@mail.gmail.com>
Subject: [mainline] [arm64] Internal error: Oops - percpu_counter_add_batch
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Tso <tytso@mit.edu>, lkft-triage@lists.linaro.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jens Axboe <axboe@kernel.dk>, Zhang Yi <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Results from Linaro=E2=80=99s test farm.
Regression found on arm64 on Linux mainline tree.

The following kernel crash was noticed while running LTP fs_fill test case =
on
arm64 devices Linus ' mainline tree (this is not yet tagged / released).

This regression  / crash is easy to reproduce.

fs_fill.c:53: TINFO: Unlinking mntpoint/thread6/file2
fs_fill.c:87: TPASS: Got 6 ENOSPC runtime 3847ms
[ 1140.055715] Unable to handle kernel paging request at virtual
address ffff76a8a6b59000
[ 1140.058338] Mem abort info:
[ 1140.059216]   ESR =3D 0x96000004
[ 1140.060366]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[ 1140.062013]   SET =3D 0, FnV =3D 0
[ 1140.062959]   EA =3D 0, S1PTW =3D 0
[ 1140.064001]   FSC =3D 0x04: level 0 translation fault
[ 1140.065496] Data abort info:
[ 1140.066389]   ISV =3D 0, ISS =3D 0x00000004
[ 1140.067556]   CM =3D 0, WnR =3D 0
[ 1140.068600] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000041e180=
00
[ 1140.070627] [ffff76a8a6b59000] pgd=3D0000000000000000, p4d=3D00000000000=
00000
[ 1140.072794] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[ 1140.074473] Modules linked in: btrfs blake2b_generic libcrc32c xor
xor_neon zstd_compress raid6_pq tun rfkill crct10dif_ce fuse
[ 1140.077
93Br9o]a dCcPaUs: 0 PID: 8478t  mCeosmsma:g ef sf_rfoim sylslt eNot
taintedm d5-.j1o3u.r0n a#l1d@
juno[  (1F1r4i0 .20082110-8057]- 0H2a r0d6w:5a2r:e3 6n aUmTeC:) :linux,
dumm
y-kveirrnte l([D2T4)7]
: [ 1[1 4101.4007.20789349]0 2I]n tpesrtnaatle :e r8r0o0r0:0 00O5o
p(sN:z c9v6 0d0a0i0f0 4- P[A#N1 ]- UPAROE E-MTPCTO  SBMTPYPE=3D--
)
[ 1140.087819] pc : percpu_counter_add_batch+0x34/0x140
[ 1140.089436] lr : percpu_counter_add_batch+0x2c/0x140
[ 1140.091033] sp : ffff8000114ebaf0
[ 1140.092122] x29: ffff8000114ebaf0 x28: ffff1f3342f8ac40 x27: 00000000000=
00000
[ 1140.094330] x26: 0000000000000000 x25: 0000000000000002 x24: 00000000000=
00001
[ 1140.096579] x23: ffff1f3342f8ac40 x22: ffff1f334391ec50 x21: 00000000000=
00020
[ 1140.098772] x20: ffffffffffffffff x19: ffff1f334391eb80 x18: 00000000000=
00000
[ 1140.101012] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000000=
00000
[ 1140.103222] x14: 0000000000000004 x13: 0000000000000000 x12: ffff1f3344e=
6e630
[ 1140.105431] x11: ffff1f334054dda8 x10: 0000000000000a50 x9 : ffffa88ad74=
0491c
[ 1140.107653] x8 : ffff1f3342f8b6f0 x7 : 0000000000000000 x6 : 00000000000=
00001
[ 1140.109869] x5 : ffffa88ad93bf260 x4 : ffffa88ad93bf000 x3 : 00000000000=
00000
[ 1140.112108] x2 : 0000000000000002 x1 : ffff76a8a6b59000 x0 : 00000000000=
00000
[ 1140.114298] Call trace:
[ 1140.115107]  percpu_counter_add_batch+0x34/0x140
[ 1140.116578]  __jbd2_journal_remove_checkpoint+0x84/0x20c
[ 1140.118237]  jbd2_log_do_checkpoint+0xbc/0x424
[ 1140.119659]  jbd2_journal_destroy+0x11c/0x2dc
[ 1140.121043]  ext4_put_super+0x8c/0x3c0
[ 1140.122226]  generic_shutdown_super+0x80/0x110
[ 1140.123651]  kill_block_super+0x2c/0x74
[ 1140.124882]  deactivate_locked_super+0x58/0xdc
[ 1140.126274]  deactivate_super+0x80/0xa0
[ 1140.127516]  cleanup_mnt+0xe4/0x180
[ 1140.128637]  __cleanup_mnt+0x20/0x2c
[ 1140.129766]  task_work_run+0x90/0x190
[ 1140.130920]  do_notify_resume+0x258/0x1350
[ 1140.132267]  work_pending+0xc/0x43c
[ 1140.133381] Code: f9001bf7 97eb400b d538d081 f9401260 (b8616816)
[ 1140.135285] ---[ end trace c36233c500dfe4b8 ]---
[ 1140.136872] note: fs_fill[8478] exited with preempt_count 2

Full test log:
--------------
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.13-7637-g=
3dbdb38e2869/testrun/5034937/suite/ltp-fs-tests/test/fs_fill/log

metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git commit: 3dbdb38e286903ec220aaf1fb29a8d94297da246
  git describe: v5.13-7637-g3dbdb38e2869
  kernel-config: https://builds.tuxbuild.com/1ukJXvBf1z1X0lUo2IV4O0Q5WkQ/co=
nfig
  System.map: https://builds.tuxbuild.com/1ukJXvBf1z1X0lUo2IV4O0Q5WkQ/Syste=
m.map
  vmlinux: https://builds.tuxbuild.com/1ukJXvBf1z1X0lUo2IV4O0Q5WkQ/vmlinux.=
xz

step to reproduce:
1) use the kernel Image from above link or build your kernel with below com=
mand

# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.


tuxmake --runtime podman --target-arch arm64 --toolchain gcc-11
--kconfig defconfig --kconfig-add
https://builds.tuxbuild.com/1ukJXvBf1z1X0lUo2IV4O0Q5WkQ/config

2) Boot the qemu with below command
/usr/bin/qemu-system-aarch64 -cpu host -machine virt,accel=3Dkvm
-nographic -net nic,model=3Dvirtio,macaddr=3DBC:DD:AD:CC:09:02 -net tap -m
4096 -monitor none -kernel Image.gz --append "console=3DttyAMA0
root=3D/dev/vda rw" -hda
rpb-console-image-lkft-juno-20210525221209.rootfs.ext4 -smp 4


3) run ltp fs_fill test case
   # cd /opt/ltp
   # ./runltp -s fs_fill
   # you notice the reported crash

The git log short summary between good and bad.

$ git log --oneline dbe69e433722..3dbdb38e2869 -- fs/
c288d9cd7104 Merge tag 'for-5.14/io_uring-2021-06-30' of
git://git.kernel.dk/linux-block
911a2997a5b7 Merge tag 'fs_for_v5.14-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
a6ecc2a491e3 Merge tag 'ext4_for_linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
e149bd742b2d io_uring: code clean for kiocb_done()
915b3dde9b72 io_uring: spin in iopoll() only when reqs are in a single queu=
e
99ebe4efbd38 io_uring: pre-initialise some of req fields
5182ed2e332e io_uring: refactor io_submit_flush_completions
4cfb25bf8877 io_uring: optimise hot path restricted checks
e5dc480d4ed9 io_uring: remove not needed PF_EXITING check
dd432ea5204e io_uring: mainstream sqpoll task_work running
b2d9c3da7711 io_uring: refactor io_arm_poll_handler()
59b735aeeb0f io_uring: reduce latency by reissueing the operation
22634bc5620d io_uring: add IOPOLL and reserved field checks to
IORING_OP_UNLINKAT
ed7eb2592286 io_uring: add IOPOLL and reserved field checks to
IORING_OP_RENAMEAT
12dcb58ac785 io_uring: refactor io_openat2()
16340eab61a3 io_uring: update sqe layout build checks
fe7e32575029 io_uring: fix code style problems
1a924a808208 io_uring: refactor io_sq_thread()
948e19479cb6 io_uring: don't change sqpoll creds if not needed
16aa4c9a1fbe jbd2: export jbd2_journal_[un]register_shrinker()
d578b99443fd ext4: notify sysfs on errors_count value change
8b0ed8443ae6 writeback: fix obtain a reference to a freeing memcg css
acc6100d3ffa fs: remove bdev_try_to_free_page callback
3b672e3aedff ext4: remove bdev_try_to_free_page() callback
dbf2bab7935b jbd2: simplify journal_clean_one_cp_list()
4ba3fcdde7e3 jbd2,ext4: add a shrinker to release checkpointed buffers
214eb5a4d8a2 jbd2: remove redundant buffer io error checks
235d68069cbd jbd2: don't abort the journal when freeing buffers
fcf37549ae19 jbd2: ensure abort the journal if detect IO error when
writing original buffer back
1866cba84243 jbd2: remove the out label in __jbd2_journal_remove_checkpoint=
()
0caaefbaf2a4 ext4: no need to verify new add extent block
d07621d9b9b8 jbd2: clean up misleading comments for jbd2_fc_release_bufs
b1489186cc83 ext4: add check to prevent attempting to resize an fs
with sparse_super2
e9f9f61d0cdc ext4: consolidate checks for resize of bigalloc into
ext4_resize_begin
310c097c2bdb ext4: remove duplicate definition of ext4_xattr_ibody_inline_s=
et()
ee00d6b3c7aa ext4: fsmap: fix the block/inode bitmap comment
6d2424a84533 ext4: fix comment for s_hash_unsigned
4ce8ad95f0af io_uring: Create define to modify a SQPOLL parameter
997135017716 io_uring: Fix race condition when sqp thread goes to sleep
f9505c72b2ee ext4: use local variable ei instead of EXT4_I() macro
c89849cc0259 ext4: fix avefreec in find_group_orlov
4fb7c70a889e ext4: correct the cache_nr in tracepoint ext4_es_shrink_exit
e5e7010e5444 ext4: remove check for zero nr_to_scan in ext4_es_scan()
b2d2e7573548 ext4: remove set but rewrite variables
351a0a3fbc35 ext4: add ioctl EXT4_IOC_CHECKPOINT
01d5d96542fd ext4: add discard/zeroout flags to journal flush
ce1b06c5f5e7 quota: remove unnecessary oom message
7a778f9dc32d io_uring: improve in tctx_task_work() resubmission
16f72070386f io_uring: don't resched with empty task_list
c6538be9e488 io_uring: refactor tctx task_work list splicing
ebd0df2e6342 io_uring: optimise task_work submit flushing
3f18407dc6f2 io_uring: inline __tctx_task_work()
a3dbdf54da80 io_uring: refactor io_get_sequence()
c854357bc1b9 io_uring: clean all flags in io_clean_op() at once
1dacb4df4ebe io_uring: simplify iovec freeing in io_clean_op()
b8e64b530011 io_uring: track request creds with a flag
c10d1f986b4e io_uring: move creds from io-wq work to io_kiocb
2a2758f26df5 io_uring: refactor io_submit_flush_completions()
e6ab8991c5d0 io_uring: fix false WARN_ONCE
fe76421d1da1 io_uring: allow user configurable IO thread CPU affinity
0e03496d1967 io-wq: use private CPU mask
e8d46b384129 isofs: remove redundant continue statement
8f6840c4fd1e ext4: return error code when ext4_fill_flex_info() fails
b9a037b7f3c4 ext4: cleanup in-core orphan list if ext4_truncate()
failed to get a transaction handle
ce3aba43599f ext4: fix kernel infoleak via ext4_extent_header
618f003199c6 ext4: fix memory leak in ext4_fill_super
1fc57ca5a2cd ext4: remove redundant assignment to error
5c680150d7f4 ext4: remove redundant check buffer_uptodate()
d0b040f5f255 ext4: fix overflow in ext4_iomap_alloc()
ec16d35b6c9d io-wq: remove header files not needed anymore
236daeae3616 io_uring: Add to traces the req pointer when available
2335f6f5ddf2 io_uring: optimise io_commit_cqring()
3c19966d3710 io_uring: shove more drain bits out of hot path
10c669040e9b io_uring: switch !DRAIN fast path when possible
27f6b318dea2 io_uring: fix min types mismatch in table alloc
dd9ae8a0b298 io_uring: Fix comment of io_get_sqe
441b8a7803bf io_uring: optimise non-drain path
76cc33d79175 io_uring: refactor io_req_defer()
0499e582aaff io_uring: move uring_lock location
311997b3fcdd io_uring: wait heads renaming
5ed7a37d21b3 io_uring: clean up check_overflow flag
5e159204d7ed io_uring: small io_submit_sqe() optimisation
f18ee4cf0a27 io_uring: optimise completion timeout flushing
15641e427070 io_uring: don't cache number of dropped SQEs
17d3aeb33cda io_uring: refactor io_get_sqe()
7f1129d227ea io_uring: shuffle more fields into SQ ctx section
b52ecf8cb5b5 io_uring: move ctx->flags from SQ cacheline
c7af47cf0fab io_uring: keep SQ pointers in a single cacheline
b1b2fc3574a6 io-wq: remove redundant initialization of variable ret
fdd1dc316e89 io_uring: Fix incorrect sizeof operator for copy_from_user cal=
l
aeab9506ef50 io_uring: inline io_iter_do_read()
78cc687be9c5 io_uring: unify SQPOLL and user task cancellations
09899b19155a io_uring: cache task struct refs
2d091d62b110 io_uring: don't vmalloc rsrc tags
9123c8ffce16 io_uring: add helpers for 2 level table alloc
157d257f99c1 io_uring: remove rsrc put work irq save/restore
d878c81610e1 io_uring: hide rsrc tag copy into generic helpers
e587227b680f io-wq: simplify worker exiting
769e68371521 io-wq: don't repeat IO_WQ_BIT_EXIT check by worker
eef51daa72f7 io_uring: rename function *task_file
cb3d8972c78a io_uring: refactor io_iopoll_req_issued
382cb030469d io-wq: remove unused io-wq refcounting
c7f405d6fa36 io-wq: embed wqe ptr array into struct io_wq
976517f162a0 io_uring: fix blocking inline submission
40dad765c045 io_uring: enable shmem/memfd memory registration
d0acdee296d4 io_uring: don't bounce submit_state cachelines
d068b5068d43 io_uring: rename io_get_cqring
8f6ed49a4443 io_uring: kill cached_cq_overflow
ea5ab3b57983 io_uring: deduce cq_mask from cq_entries
a566c5562d41 io_uring: remove dependency on ring->sq/cq_entries
b13a8918d395 io_uring: better locality for rsrc fields
b986af7e2df4 io_uring: shuffle rarely used ctx fields
93d2bcd2cbfe io_uring: make fail flag not link specific
3dd0c97a9e01 io_uring: get rid of files in exit cancel
acfb381d9d71 io_uring: simplify waking sqo_sq_wait
21f2fc080f86 io_uring: remove unused park_task_work
aaa9f0f48172 io_uring: improve sq_thread waiting check
e4b6d902a9e3 io_uring: improve sqpoll event/state handling
64c2c2c62f92 quota: Change quotactl_path() systcall to an fd-based one
21e4e15a846f reiserfs: Remove unneed check in reiserfs_write_full_page()
fa236c2b2d44 udf: Fix NULL pointer dereference in udf_symlink function
a149127be52f reiserfs: add check for invalid 1st journal block

--
Linaro LKFT
https://lkft.linaro.org
