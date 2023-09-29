Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385177B29E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 02:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjI2Amn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 20:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjI2Aml (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 20:42:41 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D42A1B0;
        Thu, 28 Sep 2023 17:42:36 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1D5643200035;
        Thu, 28 Sep 2023 20:42:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 28 Sep 2023 20:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1695948151; x=1696034551; bh=X2bcFttqBl9ewIB92kZeWxLF/sT/vAAecpU
        4Oe2o/Fw=; b=RuSKU+YG6nEu1UC6E4fWV00ynkFktchoQ/0a7a/Ukbm8NHAUpSw
        jzlojUegTrEjSnF2FYFUT3h4y8YkdYJVzuM5dvHzYExm6/dfRnJfx1Utxbpu+thA
        DOEYbK+WpaZCCn8XwOODYkGzCLN1hqEH/lGe1fImbxtedVoGOFQls+f28cb7n5S5
        OaHfODuWXIqU41qtye9qcuOS+WQxHDkd3RP4Cv8ttHnXtN9Q5JvrzfVnhKmrliqo
        F/IHj0LU0ZfFzHVgbrMOmpGggRn15MuefwAEEa0J5Q8lJsOphJwZBStvgaE0YHnl
        7HDugUAPkUod2b+aWt5cSZGsp5Uvo0w7P3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695948151; x=1696034551; bh=X2bcFttqBl9ewIB92kZeWxLF/sT/vAAecpU
        4Oe2o/Fw=; b=Ezk1uitAAhUL81xhswK6jqifHqlqdF4jll/MZSzA2ZYXyiAXZ7+
        mybEB4JHTiaRUmSFux4GYrcQ5yrlYR+RW45TiU41MXRBWGO61Auo5UHXw3e0IqTr
        Z9UkBZOBOKnlExh26XJjID25h35rHZzjTkkGucBhR+hs4rKAlx/SyCdOlSzHfU1O
        3EVImT1W5RSKME5sQU2Yc92TO7ZqO6onepohC8pMBzG8tkoW02MGq317q+vLk+2t
        L+TgRCvWeXRxfzyQuwwO9H2Tnc+Zjko16Qxk3YV//OGWedCS9fW1ltx55ZlnI+Qe
        e8CtWYvS1uh6QQ8ewdPq12ST9FmiS6kFBYw==
X-ME-Sender: <xms:dx0WZRlfAwbN11kYKcBL6NmOR36t4He8eWFqMEff9vVadsuOwD7oNg>
    <xme:dx0WZc0P4jf47U7jvtIamRzckIvYSqwgJZaVbDKwkL8NtJ4rwJkDla0qMr-d1MnCj
    ZY7eOShjfeX>
X-ME-Received: <xmr:dx0WZXpAzzPExUneyyXMfjFR-7dnb9oMnNP53Jwwas0L4_tgl4i6pA1-ArMA5D7gXXQ0mQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddugdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eugeevheeujeejvdegieehkeeuudfhgfeujefgveegudejieeigeetheekhedvkeenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:dx0WZRl8h8To65P8KqCy9ZVjyGO1i23frQ_tndsxmrqR7XN0OCR6Rg>
    <xmx:dx0WZf0Qfrg54N7zRoLX3Ye8_O6fzWtIX6gZvK55p0v5mHAAALfZiA>
    <xmx:dx0WZQsmE2Fqm4L3hLm9b2H8weAuJQSNYOwieLuD1fucEOFyIlD3mg>
    <xmx:dx0WZdOdvKHLGu8VwPMLXoKsl6oX_fqlcluUKemjYPmaVTaiGdFWow>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Sep 2023 20:42:25 -0400 (EDT)
Message-ID: <5787bac5-b368-485a-f906-44e7049d4b8f@themaw.net>
Date:   Fri, 29 Sep 2023 08:42:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/4] add statmount(2) syscall
To:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20230928130147.564503-1-mszeredi@redhat.com>
 <20230928130147.564503-4-mszeredi@redhat.com>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20230928130147.564503-4-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/9/23 21:01, Miklos Szeredi wrote:
> Add a way to query attributes of a single mount instead of having to parse
> the complete /proc/$PID/mountinfo, which might be huge.
>
> Lookup the mount the new 64bit mount ID.  If a mount needs to be queried
> based on path, then statx(2) can be used to first query the mount ID
> belonging to the path.
>
> Design is based on a suggestion by Linus:
>
>    "So I'd suggest something that is very much like "statfsat()", which gets
>     a buffer and a length, and returns an extended "struct statfs" *AND*
>     just a string description at the end."
>
> The interface closely mimics that of statx.
>
> Handle ASCII attributes by appending after the end of the structure (as per
> above suggestion).  Pointers to strings are stored in u64 members to make
> the structure the same regardless of pointer size.  Strings are nul
> terminated.
>
> Link: https://lore.kernel.org/all/CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com/
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>   arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>   arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>   fs/namespace.c                         | 283 +++++++++++++++++++++++++
>   fs/statfs.c                            |   1 +
>   include/linux/syscalls.h               |   5 +
>   include/uapi/asm-generic/unistd.h      |   5 +-
>   include/uapi/linux/mount.h             |  56 +++++
>   7 files changed, 351 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 2d0b1bd866ea..317b1320ad18 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -457,3 +457,4 @@
>   450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
>   451	i386	cachestat		sys_cachestat
>   452	i386	fchmodat2		sys_fchmodat2
> +454	i386	statmount		sys_statmount
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 1d6eee30eceb..7312c440978f 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -375,6 +375,7 @@
>   451	common	cachestat		sys_cachestat
>   452	common	fchmodat2		sys_fchmodat2
>   453	64	map_shadow_stack	sys_map_shadow_stack
> +454	common	statmount		sys_statmount
>   
>   #
>   # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/fs/namespace.c b/fs/namespace.c
> index c3a41200fe70..3326ba2b2810 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4687,6 +4687,289 @@ int show_path(struct seq_file *m, struct dentry *root)
>   	return 0;
>   }
>   
> +static struct vfsmount *lookup_mnt_in_ns(u64 id, struct mnt_namespace *ns)
> +{
> +	struct mount *mnt;
> +	struct vfsmount *res = NULL;
> +
> +	lock_ns_list(ns);
> +	list_for_each_entry(mnt, &ns->list, mnt_list) {
> +		if (!mnt_is_cursor(mnt) && id == mnt->mnt_id_unique) {
> +			res = &mnt->mnt;
> +			break;
> +		}
> +	}
> +	unlock_ns_list(ns);
> +	return res;
> +}

Seems like we might need to consider making (struct mnt_namespace)->list

a hashed list.


The number of mounts could be large, for example people using autofs direct

mount setups.


It's not common for people to have of the order of 8k map entries (for

which there is a trigger mount per entry plus any mounts that have been

automounted) but it does happen. A small setup would be of the order of

1k map entries plus automounted mounts so the benefit is likely still

there to some extent.


Ian

