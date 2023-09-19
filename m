Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A867A6047
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 12:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjISKzO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 06:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjISKxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:53:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B2B114
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 03:52:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso1437828566b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 03:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695120723; x=1695725523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RJXQBcevdI07ORSsmavy0U0gIEFY+Ang8Cg2jtZLSx8=;
        b=WALeTgWpH724hFT5l2FID14QDQQvc+XPGtGjEGH41rrHxxOrL2lem26zpwxtRhFr7t
         yQTpKJ1oG/bgwEfCwN+vqub6exHevElg+nT9QyRehAHXHArgm9mLpy36QlxlG0jnJ9BO
         7FsbzJjn1v3Z0aPqaIwF4s5w37E1Tt7mIesIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695120723; x=1695725523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJXQBcevdI07ORSsmavy0U0gIEFY+Ang8Cg2jtZLSx8=;
        b=J9bNb9VPYBlav/YyRKkNV4FJ3jZr4VqzI35rxLSvFM7CzoH7t75Vp59rQwtTjmbQMK
         eb1gRvjBk1IhufTNDZW10d5KGXFJGqeTI0hi16s7mBUBQOym5SPJLaLLC7OsU6U+iriy
         X92soyMxFr/1ZapQYEEPZvjOkEDtoP1O1BC+yBlyiuWVq2evDDyXZQE7gwN/LRcwBn1w
         x2Y9cc0h9M1qXNXl6F3367MDzbU3NdbF0nbSRkxSuuDT8+VX1BfOAa2tRt1PBc+WGT08
         bycr9WOy694ps01O8hU/XiJ3+hMe0HiNY1YXS2psCoptTMzxCG5sh/aQ46Fh80x5fDdI
         V3VA==
X-Gm-Message-State: AOJu0YyDmMVWDTRm4eKcKGOEhdaqGZQ3MST5ZiIRtsdo1phcJYzUUSDj
        gh4EBJAO5tGg8Eud7lNF2MEedYaHW3/5NgMp5Spbbw==
X-Google-Smtp-Source: AGHT+IGGWuWYVAmYA+3Xz7DhskO4n4kICuBx3cTFOHiEJPKfceh4b3ajcs9FbRntJaboqWZxfNnZvSBPM0/ZpOsAO4s=
X-Received: by 2002:a17:907:7611:b0:9a1:ca55:d0cb with SMTP id
 jx17-20020a170907761100b009a1ca55d0cbmr2647378ejc.23.1695120723228; Tue, 19
 Sep 2023 03:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-grafik-zutreffen-995b321017ae@brauner>
 <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <20230918-hierbei-erhielten-ba5ef74a5b52@brauner> <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
 <20230918-stuhl-spannend-9904d4addc93@brauner> <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com>
 <20230918-bestialisch-brutkasten-1fb34abdc33c@brauner> <CAJfpegvTiK=RM+0y07h-2vT6Zk2GCu6F98c=_CNx8B1ytFtO-g@mail.gmail.com>
 <20230919003800.93141-1-mattlloydhouse@gmail.com> <CAJfpegs6g8JQDtaHsECA_12ss_8KXOHVRH9gwwPf5WamzxXOWQ@mail.gmail.com>
 <20230919-abfedern-halfen-c12583ff93ac@brauner>
In-Reply-To: <20230919-abfedern-halfen-c12583ff93ac@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 19 Sep 2023 12:51:51 +0200
Message-ID: <CAJfpegsjE_G4d-W2hCZc0y+PioRgvK5TxT7kFAVgBqX6zN2dKg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Matthew House <mattlloydhouse@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 19 Sept 2023 at 11:07, Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, Sep 19, 2023 at 10:02:17AM +0200, Miklos Szeredi wrote:

> > This is where the thread started.  Knowing the size of the buffer is
> > no good, since the needed buffer could change between calls.
>
> The same problem would exist for the single buffer. Realistically, users
> will most often simply use a fixed size PATH_MAX buffer that will cover
> most cases and fallback to allocating a larger buffer in case things go
> awry.

Exactly.  A large buffer will work in 99.99% of the cases. Good
quality implementations will deal with the 0.01% as well, but
optimizing that case is nonsense.

> Really, the main things I care about are 64 bit alignment of the whole
> struct, typed __u64 pointers

