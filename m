Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E789427B2C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Oct 2021 17:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbhJIPPQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Oct 2021 11:15:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234306AbhJIPPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Oct 2021 11:15:13 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 199DQEKx011241;
        Sat, 9 Oct 2021 11:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=swJVj2WWl784zHZV0l1r6wanUtsilL+alia95N0bpAg=;
 b=ep/Rgm7onmvgIBeB0TjEVA8kkdNxaDanLFRGD51IJEo2lFUAcs3HMzUahIU0Q0PqbTHi
 tYo+6x1ysRL3/md6DD2F5lNrC+aKNYSK/hK2IOmla47ucu+POKdLEn2XKZnqEEMxH7vX
 Ip1aDkJrSaIaWW83MucFCFS+I+ilhkN0CyBAXfnBB9mGrh4E1OwjKl5romq5nLlzQTmp
 1D67Augn045a7mRdNtBxzWa2/SF9JsDm/tt5DORIZbJuMcgB7kJ/cLxpoHfhdUUMH2Ce
 TEGnVpKzE8Y+MXpSYZkjb4Sy4fuXlUXZnW/ldCy3YBdarCYFRxmdeM4ZAN4h/P/gT9Y5 Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bkavgj15f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 11:13:00 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 199FCDc6024360;
        Sat, 9 Oct 2021 11:13:00 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bkavgj156-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 11:13:00 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 199FCALI016074;
        Sat, 9 Oct 2021 15:12:58 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3bk2q8sydg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 15:12:58 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 199F7QqP49152360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 9 Oct 2021 15:07:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70F5942045;
        Sat,  9 Oct 2021 15:12:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39A2742041;
        Sat,  9 Oct 2021 15:12:50 +0000 (GMT)
Received: from pratiks-thinkpad.ibm.com (unknown [9.43.17.147])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  9 Oct 2021 15:12:49 +0000 (GMT)
From:   "Pratik R. Sampat" <psampat@linux.ibm.com>
To:     bristot@redhat.com, christian@brauner.io, ebiederm@xmission.com,
        lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, containers@lists.linux.dev,
        containers@lists.linux-foundation.org, psampat@linux.ibm.com,
        pratik.r.sampat@gmail.com
Subject: [RFC 1/5] ns: Introduce CPU Namespace
Date:   Sat,  9 Oct 2021 20:42:39 +0530
Message-Id: <20211009151243.8825-2-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211009151243.8825-1-psampat@linux.ibm.com>
References: <20211009151243.8825-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GHkNQzO3OEYSLtB6jpVTiC3h7uPSGLg-
X-Proofpoint-GUID: N1wiAv9XaEkU0nGYmVsHb9srrj6Rjpm0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-09_04,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110090109
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CPU namespace isolates CPU topology information

The CPU namespace isolates CPU information by virtualizing CPU IDs as
viewed by linux and maintaining a virtual map for each task.
The commit also adds functionality of plugging this interface into the
control and display interface via the sched_set/getaffinity syscalls.
These syscalls translate the namespace map and vice-versa to determine
the CPUset for the task to operate on.

As all the clone flags have been exhausted, therefore following suit
with the time namespace, the flag for a new CPU namespace similarly
now continues with the pattern of intersecting with CSIGNAL.
This means that this namespace can be triggered by only unshare()
and clone3() syscalls.

Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
---
 fs/proc/namespaces.c           |   4 +
 include/linux/cpu_namespace.h  | 159 +++++++++++++++++++++++++++
 include/linux/nsproxy.h        |   2 +
 include/linux/proc_ns.h        |   2 +
 include/linux/user_namespace.h |   1 +
 include/uapi/linux/sched.h     |   1 +
 init/Kconfig                   |   8 ++
 kernel/Makefile                |   1 +
 kernel/cpu_namespace.c         | 192 +++++++++++++++++++++++++++++++++
 kernel/fork.c                  |   2 +-
 kernel/nsproxy.c               |  30 +++++-
 kernel/sched/core.c            |  16 ++-
 kernel/ucount.c                |   1 +
 13 files changed, 414 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/cpu_namespace.h
 create mode 100644 kernel/cpu_namespace.c

diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 8e159fc78c0a..d65170a8a648 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -9,6 +9,7 @@
 #include <linux/ipc_namespace.h>
 #include <linux/pid_namespace.h>
 #include <linux/user_namespace.h>
