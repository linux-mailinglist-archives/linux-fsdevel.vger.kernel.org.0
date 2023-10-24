Return-Path: <linux-fsdevel+bounces-1051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CBA7D528F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3CF6B21959
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C536D30F80;
	Tue, 24 Oct 2023 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbEojL0X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A72B2B75A
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:47:13 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4FB170E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:47:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5abfa4c10c4so26018177b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155228; x=1698760028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9NoZOXA8j9UYH0qbl3Heb4+Wi1EaC598WUGqABNW4pA=;
        b=jbEojL0XZTmKOwfTOL1JrB3j2DoioPlUddoBoQWJbgvOwZobLdb1pOoe4yVgr6lOe7
         egEUFAZ8AXKqHEizuzXI3b9C3aJmIIThNHU2IrVSUZ5rEl05sDgGnXAw8Hqppf+Uad7z
         Zx092r39CZJ1BDlqhvzpdXnqDLw2uXwhtEa8uBOvlK2TpbFzqAtN6EDYUZCE3LyvXtCH
         6lYpHRBfKbd0mYrGAsJ0IrXvQvTacok4XeYp/NsQmbls8cqdb4M3JY6g6loRYl50JeBF
         zE/DL7gj/WBnpcV+TqiluDHjfBFvwVEgXNl4CULPHYaI+p3SQaW4K1zM3OUbrQvpYKj9
         YiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155228; x=1698760028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9NoZOXA8j9UYH0qbl3Heb4+Wi1EaC598WUGqABNW4pA=;
        b=lmP+ri6G6otOSOV81T1hcxZ97MHItzhrDgh62tdpz1nAbVehTs8MoOA9m6C2LNz2AP
         OIM85U9zO6u23VeeWgFd9gYCguw4Z1jPlSC7Lqjj4XA2yvvLltXB7AKZQh/vWPQpSJFX
         lqCMRP1/rtQVvbOc3UWVcPOGZS1kzF3WL2f84y5LB4iy4AqtjqWMMmTET4fTGhZOtW0D
         iiQbILF9GKNizKOD3K5M3sMxx2PrHNCAGjEMyWWyZk2fL3dHeDWI2qofGYXP4L2Rtg4t
         shJjsV8qECBAkvtzJ6GDp4k/LgztQQUBX7huB1BMKkyKGfhP5mwiVSiYVIjM0Y4RPvF/
         rv8g==
X-Gm-Message-State: AOJu0YyC3jT3EWyx5JOddUbmHVUMaZ/JkKgUoqlKE/KFzrHkvUS3NfpU
	q1lquR65XEYaSY05n1ZKg85yItXgCJc=
X-Google-Smtp-Source: AGHT+IEp6i7OIYLqR0zo2UBT4fCb6INeX9PpoJn2QVEvfaV9Q3dpXadwEMR0perH7aOFZkHGn0YJqemKbwE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a81:a08c:0:b0:57a:e0b:f63 with SMTP id
 x134-20020a81a08c000000b0057a0e0b0f63mr272098ywg.7.1698155228147; Tue, 24 Oct
 2023 06:47:08 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:46:09 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-13-surenb@google.com>
Subject: [PATCH v2 12/39] lib: code tagging framework
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add basic infrastructure to support code tagging which stores tag common
information consisting of the module name, function, file name and line
number. Provide functions to register a new code tag type and navigate
between code tags.

Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/codetag.h |  71 ++++++++++++++
 lib/Kconfig.debug       |   4 +
 lib/Makefile            |   1 +
 lib/codetag.c           | 199 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 275 insertions(+)
 create mode 100644 include/linux/codetag.h
 create mode 100644 lib/codetag.c

