Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750A673FEFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 16:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjF0OxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 10:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjF0Own (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:52:43 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAA05249
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 07:50:19 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7B8295C0199;
        Tue, 27 Jun 2023 10:48:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 27 Jun 2023 10:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687877325; x=1687963725; bh=NKo2h1WLcQE1mZRALyXGQ95HjFxWJxQ0LrD
        gBvrqRRM=; b=DfgrfLzvNtBj5bZm3Iqa61QFNzfGZjCenYbjb4ltaCTDngfn/EC
        ywzLNnTbxnjVyGW7oMNOksquONfvcO6dC2LK70NGMpoxe0UC6BbswmRQ0g2FG4N/
        8fCLcv9f6mS+8Ykzt0wfNbSoKK4N+zLDbOzuk10CS20KqDQia8FoMd81lif/c13h
        cHW1RsQsF5mg41JH1m0EoFM/rIBdFlk8e4gvE7yafiOw6mvdWyvP+q7UHnMGjjtD
        vGnJ83vF7wn+nrUU67f017qyBcZ9JmDQDEIELpTQmtQBfCsTEA+8MeAGe251HVFv
        q4BTxJ6re+L4p3N+0/DVJMOOT9SfD43UEYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687877325; x=1687963725; bh=NKo2h1WLcQE1mZRALyXGQ95HjFxWJxQ0LrD
        gBvrqRRM=; b=lPdrxKg3EuRQVQ9tvF8v+B2t3siyQ5kE2LzxdaVsRLYeRjwO+LE
        feZHJaN9ac5epZ3vkMq/kf1K6cgVPtwnO4rn54dthq4msiejN9/1Vwqx3tQd4P+Q
        uHnpEi1cckscOhohlWqmvyqAAG40yUioyKmWflALrv66JXWNvZXgXoxbQPZ9HWt+
        rwoAVsaBHE11b7YsTAXcKldJSS29k8lmtL28Jav6C1f7jItS0nLvvV0LKNQqt+Jk
        3DIQKmIgL3NYoKvOPfUhDKZLKyFdlthKKW3HykepFqDm84J9tbZLMD398ERRtecM
        mR9SelAXzCO4gUB11ajWdpboZ7Ap838Sqgg==
X-ME-Sender: <xms:zfaaZBEQBN5wGWtENRKIBanjAGYxmGkhHDKcQmb_Uhs9z9UUdHTeHA>
    <xme:zfaaZGU5zAPg-u0g82iAzv_TmAdmIDw2qq4IN_AJqhDS5xGbaDRTBtHUzIk0QmAzx
    K89ErgCIfXq6xE5>
X-ME-Received: <xmr:zfaaZDKGAZBZycmX17JLMLbawa4XkeSirb1JoUpMA0HZV5rIlU7UrHiEYwR8E3JAn4EOfzNDhn5UTulk2ShsJBxGiBEM53IAugiJZMsELeSN2BVxVjE2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddtgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeekheevkeelkeekjefhheegfedtffduudejjeei
    heehudeuleelgefhueekfeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:zfaaZHF7MgY-SRiu3FNkDZ0V29NnhQIXVdqISsZxB7BP9D84-rZ-jg>
    <xmx:zfaaZHXZ1QRqWg7SHcCZZlYU58wLZhwkfl3Cw_OaIJYzIEPWKeYMhA>
    <xmx:zfaaZCNRL58t6APudIG4KC3OZGOB89esp1hXeg-RABD0b85hcm9pjQ>
    <xmx:zfaaZOHmemOloyGvEhNj9OHeZ5_9a3HbhRaAW8tPUeCHQKRUvLzIGg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jun 2023 10:48:43 -0400 (EDT)
Message-ID: <ee224324-0482-0f3f-2d4c-cda24243193b@fastmail.fm>
Date:   Tue, 27 Jun 2023 16:48:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 3/3] shmem: stable directory offsets
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <168780354647.2142.537463116658872680.stgit@manet.1015granger.net>
 <168780370085.2142.4461798321197359310.stgit@manet.1015granger.net>
 <22e91db4-1003-d4b4-dd6c-f17d09488449@fastmail.fm>
 <492B084E-B8D3-437A-A7C8-8EC75D6B97A1@oracle.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <492B084E-B8D3-437A-A7C8-8EC75D6B97A1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/27/23 16:11, Chuck Lever III wrote:
