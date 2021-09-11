Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5EC4074E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Sep 2021 05:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbhIKDt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 23:49:28 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45725 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230442AbhIKDtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 23:49:24 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E3BC5C0178;
        Fri, 10 Sep 2021 23:48:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 10 Sep 2021 23:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=8hUfaqG2iqGw/
        zAQdkcBvqhTyxx4oaltsi3KSY1CXU8=; b=Ua+F6S9yCbNpg5/Sog7Hovd1Xj/CX
        VL9JZbKDx9UiCQcmBmZwgSC7JZAzStS1O9UFfAO85rObZH8ZbZxI0bulTojoTLDa
        TLNJT8Ono/AyYo0DykesRnDW5/reFYIkpS2Ltp2g3gDyYBgbVtL3tWFsHk4XT0e4
        ezismw0S4SQij/U3gfEBkJvafAGg+gRgWoH1YGLnNAbsue7TgEnqA1R5y655+JkS
        wniU925xXWR4Vc2y1RzVfvFqvrEjUUYl4L1iFAwj+NpMa4OPMNDImhrHx+Z2WSda
        O3yrNdAveUBXfVKUvy/Hqkr69BnYO5x3qvvRke+NxP4t48D2cAHRAlSbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=8hUfaqG2iqGw/zAQdkcBvqhTyxx4oaltsi3KSY1CXU8=; b=O9qEa6MQ
        h/VH421hkcjpZRoJiaynZwlgj6EcLgdNIU85qhzlPOxBs6nC2cCiEMlLpxj/eV+a
        6WHABSN0QMdeT9L0SP37TzD6Xk7vzx7d//e9rxDLUHPAyeFnU1ScJAhs0lPGesO4
        Ml1/6dCx7iCbMq6tRmIwpUlVcAb5kc208CQ1Fs4Pi706ehb+a8vjSw06D09AiG+h
        to+TlC/BdM5zpgbPvwFYZq3NJxz9ZyKfY36TwfmHexUqDEIxnToNouZcglOE3Ls2
        lNF5m5kRHgJpelAGNYkyrTJmjAGejASklGEzrjSPBkznUwJcI1cua6Jh4WjbeWXG
        +9py6WccnFLnZQ==
X-ME-Sender: <xms:-yY8YbRG59BFLPtXQFpEfTtsRdkS5DlZ4e5Ss7ULKrxD3wiPKc_vCA>
    <xme:-yY8Yczu5EmP6AjSHov41bSV9CA7K7OZ7YrZgw7BKAejrmaN8RiNVv9LGfxgYw3BN
    AJvPL3uIFae5ulXrwM>
X-ME-Received: <xmr:-yY8YQ1NdSiihTsWtbMgd_1XIKK0b09nuXK_eJXWTxTKkdnkblCi8cLq7SM2jwq_627HF5lebrR_XtE7ClR6uTErGBWJK4SbQVT17q1kIGQN0JV5fl4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegvddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigv
    ihcunfhoiihovhhskhihuceomhgvsehilhgrmhhmhidrnhgvtheqnecuggftrfgrthhtvg
    hrnhepteeujeehkeejueevieehgfeuheelleeggfehfefffeekjeduueejjeeugfetueek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvse
    hilhgrmhhmhidrnhgvth
X-ME-Proxy: <xmx:-yY8YbDoCjCsb3oqvrhvVOQASXnUdBitxxDh3Qufl6HbvcZIdPxRrg>
    <xmx:-yY8YUj3NqDMxtS8pbnzvjP0dJVxMm4arl4MK3WMiYtbgdZg75Peyg>
    <xmx:-yY8YfqV2IDA-N6ZVZKz3KEQZ8Nt_JqZpqFyQjuzbJ0cmSPd6CnggA>
    <xmx:_CY8YdsA3PmwOGWl-73jhEZGH_nWW3-Gx7_7oTky0bLmQBRx44zrKw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Sep 2021 23:48:10 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/7] proc/stat: Maintain monotonicity of "intr" and "softirq"
Date:   Sat, 11 Sep 2021 12:48:01 +0900
Message-Id: <20210911034808.24252-1-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <06F4B1B0-E4DE-4380-A8E1-A5ACAD285163@ilammy.net>
References: <06F4B1B0-E4DE-4380-A8E1-A5ACAD285163@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's a patch set that makes /proc/stat report total interrupt counts
as monotonically increasing values, just like individual counters for
interrupt types and CPUs are.

This is as if the sum was a shared counter that all CPUs increment
atomically together with their individual counters, with the sum
correctly and expectedly wrapping around to zero once it reaches
UINT_MAX.

I've also added some documentation bits to codify this behavior and make
it explicit that wrap-arounds must be expected and handled if userspace
wants to maintain accurate total interrupt count for whatever reasons.

Alexei Lozovsky (7):
  genirq: Use unsigned int for irqs_sum
  powerpc/irq: arch_irq_stat_cpu() returns unsigned int
  x86/irq: arch_irq_stat_cpu() returns unsigned int
  x86/irq: arch_irq_stat() returns unsigned int
  proc/stat: Use unsigned int for "intr" sum
  proc/stat: Use unsigned int for "softirq" sum
  docs: proc.rst: stat: Note the interrupt counter wrap-around

 Documentation/filesystems/proc.rst | 7 +++++++
 arch/powerpc/include/asm/hardirq.h | 2 +-
 arch/powerpc/kernel/irq.c          | 4 ++--
 arch/x86/include/asm/hardirq.h     | 4 ++--
 arch/x86/kernel/irq.c              | 8 ++++----
 fs/proc/stat.c                     | 8 ++++----
 include/linux/kernel_stat.h        | 2 +-
 7 files changed, 21 insertions(+), 14 deletions(-)

-- 
2.25.1

