Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC0A57ADEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 04:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbiGTCUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 22:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240935AbiGTCS4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:18:56 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD85664CC;
        Tue, 19 Jul 2022 19:18:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C08DF3200902;
        Tue, 19 Jul 2022 22:18:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 19 Jul 2022 22:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1658283485; x=
        1658369885; bh=8H7ji+0TyI03eClC29NavdviPz/MRQ5lAGcMJRJ6GdY=; b=m
        K/AJS6QxpqLS3vdtU5wHOa3VDo+Ss8/omhw7FLM5Ih5gB+1qYCXJV4ibaz5JAnOj
        5F1hKAJD7frBr7ucr3BGlG8LInkYiIWJvkG1Ar66ywuTfI3o7MkkWO3AI0NaeYd1
        wN7tqU9trBDHZ85f4N1VOSGhTGY17aaLFdkjoaDBfbgrghG1w1EVAdJhbdcsWeQn
        wpNKc4m9Vz/BU2gj6Y+Uwc7ro5KLH+spFOb8wB3OeA5KlHaSZIHtASTQSXSLuDQc
        xbd+KYzIzCR6IfZ+qZ0zz9T69AtqolvqcwU3GORdpgXoXBrZsKo1S73SOtiEJAcO
        bY9od/jOndn3u11z1N2Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1658283485; x=
        1658369885; bh=8H7ji+0TyI03eClC29NavdviPz/MRQ5lAGcMJRJ6GdY=; b=J
        EOEJm0l8Cn+fHp0naIe+zXdjBkF1Pz21bEEQehCfPgX81e/c6ocQAM8FFi3R3P8S
        qzfCejVRFEe1bXUX/fUR9k5dogR2iU7nGP9zitb16CRIFLkq0ziFW9XlFZ1yFEtM
        /bcQ9ceU6ybhk7F7IxPb0r+tWHcDNr1CyXaufW39Djds0i7mL7l79pxv6R2pkeD/
        T0x582FN4Y9sIfStYK2W9gpAl2wgDo5/vv4y8xEDsrql3GmaHcdbAVwxrM688dpZ
        DYP1FgWcJ92TQ0+czFK4SuGPIOy3AhxrEBGkRt0rAcwJfyDJJsuZCpTIBMv8kGL8
        /yRfiR47mn9mPKAj3UnYQ==
X-ME-Sender: <xms:3GXXYlq_z-KPtMv4vSTR-MnCK-xge4Z5BQU6loUkBnDO8RRv9wWJxA>
    <xme:3GXXYnpxTfO_uy29DQXfMJhw7rsKptxYS0ASue--IrzBtOxOCjIUK-XnTiZvvBR9U
    2HflLxd2Pkn>
X-ME-Received: <xmr:3GXXYiNFxYsgexRry6ZLnD8kOIEgRoIL7uR5z2wUUdopezuIyMfGqgn7G5jFpltpIJFkb2nijPJH6gQlgrc0_7jZDCRD0LMOlQoRcQJEHAf9TMwueRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeluddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:3GXXYg5OQxq6aSlgz8prFCsePdXG0kYCKTI3CcGAGUmdopXo3MFCVw>
    <xmx:3GXXYk6U9PuXrQtnpEOG2zRM_r5uGrduu0LsCJ0PgeRXuqfm4_uiYg>
    <xmx:3GXXYojVL-Gs3XqNESGW5d8eq4_MS_VAsDF_9yU_uY-cPp02jhDg7w>
    <xmx:3WXXYilkGvfj5caTUcVIFWqpUTle9TZy28iGFF6AoR-7HvkEbDnUpw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Jul 2022 22:18:02 -0400 (EDT)
Message-ID: <6c072650-aed4-3ea5-0b8b-8e52655a222d@themaw.net>
Date:   Wed, 20 Jul 2022 10:17:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] vfs: track count of child mounts
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <165751053430.210556.5634228273667507299.stgit@donald.themaw.net>
 <165751066075.210556.17270883735094115327.stgit@donald.themaw.net>
 <YtdfUlO1puevbtfi@ZenIV>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <YtdfUlO1puevbtfi@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 20/7/22 09:50, Al Viro wrote:
> On Mon, Jul 11, 2022 at 11:37:40AM +0800, Ian Kent wrote:
>> While the total reference count of a mount is mostly all that's needed
>> the reference count corresponding to the mounts only is occassionally
>> also needed (for example, autofs checking if a tree of mounts can be
>> expired).
>>
>> To make this reference count avaialble with minimal changes add a
>> counter to track the number of child mounts under a given mount. This
>> count can then be used to calculate the mounts only reference count.
> No.  This is a wrong approach - instead of keeping track of number of
> children, we should just stop having them contribute to refcount of
> the parent.  Here's what I've got in my local tree; life gets simpler
> that way.

Right, I'll grab this and run some tests.


Ian

