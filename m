Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA1924754
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 07:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfEUFJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 01:09:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42508 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfEUFJq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 01:09:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id 13so8398723pfw.9;
        Mon, 20 May 2019 22:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iH4Hc02N2HPKJftxMQstfzc1qp7qmQky02xsvvHODHg=;
        b=Lze49Glktl6JLr3SbrFTi2/1ILDiooabrHGNIg/0rtAEefxsCm+nJlw8NzHcKqW7uO
         2Xp3siOi9c0zs+eNCzH3/+Kk6J11XwowGUX5Ot6iIoa2p4aX8RiBgbEKPPYW7a7/FM/h
         iZzWb3xwpyEjcb9FWQN4bWZkgyOqv6GV/2L+S9GCoyEb12XtM4qLNXHhOgirYXcbYW9a
         Hg6Wmi1OxLguiDnquGYcQoMg4Db8ADzAM1kM8c76TtawbgjmBYkgqdz/hJ/plC/4kpvI
         lCDRXgGH88Im9wqce2/Ycq8OoXEHjTxGXBKcyEjvEwUhbGsEIx+kfLttcSYHkmr5edO2
         bE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iH4Hc02N2HPKJftxMQstfzc1qp7qmQky02xsvvHODHg=;
        b=unSv/oiEsPY0MkkIbJgIWY1QpKavaRNmbsIH3lKG8ew3HQmKNP77Lmn1PNxsGKWRlY
         WJXT7Oaf4mXhNacsfHl5rIW3RpibpUck8v2hUVM8cKgos13XqaxHu6QYnFAcRszT7jXv
         JTmVIr6mXsJjiXe0k1Jx4teQyfj6ZOyZHxRX9lrVQNte5EWjk0asX+I/4f7lY4S+LdlN
         tZnaDED7qXDWaNRl+36iP77wCkGulkmeWCU0dgZxZUP/Ypm89aeSwLaWa8L/Jc1WKeqW
         8caCPu7pT921Z2PhgRfjHtZUNtnA3FIuh6EMVPP8cZLTGjSgME0XERRHGSUwiBr01k39
         NrZg==
X-Gm-Message-State: APjAAAW1yUYo9zBc/w3UjW7poQd2sHhg5rUGXzMOxmQ+5bFTWxzXZrTV
        W+YMX78/1SME35qUk7WhTJk=
X-Google-Smtp-Source: APXvYqwfB9R7DykIPPepOiis2elRrcwkJO/eaod12JpyqcUJ08biDGJIlxfpgBCUzQJW5T7C/BnMUg==
X-Received: by 2002:a63:c64c:: with SMTP id x12mr79098885pgg.379.1558415385446;
        Mon, 20 May 2019 22:09:45 -0700 (PDT)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id f29sm48456740pfq.11.2019.05.20.22.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 22:09:44 -0700 (PDT)
From:   Weitao Hou <houweitaoo@gmail.com>
To:     mcgrof@kernel.org, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Weitao Hou <houweitaoo@gmail.com>
Subject: [PATCH v3] kernel: fix typos and some coding style in comments
Date:   Tue, 21 May 2019 13:09:37 +0800
Message-Id: <20190521050937.4370-1-houweitaoo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fix lenght to length

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
Changes in v3:
- fix all other same typos with git grep
---
 .../devicetree/bindings/usb/s3c2410-usb.txt    |  2 +-
 .../wireless/mediatek/mt76/mt76x02_usb_core.c  |  2 +-
 kernel/sysctl.c                                | 18 +++++++++---------
 sound/soc/qcom/qdsp6/q6asm.c                   |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/s3c2410-usb.txt b/Documentation/devicetree/bindings/usb/s3c2410-usb.txt
index e45b38ce2986..26c85afd0b53 100644
--- a/Documentation/devicetree/bindings/usb/s3c2410-usb.txt
+++ b/Documentation/devicetree/bindings/usb/s3c2410-usb.txt
@@ -4,7 +4,7 @@ OHCI
 
 Required properties:
  - compatible: should be "samsung,s3c2410-ohci" for USB host controller
- - reg: address and lenght of the controller memory mapped region
+ - reg: address and length of the controller memory mapped region
  - interrupts: interrupt number for the USB OHCI controller
  - clocks: Should reference the bus and host clocks
  - clock-names: Should contain two strings
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 6b89f7eab26c..e0f5e6202a27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -53,7 +53,7 @@ int mt76x02u_skb_dma_info(struct sk_buff *skb, int port, u32 flags)
 	pad = round_up(skb->len, 4) + 4 - skb->len;
 
 	/* First packet of a A-MSDU burst keeps track of the whole burst
-	 * length, need to update lenght of it and the last packet.
+	 * length, need to update length of it and the last packet.
 	 */
 	skb_walk_frags(skb, iter) {
 		last = iter;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 943c89178e3d..f78f725f225e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -187,17 +187,17 @@ extern int no_unaligned_warning;
  * enum sysctl_writes_mode - supported sysctl write modes
  *
  * @SYSCTL_WRITES_LEGACY: each write syscall must fully contain the sysctl value
- * 	to be written, and multiple writes on the same sysctl file descriptor
- * 	will rewrite the sysctl value, regardless of file position. No warning
- * 	is issued when the initial position is not 0.
+ *	to be written, and multiple writes on the same sysctl file descriptor
+ *	will rewrite the sysctl value, regardless of file position. No warning
+ *	is issued when the initial position is not 0.
  * @SYSCTL_WRITES_WARN: same as above but warn when the initial file position is
- * 	not 0.
+ *	not 0.
  * @SYSCTL_WRITES_STRICT: writes to numeric sysctl entries must always be at
- * 	file position 0 and the value must be fully contained in the buffer
- * 	sent to the write syscall. If dealing with strings respect the file
- * 	position, but restrict this to the max length of the buffer, anything
- * 	passed the max lenght will be ignored. Multiple writes will append
- * 	to the buffer.
+ *	file position 0 and the value must be fully contained in the buffer
+ *	sent to the write syscall. If dealing with strings respect the file
+ *	position, but restrict this to the max length of the buffer, anything
+ *	passed the max length will be ignored. Multiple writes will append
+ *	to the buffer.
  *
  * These write modes control how current file position affects the behavior of
  * updating sysctl values through the proc interface on each write.
diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 4f85cb19a309..e8141a33a55e 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -1194,7 +1194,7 @@ EXPORT_SYMBOL_GPL(q6asm_open_read);
  * q6asm_write_async() - non blocking write
  *
  * @ac: audio client pointer
- * @len: lenght in bytes
+ * @len: length in bytes
  * @msw_ts: timestamp msw
  * @lsw_ts: timestamp lsw
  * @wflags: flags associated with write
-- 
2.18.0

