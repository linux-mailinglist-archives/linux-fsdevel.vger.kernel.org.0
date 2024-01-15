Return-Path: <linux-fsdevel+bounces-7988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92AB82E01F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2518BB217FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 18:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2167B18ECA;
	Mon, 15 Jan 2024 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="racXoa4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262BF18E34
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc221ed88d9so12655276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 10:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705343925; x=1705948725; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ch6T6Lsnf4fqmqV9A6xFsxD4eG+jCeNRaJgu+LlgQig=;
        b=racXoa4TnsLPy0OFLS+xzftOB6e28+Lm+G2K0Tue45QfDYhuBJN8zPqvCSUGQLIRGB
         Ex7Z6px6V8c6e9Z+zu1ZevP638iygpxyIbCeKxw+/zA1/m3DWs3ASyzMRqrxxKdRy5d2
         wDUSFiLSWkykFnGsS1vGxi/zl/FfuDuWQ9fqAKrxd/AzlFxQhDZmsmgQtFs+EA3fu0AC
         UhGvm4g0XgBnaKtwq1QV/3UFtrDZHaafByjh3e66qJ3jjE7xnQcwWxNoEKsCr8pl5Mbz
         boLb+9tYXQq2eQtoiY8sAg8FH99i29PfnKLuRpSLH30hqUjWZm6ROwwLw6d7ZAfmClIa
         zW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705343925; x=1705948725;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ch6T6Lsnf4fqmqV9A6xFsxD4eG+jCeNRaJgu+LlgQig=;
        b=ghxee/i5FSPwJH3cqkqwLP3ptURhw3uR8XoctSz80kzt5BCietVzhHAqEf6k/QnEci
         NsP+0wMS8+Vaesz3elrsVynnZuz7crgl0zBdFwLWVU9UCmOlvSGpDZqV82JBiMK9BxgI
         U4WE6a6DTjsrai48ACFE6GztQKm8TziujQ6M/ofQ49veejF95CAJJU6ouJgoQBtB1VFa
         4YOK/8gjkoOE8zTIFr4QMsvLVaYQOs38wTIzELvDg3ICF9coZaB5SALV6BecJvjy+o57
         zboL4EgF0mfJwHjiylqUw62Ng1ZFTd85iMEQw7LVUuacSdkq+JxLFy6LusbnaUAiVlrz
         XpeQ==
X-Gm-Message-State: AOJu0YxDiclgRx+jDAKl6wwC0S0t8ubR9WNU1cqzi2YWv8HMwivucsqi
	7xfXid8zO+9dyfjQmALoaEo1b3afEDUaKqNWtw==
X-Google-Smtp-Source: AGHT+IGN2VvUUxNx3HDpn+LUP1maSJ793VbScOs1XRHuqJsGhFfM1RNtInfsiW1wKVri/L8s95oaaZe3g/g=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3af2:e48e:2785:270])
 (user=surenb job=sendgmr) by 2002:a05:6902:1364:b0:dbd:7149:a389 with SMTP id
 bt4-20020a056902136400b00dbd7149a389mr269675ybb.11.1705343925137; Mon, 15 Jan
 2024 10:38:45 -0800 (PST)
Date: Mon, 15 Jan 2024 10:38:35 -0800
In-Reply-To: <20240115183837.205694-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240115183837.205694-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240115183837.205694-3-surenb@google.com>
Subject: [RFC 2/3] seq_file: add validate() operation to seq_operations
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	dchinner@redhat.com, casey@schaufler-ca.com, ben.wolsieffer@hefring.com, 
	paulmck@kernel.org, david@redhat.com, avagin@google.com, 
	usama.anjum@collabora.com, peterx@redhat.com, hughd@google.com, 
	ryan.roberts@arm.com, wangkefeng.wang@huawei.com, Liam.Howlett@Oracle.com, 
	yuzhao@google.com, axelrasmussen@google.com, lstoakes@gmail.com, 
	talumbau@google.com, willy@infradead.org, vbabka@suse.cz, 
	mgorman@techsingularity.net, jhubbard@nvidia.com, vishal.moola@gmail.com, 
	mathieu.desnoyers@efficios.com, dhowells@redhat.com, jgg@ziepe.ca, 
	sidhartha.kumar@oracle.com, andriy.shevchenko@linux.intel.com, 
	yangxingui@huawei.com, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, kernel-team@android.com, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"

seq_file outputs data in chunks using seq_file.buf as the intermediate
storage before outputting the generated data for the current chunk. It is
possible for already buffered data to become stale before it gets reported.
In certain situations it is desirable to regenerate that data instead of
reporting the stale one. Provide a validate() operation called before
outputting the buffered data to allow users to validate buffered data.
To indicate valid data, user's validate callback should return 0, to
request regeneration of the stale data it should return -EAGAIN, any
other error will be considered fatal and read operation will be aborted.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/seq_file.c            | 24 +++++++++++++++++++++++-
 include/linux/seq_file.h |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index f5fdaf3b1572..77833bbe5909 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -172,6 +172,8 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct seq_file *m = iocb->ki_filp->private_data;
 	size_t copied = 0;
+	loff_t orig_index;
+	size_t orig_count;
 	size_t n;
 	void *p;
 	int err = 0;
@@ -220,6 +222,10 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		if (m->count)	// hadn't managed to copy everything
 			goto Done;
 	}
+
+	orig_index = m->index;
+	orig_count = m->count;
+Again:
 	// get a non-empty record in the buffer
 	m->from = 0;
 	p = m->op->start(m, &m->index);
@@ -278,6 +284,22 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		}
 	}
 	m->op->stop(m, p);
+	/* Note: we validate even if err<0 to prevent publishing copied data */
+	if (m->op->validate) {
+		int val_err = m->op->validate(m, p);
+
+		if (val_err) {
+			if (val_err == -EAGAIN) {
+				m->index = orig_index;
+				m->count = orig_count;
+				// data is stale, retry
+				goto Again;
+			}
+			// data is invalid, return the last error
+			err = val_err;
+			goto Done;
+		}
+	}
 	n = copy_to_iter(m->buf, m->count, iter);
 	copied += n;
 	m->count -= n;
@@ -572,7 +594,7 @@ static void single_stop(struct seq_file *p, void *v)
 int single_open(struct file *file, int (*show)(struct seq_file *, void *),
 		void *data)
 {
-	struct seq_operations *op = kmalloc(sizeof(*op), GFP_KERNEL_ACCOUNT);
+	struct seq_operations *op = kzalloc(sizeof(*op), GFP_KERNEL_ACCOUNT);
 	int res = -ENOMEM;
 
 	if (op) {
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 234bcdb1fba4..d0fefac2990f 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -34,6 +34,7 @@ struct seq_operations {
 	void (*stop) (struct seq_file *m, void *v);
 	void * (*next) (struct seq_file *m, void *v, loff_t *pos);
 	int (*show) (struct seq_file *m, void *v);
+	int (*validate)(struct seq_file *m, void *v);
 };
 
 #define SEQ_SKIP 1
-- 
2.43.0.381.gb435a96ce8-goog


