Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450FC7A12BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 03:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjIOBFY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 21:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjIOBFX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 21:05:23 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E317A1FE8;
        Thu, 14 Sep 2023 18:05:18 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6B98B3200950;
        Thu, 14 Sep 2023 21:05:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 14 Sep 2023 21:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694739916; x=1694826316; bh=P+68qh53SAAX4RozfvP5UE/KKsn4pG2G9/A
        oS9oaWs0=; b=dEcQhWOgp4/giqjh7sG3foRD/8fFqpSKJ53v4Xz/yHwK14cOsWf
        OA3y7tA0+Mysj3EwGYlj4gB5pNcD10ldXjPuAd6SwoY8x1FjqflXjbp1/I1k8vdu
        Wv5hExhEAP6kaERMZNLocKBTGDwixLcLJ2n0eia0UfNGqAq3B6xtF37DdX3VMd8y
        RFMoDhv5AEQ0SDaqcg1zkSljqQuxUnj6xfY8Rtu2EQy7giNxj4DRZCdbwawpM4SQ
        IHn0d9Q9+SMn9iHFVSGznIvLYaxVZLYtIoXo6QSeuv646rHzYnSorIiPkjT7RxVk
        RWLYcxG9pwGuyfX1SVsnA2p0w8EkkKTzXEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1694739916; x=1694826316; bh=P+68qh53SAAX4RozfvP5UE/KKsn4pG2G9/A
        oS9oaWs0=; b=Urn4AbTtHaJ5herYLs0seWjnoZnek00vPnNR8NK0K0VX9YZAgUW
        hpbBfEcbrlU4yTwCabW4gMxyeF4eCA7pC0AdWus1KX231ZIpIaPFtaY0R/Ul3lXJ
        zuWMaTK8KPF77RQfi4KCB0iMrXvGkNxlTu+/gU9wACkDD8BGt45Inw0gSEtPXUQj
        6ftZi2oEG5eUw9yJ5WM1CXnV38T+9VrA/0BfCgZjB4RFjOOuL35ZfGkB/nViBxHq
        2YGUTqQL53w9thtnCJxdIWjjxslD/yNk8y9mtLxT9JGwGimS4gG6ExHARAJ3YoDO
        QhafxUovfVo3Lsv9ZRSEesmMDGdpgNHVZLg==
X-ME-Sender: <xms:zK0DZQT9X0TlgRqflcv6gtqmxQ5pwS4zt8nEBu4cXvxYhI0HkzhxoQ>
    <xme:zK0DZdxu1lld-mxuG76Hj1noEQlgxHUp-3LlddYGqZoMIKi00pUWblGLHNu2dbZve
    sIq6Iyno1jN>
X-ME-Received: <xmr:zK0DZd0zF9qqVzDZto9mulO6JCG26zQJmgy9BqW4e0_hz58_NWT3OhAFZdwKlfqPy3nklmyAr-YeWP7g7IxfKxSd9XdolQLu2qJZOPS2YLDZcXEc1zOc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejuddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epheegveevfefhjeektdehleevjeehiedvjeefgeejfeetgfehhffhfeevheejtdefnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:zK0DZUAPGW8-_4r9G09OFFcksjAjsjGTDpKMyonZRF-OufRAtD_lig>
    <xmx:zK0DZZjCopynKDyYEs_42Iuil1q4jwVm9k86YBPdLvWUaGVYPObSdw>
    <xmx:zK0DZQoHKKHh9-0EOrNBsL9AM8h9lpLhKL-By7HdYBqyeMi-iwAe6Q>
    <xmx:zK0DZQOAkG0H2q3ekPQSgchLUrf8tHxZTfan110Kb612xGuXUFkHMw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Sep 2023 21:05:11 -0400 (EDT)
