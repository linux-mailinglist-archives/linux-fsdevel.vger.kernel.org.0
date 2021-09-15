Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E9740CC2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhIOSAu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:00:50 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51395 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231559AbhIOSAi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:00:38 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 7F1E25C019D;
        Wed, 15 Sep 2021 13:59:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 15 Sep 2021 13:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=64zNka2i99bu6
        M6rOrxFBM4wYz2D6lob8RpvLi07K+8=; b=lHZsmmPUVc4LqK0ph5U7iNOOlJxYa
        UfzCVpqZa3WXc5+NRC7C1QTICXhCP2lc8qJNMisEx741tK3y7bf3hH0au9l+yePN
        V/yILd2KScKamQlzxQ16WjAP/862jhoVhu0y/wLr1mB7bG9pFRKMPWmS0X/iSdRw
        Dae7878plfo1ZboVM7CvrYF66uFVu18+Kr20RR1ZRYXr0lntV/d7xFSXkw+uMZ7P
        klBFcvdXSwk944Oa7mmfk58QC8aF2UwtpcxNM84em2zTN0AGZP4mcohUu4s4EiNQ
        dJkYbXht5yzUadLWLD8I/rDDv03N42fI/ZvWkVee/FA1QPH9Vi/+HfwBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=64zNka2i99bu6M6rOrxFBM4wYz2D6lob8RpvLi07K+8=; b=rnKOm2Si
        yqM1UY2e1nROhrp6opivon9mMKgScm+k2suSPcsNvT29Wf5ry7TQNv9V68anZLmw
        rKhkJwh8TZS4qnYP9ZnJ+8vLGcTX9ynJAVweu/bHG9e5qmTB/F0yUze9shRyGRj1
        wZwRSbuEuOX/CMRdCkGtvyQX2y5CREqfhUuNdWpWcOsz2nDM00bDXd6cA823FsKq
        EAhHrbRVt7Bwvk9QHvg4GvrNtAk2CMQvtcOrgTkaLLUUNNQIS5FH44N8qtlRHVO0
        n4kXrQZW6t2PdrlB/Hw7IXpVd4M72gvT7lET4LXIyw0TrzneQadoJLXSHqEoFqNf
        23i35U7W+BTwKg==
X-ME-Sender: <xms:djRCYXrFPxX8yEA1jScbmBsWftcccYhLJbeXUc4_k13xkdxoBSDexw>
    <xme:djRCYRrNAHjK1jNt0HVLTZDHEnfSxHwpA7HqU2Joz0ntiPoLFea8xfff8_HD-N7dm
    -PWfjClXuDjGr6Uo8s>
X-ME-Received: <xmr:djRCYUMI9WfKdbTLZX_Ke-P37kcrFp7tioH4aC40mFMwhADFnhdnbsMv7_0HkceX6h33owwV6iLQPFLTi4uRr2u-o3j1yd2Qy9eWGHsAoS0yswWYqrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlvgig
    vghiucfnohiiohhvshhkhicuoehmvgesihhlrghmmhihrdhnvghtqeenucggtffrrghtth
    gvrhhnpeetueejheekjeeuveeihefgueehleelgefgheefffefkeejudeujeejuefgteeu
    keenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    esihhlrghmmhihrdhnvght
X-ME-Proxy: <xmx:djRCYa4iaGUqRt8GAsIiohz6ufxdsTOcDiip5aPZ74_6MhzWvl6oMg>
    <xmx:djRCYW7cKtWmR-76zsnmae2YiHjIzlVEXjy8GhFLbsmzA88fMW219A>
    <xmx:djRCYShLmV_0bP04MrFG1kgWGTcPh2ldH-CYpZtvkI23CH2697y8kQ>
    <xmx:djRCYcnt4CLrBkoOG9M9ONw5cmHhPytLeUVfRkqNmj8bmzG5D2GAjg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Sep 2021 13:59:16 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 12/12] docs: proc.rst: stat: Note the interrupt counter wrap-around
Date:   Thu, 16 Sep 2021 02:58:48 +0900
Message-Id: <20210915175848.162260-13-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915175848.162260-1-me@ilammy.net>
References: <20210911034808.24252-1-me@ilammy.net>
 <20210915175848.162260-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's make wrap-around documented behavior so that userspace has
no excuses for not handling it properly if they want accurate values.

On 32-bit platforms "intr" and "softirq" counters can and will
wrap-around, given enough time since boot. This can be days or hours,
depending on the load.

On 64-bit platforms these counters use 64-bit values and these are
very unlikely to oveflow before the heat death of the universe,
but it's still technically possible.

Many other counters can wrap-arond too but I'm not going to enumerate
all of them here. The interrupt counters are most likely to overflow.

Signed-off-by: Alexei Lozovsky <me@ilammy.net>
---
 Documentation/filesystems/proc.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 042c418f4090..a33af0074838 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1513,6 +1513,14 @@ interrupts serviced  including  unnumbered  architecture specific  interrupts;
 each  subsequent column is the  total for that particular numbered interrupt.
 Unnumbered interrupts are not shown, only summed into the total.
 
+.. note::
+
+   On 32-bit platforms interrupt counters are 32-bit, including the total
+   count of all interrupts. Depending on the system load, these values will
+   sooner or later wrap around. If you want accurate accounting of the rate
+   and *actual* number of interrupts serviced, you should monitor the value
+   closely and handle wrap-arounds.
+
 The "ctxt" line gives the total number of context switches across all CPUs.
 
 The "btime" line gives  the time at which the  system booted, in seconds since
-- 
2.25.1

