Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0BE1F49DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 00:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgFIW7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 18:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbgFIW50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:57:26 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D16C08C5CB
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 15:57:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j1so223617pfe.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2020 15:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CRbGyidHgu8ub4ibzKvKOJ9cFajk0nrgwC2Cw9/8ps0=;
        b=KRm1qp01HfOoqm7c7JJYTWeZfoG9kI+9Cj/eBfkVQk4V4iBR9cTQUZj2WVPX2uOU3T
         VVQF1fV1BPhqmlHv21M2DVPdhfNUW5BJg3VbHw9rh4/ejmE23l6/DQZWJH19aLWViLeQ
         jDnsiYPOwAXJ4KT0qeyYF/PXdrtO/oS1C3puQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CRbGyidHgu8ub4ibzKvKOJ9cFajk0nrgwC2Cw9/8ps0=;
        b=em0OCwm5qjXom7o3FvCY3MQnZoHYSt7SWb+9ZfF3ll8GOB3cSkAsrqbs/62GypD2Xc
         76E4mQFVqkgMp1kuSLh94VixNSeXxRL13thILcV+/39rf0kYjhArS4PrbFpa54p4Li/o
         tygxEQpGX05YM8eZJCBdPWGURzd5E9+PI4az+MPWKGe4mNCL072HkAb+1nq2B3CGDPQS
         CU33U7yNLc5i1Yz3SOmvwzyj8AH6yMf852+9Qu5Nnc0dzUF34YVET2Y853bxsQe6Q5iU
         ZtNmKZY1AlYEJ6HdHXzoIx3aGYhl1R3phsiQUtb+hI5OyLDnug9MUSYWuATTFEC3UWmn
         jbSg==
X-Gm-Message-State: AOAM532QeK3814U0utvp5PaaU7B1oMWIGIshMlgGricG2KAFWPBoN6ef
        Nqdid7igFYCIXJxiYGeRMe3kDw==
X-Google-Smtp-Source: ABdhPJzu8lPQo+zkHbLPEyXX8c+J5fZyJaqsWLq99E86mHm3rL0ToQim7vU6E10WgW5Haji32PgKaw==
X-Received: by 2002:a62:7bcd:: with SMTP id w196mr84242pfc.73.1591743434616;
        Tue, 09 Jun 2020 15:57:14 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p8sm9104978pgs.29.2020.06.09.15.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:57:13 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v8 2/8] firmware: add offset to request_firmware_into_buf
Date:   Tue,  9 Jun 2020 15:56:50 -0700
Message-Id: <20200609225656.18663-3-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609225656.18663-1-scott.branden@broadcom.com>
References: <20200609225656.18663-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add offset to request_firmware_into_buf to allow for portions
of firmware file to be read into a buffer.  Necessary where firmware
needs to be loaded in portions from file in memory constrained systems.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/base/firmware_loader/firmware.h |  5 ++
 drivers/base/firmware_loader/main.c     | 79 +++++++++++++++++++------
 include/linux/firmware.h                | 12 ++++
 3 files changed, 79 insertions(+), 17 deletions(-)

diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 933e2192fbe8..b5487f66dc45 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -32,6 +32,8 @@
  * @FW_OPT_FALLBACK_PLATFORM: Enable fallback to device fw copy embedded in
  *	the platform's main firmware. If both this fallback and the sysfs
  *      fallback are enabled, then this fallback will be tried first.
