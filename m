Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB665273D7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 May 2022 21:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiENT4V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 May 2022 15:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiENT4J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 May 2022 15:56:09 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404E420BC7
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 May 2022 12:56:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id c24so10288659lfv.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 May 2022 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=qhIwL70+KCmzinVsgrDQxz7iH+cV5EAnmSLiPmog6bk=;
        b=W7LcPPKA69zm0JKypsiX/tlFouEAX9Kj2LdW1B2m9kp15ovkq6UaCEhF6m2tLy9YGC
         buApEBEF9wLvPY8KRxB38WjYyTbKleDFEbPROKAHNOYG2deQVy2t9Ik2HiYNDSWdsr/x
         fLD5PyNCIHr3bLcW18m39IX8PFmeNm/268Ey3g1FzT0e0+QvQMZkjxoeoClN11EpUOXX
         Ly5CIifTGwzTnh6ZtMY2cgVYD7ik483yB10ExDDPgTf7ZH4U9oqVAQlPcdqn/9L8M926
         jjF01cf/IegadZMaQP+GOc4PEAFwmGaclKQXMvehgrvua74j57iqa2lZ26Ej4l2bQVbH
         Oq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=qhIwL70+KCmzinVsgrDQxz7iH+cV5EAnmSLiPmog6bk=;
        b=JshCYd4r/Y5FPzIGsRK7GFFIg6fxjAutjq46E9IL5+i+whmaf3ou7Udn4FETig7nbA
         cQoNy1SnlYCXrJx4lwfJO8b4IArb16Dv/nAya9YNgrtit4hhbxGUJgKq8CTxf4j4IpNE
         Kk3Tfk7Dm5KZNN4iqR2nkwFMXy8KnC0zUpqCYPYxSixAeRe/84j5450PBNl59D+bAriZ
         7+1M+yjmHlYX3URg9G+1kzvnbF1Hs3ZRbZZ1K494KLfsS4hrGFX42/Ra2N8CDs1rbbI7
         rvOBOsoQCIAnoJQd6h+TlyffY9V76HSru1xPU61Ml83OcF0dLB289abkWcTWO8gdSdug
         s06Q==
X-Gm-Message-State: AOAM530FYmQopWYBjXQhkaTzre/OrjBYCwFfIeIbUJFVyKVNp0jPgVsM
        GZ5ovkuO7M84BZbHrfFeU4683Q==
X-Google-Smtp-Source: ABdhPJwAWJ1Da2LGWi3dGCVwVi7S18jA4itXrji7BJHFQGD86OBSsWLywRigbK4g3sWFp9TWGILQbQ==
X-Received: by 2002:a05:6512:3e13:b0:471:f6a9:85d3 with SMTP id i19-20020a0565123e1300b00471f6a985d3mr7756339lfv.120.1652558165603;
        Sat, 14 May 2022 12:56:05 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id j17-20020ac25511000000b0047255d21144sm802640lfk.115.2022.05.14.12.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 12:56:05 -0700 (PDT)
Message-ID: <66e8e17a-73c2-2e50-cdc2-ed924d6bfb2a@openvz.org>
Date:   Sat, 14 May 2022 22:56:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH v2] sparse: use force attribute for vm_fault_t casts
To:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
References: <Yn/oKz6v5GkReeA3@casper.infradead.org>
Content-Language: en-US
In-Reply-To: <Yn/oKz6v5GkReeA3@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes sparse warnings:
./include/trace/events/fs_dax.h:10:1: sparse:
    got restricted vm_fault_t
./include/trace/events/fs_dax.h:153:1: sparse:
    got restricted vm_fault_t
fs/dax.c:563:39: sparse:    got restricted vm_fault_t
fs/dax.c:565:39: sparse:    got restricted vm_fault_t
fs/dax.c:569:31: sparse:    got restricted vm_fault_t
fs/dax.c:1055:41: sparse:
    got restricted vm_fault_t [assigned] [usertype] ret
fs/dax.c:1461:46: sparse:    got restricted vm_fault_t [usertype] ret
fs/dax.c:1477:21: sparse:
    expected restricted vm_fault_t [assigned] [usertype] ret
fs/dax.c:1518:51: sparse:
    got restricted vm_fault_t [assigned] [usertype] ret
fs/dax.c:1599:21: sparse:
    expected restricted vm_fault_t [assigned] [usertype] ret
fs/dax.c:1633:62: sparse:
    got restricted vm_fault_t [assigned] [usertype] ret
