Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC264074ED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Sep 2021 05:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbhIKDt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 23:49:56 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35773 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235326AbhIKDth (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 23:49:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B87FE5C0178;
        Fri, 10 Sep 2021 23:48:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 10 Sep 2021 23:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=NH5HGQ0wFtmZ6
        SSZLSPDfXj0zUk85slBKvwDXIdMM4U=; b=Vn/KHzqC53fTdOkNG/PrGKEMB+Co/
        tGdcvr4GnbjpoHVYHya+E9c7dpD79gNx2cTygqwXOuiYovPCDpgG5sgiwV0YWZxj
        VOARSKzV6YqdOdprb5tMYlEmoUg0efp95nr2CRjxY3WrD3Hp7G9FzTtmG02TMZcE
        1CXi07t2+/cHALk1mzV7prgIEzc498QTezySR8neuvu5XfxUQiaBaniuCltuv7aA
        xv1gRb3xVP5H0M40bxfptUZKEN/mxk97UHx00O/CS752CHSCBFMB7ZeL9SLjdQAQ
        Yn2JMU44AHW2LKrhRI3GCMKBTkhVfKEcqaGCKCwNr7UU0Q7s+qfT0b9ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=NH5HGQ0wFtmZ6SSZLSPDfXj0zUk85slBKvwDXIdMM4U=; b=RivrVkVC
        fEGcSLSIzB5YPciPybnYd5P+O93rt3qTTinINyIvKBYyCGSH+yizMsB9x/KKRF8d
        GwxQdeXgDJGCBtYseuAJxII7PVkyYDt8T5SM/xJmjjoBm240i9w4yFRN3Zrsj5jb
        3IBPhVzoWJuHnXjHmmUsBgsLHUqDHSASEFh8bvmIn69DQYXcxRc01R9/bgnp5BFK
        IbmnFs/KTyHh7/N/y2cBPcIqI1pg5i5xS4rs8QoWMHw1q+kWJX1yJLwXczAXW4mD
        zqMJOtWPMbz1nuraKJXpjr75RZ/VgN3ThRQ27DD2/GKSMvjJb/GMVslttCJFLl54
        Z5MRihi9oE1e/g==
X-ME-Sender: <xms:CCc8YfWm2EfPlP9lHHCo_NHbD4mStKrKAv7wR6BXpiIsbwQ9vTqQdQ>
    <xme:CCc8YXlQEeUXoio2CYlLue6HFC-OPez3R0yWO1HQwpn1AdAO-h7ztNpTfhsJXqcgC
    upIgqqCk8X4d3ehRrA>
X-ME-Received: <xmr:CCc8YbZRmCv9Ya12NKpeDN8oOZmO6L0TuvbeIHWIh0YkLPQbmhvaFp8aw7-1FMKroLAXXQyyp3OfQtJVnPOmFrp8runfnCA12CyKuYjj4dVaCmpcXkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegvddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigv
    ihcunfhoiihovhhskhihuceomhgvsehilhgrmhhmhidrnhgvtheqnecuggftrfgrthhtvg
    hrnhepteeujeehkeejueevieehgfeuheelleeggfehfefffeekjeduueejjeeugfetueek
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepmhgvse
    hilhgrmhhmhidrnhgvth
X-ME-Proxy: <xmx:CCc8YaW679VTw3nFpZbYZRnk-BiQ7U9EfktmYUurNZ2yfSzpnJ-VMA>
    <xmx:CCc8YZl6Itt0cZB5N80jkg4urd4q09_7cEonRnRv7PGD4NffA-eZ4A>
    <xmx:CCc8YXdFxntIlDk5H90cqEi-qT9wluX1oJrImAfEDc3b65Xxy7_HCw>
    <xmx:CCc8YfhCj_I6zyw1ETpNJWEZLH6b99UNpOvHo0HnNS4kdT-IYCAoZg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Sep 2021 23:48:23 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/7] docs: proc.rst: stat: Note the interrupt counter wrap-around
Date:   Sat, 11 Sep 2021 12:48:08 +0900
Message-Id: <20210911034808.24252-8-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210911034808.24252-1-me@ilammy.net>
References: <06F4B1B0-E4DE-4380-A8E1-A5ACAD285163@ilammy.net>
 <20210911034808.24252-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's make wrap-around documented behavior so that userspace has no
excuses for not handling it properly if they want accurate values.

Both "intr" and "softirq" counters (as well as many others, actually)
can and will wrap-around, given enough time since boot.

Signed-off-by: Alexei Lozovsky <me@ilammy.net>
---
 Documentation/filesystems/proc.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 042c418f4090..06a0e3aa2e0e 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1513,6 +1513,13 @@ interrupts serviced  including  unnumbered  architecture specific  interrupts;
 each  subsequent column is the  total for that particular numbered interrupt.
 Unnumbered interrupts are not shown, only summed into the total.
 
+.. note::
+
+   Interrupt counters on most platforms are 32-bit, including the total count.
+   Depending on the system load, ths values will sooner or later wrap around.
+   If you want accurate accouting of the rate and *real* number of interrupts
+   serviced, you should monitor the value closely and handle wrap-arounds.
+
 The "ctxt" line gives the total number of context switches across all CPUs.
 
 The "btime" line gives  the time at which the  system booted, in seconds since
-- 
2.25.1