> 
> 
>> On Jun 27, 2023, at 10:06 AM, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 6/26/23 20:21, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>> The current cursor-based directory offset mechanism doesn't work
>>> when a tmpfs filesystem is exported via NFS. This is because NFS
>>> clients do not open directories. Each server-side READDIR operation
>>> has to open the directory, read it, then close it. The cursor state
>>> for that directory, being associated strictly with the opened
>>> struct file, is thus discarded after each NFS READDIR operation.
>>> Directory offsets are cached not only by NFS clients, but also by
>>> user space libraries on those clients. Essentially there is no way
>>> to invalidate those caches when directory offsets have changed on
>>> an NFS server after the offset-to-dentry mapping changes. Thus the
>>> whole application stack depends on unchanging directory offsets.
>>> The solution we've come up with is to make the directory offset for
>>> each file in a tmpfs filesystem stable for the life of the directory
>>> entry it represents.
>>> shmem_readdir() and shmem_dir_llseek() now use an xarray to map each
>>> directory offset (an loff_t integer) to the memory address of a
>>> struct dentry.
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>   mm/shmem.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++-------
>>>   1 file changed, 47 insertions(+), 7 deletions(-)
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index 721f9fd064aa..89012f3583b1 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -2410,7 +2410,8 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
>>>    /* Some things misbehave if size == 0 on a directory */
>>>    inode->i_size = 2 * BOGO_DIRENT_SIZE;
>>>    inode->i_op = &shmem_dir_inode_operations;
>>> - inode->i_fop = &simple_dir_operations;
>>> + inode->i_fop = &stable_dir_operations;
>>> + stable_offset_init(inode);
>>>    break;
>>>    case S_IFLNK:
>>>    /*
>>> @@ -2950,7 +2951,10 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
>>>    if (error && error != -EOPNOTSUPP)
>>>    goto out_iput;
>>>   - error = 0;
>>> + error = stable_offset_add(dir, dentry);
>>> + if (error)
>>> + goto out_iput;
>>> +
>>>    dir->i_size += BOGO_DIRENT_SIZE;
>>>    dir->i_ctime = dir->i_mtime = current_time(dir);
>>>    inode_inc_iversion(dir);
>>> @@ -3027,6 +3031,13 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
>>>    goto out;
>>>    }
>>>   + ret = stable_offset_add(dir, dentry);
>>> + if (ret) {
>>> + if (inode->i_nlink)
>>> + shmem_free_inode(inode->i_sb);
>>> + goto out;
>>> + }
>>> +
>>>    dir->i_size += BOGO_DIRENT_SIZE;
>>>    inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
>>>    inode_inc_iversion(dir);
>>> @@ -3045,6 +3056,8 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
>>>    if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
>>>    shmem_free_inode(inode->i_sb);
>>>   + stable_offset_remove(dir, dentry);
>>> +
>>>    dir->i_size -= BOGO_DIRENT_SIZE;
>>>    inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
>>>    inode_inc_iversion(dir);
>>> @@ -3103,24 +3116,41 @@ static int shmem_rename2(struct mnt_idmap *idmap,
>>>   {
>>>    struct inode *inode = d_inode(old_dentry);
>>>    int they_are_dirs = S_ISDIR(inode->i_mode);
>>> + int error;
>>>      if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
>>>    return -EINVAL;
>>>   - if (flags & RENAME_EXCHANGE)
>>> + if (flags & RENAME_EXCHANGE) {
>>> + error = stable_offset_add(new_dir, old_dentry);
>>> + if (error)
>>> + return error;
>>
>> Won't this fail in stable_offset_add() with -EBUSY, because dentry->d_offset is set?
>>
>>> + error = stable_offset_add(old_dir, new_dentry);
>>> + if (error) {
>>> + stable_offset_remove(new_dir, old_dentry);
>>> + return error;
>>> + }
>>> + stable_offset_remove(old_dir, old_dentry);
>>> + stable_offset_remove(new_dir, new_dentry);
>>
>> Assuming stable_offset_add() would have succeeded (somehow), old_dentry and new_dentry would have gotten reset their dentry->d_offset?
> 
> Probably. I can have another look.
> 
> 
>>> +
>>> + /* Always returns zero */
>>>    return simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
>>> + }
>>
>> Hmm, let's assume simple_rename_exchange() fails, stable entries are now the other way around?
> 
> Today it never fails. We can add an assertion here.
> 
> Otherwise cleaning up after a simple_rename_exchange() failure is going to be even more hair >
> 

