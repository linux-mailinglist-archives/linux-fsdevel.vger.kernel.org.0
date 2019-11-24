Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C482E108383
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2019 14:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfKXNjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 08:39:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34650 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfKXNjo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 08:39:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id j18so14023713wmk.1;
        Sun, 24 Nov 2019 05:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d5kjGUzlv1E7Wwg3/Im24rEOibwGt1VTUz9hOtyzDRo=;
        b=P3A0eO+UU2fkR78M/gKuYSwQIeOWbVT/0VZTKfEjGUvBYg14e6jJ713yB/Nv1rqQEY
         t0cmRiC/OofksIwBoTP8fHWjG86/G16l7BJzpxvaNUeq2fVTpvLm0H2npMkNnQ5Oe5BY
         2JP3hGYg2qvTp1vl3h1O8uq2fVXeKSLByiPqXVbgzc4Nc3Ly3MMMn4ev9jVEe9zumeEb
         Nu1LHl+fOTjs6I64wpQRM8BZq+EWd6fgCa1qziyOZjD3ag6u2/w7VytXLN+NBF9EcpEG
         Lx9AKCo0uRBnxI1QzeY/pIsiDApm9TktOpUClghsLUIbpNXcL2pFYdQPXFZJPYNCwpXX
         wBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d5kjGUzlv1E7Wwg3/Im24rEOibwGt1VTUz9hOtyzDRo=;
        b=CXq+4jD6hflGmA9pe0Tg+AhvLx7gomMN5/DQhCf2lEqBtQd5Q+qgCdIBN8/cG9k1Na
         CNaOijwgeYJDVXlBigvlyRYw+ibAvAC697O07dizLZLRN6NZ9HGhEpJGr38nTkEvPDgK
         NaSdTivWp1GYttmZZH97kul0474pRKYPQTOZJt9Cv57tZjYS0FzL0VE1r6RCLOMQMhFY
         ZZCxTUonTGbjMTJkT0vOHennUVohVlsNe+OOqyC4U3qm216HGKnHN5e1egem3Zsq9bdm
         ZDgGaFQE8H6Qt5jlo4dlcrcZWbYynRLFeyvhjelvdOfbEVOe6jjktM5ED2QLBjVbEa1q
         nmyQ==
X-Gm-Message-State: APjAAAV2vXVl6jWJIUuHz/60Qp9SFA4laCKoqwUFP6rjV0ernSYWXt7M
        98NeyagaidA4YfM/G7BHhT+6D84=
X-Google-Smtp-Source: APXvYqyKLlVQlZasLJS6qqfxSi+wG6qHJ5Ov+8zsYpLre1cUbqGpDdA30Jg8HonWIYBUqKvc9t+f9A==
X-Received: by 2002:a1c:9804:: with SMTP id a4mr24218605wme.57.1574602781495;
        Sun, 24 Nov 2019 05:39:41 -0800 (PST)
Received: from avx2 ([46.53.250.34])
        by smtp.gmail.com with ESMTPSA id t14sm6049575wrw.87.2019.11.24.05.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 05:39:40 -0800 (PST)
Date:   Sun, 24 Nov 2019 16:39:36 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        krzk@kernel.org
Subject: [PATCH] proc: fix Kconfig indentation
Message-ID: <20191124133936.GA5655@avx2>
References: <20191120134322.16525-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191120134322.16525-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
        $ sed -e 's/^        /\t/' -i */Kconfig

[add two spaces where necessary --adobriyan]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/Kconfig |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -42,8 +42,8 @@ config PROC_VMCORE
 	bool "/proc/vmcore support"
 	depends on PROC_FS && CRASH_DUMP
 	default y
-        help
-        Exports the dump image of crashed kernel in ELF format.
+	help
+	  Exports the dump image of crashed kernel in ELF format.
 
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