Okay.

>  with __u32 size for mnt_root and mnt_point

Unnecessary if the strings are nul terminated.

> and that we please spell out "mount" and not use "mnt": so statmount
> because the new mount api uses "mount" (move_mount(), mount_setattr(),
> fsmount(), MOUNT_ATTR_*) almost everywhere.

Okay.

Incremental below.

Also pushed to:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#statmount

Thanks,
Miklos


diff --git a/arch/x86/entry/syscalls/syscall_64.tbl
b/arch/x86/entry/syscalls/syscall_64.tbl
index 0d9a47b0ce9b..a1b3ce7d22cc 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -375,8 +375,8 @@
 451    common  cachestat               sys_cachestat
 452    common  fchmodat2               sys_fchmodat2
 453    64      map_shadow_stack        sys_map_shadow_stack
-454    common  statmnt                 sys_statmnt
-455    common  listmnt                 sys_listmnt
+454    common  statmount               sys_statmount
+455    common  listmount               sys_listmount

 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/fs/namespace.c b/fs/namespace.c
index 5362b1ffb26f..803003052bfb 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -68,9 +68,8 @@ static u64 event;
 static DEFINE_IDA(mnt_id_ida);
 static DEFINE_IDA(mnt_group_ida);

-/* Don't allow confusion with mount ID allocated wit IDA */
-#define OLD_MNT_ID_MAX UINT_MAX
-static atomic64_t mnt_id_ctr = ATOMIC64_INIT(OLD_MNT_ID_MAX);
+/* Don't allow confusion with old 32bit mount ID */
+static atomic64_t mnt_id_ctr = ATOMIC64_INIT(1ULL << 32);

 static struct hlist_head *mount_hashtable __read_mostly;
 static struct hlist_head *mountpoint_hashtable __read_mostly;
@@ -4679,14 +4678,6 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const
char __user *, path,
        return err;
 }

