Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F23273E0C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 15:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjFZNgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 09:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZNgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:36:15 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA5F1A2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 06:36:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 392A25C011D;
        Mon, 26 Jun 2023 09:36:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 26 Jun 2023 09:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687786572; x=1687872972; bh=ZqNByJxxnlNcyNHYdfSQ28h94O10hIAx/33
        ecCPu5aI=; b=WK63So9SEoY6AC3WkXLXksnmAIUYukWDg6vpHG3iJdSJZ1Vah0j
        qwCV+tln2Lxt8WiwherIyosCciSA3DHKZRP03VixBykjiiXbk9YeNqRT/YnHIKJg
        FcnoPwIp2sbcHJkzae9t+m2JO4a1NylyVSbRi+zLGq1McKloiaB4UKCR4tL4uNrO
        EEnoJ1h1UC2yymecvkmyz8t1GpSxFRQSlvGjVDLpuIoGn/e5z43m2oaey5qRFtVa
        HbcWaOz4Zoagc3gHFuCWASRquz2Wo8yvFsndt30U87Ocwub15LIBXYkwnrVOxIu6
        K046zQoolw0UkZTIqx2pzvD0Tt8Dz68xSUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687786572; x=1687872972; bh=ZqNByJxxnlNcyNHYdfSQ28h94O10hIAx/33
        ecCPu5aI=; b=gwJKyl2mwZSbpGz/w3QSVOcUXJE38pUB9N3oVbafDfKZaPWezgr
        pYWWlLn8reXeCkpjZU/p28PMDFdc4XsP7j6ioWPw8VJLX2QFQR6VWG+xQy29flax
        2+kIADMQPAmikJdmbAJlWdAodK3qn2iK1ChraiE5RqCeeYumI3VxcUksXANF1kDV
        0Wr/PiUlfOUX30/4P9Pvd+jJXrfBY91bv83W1sTcLqqMJ+KyYlOhVn8SDMPPQWXi
        K5314NHVENrfEbX75ppmQeHO/Pn+6ssuT4HXaLVrYP0kj2SQwQycPM3uAftvoYdU
        bsm411+/xY9pb4PfiyqCJqGzpYcKxkzDsnw==
X-ME-Sender: <xms:S5SZZIqyQXGW6rczRPlMZ47jJT7uuwNYVgrv_zGXcTztgynadIB1AQ>
    <xme:S5SZZOocj8pclgmn4IQpCRHY0-Ha_J4QmMFMNVHdYl0d4_y_xup03-3CE59_MYfAX
    UOUpov-j0jsS2qX>
X-ME-Received: <xmr:S5SZZNPjAV6b8bggsuja7xHTK0lqG5EZNJ6fQuST8jOMz27Mkgc6-RsJsJt30w-IhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehfedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffhvfevfhgjtgfgsehtkeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepudetjeeutddvtdduffefudduhedvvdfhgeel
    heetvefgkefhleeghfffgfetuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:S5SZZP7-5P6yg7Y6a1RWJoFdsDk9L84ztcaIjJaAzBJLyQERHcAUBg>
    <xmx:S5SZZH6KBNfLO74bNeezLNhYOPXL9WLX8BEy9cczex0mWmbpHz3dNA>
    <xmx:S5SZZPjHahJabtcpZDSpAUk6pqQY9eS1H6yP8o92N5w_7tbKSKh_BA>
    <xmx:TJSZZEvOCJe_GQf-gjb-uTplUIl4Ok4To_lmBovZnEoLLDHnvtCW-g>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jun 2023 09:36:10 -0400 (EDT)
Message-ID: <68ccd526-34a5-7c6f-304c-50c7df0cf4b2@fastmail.fm>
Date:   Mon, 26 Jun 2023 15:36:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/3] libfs: Add directory operations for stable offsets
Content-Language: en-US
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
To:     Chuck Lever <cel@kernel.org>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, hughd@google.com, akpm@linux-foundation.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <168605676256.32244.6158641147817585524.stgit@manet.1015granger.net>
 <168605705924.32244.13384849924097654559.stgit@manet.1015granger.net>
 <a291a0db-c631-6e52-1764-1ccadf60ca1a@fastmail.fm>