diff --git a/include/linux/codetag.h b/include/linux/codetag.h
new file mode 100644
index 000000000000..a9d7adecc2a5
--- /dev/null
+++ b/include/linux/codetag.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * code tagging framework
+ */
+#ifndef _LINUX_CODETAG_H
+#define _LINUX_CODETAG_H
+
+#include <linux/types.h>
+
+struct codetag_iterator;
+struct codetag_type;
+struct seq_buf;
+struct module;
+
+/*
+ * An instance of this structure is created in a special ELF section at every
+ * code location being tagged.  At runtime, the special section is treated as
+ * an array of these.
+ */
+struct codetag {
+	unsigned int flags; /* used in later patches */
+	unsigned int lineno;
+	const char *modname;
+	const char *function;
+	const char *filename;
+} __aligned(8);
+
+union codetag_ref {
+	struct codetag *ct;
+};
+
+struct codetag_range {
+	struct codetag *start;
+	struct codetag *stop;
+};
+
+struct codetag_module {
+	struct module *mod;
+	struct codetag_range range;
+};
+
+struct codetag_type_desc {
+	const char *section;
+	size_t tag_size;
+};
+
+struct codetag_iterator {
+	struct codetag_type *cttype;
+	struct codetag_module *cmod;
+	unsigned long mod_id;
+	struct codetag *ct;
+};
+
+#define CODE_TAG_INIT {					\
+	.modname	= KBUILD_MODNAME,		\
+	.function	= __func__,			\
+	.filename	= __FILE__,			\
+	.lineno		= __LINE__,			\
+	.flags		= 0,				\
+}
+
+void codetag_lock_module_list(struct codetag_type *cttype, bool lock);
+struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttype);
+struct codetag *codetag_next_ct(struct codetag_iterator *iter);
+
+void codetag_to_text(struct seq_buf *out, struct codetag *ct);
+
+struct codetag_type *
+codetag_register_type(const struct codetag_type_desc *desc);
+
+#endif /* _LINUX_CODETAG_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index fa307f93fa2e..2acbef24e93e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -962,6 +962,10 @@ config DEBUG_STACKOVERFLOW
 
 	  If in doubt, say "N".
 
+config CODE_TAGGING
+	bool
+	select KALLSYMS
+
 source "lib/Kconfig.kasan"
 source "lib/Kconfig.kfence"
 source "lib/Kconfig.kmsan"
diff --git a/lib/Makefile b/lib/Makefile
index 740109b6e2c8..b50212b5b999 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -233,6 +233,7 @@ obj-$(CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT) += \
 	of-reconfig-notifier-error-inject.o
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 
+obj-$(CONFIG_CODE_TAGGING) += codetag.o
 lib-$(CONFIG_GENERIC_BUG) += bug.o
 
 obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
