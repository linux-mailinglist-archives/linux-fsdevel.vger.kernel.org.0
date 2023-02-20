Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F38369D430
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 20:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjBTTin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 14:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjBTTie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:38:34 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D761E1FD
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:24 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 45D003F720
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 19:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676921903;
        bh=wgK/ccpFWDdrinS6PVt6yIooJLrwdbOVGSrrVMJp+Ho=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=OKezp918smUm0EWp1yC4r8aGs/UGiH9zxicgz8nN7Xhs590dpIMNoitLn3rgmVUB0
         0NE449N+U1cIsxwxVraSkPi1+YVwI6NcaMUCeN0cyyGj9RWMz9EYGdpATddAh5qRTe
         KISXv5LICcNn5i5jZYNOrUdEM7b8oM+SOf4Jfm+IMmHaI9ocPwoFcFfhqlmefIlenn
         d2aD1CXTR/zhD1hFqlFdh1t+Q0QjwJVmnCifj6BJ2JGQGqDIrvMjRCT3UOqNr3xIOW
         gSP7uU9L7x0WFTnuHJSMquMLdr8UzhDa8eRWVM8WTUj7TjdrBim28ISJJfXET8C//g
         twlbciTbc8NPQ==
Received: by mail-ed1-f70.google.com with SMTP id er17-20020a056402449100b004ad793116d5so1065024edb.23
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgK/ccpFWDdrinS6PVt6yIooJLrwdbOVGSrrVMJp+Ho=;
        b=XzFSAy5Qk0fvdG8I1uK1JqaRIZbqivWs2LMljedFvQookb+L6fPjpVyVU4l8IH/XAI
         8s9sSvDFDHJZE+SKcA2sBny7GvKmQV4ZhU0KKuPiEwG29PKUFNm0+o7OAxec4snzjGuC
         VmjSQ6bmfNV41Nj2JJ2Tnrfsp0lCeloozwrSTjy9QLvTblJL9rOChOsY/+kL072YHtqx
         j4PgFW8/hDTZMmP2yVbC8Olaj7/QdGwSF1ZuwQtYYw/jRSRzzJxfdzxzMYqwNS70RW1s
         2l/gFLZnkBLGZIpajEDipuuSTy2i+v6p8eEdLcARK3HmIYtgoy5b6NR/nMd1iKQ1UGdM
         qn4Q==
X-Gm-Message-State: AO0yUKW5/OGgxPWjZXto82w92cZsCi9hrlBlGlhA31Ty9EYCOD9vF3B8
        /fYBKGHn7Yv9hOY/166umttZNfNmu1xGqwyrdPKRqncAEJL+FI+LY60QPugTUoisc/jTYcKLQH8
        L8Q2zl77eM/Jj/z3yXtomQ8QD+p4faYMJZ9Ro62lETFbjptpF
X-Received: by 2002:a17:906:5f93:b0:8af:2a97:91d4 with SMTP id a19-20020a1709065f9300b008af2a9791d4mr8676542eju.14.1676921902860;
        Mon, 20 Feb 2023 11:38:22 -0800 (PST)
X-Google-Smtp-Source: AK7set9bcTHcatncXa8wlU3TSRfSP2fOd0mUHQR7oqeIqA73Ga6RM+ssQr4E60NApZKqHA8RyLtkAw==
X-Received: by 2002:a17:906:5f93:b0:8af:2a97:91d4 with SMTP id a19-20020a1709065f9300b008af2a9791d4mr8676526eju.14.1676921902560;
        Mon, 20 Feb 2023 11:38:22 -0800 (PST)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:bb20:aed2:bb7f:f0cf])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090680d300b008d4df095034sm1526693ejx.195.2023.02.20.11.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 11:38:22 -0800 (PST)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH 7/9] fuse: add fuse device ioctl(FUSE_DEV_IOC_REINIT)
Date:   Mon, 20 Feb 2023 20:37:52 +0100
Message-Id: <20230220193754.470330-8-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: criu@openvz.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dev.c             | 132 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |   1 +
 2 files changed, 133 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 737764c2295e..0f53ffd63957 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2187,6 +2187,112 @@ void fuse_abort_conn(struct fuse_conn *fc)
 }
 EXPORT_SYMBOL_GPL(fuse_abort_conn);
 
+static int fuse_reinit_conn(struct fuse_conn *fc)
+{
+	struct fuse_iqueue *fiq = &fc->iq;
+	struct fuse_dev *fud;
+	unsigned int i;
+
+	if (fc->conn_gen + 1 < fc->conn_gen)
+		return -EOVERFLOW;
+
+	fuse_abort_conn(fc);
+	fuse_wait_aborted(fc);
+
+	spin_lock(&fc->lock);
+	if (fc->connected) {
+		spin_unlock(&fc->lock);
+		return -EINVAL;
+	}
+
+	if (fc->conn_gen + 1 < fc->conn_gen) {
+		spin_unlock(&fc->lock);
+		return -EOVERFLOW;
+	}
+
+	fc->conn_gen++;
+
+	spin_lock(&fiq->lock);
+	if (request_pending(fiq) || fiq->forget_list_tail != &fiq->forget_list_head) {
+		spin_unlock(&fiq->lock);
+		spin_unlock(&fc->lock);
+		return -EINVAL;
+	}
+
+	if (&fuse_dev_fiq_ops != fiq->ops) {
+		spin_unlock(&fiq->lock);
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
+			spin_unlock(&fc->lock);
+			return -EINVAL;
+		}
+
+		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++) {
+			if (!list_empty(&fpq->processing[i])) {
+				spin_unlock(&fpq->lock);
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
+	return 0;
+}
+
 void fuse_wait_aborted(struct fuse_conn *fc)
 {
 	/* matches implicit memory barrier in fuse_drop_waiting() */
@@ -2282,6 +2388,32 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
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
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1b9d0dfae72d..3dac67b25eae 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -989,6 +989,7 @@ struct fuse_notify_retrieve_in {
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
+#define FUSE_DEV_IOC_REINIT		_IO(FUSE_DEV_IOC_MAGIC, 0)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.34.1

