Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DD0580C30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 09:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiGZHKf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 03:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiGZHKe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:10:34 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD1B22290;
        Tue, 26 Jul 2022 00:10:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5E916320099E;
        Tue, 26 Jul 2022 03:10:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 26 Jul 2022 03:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1658819430; x=
        1658905830; bh=KFlxlUncwnZ5F8XB9RMjpao/FVH0XrfLhzYwJ2fWqNM=; b=F
        0nvuVW1Bqo5bjurdTKbPMV53yO4SFkjM+N7GDpwoM1R0Qu81ELJe8HbJ3YR69BK9
        GpCisu77wBFiDRMkf5mILvUr9LM0FbrkhGRUxc8hSfK+k9zSX84osTwIKSfTaH5n
        +0hfG9jP8EcUdofH8HAC+ojnj59Ijm4OQLbkYewQW8USbTDP/si7hlnh3TMxUQj9
        q+UpU2N4vZ0SrImUnAQxb0jCtlYK03+tO3+Bb3blQiMsWPvPxvSrLXeeP/PuHVTM
        DvsZFIqvTlEW+8SEmRhB/+1JO123ensN+1ucYZaRQ8GHCMcYP0A8geQi4rCS68aU
        PFRnREML01vzAeO0m5iSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1658819430; x=
        1658905830; bh=KFlxlUncwnZ5F8XB9RMjpao/FVH0XrfLhzYwJ2fWqNM=; b=o
        TV5wIDYgl8ZeFNKXozQXuoinGu7vMn8tE/eDhAhD3IO1WCVMRY677e7nMmDhpC6q
        JpcRNZq0YE+8FwsdkWmI0xQnLqO2VPMRc0LHGhWiayKtyMuaPDq8PkGHpc87ijkA
        4uep/d9aJIoCU0rhLMIJRzTkzFgw7CJuuZh1vWuXGPmnLxbM4FoEbUjN6PRwUSQ+
        8rwceB5AA2BbQfpdEnPr6/N1Ma64zn0OsxzrOc/8i6eif81vB8NlQ2JC4oX1/mTW
        /GDHJOrK2RMmoVYH8jrg6rvAajeEWIhwJ4t5XlmqV/KogDxw/Tu4C49y1iiwN/t3
        9e6/Wn0LEn2rjJlu2OYxA==
X-ME-Sender: <xms:ZpPfYoEet12EWXznlMFWlrS86zRQVIp46ICHf4csMo359dnlZfpDxQ>
    <xme:ZpPfYhX_QbFBM6PpmtAzKG1UTQ2HXRwqMeOpFV1ZrfuzkcpVdRRM1Q9BZkgwOBCYn
    LOxsiZ_oo1K>
X-ME-Received: <xmr:ZpPfYiLSAhmMtSme5g_27ALmkyiZt9fLJukmuiJ9tmH5EdegDJtpbO_PuN6mIYsiecITA9WoVN1X81pyZr3txENQPryDcn-LbOoFMvmldMEoYhV_gs4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtledguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuhffvvehfjggtgfesthekredttdefjeenucfhrhhomhepkfgr
    nhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeiveelkefgtdegudefudeftdelteejtedvheeuleevvdeluefhuddtieegveelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvg
    hnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:ZpPfYqFwOad60y3LMqUsKYCiqKMN6E_sGOUCflV2wEt5NM9k10Y62Q>
    <xmx:ZpPfYuVeVX0nOB4OuL5YQpymh3IbRwCMU4e6xOgNJbpXWUhL1ZydLg>
    <xmx:ZpPfYtPBnaIXERy8UmnlxtQUu_dJhE8mlSVEJ8Pkjtbteti7edJyXA>
    <xmx:ZpPfYtRu3-d3bPfUdSCutFxHe9oZ3zkiJ-Tt2RqyJMTeiFVzhuazug>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Jul 2022 03:10:27 -0400 (EDT)
Message-ID: <0157609c-f99a-8a51-4d2e-fe55bcd971c9@themaw.net>
Date:   Tue, 26 Jul 2022 15:10:23 +0800
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
 <5ee80f66-7e6c-228f-2ee0-a5610dabc887@themaw.net>
