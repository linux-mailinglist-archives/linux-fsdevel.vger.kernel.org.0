Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6851D15CB5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 20:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgBMTsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 14:48:16 -0500
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:3236 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgBMTsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:48:16 -0500
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2020 14:48:14 EST
X-EEMSG-check-017: 77682231|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,437,1574121600"; 
   d="scan'208";a="77682231"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Feb 2020 19:41:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581622862; x=1613158862;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4sLC3taziqq+PTb7ehQVhicAG403X4m64MTt2WJhuSg=;
  b=iLbBY/2fKvOcmY0+dBeI0GsA3iqtED+sOgFwq1btELuwL2ywKv0B9O9u
   OkqhCV0xOSE84mGHcN3Iv5v+3fGrdhALkumXACafpgxTjEw23NaDjmcOR
   L3cb1CyGgRRrwJXPPcLUFbPT458f9bktcAydm2EZZHEBUh8A6+pdf20Ty
   0kS8uHH+7XjLydX2QnA7DT0ONlrcZSzbKj4PDUiNJjF7BNmEdsqwbsk8l
   VCe05XVwoqraJu8C6epZJ7/iHO1wiBPibyV2z6x9qtDLrvEnjX7Ohf4H3
   SkOWBJuUp2Agw+6M5SH1lU+lwi268svZaRIrcLDBvOEdKbKaFUg+9saYb
   g==;
X-IronPort-AV: E=Sophos;i="5.70,437,1574121600"; 
   d="scan'208";a="39098365"
IronPort-PHdr: =?us-ascii?q?9a23=3A6xWfLR1ziOCpm0HEsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesULvzxwZ3uMQTl6Ol3ixeRBMOHsq4C1bqd6vq+EUU7or+/81k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba59IRmsrAjctcYajZZ8Jqsw1x?=
 =?us-ascii?q?DEvmZGd+NKyGxnIl6egwzy7dqq8p559CRQtfMh98peXqj/Yq81U79WAik4Pm?=
 =?us-ascii?q?4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WS?=
 =?us-ascii?q?m+76puVRTlhjsLOyI//WrKhMNwlqZbqw+/qRJ5zYDffYWZOONwc67ZeN8XQ3?=
 =?us-ascii?q?dKUMRMWCxbGo6yb5UBAfcPM+hbqIfyqFQAoACiCQSvHu7j1iVFimPq0aA8zu?=
 =?us-ascii?q?8vERvG3AslH98WrXrUsMv6NL8SUe+ryqnD0CjNb/ZM1jf57IjHbBAgquyLUL?=
 =?us-ascii?q?JrbMXR0lIiFx/Fj1qMqYzlOCmZ1uIWs2eB9eZgWuWvi3A+pgx3vzOhyMAsio?=
 =?us-ascii?q?zTiYIUzFDJ7SZ5z5gvJd2+VkF7ZcSoEJxKtyGVMYZ9X8AsQ3lwtSonxbALto?=
 =?us-ascii?q?S3cSgXxJg92RLSZOKLf5KV7h/lSe2fOy13hGh/d7K6nxuy9E+gxfDiWcSsy1?=
 =?us-ascii?q?ZKqzZFksHLtnAQyxzf8siHReV5/kemwTuPyxrc6vtFIUApjqrXMZ8hwrg+lp?=
 =?us-ascii?q?oUqkTMADP5lF/qjK6Wakok+u+o5/7hYrr6vZ+TK5V4igT/MqQqgsC/AOI4PR?=
 =?us-ascii?q?YSX2WD5Oix27Lu8Vf5TblXlPE6jKbUvI7AKcgGvqK5BhVa0ocn6xaxFTem19?=
 =?us-ascii?q?EYkGEcLF1YYxKKlJTpOlHSL/D4CvezmVKskCxxyPzcMb3hBYvNImDZkLj9Zb?=
 =?us-ascii?q?Z991JcyA0rwNBZ4ZJUCaoMIP30Wk/2u9zYCgE2PxaozObgDdV3zpkeVn6XAq?=
 =?us-ascii?q?+FLKPStkeF6f81LOmKeIAVvzL9JuMq5/7pin85llsdcrez0ZQLb3C4G+xsI1?=
 =?us-ascii?q?+Fbnr0ntcBDWAKsxImTOPwlV2CVSVeZ26oUKIh4jE3EYemDYDERoC3nrONxj?=
 =?us-ascii?q?u0HppTZmpeEFCDDW/od5mYW/cLcC+SPM5hkiYDVbW6So4uyxeutA7ky7Z9Ku?=
 =?us-ascii?q?rU+ysYtY/s1dRv4O3Tjx4y+SZpD8Sey2uNVX17nnsURz8q26ByuU99ykmG0a?=
 =?us-ascii?q?VjnfxYGsJc5+lTXgc5K5Hc1ep6BM72Wg7bedeJUlmmSM28AT4tVtIx38MOY0?=
 =?us-ascii?q?FlFtWmjxDD2TeqArAMm7yFH5w777zT32bvKMZ50HvGyqYhgEc8QsdVNm2pmL?=
 =?us-ascii?q?R/9w7NCI7NiUmZkLyqdasE1i7X6GiD1XaOvF1fUANoVaXFXHYfZlbZrNjg/U?=
 =?us-ascii?q?PNUaOhCak9MgtA1c6DKrJGatjujVpbWffjPMrRbnmvm2e/GxmI3KmAbIn0dG?=
 =?us-ascii?q?UH2iXSFkwEnxoU/XacOgg0Hj2hrH7GDDxyCVLvZFvh8fJgp3O/T080yRyKbk?=
 =?us-ascii?q?J62rqr9R4am+acR+kQ3r0aoichrSt7HFKn09LREdqAqFkpQKIJet454VFaxU?=
 =?us-ascii?q?rHuAFneJ+tNaZvghgZaQskkVnp0kBMFohYkcUs5EgvxQ52JLPQhEhNbBuEzJ?=
 =?us-ascii?q?vwPfvRMWC08xexPf2FkmrC2cqbr/9coM8zrE/u6UTyR0c=3D?=