fs/dax.c:1696:55: sparse:    got restricted vm_fault_t
fs/dax.c:1711:58: sparse:
    got restricted vm_fault_t [assigned] [usertype] ret

vm_fault_t type is bitwise and requires __force attribute for any casts.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
v2: improved according to the recommendations of Matthew Wilcox:
   - __force cast moved into internal functions
   - introduced new abstractions dax_vm_fault_[en|de]code()
---
 fs/dax.c                      | 21 +++++++++++++++------
 include/linux/mm_types.h      | 30 ++++++++++++++++--------------
 include/trace/events/fs_dax.h | 12 ++++++------
 3 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 67a08a32fccb..c27c8782007f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -121,6 +121,15 @@ static int dax_is_empty_entry(void *entry)
 	return xa_to_value(entry) & DAX_EMPTY;
 }
 
+static void *dax_vm_fault_encode(vm_fault_t fault)
+{
+	return xa_mk_internal((__force unsigned long)fault);
+}
+
+static vm_fault_t dax_vm_fault_decode(void *entry)
+{
+	return (__force vm_fault_t)xa_to_internal(entry);
+}
 /*
  * true if the entry that was found is of a smaller order than the entry
  * we were looking for
@@ -560,13 +569,13 @@ static void *grab_mapping_entry(struct xa_state *xas,
 	if (xas_nomem(xas, mapping_gfp_mask(mapping) & ~__GFP_HIGHMEM))
 		goto retry;
 	if (xas->xa_node == XA_ERROR(-ENOMEM))
-		return xa_mk_internal(VM_FAULT_OOM);
+		return dax_vm_fault_encode(VM_FAULT_OOM);
 	if (xas_error(xas))
-		return xa_mk_internal(VM_FAULT_SIGBUS);
+		return dax_vm_fault_encode(VM_FAULT_SIGBUS);
 	return entry;
 fallback:
 	xas_unlock_irq(xas);
-	return xa_mk_internal(VM_FAULT_FALLBACK);
+	return dax_vm_fault_encode(VM_FAULT_FALLBACK);
 }
 
 /**
@@ -1474,7 +1483,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 
 	entry = grab_mapping_entry(&xas, mapping, 0);
 	if (xa_is_internal(entry)) {
-		ret = xa_to_internal(entry);
+		ret = dax_vm_fault_decode(entry);
 		goto out;
 	}
 
@@ -1578,7 +1587,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 */
 	max_pgoff = DIV_ROUND_UP(i_size_read(iter.inode), PAGE_SIZE);
 
