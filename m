Return-Path: <linux-fsdevel+bounces-7309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091A8823853
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B32F1C2448D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D2A1F927;
	Wed,  3 Jan 2024 22:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAMqZIfI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62111F60B;
	Wed,  3 Jan 2024 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1d480c6342dso44451775ad.2;
        Wed, 03 Jan 2024 14:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704321751; x=1704926551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5MKWIUvYvBzFl4/zY3kO9lIA0w6d0GnkdKyiozKias=;
        b=mAMqZIfI2kRMSMKRbZnGeQ65sS0vFdaVoV2BW3GcL0iywpOcDrTUKRN08nbRmnUjBu
         nJ9X9RcnNsYZtr9r+rzjYIOXjwy+HB0OD4wG065NGunklH9111IKi09OH3QZ6GVb9CpK
         xo06x/9SJx55oT7nPpJDHIL56vv66TqLGeeOO99t20u6LHJlkkGvyArXyDqwefA/wIw0
         98N28AH+Ot8scrtrd0aJUOz5pg/QWdqpXx78cYUbRaD6DbgQBsa+J9qY5+mGUCtyUp4P
         bAzfN1e2NYvIpnPWMNH+QB69C1L08eO52GG6pM66UbyjZJyM/ajUn5VZuWi0n7Z68KBO
         1zIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704321751; x=1704926551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5MKWIUvYvBzFl4/zY3kO9lIA0w6d0GnkdKyiozKias=;
        b=i3P3WV8BRssr2RiY+phVnAho7PZyYB5ZlcK1P09Xv2xJ22Vle232tdEivwHY/s/One
         eu3fRH7XNP2MrcxKMESwIL+cj42dwt92pAxNxLuXBQlLv496D62SckujHTNNqRYpUudg
         7Xwqwozv8/BM1apLCX/V5GKTmkegUtrOFESYgN+deQ/lSWs1kOGO5pz5WCwGCYhjjqBn
         7qhINAWGN6EI8rGyQc6eCAuUJN0fXnu6Jn7KCRDbSutOg05lAykXp7Kd2VgFbuD7VpXT
         WLYiGeI24bSLFTndAqr7C/K5a/Ab8xFvr38UfVLna0/ZGBRai+k1efW2nT7F0akuHnA+
         24Rg==
X-Gm-Message-State: AOJu0YzfmXIg5rK5WQprQWFdtuEAjX8Hj3u/aVcOH45Jley+hJCb0Yyt
	g2RWL9xCqfiZ8vY6X+x/q90pHS5TMzCseaQ=
X-Google-Smtp-Source: AGHT+IETjmZI/H5jzuTEDLcLeTtQG732PMB/ir8hLWjOSjN9vjly0mA8Vcj8KqCQX+cOsD5NH6lN8g==
X-Received: by 2002:a17:902:e5d2:b0:1d4:d5bb:5d7c with SMTP id u18-20020a170902e5d200b001d4d5bb5d7cmr1022739plf.110.1704321750996;
        Wed, 03 Jan 2024 14:42:30 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902fe0100b001d36df58ba2sm24269426plj.308.2024.01.03.14.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 14:42:30 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	mhocko@kernel.org,
	tj@kernel.org,
	ying.huang@intel.com,
	gregory.price@memverge.com,
	corbet@lwn.net,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	honggyu.kim@sk.com,
	vtavarespetr@micron.com,
	peterz@infradead.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com
Subject: [PATCH v6 01/12] mm/mempolicy: implement the sysfs-based weighted_interleave interface
Date: Wed,  3 Jan 2024 17:41:58 -0500
Message-Id: <20240103224209.2541-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240103224209.2541-1-gregory.price@memverge.com>
References: <20240103224209.2541-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rakie Kim <rakie.kim@sk.com>

This patch provides a way to set interleave weight information under
sysfs at /sys/kernel/mm/mempolicy/weighted_interleave/nodeN

The sysfs structure is designed as follows.

  $ tree /sys/kernel/mm/mempolicy/
  /sys/kernel/mm/mempolicy/ [1]
  └── weighted_interleave [2]
      ├── node0 [3]
      └── node1