X-IPAS-Result: =?us-ascii?q?A2D8BgD2pEVe/wHyM5BmHQEBAQkBEQUFAYF7gXgFgRhVI?=
 =?us-ascii?q?BIqjReGXwaCOIhviTSGL4FnCQEBAQEBAQEBARsSCgQBAYRAgnI4EwIQAQEBB?=
 =?us-ascii?q?QEBAQEBBQMBAWyFNwyCOymDMAsBRkiBCYJbDD8BglYlD65uM4NMaQGEToE4B?=
 =?us-ascii?q?oE4h0ZqhA55gQeBETaCKHOEAwFzE4UvBJZhgSqXa4JEgk+EfoIsgxyJMAwch?=
 =?us-ascii?q?QeRVIQ7AS2XKZRQIjeBISsIAhgIIQ+DJxM9GA2BGo0PF4hkhV0jAzACAYxsg?=
 =?us-ascii?q?jIBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 13 Feb 2020 19:41:00 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01DJe4pn093453;
        Thu, 13 Feb 2020 14:40:04 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        viro@zeniv.linux.org.uk, paul@paul-moore.com, dancol@google.com,
        nnk@google.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH] security,anon_inodes,kvm: enable security support for anon inodes
Date:   Thu, 13 Feb 2020 14:41:57 -0500
Message-Id: <20200213194157.5877-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for labeling and controlling access to files attached to anon
inodes. Introduce extended interfaces for creating such files to permit
passing a related file as an input to decide how to label the anon
inode. Define a security hook for initializing the anon inode security
attributes. Security attributes are either inherited from a related file
or determined based on some combination of the creating task and policy
(in the case of SELinux, using type_transition rules).  As an
example user of the inheritance support, convert kvm to use the new
interface for passing the related file so that the anon inode can inherit
the security attributes of /dev/kvm and provide consistent access control
for subsequent ioctl operations.  Other users of anon inodes, including
userfaultfd, will default to the transition-based mechanism instead.

