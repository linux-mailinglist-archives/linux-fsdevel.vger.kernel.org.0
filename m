Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C16243D13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 18:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHMQOJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 12:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgHMQOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:14:05 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA53C061384
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 09:14:04 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e5so4762269qth.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IaO87JqeLl+O7BlBAJGOZPpEX9UGcCnuKI5svLj4Bs0=;
        b=IKVEwUkSOr1GN4X53RteYy8JlANkTnQcQJ4YkGJWUOfhkQHSPB7I9G1WF9Jh6/pk9J
         Xb+WQrQwRpoLYnlVl3mAmwyCaBySGZUJqad8isejyoLTBcWXA1oLtQvKEozv2DFw01tx
         RvQ3GlDkfjthxSoqI5xTiCTW2h5FVdFxTTuMzLFGCt+jwpFilZSbx05VTyxWJxJAPVXC
         NIz1z2e/q/osLAmsM61LKX88ZpmqTENx3zOk3HwHIXwPXj7BOzfv1Pkx68gtLiHZ3GgA
         C3DP24Lp/5B5W7Kjy9UF365xI0jnPJQVPhMClRPG9m1jPFgkPhGwxYosWn0BkrB5zE+T
         GMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IaO87JqeLl+O7BlBAJGOZPpEX9UGcCnuKI5svLj4Bs0=;
        b=DXK3W+qt9u2cG5+OjdVncqLt98z6/43xww26FaZntKwPKSCd19CmCJ1r/liLUczxav
         tFUpWVtLKg6PBuCoIttbB7fuX3pFTRfsVIjlUYnrQyj2gKp8m7vHmRoyyehPErUM+CMN
         s9ZbS0AX1LEmbxR04sgW5oxUp/lFVF8jpzXFyPnUQ71t/KZYMxGdMTJ28Pq5qndt4bC9
         yihIlJog8R7Zo3dyBlzPD0EFC3WyvZ+gTDFeU/4SiJgV99rpIFT5C+lwKjH/4qOVEu0r
         S1rDcJGEmHKQqlnRjVmJSdz/B9AEhtvoSuT4SwNJQqIBEhy/RuMakFchQ/ttD7kT5ACu
         Wgag==
X-Gm-Message-State: AOAM533RB7MdAkZ/d4+/1eDvlvc+ZmZiVIiYkRd7VlFKNArtllmw+lk4
        yCxPzGrKuuupE4m1AzdN5O+kkIQfnTP0Ww==
X-Google-Smtp-Source: ABdhPJwWfM5hzbMDJRBOt2cpsj6G35F/u7VNLfCx3el5I813MKKeoZhOuTssedmV4ig4uqtNwPkLQw==
X-Received: by 2002:ac8:408f:: with SMTP id p15mr6016574qtl.156.1597335243597;
        Thu, 13 Aug 2020 09:14:03 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h81sm5999000qke.76.2020.08.13.09.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 09:14:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     hch@lst.de, viro@ZenIV.linux.org.uk, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 2/2] tree-wide: rename vmemdup_user to kvmemdup_user