In-Reply-To: <5ee80f66-7e6c-228f-2ee0-a5610dabc887@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 26/7/22 13:11, Ian Kent wrote:
> On 20/7/22 10:17, Ian Kent wrote:
>>
>> On 20/7/22 09:50, Al Viro wrote:
>>> On Mon, Jul 11, 2022 at 11:37:40AM +0800, Ian Kent wrote:
>>>> While the total reference count of a mount is mostly all that's needed
>>>> the reference count corresponding to the mounts only is occassionally
>>>> also needed (for example, autofs checking if a tree of mounts can be
>>>> expired).
>>>>
>>>> To make this reference count avaialble with minimal changes add a
>>>> counter to track the number of child mounts under a given mount. This
>>>> count can then be used to calculate the mounts only reference count.
>>> No.  This is a wrong approach - instead of keeping track of number of
>>> children, we should just stop having them contribute to refcount of
>>> the parent.  Here's what I've got in my local tree; life gets simpler
>>> that way.
>>
>> Right, I'll grab this and run some tests.
>
> Just a heads up, I've been able to reliably hang autofs with the
>
> below patch using my submount test (which is actually pretty good
>
> at exposing problems).
>
>
> No idea what it is yet but I'll look around and keep trying to work
>
> it out, ;)

Mmm ... so it's just slower ... that was unexpected ...