In-Reply-To: <a291a0db-c631-6e52-1764-1ccadf60ca1a@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/24/23 00:21, Bernd Schubert wrote:
> 
> 
> On 6/6/23 15:10, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Create a vector of directory operations in fs/libfs.c that handles
>> directory seeks and readdir via stable offsets instead of the
>> current cursor-based mechanism.
>>
>> For the moment these are unused.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   fs/dcache.c            |    1
>>   fs/libfs.c             |  185 
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/dcache.h |    1
>>   include/linux/fs.h     |    9 ++
>>   4 files changed, 196 insertions(+)
>>
>> diff --git a/fs/dcache.c b/fs/dcache.c
>> index 52e6d5fdab6b..9c9a801f3b33 100644
>> --- a/fs/dcache.c
>> +++ b/fs/dcache.c
>> @@ -1813,6 +1813,7 @@ static struct dentry *__d_alloc(struct 
>> super_block *sb, const struct qstr *name)
>>       dentry->d_sb = sb;
>>       dentry->d_op = NULL;
>>       dentry->d_fsdata = NULL;
>> +    dentry->d_offset = 0;
>>       INIT_HLIST_BL_NODE(&dentry->d_hash);
>>       INIT_LIST_HEAD(&dentry->d_lru);
>>       INIT_LIST_HEAD(&dentry->d_subdirs);
>> diff --git a/fs/libfs.c b/fs/libfs.c
>> index 89cf614a3271..07317bbe1668 100644
>> --- a/fs/libfs.c
>> +++ b/fs/libfs.c
>> @@ -239,6 +239,191 @@ const struct inode_operations 
>> simple_dir_inode_operations = {
>>   };
>>   EXPORT_SYMBOL(simple_dir_inode_operations);
>> +/**
>> + * stable_offset_init - initialize a parent directory
>> + * @dir: parent directory to be initialized
>> + *
>> + */
>> +void stable_offset_init(struct inode *dir)
>> +{
>> +    xa_init_flags(&dir->i_doff_map, XA_FLAGS_ALLOC1);
>> +    dir->i_next_offset = 0;
>> +}
>> +EXPORT_SYMBOL(stable_offset_init);
>> +
>> +/**
>> + * stable_offset_add - Add an entry to a directory's stable offset map
>> + * @dir: parent directory being modified
>> + * @dentry: new dentry being added
>> + *
>> + * Returns zero on success. Otherwise, a negative errno value is 
>> returned.
>> + */
>> +int stable_offset_add(struct inode *dir, struct dentry *dentry)
>> +{
>> +    struct xa_limit limit = XA_LIMIT(2, U32_MAX);
>> +    u32 offset = 0;
>> +    int ret;
>> +
>> +    if (dentry->d_offset)
>> +        return -EBUSY;
>> +
>> +    ret = xa_alloc_cyclic(&dir->i_doff_map, &offset, dentry, limit,
>> +                  &dir->i_next_offset, GFP_KERNEL);
> 
> Please see below at struct inode my question about i_next_offset.
> 
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    dentry->d_offset = offset;
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL(stable_offset_add);
>> +
>> +/**
>> + * stable_offset_remove - Remove an entry to a directory's stable 
>> offset map
>> + * @dir: parent directory being modified
>> + * @dentry: dentry being removed
>> + *
>> + */
>> +void stable_offset_remove(struct inode *dir, struct dentry *dentry)
>> +{
>> +    if (!dentry->d_offset)
>> +        return;
>> +
>> +    xa_erase(&dir->i_doff_map, dentry->d_offset);
>> +    dentry->d_offset = 0;
>> +}
>> +EXPORT_SYMBOL(stable_offset_remove);
>> +
>> +/**
>> + * stable_offset_destroy - Release offset map
>> + * @dir: parent directory that is about to be destroyed
>> + *
>> + * During fs teardown (eg. umount), a directory's offset map might still
>> + * contain entries. xa_destroy() cleans out anything that remains.
>> + */
>> +void stable_offset_destroy(struct inode *dir)
>> +{
>> +    xa_destroy(&dir->i_doff_map);
>> +}
>> +EXPORT_SYMBOL(stable_offset_destroy);
>> +
>> +/**
>> + * stable_dir_llseek - Advance the read position of a directory 
>> descriptor
>> + * @file: an open directory whose position is to be updated
>> + * @offset: a byte offset
>> + * @whence: enumerator describing the starting position for this update
>> + *
>> + * SEEK_END, SEEK_DATA, and SEEK_HOLE are not supported for directories.
>> + *
>> + * Returns the updated read position if successful; otherwise a
>> + * negative errno is returned and the read position remains unchanged.
>> + */
>> +static loff_t stable_dir_llseek(struct file *file, loff_t offset, int 
>> whence)
>> +{
>> +    switch (whence) {
>> +    case SEEK_CUR:
>> +        offset += file->f_pos;
>> +        fallthrough;
>> +    case SEEK_SET:
>> +        if (offset >= 0)
>> +            break;
>> +        fallthrough;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    return vfs_setpos(file, offset, U32_MAX);
>> +}
>> +
>> +static struct dentry *stable_find_next(struct xa_state *xas)
>> +{
>> +    struct dentry *child, *found = NULL;
>> +
>> +    rcu_read_lock();
>> +    child = xas_next_entry(xas, U32_MAX);
>> +    if (!child)
>> +        goto out;
>> +    spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
>> +    if (simple_positive(child))
>> +        found = dget_dlock(child);
>> +    spin_unlock(&child->d_lock);
>> +out:
>> +    rcu_read_unlock();
>> +    return found;
>> +}

I wonder if this should try the next dentry when simple_positive() 
returns false, what is if there is a readdir/unlink race? readdir now 
abort in the middle instead of continuing with the next dentry?

>> +
>> +static bool stable_dir_emit(struct dir_context *ctx, struct dentry 
>> *dentry)
>> +{
>> +    struct inode *inode = d_inode(dentry);
>> +
>> +    return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len,
>> +              dentry->d_offset, inode->i_ino,
>> +              fs_umode_to_dtype(inode->i_mode));
>> +}
>> +
>> +static void stable_iterate_dir(struct dentry *dir, struct dir_context 
>> *ctx)
>> +{
>> +    XA_STATE(xas, &((d_inode(dir))->i_doff_map), ctx->pos);
>> +    struct dentry *dentry;
>> +
>> +    while (true) {
>> +        spin_lock(&dir->d_lock);
>> +        dentry = stable_find_next(&xas);
>> +        spin_unlock(&dir->d_lock);
>> +        if (!dentry)
>> +            break;
>> +
>> +        if (!stable_dir_emit(ctx, dentry)) {
>> +            dput(dentry);
>> +            break;
>> +        }
>> +
>> +        dput(dentry);
>> +        ctx->pos = xas.xa_index + 1;
>> +    }
>> +}
>> +
>> +/**
>> + * stable_readdir - Emit entries starting at offset @ctx->pos
>> + * @file: an open directory to iterate over
>> + * @ctx: directory iteration context
>> + *
>> + * Caller must hold @file's i_rwsem to prevent insertion or removal of
>> + * entries during this call.
>> + *
>> + * On entry, @ctx->pos contains an offset that represents the first 
>> entry
>> + * to be read from the directory.
>> + *
>> + * The operation continues until there are no more entries to read, or
>> + * until the ctx->actor indicates there is no more space in the caller's
>> + * output buffer.
>> + *
>> + * On return, @ctx->pos contains an offset that will read the next entry
>> + * in this directory when shmem_readdir() is called again with @ctx.
>> + *
>> + * Return values:
>> + *   %0 - Complete
>> + */
>> +static int stable_readdir(struct file *file, struct dir_context *ctx)
>> +{
>> +    struct dentry *dir = file->f_path.dentry;
>> +
>> +    lockdep_assert_held(&d_inode(dir)->i_rwsem);
>> +
>> +    if (!dir_emit_dots(file, ctx))
>> +        return 0;
>> +
>> +    stable_iterate_dir(dir, ctx);
>> +    return 0;
>> +}
>> +
>> +const struct file_operations stable_dir_operations = {
>> +    .llseek        = stable_dir_llseek,
>> +    .iterate_shared    = stable_readdir,
>> +    .read        = generic_read_dir,
>> +    .fsync        = noop_fsync,
>> +};
>> +EXPORT_SYMBOL(stable_dir_operations);
>> +
>>   static struct dentry *find_next_child(struct dentry *parent, struct 
>> dentry *prev)
>>   {
>>       struct dentry *child = NULL;
>> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
>> index 6b351e009f59..579ce1800efe 100644
>> --- a/include/linux/dcache.h
>> +++ b/include/linux/dcache.h
>> @@ -96,6 +96,7 @@ struct dentry {
>>       struct super_block *d_sb;    /* The root of the dentry tree */
>>       unsigned long d_time;        /* used by d_revalidate */
>>       void *d_fsdata;            /* fs-specific data */
>> +    u32 d_offset;            /* directory offset in parent */
>>       union {
>>           struct list_head d_lru;        /* LRU list */
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 133f0640fb24..3fc2c04ed8ff 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -719,6 +719,10 @@ struct inode {
>>   #endif
>>       void            *i_private; /* fs or device private pointer */
>> +
>> +    /* simplefs stable directory offset tracking */
>> +    struct xarray        i_doff_map;
>> +    u32            i_next_offset;
> 
> Hmm, I was grepping through the patches and only find that 
> "i_next_offset" is initialized to 0 and then passed to xa_alloc_cyclic - 
> does this really need to part of struct inode or could it be a local 
> variable in stable_offset_add()?

Hmm, at best that is used for rename, but then is this offset right when 
old_dir and new_dir differ?

> 
> I only managed to look a bit through the patches right now, personally I 
> like v2 better as it doesn't extend struct inode with changes that can 
> be used by in-memory file system only. What do others think? An 
> alternative would be to have these fields in struct shmem_inode_info and 
> pass it as extra argument to the stable_ functions?
> 
> 
> Thanks,
> Bernd
