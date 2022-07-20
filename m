Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952A157B1B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 09:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239302AbiGTH0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 03:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239315AbiGTH0I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:26:08 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0871066BB9;
        Wed, 20 Jul 2022 00:26:07 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5A0FC5C0092;
        Wed, 20 Jul 2022 03:26:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 20 Jul 2022 03:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1658301966; x=
        1658388366; bh=B6+uixznWpHdEohDGmP3+AKeQCMmWG+4Se9ltdNTC+0=; b=q
        PxdJoOtwYAmSWLBVjADUHo11NvfgJAoVdwhP4k4qHQ03pF/ncVj72Uta1SMPdV4k
        HWIpTdLC/dRN83UKPvkC3bqVcxrMMHrggoQ4/+rt90ENs4TXtPxsaYyYAKCoUwhf
        fA0sLJpipofKNTl8SWEipLSxI6GehAzlXIfzFljzscep4XqXQpuLfPTyj00Qzkv7
        3Ngy3gjDaq05iMhtfFHFV3EIdow17QLy3OUdCMkuCEoouQJ6gy8vDAfWza4MZ+kh
        oxcCwRfPy/0WIUzmHrl/HHnTWH3VBM5m7xvbQ1id0aJcDYqR6Q1iXiIx3LCBs/dO
        S49cnRoZjLJxW52G1ilFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1658301966; x=
        1658388366; bh=B6+uixznWpHdEohDGmP3+AKeQCMmWG+4Se9ltdNTC+0=; b=Q
        3KCCSD5K6qofjj7HX1k47BJlWSR/f7wz8RtTKPV4zoh8icI4uBnx65qiczI+3Avc
        Y1FIbsB8/rmam6a3dLETs10VL2XYdFPDndYJaN6qht4Ooc2zsrXowlf3GHdYa754
        4wRP5Ur82L6KORTm90LxeMs8Y8b8iB0ICm6dmN20FsGPLF2t/cRXHW/1ptQb1Iao
        R+Mm3lGLVlZ20Pe3lDAVWW5C/Gb/gOcNR+9rCXDqA14PpMSh+DFRKoMkoEiHubp7
        WCpa8FJqV6O/d42baMKtADg1kWCNKmufUABGZW2QrLI38sDV++5rSXBCA5/StKw7
        /sTgs1TxpBCOH0HV5umHg==
X-ME-Sender: <xms:Da7XYr8ByNQMzC8qvnXqF3RkKteCS33M-leYTnGE94eH6VjMmxsmrg>
    <xme:Da7XYnt0xNCPuBxU1d2WsXw7mqhj9rQ4hZ_WoSvDR8qpAe1oXjisc0tGscFhs_Xg1
    vLpxhrpZe_e>
X-ME-Received: <xmr:Da7XYpByEGcrst0MAGcI6BOwOQaX_X2mBwudM-1Ga6pHyL-NwEbcJp-WW-7z-oW_VwYowrKweYOgcPw3RMSuWi_8DphZgCFJOmP40_zdgk-xAe8Qy5I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeluddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuhffvvehfjggtgfesthekredttdefjeenucfhrhhomhepkfgr
    nhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeiveelkefgtdegudefudeftdelteejtedvheeuleevvdeluefhuddtieegveelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvg
    hnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:Dq7XYneTkWp2oUzAah9nZgVrVgzJ3fXACD42q3HtPTcuOokWHRRBfg>
    <xmx:Dq7XYgN4cIqtg5DM_RmeZ5THQpD8T1tsUX5VB_8ZNtlSSs8bjTBCfg>
    <xmx:Dq7XYplnYLuKi5MPIYxFm4p-mR1SAZONuSDdYiNJWy4O_HcvGJQVIA>
    <xmx:Dq7XYlrHiu22e9e0sDvI5r2qCrl7qwhm-e_8Rd02biSa7a_3Ji3WsQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Jul 2022 03:26:03 -0400 (EDT)
Message-ID: <afc1cca0-1a23-65d0-6fcb-dcbb7c336669@themaw.net>
Date:   Wed, 20 Jul 2022 15:26:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] vfs: track count of child mounts
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <165751053430.210556.5634228273667507299.stgit@donald.themaw.net>
 <165751066075.210556.17270883735094115327.stgit@donald.themaw.net>
 <YtdfUlO1puevbtfi@ZenIV> <6c072650-aed4-3ea5-0b8b-8e52655a222d@themaw.net>
