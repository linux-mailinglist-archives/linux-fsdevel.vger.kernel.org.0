Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC50538E4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 12:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245476AbiEaKAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 06:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245425AbiEaKAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 06:00:21 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2972884A14;
        Tue, 31 May 2022 03:00:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id f21so25481616ejh.11;
        Tue, 31 May 2022 03:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNC+q1HYAjRPp62MTH/zi2loKTLmxRGj7rz2onfHvYc=;
        b=GBXq9vHHCJxrvvL36ccyiGaBUxAA4gOuuAE6JJqw7rKR68K9hwr5XNyqXOEIIT7vcs
         b+n0Pi155O7ZJ3hNSKyRz9mXIkUEKm2lcFNblLxTflNcxgkeUjq/QrKdI4HYMHPMzWAq
         SVmk2ARrocIRZTeQ2RslzCLdsKehpXg+Kq0kTeKoNXvG6sD16XOQ01MvqTpq1vkjhPtq
         +sWJbuWYYHK+e5WSj+SIwpEX66Y+xGwye9J3sHcOAM1TU5DbXJA7e3WOh4GWP04ovYuJ
         BVp7Cx+40rXPVhuLagJwI31hssTpBLyHz/XRKyjdzt8EQGLbOfMOhG6RJdTATBNFmuK2
         0Y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNC+q1HYAjRPp62MTH/zi2loKTLmxRGj7rz2onfHvYc=;
        b=uvVaBjCnioWLWAVLQvUWYntrPFExkrnD14h2h4bkKC8KoJQrXUHexMGfADheaxuI4J
         62l1PPFu0QDc6FRw8bP/0jXAWet8XH28nTzfj3vdD6isN8Q4cGK/9rdTFvKMbUCzHzi9
         KXkyAQcp+cdeUtc/d99oRcFYH15horqmhPF/knz9RkiJllGrada6z646Ee05dWlCrt6D
         LIMdCBff5sq8QkqENe3L1pEWC1aYPpAHQITyPw8VDajbEMI4SMHKPcksmY5ROWmCouqB
         5ZzWOxPGKHo1odJ4f18uno3GzrDR8MJAfYMshoHSgu60F/r02yU1umI6+056AgHrYD/+
         QADQ==
X-Gm-Message-State: AOAM533Hc8TcyR+b0Igsn2NpGTj+Q3PaFfbsS3ncwu9Ot3gM7pRu/jwA
        t8bccTr4RXMIqgKQqm7+yizRqwRhI2Pn5Q==
X-Google-Smtp-Source: ABdhPJw0gyeFnw57oxp0sq6bqgANIsrzObxRClwQk6Sv+DHCrMObVZ1M7XOYXmXPr5CJvAsoBP5qig==
X-Received: by 2002:a17:907:1b03:b0:6ff:78d4:c140 with SMTP id mp3-20020a1709071b0300b006ff78d4c140mr8861505ejc.554.1653991217575;
        Tue, 31 May 2022 03:00:17 -0700 (PDT)
