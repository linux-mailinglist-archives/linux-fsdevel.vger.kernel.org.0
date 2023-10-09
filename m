Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17857BE9F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 20:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378055AbjJISnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 14:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377383AbjJISnO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:43:14 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC863A4;
        Mon,  9 Oct 2023 11:43:10 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 19C9232009F4;
        Mon,  9 Oct 2023 14:43:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 09 Oct 2023 14:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1696876986; x=1696963386; bh=08wo/yiv4huBAeHPFlXWe9bp6XF7ZYzn1PL
        Bo0vHCjw=; b=rjlFB8sAlegAwUIMvFi0vbvo3RuAXnONvL5u2gMypdRS+wYx65D
        QzZEuzslVwPVjM3FUHZD4f67Hx/JvbP2YuQB/e+a813PKkS5fAYosUtmI92hB3fV
        l7jQL78KI+HWU7scwFr/RigfS1p1+BOuP22RdLaj5ByR07VencFt01GuhOivr9Xc
        3OGSoTln/5i1M7Wdz3LSysipDsaE62eJxh965ulvVxFwAg4CsXnaqS+E2vdPs93h
        gSsq+UH/H+aJ1UwR9DRazSf2qAflUtJL7RGzYinBUabI238QYd/dVSVVbQ9Fvt0D
        ZR2QiTISmy3/Ck010yUSeCIvoy95geXFOfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696876986; x=1696963386; bh=08wo/yiv4huBAeHPFlXWe9bp6XF7ZYzn1PL
        Bo0vHCjw=; b=mIywZUad3PTt5HzIzz8ngFa2GQYLgkAr5m/qrkkMeii2drPSf71
        qD5QKTtJMn96KsjHBQpktQmffvKkgAg9runXR0HpwU9PTqhquJcG8estp3H9ecnX
        yScVKT7e+wgp292im3jiOuEFU54edRqnO9usMURE8M4Hp/k/SIoy5U/wMqMdpIKF
        YkolwjjDghPCEq9djzBPKCE/ZJxDrMz6tdg9x+g51KyvxipVHBnA9RGXTqf2cqYS
        lGaM+2Tac9MfsN3B5/KwYwJrGa0UO0bvTLTCnSW/Q8+QrqSxmgqgvMYsBSVLPwDz
        Mo1x2O4ILpdprAxl9wSFgFnWUOhnBY8fkTw==
X-ME-Sender: <xms:ukkkZbo0YT894KFy-ZAdjfuuGrqLTDFc_0ur8s-hrcGGbX8AxVNDew>
    <xme:ukkkZVqrMIFnrhSfsHNR7NaLCrju_Ou8uflK4KLqs0Or9uKqaH98JJeQQ4_RY6tbg
    -xORy7fGYp1WYlp>
X-ME-Received: <xmr:ukkkZYMpBLaRy-lXgGLdHAdVD3bcq45cwtohxWKdWHFnXgT4KTMzvLdHrvXJdcllOXt3ZMgWFx00YOIiRjTOrb1vD85KReLXQ2ylitBB_1_bH7DRpvWL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheefgdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:ukkkZe7KuGDItriyRA8z5yBJNwqrxdT0V78ajVIojueuRMBp6_3GhQ>
    <xmx:ukkkZa7_q-gO6KfGJYCx7LxyaVYG-4LZCv2nCrtFR9D7CGuCLkxM1A>
    <xmx:ukkkZWjNQLK-_faODp-CJbPAvo0jji2LscJQkVtXmb8B1BgSlj7vAQ>
    <xmx:ukkkZXs8zSnqs1YiOc0fqrm_MnKnYk39RbL3Vq0A7MZJhaby7uYmlw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Oct 2023 14:43:05 -0400 (EDT)
Message-ID: <f5a431f8-fad9-4b1b-a3ae-86b6cff65b9b@fastmail.fm>
Date:   Mon, 9 Oct 2023 20:43:02 +0200
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
 <968148ad-787e-4ccb-9d84-f32b5da88517@fastmail.fm>
 <20231009171525.GA1973@templeofstupid.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20231009171525.GA1973@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/9/23 19:15, Krister Johansen wrote:
> On Mon, Oct 09, 2023 at 02:52:42PM +0200, Bernd Schubert wrote:
>>
>>
>> On 10/7/23 02:41, Krister Johansen wrote:
>>> On Fri, Oct 06, 2023 at 07:13:06PM +0200, Bernd Schubert wrote:
>>>>
>>>>
>>>> On 10/2/23 17:24, Krister Johansen wrote:
>>>>> The submount code uses the parent nodeid passed into the function in
>>>>> order to create the root dentry for the new submount.  This nodeid does
>>>>> not get its remote reference count incremented by a lookup option.
>>>>>
>>>>> If the parent inode is evicted from its superblock, due to memory
>>>>> pressure for example, it can result in a forget opertation being sent to
>>>>> the server.  Should this nodeid be forgotten while it is still in use in
>>>>> a submount, users of the submount get an error from the server on any
>>>>> subsequent access.  In the author's case, this was an EBADF on all
>>>>> subsequent operations that needed to reference the root.
>>>>>
>>>>> Debugging the problem revealed that the dentry shrinker triggered a forget
>>>>> after killing the dentry with the last reference, despite the root
>>>>> dentry in another superblock still using the nodeid.
>>>>>
>>>>> As a result, a container that was also using this submount failed to
>>>>> access its filesystem because it had borrowed the reference instead of
>>>>> taking its own when setting up its superblock for the submount.
>>>>>
>>>>> This commit fixes the problem by having the new submount trigger a
>>>>> lookup for the parent as part of creating a new root dentry for the
>>>>> virtiofsd submount superblock.  This allows each superblock to have its
>>>>> inodes removed by the shrinker when unreferenced, while keeping the
>>>>> nodeid reference count accurate and active with the server.
>>>>>
>>>>> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
>>>>> ---
>>>>>     fs/fuse/dir.c    | 10 +++++-----
>>>>>     fs/fuse/fuse_i.h |  6 ++++++
>>>>>     fs/fuse/inode.c  | 43 +++++++++++++++++++++++++++++++++++++------
>>>>>     3 files changed, 48 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>>>>> index 5e01946d7531..333730c74619 100644
>>>>> --- a/fs/fuse/dir.c
>>>>> +++ b/fs/fuse/dir.c
>>>>> @@ -183,11 +183,11 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
>>>>>     	args->out_args[0].value = outarg;
>>>>>     }
>>>>> -static int fuse_dentry_revalidate_lookup(struct fuse_mount *fm,
>>>>> -					 struct dentry *entry,
>>>>> -					 struct inode *inode,
>>>>> -					 struct fuse_entry_out *outarg,
>>>>> -					 bool *lookedup)
>>>>> +int fuse_dentry_revalidate_lookup(struct fuse_mount *fm,
>>>>> +				  struct dentry *entry,
>>>>> +				  struct inode *inode,
>>>>> +				  struct fuse_entry_out *outarg,
>>>>> +				  bool *lookedup)
>>>>>     {
>>>>>     	struct dentry *parent;
>>>>>     	struct fuse_forget_link *forget;
>>>>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>>>>> index 405252bb51f2..a66fcf50a4cc 100644
>>>>> --- a/fs/fuse/fuse_i.h
>>>>> +++ b/fs/fuse/fuse_i.h
>>>>> @@ -1325,6 +1325,12 @@ void fuse_dax_dontcache(struct inode *inode, unsigned int flags);
>>>>>     bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
>>>>>     void fuse_dax_cancel_work(struct fuse_conn *fc);
>>>>> +/* dir.c */
>>>>> +int fuse_dentry_revalidate_lookup(struct fuse_mount *fm, struct dentry *entry,
>>>>> +				  struct inode *inode,
>>>>> +				  struct fuse_entry_out *outarg,
>>>>> +				  bool *lookedup);
>>>>> +
>>>>>     /* ioctl.c */
>>>>>     long fuse_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
>>>>>     long fuse_file_compat_ioctl(struct file *file, unsigned int cmd,
>>>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>>>> index 444418e240c8..79a31cb55512 100644
>>>>> --- a/fs/fuse/inode.c
>>>>> +++ b/fs/fuse/inode.c
>>>>> @@ -1464,7 +1464,13 @@ static int fuse_fill_super_submount(struct super_block *sb,
>>>>>     	struct fuse_mount *fm = get_fuse_mount_super(sb);
>>>>>     	struct super_block *parent_sb = parent_fi->inode.i_sb;
>>>>>     	struct fuse_attr root_attr;
>>>>> +	struct fuse_inode *fi;
>>>>>     	struct inode *root;
>>>>> +	struct inode *parent;
>>>>> +	struct dentry *pdent;
>>>>> +	struct fuse_entry_out outarg;
>>>>> +	bool lookedup = false;
>>>>> +	int ret;
>>>>>     	fuse_sb_defaults(sb);
>>>>>     	fm->sb = sb;
>>>>> @@ -1480,14 +1486,39 @@ static int fuse_fill_super_submount(struct super_block *sb,
>>>>>     	if (parent_sb->s_subtype && !sb->s_subtype)
>>>>>     		return -ENOMEM;
>>>>> -	fuse_fill_attr_from_inode(&root_attr, parent_fi);
>>>>> -	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0);
>>>>>     	/*
>>>>> -	 * This inode is just a duplicate, so it is not looked up and
>>>>> -	 * its nlookup should not be incremented.  fuse_iget() does
>>>>> -	 * that, though, so undo it here.
>>>>> +	 * It is necessary to lookup the parent_if->nodeid in case the dentry
>>>>> +	 * that triggered the automount of the submount is later evicted.
>>>>> +	 * If this dentry is evicted without the lookup count getting increased
>>>>> +	 * on the submount root, then the server can subsequently forget this
>>>>> +	 * nodeid which leads to errors when trying to access the root of the
>>>>> +	 * submount.
>>>>>     	 */
>>>>> -	get_fuse_inode(root)->nlookup--;
>>>>> +	parent = &parent_fi->inode;
>>>>> +	pdent = d_find_alias(parent);
>>>>> +	if (!pdent)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	ret = fuse_dentry_revalidate_lookup(fm, pdent, parent, &outarg,
>>>>> +	    &lookedup);
>>>>> +	dput(pdent);
>>>>> +	/*
>>>>> +	 * The new root owns this nlookup on success, and it is incremented by
>>>>> +	 * fuse_iget().  In the case the lookup succeeded but revalidate fails,
>>>>> +	 * ensure that the lookup count is tracked by the parent.
>>>>> +	 */
>>>>> +	if (ret <= 0) {
>>>>> +		if (lookedup) {
>>>>> +			fi = get_fuse_inode(parent);
>>>>> +			spin_lock(&fi->lock);
>>>>> +			fi->nlookup++;
>>>>> +			spin_unlock(&fi->lock);
>>>>> +		}
>>>>
>>>> I might be wrong, but doesn't that mean that
>>>> "get_fuse_inode(root)->nlookup--" needs to be called?
>>>
>>> In the case where ret > 0, the nlookup on get_fuse_inode(root) is set to
>>> 1 by fuse_iget().  That ensures that the root is forgotten when later
>>> unmounted.  The code that handles the forget uses the count of nlookup
>>> to tell the server-side how many references to forget.  (That's in
>>> fuse_evict_inode()).
>>>
>>> However, if the fuse_dentry_revalidate_lookup() call performs a valid
>>> lookup but returns an error, this function will return before it fills
>>> out s_root in the superblock or calls fuse_iget().  If the superblock
>>> doesn't have a s_root set, then the code in generic_kill_super() won't
>>> dput() the root dentry and trigger the forget.
>>>
>>> The intention of this code was to handle the case where the lookup had
>>> succeeded, but the code determined it was still necessary to return an
>>> error.  In that situation, the reference taken by the lookup has to be
>>> accounted somewhere, and the parent seemed like a plausible candidate.
>>
>> Yeah sorry, I had just missed that fuse_iget() also moved and then thought
>> it would have increased fi->nlookup already.
> 
> No worries; I'd much rather get feedback if something doesn't look
> right, even if it turns out okay in the end.
> 
>>> However, after writing up this response, I can see that there's still a
>>> problem here if d_make_root(root) returns NULL, because we'll also lose
>>> track of the nlookup in that case.
>>>
>>> If you agree that charging this to the parent on error makes sense, I'll
>>> re-work the error handling here so that the right thing happens when
>>> either fuse_dentry_revalidate_lookup() or d_make_root() encounter an
>>> error.
>>
>> Oh yeah, I also missed that. Although, iput() calls iput_final, which then
>> calls evict and sends the fuse forget - isn't that the right action already?
> 
> Thanks, I had forgotten that d_make_root() would call iput() for me if
> d_alloc_anon() fails.  Let me restate this to suggest that I account the
> nlookup to the parent if fuse_dentry_revalidate_lookup() or fuse_iget()
> fail instead.  Does that sound right?

Hmm, so server/daemon side uses the lookup count to have an inode 
reference - are you sure that parent is the right inode for the forget 
call? And what is the probability for such failures? I.e. is that 
performance critical? Wouldn't be much simpler and clearer to just avoid 
and doubt and to send an immediate forget?


Thanks,
Bernd