-	trace_dax_pmd_fault(iter.inode, vmf, max_pgoff, 0);
+	trace_dax_pmd_fault(iter.inode, vmf, max_pgoff, (vm_fault_t)0);
 
 	if (xas.xa_index >= max_pgoff) {
 		ret = VM_FAULT_SIGBUS;
@@ -1596,7 +1605,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 */
 	entry = grab_mapping_entry(&xas, mapping, PMD_ORDER);
 	if (xa_is_internal(entry)) {
-		ret = xa_to_internal(entry);
+		ret = dax_vm_fault_decode(entry);
 		goto fallback;
 	}
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8834e38c06a4..57cc4918b1b1 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -745,20 +745,22 @@ enum vm_fault_reason {
 			VM_FAULT_SIGSEGV | VM_FAULT_HWPOISON |	\
 			VM_FAULT_HWPOISON_LARGE | VM_FAULT_FALLBACK)
 
-#define VM_FAULT_RESULT_TRACE \
-	{ VM_FAULT_OOM,                 "OOM" },	\
-	{ VM_FAULT_SIGBUS,              "SIGBUS" },	\
-	{ VM_FAULT_MAJOR,               "MAJOR" },	\
-	{ VM_FAULT_WRITE,               "WRITE" },	\
-	{ VM_FAULT_HWPOISON,            "HWPOISON" },	\
-	{ VM_FAULT_HWPOISON_LARGE,      "HWPOISON_LARGE" },	\
-	{ VM_FAULT_SIGSEGV,             "SIGSEGV" },	\
-	{ VM_FAULT_NOPAGE,              "NOPAGE" },	\
-	{ VM_FAULT_LOCKED,              "LOCKED" },	\
-	{ VM_FAULT_RETRY,               "RETRY" },	\
-	{ VM_FAULT_FALLBACK,            "FALLBACK" },	\
-	{ VM_FAULT_DONE_COW,            "DONE_COW" },	\
-	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
+#define faultflag_string(flag) {(__force unsigned long)VM_FAULT_##flag, #flag}
+
+#define VM_FAULT_RESULT_TRACE			\
+	faultflag_string(OOM),			\
+	faultflag_string(SIGBUS),		\
+	faultflag_string(MAJOR),		\
+	faultflag_string(WRITE),		\
+	faultflag_string(HWPOISON),		\
+	faultflag_string(HWPOISON_LARGE),	\
+	faultflag_string(SIGSEGV),		\
+	faultflag_string(NOPAGE),		\
+	faultflag_string(LOCKED),		\
+	faultflag_string(RETRY),		\
+	faultflag_string(FALLBACK),		\
+	faultflag_string(DONE_COW),		\
+	faultflag_string(NEEDDSYNC)
 
 struct vm_special_mapping {
 	const char *name;	/* The name, e.g. "[vdso]". */
diff --git a/include/trace/events/fs_dax.h b/include/trace/events/fs_dax.h
index 97b09fcf7e52..75908bdc7b2d 100644
--- a/include/trace/events/fs_dax.h
+++ b/include/trace/events/fs_dax.h
@@ -9,7 +9,7 @@
 
 DECLARE_EVENT_CLASS(dax_pmd_fault_class,
 	TP_PROTO(struct inode *inode, struct vm_fault *vmf,
-		pgoff_t max_pgoff, int result),
+		pgoff_t max_pgoff, vm_fault_t result),
 	TP_ARGS(inode, vmf, max_pgoff, result),
 	TP_STRUCT__entry(
 		__field(unsigned long, ino)
@@ -33,7 +33,7 @@ DECLARE_EVENT_CLASS(dax_pmd_fault_class,
 		__entry->flags = vmf->flags;
 		__entry->pgoff = vmf->pgoff;
 		__entry->max_pgoff = max_pgoff;
-		__entry->result = result;
+		__entry->result = (__force int)result;
 	),
 	TP_printk("dev %d:%d ino %#lx %s %s address %#lx vm_start "
 			"%#lx vm_end %#lx pgoff %#lx max_pgoff %#lx %s",
@@ -54,7 +54,7 @@ DECLARE_EVENT_CLASS(dax_pmd_fault_class,
 #define DEFINE_PMD_FAULT_EVENT(name) \
 DEFINE_EVENT(dax_pmd_fault_class, name, \
 	TP_PROTO(struct inode *inode, struct vm_fault *vmf, \
-		pgoff_t max_pgoff, int result), \
+		pgoff_t max_pgoff, vm_fault_t result), \
 	TP_ARGS(inode, vmf, max_pgoff, result))
 
 DEFINE_PMD_FAULT_EVENT(dax_pmd_fault);
@@ -151,7 +151,7 @@ DEFINE_EVENT(dax_pmd_insert_mapping_class, name, \
 DEFINE_PMD_INSERT_MAPPING_EVENT(dax_pmd_insert_mapping);
 
 DECLARE_EVENT_CLASS(dax_pte_fault_class,
-	TP_PROTO(struct inode *inode, struct vm_fault *vmf, int result),
+	TP_PROTO(struct inode *inode, struct vm_fault *vmf, vm_fault_t result),
 	TP_ARGS(inode, vmf, result),
 	TP_STRUCT__entry(
 		__field(unsigned long, ino)
@@ -169,7 +169,7 @@ DECLARE_EVENT_CLASS(dax_pte_fault_class,
 		__entry->address = vmf->address;
 		__entry->flags = vmf->flags;
 		__entry->pgoff = vmf->pgoff;
-		__entry->result = result;
+		__entry->result = (__force int)result;
 	),
 	TP_printk("dev %d:%d ino %#lx %s %s address %#lx pgoff %#lx %s",
 		MAJOR(__entry->dev),
@@ -185,7 +185,7 @@ DECLARE_EVENT_CLASS(dax_pte_fault_class,
 
 #define DEFINE_PTE_FAULT_EVENT(name) \
 DEFINE_EVENT(dax_pte_fault_class, name, \
-	TP_PROTO(struct inode *inode, struct vm_fault *vmf, int result), \
+	TP_PROTO(struct inode *inode, struct vm_fault *vmf, vm_fault_t result), \
 	TP_ARGS(inode, vmf, result))
 
 DEFINE_PTE_FAULT_EVENT(dax_pte_fault);
-- 
2.31.1

