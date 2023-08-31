Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E23278F42F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 22:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbjHaUhb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 16:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347431AbjHaUh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:37:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE3D10C2
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 13:37:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d74a012e6a6so1021828276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 13:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693514245; x=1694119045; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yBbx4b8+p9YSAXqpoHoy5g7vSJRSgSl+lhiyxSfb/eU=;
        b=0ZPTG/K7z5/cT3ShYOz0vb8RRH4Nw5JXxa7KNOL84iPd1CZJTHmMWpm+xmKxB9Vedi
         o6croEnyFXHRTciz3Ezy+AR6G9NjYBw/vR2C12GNnJbH9rG6IxMXq7cU+A/KN30iWzo0
         C3kmfe//Nq5Upsh9aBAVG16S3pEbGPBhnd2VcTeSnecYNGtP0waNq6wqZhBL1Mrl3GgV
         exqBkHKhdfVkahdff25HfoKIw99yBYeqZbnLDr1ofsMz8R8AgCzoXG+wlrl6e83I3qnt
         WrAnR8VQUb5EsgG9+ZTMMgQOFUFLNAcDHIbyMmbDg+nmGxrxAKF0aoCHA/ey26lhxVZz
         OfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693514245; x=1694119045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBbx4b8+p9YSAXqpoHoy5g7vSJRSgSl+lhiyxSfb/eU=;
        b=ePquwRmsR7N/QnPcQS6ql/7BCRJ7OHhLC2kf1b34Lsbrpx32jJj/K/bGTr1y2Rpptz
         aAgHpoYMSA17Bpv/o//4TBXW1f9ZQe9w9trlAnYfiBL2nZx0bzb+/UFNFE5R3BAOUQtO
         li0/1NW1sZBKO8FsblxnaPAqSt+Jgoh/cHMm79cdU3DEsn/xQSj9w5RARNJA2kR2iGe5
         c8klP1p9me8NGHfO0064dXabLGocFplYCzCc9WkohoNHJzN/AcEES9B5pcb/IpFxEq67
         RaHjdxh1kRfYdsk4F09Y+3Ek/E8QnsCP2ZtffjFjuLyQFlZlOsZYjgULTYEHZVyGJHOb
         5R7A==
X-Gm-Message-State: AOJu0YwjVs0AluK2uf0Ek4JTueDAL8GEu+Lno5HtFl11p3ae9X5hGIMn
        YTX4Y2aYrCvboVr17a9U7LfqhHdvMddRh4tG
X-Google-Smtp-Source: AGHT+IF1LWmDxsSgnrtvI1kzQAdmqG9kkHzoMRjXO6gEE8jOd/mbGmywsGSMUbTy0xnAonh3GTBUSjDNwaJZ1HZV
X-Received: from mclapinski.waw.corp.google.com ([2a00:79e0:9b:0:36f8:f0a:6df2:a7d5])
 (user=mclapinski job=sendgmr) by 2002:a05:6902:11c9:b0:d20:7752:e384 with
 SMTP id n9-20020a05690211c900b00d207752e384mr22037ybu.3.1693514245015; Thu,
 31 Aug 2023 13:37:25 -0700 (PDT)
Date:   Thu, 31 Aug 2023 22:36:46 +0200
In-Reply-To: <20230831203647.558079-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20230831203647.558079-1-mclapinski@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230831203647.558079-2-mclapinski@google.com>
Subject: [PATCH 1/2] fcntl: add fcntl(F_CHECK_ORIGINAL_MEMFD)
From:   Michal Clapinski <mclapinski@google.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Xu <jeffxu@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a way to check if an fd points to the memfd's original open fd
(the one created by memfd_create).
Useful because only the original open fd can be both writable and
executable.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 fs/fcntl.c                 | 3 +++
 include/uapi/linux/fcntl.h | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index e871009f6c88..301527e07a4d 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -419,6 +419,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_SET_RW_HINT:
 		err = fcntl_rw_hint(filp, cmd, arg);
 		break;
+	case F_CHECK_ORIGINAL_MEMFD:
+		err = !(filp->f_mode & FMODE_WRITER);
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 6c80f96049bd..9a10fe3aafa7 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -56,6 +56,15 @@
 #define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
 #define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
 
+/*
+ * Check if the fd points to the memfd's original open fd (the one created by
+ * memfd_create). Returns 1 if yes, 0 if no.
+ * If the fd doesn't point to a memfd, the value should not be interpreted.
+ * Useful because only the original open fd can be both writable and
+ * executable.
+ */
+#define F_CHECK_ORIGINAL_MEMFD	(F_LINUX_SPECIFIC_BASE + 15)
+
 /*
  * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
  * used to clear any hints previously set.
-- 
2.42.0.283.g2d96d420d3-goog

