Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF7911555C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 17:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfLFQb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 11:31:59 -0500
Received: from sandeen.net ([63.231.237.45]:58762 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfLFQb7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:31:59 -0500
Received: from Liberator-6.local (liberator [10.0.0.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 7B95B7BDD;
        Fri,  6 Dec 2019 10:30:08 -0600 (CST)
To:     fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: [PATCH V2] fs_parser: remove fs_parameter_description name field
Autocrypt: addr=sandeen@sandeen.net; prefer-encrypt=mutual; keydata=
 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 pA==
Message-ID: <22be7526-d9da-5309-22a8-3405ed1c0842@sandeen.net>
Date:   Fri, 6 Dec 2019 10:31:57 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There doesn't seem to be a strong reason to have a copy of the
filesystem name string in the fs_parameter_description structure;
it's easy enough to get the name from the fs_type, and using it
instead ensures consistency across messages (for example,
vfs_parse_fs_param() already uses fc->fs_type->name for the error
messages, because it doesn't have the fs_parameter_description).

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Acked-by: David Howells <dhowells@redhat.com>
---

V2: add more recently converted filesystems and fix kernel docs

(This also fixes ffs_fs_fs_parameters which mistakenly named itself
"kAFS" - which shows why redundant copies of information is a bad
plan.)

diff --git a/Documentation/filesystems/mount_api.txt b/Documentation/filesystems/mount_api.txt
index 00ff0cf..7e09dc3 100644
--- a/Documentation/filesystems/mount_api.txt
+++ b/Documentation/filesystems/mount_api.txt
@@ -519,7 +519,6 @@ Parameters are described using structures defined in linux/fs_parser.h.
 There's a core description struct that links everything together:
 
 	struct fs_parameter_description {
-		const char	name[16];
 		const struct fs_parameter_spec *specs;
 		const struct fs_parameter_enum *enums;
 	};
@@ -535,19 +534,13 @@ For example:
 	};
 
 	static const struct fs_parameter_description afs_fs_parameters = {
-		.name		= "kAFS",
 		.specs		= afs_param_specs,
 		.enums		= afs_param_enums,
 	};
 
 The members are as follows:
 
- (1) const char name[16];
-
-     The name to be used in error messages generated by the parse helper
-     functions.
-
- (2) const struct fs_parameter_specification *specs;
+ (1) const struct fs_parameter_specification *specs;
 
      Table of parameter specifications, terminated with a null entry, where the
      entries are of type:
@@ -626,7 +619,7 @@ The members are as follows:
      of arguments to specify the type and the flags for anything that doesn't
      match one of the above macros.
 
- (6) const struct fs_parameter_enum *enums;
+ (2) const struct fs_parameter_enum *enums;
 
      Table of enum value names to integer mappings, terminated with a null
      entry.  This is of type:
diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 9b1586b..36ce5d0 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -592,7 +592,6 @@ enum {
 };
 
 static const struct fs_parameter_description spufs_fs_parameters = {
-	.name		= "spufs",
 	.specs		= spufs_param_specs,
 };
 
diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 70139d0..b3a6d13 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -216,7 +216,6 @@ static int hypfs_release(struct inode *inode, struct file *filp)
 };
 
 static const struct fs_parameter_description hypfs_fs_parameters = {
-	.name		= "hypfs",
 	.specs		= hypfs_param_specs,
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2e3b06d..f145594 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2045,7 +2045,6 @@ enum rdt_param {
 };
 
 static const struct fs_parameter_description rdt_fs_parameters = {
-	.name		= "rdt",
 	.specs		= rdt_param_specs,
 };
 
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2b18456..b33f147 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -864,7 +864,6 @@ enum {
 };
 
 static const struct fs_parameter_description rbd_parameters = {
-	.name		= "rbd",
 	.specs		= rbd_param_specs,
 };
 
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index ce1d023..14ef94f 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1497,7 +1497,6 @@ enum {
 };
 
 static const struct fs_parameter_description ffs_fs_fs_parameters = {
-	.name		= "kAFS",
 	.specs		= ffs_fs_param_specs,
 };
 
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 488641b..8edbd87 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -42,7 +42,6 @@
 
 struct file_system_type afs_fs_type = {
 	.owner			= THIS_MODULE,
-	.name			= "afs",
 	.init_fs_context	= afs_init_fs_context,
 	.parameters		= &afs_fs_parameters,
 	.kill_sb		= afs_kill_super,
@@ -90,7 +89,6 @@ enum afs_param {
 };
 
 static const struct fs_parameter_description afs_fs_parameters = {
-	.name		= "kAFS",
 	.specs		= afs_param_specs,
 	.enums		= afs_param_enums,
 };
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 9c9a7c6..c164256 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -199,7 +199,6 @@ enum ceph_recover_session_mode {
 };
 
 static const struct fs_parameter_description ceph_mount_parameters = {
-	.name           = "ceph",
 	.specs          = ceph_mount_param_specs,
 	.enums		= ceph_mount_param_enums,
 };
diff --git a/fs/filesystems.c b/fs/filesystems.c
index 9135646..77bf5f9 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -74,7 +74,8 @@ int register_filesystem(struct file_system_type * fs)
 	int res = 0;
 	struct file_system_type ** p;
 
-	if (fs->parameters && !fs_validate_description(fs->parameters))
+	if (fs->parameters &&
+	    !fs_validate_description(fs->name, fs->parameters))
 		return -EINVAL;
 
 	BUG_ON(strchr(fs->name, '.'));
diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index d1930ad..866c71b 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -111,7 +111,7 @@ int fs_parse(struct fs_context *fc,
 
 	if (p->flags & fs_param_deprecated)
 		warnf(fc, "%s: Deprecated parameter '%s'",
-		      desc->name, param->key);
+		      fc->fs_type->name, param->key);
 
 	if (result->negated)
 		goto okay;
@@ -147,7 +147,7 @@ int fs_parse(struct fs_context *fc,
 		if (param->type != fs_value_is_flag &&
 		    (param->type != fs_value_is_string || result->has_value))
 			return invalf(fc, "%s: Unexpected value for '%s'",
-				      desc->name, param->key);
+				      fc->fs_type->name, param->key);
 		result->boolean = true;
 		goto okay;
 
@@ -237,7 +237,8 @@ int fs_parse(struct fs_context *fc,
 	return p->opt;
 
 bad_value:
-	return invalf(fc, "%s: Bad value for '%s'", desc->name, param->key);
+	return invalf(fc, "%s: Bad value for '%s'",
+		      fc->fs_type->name, param->key);
 unknown_parameter:
 	return -ENOPARAM;
 }
@@ -357,22 +358,16 @@ bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
  * fs_validate_description - Validate a parameter description
  * @desc: The parameter description to validate.
  */
-bool fs_validate_description(const struct fs_parameter_description *desc)
+bool fs_validate_description(const char *name,
+	const struct fs_parameter_description *desc)
 {
 	const struct fs_parameter_spec *param, *p2;
 	const struct fs_parameter_enum *e;
-	const char *name = desc->name;
 	unsigned int nr_params = 0;
 	bool good = true, enums = false;
 
 	pr_notice("*** VALIDATE %s ***\n", name);
 
-	if (!name[0]) {
-		pr_err("VALIDATE Parser: No name\n");
-		name = "Unknown";
-		good = false;
-	}
-
 	if (desc->specs) {
 		for (param = desc->specs; param->name; param++) {
 			enum fs_parameter_type t = param->type;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 16aec32..5a01daa 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -463,7 +463,6 @@ enum {
 };
 
 static const struct fs_parameter_description fuse_fs_parameters = {
-	.name		= "fuse",
 	.specs		= fuse_param_specs,
 };
 
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index e8b7b0c..d406729 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1328,7 +1328,6 @@ enum opt_errors {
 };
 
 static const struct fs_parameter_description gfs2_fs_parameters = {
-	.name = "gfs2",
 	.specs = gfs2_param_specs,
 	.enums = gfs2_param_enums,
 };
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d5c2a31..2ac0143 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -85,7 +85,6 @@ enum hugetlb_param {
 };
 
 static const struct fs_parameter_description hugetlb_fs_parameters = {
-	.name		= "hugetlbfs",
 	.specs		= hugetlb_param_specs,
 };
 
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 0e6406c..55d44aa 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -185,7 +185,6 @@ enum {
 };
 
 const struct fs_parameter_description jffs2_fs_parameters = {
-	.name		= "jffs2",
 	.specs		= jffs2_param_specs,
 	.enums		= jffs2_param_enums,
 };
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 0b7c8df..c447654 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -48,7 +48,6 @@ enum proc_param {
 };
 
 static const struct fs_parameter_description proc_fs_parameters = {
-	.name		= "proc",
 	.specs		= proc_param_specs,
 };
 
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index d82636e..bb7ab56 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -187,7 +187,6 @@ enum ramfs_param {
 };
 
 const struct fs_parameter_description ramfs_fs_parameters = {
-	.name		= "ramfs",
 	.specs		= ramfs_param_specs,
 };
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d9ae27d..ee23a2b 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -107,7 +107,6 @@ enum {
 };
 
 static const struct fs_parameter_description xfs_fs_parameters = {
-	.name		= "xfs",
 	.specs		= xfs_param_specs,
 };
 
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index dee140d..090a2ed 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -62,7 +62,6 @@ struct fs_parameter_enum {
 };
 
 struct fs_parameter_description {
-	const char	name[16];		/* Name for logging purposes */
 	const struct fs_parameter_spec *specs;	/* List of param specifications */
 	const struct fs_parameter_enum *enums;	/* Enum values */
 };
@@ -97,12 +96,14 @@ extern int __lookup_constant(const struct constant_table tbl[], size_t tbl_size,
 #ifdef CONFIG_VALIDATE_FS_PARSER
 extern bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
 				    int low, int high, int special);
-extern bool fs_validate_description(const struct fs_parameter_description *desc);
+extern bool fs_validate_description(const char *name,
+				    const struct fs_parameter_description *desc);
 #else
 static inline bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
 					   int low, int high, int special)
 { return true; }
-static inline bool fs_validate_description(const struct fs_parameter_description *desc)
+static inline bool fs_validate_description(const char *name,
+					   const struct fs_parameter_description *desc)
 { return true; }
 #endif
 
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index ecf42be..9608aa4 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -593,7 +593,6 @@ enum {
 };
 
 static const struct fs_parameter_description bpf_fs_parameters = {
-	.name		= "bpf",
 	.specs		= bpf_param_specs,
 };
 
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 09f3a41..e711a43 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -900,7 +900,6 @@ enum cgroup1_param {
 };
 
 const struct fs_parameter_description cgroup1_fs_parameters = {
-	.name		= "cgroup1",
 	.specs		= cgroup1_param_specs,
 };
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 735af8f..d86d441 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1823,7 +1823,6 @@ enum cgroup2_param {
 };
 
 static const struct fs_parameter_description cgroup2_fs_parameters = {
-	.name		= "cgroup2",
 	.specs		= cgroup2_param_specs,
 };
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 165fa63..b6dc807 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3401,7 +3401,6 @@ enum shmem_param {
 };
 
 const struct fs_parameter_description shmem_fs_parameters = {
-	.name		= "tmpfs",
 	.specs		= shmem_param_specs,
 	.enums		= shmem_param_enums,
 };
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index a9d6c97..895a563 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -291,7 +291,6 @@ enum {
 };
 
 static const struct fs_parameter_description ceph_parameters = {
-        .name           = "libceph",
         .specs          = ceph_param_specs,
 };
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 116b4d6..54f3463 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2818,7 +2818,6 @@ static int selinux_fs_context_dup(struct fs_context *fc,
 };
 
 static const struct fs_parameter_description selinux_fs_parameters = {
-	.name		= "SELinux",
 	.specs		= selinux_param_specs,
 };
 
@@ -7145,7 +7144,7 @@ static __init int selinux_init(void)
 	else
 		pr_debug("SELinux:  Starting in permissive mode\n");
 
-	fs_validate_description(&selinux_fs_parameters);
+	fs_validate_description("selinux", &selinux_fs_parameters);
 
 	return 0;
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ecea41c..646c0b4 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -689,7 +689,6 @@ static int smack_fs_context_dup(struct fs_context *fc,
 };
 
 static const struct fs_parameter_description smack_fs_parameters = {
-	.name		= "smack",
 	.specs		= smack_param_specs,
 };
 