Message-ID: <1b748d8d-44b0-6b79-9fa7-7ab6ee681f4b@themaw.net>
Date:   Fri, 15 Sep 2023 09:05:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-3-mszeredi@redhat.com>
 <CAOQ4uxireYvc-+peft9RdYi+UzNSBsgNZN2Je+y_qnS578Cxfg@mail.gmail.com>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <CAOQ4uxireYvc-+peft9RdYi+UzNSBsgNZN2Je+y_qnS578Cxfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/9/23 14:11, Amir Goldstein wrote:
> On Wed, Sep 13, 2023 at 6:22 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>> Add a way to query attributes of a single mount instead of having to parse
>> the complete /proc/$PID/mountinfo, which might be huge.
>>
>> Lookup the mount by the old (32bit) or new (64bit) mount ID.  If a mount
>> needs to be queried based on path, then statx(2) can be used to first query
>> the mount ID belonging to the path.
>>
>> Design is based on a suggestion by Linus:
>>
>>    "So I'd suggest something that is very much like "statfsat()", which gets
>>     a buffer and a length, and returns an extended "struct statfs" *AND*
>>     just a string description at the end."
>>
>> The interface closely mimics that of statx.
>>
>> Handle ASCII attributes by appending after the end of the structure (as per
>> above suggestion).  Allow querying multiple string attributes with
>> individual offset/length for each.  String are nul terminated (termination
>> isn't counted in length).
>>
>> Mount options are also delimited with nul characters.  Unlike proc, special
>> characters are not quoted.
>>
>> Link: https://lore.kernel.org/all/CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com/
>> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>> ---
>>   arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>>   fs/internal.h                          |   5 +
>>   fs/namespace.c                         | 312 ++++++++++++++++++++++++-
>>   fs/proc_namespace.c                    |  19 +-
>>   fs/statfs.c                            |   1 +
>>   include/linux/syscalls.h               |   3 +
>>   include/uapi/asm-generic/unistd.h      |   5 +-
>>   include/uapi/linux/mount.h             |  36 +++
>>   8 files changed, 373 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
>> index 1d6eee30eceb..6d807c30cd16 100644
>> --- a/arch/x86/entry/syscalls/syscall_64.tbl
>> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
>> @@ -375,6 +375,7 @@
>>   451    common  cachestat               sys_cachestat
>>   452    common  fchmodat2               sys_fchmodat2
>>   453    64      map_shadow_stack        sys_map_shadow_stack
>> +454    common  statmnt                 sys_statmnt
>>
>>   #
>>   # Due to a historical design error, certain syscalls are numbered differently
>> diff --git a/fs/internal.h b/fs/internal.h
>> index d64ae03998cc..8f75271428aa 100644
>> --- a/fs/internal.h
>> +++ b/fs/internal.h
>> @@ -83,6 +83,11 @@ int path_mount(const char *dev_name, struct path *path,
>>                  const char *type_page, unsigned long flags, void *data_page);
>>   int path_umount(struct path *path, int flags);
>>
>> +/*
>> + * proc_namespace.c
>> + */
>> +int show_path(struct seq_file *m, struct dentry *root);
>> +
>>   /*
>>    * fs_struct.c
>>    */
>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index de47c5f66e17..088a52043bba 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -69,7 +69,8 @@ static DEFINE_IDA(mnt_id_ida);
>>   static DEFINE_IDA(mnt_group_ida);
>>
>>   /* Don't allow confusion with mount ID allocated wit IDA */
>> -static atomic64_t mnt_id_ctr = ATOMIC64_INIT(1ULL << 32);
>> +#define OLD_MNT_ID_MAX UINT_MAX
>> +static atomic64_t mnt_id_ctr = ATOMIC64_INIT(OLD_MNT_ID_MAX);
>>
>>   static struct hlist_head *mount_hashtable __read_mostly;
>>   static struct hlist_head *mountpoint_hashtable __read_mostly;
>> @@ -4678,6 +4679,315 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
>>          return err;
>>   }
>>
>> +static bool mnt_id_match(struct mount *mnt, u64 id)
>> +{
>> +       if (id <= OLD_MNT_ID_MAX)
>> +               return id == mnt->mnt_id;
>> +       else
>> +               return id == mnt->mnt_id_unique;
>> +}
>> +
>> +struct vfsmount *lookup_mnt_in_ns(u64 id, struct mnt_namespace *ns)
>> +{
>> +       struct mount *mnt;
>> +       struct vfsmount *res = NULL;
>> +
>> +       lock_ns_list(ns);
>> +       list_for_each_entry(mnt, &ns->list, mnt_list) {
>> +               if (!mnt_is_cursor(mnt) && mnt_id_match(mnt, id)) {
>> +                       res = &mnt->mnt;
>> +                       break;
>> +               }
>> +       }
>> +       unlock_ns_list(ns);
>> +       return res;
>> +}
>> +
>> +struct stmt_state {
>> +       void __user *const buf;
>> +       size_t const bufsize;
>> +       struct vfsmount *const mnt;
>> +       u64 const mask;
>> +       struct seq_file seq;
>> +       struct path root;
>> +       struct statmnt sm;
>> +       size_t pos;
>> +       int err;
>> +};
>> +
>> +typedef int (*stmt_func_t)(struct stmt_state *);
>> +
>> +static int stmt_string_seq(struct stmt_state *s, stmt_func_t func)
>> +{
>> +       struct seq_file *seq = &s->seq;
>> +       int ret;
>> +
>> +       seq->count = 0;
>> +       seq->size = min_t(size_t, seq->size, s->bufsize - s->pos);
>> +       seq->buf = kvmalloc(seq->size, GFP_KERNEL_ACCOUNT);
>> +       if (!seq->buf)
>> +               return -ENOMEM;
>> +
>> +       ret = func(s);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (seq_has_overflowed(seq)) {
>> +               if (seq->size == s->bufsize - s->pos)
>> +                       return -EOVERFLOW;
>> +               seq->size *= 2;
>> +               if (seq->size > MAX_RW_COUNT)
>> +                       return -ENOMEM;
>> +               kvfree(seq->buf);
>> +               return 0;
>> +       }
>> +
>> +       /* Done */
>> +       return 1;
>> +}
>> +
>> +static void stmt_string(struct stmt_state *s, u64 mask, stmt_func_t func,
>> +                      stmt_str_t *str)
>> +{
>> +       int ret = s->pos >= s->bufsize ? -EOVERFLOW : 0;
>> +       struct statmnt *sm = &s->sm;
>> +       struct seq_file *seq = &s->seq;
>> +
>> +       if (s->err || !(s->mask & mask))
>> +               return;
>> +
>> +       seq->size = PAGE_SIZE;
>> +       while (!ret)
>> +               ret = stmt_string_seq(s, func);
>> +
>> +       if (ret < 0) {
>> +               s->err = ret;
>> +       } else {
>> +               seq->buf[seq->count++] = '\0';
>> +               if (copy_to_user(s->buf + s->pos, seq->buf, seq->count)) {
>> +                       s->err = -EFAULT;
>> +               } else {
>> +                       str->off = s->pos;
>> +                       str->len = seq->count - 1;
>> +                       s->pos += seq->count;
>> +               }
>> +       }
>> +       kvfree(seq->buf);
>> +       sm->mask |= mask;
>> +}
>> +
>> +static void stmt_numeric(struct stmt_state *s, u64 mask, stmt_func_t func)
>> +{
>> +       if (s->err || !(s->mask & mask))
>> +               return;
>> +
>> +       s->err = func(s);
>> +       s->sm.mask |= mask;
>> +}
>> +
>> +static u64 mnt_to_attr_flags(struct vfsmount *mnt)
>> +{
>> +       unsigned int mnt_flags = READ_ONCE(mnt->mnt_flags);
>> +       u64 attr_flags = 0;
>> +
>> +       if (mnt_flags & MNT_READONLY)
>> +               attr_flags |= MOUNT_ATTR_RDONLY;
>> +       if (mnt_flags & MNT_NOSUID)
>> +               attr_flags |= MOUNT_ATTR_NOSUID;
>> +       if (mnt_flags & MNT_NODEV)
>> +               attr_flags |= MOUNT_ATTR_NODEV;
>> +       if (mnt_flags & MNT_NOEXEC)
>> +               attr_flags |= MOUNT_ATTR_NOEXEC;
>> +       if (mnt_flags & MNT_NODIRATIME)
>> +               attr_flags |= MOUNT_ATTR_NODIRATIME;
>> +       if (mnt_flags & MNT_NOSYMFOLLOW)
>> +               attr_flags |= MOUNT_ATTR_NOSYMFOLLOW;
>> +
>> +       if (mnt_flags & MNT_NOATIME)
>> +               attr_flags |= MOUNT_ATTR_NOATIME;
>> +       else if (mnt_flags & MNT_RELATIME)
>> +               attr_flags |= MOUNT_ATTR_RELATIME;
>> +       else
>> +               attr_flags |= MOUNT_ATTR_STRICTATIME;
>> +
>> +       if (is_idmapped_mnt(mnt))
>> +               attr_flags |= MOUNT_ATTR_IDMAP;
>> +
>> +       return attr_flags;
>> +}
>> +
>> +static u64 mnt_to_propagation_flags(struct mount *m)
>> +{
>> +       u64 propagation = 0;
>> +
>> +       if (IS_MNT_SHARED(m))
>> +               propagation |= MS_SHARED;
>> +       if (IS_MNT_SLAVE(m))
>> +               propagation |= MS_SLAVE;
>> +       if (IS_MNT_UNBINDABLE(m))
>> +               propagation |= MS_UNBINDABLE;
>> +       if (!propagation)
>> +               propagation |= MS_PRIVATE;
>> +
>> +       return propagation;
>> +}
>> +
>> +static int stmt_sb_basic(struct stmt_state *s)
>> +{
>> +       struct super_block *sb = s->mnt->mnt_sb;
>> +
>> +       s->sm.sb_dev_major = MAJOR(sb->s_dev);
>> +       s->sm.sb_dev_minor = MINOR(sb->s_dev);
>> +       s->sm.sb_magic = sb->s_magic;
>> +       s->sm.sb_flags = sb->s_flags & (SB_RDONLY|SB_SYNCHRONOUS|SB_DIRSYNC|SB_LAZYTIME);
>> +
>> +       return 0;
>> +}
>> +
>> +static int stmt_mnt_basic(struct stmt_state *s)
>> +{
>> +       struct mount *m = real_mount(s->mnt);
>> +
>> +       s->sm.mnt_id = m->mnt_id_unique;
>> +       s->sm.mnt_parent_id = m->mnt_parent->mnt_id_unique;
>> +       s->sm.mnt_id_old = m->mnt_id;
>> +       s->sm.mnt_parent_id_old = m->mnt_parent->mnt_id;
>> +       s->sm.mnt_attr = mnt_to_attr_flags(&m->mnt);
>> +       s->sm.mnt_propagation = mnt_to_propagation_flags(m);
>> +       s->sm.mnt_peer_group = IS_MNT_SHARED(m) ? m->mnt_group_id : 0;
>> +       s->sm.mnt_master = IS_MNT_SLAVE(m) ? m->mnt_master->mnt_group_id : 0;
>> +
>> +       return 0;
>> +}
>> +
>> +static int stmt_propagate_from(struct stmt_state *s)
>> +{
>> +       struct mount *m = real_mount(s->mnt);
>> +
>> +       if (!IS_MNT_SLAVE(m))
>> +               return 0;
>> +
>> +       s->sm.propagate_from = get_dominating_id(m, &current->fs->root);
>> +
>> +       return 0;
>> +}
>> +
>> +static int stmt_mnt_root(struct stmt_state *s)
>> +{
>> +       struct seq_file *seq = &s->seq;
>> +       int err = show_path(seq, s->mnt->mnt_root);
>> +
>> +       if (!err && !seq_has_overflowed(seq)) {
>> +               seq->buf[seq->count] = '\0';
>> +               seq->count = string_unescape_inplace(seq->buf, UNESCAPE_OCTAL);
>> +       }
>> +       return err;
>> +}
>> +
>> +static int stmt_mountpoint(struct stmt_state *s)
>> +{
>> +       struct vfsmount *mnt = s->mnt;
>> +       struct path mnt_path = { .dentry = mnt->mnt_root, .mnt = mnt };
>> +       int err = seq_path_root(&s->seq, &mnt_path, &s->root, "");
>> +
>> +       return err == SEQ_SKIP ? 0 : err;
>> +}
>> +
>> +static int stmt_fs_type(struct stmt_state *s)
>> +{
>> +       struct seq_file *seq = &s->seq;
>> +       struct super_block *sb = s->mnt->mnt_sb;
>> +
>> +       seq_puts(seq, sb->s_type->name);
>> +       if (sb->s_subtype) {
>> +               seq_putc(seq, '.');
>> +               seq_puts(seq, sb->s_subtype);
>> +       }
>> +       return 0;
>> +}
>> +
>> +static int stmt_sb_opts(struct stmt_state *s)
>> +{
>> +       struct seq_file *seq = &s->seq;
>> +       struct super_block *sb = s->mnt->mnt_sb;
>> +       char *p, *end, *next, *u = seq->buf;
>> +       int err;
>> +
>> +       if (!sb->s_op->show_options)
>> +               return 0;
>> +
>> +       err = sb->s_op->show_options(seq, s->mnt->mnt_root);
>> +       if (err || seq_has_overflowed(seq) || !seq->count)
>> +               return err;
>> +
>> +       end = seq->buf + seq->count;
>> +       *end = '\0';
>> +       for (p = seq->buf + 1; p < end; p = next + 1) {
>> +               next = strchrnul(p, ',');
>> +               *next = '\0';
>> +               u += string_unescape(p, u, 0, UNESCAPE_OCTAL) + 1;
>> +       }
>> +       seq->count = u - 1 - seq->buf;
>> +       return 0;
>> +}
>> +
>> +static int do_statmnt(struct stmt_state *s)
>> +{
>> +       struct statmnt *sm = &s->sm;
>> +       struct mount *m = real_mount(s->mnt);
>> +
>> +       if (!capable(CAP_SYS_ADMIN) &&
>> +           !is_path_reachable(m, m->mnt.mnt_root, &s->root))
>> +               return -EPERM;
>> +
>> +       stmt_numeric(s, STMT_SB_BASIC, stmt_sb_basic);
>> +       stmt_numeric(s, STMT_MNT_BASIC, stmt_mnt_basic);
>> +       stmt_numeric(s, STMT_PROPAGATE_FROM, stmt_propagate_from);
>> +       stmt_string(s, STMT_MNT_ROOT, stmt_mnt_root, &sm->mnt_root);
>> +       stmt_string(s, STMT_MOUNTPOINT, stmt_mountpoint, &sm->mountpoint);
>> +       stmt_string(s, STMT_FS_TYPE, stmt_fs_type, &sm->fs_type);
>> +       stmt_string(s, STMT_SB_OPTS, stmt_sb_opts, &sm->sb_opts);
>> +
>> +       if (s->err)
>> +               return s->err;
>> +
>> +       if (copy_to_user(s->buf, sm, min_t(size_t, s->bufsize, sizeof(*sm))))
>> +               return -EFAULT;
>> +
>> +       return 0;
> Similar concern as with listmnt, I think that users would
> want to have a way to get the fixed size statmnt part that fits
> in the buffer, even if the variable length string values do not fit
> and be able to query the required buffer size to get the strings.
>
> The API could be either to explicitly request
> STMT_MNT_ROOT_LEN | STMT_MOUNTPOINT_LEN ...
> without allowing mixing of no-value and value requests,
> or to out-out from any string values using a single flag,
> which is probably more simple for API and implementation.


There is also the possibility that the size needed to satisfy the

request will change between request and call, not sure how to deal

with that, but the size estimate is needed ...


Ian

