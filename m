Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CB87BDCE2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 14:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376588AbjJIMwx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 08:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346619AbjJIMww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:52:52 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0B48F;
        Mon,  9 Oct 2023 05:52:50 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 9F0613200AA7;
        Mon,  9 Oct 2023 08:52:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 09 Oct 2023 08:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1696855966; x=1696942366; bh=9fq7vkF4Cqi6XBFCuRJW1EaTqBCzFa1UoSM
        USwUSuiU=; b=fL4ABiAmhf2nJGDyKeLUYbee6A++Q9EQqKyrLjzPtLXh6jP4e71
        ZJdIFb3k4KZUrJbxI125mAPjWS2XSzBl1ssDD75Le5mZ+NY2e9p6WQmNTIAQmAYt
        Wj0Q5X3TbQ7fMzcTBtmdgoDFe3I8BSQ3M/tGYWGDP9Xsw/O9Kc8TuxTWLX4gi9s1
        5pWCCe3IP5N+LNGrBlanfL4Y0HoOx/hUX32lBxDJo3Vb9x1unWhdTCfeYZPpgFxY
        lLzWqGjRhb8m01ZR3b+zX1Op7tmW5n6ye1vs/3LdYzhZ47PIuq+3X75oY942vbkN
        s/609ERnD+rnEsivjoB7N/r3rXjLlVINP9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696855966; x=1696942366; bh=9fq7vkF4Cqi6XBFCuRJW1EaTqBCzFa1UoSM
        USwUSuiU=; b=nTqvY6WC9eDbN8a9QQL1S+7Nel9t5sbI8Uu+yN+fi7rkMxWHH+C
        WX3RCawbI950EUT7UfYt7PHQoyJEocc3MPKxiKEDZGszd036OY6liUpWn0vWt3LB
        7qawOWHsnWz/X01CWLyKOvhvZdk8VW3MMqAiPDaDVFaQrHPrsWy022QIFQMlMXxU
        0dGKuykMKzEYmKI7xHWdaNlOR3deMkcizVHKspDZNhjC6E/vEYSD6MTsMqCIwKdq
        o1C6Fw6kXjgyl1dHhTnSkXtzP26kyVeqSH1oYjQUnXqLFeWuNvcECG3R1DbRMOf4
        d+nyBvxqabt4FCgSncZQkRl+qbVxd4gxLwA==
X-ME-Sender: <xms:nfcjZejpyYpeuKVejWm11BFdd05NV2IMVdTubyzYQKlux67pgIFnpA>
    <xme:nfcjZfAj9ZlQl4KVVEKzlf73k_6y2epqi40dI-2Wzbia4gtmU-x1LlIVgyvRx9I4r
    8XpAr2gI23iSAFy>
X-ME-Received: <xmr:nfcjZWFFSgTayxn9CPxA1Xg63l0qqjTq1L9eAvrRHlBQUaGZVB9trozttPx801tJoepaUrnIgcqnNNgrQmxzSvLyyB5xEieJAYQzPxQ7syzatgeVKAT1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheefgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeeiveej
    ieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:nfcjZXQcRObCnxIhUY7iFO_F2G50wH5E7-9PaH4fjSaxcSsiEgz_Vw>
    <xmx:nfcjZbwZxEuoe5SdoPtu3YRnHazIqogXscElTyZ9hbzh-_Zh4CuplQ>
    <xmx:nfcjZV551LMPHhrkooqb--Qp14X3gV1Rhsu00JLrQkkJfnme-XBVlg>
    <xmx:nvcjZSmZpXnEvS-k_opB1J856r7MTP4XxWhdCVhL_Bt3K61rLqgstA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Oct 2023 08:52:44 -0400 (EDT)
Message-ID: <968148ad-787e-4ccb-9d84-f32b5da88517@fastmail.fm>
Date:   Mon, 9 Oct 2023 14:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [resend PATCH v2 2/2] fuse: ensure that submounts lookup their
 parent
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>
References: <cover.1696043833.git.kjlx@templeofstupid.com>
 <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
 <3187f942-dcf0-4b2f-a106-0eb5d5a33949@fastmail.fm>
 <20231007004107.GA1967@templeofstupid.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20231007004107.GA1967@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/7/23 02:41, Krister Johansen wrote:
> On Fri, Oct 06, 2023 at 07:13:06PM +0200, Bernd Schubert wrote:
>>
>>
>> On 10/2/23 17:24, Krister Johansen wrote:
>>> The submount code uses the parent nodeid passed into the function in
>>> order to create the root dentry for the new submount.  This nodeid does
>>> not get its remote reference count incremented by a lookup option.
>>>
>>> If the parent inode is evicted from its superblock, due to memory
>>> pressure for example, it can result in a forget opertation being sent to
>>> the server.  Should this nodeid be forgotten while it is still in use in
>>> a submount, users of the submount get an error from the server on any
>>> subsequent access.  In the author's case, this was an EBADF on all
>>> subsequent operations that needed to reference the root.
>>>
>>> Debugging the problem revealed that the dentry shrinker triggered a forget
>>> after killing the dentry with the last reference, despite the root
>>> dentry in another superblock still using the nodeid.
>>>
>>> As a result, a container that was also using this submount failed to
>>> access its filesystem because it had borrowed the reference instead of
>>> taking its own when setting up its superblock for the submount.
>>>
>>> This commit fixes the problem by having the new submount trigger a
>>> lookup for the parent as part of creating a new root dentry for the
>>> virtiofsd submount superblock.  This allows each superblock to have its
>>> inodes removed by the shrinker when unreferenced, while keeping the
>>> nodeid reference count accurate and active with the server.
>>>
>>> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
>>> ---
>>>    fs/fuse/dir.c    | 10 +++++-----
>>>    fs/fuse/fuse_i.h |  6 ++++++
>>>    fs/fuse/inode.c  | 43 +++++++++++++++++++++++++++++++++++++------
>>>    3 files changed, 48 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>>> index 5e01946d7531..333730c74619 100644
>>> --- a/fs/fuse/dir.c
>>> +++ b/fs/fuse/dir.c
>>> @@ -183,11 +183,11 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
>>>    	args->out_args[0].value = outarg;
>>>    }
>>> -static int fuse_dentry_revalidate_lookup(struct fuse_mount *fm,
>>> -					 struct dentry *entry,
>>> -					 struct inode *inode,
>>> -					 struct fuse_entry_out *outarg,
>>> -					 bool *lookedup)
>>> +int fuse_dentry_revalidate_lookup(struct fuse_mount *fm,
>>> +				  struct dentry *entry,
>>> +				  struct inode *inode,
>>> +				  struct fuse_entry_out *outarg,
>>> +				  bool *lookedup)
>>>    {
>>>    	struct dentry *parent;
>>>    	struct fuse_forget_link *forget;
>>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>>> index 405252bb51f2..a66fcf50a4cc 100644
>>> --- a/fs/fuse/fuse_i.h
>>> +++ b/fs/fuse/fuse_i.h
>>> @@ -1325,6 +1325,12 @@ void fuse_dax_dontcache(struct inode *inode, unsigned int flags);
>>>    bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
>>>    void fuse_dax_cancel_work(struct fuse_conn *fc);
>>> +/* dir.c */
>>> +int fuse_dentry_revalidate_lookup(struct fuse_mount *fm, struct dentry *entry,
>>> +				  struct inode *inode,
>>> +				  struct fuse_entry_out *outarg,
>>> +				  bool *lookedup);
>>> +
>>>    /* ioctl.c */
>>>    long fuse_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
>>>    long fuse_file_compat_ioctl(struct file *file, unsigned int cmd,
>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>> index 444418e240c8..79a31cb55512 100644
>>> --- a/fs/fuse/inode.c
>>> +++ b/fs/fuse/inode.c
>>> @@ -1464,7 +1464,13 @@ static int fuse_fill_super_submount(struct super_block *sb,
>>>    	struct fuse_mount *fm = get_fuse_mount_super(sb);
>>>    	struct super_block *parent_sb = parent_fi->inode.i_sb;
>>>    	struct fuse_attr root_attr;
>>> +	struct fuse_inode *fi;
>>>    	struct inode *root;
>>> +	struct inode *parent;
>>> +	struct dentry *pdent;
>>> +	struct fuse_entry_out outarg;
>>> +	bool lookedup = false;
>>> +	int ret;
>>>    	fuse_sb_defaults(sb);
>>>    	fm->sb = sb;
>>> @@ -1480,14 +1486,39 @@ static int fuse_fill_super_submount(struct super_block *sb,
>>>    	if (parent_sb->s_subtype && !sb->s_subtype)
>>>    		return -ENOMEM;
>>> -	fuse_fill_attr_from_inode(&root_attr, parent_fi);
>>> -	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0);
>>>    	/*
>>> -	 * This inode is just a duplicate, so it is not looked up and
>>> -	 * its nlookup should not be incremented.  fuse_iget() does
>>> -	 * that, though, so undo it here.
>>> +	 * It is necessary to lookup the parent_if->nodeid in case the dentry
>>> +	 * that triggered the automount of the submount is later evicted.
>>> +	 * If this dentry is evicted without the lookup count getting increased
>>> +	 * on the submount root, then the server can subsequently forget this
>>> +	 * nodeid which leads to errors when trying to access the root of the
>>> +	 * submount.
>>>    	 */
>>> -	get_fuse_inode(root)->nlookup--;
>>> +	parent = &parent_fi->inode;
>>> +	pdent = d_find_alias(parent);
>>> +	if (!pdent)
>>> +		return -EINVAL;
>>> +
>>> +	ret = fuse_dentry_revalidate_lookup(fm, pdent, parent, &outarg,
>>> +	    &lookedup);
>>> +	dput(pdent);
>>> +	/*
>>> +	 * The new root owns this nlookup on success, and it is incremented by
>>> +	 * fuse_iget().  In the case the lookup succeeded but revalidate fails,
>>> +	 * ensure that the lookup count is tracked by the parent.
>>> +	 */
>>> +	if (ret <= 0) {
>>> +		if (lookedup) {
>>> +			fi = get_fuse_inode(parent);
>>> +			spin_lock(&fi->lock);
>>> +			fi->nlookup++;
>>> +			spin_unlock(&fi->lock);
>>> +		}
>>
>> I might be wrong, but doesn't that mean that
>> "get_fuse_inode(root)->nlookup--" needs to be called?
> 
> In the case where ret > 0, the nlookup on get_fuse_inode(root) is set to
> 1 by fuse_iget().  That ensures that the root is forgotten when later
> unmounted.  The code that handles the forget uses the count of nlookup
> to tell the server-side how many references to forget.  (That's in
> fuse_evict_inode()).
> 
> However, if the fuse_dentry_revalidate_lookup() call performs a valid
> lookup but returns an error, this function will return before it fills
> out s_root in the superblock or calls fuse_iget().  If the superblock
> doesn't have a s_root set, then the code in generic_kill_super() won't
> dput() the root dentry and trigger the forget.
> 
> The intention of this code was to handle the case where the lookup had
> succeeded, but the code determined it was still necessary to return an
> error.  In that situation, the reference taken by the lookup has to be
> accounted somewhere, and the parent seemed like a plausible candidate.

Yeah sorry, I had just missed that fuse_iget() also moved and then 
thought it would have increased fi->nlookup already.

> 
> However, after writing up this response, I can see that there's still a
> problem here if d_make_root(root) returns NULL, because we'll also lose
> track of the nlookup in that case.
> 
> If you agree that charging this to the parent on error makes sense, I'll
> re-work the error handling here so that the right thing happens when
> either fuse_dentry_revalidate_lookup() or d_make_root() encounter an
> error.

Oh yeah, I also missed that. Although, iput() calls iput_final, which 
then calls evict and sends the fuse forget - isn't that the right action 
already?

> 
> Thanks for the feedback.

Well, false alarm from my side, sorry again!


Bernd