Received: from able.fritz.box (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
        by smtp.gmail.com with ESMTPSA id r13-20020a056402018d00b0042617ba6389sm582062edv.19.2022.05.31.03.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:00:17 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     christian.koenig@amd.com, alexander.deucher@amd.com,
        daniel@ffwll.ch, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, hughd@google.com,
        andrey.grodzovsky@amd.com
Subject: [PATCH 05/13] drm/gem: adjust per file OOM badness on handling buffers
Date:   Tue, 31 May 2022 11:59:59 +0200
Message-Id: <20220531100007.174649-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531100007.174649-1-christian.koenig@amd.com>
References: <20220531100007.174649-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Large amounts of VRAM are usually not CPU accessible, so they are not mapped
into the processes address space. But since the device drivers usually support
swapping buffers from VRAM to system memory we can still run into an out of
memory situation when userspace starts to allocate to much.

This patch gives the OOM killer another hint which process is
holding references to memory resources.

A GEM helper is provided and automatically used for all drivers using the
DEFINE_DRM_GEM_FOPS() and DEFINE_DRM_GEM_CMA_FOPS() macros.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/drm_file.c       | 19 +++++++++++++++++++
 drivers/gpu/drm/drm_gem.c        |  5 +++++
 include/drm/drm_file.h           |  9 +++++++++
 include/drm/drm_gem.h            |  1 +
 include/drm/drm_gem_cma_helper.h |  1 +
 5 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index ed25168619fc..1959a5b7029e 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -1049,3 +1049,22 @@ unsigned long drm_get_unmapped_area(struct file *file,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 EXPORT_SYMBOL_GPL(drm_get_unmapped_area);
 #endif /* CONFIG_MMU */
+
+
+/**
+ * drm_oom_badness() - get oom badness for struct drm_file
+ * @f: struct drm_file to get the badness from
+ *
+ * Return how many pages are allocated for this client.
+ */
+long drm_oom_badness(struct file *f)
+{
+
+	struct drm_file *file_priv = f->private_data;
+
+	if (file_priv)
+		return atomic_long_read(&file_priv->f_oom_badness);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_oom_badness);
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index eb0c2d041f13..768b28b198cd 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -256,6 +256,7 @@ drm_gem_object_release_handle(int id, void *ptr, void *data)
 	drm_gem_remove_prime_handles(obj, file_priv);
 	drm_vma_node_revoke(&obj->vma_node, file_priv);
 
+	atomic_long_sub(obj->size >> PAGE_SHIFT, &file_priv->f_oom_badness);
 	drm_gem_object_handle_put_unlocked(obj);
 
 	return 0;
@@ -291,6 +292,8 @@ drm_gem_handle_delete(struct drm_file *filp, u32 handle)
 	idr_remove(&filp->object_idr, handle);
 	spin_unlock(&filp->table_lock);
 
+	atomic_long_sub(obj->size >> PAGE_SHIFT, &filp->f_oom_badness);
+
 	return 0;
 }
 EXPORT_SYMBOL(drm_gem_handle_delete);
@@ -399,6 +402,8 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
 	}
 
 	*handlep = handle;
+
+	atomic_long_add(obj->size >> PAGE_SHIFT, &file_priv->f_oom_badness);
 	return 0;
 
 err_revoke:
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index e0a73a1e2df7..5926766d79f0 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -366,6 +366,13 @@ struct drm_file {
 #if IS_ENABLED(CONFIG_DRM_LEGACY)
 	unsigned long lock_count; /* DRI1 legacy lock count */
 #endif
+
+	/**
+	 * @f_oom_badness:
+	 *
+	 * How many pages are allocated through this driver connection.
+	 */
+	atomic_long_t		f_oom_badness;
 };
 
 /**
@@ -430,4 +437,6 @@ unsigned long drm_get_unmapped_area(struct file *file,
 #endif /* CONFIG_MMU */
 
 
+long drm_oom_badness(struct file *f);
+
 #endif /* _DRM_FILE_H_ */
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 9d7c61a122dc..0adf8c2f62e8 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -338,6 +338,7 @@ struct drm_gem_object {
 		.read		= drm_read,\
 		.llseek		= noop_llseek,\
 		.mmap		= drm_gem_mmap,\
+		.oom_badness	= drm_oom_badness,\
 	}
 
 void drm_gem_object_release(struct drm_gem_object *obj);
diff --git a/include/drm/drm_gem_cma_helper.h b/include/drm/drm_gem_cma_helper.h
index fbda4ce5d5fb..455ce1aa6d2c 100644
--- a/include/drm/drm_gem_cma_helper.h
+++ b/include/drm/drm_gem_cma_helper.h
@@ -273,6 +273,7 @@ unsigned long drm_gem_cma_get_unmapped_area(struct file *filp,
 		.read		= drm_read,\
 		.llseek		= noop_llseek,\
 		.mmap		= drm_gem_mmap,\
+		.oom_badness	= drm_oom_badness,\
 		DRM_GEM_CMA_UNMAPPED_AREA_FOPS \
 	}
 
-- 
2.25.1

