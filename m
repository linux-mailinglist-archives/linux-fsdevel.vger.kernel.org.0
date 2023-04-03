Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36366D4A8A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 16:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjDCOsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 10:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjDCOra (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:47:30 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E977628EA4
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 07:46:47 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B97AB3F858
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 14:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680533147;
        bh=N1lNLcfnab/Xak3vE1BXdEngtUghqVUaWAQgAOaQ90I=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=uUMWMBDZx58VKlTxjaA0MiHajAjIifwVyGwQ+GhfBSNwqIa2tREtUaK5l4L2ZLXWb
         0r7d8LcT085bQHGfsPYzgc9p3iB/52TKqALysFvhC3kpziM3PvO9+v0Is68KVKkRHR
         8MH6KXwrxuAKIe+QZQmL53XCZEFunP+gy7hi7lU8o+v+666a/MAGF9lDHnywkT3pdN
         +vl0ybx9ukSKQqL4LShkvnWX2S4UPnmZy6eVtwo4dho0DKHA4lAinAV3dMGvkN2SfW
         /oxuZ+s33OTR3/6lkK/CdOpiH8WxlrZqSLeTYjk6oXaUSe/lucHKRB17dVU2awuXli
         KGsmQjA8VOyfQ==
Received: by mail-ed1-f71.google.com with SMTP id b6-20020a509f06000000b005029d95390aso5090074edf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 07:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1lNLcfnab/Xak3vE1BXdEngtUghqVUaWAQgAOaQ90I=;
        b=5ysmgUULo1eQxhQpofjVvUcbBitUwXOT2Y+OHHYzLC9n+zQGGxsDhL6n+U1lfgHeIv
         Sv/vgdr8Y+7hsbhvDhVc/13CClkOZIDqoMc2NbnvZN5FKF9qlAJkgF9aDSuERqBrQX/W
         R+Gc7tl5bjioW4ArSFrDHYgxBf2i9KehEGwoQwj2NJdpR3TNxUCaxQHrYRSPGTutugbp
         MJfSM8hYZyBRnXUpjeqzyOmIjaYyzbDBGnyHySV1FtRDdvIsR/xzjzrnTZjPEqgjFNyX
         Ynu/A4QOjCYLpR4l58CHj+2AZwTKst96Uf6EtzvENFkfOLYkI3eMqRuctNBs2Fk0JRpz
         rJ1A==
X-Gm-Message-State: AAQBX9eFAzhzd7jmtFhwxLoLKzK+FMUEAtbWhH1R498Dnvy5wtA8z2M6
        2YF3s+7LnLg9f/Kf+AmtdL4JGQah9MsO1hx/lWhnLiHbjS+QZDZHD8XTb/Zq13Jx5BKW0VSOaoL
        seOWm2wqCOeQNXQpecgbtmG10QpZrfGzVNPR6kVE6vZE=
X-Received: by 2002:a17:907:d487:b0:93f:fbe:c388 with SMTP id vj7-20020a170907d48700b0093f0fbec388mr34735183ejc.27.1680533147537;
        Mon, 03 Apr 2023 07:45:47 -0700 (PDT)
X-Google-Smtp-Source: AKy350bcO0nfWshaXRLgIpS2eZis0PuIuWt4U+aoRv7PYgiFEjJZmPa6l00ijPySY3vFOAzJmjYOZQ==
X-Received: by 2002:a17:907:d487:b0:93f:fbe:c388 with SMTP id vj7-20020a170907d48700b0093f0fbec388mr34735154ejc.27.1680533147248;
        Mon, 03 Apr 2023 07:45:47 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bd076.dynamic.kabel-deutschland.de. [95.91.208.118])
        by smtp.gmail.com with ESMTPSA id i5-20020a50d745000000b004fa19f5ba99sm4735804edj.79.2023.04.03.07.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 07:45:46 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     flyingpeng@tencent.com,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH v2 7/9] fuse: add fuse device ioctl(FUSE_DEV_IOC_REINIT)
Date:   Mon,  3 Apr 2023 16:45:15 +0200
Message-Id: <20230403144517.347517-8-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This ioctl aborts fuse connection and then reinitializes it,
sends FUSE_INIT request to allow a new userspace daemon
to pick up the fuse connection.

Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Stéphane Graber <stgraber@ubuntu.com>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: criu@openvz.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dev.c             | 152 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h          |   3 +
 include/uapi/linux/fuse.h |   1 +
 3 files changed, 156 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index b4501a10c379..93a457c90b49 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2187,6 +2187,132 @@ void fuse_abort_conn(struct fuse_conn *fc)
 }
 EXPORT_SYMBOL_GPL(fuse_abort_conn);
 