+#include <linux/cpu_namespace.h>
 #include "internal.h"
 
 
@@ -37,6 +38,9 @@ static const struct proc_ns_operations *ns_entries[] = {
 	&timens_operations,
 	&timens_for_children_operations,
 #endif
+#ifdef CONFIG_CPU_NS
+	&cpuns_operations,
+#endif
 };
 
 static const char *proc_ns_get_link(struct dentry *dentry,
diff --git a/include/linux/cpu_namespace.h b/include/linux/cpu_namespace.h
new file mode 100644
index 000000000000..edad05919db7
--- /dev/null
+++ b/include/linux/cpu_namespace.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_CPU_NS_H
+#define _LINUX_CPU_NS_H
+
+#include <linux/sched.h>
+#include <linux/bug.h>
+#include <linux/nsproxy.h>
+#include <linux/ns_common.h>
+
+/*
+ * Virtual CPUs  => View of the CPUs in the CPU NS context
+ * Physical CPUs => CPU as viewed by host, also known as logical CPUs
+ */
+struct cpu_namespace {
+	/* Virtual map of cpus in the cpuset */
+	cpumask_t v_cpuset_cpus;
+	/* map for CPU translation -- Physical --> Virtual */
+	int p_v_trans_map[NR_CPUS];
+	/* map for CPU translation -- Virtual --> Physical */
+	int v_p_trans_map[NR_CPUS];
+	struct cpu_namespace *parent;
+	struct ucounts *ucounts;
+	struct user_namespace *user_ns;
+	struct ns_common ns;
+} __randomize_layout;
+
+extern struct cpu_namespace init_cpu_ns;
+
+#ifdef CONFIG_CPU_NS
+
+static inline struct cpu_namespace *get_cpu_ns(struct cpu_namespace *ns)
+{
+	if (ns != &init_cpu_ns)
+		refcount_inc(&ns->ns.count);
+	return ns;
+}
+
+/*
+ * Get the virtual CPU for the requested physical CPU in the ns context
+ */
+static inline int get_vcpu_cpuns(struct cpu_namespace *c, int pcpu)
+{
+	if (pcpu >= num_possible_cpus())
+		return -1;
+
+	return c->p_v_trans_map[pcpu];
+}
+
+/*
+ * Get the physical CPU for requested virtual CPU in the ns context
+ */
+static inline int get_pcpu_cpuns(struct cpu_namespace *c, int vcpu)
+{
+	if (vcpu >= num_possible_cpus())
+		return -1;
+
+	return c->v_p_trans_map[vcpu];
+}
+
+/*
+ * Given the physical CPU map get the virtual CPUs corresponding to that ns
+ */
+static inline cpumask_t get_vcpus_cpuns(struct cpu_namespace *c,
+					const cpumask_var_t mask)
+{
+	int cpu;
+	cpumask_t temp;
+
+	cpumask_clear(&temp);
+
+	for_each_cpu(cpu, mask)
+		cpumask_set_cpu(get_vcpu_cpuns(c, cpu), &temp);
+
+	return temp;
+}
+
+/*
+ * Given a virtual CPU map get the physical CPUs corresponding to that ns
+ */
+static inline cpumask_t get_pcpus_cpuns(struct cpu_namespace *c,
+					const cpumask_var_t mask)
+{
+	int cpu;
+	cpumask_t temp;
+
+	cpumask_clear(&temp);
+
+	for_each_cpu(cpu, mask)
+		cpumask_set_cpu(get_pcpu_cpuns(c, cpu), &temp);
+
+	return temp;
+}
+
+extern struct cpu_namespace *copy_cpu_ns(unsigned long flags,
+	struct user_namespace *user_ns, struct cpu_namespace *ns);
+extern void put_cpu_ns(struct cpu_namespace *ns);
+
+#else /* !CONFIG_CPU_NS */
+#include <linux/err.h>
+
+static inline struct cpu_namespace *get_cpu_ns(struct cpu_namespace *ns)
+{
+	return ns;
+}
+
+static inline struct cpu_namespace *copy_cpu_ns(unsigned long flags,
+	struct user_namespace *user_ns, struct cpu_namespace *ns)
+{
+	if (flags & CLONE_NEWCPU)
+		return ERR_PTR(-EINVAL);
+	return ns;
+}
+
+static inline void put_cpu_ns(struct cpu_namespace *ns)
+{
+}
+
+static inline int get_vcpu_cpuns(struct cpu_namespace *c, int pcpu)
+{
+	return pcpu;
+}
+
+static inline int get_pcpu_cpuns(struct cpu_namespace *c, int vcpu)
+{
+	return vcpu;
+}
+
+static inline cpumask_t get_vcpus_cpuns(struct cpu_namespace *c,
+					const cpumask_var_t mask)
+{
+	cpumask_t temp;
+	int cpu;
+
+	cpumask_clear(&temp);
+
+	for_each_cpu(cpu, mask)
+		cpumask_set_cpu(get_vcpu_cpuns(c, cpu), &temp);
+
+	return temp;
+}
+
+static inline cpumask_t get_pcpus_cpuns(struct cpu_namespace *c,
+					const cpumask_var_t mask)
+{
+	cpumask_t temp;
+	int cpu;
+
+	cpumask_clear(&temp);
+
+	for_each_cpu(cpu, mask)
+		cpumask_set_cpu(get_pcpu_cpuns(c, cpu), &temp);
+
+	return temp;
+}
+
+#endif /* CONFIG_CPU_NS */
+
+#endif /* _LINUX_CPU_NS_H */
diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index cdb171efc7cb..40e0357fe0bb 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -10,6 +10,7 @@ struct uts_namespace;
 struct ipc_namespace;
 struct pid_namespace;
 struct cgroup_namespace;
+struct cpu_namespace;
 struct fs_struct;
 
 /*
@@ -38,6 +39,7 @@ struct nsproxy {
 	struct time_namespace *time_ns;
 	struct time_namespace *time_ns_for_children;
 	struct cgroup_namespace *cgroup_ns;
+	struct cpu_namespace *cpu_ns;
 };
 extern struct nsproxy init_nsproxy;
 
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 75807ecef880..dd1db6782336 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -34,6 +34,7 @@ extern const struct proc_ns_operations mntns_operations;
 extern const struct proc_ns_operations cgroupns_operations;
 extern const struct proc_ns_operations timens_operations;
 extern const struct proc_ns_operations timens_for_children_operations;
+extern const struct proc_ns_operations cpuns_operations;
 
 /*
  * We always define these enumerators
@@ -46,6 +47,7 @@ enum {
 	PROC_PID_INIT_INO	= 0xEFFFFFFCU,
 	PROC_CGROUP_INIT_INO	= 0xEFFFFFFBU,
 	PROC_TIME_INIT_INO	= 0xEFFFFFFAU,
+	PROC_CPU_INIT_INO	= 0xEFFFFFFU,
 };
 
 #ifdef CONFIG_PROC_FS
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index eb70cabe6e7f..9f0b121f97ac 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -46,6 +46,7 @@ enum ucount_type {
 	UCOUNT_MNT_NAMESPACES,
 	UCOUNT_CGROUP_NAMESPACES,
 	UCOUNT_TIME_NAMESPACES,
+	UCOUNT_CPU_NAMESPACES,
 #ifdef CONFIG_INOTIFY_USER
 	UCOUNT_INOTIFY_INSTANCES,
 	UCOUNT_INOTIFY_WATCHES,
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..f8bb6de68874 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -41,6 +41,7 @@
  * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
  * syscalls only:
  */
+#define CLONE_NEWCPU	0x00000040	/* New cpu namespace */
 #define CLONE_NEWTIME	0x00000080	/* New time namespace */
 
 #ifndef __ASSEMBLY__
diff --git a/init/Kconfig b/init/Kconfig
index 55f9f7738ebb..c3e3abd35bb4 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1214,6 +1214,14 @@ config NET_NS
 	  Allow user space to create what appear to be multiple instances
 	  of the network stack.
 
+config CPU_NS
+	bool "CPU Namespaces"
+	default y
+	help
+	  Support CPU namespaces. This allows having a context-aware
+	  scrambled view of the CPU topology coherent to limits set
+	  in system control mechanism.
+
 endif # NAMESPACES
 
 config CHECKPOINT_RESTORE
diff --git a/kernel/Makefile b/kernel/Makefile
index 4df609be42d0..5a37e3e56f8f 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_CGROUPS) += cgroup/
 obj-$(CONFIG_UTS_NS) += utsname.o
 obj-$(CONFIG_USER_NS) += user_namespace.o
 obj-$(CONFIG_PID_NS) += pid_namespace.o
