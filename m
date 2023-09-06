Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9670F79394E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 12:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbjIFKEO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 06:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238414AbjIFKEN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:04:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4413A10C6;
        Wed,  6 Sep 2023 03:04:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94ABBC433C7;
        Wed,  6 Sep 2023 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693994648;
        bh=RZlV/34Vua6RtOG2tuKplOnqI0FsyqjllBam2o71Lr0=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=ese8C4pRWP6sY3+OCXNcdC9B9Ipym4Ex+ewzusA1Zs0AkrZPJZZY2VICLL4eKVsiI
         a8TNKVvmiffN6QZJkZY8XSy0dKpBtMBhSZI/CNr48thLuWUBpIVxOOcMopUcuDlANm
         Kun4QmDOty8OpcB8RepxUa5/x/bzCTcZJzeQOBkolfk7JxJayJD7pBnxvN503nNOUK
         94iwF1PL+EqNLU8wEGX/wGR9FV4dQk96MRZOydTcwRQ/J+zeHk2Hcd+/FH7YAGni04
         5VumWZ8CNzAzkKFtDCGxQhL2cO6NEFuhVFRjMUC44nJ3m56DRjdrA3wna1+ry5O2Ka
         O7320tIeDGr9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE12EB8FAD;
        Wed,  6 Sep 2023 10:04:08 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Subject: [PATCH 0/8] sysctl: Remove sentinel elements from arch
Date:   Wed, 06 Sep 2023 12:03:21 +0200
Message-Id: <20230906-jag-sysctl_remove_empty_elem_arch-v1-0-3935d4854248@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGlO+GQC/x3NWwqDMBBG4a3IPDcQL0jbrZQS0vGvTjEqMyIVc
 e8NffxezjnIoAKje3GQYhOTecooLwXxEKceTrpsqnxV+5tv3Cf2znbjdQyKNG8ISMu6B4xIISo
 P7lp2Lx9btMwN5c6ieMv3/3g8z/MHGVjrR3MAAAA=
To:     Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
        josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-csky@vger.kernel.org,
        Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=8530;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=yV8IUVtpYik//LpZ/IfLgtpn217RZWSw2cuIGmPdr2I=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBk+E6RSaFgJaXIBYPqWoRCs+nSM68bDy7gJkBbN
 VhSeKZt+2+JAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZPhOkQAKCRC6l81St5ZB
 T5h2C/0RyAVnXCKcWDruWBXTX/Nondl8NBwULb74ObwLNamHm0CYtKL5NwOozUcq+O0Ukkt2yRg
 sEgpDscIbsoe+TjDUKn1Sd9YYIasdB7UE4gxOPZydkJvk8sIWRf7knr7PTpBIXqSIEDBfjd2zWJ
 hqOheXtxPT+ctxIRV8mw5Y9JRlr8ECZcE5rogXAlssFCAM+ICnyGVMvG+vJtu0BRHhL+YJkn+jx
 o/tNRp5qoIgGNvjQrq+fDNXtIk+q/yn3nMo01ty6KHGYLOV0ingU/pLfSy7ougzV4vwgODMt+gA
 BG835F3bTbdXaX72HlOw8zGTzdodDr5aCoMtkLENcUrA2J5qBfCANhl22VJxxb3pbpEBm7KehFg
 e07TDiN+NCXXcLJhPsRedx6yDE75tQu4HJSORbK7wHQzXLwrTSLYdQ50E2fdqwZUk7oFmq3mDx/
 0iKUMx/8TtfqRtvuSbp11fWpXo8c2FQa36rdpra2HbhbxqpliJ+Vpv0bDJVgmtRYlPZBQ=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Joel Granados <j.granados@samsung.com>