Compared to the series in
https://lore.kernel.org/selinux/20200211225547.235083-1-dancol@google.com/,
this approach differs in that it does not require creation of a separate
anonymous inode for each file (instead storing the per-instance security
information in the file security blob), it applies labeling and control
to all users of anonymous inodes rather than requiring opt-in via a new
flag, it supports labeling based on a related inode if provided,
it relies on type transitions to compute the label of the anon inode
when there is no related inode, and it does not require introducing a new
security class for each user of anonymous inodes.

On the other hand, the approach in this patch does expose the name passed
by the creator of the anon inode to the policy (an indirect mapping could
be provided within SELinux if these names aren't considered to be stable),
requires the definition of type_transition rules to distinguish userfaultfd
inodes from proc inodes based on type since they share the same class,
doesn't support denying the creation of anonymous inodes (making the hook
added by this patch return something other than void is problematic due to
it being called after the file is already allocated and error handling in
the callers can't presently account for this scenario and end up calling
release methods multiple times), and may be more expensive
(security_transition_sid overhead on each anon inode allocation).

We are primarily posting this RFC patch now so that the two different
approaches can be concretely compared.  We anticipate a hybrid of the
two approaches being the likely outcome in the end.  In particular
if support for allocating a separate inode for each of these files
is acceptable, then we would favor storing the security information
in the inode security blob and using it instead of the file security
blob.

This patch only converts kvm to use a related inode (/dev/kvm) for the
creation of anon inodes as an example user. We would look to
incrementally convert other subsystems where applicable. This could
potentially cause policy breakage if policies are written for a subsystem
using the type_transition rules and then the subsystem is later converted
to use a related inode, so some means of compatible evolution would be
required.

There are a number of file permission checks in SELinux that do not
currently use the file_has_perm() helper and therefore do not pick up
the logic for handling these anonymous inodes. These will need to be looked
at further to see whether they are relevant to anonymous inodes and should
be updated with the new logic.

Any hooks that are directly passed a dentry or inode and not a file will
still skip permission checking by virtue of the S_ISPRIVATE() checks in
security/security.c and in security/selinux/hooks.c. At some point they
need to be audited to determine whether they are relevant to anonymous
inodes.

This change may create compatibility issues since it unconditionally
enables labeling and access control for all anonymous inodes; it is
known to break two selinux-testsuite bpf tests without adjusting its
policy.  It will likely need to be wrapped by a SELinux policy
capability before being merged to prevent breaking existing policies.

An example of a sample program and policy will follow in a follow-up
to this patch to demonstrate the effect on userfaultfd and kvm.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 fs/anon_inodes.c                  | 53 +++++++++++++++++-------
 include/linux/anon_inodes.h       |  7 ++++
 include/linux/lsm_hooks.h         | 11 +++++
 include/linux/security.h          |  8 ++++
 security/security.c               |  7 ++++
 security/selinux/hooks.c          | 69 ++++++++++++++++++++++++++++---
 security/selinux/include/objsec.h |  4 ++
 virt/kvm/kvm_main.c               | 27 +++++++-----
 8 files changed, 155 insertions(+), 31 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 89714308c25b..4579913cb33e 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -21,6 +21,7 @@
 #include <linux/magic.h>
 #include <linux/anon_inodes.h>
 #include <linux/pseudo_fs.h>
+#include <linux/security.h>
 
 #include <linux/uaccess.h>
 
@@ -55,15 +56,25 @@ static struct file_system_type anon_inode_fs_type = {
 	.kill_sb	= kill_anon_super,
 };
 