+obj-$(CONFIG_CPU_NS) += cpu_namespace.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKHEADERS) += kheaders.o
 obj-$(CONFIG_SMP) += stop_machine.o
diff --git a/kernel/cpu_namespace.c b/kernel/cpu_namespace.c
new file mode 100644
index 000000000000..6c700522352a
--- /dev/null
+++ b/kernel/cpu_namespace.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CPU namespaces
+ * <TODO More description>
+ *
+ * Author: Pratik Rajesh Sampat <psampat@linux.ibm.com>
+ */
+
+#include <linux/cpu_namespace.h>
+#include <linux/syscalls.h>
+#include <linux/proc_ns.h>
+#include <linux/export.h>
+#include <linux/acct.h>
+#include <linux/err.h>
+#include <linux/random.h>
+
+static void dec_cpu_namespaces(struct ucounts *ucounts)
+{
+	dec_ucount(ucounts, UCOUNT_CPU_NAMESPACES);
+}
+
+static void destroy_cpu_namespace(struct cpu_namespace *ns)
+{
+	ns_free_inum(&ns->ns);
+
+	dec_cpu_namespaces(ns->ucounts);
+	put_user_ns(ns->user_ns);
+}
+
+static struct ucounts *inc_cpu_namespaces(struct user_namespace *ns)
+{
+	return inc_ucount(ns, current_euid(), UCOUNT_CPU_NAMESPACES);
+}
+
+static struct cpu_namespace *create_cpu_namespace(struct user_namespace *user_ns,
+	struct cpu_namespace *parent_cpu_ns)
+{
+	struct cpu_namespace *ns;
+	struct ucounts *ucounts;
+	int err, i, cpu;
+	cpumask_t temp;
+
+	err = -EINVAL;
+	if (!in_userns(parent_cpu_ns->user_ns, user_ns))
+		goto out;
+
+	ucounts = inc_cpu_namespaces(user_ns);
+	if (!ucounts)
+		goto out;
+
+	err = -ENOMEM;
+	ns = kmalloc(sizeof(*ns), GFP_KERNEL);
+	if (ns == NULL)
+		goto out_dec;
+
+	err = ns_alloc_inum(&ns->ns);
+	if (err)
+		goto out_free_ns;
+	ns->ns.ops = &cpuns_operations;
+
+	refcount_set(&ns->ns.count, 1);
+	ns->parent = get_cpu_ns(parent_cpu_ns);
+	ns->user_ns = get_user_ns(user_ns);
+
+	for_each_present_cpu(cpu) {
+		ns->p_v_trans_map[cpu] = ns->parent->p_v_trans_map[cpu];
+		ns->v_p_trans_map[cpu] = ns->parent->v_p_trans_map[cpu];
+	}
+	cpumask_clear(&temp);
+	cpumask_clear(&ns->v_cpuset_cpus);
+
+	for_each_cpu(i, &parent_cpu_ns->v_cpuset_cpus) {
+		int parent_pcpu = get_pcpu_cpuns(parent_cpu_ns, i);
+
+		cpumask_set_cpu(get_vcpu_cpuns(ns, parent_pcpu),
+				&ns->v_cpuset_cpus);
+	}
+	for_each_cpu(i, &ns->v_cpuset_cpus)
+		cpumask_set_cpu(get_pcpu_cpuns(ns, i), &temp);
+
+	set_cpus_allowed_ptr(current, &temp);
+
+	return ns;
+
+out_free_ns:
+	kfree(ns);
+out_dec:
+	dec_cpu_namespaces(ucounts);
+out:
+	return ERR_PTR(err);
+}
+
+struct cpu_namespace *copy_cpu_ns(unsigned long flags,
+	struct user_namespace *user_ns, struct cpu_namespace *old_ns)
+{
+	if (!(flags & CLONE_NEWCPU))
+		return get_cpu_ns(old_ns);
+	return create_cpu_namespace(user_ns, old_ns);
+}
+
+void put_cpu_ns(struct cpu_namespace *ns)
+{
+	struct cpu_namespace *parent;
+
+	while (ns != &init_cpu_ns) {
+		parent = ns->parent;
+		if (!refcount_dec_and_test(&ns->ns.count))
+			break;
+		destroy_cpu_namespace(ns);
+		ns = parent;
+	}
+}
+EXPORT_SYMBOL_GPL(put_cpu_ns);
+
+static inline struct cpu_namespace *to_cpu_ns(struct ns_common *ns)
+{
+	return container_of(ns, struct cpu_namespace, ns);
+}
+
+static struct ns_common *cpuns_get(struct task_struct *task)
+{
+	struct cpu_namespace *ns = NULL;
+	struct nsproxy *nsproxy;
+
+	task_lock(task);
+	nsproxy = task->nsproxy;
+	if (nsproxy) {
+		ns = nsproxy->cpu_ns;
+		get_cpu_ns(ns);
+	}
+	task_unlock(task);
+
+	return ns ? &ns->ns : NULL;
+}
+
+static void cpuns_put(struct ns_common *ns)
+{
+	put_cpu_ns(to_cpu_ns(ns));
+}
+
+static int cpuns_install(struct nsset *nsset, struct ns_common *new)
+{
+	struct nsproxy *nsproxy = nsset->nsproxy;
+	struct cpu_namespace *ns = to_cpu_ns(new);
+
+	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
+	    !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
+	get_cpu_ns(ns);
+	put_cpu_ns(nsproxy->cpu_ns);
+	nsproxy->cpu_ns = ns;
+	return 0;
+}
+
+static struct user_namespace *cpuns_owner(struct ns_common *ns)
+{
+	return to_cpu_ns(ns)->user_ns;
+}
+
+const struct proc_ns_operations cpuns_operations = {
+	.name		= "cpu",
+	.type		= CLONE_NEWCPU,
+	.get		= cpuns_get,
+	.put		= cpuns_put,
+	.install	= cpuns_install,
+	.owner		= cpuns_owner,
+};
+
+struct cpu_namespace init_cpu_ns = {
+	.ns.count	= REFCOUNT_INIT(2),
+	.user_ns	= &init_user_ns,
+	.ns.inum	= PROC_CPU_INIT_INO,
+	.ns.ops		= &cpuns_operations,
+};
+EXPORT_SYMBOL(init_cpu_ns);
+
+static __init int cpu_namespaces_init(void)
+{
+	int cpu;
+
+	cpumask_copy(&init_cpu_ns.v_cpuset_cpus, cpu_possible_mask);
+
+	/* Identity mapping for the cpu_namespace init */
+	for_each_present_cpu(cpu) {
+		init_cpu_ns.p_v_trans_map[cpu] = cpu;
+		init_cpu_ns.v_p_trans_map[cpu] = cpu;
+	}
+
+	return 0;
+}
+device_initcall(cpu_namespaces_init);
diff --git a/kernel/fork.c b/kernel/fork.c
index bc94b2cc5995..fac3317b1f57 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2877,7 +2877,7 @@ static int check_unshare_flags(unsigned long unshare_flags)
 				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|
 				CLONE_NEWUTS|CLONE_NEWIPC|CLONE_NEWNET|
 				CLONE_NEWUSER|CLONE_NEWPID|CLONE_NEWCGROUP|