diff --git a/lib/codetag.c b/lib/codetag.c
new file mode 100644
index 000000000000..7708f8388e55
--- /dev/null
+++ b/lib/codetag.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/codetag.h>
+#include <linux/idr.h>
+#include <linux/kallsyms.h>
+#include <linux/module.h>
+#include <linux/seq_buf.h>
+#include <linux/slab.h>
+
+struct codetag_type {
+	struct list_head link;
+	unsigned int count;
+	struct idr mod_idr;
+	struct rw_semaphore mod_lock; /* protects mod_idr */
+	struct codetag_type_desc desc;
+};
+
+static DEFINE_MUTEX(codetag_lock);
+static LIST_HEAD(codetag_types);
+
+void codetag_lock_module_list(struct codetag_type *cttype, bool lock)
+{
+	if (lock)
+		down_read(&cttype->mod_lock);
+	else
+		up_read(&cttype->mod_lock);
+}
+
+struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttype)
+{
+	struct codetag_iterator iter = {
+		.cttype = cttype,
+		.cmod = NULL,
+		.mod_id = 0,
+		.ct = NULL,
+	};
+
+	return iter;
+}
+
+static inline struct codetag *get_first_module_ct(struct codetag_module *cmod)
+{
+	return cmod->range.start < cmod->range.stop ? cmod->range.start : NULL;
+}
+
+static inline
+struct codetag *get_next_module_ct(struct codetag_iterator *iter)
+{
+	struct codetag *res = (struct codetag *)
+			((char *)iter->ct + iter->cttype->desc.tag_size);
+
+	return res < iter->cmod->range.stop ? res : NULL;
+}
+
+struct codetag *codetag_next_ct(struct codetag_iterator *iter)
+{
+	struct codetag_type *cttype = iter->cttype;
+	struct codetag_module *cmod;
+	struct codetag *ct;
+
+	lockdep_assert_held(&cttype->mod_lock);
+
+	if (unlikely(idr_is_empty(&cttype->mod_idr)))
+		return NULL;
+
+	ct = NULL;
+	while (true) {
+		cmod = idr_find(&cttype->mod_idr, iter->mod_id);
+
+		/* If module was removed move to the next one */
+		if (!cmod)
+			cmod = idr_get_next_ul(&cttype->mod_idr,
+					       &iter->mod_id);
+
+		/* Exit if no more modules */
+		if (!cmod)
+			break;
+
+		if (cmod != iter->cmod) {
+			iter->cmod = cmod;
+			ct = get_first_module_ct(cmod);
+		} else
+			ct = get_next_module_ct(iter);
+
+		if (ct)
+			break;
+
+		iter->mod_id++;
+	}
+
+	iter->ct = ct;
+	return ct;
+}
+
+void codetag_to_text(struct seq_buf *out, struct codetag *ct)
+{
+	seq_buf_printf(out, "%s:%u module:%s func:%s",
+		       ct->filename, ct->lineno,
+		       ct->modname, ct->function);
+}
+
+static inline size_t range_size(const struct codetag_type *cttype,
+				const struct codetag_range *range)
+{
+	return ((char *)range->stop - (char *)range->start) /
+			cttype->desc.tag_size;
+}
+
+static void *get_symbol(struct module *mod, const char *prefix, const char *name)
+{
+	char buf[64];
+	int res;
+
+	res = snprintf(buf, sizeof(buf), "%s%s", prefix, name);
+	if (WARN_ON(res < 1 || res > sizeof(buf)))
+		return NULL;
+
+	return mod ?
+		(void *)find_kallsyms_symbol_value(mod, buf) :
+		(void *)kallsyms_lookup_name(buf);
+}
+
+static struct codetag_range get_section_range(struct module *mod,
+					      const char *section)
+{
+	return (struct codetag_range) {
+		get_symbol(mod, "__start_", section),
+		get_symbol(mod, "__stop_", section),
+	};
+}
+
+static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
+{
+	struct codetag_range range;
+	struct codetag_module *cmod;
+	int err;
+
+	range = get_section_range(mod, cttype->desc.section);
+	if (!range.start || !range.stop) {
+		pr_warn("Failed to load code tags of type %s from the module %s\n",
+			cttype->desc.section,
+			mod ? mod->name : "(built-in)");
+		return -EINVAL;
+	}
+
+	/* Ignore empty ranges */
+	if (range.start == range.stop)
+		return 0;
+
+	BUG_ON(range.start > range.stop);
+
+	cmod = kmalloc(sizeof(*cmod), GFP_KERNEL);
+	if (unlikely(!cmod))
+		return -ENOMEM;
+
+	cmod->mod = mod;
+	cmod->range = range;
+
+	down_write(&cttype->mod_lock);
+	err = idr_alloc(&cttype->mod_idr, cmod, 0, 0, GFP_KERNEL);
+	if (err >= 0)
+		cttype->count += range_size(cttype, &range);
+	up_write(&cttype->mod_lock);
+
+	if (err < 0) {
+		kfree(cmod);
+		return err;
+	}
+
+	return 0;
+}
+
+struct codetag_type *
+codetag_register_type(const struct codetag_type_desc *desc)
+{
+	struct codetag_type *cttype;
+	int err;
+
+	BUG_ON(desc->tag_size <= 0);
+
+	cttype = kzalloc(sizeof(*cttype), GFP_KERNEL);
+	if (unlikely(!cttype))
+		return ERR_PTR(-ENOMEM);
+
+	cttype->desc = *desc;
+	idr_init(&cttype->mod_idr);
+	init_rwsem(&cttype->mod_lock);
+
+	err = codetag_module_init(cttype, NULL);
+	if (unlikely(err)) {
+		kfree(cttype);
+		return ERR_PTR(err);
+	}
+
+	mutex_lock(&codetag_lock);
+	list_add_tail(&cttype->link, &codetag_types);
+	mutex_unlock(&codetag_lock);
+
+	return cttype;
+}
-- 
2.42.0.758.gaed0368e0e-goog


