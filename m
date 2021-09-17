Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2584F40FF22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 20:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344413AbhIQSYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 14:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344392AbhIQSYJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:24:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9E9C061574;
        Fri, 17 Sep 2021 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZzaciR8ve7n20ZcFiVg0y2XicmgWHcd906Wyz0gIy9E=; b=ES9saNgpa4mxpTW4fopZPPTEuq
        TBLZkSNA1Y2JPaitz3hisgycOO2BG+UtE6Atni+L4+oVx+1hd15uLGWIVQe8cGDk3K+wX2F5+UuoZ
        Jo0ru+TofNOCWkO9pRbOr5pyCCOxMTWHUdxIOEHsbA1528nleGhNAs8l7oCl3W1+0Lex2uxGOG7Oa
        0wAv5YkO7P4yVdDPXVJRLkhB/Q7T4VmSaQ9czhe/IlS2hyy4xs9PsC/7qvE2OFLswBqEicpQNywkn
        dOowrt310okeABxDQKUdvjn3qxSt0LTX/0L+9Kz2FoBoZhq0QuCFC751MlW6ziXsHyvdLMTTOLpeL
        2nAJglOQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRIVI-00Ep5o-KQ; Fri, 17 Sep 2021 18:22:28 +0000
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     bp@suse.de, akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, kubakici@wp.pl, maco@android.com,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-wireless@vger.kernel.org, keescook@chromium.org,
        shuah@kernel.org, mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com,
        dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
        arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, sfr@canb.auug.org.au, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 11/14] firmware_loader: rename EXTRA_FIRMWARE and EXTRA_FIRMWARE_DIR
Date:   Fri, 17 Sep 2021 11:22:23 -0700
Message-Id: <20210917182226.3532898-12-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917182226.3532898-1-mcgrof@kernel.org>
References: <20210917182226.3532898-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Now that we've tied loose ends on the built-in firmware API,
rename the kconfig symbols for it to reflect more that they are
associated to the firmware_loader and to make it easier to
understand what they are for.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 .../driver-api/firmware/built-in-fw.rst       |  6 +++---
 Documentation/x86/microcode.rst               |  6 +++---
 arch/x86/Kconfig                              |  4 ++--
 drivers/base/firmware_loader/Kconfig          | 20 +++++++++++--------
 drivers/base/firmware_loader/builtin/Makefile |  6 +++---
 drivers/staging/media/av7110/Kconfig          |  4 ++--
 6 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/Documentation/driver-api/firmware/built-in-fw.rst b/Documentation/driver-api/firmware/built-in-fw.rst
index 9dd2b1df44f0..b36ea4b13b5e 100644
--- a/Documentation/driver-api/firmware/built-in-fw.rst
+++ b/Documentation/driver-api/firmware/built-in-fw.rst
@@ -9,11 +9,11 @@ directly. You can enable built-in firmware using the kernel configuration
 options:
 
   * CONFIG_FW_LOADER_BUILTIN
-  * CONFIG_EXTRA_FIRMWARE
-  * CONFIG_EXTRA_FIRMWARE_DIR
+  * CONFIG_FW_LOADER_BUILTIN_FILES
+  * CONFIG_FW_LOADER_BUILTIN_DIR
 
 There are a few reasons why you might want to consider building your firmware
-into the kernel with CONFIG_EXTRA_FIRMWARE:
+into the kernel with CONFIG_FW_LOADER_BUILTIN_FILES:
 
 * Speed
 * Firmware is needed for accessing the boot device, and the user doesn't
diff --git a/Documentation/x86/microcode.rst b/Documentation/x86/microcode.rst
index d199f0b98869..7aa9c86b2868 100644
--- a/Documentation/x86/microcode.rst
+++ b/Documentation/x86/microcode.rst
@@ -115,13 +115,13 @@ Builtin microcode
 
 The loader supports also loading of a builtin microcode supplied through
 the regular builtin firmware method using CONFIG_FW_LOADER_BUILTIN and
-CONFIG_EXTRA_FIRMWARE. Only 64-bit is currently supported.
+CONFIG_FW_LOADER_BUILTIN_FILES. Only 64-bit is currently supported.
 
 Here's an example::
 
   CONFIG_FW_LOADER_BUILTIN=y
-  CONFIG_EXTRA_FIRMWARE="intel-ucode/06-3a-09 amd-ucode/microcode_amd_fam15h.bin"
-  CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"
+  CONFIG_FW_LOADER_BUILTIN_FILES="intel-ucode/06-3a-09 amd-ucode/microcode_amd_fam15h.bin"
+  CONFIG_FW_LOADER_BUILTIN_DIR="/lib/firmware"
 
 This basically means, you have the following tree structure locally::
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 25960fe242bd..60eae188ebe0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1304,8 +1304,8 @@ config MICROCODE
 	  initrd for microcode blobs.
 
 	  In addition, you can build the microcode into the kernel. For that you
-	  need to add the vendor-supplied microcode to the CONFIG_EXTRA_FIRMWARE
-	  config option.
+	  need to add the vendor-supplied microcode to the configuration option
+	  CONFIG_FW_LOADER_BUILTIN_FILES
 
 config MICROCODE_INTEL
 	bool "Intel microcode loading support"
diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
index de4fcd9d41f3..181bfbc108e6 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -22,7 +22,7 @@ config FW_LOADER
 	  You typically want this built-in (=y) but you can also enable this
 	  as a module, in which case the firmware_class module will be built.
 	  You also want to be sure to enable this built-in if you are going to
-	  enable built-in firmware (CONFIG_EXTRA_FIRMWARE).
+	  enable built-in firmware (CONFIG_FW_LOADER_BUILTIN_FILES).
 
 if FW_LOADER
 
@@ -48,18 +48,22 @@ config FW_LOADER_BUILTIN
 	  Support for built-in firmware is not supported if you are using
 	  the firmware loader as a module.
 
-config EXTRA_FIRMWARE
+config FW_LOADER_BUILTIN_FILES
 	string "Build named firmware blobs into the kernel binary"
 	depends on FW_LOADER_BUILTIN
 	help
 	  This option is a string and takes the space-separated names of the
 	  firmware files -- the same names that appear in MODULE_FIRMWARE()
 	  and request_firmware() in the source. These files should exist under
-	  the directory specified by the EXTRA_FIRMWARE_DIR option, which is
+	  the directory specified by the FW_LOADER_BUILTIN_DIR option, which is
 	  /lib/firmware by default.
 
-	  For example, you might set CONFIG_EXTRA_FIRMWARE="usb8388.bin", copy
-	  the usb8388.bin file into /lib/firmware, and build the kernel. Then
+	  For example, you might have set:
+
+	  CONFIG_FW_LOADER_BUILTIN_FILES="usb8388.bin"
+
+	  After this you would copy the usb8388.bin file into directory
+	  specified by FW_LOADER_BUILTIN_DIR and build the kernel. Then
 	  any request_firmware("usb8388.bin") will be satisfied internally
 	  inside the kernel without ever looking at your filesystem at runtime.
 
@@ -69,15 +73,15 @@ config EXTRA_FIRMWARE
 	  image since it combines both GPL and non-GPL work. You should
 	  consult a lawyer of your own before distributing such an image.
 
-config EXTRA_FIRMWARE_DIR
+config FW_LOADER_BUILTIN_DIR
 	string "Directory with firmware to be built-in to the kernel"
 	depends on FW_LOADER_BUILTIN
 	default "/lib/firmware"
 	help
 	  This option specifies the directory which the kernel build system
 	  will use to look for the firmware files which are going to be
-	  built into the kernel using the space-separated EXTRA_FIRMWARE
-	  entries.
+	  built into the kernel using the space-separated
+	  FW_LOADER_BUILTIN_FILES entries.
 
 config FW_LOADER_USER_HELPER
 	bool "Enable the firmware sysfs fallback mechanism"
diff --git a/drivers/base/firmware_loader/builtin/Makefile b/drivers/base/firmware_loader/builtin/Makefile
index eb4be452062a..7cdd0b5c7384 100644
--- a/drivers/base/firmware_loader/builtin/Makefile
+++ b/drivers/base/firmware_loader/builtin/Makefile
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y  += main.o
 
-# Create $(fwdir) from $(CONFIG_EXTRA_FIRMWARE_DIR) -- if it doesn't have a
+# Create $(fwdir) from $(CONFIG_FW_LOADER_BUILTIN_DIR) -- if it doesn't have a
 # leading /, it's relative to $(srctree).
-fwdir := $(subst $(quote),,$(CONFIG_EXTRA_FIRMWARE_DIR))
+fwdir := $(subst $(quote),,$(CONFIG_FW_LOADER_BUILTIN_DIR))
 fwdir := $(addprefix $(srctree)/,$(filter-out /%,$(fwdir)))$(filter /%,$(fwdir))
 
-firmware  := $(addsuffix .gen.o, $(subst $(quote),,$(CONFIG_EXTRA_FIRMWARE)))
+firmware  := $(addsuffix .gen.o, $(subst $(quote),,$(CONFIG_FW_LOADER_BUILTIN_FILES)))
 obj-y += $(firmware)
 
 FWNAME    = $(patsubst $(obj)/%.gen.S,%,$@)
diff --git a/drivers/staging/media/av7110/Kconfig b/drivers/staging/media/av7110/Kconfig
index 9faf9d2d4001..87c7702f72f6 100644
--- a/drivers/staging/media/av7110/Kconfig
+++ b/drivers/staging/media/av7110/Kconfig
@@ -31,8 +31,8 @@ config DVB_AV7110
 	  or /lib/firmware (depending on configuration of firmware hotplug).
 
 	  Alternatively, you can download the file and use the kernel's
-	  EXTRA_FIRMWARE configuration option to build it into your
-	  kernel image by adding the filename to the EXTRA_FIRMWARE
+	  FW_LOADER_BUILTIN_FILES configuration option to build it into your
+	  kernel image by adding the filename to the FW_LOADER_BUILTIN_FILES
 	  configuration option string.
 
 	  Say Y if you own such a card and want to use it.
-- 
2.30.2