In-Reply-To: <6c072650-aed4-3ea5-0b8b-8e52655a222d@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20/7/22 10:17, Ian Kent wrote:
>
> On 20/7/22 09:50, Al Viro wrote:
>> On Mon, Jul 11, 2022 at 11:37:40AM +0800, Ian Kent wrote:
>>> While the total reference count of a mount is mostly all that's needed
>>> the reference count corresponding to the mounts only is occassionally
>>> also needed (for example, autofs checking if a tree of mounts can be
>>> expired).
>>>
>>> To make this reference count avaialble with minimal changes add a
>>> counter to track the number of child mounts under a given mount. This
>>> count can then be used to calculate the mounts only reference count.
>> No.  This is a wrong approach - instead of keeping track of number of
>> children, we should just stop having them contribute to refcount of
>> the parent.  Here's what I've got in my local tree; life gets simpler
>> that way.
>
> Right, I'll grab this and run some tests.
>
>
> Ian
>
>>
>> commit e99f1f9cc864103f326a5352e6ce1e377613437f
>> Author: Al Viro <viro@zeniv.linux.org.uk>
>> Date:   Sat Jul 9 14:45:39 2022 -0400
>>
>>      namespace: don't keep ->mnt_parent pinned
>>           makes refcounting more consistent
>>           Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>>
>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index 68789f896f08..53c29110a0cd 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -906,7 +906,6 @@ void mnt_set_mountpoint(struct mount *mnt,
>>               struct mount *child_mnt)
>>   {
>>       mp->m_count++;
>> -    mnt_add_count(mnt, 1);    /* essentially, that's mntget */
>>       child_mnt->mnt_mountpoint = mp->m_dentry;
>>       child_mnt->mnt_parent = mnt;
>>       child_mnt->mnt_mp = mp;
>> @@ -1429,22 +1428,18 @@ void mnt_cursor_del(struct mnt_namespace *ns, 
>> struct mount *cursor)
>>   int may_umount_tree(struct vfsmount *m)
>>   {
>>       struct mount *mnt = real_mount(m);
>> -    int actual_refs = 0;
>> -    int minimum_refs = 0;
>> -    struct mount *p;
>>       BUG_ON(!m);
>>         /* write lock needed for mnt_get_count */
>>       lock_mount_hash();
>> -    for (p = mnt; p; p = next_mnt(p, mnt)) {
>> -        actual_refs += mnt_get_count(p);
>> -        minimum_refs += 2;
>> +    for (struct mount *p = mnt; p; p = next_mnt(p, mnt)) {
>> +        int allowed = p == mnt ? 2 : 1;
>> +        if (mnt_get_count(p) > allowed) {
>> +            unlock_mount_hash();
>> +            return 0;
>> +        }
>>       }

One part of the problem I'm trying to fix is when some other

process has created a mount namespace (say with unshare(1))

on an auto-mounted path and holds the mount in use in some way.

This leads to an attempted umount in the automount daemon which

fails because a propagation of the mount is in use.


Given the way may_umount() behaves I thought it sensible that

may_umount_tree() behave that way too, but the above doesn't

check propagated mounts.


I'll see if I can come up with something on that ... unless

I'm missing something and you have different thoughts how

this should be done ...


Ian

>>       unlock_mount_hash();
>> -
>> -    if (actual_refs > minimum_refs)
>> -        return 0;
>> -
>>       return 1;
>>   }
>>   @@ -1586,7 +1581,6 @@ static void umount_tree(struct mount *mnt, 
>> enum umount_tree_flags how)
>>             disconnect = disconnect_mount(p, how);
>>           if (mnt_has_parent(p)) {
>> -            mnt_add_count(p->mnt_parent, -1);
>>               if (!disconnect) {
>>                   /* Don't forget about p */
>>                   list_add_tail(&p->mnt_child, 
>> &p->mnt_parent->mnt_mounts);
>> @@ -2892,12 +2886,8 @@ static int do_move_mount(struct path 
>> *old_path, struct path *new_path)
>>           put_mountpoint(old_mp);
>>   out:
>>       unlock_mount(mp);
>> -    if (!err) {
>> -        if (attached)
>> -            mntput_no_expire(parent);
>> -        else
>> -            free_mnt_ns(ns);
>> -    }
>> +    if (!err && !attached)
>> +        free_mnt_ns(ns);
>>       return err;
>>   }
>>   @@ -3869,7 +3859,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user 
>> *, new_root,
>>           const char __user *, put_old)
>>   {
>>       struct path new, old, root;
>> -    struct mount *new_mnt, *root_mnt, *old_mnt, *root_parent, 
>> *ex_parent;
>> +    struct mount *new_mnt, *root_mnt, *old_mnt, *root_parent;
>>       struct mountpoint *old_mp, *root_mp;
>>       int error;
>>   @@ -3900,10 +3890,9 @@ SYSCALL_DEFINE2(pivot_root, const char 
>> __user *, new_root,
>>       new_mnt = real_mount(new.mnt);
>>       root_mnt = real_mount(root.mnt);
>>       old_mnt = real_mount(old.mnt);
>> -    ex_parent = new_mnt->mnt_parent;
>>       root_parent = root_mnt->mnt_parent;
>>       if (IS_MNT_SHARED(old_mnt) ||
>> -        IS_MNT_SHARED(ex_parent) ||
>> +        IS_MNT_SHARED(new_mnt->mnt_parent) ||
>>           IS_MNT_SHARED(root_parent))
>>           goto out4;
>>       if (!check_mnt(root_mnt) || !check_mnt(new_mnt))
>> @@ -3942,7 +3931,6 @@ SYSCALL_DEFINE2(pivot_root, const char __user 
>> *, new_root,
>>       attach_mnt(root_mnt, old_mnt, old_mp);
>>       /* mount new_root on / */
>>       attach_mnt(new_mnt, root_parent, root_mp);
>> -    mnt_add_count(root_parent, -1);
>>       touch_mnt_namespace(current->nsproxy->mnt_ns);
>>       /* A moved mount should not expire automatically */
>>       list_del_init(&new_mnt->mnt_expire);
>> @@ -3952,8 +3940,6 @@ SYSCALL_DEFINE2(pivot_root, const char __user 
>> *, new_root,
>>       error = 0;
>>   out4:
>>       unlock_mount(old_mp);
>> -    if (!error)
>> -        mntput_no_expire(ex_parent);
>>   out3:
>>       path_put(&root);
>>   out2:
>> diff --git a/fs/pnode.c b/fs/pnode.c
>> index 1106137c747a..e2c8a4b18857 100644
>> --- a/fs/pnode.c
>> +++ b/fs/pnode.c
>> @@ -368,7 +368,7 @@ static inline int do_refcount_check(struct mount 
>> *mnt, int count)
>>    */
>>   int propagate_mount_busy(struct mount *mnt, int refcnt)
>>   {
>> -    struct mount *m, *child, *topper;
>> +    struct mount *m, *child;
>>       struct mount *parent = mnt->mnt_parent;
>>         if (mnt == parent)
>> @@ -384,7 +384,6 @@ int propagate_mount_busy(struct mount *mnt, int 
>> refcnt)
>>         for (m = propagation_next(parent, parent); m;
>>                    m = propagation_next(m, parent)) {
>> -        int count = 1;
>>           child = __lookup_mnt(&m->mnt, mnt->mnt_mountpoint);
>>           if (!child)
>>               continue;
>> @@ -392,13 +391,10 @@ int propagate_mount_busy(struct mount *mnt, int 
>> refcnt)
>>           /* Is there exactly one mount on the child that covers
>>            * it completely whose reference should be ignored?
>>            */
>> -        topper = find_topper(child);
>> -        if (topper)
>> -            count += 1;
>> -        else if (!list_empty(&child->mnt_mounts))
>> +        if (!find_topper(child) && !list_empty(&child->mnt_mounts))
>>               continue;
>>   -        if (do_refcount_check(child, count))
>> +        if (do_refcount_check(child, 1))
>>               return 1;
>>       }
>>       return 0;