> +
> +struct stmt_state {
> +	struct statmnt __user *const buf;
> +	size_t const bufsize;
> +	struct vfsmount *const mnt;
> +	u64 const mask;
> +	struct seq_file seq;
> +	struct path root;
> +	struct statmnt sm;
> +	size_t pos;
> +	int err;
> +};
> +
> +typedef int (*stmt_func_t)(struct stmt_state *);
> +
> +static int stmt_string_seq(struct stmt_state *s, stmt_func_t func)
> +{
> +	size_t rem = s->bufsize - s->pos - sizeof(s->sm);
> +	struct seq_file *seq = &s->seq;
> +	int ret;
> +
> +	seq->count = 0;
> +	seq->size = min(seq->size, rem);
> +	seq->buf = kvmalloc(seq->size, GFP_KERNEL_ACCOUNT);
> +	if (!seq->buf)
> +		return -ENOMEM;
> +
> +	ret = func(s);
> +	if (ret)
> +		return ret;
> +
> +	if (seq_has_overflowed(seq)) {
> +		if (seq->size == rem)
> +			return -EOVERFLOW;
> +		seq->size *= 2;
> +		if (seq->size > MAX_RW_COUNT)
> +			return -ENOMEM;
> +		kvfree(seq->buf);
> +		return 0;
> +	}
> +
> +	/* Done */
> +	return 1;
> +}
> +
> +static void stmt_string(struct stmt_state *s, u64 mask, stmt_func_t func,
> +		       u32 *str)
> +{
> +	int ret = s->pos + sizeof(s->sm) >= s->bufsize ? -EOVERFLOW : 0;
> +	struct statmnt *sm = &s->sm;
> +	struct seq_file *seq = &s->seq;
> +
> +	if (s->err || !(s->mask & mask))
> +		return;
> +
> +	seq->size = PAGE_SIZE;
> +	while (!ret)
> +		ret = stmt_string_seq(s, func);
> +
> +	if (ret < 0) {
> +		s->err = ret;
> +	} else {
> +		seq->buf[seq->count++] = '\0';
> +		if (copy_to_user(s->buf->str + s->pos, seq->buf, seq->count)) {
> +			s->err = -EFAULT;
> +		} else {
> +			*str = s->pos;
> +			s->pos += seq->count;
> +		}
> +	}
> +	kvfree(seq->buf);
> +	sm->mask |= mask;
> +}
> +
> +static void stmt_numeric(struct stmt_state *s, u64 mask, stmt_func_t func)
> +{
> +	if (s->err || !(s->mask & mask))
> +		return;
> +
> +	s->err = func(s);
> +	s->sm.mask |= mask;
> +}
> +
> +static u64 mnt_to_attr_flags(struct vfsmount *mnt)
> +{
> +	unsigned int mnt_flags = READ_ONCE(mnt->mnt_flags);
> +	u64 attr_flags = 0;
> +
> +	if (mnt_flags & MNT_READONLY)
> +		attr_flags |= MOUNT_ATTR_RDONLY;
> +	if (mnt_flags & MNT_NOSUID)
> +		attr_flags |= MOUNT_ATTR_NOSUID;
> +	if (mnt_flags & MNT_NODEV)
> +		attr_flags |= MOUNT_ATTR_NODEV;
> +	if (mnt_flags & MNT_NOEXEC)
> +		attr_flags |= MOUNT_ATTR_NOEXEC;
> +	if (mnt_flags & MNT_NODIRATIME)
> +		attr_flags |= MOUNT_ATTR_NODIRATIME;
> +	if (mnt_flags & MNT_NOSYMFOLLOW)
> +		attr_flags |= MOUNT_ATTR_NOSYMFOLLOW;
> +
> +	if (mnt_flags & MNT_NOATIME)
> +		attr_flags |= MOUNT_ATTR_NOATIME;
> +	else if (mnt_flags & MNT_RELATIME)
> +		attr_flags |= MOUNT_ATTR_RELATIME;
> +	else
> +		attr_flags |= MOUNT_ATTR_STRICTATIME;
> +
> +	if (is_idmapped_mnt(mnt))
> +		attr_flags |= MOUNT_ATTR_IDMAP;
> +
> +	return attr_flags;
> +}
> +
> +static u64 mnt_to_propagation_flags(struct mount *m)
> +{
> +	u64 propagation = 0;
> +
> +	if (IS_MNT_SHARED(m))
> +		propagation |= MS_SHARED;
> +	if (IS_MNT_SLAVE(m))
> +		propagation |= MS_SLAVE;
> +	if (IS_MNT_UNBINDABLE(m))
> +		propagation |= MS_UNBINDABLE;
> +	if (!propagation)
> +		propagation |= MS_PRIVATE;
> +
> +	return propagation;
> +}
> +
> +static int stmt_sb_basic(struct stmt_state *s)
> +{
> +	struct super_block *sb = s->mnt->mnt_sb;
> +
> +	s->sm.sb_dev_major = MAJOR(sb->s_dev);
> +	s->sm.sb_dev_minor = MINOR(sb->s_dev);
> +	s->sm.sb_magic = sb->s_magic;
> +	s->sm.sb_flags = sb->s_flags & (SB_RDONLY|SB_SYNCHRONOUS|SB_DIRSYNC|SB_LAZYTIME);
> +
> +	return 0;
> +}
> +
> +static int stmt_mnt_basic(struct stmt_state *s)
> +{
> +	struct mount *m = real_mount(s->mnt);
> +
> +	s->sm.mnt_id = m->mnt_id_unique;
> +	s->sm.mnt_parent_id = m->mnt_parent->mnt_id_unique;
> +	s->sm.mnt_id_old = m->mnt_id;
> +	s->sm.mnt_parent_id_old = m->mnt_parent->mnt_id;
> +	s->sm.mnt_attr = mnt_to_attr_flags(&m->mnt);
> +	s->sm.mnt_propagation = mnt_to_propagation_flags(m);
> +	s->sm.mnt_peer_group = IS_MNT_SHARED(m) ? m->mnt_group_id : 0;
> +	s->sm.mnt_master = IS_MNT_SLAVE(m) ? m->mnt_master->mnt_group_id : 0;
> +
> +	return 0;
> +}
> +
> +static int stmt_propagate_from(struct stmt_state *s)
> +{
> +	struct mount *m = real_mount(s->mnt);
> +
> +	if (!IS_MNT_SLAVE(m))
> +		return 0;
> +
> +	s->sm.propagate_from = get_dominating_id(m, &current->fs->root);
> +
> +	return 0;
> +}
> +
> +static int stmt_mnt_root(struct stmt_state *s)
> +{
> +	struct seq_file *seq = &s->seq;
> +	int err = show_path(seq, s->mnt->mnt_root);
> +
> +	if (!err && !seq_has_overflowed(seq)) {
> +		seq->buf[seq->count] = '\0';
> +		seq->count = string_unescape_inplace(seq->buf, UNESCAPE_OCTAL);
> +	}
> +	return err;
> +}
> +
> +static int stmt_mnt_point(struct stmt_state *s)
> +{
> +	struct vfsmount *mnt = s->mnt;
> +	struct path mnt_path = { .dentry = mnt->mnt_root, .mnt = mnt };
> +	int err = seq_path_root(&s->seq, &mnt_path, &s->root, "");
> +
> +	return err == SEQ_SKIP ? 0 : err;
> +}
> +
> +static int stmt_fs_type(struct stmt_state *s)
> +{
> +	struct seq_file *seq = &s->seq;
> +	struct super_block *sb = s->mnt->mnt_sb;
> +
> +	seq_puts(seq, sb->s_type->name);
> +	return 0;
> +}
> +
> +static int do_statmount(struct stmt_state *s)
> +{
> +	struct statmnt *sm = &s->sm;
> +	struct mount *m = real_mount(s->mnt);
> +	size_t copysize = min_t(size_t, s->bufsize, sizeof(*sm));
> +	int err;
> +
> +	err = security_sb_statfs(s->mnt->mnt_root);
> +	if (err)
> +		return err;
> +
> +	if (!capable(CAP_SYS_ADMIN) &&
> +	    !is_path_reachable(m, m->mnt.mnt_root, &s->root))
> +		return -EPERM;
> +
> +	stmt_numeric(s, STMT_SB_BASIC, stmt_sb_basic);
> +	stmt_numeric(s, STMT_MNT_BASIC, stmt_mnt_basic);
> +	stmt_numeric(s, STMT_PROPAGATE_FROM, stmt_propagate_from);
> +	stmt_string(s, STMT_FS_TYPE, stmt_fs_type, &sm->fs_type);
> +	stmt_string(s, STMT_MNT_ROOT, stmt_mnt_root, &sm->mnt_root);
> +	stmt_string(s, STMT_MNT_POINT, stmt_mnt_point, &sm->mnt_point);
> +
> +	if (s->err)
> +		return s->err;
> +
> +	/* Return the number of bytes copied to the buffer */
> +	sm->size = copysize + s->pos;
> +
> +	if (copy_to_user(s->buf, sm, copysize))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +SYSCALL_DEFINE4(statmount, const struct __mount_arg __user *, req,
> +		struct statmnt __user *, buf, size_t, bufsize,
> +		unsigned int, flags)
> +{
> +	struct vfsmount *mnt;
> +	struct __mount_arg kreq;
> +	int ret;
> +
> +	if (flags)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&kreq, req, sizeof(kreq)))
> +		return -EFAULT;
> +
> +	down_read(&namespace_sem);
> +	mnt = lookup_mnt_in_ns(kreq.mnt_id, current->nsproxy->mnt_ns);
> +	ret = -ENOENT;
> +	if (mnt) {
> +		struct stmt_state s = {
> +			.mask = kreq.request_mask,
> +			.buf = buf,
> +			.bufsize = bufsize,
> +			.mnt = mnt,
> +		};
> +
> +		get_fs_root(current->fs, &s.root);
> +		ret = do_statmount(&s);
> +		path_put(&s.root);
> +	}
> +	up_read(&namespace_sem);
> +
> +	return ret;
> +}
> +
>   static void __init init_mount_tree(void)
>   {
>   	struct vfsmount *mnt;
> diff --git a/fs/statfs.c b/fs/statfs.c
> index 96d1c3edf289..cc774c2e2c9a 100644
> --- a/fs/statfs.c
> +++ b/fs/statfs.c
> @@ -9,6 +9,7 @@
>   #include <linux/security.h>
>   #include <linux/uaccess.h>
>   #include <linux/compat.h>
> +#include <uapi/linux/mount.h>
>   #include "internal.h"
>   
>   static int flags_by_mnt(int mnt_flags)
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 22bc6bc147f8..ba371024d902 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -74,6 +74,8 @@ struct landlock_ruleset_attr;
>   enum landlock_rule_type;
>   struct cachestat_range;
>   struct cachestat;
> +struct statmnt;
> +struct __mount_arg;
>   
>   #include <linux/types.h>
>   #include <linux/aio_abi.h>
> @@ -408,6 +410,9 @@ asmlinkage long sys_statfs64(const char __user *path, size_t sz,
>   asmlinkage long sys_fstatfs(unsigned int fd, struct statfs __user *buf);
>   asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
>   				struct statfs64 __user *buf);
> +asmlinkage long sys_statmount(const struct __mount_arg __user *req,
> +			      struct statmnt __user *buf, size_t bufsize,
> +			      unsigned int flags);
>   asmlinkage long sys_truncate(const char __user *path, long length);
>   asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
>   #if BITS_PER_LONG == 32
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index abe087c53b4b..8f034e934a2e 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -823,8 +823,11 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
>   #define __NR_fchmodat2 452
>   __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
>   
> +#define __NR_statmount   454
> +__SYSCALL(__NR_statmount, sys_statmount)
> +
>   #undef __NR_syscalls
> -#define __NR_syscalls 453
> +#define __NR_syscalls 455
>   
>   /*
>    * 32 bit systems traditionally used different
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index bb242fdcfe6b..d2c988ab526b 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -138,4 +138,60 @@ struct mount_attr {
>   /* List of all mount_attr versions. */
>   #define MOUNT_ATTR_SIZE_VER0	32 /* sizeof first published struct */
>   
> +
> +/*
> + * Structure for getting mount/superblock/filesystem info with statmount(2).
> + *
> + * The interface is similar to statx(2): individual fields or groups can be
> + * selected with the @mask argument of statmount().  Kernel will set the @mask
> + * field according to the supported fields.
> + *
> + * If string fields are selected, then the caller needs to pass a buffer that
> + * has space after the fixed part of the structure.  Nul terminated strings are
> + * copied there and offsets relative to @str are stored in the relevant fields.
> + * If the buffer is too small, then EOVERFLOW is returned.  The actually used
> + * size is returned in @size.
> + */
> +struct statmnt {
> +	__u32 size;		/* Total size, including strings */
> +	__u32 __spare1;
> +	__u64 mask;		/* What results were written */
> +	__u32 sb_dev_major;	/* Device ID */
> +	__u32 sb_dev_minor;
> +	__u64 sb_magic;		/* ..._SUPER_MAGIC */
> +	__u32 sb_flags;		/* MS_{RDONLY,SYNCHRONOUS,DIRSYNC,LAZYTIME} */
> +	__u32 fs_type;		/* [str] Filesystem type */
> +	__u64 mnt_id;		/* Unique ID of mount */
> +	__u64 mnt_parent_id;	/* Unique ID of parent (for root == mnt_id) */
> +	__u32 mnt_id_old;	/* Reused IDs used in proc/.../mountinfo */
> +	__u32 mnt_parent_id_old;
> +	__u64 mnt_attr;		/* MOUNT_ATTR_... */
> +	__u64 mnt_propagation;	/* MS_{SHARED,SLAVE,PRIVATE,UNBINDABLE} */
> +	__u64 mnt_peer_group;	/* ID of shared peer group */
> +	__u64 mnt_master;	/* Mount receives propagation from this ID */
> +	__u64 propagate_from;	/* Propagation from in current namespace */
> +	__u32 mnt_root;		/* [str] Root of mount relative to root of fs */
> +	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
> +	__u64 __spare2[50];
> +	char str[];		/* Variable size part containing strings */
> +};
> +
> +/*
> + * To be used on the kernel ABI only for passing 64bit arguments to statmount(2)
> + */
> +struct __mount_arg {
> +	__u64 mnt_id;
> +	__u64 request_mask;
> +};
> +
> +/*
> + * @mask bits for statmount(2)
> + */
> +#define STMT_SB_BASIC		0x00000001U     /* Want/got sb_... */
> +#define STMT_MNT_BASIC		0x00000002U	/* Want/got mnt_... */
> +#define STMT_PROPAGATE_FROM	0x00000004U	/* Want/got propagate_from */
> +#define STMT_MNT_ROOT		0x00000008U	/* Want/got mnt_root  */
> +#define STMT_MNT_POINT		0x00000010U	/* Want/got mnt_point */
> +#define STMT_FS_TYPE		0x00000020U	/* Want/got fs_type */
> +
>   #endif /* _UAPI_LINUX_MOUNT_H */
