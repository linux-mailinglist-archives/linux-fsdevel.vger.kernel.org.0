Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC43240CC1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhIOSAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:00:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55907 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230203AbhIOSAN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:00:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7EB735C00F9;
        Wed, 15 Sep 2021 13:58:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 15 Sep 2021 13:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=7Q8HGeP+EDgnA
        p4Z23/+CZpTxVKtu2EPqIYAvB/bUV0=; b=adKxV/ppBDEb0yF+1MkVw4ccgRViI
        0R0v+zz3XWrWV+MCv4FO5geUlKGkShnib10uKGwCKJRIPfb6eAMi1jX6Gw3q4DMg
        FZGT8Bf82DDMppzs3EYri2QCQbQ9UimxZDFT3Vsx8p5mHqya5LgbRF/rYz10qhfQ
        1Q5KP5QzcQe6buf0D8tBmWCSghKx3tbe3Rrb/5MHsryQV0Bd/X9ZEIEif7m0P++8
        Rlx+gpZBYuw8MyT3Vm/lsZGuWJ2yKScfsMtQ9Xk4Lq+Toci30oUZWkgSLrfZoERj
        oM3++xoeRLv4UGYLTmuQuXBg9HOYmJorQhdz2C0u2utXCrlTp5M7OxByw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=7Q8HGeP+EDgnAp4Z23/+CZpTxVKtu2EPqIYAvB/bUV0=; b=EjpYIBNE
        zVcRZA9GhDcfNeHFbQ7kno/cpg57vQuA7QyXVUCTk7HBWW+71IizavKc9LqWKcHP
        HpTGncUuFfpKrBmL4ko4JkKjuXyXx/sv5lUpZcpP7jLXu9vJGoiE/bRSANa9bYkZ
        yAH2cXnzR8QIP9VeIoWoA57cg14OAgj7IME6jE7xfWEj95HxIUz7qedt/i0m0Erk
        apDcJp018uuv1l6FaabSt/4JeC3pDoZa7tfbOAN6AUxuky13+I6SbU1KtbC2clUs
        rtKfBwsRnVp/XfLniyThcHphpAmhF+iyAQHtD/RKL77ODcS9mKYi+GSIMdjqPUUs
        k9y96BrMp4lZZw==
X-ME-Sender: <xms:XTRCYb0OTFO7oE64Wg4FzG0eTYjKCTD-BDrwhKoxwt_1fKr3Dxs_hA>
    <xme:XTRCYaEw0pCXfd49c6ce1eJHkpiiWAzXZy8ubF5QXygTOgcN9LeSLeZTbx_e3GWWQ
    xqRqirXyJRWOebLfiU>
X-ME-Received: <xmr:XTRCYb6y--qmOVs3GByKo602-qZkn29SRnxqoGVVWhaaZYPg089hJPwoi141JDCgVpkoqKSbXQqHvHtyN9-gKE_U-b4QFVohkJM2qyxpaUQxf5DYbOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlvgig
    vghiucfnohiiohhvshhkhicuoehmvgesihhlrghmmhihrdhnvghtqeenucggtffrrghtth
    gvrhhnpeetueejheekjeeuveeihefgueehleelgefgheefffefkeejudeujeejuefgteeu
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    esihhlrghmmhihrdhnvght
X-ME-Proxy: <xmx:XTRCYQ07zf8HlGrAjsdJGjuKRnR4ZIhoKFlnfaH0ZcpiQv61iNy7aQ>
    <xmx:XTRCYeGWrz_vT_OhWG8R93Nye2u8fbDV7kjh77gpS7c7JCsNW8Tj8Q>
    <xmx:XTRCYR8ApJWQWPU9FQfAk5Upw_9ibSatMyiBvqUOogW-W6xMkqfEeA>
    <xmx:XTRCYaCqWlH3J5exsrLVhFtUBpBByX78U1oR6S4ZN9hclbE6VhxI4g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Sep 2021 13:58:51 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 00/12] proc/stat: Maintain monotonicity of "intr" and "softirq"
Date:   Thu, 16 Sep 2021 02:58:36 +0900
Message-Id: <20210915175848.162260-1-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210911034808.24252-1-me@ilammy.net>
References: <20210911034808.24252-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's a patch set that makes /proc/stat report total interrupt counts
as monotonically increasing values, just like individual counters for
interrupt types and CPUs are.

The total counters are not actually maintained but computed from
individual counters. These counters must all have the same width
for their sum to wrap around in correct and expected manner.

This patch set unifies all counters that are displayed by /proc/stat
and /proc/interrupts to use "unsigned long" (instead of "unsigned int"
values that get summed into u64, which causes problems for userspace
monitoring tools when the individual counters wrap around).

v1 -> v2:

  - Added READ_ONCE to all reads of per-CPU counters
  - Widened and unified all counters to "unsigned long"
    instead of clamping them all to "unsigned int"
  - Fixed typos in documentation

Since the scope of changes has expanded, I think these patches will
need to be seen and vetted by more people (get-maintainer.pl agrees)
but for now I'll keep the same CC list as for v1.

Unresolved questions:

  - Does READ_ONCE addition has any merit without WRITE_ONCE?

  - Some counters turned out to be unaccounted for in the total sum.
    Should they be included there? Or are they omitted on purpose?

  - I haven't tested this on PowerPC since I don't have the hardware

Alexei Lozovsky (12):
  genirq: Use READ_ONCE for IRQ counter reads
  genirq: Use unsigned long for IRQ counters
  powerpc/irq: Use READ_ONCE for IRQ counter reads
  powerpc/irq: Use unsigned long for IRQ counters
  powerpc/irq: Use unsigned long for IRQ counter sum
  x86/irq: Use READ_ONCE for IRQ counter reads
  x86/irq: Use unsigned long for IRQ counters
  x86/irq: Use unsigned long for IRQ counters more
  x86/irq: Use unsigned long for IRQ counter sum
  proc/stat: Use unsigned long for "intr" sum
  proc/stat: Use unsigned long for "softirq" sum
  docs: proc.rst: stat: Note the interrupt counter wrap-around

 Documentation/filesystems/proc.rst |  8 +++
 arch/powerpc/include/asm/hardirq.h | 20 ++++----
 arch/powerpc/include/asm/paca.h    |  2 +-
 arch/powerpc/kernel/irq.c          | 42 +++++++--------
 arch/x86/include/asm/hardirq.h     | 26 +++++-----
 arch/x86/include/asm/hw_irq.h      |  4 +-
 arch/x86/include/asm/mce.h         |  4 +-
 arch/x86/kernel/apic/apic.c        |  2 +-
 arch/x86/kernel/apic/io_apic.c     |  4 +-
 arch/x86/kernel/cpu/mce/core.c     |  4 +-
 arch/x86/kernel/i8259.c            |  2 +-
 arch/x86/kernel/irq.c              | 82 +++++++++++++++---------------
 fs/proc/softirqs.c                 |  2 +-
 fs/proc/stat.c                     | 12 ++---
 include/linux/kernel_stat.h        | 10 ++--
 kernel/rcu/tree.h                  |  2 +-
 kernel/rcu/tree_stall.h            |  4 +-
 17 files changed, 119 insertions(+), 111 deletions(-)

-- 
2.25.1