+struct file *anon_inode_getfile(const char *name,
+				const struct file_operations *fops,
+				void *priv, int flags)
+{
+	return anon_inode_getfile_inherit(name, fops, priv, flags, NULL);
+}
+EXPORT_SYMBOL_GPL(anon_inode_getfile);
+
 /**
- * anon_inode_getfile - creates a new file instance by hooking it up to an
- *                      anonymous inode, and a dentry that describe the "class"
- *                      of the file
+ * anon_inode_getfile_inherit - creates a new file instance by hooking it up to
+ *                              an anonymous inode, and a dentry that describe
+ *                              the "class" of the file
  *
  * @name:    [in]    name of the "class" of the new file
  * @fops:    [in]    file operations for the new file
  * @priv:    [in]    private data for the new file (will be file's private_data)
  * @flags:   [in]    flags
+ * @related: [in optional]    a related file that security attributes will be
+ *                            inherited from.
  *
  * Creates a new file by hooking it on a single inode. This is useful for files
  * that do not need to have a full-fledged inode in order to operate correctly.
@@ -71,9 +82,10 @@ static struct file_system_type anon_inode_fs_type = {
  * hence saving memory and avoiding code duplication for the file/inode/dentry
  * setup.  Returns the newly created file* or an error pointer.
  */