Hmm, then add in the commit message that error handling for 
RENAME_EXCHANGE is not perfect?

>> I actually start to wonder if we need to introduce error injection for RENAME_EXCHANGE, I think it the most complex part in the series.
> 
> And it's the least frequently used mode of rename.
> 
> 
>>>      if (!simple_empty(new_dentry))
>>>    return -ENOTEMPTY;
>>>      if (flags & RENAME_WHITEOUT) {
>>> - int error;
>>> -
>>>    error = shmem_whiteout(idmap, old_dir, old_dentry);
>>>    if (error)
>>>    return error;
>>>    }
>>>   + stable_offset_remove(old_dir, old_dentry);
>>> + error = stable_offset_add(new_dir, old_dentry);
>>> + if (error)
>>> + return error;
>>> +
>>>    if (d_really_is_positive(new_dentry)) {
>>>    (void) shmem_unlink(new_dir, new_dentry);
>>>    if (they_are_dirs) {
>>> @@ -3164,19 +3194,23 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
>>>    if (error && error != -EOPNOTSUPP)
>>>    goto out_iput;
>>>   + error = stable_offset_add(dir, dentry);
>>> + if (error)
>>> + goto out_iput;
>>> +
>>>    inode->i_size = len-1;
>>>    if (len <= SHORT_SYMLINK_LEN) {
>>>    inode->i_link = kmemdup(symname, len, GFP_KERNEL);
>>>    if (!inode->i_link) {
>>>    error = -ENOMEM;
>>> - goto out_iput;
>>> + goto out_remove_offset;
>>>    }
>>>    inode->i_op = &shmem_short_symlink_operations;
>>>    } else {
>>>    inode_nohighmem(inode);
>>>    error = shmem_get_folio(inode, 0, &folio, SGP_WRITE);
>>>    if (error)
>>> - goto out_iput;
>>> + goto out_remove_offset;
>>>    inode->i_mapping->a_ops = &shmem_aops;
>>>    inode->i_op = &shmem_symlink_inode_operations;
>>>    memcpy(folio_address(folio), symname, len);
>>> @@ -3185,12 +3219,16 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
>>>    folio_unlock(folio);
>>>    folio_put(folio);
>>>    }
>>> +
>>>    dir->i_size += BOGO_DIRENT_SIZE;
>>>    dir->i_ctime = dir->i_mtime = current_time(dir);
>>>    inode_inc_iversion(dir);
>>>    d_instantiate(dentry, inode);
>>>    dget(dentry);
>>>    return 0;
>>> +
>>> +out_remove_offset:
>>> + stable_offset_remove(dir, dentry);
>>>   out_iput:
>>>    iput(inode);
>>>    return error;
>>> @@ -3920,6 +3958,8 @@ static void shmem_destroy_inode(struct inode *inode)
>>>   {
>>>    if (S_ISREG(inode->i_mode))
>>>    mpol_free_shared_policy(&SHMEM_I(inode)->policy);
>>> + if (S_ISDIR(inode->i_mode))
>>> + stable_offset_destroy(inode);
>>>   }
>>>     static void shmem_init_inode(void *foo)
> 
> 
> --
> Chuck Lever
> 
> 