Each file above can be explained as follows.

[1] mm/mempolicy: configuration interface for mempolicy subsystem

[2] weighted_interleave/: config interface for weighted interleave policy

[3] weighted_interleave/nodeN: weight for nodeN

Internally, there is a secondary table `default_iw_table`, which holds
kernel-internal default interleave weights for each possible node.

If the value for a node is set to `0`, the default value will be used.

If sysfs is disabled in the config, interleave weights will default
to use `default_iw_table`.

Suggested-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Co-developed-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
---
 .../ABI/testing/sysfs-kernel-mm-mempolicy     |   4 +
 ...fs-kernel-mm-mempolicy-weighted-interleave |  26 +++
 mm/mempolicy.c                                | 178 ++++++++++++++++++
 3 files changed, 208 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
new file mode 100644
index 000000000000..2dcf24f4384a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
@@ -0,0 +1,4 @@
+What:		/sys/kernel/mm/mempolicy/
+Date:		December 2023
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Interface for Mempolicy
diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
new file mode 100644
index 000000000000..e6a38139bf0f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
@@ -0,0 +1,26 @@
+What:		/sys/kernel/mm/mempolicy/weighted_interleave/
+Date:		December 2023
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Configuration Interface for the Weighted Interleave policy
+
+What:		/sys/kernel/mm/mempolicy/weighted_interleave/nodeN
+Date:		December 2023
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Weight configuration interface for nodeN
+
+		The interleave weight for a memory node (N). These weights are
+		utilized by processes which have set their mempolicy to
+		MPOL_WEIGHTED_INTERLEAVE and have opted into global weights by
+		omitting a task-local weight array.
+
+		These weights only affect new allocations, and changes at runtime
+		will not cause migrations on already allocated pages.
+
+		The minimum weight for a node is always 1.
+
+		Minimum weight: 1
+		Maximum weight: 255
+
+		Writing an empty string or `0` will reset the weight to the
+		system default. The system default may be set by the kernel
+		or drivers at boot or during hotplug events.
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590ee1c89..30da1a1be707 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -131,6 +131,23 @@ static struct mempolicy default_policy = {
 
 static struct mempolicy preferred_node_policy[MAX_NUMNODES];
 
+/*
+ * default_iw_table is the kernel-internal default value interleave
+ * weight table. It is to be set by driver code capable of reading
+ * HMAT/CDAT information, and to provide mempolicy a sane set of
+ * default weight values for WEIGHTED_INTERLEAVE mode.
+ *
+ * By default, prior to HMAT/CDAT information being consumed, the
+ * default weight of all nodes is 1.  The default weight of any
+ * node can only be in the range 1-255. A 0-weight is not allowed.
+ */
+static u8 default_iw_table[MAX_NUMNODES];
+/*
+ * iw_table is the sysfs-set interleave weight table, a value of 0
+ * denotes that the default_iw_table value should be used.
+ */
+static u8 iw_table[MAX_NUMNODES];
+
 /**
  * numa_nearest_node - Find nearest node by state
  * @node: Node id to start the search
@@ -3067,3 +3084,164 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 		p += scnprintf(p, buffer + maxlen - p, ":%*pbl",
 			       nodemask_pr_args(&nodes));
 }
+
+#ifdef CONFIG_SYSFS
+struct iw_node_attr {
+	struct kobj_attribute kobj_attr;
+	int nid;
+};
+
+static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	struct iw_node_attr *node_attr;
+	u8 weight;
+
+	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
+	weight = iw_table[node_attr->nid];
+	if (!weight)
+		weight = default_iw_table[node_attr->nid];
+	return sysfs_emit(buf, "%d\n", weight);
+}
+
+static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct iw_node_attr *node_attr;
+	u8 weight = 0;
+
+	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
+	/* If no input, revert to default weight */
+	if (count == 0 || sysfs_streq(buf, ""))
+		weight = 0;
+	else if (kstrtou8(buf, 0, &weight))
+		return -EINVAL;
+
+	iw_table[node_attr->nid] = weight;
+	return count;
+}
+
+static struct iw_node_attr *node_attrs[MAX_NUMNODES];
+
+static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
+				  struct kobject *parent)
+{
+	if (!node_attr)
+		return;
+	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
+	kfree(node_attr->kobj_attr.attr.name);
+	kfree(node_attr);
+}
+
+static void sysfs_mempolicy_release(struct kobject *mempolicy_kobj)
+{
+	int i;
+
+	for (i = 0; i < MAX_NUMNODES; i++)
+		sysfs_wi_node_release(node_attrs[i], mempolicy_kobj);
+	kobject_put(mempolicy_kobj);
+}
+
+static const struct kobj_type mempolicy_ktype = {
+	.sysfs_ops = &kobj_sysfs_ops,
+	.release = sysfs_mempolicy_release,
+};
+
+static int add_weight_node(int nid, struct kobject *wi_kobj)
+{
+	struct iw_node_attr *node_attr;
+	char *name;
+
+	node_attr = kzalloc(sizeof(*node_attr), GFP_KERNEL);
+	if (!node_attr)
+		return -ENOMEM;
+
+	name = kasprintf(GFP_KERNEL, "node%d", nid);
+	if (!name) {
+		kfree(node_attr);
+		return -ENOMEM;
+	}
+
+	sysfs_attr_init(&node_attr->kobj_attr.attr);
+	node_attr->kobj_attr.attr.name = name;
+	node_attr->kobj_attr.attr.mode = 0644;
+	node_attr->kobj_attr.show = node_show;
+	node_attr->kobj_attr.store = node_store;
+	node_attr->nid = nid;
+
+	if (sysfs_create_file(wi_kobj, &node_attr->kobj_attr.attr)) {
+		kfree(node_attr->kobj_attr.attr.name);
+		kfree(node_attr);
+		pr_err("failed to add attribute to weighted_interleave\n");
+		return -ENOMEM;
+	}
+
+	node_attrs[nid] = node_attr;
+	return 0;
+}
+
+static int add_weighted_interleave_group(struct kobject *root_kobj)
+{
+	struct kobject *wi_kobj;
+	int nid, err;
+
+	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
+	if (!wi_kobj)
+		return -ENOMEM;
+
+	err = kobject_init_and_add(wi_kobj, &mempolicy_ktype, root_kobj,
+				   "weighted_interleave");
+	if (err) {
+		kfree(wi_kobj);
+		return err;
+	}
+
+	memset(node_attrs, 0, sizeof(node_attrs));
+	for_each_node_state(nid, N_POSSIBLE) {
+		err = add_weight_node(nid, wi_kobj);
+		if (err) {
+			pr_err("failed to add sysfs [node%d]\n", nid);
+			break;
+		}
+	}
+	if (err)
+		kobject_put(wi_kobj);
+	return 0;
+}
+
+static int __init mempolicy_sysfs_init(void)
+{
+	int err;
+	struct kobject *root_kobj;
+
+	memset(&default_iw_table, 1, sizeof(default_iw_table));
+	memset(&iw_table, 0, sizeof(iw_table));
+
+	root_kobj = kobject_create_and_add("mempolicy", mm_kobj);
+	if (!root_kobj) {
+		pr_err("failed to add mempolicy kobject to the system\n");
+		return -ENOMEM;
+	}
+
+	err = add_weighted_interleave_group(root_kobj);
+
+	if (err)
+		kobject_put(root_kobj);
+	return err;
+
+}
+#else
+static int __init mempolicy_sysfs_init(void)
+{
+	/*
+	 * if sysfs is not enabled MPOL_WEIGHTED_INTERLEAVE defaults to
+	 * MPOL_INTERLEAVE behavior, but is still defined separately to
+	 * allow task-local weighted interleave and system-defaults to
+	 * operate as intended.
+	 */
+	memset(&default_iw_table, 1, sizeof(default_iw_table));
+	memset(&iw_table, 0, sizeof(iw_table));
+	return 0;
+}
+#endif /* CONFIG_SYSFS */
+late_initcall(mempolicy_sysfs_init);
-- 
2.39.1


