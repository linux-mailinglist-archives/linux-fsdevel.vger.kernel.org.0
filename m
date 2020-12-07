Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3D02D0F51
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgLGLft (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgLGLfo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:44 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8F3C08E864;
        Mon,  7 Dec 2020 03:34:55 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id o5so8647152pgm.10;
        Mon, 07 Dec 2020 03:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cfW0rkOgMIuxNIUMjXUU1M20WeHJvF5wHx5SDbaa7WE=;
        b=tAKAgseG2CCONQ+JBLfVPuz/DEVm6e6uJwCvBS1RREKrlZrlOUdzYsuLEUhueHfOFF
         uFV+57rP3yHKObWXA15tn3JY9Y2Mp7P0iPIKN8JWG9DeMFVnD03wWM3MnRRZiJQT6AF2
         WR2vxkVxf0MNXxhaYUqnCBkgNMZXajnPprZpauiW0v4cZtIPknD9A9IWTbwA3N/nERtu
         oiMqPUyiyheuzpFUWKvr/tZb1S1TJE2PoPMHS+zlAU086PYQuSRhzWuPFYiB7b1Acfcl
         yxBbTTVnn5ROFZOGNlweU2k6Hu7UN+pZY6i4XQztkumh8Gv00oB9pvKIHKFEHgAYZYi/
         4JrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cfW0rkOgMIuxNIUMjXUU1M20WeHJvF5wHx5SDbaa7WE=;
        b=FxBKjWXmRnz7ifCQVUGXFM8hPwkNTYIpfVWyk1OHP0/5FEAvpcMVZkKQfVWd4KBTa8
         DcRoOqvkCkYfG6cW6TixeyrQ5+iA/4/xt3Pb0nQTrgdkxpMMMUJAjZZpZMk56SQrlYxN
         3myAbITwHeVwdr4fKPhZVbF5MUhSmhgs7fJ/zBG6k1d9mqDiH9CJiRRJQwaABiVXQp55
         ryhTWEADuVMkeARucipjmKwgS/xUt+90Y5hahGClLWJWOwsDU4ef75OHDXzICRdPkW8I
         mgHP3IqO96uSoG/s8HdsQHsTT+Y9sQBzscImiOjqwBbBJY9IKMBbUHnr1CI6TUEylA27
         VKTQ==
X-Gm-Message-State: AOAM530T2i+KOeU0kSYcF+BBEAAf6JGDs25AfptPdOLO0mKZpc+0hIE+
        roXbAv0duBIOgN08Fm7B7zw=
X-Google-Smtp-Source: ABdhPJwFz1981DhHI3jR9VGpOCOSaq+Ig5CXILTKJ1ERZg74A7VBmwCCkjGQ9zkn+U6XHw4ztmn59g==
X-Received: by 2002:a17:902:5581:b029:da:a817:1753 with SMTP id g1-20020a1709025581b02900daa8171753mr15580441pli.76.1607340894707;
        Mon, 07 Dec 2020 03:34:54 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.34.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:34:54 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [RFC V2 22/37] kvm, x86: Distinguish dmemfs page from mmio page
Date:   Mon,  7 Dec 2020 19:31:15 +0800
Message-Id: <ccf4300c78c8c5557e7a19cc194200bb47b7997a.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Dmem page is pfn invalid but not mmio, introduce API
is_dmem_pfn() to distinguish that.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 arch/x86/kvm/mmu/mmu.c | 1 +
 include/linux/dmem.h   | 7 +++++++
 mm/dmem.c              | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5bb1939..394508f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -43,6 +43,7 @@
 #include <linux/hash.h>
 #include <linux/kern_levels.h>
 #include <linux/kthread.h>
+#include <linux/dmem.h>
 
 #include <asm/page.h>
 #include <asm/memtype.h>
diff --git a/include/linux/dmem.h b/include/linux/dmem.h
index 8682d63..59d3ef14 100644
--- a/include/linux/dmem.h
+++ b/include/linux/dmem.h
@@ -19,11 +19,18 @@
 		     unsigned int try_max, unsigned int *result_nr);
 
 void dmem_free_pages(phys_addr_t addr, unsigned int dpages_nr);
+bool is_dmem_pfn(unsigned long pfn);
 #define dmem_free_page(addr)	dmem_free_pages(addr, 1)
 #else
 static inline int dmem_reserve_init(void)
 {
 	return 0;
 }
+
+static inline bool is_dmem_pfn(unsigned long pfn)
+{
+	return 0;
+}
+
 #endif
 #endif	/* _LINUX_DMEM_H */
diff --git a/mm/dmem.c b/mm/dmem.c
index 2e61dbd..eb6df70 100644
--- a/mm/dmem.c
+++ b/mm/dmem.c
@@ -972,3 +972,10 @@ void dmem_free_pages(phys_addr_t addr, unsigned int dpages_nr)
 }
 EXPORT_SYMBOL(dmem_free_pages);
 
+bool is_dmem_pfn(unsigned long pfn)
+{
+	struct dmem_node *dnode;
+
+	return !!find_dmem_region(__pfn_to_phys(pfn), &dnode);
+}
+EXPORT_SYMBOL(is_dmem_pfn);
-- 
1.8.3.1