>
>
> Ian
>
>>
>>
>> Ian
>>
>>>
>>> commit e99f1f9cc864103f326a5352e6ce1e377613437f
>>> Author: Al Viro <viro@zeniv.linux.org.uk>
>>> Date:   Sat Jul 9 14:45:39 2022 -0400
>>>
>>>      namespace: don't keep ->mnt_parent pinned
>>>           makes refcounting more consistent
>>>           Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>>>
>>> diff --git a/fs/namespace.c b/fs/namespace.c
>>> index 68789f896f08..53c29110a0cd 100644
>>> --- a/fs/namespace.c
>>> +++ b/fs/namespace.c
>>> @@ -906,7 +906,6 @@ void mnt_set_mountpoint(struct mount *mnt,
>>>               struct mount *child_mnt)
>>>   {
>>>       mp->m_count++;
>>> -    mnt_add_count(mnt, 1);    /* essentially, that's mntget */
>>>       child_mnt->mnt_mountpoint = mp->m_dentry;
>>>       child_mnt->mnt_parent = mnt;
>>>       child_mnt->mnt_mp = mp;
>>> @@ -1429,22 +1428,18 @@ void mnt_cursor_del(struct mnt_namespace 
>>> *ns, struct mount *cursor)
>>>   int may_umount_tree(struct vfsmount *m)
>>>   {
>>>       struct mount *mnt = real_mount(m);
>>> -    int actual_refs = 0;
>>> -    int minimum_refs = 0;
>>> -    struct mount *p;
>>>       BUG_ON(!m);
>>>         /* write lock needed for mnt_get_count */
>>>       lock_mount_hash();
>>> -    for (p = mnt; p; p = next_mnt(p, mnt)) {
>>> -        actual_refs += mnt_get_count(p);
>>> -        minimum_refs += 2;
>>> +    for (struct mount *p = mnt; p; p = next_mnt(p, mnt)) {
>>> +        int allowed = p == mnt ? 2 : 1;
>>> +        if (mnt_get_count(p) > allowed) {
>>> +            unlock_mount_hash();
>>> +            return 0;
>>> +        }
>>>       }
>>>       unlock_mount_hash();
>>> -
>>> -    if (actual_refs > minimum_refs)
>>> -        return 0;
>>> -
>>>       return 1;
>>>   }
>>>   @@ -1586,7 +1581,6 @@ static void umount_tree(struct mount *mnt, 
>>> enum umount_tree_flags how)
>>>             disconnect = disconnect_mount(p, how);
>>>           if (mnt_has_parent(p)) {
>>> -            mnt_add_count(p->mnt_parent, -1);
>>>               if (!disconnect) {
>>>                   /* Don't forget about p */
>>>                   list_add_tail(&p->mnt_child, 
>>> &p->mnt_parent->mnt_mounts);
>>> @@ -2892,12 +2886,8 @@ static int do_move_mount(struct path 
>>> *old_path, struct path *new_path)
>>>           put_mountpoint(old_mp);
>>>   out:
>>>       unlock_mount(mp);
>>> -    if (!err) {
>>> -        if (attached)
>>> -            mntput_no_expire(parent);
>>> -        else
>>> -            free_mnt_ns(ns);
>>> -    }
>>> +    if (!err && !attached)
>>> +        free_mnt_ns(ns);
>>>       return err;
>>>   }
>>>   @@ -3869,7 +3859,7 @@ SYSCALL_DEFINE2(pivot_root, const char 
>>> __user *, new_root,
>>>           const char __user *, put_old)
>>>   {
>>>       struct path new, old, root;
>>> -    struct mount *new_mnt, *root_mnt, *old_mnt, *root_parent, 
>>> *ex_parent;
>>> +    struct mount *new_mnt, *root_mnt, *old_mnt, *root_parent;
>>>       struct mountpoint *old_mp, *root_mp;
>>>       int error;
>>>   @@ -3900,10 +3890,9 @@ SYSCALL_DEFINE2(pivot_root, const char 
>>> __user *, new_root,
>>>       new_mnt = real_mount(new.mnt);
>>>       root_mnt = real_mount(root.mnt);
>>>       old_mnt = real_mount(old.mnt);
>>> -    ex_parent = new_mnt->mnt_parent;
>>>       root_parent = root_mnt->mnt_parent;
>>>       if (IS_MNT_SHARED(old_mnt) ||
>>> -        IS_MNT_SHARED(ex_parent) ||
>>> +        IS_MNT_SHARED(new_mnt->mnt_parent) ||
>>>           IS_MNT_SHARED(root_parent))
>>>           goto out4;
>>>       if (!check_mnt(root_mnt) || !check_mnt(new_mnt))
>>> @@ -3942,7 +3931,6 @@ SYSCALL_DEFINE2(pivot_root, const char __user 
>>> *, new_root,
>>>       attach_mnt(root_mnt, old_mnt, old_mp);
>>>       /* mount new_root on / */
>>>       attach_mnt(new_mnt, root_parent, root_mp);
>>> -    mnt_add_count(root_parent, -1);
>>>       touch_mnt_namespace(current->nsproxy->mnt_ns);
>>>       /* A moved mount should not expire automatically */
>>>       list_del_init(&new_mnt->mnt_expire);
>>> @@ -3952,8 +3940,6 @@ SYSCALL_DEFINE2(pivot_root, const char __user 
>>> *, new_root,
>>>       error = 0;
>>>   out4:
>>>       unlock_mount(old_mp);
>>> -    if (!error)
>>> -        mntput_no_expire(ex_parent);
>>>   out3:
>>>       path_put(&root);
>>>   out2:
>>> diff --git a/fs/pnode.c b/fs/pnode.c
>>> index 1106137c747a..e2c8a4b18857 100644
>>> --- a/fs/pnode.c
>>> +++ b/fs/pnode.c
>>> @@ -368,7 +368,7 @@ static inline int do_refcount_check(struct mount 
>>> *mnt, int count)
>>>    */
>>>   int propagate_mount_busy(struct mount *mnt, int refcnt)
>>>   {
>>> -    struct mount *m, *child, *topper;
>>> +    struct mount *m, *child;
>>>       struct mount *parent = mnt->mnt_parent;
>>>         if (mnt == parent)
>>> @@ -384,7 +384,6 @@ int propagate_mount_busy(struct mount *mnt, int 
>>> refcnt)
>>>         for (m = propagation_next(parent, parent); m;
>>>                    m = propagation_next(m, parent)) {
>>> -        int count = 1;
>>>           child = __lookup_mnt(&m->mnt, mnt->mnt_mountpoint);
>>>           if (!child)
>>>               continue;
>>> @@ -392,13 +391,10 @@ int propagate_mount_busy(struct mount *mnt, 
>>> int refcnt)
>>>           /* Is there exactly one mount on the child that covers
>>>            * it completely whose reference should be ignored?
>>>            */
>>> -        topper = find_topper(child);
>>> -        if (topper)
>>> -            count += 1;
>>> -        else if (!list_empty(&child->mnt_mounts))
>>> +        if (!find_topper(child) && !list_empty(&child->mnt_mounts))
>>>               continue;
>>>   -        if (do_refcount_check(child, count))
>>> +        if (do_refcount_check(child, 1))
>>>               return 1;
>>>       }
>>>       return 0;
