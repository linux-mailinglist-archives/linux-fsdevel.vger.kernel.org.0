Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B1A7BBD7E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 19:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjJFRNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 13:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjJFRNP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:13:15 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC16C6;
        Fri,  6 Oct 2023 10:13:13 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0861C5C01C0;
        Fri,  6 Oct 2023 13:13:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 06 Oct 2023 13:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1696612390; x=1696698790; bh=JF4wG8A2t5G+ITf2U56/dMEDNhUNDLpZEkl
        GA4HLqXU=; b=UcDt2nFfA56+MlTcoDJAy88bJLWGQKzCg3e2c2FfhXtkprzHEY4
        dqclxoudNmxM3Vdzx/12y0cd5ioEVe5PaGLXmQ7ApOrBuIfuP6XMfM6qEpGmU2U+
        TbU/B+/0VpuIB2E1OBe7tELPfSdFxI802g2t5QJRE0Yn4qIXynSIJonGUm7HH5pk
        mTD9wtT8VUSYxWZtF7N17DTyjCad55ao0Pd1yrhfi4v6fC3dEXbok8AMhVSThLiY
        WpGNULYvCWAiepVdXtyrQyq/o4rrlddKWofoRW9xrqt6ssywAbzqk4C0zBfoOfU3
        DfeKht5b61nMcqoqDQKLdtwccsARbhP3myQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696612390; x=1696698790; bh=JF4wG8A2t5G+ITf2U56/dMEDNhUNDLpZEkl
        GA4HLqXU=; b=f/0lXuZUHICPQE4jyYPdyqRPSTXNGjn5B3zc1d/ICr2Lb18mdah
        lIWoErD2FOJrd3ZIMh6jZD3/8lTJmYQTaR3E+51BhogSCcEenRc4jBYEqzh4BMMh
        5r3dVkSuV8yWACnP9KIBeJPkTRwY0tsP0PPmTkMukvl0zX3/savlO98OHHhZITLF
        g0NkiyAFNmXv1/sWtN1uoAg5TqB18s25Vc8NUuzVNjWF2QW5ANkdDhplZKTetOLk
        W+wEGtYamnTqAx++dmrvOsep08LS1cZzB3DLBuAuv6Fev5nTdpJGPMRKqiThHknX
        lxG8yyodisZ0qC1pROoWUMss41vJKbdWGhA==
X-ME-Sender: <xms:JUAgZWi0Tp_egRRchP3S7588c9UKFMf_oyZVB9zak9dPbSnlumg7KA>
    <xme:JUAgZXBcblKnsa7c9ar5xthyLicW81kaqlPhhKzuM5JZE0U_TauVhzIz5lZsLfmQg
    X_hOcYiXATW5ZAk>
X-ME-Received: <xmr:JUAgZeFTqo4khOPK2MBCdvfCVN-9ADuT0Hqxw2z3z7Z8AovjSxYhU-NcJ84_sHuwiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeigddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:JUAgZfRIMXzWqCh6R2zPr4YtSKoSrfrCJBn020Q6c86qVYE7RqRHuw>
    <xmx:JUAgZTwMuz1DLwmBu3XrnlC29G1ZY2MMiuEjNWNte_g-wGufTULKdw>
    <xmx:JUAgZd652CVAyL1NhRaPMxQCTt5LR-zp6H6NfNY2woX3E1NYiDqSsw>
    <xmx:JkAgZakD8npwuqwOfW802nw0BHnhDAfTIm83WaNVelddLcwepUcc4g>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Oct 2023 13:13:08 -0400 (EDT)
Message-ID: <3187f942-dcf0-4b2f-a106-0eb5d5a33949@fastmail.fm>
Date:   Fri, 6 Oct 2023 19:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [resend PATCH v2 2/2] fuse: ensure that submounts lookup their
 parent
Content-Language: en-US
To:     Krister Johansen <kjlx@templeofstupid.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>
References: <cover.1696043833.git.kjlx@templeofstupid.com>
 <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/2/23 17:24, Krister Johansen wrote:
> The submount code uses the parent nodeid passed into the function in
> order to create the root dentry for the new submount.  This nodeid does
> not get its remote reference count incremented by a lookup option.
> 
> If the parent inode is evicted from its superblock, due to memory
> pressure for example, it can result in a forget opertation being sent to
> the server.  Should this nodeid be forgotten while it is still in use in
> a submount, users of the submount get an error from the server on any
> subsequent access.  In the author's case, this was an EBADF on all
> subsequent operations that needed to reference the root.
> 
> Debugging the problem revealed that the dentry shrinker triggered a forget
> after killing the dentry with the last reference, despite the root
> dentry in another superblock still using the nodeid.
> 
> As a result, a container that was also using this submount failed to
> access its filesystem because it had borrowed the reference instead of
> taking its own when setting up its superblock for the submount.
> 
> This commit fixes the problem by having the new submount trigger a
> lookup for the parent as part of creating a new root dentry for the
> virtiofsd submount superblock.  This allows each superblock to have its
> inodes removed by the shrinker when unreferenced, while keeping the
> nodeid reference count accurate and active with the server.
> 
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> ---
>   fs/fuse/dir.c    | 10 +++++-----
>   fs/fuse/fuse_i.h |  6 ++++++
>   fs/fuse/inode.c  | 43 +++++++++++++++++++++++++++++++++++++------
>   3 files changed, 48 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 5e01946d7531..333730c74619 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -183,11 +183,11 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
>   	args->out_args[0].value = outarg;
>   }
>   
> -static int fuse_dentry_revalidate_lookup(struct fuse_mount *fm,
> -					 struct dentry *entry,
> -					 struct inode *inode,
> -					 struct fuse_entry_out *outarg,
> -					 bool *lookedup)
> +int fuse_dentry_revalidate_lookup(struct fuse_mount *fm,
> +				  struct dentry *entry,
> +				  struct inode *inode,
> +				  struct fuse_entry_out *outarg,
> +				  bool *lookedup)
>   {
>   	struct dentry *parent;
>   	struct fuse_forget_link *forget;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 405252bb51f2..a66fcf50a4cc 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1325,6 +1325,12 @@ void fuse_dax_dontcache(struct inode *inode, unsigned int flags);
>   bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
>   void fuse_dax_cancel_work(struct fuse_conn *fc);
>   
> +/* dir.c */
> +int fuse_dentry_revalidate_lookup(struct fuse_mount *fm, struct dentry *entry,
> +				  struct inode *inode,
> +				  struct fuse_entry_out *outarg,
> +				  bool *lookedup);
> +
>   /* ioctl.c */
>   long fuse_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
>   long fuse_file_compat_ioctl(struct file *file, unsigned int cmd,
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 444418e240c8..79a31cb55512 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1464,7 +1464,13 @@ static int fuse_fill_super_submount(struct super_block *sb,
>   	struct fuse_mount *fm = get_fuse_mount_super(sb);
>   	struct super_block *parent_sb = parent_fi->inode.i_sb;
>   	struct fuse_attr root_attr;
> +	struct fuse_inode *fi;
>   	struct inode *root;
> +	struct inode *parent;
> +	struct dentry *pdent;
> +	struct fuse_entry_out outarg;
> +	bool lookedup = false;
> +	int ret;
>   
>   	fuse_sb_defaults(sb);
>   	fm->sb = sb;
> @@ -1480,14 +1486,39 @@ static int fuse_fill_super_submount(struct super_block *sb,
>   	if (parent_sb->s_subtype && !sb->s_subtype)
>   		return -ENOMEM;
>   
> -	fuse_fill_attr_from_inode(&root_attr, parent_fi);
> -	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0);
>   	/*
> -	 * This inode is just a duplicate, so it is not looked up and
> -	 * its nlookup should not be incremented.  fuse_iget() does
> -	 * that, though, so undo it here.
> +	 * It is necessary to lookup the parent_if->nodeid in case the dentry
> +	 * that triggered the automount of the submount is later evicted.
> +	 * If this dentry is evicted without the lookup count getting increased
> +	 * on the submount root, then the server can subsequently forget this
> +	 * nodeid which leads to errors when trying to access the root of the
> +	 * submount.
>   	 */
> -	get_fuse_inode(root)->nlookup--;
> +	parent = &parent_fi->inode;
> +	pdent = d_find_alias(parent);
> +	if (!pdent)
> +		return -EINVAL;
> +
> +	ret = fuse_dentry_revalidate_lookup(fm, pdent, parent, &outarg,
> +	    &lookedup);
> +	dput(pdent);
> +	/*
> +	 * The new root owns this nlookup on success, and it is incremented by
> +	 * fuse_iget().  In the case the lookup succeeded but revalidate fails,
> +	 * ensure that the lookup count is tracked by the parent.
> +	 */
> +	if (ret <= 0) {
> +		if (lookedup) {
> +			fi = get_fuse_inode(parent);
> +			spin_lock(&fi->lock);
> +			fi->nlookup++;
> +			spin_unlock(&fi->lock);
> +		}

I might be wrong, but doesn't that mean that 
"get_fuse_inode(root)->nlookup--" needs to be called?



Thanks,
Bernd