-				CLONE_NEWTIME))
+				CLONE_NEWTIME|CLONE_NEWCPU))
 		return -EINVAL;
 	/*
 	 * Not implemented, but pretend it works if there is nothing
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index abc01fcad8c7..dab0f9799ce7 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -19,6 +19,7 @@
 #include <net/net_namespace.h>
 #include <linux/ipc_namespace.h>
 #include <linux/time_namespace.h>
+#include <linux/cpu_namespace.h>
 #include <linux/fs_struct.h>
 #include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
@@ -47,6 +48,9 @@ struct nsproxy init_nsproxy = {
 	.time_ns		= &init_time_ns,
 	.time_ns_for_children	= &init_time_ns,
 #endif
+#ifdef CONFIG_CPU_NS
+	.cpu_ns			= &init_cpu_ns,
+#endif
 };
 
 static inline struct nsproxy *create_nsproxy(void)
@@ -121,8 +125,17 @@ static struct nsproxy *create_new_namespaces(unsigned long flags,
 	}
 	new_nsp->time_ns = get_time_ns(tsk->nsproxy->time_ns);
 
+	new_nsp->cpu_ns = copy_cpu_ns(flags, user_ns, tsk->nsproxy->cpu_ns);
+	if (IS_ERR(new_nsp->cpu_ns)) {
+		err = PTR_ERR(new_nsp->cpu_ns);
+		goto out_cpu;
+	}
+
 	return new_nsp;
 
+out_cpu:
+	if (new_nsp->cpu_ns)
+		put_cpu_ns(new_nsp->cpu_ns);
 out_time:
 	put_net(new_nsp->net_ns);
 out_net:
@@ -156,7 +169,8 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 
 	if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
 			      CLONE_NEWPID | CLONE_NEWNET |
-			      CLONE_NEWCGROUP | CLONE_NEWTIME)))) {
+			      CLONE_NEWCGROUP | CLONE_NEWTIME |
+			      CLONE_NEWCPU)))) {
 		if (likely(old_ns->time_ns_for_children == old_ns->time_ns)) {
 			get_nsproxy(old_ns);
 			return 0;
@@ -216,7 +230,7 @@ int unshare_nsproxy_namespaces(unsigned long unshare_flags,
 
 	if (!(unshare_flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
 			       CLONE_NEWNET | CLONE_NEWPID | CLONE_NEWCGROUP |
-			       CLONE_NEWTIME)))
+			       CLONE_NEWTIME | CLONE_NEWCPU)))
 		return 0;
 
 	user_ns = new_cred ? new_cred->user_ns : current_user_ns();
@@ -289,6 +303,10 @@ static int check_setns_flags(unsigned long flags)
 	if (flags & CLONE_NEWTIME)
 		return -EINVAL;
 #endif
+#ifndef CONFIG_CPU_NS
+	if (flags & CLONE_NEWCPU)
+		return -EINVAL;
+#endif
 
 	return 0;
 }
@@ -471,6 +489,14 @@ static int validate_nsset(struct nsset *nsset, struct pid *pid)
 	}
 #endif
 
+#ifdef CONFIG_CPU_NS
+	if (flags & CLONE_NEWCPU) {
+		ret = validate_ns(nsset, &nsp->cpu_ns->ns);
+		if (ret)
+			goto out;
+	}
+#endif
+
 out:
 	if (pid_ns)
 		put_pid_ns(pid_ns);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d9ff40f4661..0413175e6d73 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -27,6 +27,8 @@
 #include "pelt.h"
 #include "smp.h"
 
+#include <linux/cpu_namespace.h>
+
 /*
  * Export tracepoints that act as a bare tracehook (ie: have no trace event
  * associated with them) to allow external modules to probe them.
@@ -7559,6 +7561,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 {
 	cpumask_var_t cpus_allowed, new_mask;
 	struct task_struct *p;
+	cpumask_t temp;
 	int retval;
 
 	rcu_read_lock();
@@ -7601,7 +7604,8 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 
 
 	cpuset_cpus_allowed(p, cpus_allowed);
-	cpumask_and(new_mask, in_mask, cpus_allowed);
+	temp = get_pcpus_cpuns(current->nsproxy->cpu_ns, in_mask);
+	cpumask_and(new_mask, &temp, cpus_allowed);
 
 	/*
 	 * Since bandwidth control happens on root_domain basis,
@@ -7682,8 +7686,9 @@ SYSCALL_DEFINE3(sched_setaffinity, pid_t, pid, unsigned int, len,
 long sched_getaffinity(pid_t pid, struct cpumask *mask)
 {
 	struct task_struct *p;
+	cpumask_var_t temp;
 	unsigned long flags;
-	int retval;
+	int retval, cpu;
 
 	rcu_read_lock();
 
@@ -7698,6 +7703,13 @@ long sched_getaffinity(pid_t pid, struct cpumask *mask)
 
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
 	cpumask_and(mask, &p->cpus_mask, cpu_active_mask);
+	cpumask_clear(temp);
+	for_each_cpu(cpu, mask) {
+		cpumask_set_cpu(get_vcpu_cpuns(current->nsproxy->cpu_ns, cpu),
+				temp);
+	}
+
+	cpumask_copy(mask, temp);
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 
 out_unlock:
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 87799e2379bd..3adb168b4a2b 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -76,6 +76,7 @@ static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_mnt_namespaces"),
 	UCOUNT_ENTRY("max_cgroup_namespaces"),
 	UCOUNT_ENTRY("max_time_namespaces"),
+	UCOUNT_ENTRY("max_cpu_namespaces"),
 #ifdef CONFIG_INOTIFY_USER
 	UCOUNT_ENTRY("max_inotify_instances"),
 	UCOUNT_ENTRY("max_inotify_watches"),
-- 
2.31.1