What?
These commits remove the sentinel element (last empty element) from the
sysctl arrays of all the files under the "arch/" directory that use a
sysctl array for registration. The merging of the preparation patches
(in https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
to mainline allows us to just remove sentinel elements without changing
behavior (more info on how this was done here [1]).

These commits are part of a bigger set (bigger patchset here
https://github.com/Joelgranados/linux/tree/tag/sysctl_remove_empty_elem_V4)
that remove the ctl_table sentinel. The idea is to make the review
process easier by chunking the 52 commits into manageable pieces. By
sending out one chunk at a time, they can be reviewed separately without
noise from parallel sets. After the "arch/" commits in this set are
reviewed, I will continue with drivers/*, fs/*, kernel/*, net/* and
miscellaneous. The final set will remove the unneeded check for
->procname == NULL.

Why?
By removing the sysctl sentinel elements we avoid kernel bloat as
ctl_table arrays get moved out of kernel/sysctl.c into their own
respective subsystems. This move was started long ago to avoid merge
conflicts; the sentinel removal bit came after Mathew Wilcox suggested
it to avoid bloating the kernel by one element as arrays moved out. This
patchset will reduce the overall build time size of the kernel and run
time memory bloat by about ~64 bytes per declared ctl_table array. I
have consolidated some links that shed light on the history of this
effort [2].

Testing:
* Ran sysctl selftests (./tools/testing/selftests/sysctl/sysctl.sh)
* Ran this through 0-day with no errors or warnings

Size saving after removing all sentinels:
  A consequence of eventually removing all the sentinels (64 bytes per
  sentinel) is the bytes we save. These are *not* numbers that we will
  get after this patch set; these are the numbers that we will get after
  removing all the sentinels. I included them here because they are
  relevant and to get an idea of just how much memory we are talking
  about.
    * bloat-o-meter:
        - The "yesall" configuration results save 9158 bytes (bloat-o-meter output here
          https://lore.kernel.org/all/20230621091000.424843-1-j.granados@samsung.com/)
        - The "tiny" config + CONFIG_SYSCTL save 1215 bytes (bloat-o-meter output here
          https://lore.kernel.org/all/20230809105006.1198165-1-j.granados@samsung.com/)
    * memory usage:
        we save some bytes in main memory as well. In my testing kernel
        I measured a difference of 7296 bytes. I include the way to
        measure in [3]

Size saving after this patchset:
  Here I give the values that I measured for the architecture that I'm
  running (x86_64). This can give an approximation of how many bytes are
  saved for each arch. I won't publish for all the archs because I don't
  have access to all of them.
    * bloat-o-meter
        - The "yesall" config saves 192 bytes (bloat-o-meter output [4])
        - The "tiny" config saves 64 bytes (bloat-o-meter output [5])
    * memory usage:
        In this case there were no bytes saved. To measure it comment the
        printk in `new_dir` and uncomment the if conditional in `new_links`
        [3].

Comments/feedback greatly appreciated

Best
Joel

[1]
We are able to remove a sentinel table without behavioral change by
introducing a table_size argument in the same place where procname is
checked for NULL. The idea is for it to keep stopping when it hits
->procname == NULL, while the sentinel is still present. And when the
sentinel is removed, it will stop on the table_size. You can go to 
(https://lore.kernel.org/all/20230809105006.1198165-1-j.granados@samsung.com/)
for more information.

[2]
Links Related to the ctl_table sentinel removal:
* Good summary from Luis sent with the "pull request" for the
  preparation patches.
  https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/
* Another very good summary from Luis.
  https://lore.kernel.org/all/ZMFizKFkVxUFtSqa@bombadil.infradead.org/
* This is a patch set that replaces register_sysctl_table with register_sysctl
  https://lore.kernel.org/all/20230302204612.782387-1-mcgrof@kernel.org/
* Patch set to deprecate register_sysctl_paths()
  https://lore.kernel.org/all/20230302202826.776286-1-mcgrof@kernel.org/
* Here there is an explicit expectation for the removal of the sentinel element.
  https://lore.kernel.org/all/20230321130908.6972-1-frank.li@vivo.com
* The "ARRAY_SIZE" approach was mentioned (proposed?) in this thread
  https://lore.kernel.org/all/20220220060626.15885-1-tangmeng@uniontech.com

[3]
To measure the in memory savings apply this on top of this patchset.

"
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c88854df0b62..e0073a627bac 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -976,6 +976,8 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
        table[0].procname = new_name;
        table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
        init_header(&new->header, set->dir.header.root, set, node, table, 1);
+       // Counts additional sentinel used for each new dir.
+       printk("%ld sysctl saved mem kzalloc \n", sizeof(struct ctl_table));

        return new;
 }
@@ -1199,6 +1201,9 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
                link_name += len;
                link++;
        }
+       // Counts additional sentinel used for each new registration
+       //if ((head->ctl_table + head->ctl_table_size)->procname)
+               printk("%ld sysctl saved mem kzalloc \n", sizeof(struct ctl_table));
        init_header(links, dir->header.root, dir->header.set, node, link_table,
                    head->ctl_table_size);
        links->nreg = nr_entries;
"
and then run the following bash script in the kernel:

accum=0
for n in $(dmesg | grep kzalloc | awk '{print $3}') ; do
    echo $n
    accum=$(calc "$accum + $n")
done
echo $accum

[4]
add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-192 (-192)
Function                                     old     new   delta
sld_sysctls                                  128      64     -64
itmt_kern_table                              128      64     -64
abi_table2                                   128      64     -64
Total: Before=429173594, After=429173402, chg -0.00%

[5]
add/remove: 0/0 grow/shrink: 1/0 up/down: 64/0 (64)
Function                                     old     new   delta
sld_sysctls                                   64     128     +64
Total: Before=1886119, After=1886183, chg +0.00%

Signed-off-by: Joel Granados <j.granados@samsung.com>

---

---
Joel Granados (8):
      S390: Remove sentinel elem from ctl_table arrays
      arm: Remove sentinel elem from ctl_table arrays
      arch/x86: Remove sentinel elem from ctl_table arrays
      x86 vdso: rm sentinel element from ctl_table array
      riscv: Remove sentinel element from ctl_table array
      powerpc: Remove sentinel element from ctl_table arrays
      ia64: Remove sentinel element from ctl_table array
      c-sky: rm sentinel element from ctl_talbe array

 arch/arm/kernel/isa.c                     | 4 ++--
 arch/arm64/kernel/armv8_deprecated.c      | 8 +++-----
 arch/arm64/kernel/fpsimd.c                | 6 ++----
 arch/arm64/kernel/process.c               | 3 +--
 arch/csky/abiv1/alignment.c               | 3 +--
 arch/ia64/kernel/crash.c                  | 3 +--
 arch/powerpc/kernel/idle.c                | 3 +--
 arch/powerpc/platforms/pseries/mobility.c | 3 +--
 arch/riscv/kernel/vector.c                | 3 +--
 arch/s390/appldata/appldata_base.c        | 6 ++----
 arch/s390/kernel/debug.c                  | 3 +--
 arch/s390/kernel/topology.c               | 3 +--
 arch/s390/mm/cmm.c                        | 3 +--
 arch/s390/mm/pgalloc.c                    | 3 +--
 arch/x86/entry/vdso/vdso32-setup.c        | 3 +--
 arch/x86/kernel/cpu/intel.c               | 3 +--
 arch/x86/kernel/itmt.c                    | 3 +--
 drivers/perf/arm_pmuv3.c                  | 3 +--
 18 files changed, 23 insertions(+), 43 deletions(-)
---
base-commit: 708283abf896dd4853e673cc8cba70acaf9bf4ea
change-id: 20230904-jag-sysctl_remove_empty_elem_arch-81db0a6e6cc4

Best regards,
-- 
Joel Granados <j.granados@samsung.com>