+ * @FW_OPT_PARTIAL: Allow partial read of firmware instead of needing to read
+ *	entire file.
  */
 enum fw_opt {
 	FW_OPT_UEVENT			= BIT(0),
@@ -41,6 +43,7 @@ enum fw_opt {
 	FW_OPT_NOCACHE			= BIT(4),
 	FW_OPT_NOFALLBACK_SYSFS		= BIT(5),
 	FW_OPT_FALLBACK_PLATFORM	= BIT(6),
+	FW_OPT_PARTIAL			= BIT(7),
 };
 
 enum fw_status {
@@ -68,6 +71,8 @@ struct fw_priv {
 	void *data;
 	size_t size;
 	size_t allocated_size;
+	size_t offset;
+	u32 opt_flags;
 #ifdef CONFIG_FW_LOADER_PAGED_BUF
 	bool is_paged_buf;
 	struct page **pages;
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index ca871b13524e..82c29c1f85c6 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -167,7 +167,10 @@ static int fw_cache_piggyback_on_request(const char *name);
 
 static struct fw_priv *__allocate_fw_priv(const char *fw_name,
 					  struct firmware_cache *fwc,
-					  void *dbuf, size_t size)
+					  void *dbuf,
+					  size_t size,
+					  size_t offset,
+					  u32 opt_flags)
 {
 	struct fw_priv *fw_priv;
 
@@ -185,6 +188,8 @@ static struct fw_priv *__allocate_fw_priv(const char *fw_name,
 	fw_priv->fwc = fwc;
 	fw_priv->data = dbuf;
 	fw_priv->allocated_size = size;
+	fw_priv->offset = offset;
+	fw_priv->opt_flags = opt_flags;
 	fw_state_init(fw_priv);
 #ifdef CONFIG_FW_LOADER_USER_HELPER
 	INIT_LIST_HEAD(&fw_priv->pending_list);
@@ -209,8 +214,11 @@ static struct fw_priv *__lookup_fw_priv(const char *fw_name)
 /* Returns 1 for batching firmware requests with the same name */
 static int alloc_lookup_fw_priv(const char *fw_name,
 				struct firmware_cache *fwc,
-				struct fw_priv **fw_priv, void *dbuf,
-				size_t size, u32 opt_flags)
+				struct fw_priv **fw_priv,
+				void *dbuf,
+				size_t size,
+				size_t offset,
+				u32 opt_flags)
 {
 	struct fw_priv *tmp;
 
@@ -226,7 +234,7 @@ static int alloc_lookup_fw_priv(const char *fw_name,
 		}
 	}
 
-	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size);
+	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size, offset, opt_flags);
 	if (tmp) {
 		INIT_LIST_HEAD(&tmp->list);
 		if (!(opt_flags & FW_OPT_NOCACHE))
@@ -472,7 +480,11 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 	/* Already populated data member means we're loading into a buffer */
 	if (!decompress && fw_priv->data) {
 		buffer = fw_priv->data;
-		id = READING_FIRMWARE_PREALLOC_BUFFER;
+		if (fw_priv->opt_flags & FW_OPT_PARTIAL)
+			id = READING_FIRMWARE_PARTIAL_READ;
+		else
+			id = READING_FIRMWARE_PREALLOC_BUFFER;
+
 		msize = fw_priv->allocated_size;
 	}
 
@@ -495,8 +507,10 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 		fw_priv->size = 0;
 
 		/* load firmware files from the mount namespace of init */
-		rc = kernel_read_file_from_path_initns(path, &buffer,
-						       &size, msize, id);
+		rc = kernel_pread_file_from_path_initns(path, &buffer,
+							&size, msize,
+							fw_priv->offset,
+							id);
 		if (rc) {
 			if (rc != -ENOENT)
 				dev_warn(device, "loading %s failed with error %d\n",
@@ -683,7 +697,7 @@ int assign_fw(struct firmware *fw, struct device *device, u32 opt_flags)
 static int
 _request_firmware_prepare(struct firmware **firmware_p, const char *name,
 			  struct device *device, void *dbuf, size_t size,
-			  u32 opt_flags)
+			  size_t offset, u32 opt_flags)
 {
 	struct firmware *firmware;
 	struct fw_priv *fw_priv;
@@ -702,7 +716,7 @@ _request_firmware_prepare(struct firmware **firmware_p, const char *name,
 	}
 
 	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size,
-				  opt_flags);
+				   offset, opt_flags);
 
 	/*
 	 * bind with 'priv' now to avoid warning in failure path
@@ -749,7 +763,7 @@ static void fw_abort_batch_reqs(struct firmware *fw)
 static int
 _request_firmware(const struct firmware **firmware_p, const char *name,
 		  struct device *device, void *buf, size_t size,
-		  u32 opt_flags)
+		  size_t offset, u32 opt_flags)
 {
 	struct firmware *fw = NULL;
 	int ret;
@@ -763,7 +777,7 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 	}
 
 	ret = _request_firmware_prepare(&fw, name, device, buf, size,
-					opt_flags);
+					offset, opt_flags);
 	if (ret <= 0) /* error or already assigned */
 		goto out;
 
@@ -825,7 +839,7 @@ request_firmware(const struct firmware **firmware_p, const char *name,
 
 	/* Need to pin this module until return */
 	__module_get(THIS_MODULE);
-	ret = _request_firmware(firmware_p, name, device, NULL, 0,
+	ret = _request_firmware(firmware_p, name, device, NULL, 0, 0,
 				FW_OPT_UEVENT);
 	module_put(THIS_MODULE);
 	return ret;
@@ -852,7 +866,7 @@ int firmware_request_nowarn(const struct firmware **firmware, const char *name,
 
 	/* Need to pin this module until return */
 	__module_get(THIS_MODULE);
-	ret = _request_firmware(firmware, name, device, NULL, 0,
+	ret = _request_firmware(firmware, name, device, NULL, 0, 0,
 				FW_OPT_UEVENT | FW_OPT_NO_WARN);
 	module_put(THIS_MODULE);
 	return ret;
@@ -876,7 +890,7 @@ int request_firmware_direct(const struct firmware **firmware_p,
 	int ret;
 
 	__module_get(THIS_MODULE);
-	ret = _request_firmware(firmware_p, name, device, NULL, 0,
+	ret = _request_firmware(firmware_p, name, device, NULL, 0, 0,
 				FW_OPT_UEVENT | FW_OPT_NO_WARN |
 				FW_OPT_NOFALLBACK_SYSFS);
 	module_put(THIS_MODULE);
@@ -901,7 +915,7 @@ int firmware_request_platform(const struct firmware **firmware,
 
 	/* Need to pin this module until return */
 	__module_get(THIS_MODULE);
-	ret = _request_firmware(firmware, name, device, NULL, 0,
+	ret = _request_firmware(firmware, name, device, NULL, 0, 0,
 				FW_OPT_UEVENT | FW_OPT_FALLBACK_PLATFORM);
 	module_put(THIS_MODULE);
 	return ret;
@@ -957,13 +971,44 @@ request_firmware_into_buf(const struct firmware **firmware_p, const char *name,
 		return -EOPNOTSUPP;
 
 	__module_get(THIS_MODULE);
-	ret = _request_firmware(firmware_p, name, device, buf, size,
+	ret = _request_firmware(firmware_p, name, device, buf, size, 0,
 				FW_OPT_UEVENT | FW_OPT_NOCACHE);
 	module_put(THIS_MODULE);
 	return ret;
 }
 EXPORT_SYMBOL(request_firmware_into_buf);
 
+/**
+ * request_partial_firmware_into_buf() - load partial firmware into a previously allocated buffer
+ * @firmware_p: pointer to firmware image
+ * @name: name of firmware file
+ * @device: device for which firmware is being loaded and DMA region allocated
+ * @buf: address of buffer to load firmware into
+ * @size: size of buffer
+ * @offset: offset into file to read
+ *
+ * This function works pretty much like request_firmware_into_buf except
+ * it allows a partial read of the file.
+ */
+int
+request_partial_firmware_into_buf(const struct firmware **firmware_p,
+				  const char *name, struct device *device,
+				  void *buf, size_t size, size_t offset)
+{
+	int ret;
+
+	if (fw_cache_is_setup(device, name))
+		return -EOPNOTSUPP;
+
+	__module_get(THIS_MODULE);
+	ret = _request_firmware(firmware_p, name, device, buf, size, offset,
+				FW_OPT_UEVENT | FW_OPT_NOCACHE |
+				FW_OPT_PARTIAL);
+	module_put(THIS_MODULE);
+	return ret;
+}
+EXPORT_SYMBOL(request_partial_firmware_into_buf);
+
 /**
  * release_firmware() - release the resource associated with a firmware image
  * @fw: firmware resource to release
@@ -996,7 +1041,7 @@ static void request_firmware_work_func(struct work_struct *work)
 
 	fw_work = container_of(work, struct firmware_work, work);
 
-	_request_firmware(&fw, fw_work->name, fw_work->device, NULL, 0,
+	_request_firmware(&fw, fw_work->name, fw_work->device, NULL, 0, 0,
 			  fw_work->opt_flags);
 	fw_work->cont(fw, fw_work->context);
 	put_device(fw_work->device); /* taken in request_firmware_nowait() */
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index cb3e2c06ed8a..63edc2b02e4f 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -53,6 +53,9 @@ int request_firmware_direct(const struct firmware **fw, const char *name,
 			    struct device *device);
 int request_firmware_into_buf(const struct firmware **firmware_p,
 	const char *name, struct device *device, void *buf, size_t size);
+int request_partial_firmware_into_buf(const struct firmware **firmware_p,
+				      const char *name, struct device *device,
+				      void *buf, size_t size, size_t offset);
 
 void release_firmware(const struct firmware *fw);
 #else
@@ -102,6 +105,15 @@ static inline int request_firmware_into_buf(const struct firmware **firmware_p,
 	return -EINVAL;
 }
 
+static inline int request_partial_firmware_into_buf
+					(const struct firmware **firmware_p,
+					 const char *name,
+					 struct device *device,
+					 void *buf, size_t size, offset)
+{
+	return -EINVAL;
+}
+
 #endif
 
 int firmware_request_cache(struct device *device, const char *name);
-- 
2.17.1