-struct file *anon_inode_getfile(const char *name,
-				const struct file_operations *fops,
-				void *priv, int flags)
+struct file *anon_inode_getfile_inherit(const char *name,
+					const struct file_operations *fops,
+					void *priv, int flags,
+					const struct file *related)
 {
 	struct file *file;
 
@@ -97,6 +109,8 @@ struct file *anon_inode_getfile(const char *name,
 
 	file->private_data = priv;
 
+	security_anon_file_init(file, related, name);
+
 	return file;
 
 err:
@@ -104,17 +118,27 @@ struct file *anon_inode_getfile(const char *name,
 	module_put(fops->owner);
 	return file;
 }
-EXPORT_SYMBOL_GPL(anon_inode_getfile);
+EXPORT_SYMBOL_GPL(anon_inode_getfile_inherit);
+
+int anon_inode_getfd(const char *name,
+		     const struct file_operations *fops, void *priv,
+		     int flags)
+{
+	return anon_inode_getfd_inherit(name, fops, priv, flags, NULL);
+}
+EXPORT_SYMBOL_GPL(anon_inode_getfd);
 
 /**
- * anon_inode_getfd - creates a new file instance by hooking it up to an
- *                    anonymous inode, and a dentry that describe the "class"
- *                    of the file
+ * anon_inode_getfd_inherit - creates and installs a new file instance by
+ *                            hooking it up to an anonymous inode, and a dentry
+ *                            that describe the "class" of the file
  *
  * @name:    [in]    name of the "class" of the new file
  * @fops:    [in]    file operations for the new file
  * @priv:    [in]    private data for the new file (will be file's private_data)
  * @flags:   [in]    flags
+ * @related: [in optional]    a related file that security attributes will be
+ *                            inherited from.
  *
  * Creates a new file by hooking it on a single inode. This is useful for files
  * that do not need to have a full-fledged inode in order to operate correctly.
@@ -122,8 +146,9 @@ EXPORT_SYMBOL_GPL(anon_inode_getfile);
  * hence saving memory and avoiding code duplication for the file/inode/dentry
  * setup.  Returns new descriptor or an error code.
  */
-int anon_inode_getfd(const char *name, const struct file_operations *fops,
-		     void *priv, int flags)
+int anon_inode_getfd_inherit(const char *name,
+			     const struct file_operations *fops, void *priv,
+			     int flags, const struct file *related)
 {
 	int error, fd;
 	struct file *file;
@@ -133,7 +158,7 @@ int anon_inode_getfd(const char *name, const struct file_operations *fops,
 		return error;
 	fd = error;
 
-	file = anon_inode_getfile(name, fops, priv, flags);
+	file = anon_inode_getfile_inherit(name, fops, priv, flags, related);
 	if (IS_ERR(file)) {
 		error = PTR_ERR(file);
 		goto err_put_unused_fd;
@@ -146,7 +171,7 @@ int anon_inode_getfd(const char *name, const struct file_operations *fops,
 	put_unused_fd(fd);
 	return error;
 }
-EXPORT_SYMBOL_GPL(anon_inode_getfd);
+EXPORT_SYMBOL_GPL(anon_inode_getfd_inherit);
 
 static int __init anon_inode_init(void)
 {
diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
index d0d7d96261ad..c385eff5d852 100644
--- a/include/linux/anon_inodes.h
+++ b/include/linux/anon_inodes.h
@@ -14,8 +14,15 @@ struct file_operations;
 struct file *anon_inode_getfile(const char *name,
 				const struct file_operations *fops,
 				void *priv, int flags);
+struct file *anon_inode_getfile_inherit(const char *name,
+					const struct file_operations *fops,
+					void *priv, int flags,
+					const struct file *related);
 int anon_inode_getfd(const char *name, const struct file_operations *fops,
 		     void *priv, int flags);
+int anon_inode_getfd_inherit(const char *name,
+			     const struct file_operations *fops, void *priv,
+			     int flags, const struct file *related);
 
 #endif /* _LINUX_ANON_INODES_H */
 
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 20d8cf194fb7..253ecffeda0b 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1454,6 +1454,14 @@
  *     code execution in kernel space should be permitted.
  *
  *     @what: kernel feature being accessed
+ *
+ * @anon_file_init:
+ *     Initialize the security attributes of a file attached to an anonymous
+ *     inode.
+ *     @file contains the file to initialize
+ *     @related contains a related file that security attributes will be
+ *     inherited from.
+ *     @name contains the name of the "class" of the file
  */
 union security_list_options {
 	int (*binder_set_context_mgr)(struct task_struct *mgr);
@@ -1818,6 +1826,8 @@ union security_list_options {
 	void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
 #endif /* CONFIG_BPF_SYSCALL */
 	int (*locked_down)(enum lockdown_reason what);
+	void (*anon_file_init)(struct file *file, const struct file *related,
+				const char *name);
 #ifdef CONFIG_PERF_EVENTS
 	int (*perf_event_open)(struct perf_event_attr *attr, int type);
 	int (*perf_event_alloc)(struct perf_event *event);
@@ -2068,6 +2078,7 @@ struct security_hook_heads {
 	struct hlist_head bpf_prog_free_security;
 #endif /* CONFIG_BPF_SYSCALL */
 	struct hlist_head locked_down;
+	struct hlist_head anon_file_init;
 #ifdef CONFIG_PERF_EVENTS
 	struct hlist_head perf_event_open;
 	struct hlist_head perf_event_alloc;
diff --git a/include/linux/security.h b/include/linux/security.h
index 64b19f050343..6ecef70566c1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -447,6 +447,8 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+void security_anon_file_init(struct file *file, const struct file *related,
+			const char *name);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1274,6 +1276,12 @@ static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
 }
+static inline void security_anon_file_init(struct file *file,
+					   const struct file *related,
+					   const char *name);
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/security.c b/security/security.c
index 565bc9b67276..ce5d24c6cae8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2437,6 +2437,13 @@ int security_locked_down(enum lockdown_reason what)
 }
 EXPORT_SYMBOL(security_locked_down);
 
+void security_anon_file_init(struct file *file, const struct file *related,
+			const char *name)
+{
+	call_void_hook(anon_file_init, file, related, name);
+}
+EXPORT_SYMBOL(security_anon_file_init);
+
 #ifdef CONFIG_PERF_EVENTS
 int security_perf_event_open(struct perf_event_attr *attr, int type)
 {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 44f6f4e20cba..5193b93fae4f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1725,8 +1725,13 @@ static int file_has_perm(const struct cred *cred,
 
 	/* av is zero if only checking access to the descriptor. */
 	rc = 0;
-	if (av)
-		rc = inode_has_perm(cred, inode, av, &ad);
+	if (av) {
+		if (unlikely(fsec->anon))
+			rc = avc_has_perm(&selinux_state, sid, fsec->isid,
+					  fsec->anon_sclass, av, &ad);
+		else
+			rc = inode_has_perm(cred, inode, av, &ad);
+	}
 
 out:
 	return rc;
@@ -3558,6 +3563,8 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	struct inode_security_struct *isec;
 	struct lsm_ioctlop_audit ioctl;
 	u32 ssid = cred_sid(cred);
+	u32 tsid;
+	u16 tclass;
 	int rc;
 	u8 driver = cmd >> 8;
 	u8 xperm = cmd & 0xff;
@@ -3577,12 +3584,21 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 			goto out;
 	}
 
-	if (unlikely(IS_PRIVATE(inode)))
-		return 0;
+	if (unlikely(fsec->anon)) {
+		tsid = fsec->isid;
+		tclass = fsec->anon_sclass;
+	} else {
+		if (unlikely(IS_PRIVATE(inode)))
+			return 0;
+
+		isec = inode_security(inode);
+
+		tsid = isec->sid;
+		tclass = isec->sclass;
+	}
 
-	isec = inode_security(inode);
 	rc = avc_has_extended_perms(&selinux_state,
-				    ssid, isec->sid, isec->sclass,
+				    ssid, tsid, tclass,
 				    requested, driver, xperm, &ad);
 out:
 	return rc;
@@ -6805,6 +6821,46 @@ static int selinux_lockdown(enum lockdown_reason what)
 				    LOCKDOWN__CONFIDENTIALITY, &ad);
 }
 
+static void selinux_anon_file_init(struct file *file,
+				const struct file *related, const char *name)
+{
+	struct file_security_struct *fsec = selinux_file(file);
+	const struct file_security_struct *pfsec;
+	const struct inode *pinode;
+	const struct inode_security_struct *pisec;
+	u32 sid;
+	struct qstr qname = {{{0}}, name};
+	int error;
+
+	fsec->anon = true;
+
+	if (related) {
+		pfsec = selinux_file(related);
+
+		if (pfsec->anon) {
+			fsec->isid = pfsec->isid;
+			fsec->anon_sclass = pfsec->anon_sclass;
+		} else {
+			pinode = file_inode(related);
+			pisec = selinux_inode(pinode);
+
+			fsec->isid = pisec->sid;
+			fsec->anon_sclass = pisec->sclass;
+		}
+	} else {
+		fsec->isid = SECINITSID_UNLABELED;
+		fsec->anon_sclass = SECCLASS_FILE;
+
+		sid = cred_sid(current_cred());
+
+		error = security_transition_sid(&selinux_state, sid, sid,
+						SECCLASS_FILE, &qname,
+						&fsec->isid);
+		if (error)
+			fsec->isid = SECINITSID_UNLABELED;
+	}
+}
+
 struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct task_security_struct),
 	.lbs_file = sizeof(struct file_security_struct),
@@ -7108,6 +7164,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 #endif
 
 	LSM_HOOK_INIT(locked_down, selinux_lockdown),
+	LSM_HOOK_INIT(anon_file_init, selinux_anon_file_init),
 
 	/*
 	 * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 330b7b6d44e0..8aa620e40a46 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -57,6 +57,10 @@ struct file_security_struct {
 	u32 sid;		/* SID of open file description */
 	u32 fown_sid;		/* SID of file owner (for SIGIO) */
 	u32 isid;		/* SID of inode at the time of file open */
+	bool anon;              /* Is file connected to an anonymous inode */
+	u16 anon_sclass;        /* inode security class if connected
+				 * to an anonymous inode
+				 */
 	u32 pseqno;		/* Policy seqno at the time of file open */
 };
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 67ae2d5c37b2..ad9161de6273 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2756,12 +2756,13 @@ static struct file_operations kvm_vcpu_fops = {
 /*
  * Allocates an inode for the vcpu.
  */
-static int create_vcpu_fd(struct kvm_vcpu *vcpu)
+static int create_vcpu_fd(struct kvm_vcpu *vcpu, const struct file *filp)
 {
 	char name[8 + 1 + ITOA_MAX_LEN + 1];
 
 	snprintf(name, sizeof(name), "kvm-vcpu:%d", vcpu->vcpu_id);
-	return anon_inode_getfd(name, &kvm_vcpu_fops, vcpu, O_RDWR | O_CLOEXEC);
+	return anon_inode_getfd_inherit(name, &kvm_vcpu_fops, vcpu,
+					O_RDWR | O_CLOEXEC, filp);
 }
 
 static void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
@@ -2783,7 +2784,8 @@ static void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 /*
  * Creates some virtual cpus.  Good luck creating more than one.
  */
-static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
+static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id,
+				    const struct file *filp)
 {
 	int r;
 	struct kvm_vcpu *vcpu;
@@ -2838,7 +2840,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 
 	/* Now it's all set up, let userspace reach it */
 	kvm_get_kvm(kvm);
-	r = create_vcpu_fd(vcpu);
+	r = create_vcpu_fd(vcpu, filp);
 	if (r < 0) {
 		kvm_put_kvm_no_destroy(kvm);
 		goto unlock_vcpu_destroy;
@@ -3239,7 +3241,8 @@ void kvm_unregister_device_ops(u32 type)
 }
 
 static int kvm_ioctl_create_device(struct kvm *kvm,
-				   struct kvm_create_device *cd)
+				   struct kvm_create_device *cd,
+				   const struct file *filp)
 {
 	const struct kvm_device_ops *ops = NULL;
 	struct kvm_device *dev;
@@ -3279,7 +3282,8 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
 		ops->init(dev);
 
 	kvm_get_kvm(kvm);
-	ret = anon_inode_getfd(ops->name, &kvm_device_fops, dev, O_RDWR | O_CLOEXEC);
+	ret = anon_inode_getfd_inherit(ops->name, &kvm_device_fops, dev,
+				       O_RDWR | O_CLOEXEC, filp);
 	if (ret < 0) {
 		kvm_put_kvm_no_destroy(kvm);
 		mutex_lock(&kvm->lock);
@@ -3369,7 +3373,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		return -EIO;
 	switch (ioctl) {
 	case KVM_CREATE_VCPU:
-		r = kvm_vm_ioctl_create_vcpu(kvm, arg);
+		r = kvm_vm_ioctl_create_vcpu(kvm, arg, filp);
 		break;
 	case KVM_ENABLE_CAP: {
 		struct kvm_enable_cap cap;
@@ -3526,7 +3530,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		if (copy_from_user(&cd, argp, sizeof(cd)))
 			goto out;
 
-		r = kvm_ioctl_create_device(kvm, &cd);
+		r = kvm_ioctl_create_device(kvm, &cd, filp);
 		if (r)
 			goto out;
 
@@ -3595,7 +3599,7 @@ static struct file_operations kvm_vm_fops = {
 	KVM_COMPAT(kvm_vm_compat_ioctl),
 };
 
-static int kvm_dev_ioctl_create_vm(unsigned long type)
+static int kvm_dev_ioctl_create_vm(unsigned long type, const struct file *filp)
 {
 	int r;
 	struct kvm *kvm;
@@ -3613,7 +3617,8 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
 	if (r < 0)
 		goto put_kvm;
 
-	file = anon_inode_getfile("kvm-vm", &kvm_vm_fops, kvm, O_RDWR);
+	file = anon_inode_getfile_inherit("kvm-vm", &kvm_vm_fops, kvm, O_RDWR,
+					  filp);
 	if (IS_ERR(file)) {
 		put_unused_fd(r);
 		r = PTR_ERR(file);
@@ -3653,7 +3658,7 @@ static long kvm_dev_ioctl(struct file *filp,
 		r = KVM_API_VERSION;
 		break;
 	case KVM_CREATE_VM:
-		r = kvm_dev_ioctl_create_vm(arg);
+		r = kvm_dev_ioctl_create_vm(arg, filp);
 		break;
 	case KVM_CHECK_EXTENSION:
 		r = kvm_vm_ioctl_check_extension_generic(NULL, arg);
-- 
2.24.1

