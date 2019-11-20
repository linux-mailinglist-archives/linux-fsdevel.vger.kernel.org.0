Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3AC3103C62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 14:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfKTNn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 08:43:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730110AbfKTNn1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:43:27 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2401422528;
        Wed, 20 Nov 2019 13:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257406;
        bh=h3AbCresN75AqgZ8h/I3zFonj444oDdMctTI2cTK53E=;
        h=From:To:Cc:Subject:Date:From;
        b=K9EbXWcYVCVzDVTSky2FfHu5DCewjx7V2nsKxO/MRI29oJp+3uDljZcFydiJsFG1H
         4tddqe6WkXDPdQWdAr/8LWwAQe0aSZfiRaEcxZJ0lFIx+t5vcWOlYCgM9o3ooy1a9g
         hQ0vvt9n6wiZLiwTBkFObQu+L9T0iYRI2v2Pjq7E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: proc: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:43:22 +0800
Message-Id: <20191120134322.16525-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 fs/proc/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index cb5629bd5fff..af2c0af60269 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -42,8 +42,8 @@ config PROC_VMCORE
 	bool "/proc/vmcore support"
 	depends on PROC_FS && CRASH_DUMP
 	default y
-        help
-        Exports the dump image of crashed kernel in ELF format.
+	help
+	Exports the dump image of crashed kernel in ELF format.
 
 config PROC_VMCORE_DEVICE_DUMP
 	bool "Device Hardware/Firmware Log Collection"
@@ -72,7 +72,7 @@ config PROC_SYSCTL
 	  a recompile of the kernel or reboot of the system.  The primary
 	  interface is through /proc/sys.  If you say Y here a tree of
 	  modifiable sysctl entries will be generated beneath the
-          /proc/sys directory. They are explained in the files
+	  /proc/sys directory. They are explained in the files
 	  in <file:Documentation/admin-guide/sysctl/>.  Note that enabling this
 	  option will enlarge the kernel by at least 8 KB.
 
@@ -88,7 +88,7 @@ config PROC_PAGE_MONITOR
 	  Various /proc files exist to monitor process memory utilization:
 	  /proc/pid/smaps, /proc/pid/clear_refs, /proc/pid/pagemap,
 	  /proc/kpagecount, and /proc/kpageflags. Disabling these
-          interfaces will reduce the size of the kernel by approximately 4kb.
+	  interfaces will reduce the size of the kernel by approximately 4kb.
 
 config PROC_CHILDREN
 	bool "Include /proc/<pid>/task/<tid>/children file"
-- 
2.17.1