>
> commit e99f1f9cc864103f326a5352e6ce1e377613437f
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Sat Jul 9 14:45:39 2022 -0400
>
>      namespace: don't keep ->mnt_parent pinned
>      
>      makes refcounting more consistent
>      
>      Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 68789f896f08..53c29110a0cd 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -906,7 +906,6 @@ void mnt_set_mountpoint(struct mount *mnt,
>   			struct mount *child_mnt)
>   {
>   	mp->m_count++;
> -	mnt_add_count(mnt, 1);	/* essentially, that's mntget */
>   	child_mnt->mnt_mountpoint = mp->m_dentry;
>   	child_mnt->mnt_parent = mnt;
>   	child_mnt->mnt_mp = mp;
> @@ -1429,22 +1428,18 @@ void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor)
>   int may_umount_tree(struct vfsmount *m)
>   {
>   	struct mount *mnt = real_mount(m);
> -	int actual_refs = 0;
> -	int minimum_refs = 0;
> -	struct mount *p;
>   	BUG_ON(!m);
>   
>   	/* write lock needed for mnt_get_count */
>   	lock_mount_hash();
> -	for (p = mnt; p; p = next_mnt(p, mnt)) {
> -		actual_refs += mnt_get_count(p);
> -		minimum_refs += 2;
> +	for (struct mount *p = mnt; p; p = next_mnt(p, mnt)) {
> +		int allowed = p == mnt ? 2 : 1;
> +		if (mnt_get_count(p) > allowed) {
> +			unlock_mount_hash();
> +			return 0;
> +		}
>   	}
>   	unlock_mount_hash();
> -
> -	if (actual_refs > minimum_refs)
> -		return 0;
> -
>   	return 1;
>   }
>   
> @@ -1586,7 +1581,6 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
>   
>   		disconnect = disconnect_mount(p, how);
>   		if (mnt_has_parent(p)) {
> -			mnt_add_count(p->mnt_parent, -1);
>   			if (!disconnect) {
>   				/* Don't forget about p */
>   				list_add_tail(&p->mnt_child, &p->mnt_parent->mnt_mounts);
> @@ -2892,12 +2886,8 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>   		put_mountpoint(old_mp);
>   out:
>   	unlock_mount(mp);
> -	if (!err) {
> -		if (attached)
> -			mntput_no_expire(parent);
> -		else
> -			free_mnt_ns(ns);
> -	}
> +	if (!err && !attached)
> +		free_mnt_ns(ns);
>   	return err;
>   }
>   
> @@ -3869,7 +3859,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
>   		const char __user *, put_old)
>   {
>   	struct path new, old, root;
> -	struct mount *new_mnt, *root_mnt, *old_mnt, *root_parent, *ex_parent;
> +	struct mount *new_mnt, *root_mnt, *old_mnt, *root_parent;
>   	struct mountpoint *old_mp, *root_mp;
>   	int error;
>   
> @@ -3900,10 +3890,9 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
>   	new_mnt = real_mount(new.mnt);
>   	root_mnt = real_mount(root.mnt);
>   	old_mnt = real_mount(old.mnt);
> -	ex_parent = new_mnt->mnt_parent;
>   	root_parent = root_mnt->mnt_parent;
>   	if (IS_MNT_SHARED(old_mnt) ||
> -		IS_MNT_SHARED(ex_parent) ||
> +		IS_MNT_SHARED(new_mnt->mnt_parent) ||
>   		IS_MNT_SHARED(root_parent))
>   		goto out4;
>   	if (!check_mnt(root_mnt) || !check_mnt(new_mnt))
> @@ -3942,7 +3931,6 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
>   	attach_mnt(root_mnt, old_mnt, old_mp);
>   	/* mount new_root on / */
>   	attach_mnt(new_mnt, root_parent, root_mp);
> -	mnt_add_count(root_parent, -1);
>   	touch_mnt_namespace(current->nsproxy->mnt_ns);
>   	/* A moved mount should not expire automatically */
>   	list_del_init(&new_mnt->mnt_expire);
> @@ -3952,8 +3940,6 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
>   	error = 0;
>   out4:
>   	unlock_mount(old_mp);
> -	if (!error)
> -		mntput_no_expire(ex_parent);
>   out3:
>   	path_put(&root);
>   out2:
> diff --git a/fs/pnode.c b/fs/pnode.c
> index 1106137c747a..e2c8a4b18857 100644
> --- a/fs/pnode.c
> +++ b/fs/pnode.c
> @@ -368,7 +368,7 @@ static inline int do_refcount_check(struct mount *mnt, int count)
>    */
>   int propagate_mount_busy(struct mount *mnt, int refcnt)
>   {
> -	struct mount *m, *child, *topper;
> +	struct mount *m, *child;
>   	struct mount *parent = mnt->mnt_parent;
>   
>   	if (mnt == parent)
> @@ -384,7 +384,6 @@ int propagate_mount_busy(struct mount *mnt, int refcnt)
>   
>   	for (m = propagation_next(parent, parent); m;
>   	     		m = propagation_next(m, parent)) {
> -		int count = 1;
>   		child = __lookup_mnt(&m->mnt, mnt->mnt_mountpoint);
>   		if (!child)
>   			continue;
> @@ -392,13 +391,10 @@ int propagate_mount_busy(struct mount *mnt, int refcnt)
>   		/* Is there exactly one mount on the child that covers
>   		 * it completely whose reference should be ignored?
>   		 */
> -		topper = find_topper(child);
> -		if (topper)
> -			count += 1;
> -		else if (!list_empty(&child->mnt_mounts))
> +		if (!find_topper(child) && !list_empty(&child->mnt_mounts))
>   			continue;
>   
> -		if (do_refcount_check(child, count))
> +		if (do_refcount_check(child, 1))
>   			return 1;
>   	}
>   	return 0;