Date:   Thu, 13 Aug 2020 12:13:59 -0400
Message-Id: <20200813161359.904275-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200813161359.904275-1-josef@toxicpanda.com>
References: <20200813161359.904275-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This helper uses kvmalloc, not vmalloc, so rename it to kvmemdup_user to
make it clear we're using kvmalloc() and will need to use kvfree().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/x86/kvm/cpuid.c                   | 6 +++---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 2 +-
 drivers/tty/vt/consolemap.c            | 2 +-
 include/linux/string.h                 | 2 +-
 mm/util.c                              | 6 +++---
 sound/core/control.c                   | 4 ++--
 virt/kvm/kvm_main.c                    | 4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 3fd6eec202d7..22834ea499ee 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -200,9 +200,9 @@ int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
 	if (cpuid->nent > KVM_MAX_CPUID_ENTRIES)
 		goto out;
 	if (cpuid->nent) {
-		cpuid_entries = vmemdup_user(entries,
-					     array_size(sizeof(struct kvm_cpuid_entry),
-							cpuid->nent));
+		cpuid_entries = kvmemdup_user(entries,
+					      array_size(sizeof(struct kvm_cpuid_entry),
+							 cpuid->nent));
 		if (IS_ERR(cpuid_entries)) {
 			r = PTR_ERR(cpuid_entries);
 			goto out;
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 7a2430e34e00..c2f973aa3680 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -147,7 +147,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		bo_handles = NULL;
 	}
 
-	buf = vmemdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
+	buf = kvmemdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
 	if (IS_ERR(buf)) {
 		ret = PTR_ERR(buf);
 		goto out_unused_fd;
diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 5947b54d92be..2cffa8b3c74b 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -542,7 +542,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 	if (!ct)
 		return 0;
 
-	unilist = vmemdup_user(list, array_size(sizeof(struct unipair), ct));
+	unilist = kvmemdup_user(list, array_size(sizeof(struct unipair), ct));
 	if (IS_ERR(unilist))
 		return PTR_ERR(unilist);
 
diff --git a/include/linux/string.h b/include/linux/string.h
index 21bb6d3d88c4..a6f7218124a0 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -11,7 +11,7 @@
 
 extern char *strndup_user(const char __user *, long);
 extern void *memdup_user(const void __user *, size_t);
-extern void *vmemdup_user(const void __user *, size_t);
+extern void *kvmemdup_user(const void __user *, size_t);
 extern void *kvmemdup_user_nul(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
diff --git a/mm/util.c b/mm/util.c
index cf454d57d3e2..f434634b6ba3 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -183,7 +183,7 @@ void *memdup_user(const void __user *src, size_t len)
 EXPORT_SYMBOL(memdup_user);
 
 /**
- * vmemdup_user - duplicate memory region from user space
+ * kvmemdup_user - duplicate memory region from user space
  *
  * @src: source address in user space
  * @len: number of bytes to copy
@@ -191,7 +191,7 @@ EXPORT_SYMBOL(memdup_user);
  * Return: an ERR_PTR() on failure.  Result may be not
  * physically contiguous.  Use kvfree() to free.
  */
-void *vmemdup_user(const void __user *src, size_t len)
+void *kvmemdup_user(const void __user *src, size_t len)
 {
 	void *p;
 
@@ -206,7 +206,7 @@ void *vmemdup_user(const void __user *src, size_t len)
 
 	return p;
 }
-EXPORT_SYMBOL(vmemdup_user);
+EXPORT_SYMBOL(kvmemdup_user);
 
 /**
  * kvmemdup_user_nul - duplicate memory region from user space and NUL-terminate
diff --git a/sound/core/control.c b/sound/core/control.c
index aa0c0cf182af..b712f4d261de 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1297,7 +1297,7 @@ static int replace_user_tlv(struct snd_kcontrol *kctl, unsigned int __user *buf,
 	if (size > 1024 * 128)	/* sane value */
 		return -EINVAL;
 
-	container = vmemdup_user(buf, size);
+	container = kvmemdup_user(buf, size);
 	if (IS_ERR(container))
 		return PTR_ERR(container);
 
@@ -1365,7 +1365,7 @@ static int snd_ctl_elem_init_enum_names(struct user_element *ue)
 	if (ue->info.value.enumerated.names_length > 64 * 1024)
 		return -EINVAL;
 
-	names = vmemdup_user((const void __user *)user_ptrval,
+	names = kvmemdup_user((const void __user *)user_ptrval,
 		ue->info.value.enumerated.names_length);
 	if (IS_ERR(names))
 		return PTR_ERR(names);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 737666db02de..1111780ccefd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3814,8 +3814,8 @@ static long kvm_vm_ioctl(struct file *filp,
 			goto out;
 		if (routing.nr) {
 			urouting = argp;
-			entries = vmemdup_user(urouting->entries,
-					       array_size(sizeof(*entries),
+			entries = kvmemdup_user(urouting->entries,
+						array_size(sizeof(*entries),
 							  routing.nr));
 			if (IS_ERR(entries)) {
 				r = PTR_ERR(entries);
-- 
2.24.1