-static bool mnt_id_match(struct mount *mnt, u64 id)
-{
-       if (id <= OLD_MNT_ID_MAX)
-               return id == mnt->mnt_id;
-       else
-               return id == mnt->mnt_id_unique;
-}
-
 struct vfsmount *lookup_mnt_in_ns(u64 id, struct mnt_namespace *ns)
 {
        struct mount *mnt;
@@ -4694,7 +4685,7 @@ struct vfsmount *lookup_mnt_in_ns(u64 id, struct
mnt_namespace *ns)

        lock_ns_list(ns);
        list_for_each_entry(mnt, &ns->list, mnt_list) {
-               if (!mnt_is_cursor(mnt) && mnt_id_match(mnt, id)) {
+               if (!mnt_is_cursor(mnt) && id == mnt->mnt_id_unique) {
                        res = &mnt->mnt;
                        break;
                }
@@ -4747,7 +4738,7 @@ static int stmt_string_seq(struct stmt_state *s,
stmt_func_t func)
 }

 static void stmt_string(struct stmt_state *s, u64 mask, stmt_func_t func,
-                      stmt_str_t *str)
+                      u64 *str)
 {
        int ret = s->pos >= s->bufsize ? -EOVERFLOW : 0;
        struct statmnt *sm = &s->sm;
@@ -4767,8 +4758,7 @@ static void stmt_string(struct stmt_state *s,
u64 mask, stmt_func_t func,
                if (copy_to_user(s->buf + s->pos, seq->buf, seq->count)) {
                        s->err = -EFAULT;
                } else {
-                       str->off = s->pos;
-                       str->len = seq->count - 1;
+                       *str = (unsigned long) (s->buf + s->pos);
                        s->pos += seq->count;
                }
        }
@@ -4899,39 +4889,10 @@ static int stmt_fs_type(struct stmt_state *s)
        struct super_block *sb = s->mnt->mnt_sb;

        seq_puts(seq, sb->s_type->name);
-       if (sb->s_subtype) {
-               seq_putc(seq, '.');
-               seq_puts(seq, sb->s_subtype);
-       }
-       return 0;
-}
-
-static int stmt_sb_opts(struct stmt_state *s)
-{
-       struct seq_file *seq = &s->seq;
-       struct super_block *sb = s->mnt->mnt_sb;
-       char *p, *end, *next, *u = seq->buf;
-       int err;
-
-       if (!sb->s_op->show_options)
-               return 0;
-
-       err = sb->s_op->show_options(seq, s->mnt->mnt_root);
-       if (err || seq_has_overflowed(seq) || !seq->count)
-               return err;
-
-       end = seq->buf + seq->count;
-       *end = '\0';
-       for (p = seq->buf + 1; p < end; p = next + 1) {
-               next = strchrnul(p, ',');
-               *next = '\0';
-               u += string_unescape(p, u, 0, UNESCAPE_OCTAL) + 1;
-       }
-       seq->count = u - 1 - seq->buf;
        return 0;
 }

-static int do_statmnt(struct stmt_state *s)
+static int do_statmount(struct stmt_state *s)
 {
        struct statmnt *sm = &s->sm;
        struct mount *m = real_mount(s->mnt);
@@ -4946,7 +4907,6 @@ static int do_statmnt(struct stmt_state *s)
        stmt_string(s, STMT_MNT_ROOT, stmt_mnt_root, &sm->mnt_root);
        stmt_string(s, STMT_MOUNTPOINT, stmt_mountpoint, &sm->mountpoint);
        stmt_string(s, STMT_FS_TYPE, stmt_fs_type, &sm->fs_type);
-       stmt_string(s, STMT_SB_OPTS, stmt_sb_opts, &sm->sb_opts);

        if (s->err)
                return s->err;
@@ -4957,7 +4917,7 @@ static int do_statmnt(struct stmt_state *s)
        return 0;
 }

-SYSCALL_DEFINE5(statmnt, u64, mnt_id,
+SYSCALL_DEFINE5(statmount, u64, mnt_id,
                u64, mask, struct statmnt __user *, buf,
                size_t, bufsize, unsigned int, flags)
 {
@@ -4980,7 +4940,7 @@ SYSCALL_DEFINE5(statmnt, u64, mnt_id,
                };

                get_fs_root(current->fs, &s.root);
-               err = do_statmnt(&s);
+               err = do_statmount(&s);
                path_put(&s.root);
        }
        up_read(&namespace_sem);
@@ -4988,19 +4948,25 @@ SYSCALL_DEFINE5(statmnt, u64, mnt_id,
        return err;
 }

-static long do_listmnt(struct vfsmount *mnt, u64 __user *buf, size_t bufsize,
-                     const struct path *root)
+static long do_listmount(struct vfsmount *mnt, u64 __user *buf, size_t bufsize,
+                        const struct path *root, unsigned int flags)
 {
        struct mount *r, *m = real_mount(mnt);
        struct path rootmnt = { .mnt = root->mnt, .dentry =
root->mnt->mnt_root };
        long ctr = 0;
+       bool reachable_only = true;

-       if (!capable(CAP_SYS_ADMIN) &&
-           !is_path_reachable(m, mnt->mnt_root, &rootmnt))
-               return -EPERM;
+       if (flags & LISTMOUNT_UNREACHABLE) {
+               if (!capable(CAP_SYS_ADMIN))
+                       return -EPERM;
+               reachable_only = false;
+       }
+
+       if (reachable_only && !is_path_reachable(m, mnt->mnt_root, &rootmnt))
+               return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;

        list_for_each_entry(r, &m->mnt_mounts, mnt_child) {
-               if (!capable(CAP_SYS_ADMIN) &&
+               if (reachable_only &&
                    !is_path_reachable(r, r->mnt.mnt_root, root))
                        continue;

@@ -5015,14 +4981,14 @@ static long do_listmnt(struct vfsmount *mnt,
u64 __user *buf, size_t bufsize,
        return ctr;
 }

-SYSCALL_DEFINE4(listmnt, u64, mnt_id, u64 __user *, buf, size_t, bufsize,
+SYSCALL_DEFINE4(listmount, u64, mnt_id, u64 __user *, buf, size_t, bufsize,
                unsigned int, flags)
 {
        struct vfsmount *mnt;
        struct path root;
        long err;

-       if (flags)
+       if (flags & ~LISTMOUNT_UNREACHABLE)
                return -EINVAL;

        down_read(&namespace_sem);
@@ -5030,7 +4996,7 @@ SYSCALL_DEFINE4(listmnt, u64, mnt_id, u64 __user
*, buf, size_t, bufsize,
        err = -ENOENT;
        if (mnt) {
                get_fs_root(current->fs, &root);
-               err = do_listmnt(mnt, buf, bufsize, &root);
+               err = do_listmount(mnt, buf, bufsize, &root, flags);
                path_put(&root);
        }
        up_read(&namespace_sem);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 5d776cdb6f18..a35fb7b2c842 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -74,6 +74,7 @@ struct landlock_ruleset_attr;
 enum landlock_rule_type;
 struct cachestat_range;
 struct cachestat;
+struct statmnt;

 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -408,11 +409,11 @@ asmlinkage long sys_statfs64(const char __user
*path, size_t sz,
 asmlinkage long sys_fstatfs(unsigned int fd, struct statfs __user *buf);
 asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
                                struct statfs64 __user *buf);
-asmlinkage long sys_statmnt(u64 mnt_id, u64 mask,
-                           struct statmnt __user *buf, size_t bufsize,
-                           unsigned int flags);
-asmlinkage long sys_listmnt(u64 mnt_id, u64 __user *buf, size_t bufsize,
-                           unsigned int flags);
+asmlinkage long sys_statmount(u64 mnt_id, u64 mask,
+                             struct statmnt __user *buf, size_t bufsize,
+                             unsigned int flags);
+asmlinkage long sys_listmount(u64 mnt_id, u64 __user *buf, size_t bufsize,
+                             unsigned int flags);
 asmlinkage long sys_truncate(const char __user *path, long length);
 asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
 #if BITS_PER_LONG == 32
diff --git a/include/uapi/asm-generic/unistd.h
b/include/uapi/asm-generic/unistd.h
index a2b41370f603..8df6a747e21a 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -823,11 +823,11 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
 #define __NR_fchmodat2 452
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)

-#define __NR_statmnt   454
-__SYSCALL(__NR_statmnt, sys_statmnt)
+#define __NR_statmount   454
+__SYSCALL(__NR_statmount, sys_statmount)

-#define __NR_listmnt   455
-__SYSCALL(__NR_listmnt, sys_listmnt)
+#define __NR_listmount   455
+__SYSCALL(__NR_listmount, sys_listmount)

 #undef __NR_syscalls
 #define __NR_syscalls 456
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 4ec7308a9259..d98b41024507 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -138,11 +138,6 @@ struct mount_attr {
 /* List of all mount_attr versions. */
 #define MOUNT_ATTR_SIZE_VER0   32 /* sizeof first published struct */

-struct stmt_str {
-       __u32 off;
-       __u32 len;
-};
-
 struct statmnt {
        __u64 mask;             /* What results were written [uncond] */
        __u32 sb_dev_major;     /* Device ID */
@@ -159,11 +154,10 @@ struct statmnt {
        __u64 mnt_peer_group;   /* ID of shared peer group */
        __u64 mnt_master;       /* Mount receives propagation from this ID */
        __u64 propagate_from;   /* Propagation from in current namespace */
-       __u64 __spare[20];
-       struct stmt_str mnt_root;       /* Root of mount relative to
root of fs */
-       struct stmt_str mountpoint;     /* Mountpoint relative to root
of process */
-       struct stmt_str fs_type;        /* Filesystem type[.subtype] */
-       struct stmt_str sb_opts;        /* Super block string options
(nul delimted) */
+       __u64 mnt_root;         /* [str] Root of mount relative to root of fs */
+       __u64 mountpoint;       /* [str] Mountpoint relative to root
of process */
+       __u64 fs_type;          /* [srt] Filesystem type */
+       __u64 __spare[49];
 };

 #define STMT_SB_BASIC          0x00000001U     /* Want/got sb_... */
@@ -172,6 +166,8 @@ struct statmnt {
 #define STMT_MNT_ROOT          0x00000008U     /* Want/got mnt_root  */
 #define STMT_MOUNTPOINT                0x00000010U     /* Want/got
mountpoint */
 #define STMT_FS_TYPE           0x00000020U     /* Want/got fs_type */
-#define STMT_SB_OPTS           0x00000040U     /* Want/got sb_opts */
+
+/* listmount(2) flags */
+#define LISTMOUNT_UNREACHABLE  0x01    /* List unreachable mounts too */

 #endif /* _UAPI_LINUX_MOUNT_H */