+static int fuse_reinit_conn(struct fuse_conn *fc)
+{
+	struct fuse_iqueue *fiq = &fc->iq;
+	struct fuse_dev *fud;
+	unsigned int i;
+
+	spin_lock(&fc->lock);
+	if (fc->reinit_in_progress) {
+		spin_unlock(&fc->lock);
+		return -EBUSY;
+	}
+
+	if (fc->conn_gen + 1 < fc->conn_gen) {
+		spin_unlock(&fc->lock);
+		return -EOVERFLOW;
+	}
+
+	fc->reinit_in_progress = true;
+	spin_unlock(&fc->lock);
+
+	/*
+	 * Unsets fc->connected and fiq->connected and
+	 * ensures that no new requests can be queued
+	 */
+	fuse_abort_conn(fc);
+	fuse_wait_aborted(fc);
+
+	spin_lock(&fc->lock);
+	if (fc->connected) {
+		fc->reinit_in_progress = false;
+		spin_unlock(&fc->lock);
+		return -EINVAL;
+	}
+
+	fc->conn_gen++;
+
+	spin_lock(&fiq->lock);
+	if (request_pending(fiq) || fiq->forget_list_tail != &fiq->forget_list_head) {
+		spin_unlock(&fiq->lock);
+		fc->reinit_in_progress = false;
+		spin_unlock(&fc->lock);
+		return -EINVAL;
+	}
+
+	if (&fuse_dev_fiq_ops != fiq->ops) {
+		spin_unlock(&fiq->lock);
+		fc->reinit_in_progress = false;
+		spin_unlock(&fc->lock);
+		return -EOPNOTSUPP;
+	}
+
+	fiq->connected = 1;
+	spin_unlock(&fiq->lock);
+
+	spin_lock(&fc->bg_lock);
+	if (!list_empty(&fc->bg_queue)) {
+		spin_unlock(&fc->bg_lock);
+		fc->reinit_in_progress = false;
+		spin_unlock(&fc->lock);
+		return -EINVAL;
+	}
+
+	fc->blocked = 0;
+	fc->max_background = FUSE_DEFAULT_MAX_BACKGROUND;
+	spin_unlock(&fc->bg_lock);
+
+	list_for_each_entry(fud, &fc->devices, entry) {
+		struct fuse_pqueue *fpq = &fud->pq;
+
+		spin_lock(&fpq->lock);
+		if (!list_empty(&fpq->io)) {
+			spin_unlock(&fpq->lock);
+			fc->reinit_in_progress = false;
+			spin_unlock(&fc->lock);
+			return -EINVAL;
+		}
+
+		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++) {
+			if (!list_empty(&fpq->processing[i])) {
+				spin_unlock(&fpq->lock);
+				fc->reinit_in_progress = false;
+				spin_unlock(&fc->lock);
+				return -EINVAL;
+			}
+		}
+
+		fpq->connected = 1;
+		spin_unlock(&fpq->lock);
+	}
+
+	fuse_set_initialized(fc);
+
+	/* Background queuing checks fc->connected under bg_lock */
+	spin_lock(&fc->bg_lock);
+	fc->connected = 1;
+	spin_unlock(&fc->bg_lock);
+
+	fc->aborted = false;
+	fc->abort_err = 0;
+
+	/* nullify all the flags */
+	memset(&fc->flags, 0, sizeof(struct fuse_conn_flags));
+
+	spin_unlock(&fc->lock);
+
+	down_read(&fc->killsb);
+	if (!list_empty(&fc->mounts)) {
+		struct fuse_mount *fm;
+
+		fm = list_first_entry(&fc->mounts, struct fuse_mount, fc_entry);
+		if (!fm->sb) {
+			up_read(&fc->killsb);
+			return -EINVAL;
+		}
+
+		fuse_send_init(fm);
+	}
+	up_read(&fc->killsb);
+
+	spin_lock(&fc->lock);
+	fc->reinit_in_progress = false;
+	spin_unlock(&fc->lock);
+
+	return 0;
+}
+
 void fuse_wait_aborted(struct fuse_conn *fc)
 {
 	/* matches implicit memory barrier in fuse_drop_waiting() */
@@ -2282,6 +2408,32 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			}
 		}
 		break;
+	case FUSE_DEV_IOC_REINIT:
+		struct fuse_conn *fc;
+
+		if (!checkpoint_restore_ns_capable(file->f_cred->user_ns))
+			return -EPERM;
+
+		res = -EINVAL;
+		fud = fuse_get_dev(file);
+
+		/*
+		 * Only fuse mounts with an already initialized fuse
+		 * connection are supported
+		 */
+		if (file->f_op == &fuse_dev_operations && fud) {
+			mutex_lock(&fuse_mutex);
+			fc = fud->fc;
+			if (fc)
+				fc = fuse_conn_get(fc);
+			mutex_unlock(&fuse_mutex);
+
+			if (fc) {
+				res = fuse_reinit_conn(fc);
+				fuse_conn_put(fc);
+			}
+		}
+		break;
 	default:
 		res = -ENOTTY;
 		break;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 90c5b3459864..8f2c0f969f6f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -752,6 +752,9 @@ struct fuse_conn {
 	/** Connection aborted via sysfs */
 	bool aborted;
 
+	/** Connection reinit in progress */
+	bool reinit_in_progress;
+
 	/** Connection failed (version mismatch).  Cannot race with
 	    setting other bitfields since it is only set once in INIT
 	    reply, before any other request, and never cleared */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index b3fcab13fcd3..325da23431ef 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -992,6 +992,7 @@ struct fuse_notify_retrieve_in {
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
+#define FUSE_DEV_IOC_REINIT		_IO(FUSE_DEV_IOC_MAGIC, 0)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.34.1

