Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD2B760303
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 01:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjGXXQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 19:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGXXQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:16:18 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1591700;
        Mon, 24 Jul 2023 16:16:14 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 46ACC5C007A;
        Mon, 24 Jul 2023 19:16:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 24 Jul 2023 19:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1690240572; x=1690326972; bh=yQYsb6f3TXQaFHpzPwBQUT2HsaYCaEOi5Gw
        32hKxJA8=; b=kiw5EYlYEliliVaH2uAd5xQgwfk6a0Azwggd5j3wu0jmCLFBkKk
        5ySW3u/M7LH9FEYgIL5Dtgy82t6Q/xCGMtcECOcP8W5zgoyuZoqCO77XPYNcyN0V
        h1GHVhW5zMuprsVdFqQpZeNqUaNU5PwMSFg1w1FV0uxorC5d5y/IKhotD6ZWCkKt
        Q9kdsz08YZHQlqQWM4i/gBrWURqQyiRCeLp1jzz2F1jTpiv8+omRSxH9FREUDjbi
        3mnPSszetZqAPSU3mtDWgOIwLmx+pyGCu7+at6YIF713vOeeR1lPUhA7yO5GAixL
        ITXzLvDISNRT+Puk/rRD1D3jpoiNCg3VDsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690240572; x=1690326972; bh=yQYsb6f3TXQaFHpzPwBQUT2HsaYCaEOi5Gw
        32hKxJA8=; b=zsPsLpfvAQPST8ChJGPYrq9KXVqhncxmJ24BhlCYdlcn4JHnl53
        dnzUUp5kB/H2pDaZ3R2P0hi9XfW+16twhn/L78rc0ja9SOjqbahgpMAyURdg2Rdh
        tZNS86qxqMyAuT+J/WBPrLWwaPuVz/WEAf/PLrVHvBTDx4ejAhL9OZrTimi/1PBA
        DD+fklgtS060ta6onElWYkxeohZzK9R5ui0RBi5iXsvS+DOs9F+dycD7Uq4ggpXP
        1lM7QH7W1J2t7HUdfRhn85+Y0ufRShzk0wFOs6ktBuLPnQMl6dZDFIIbQycUIjOI
        KKaMsh3OI1KG3pe0kGyLjYj6DeIzZQ9ikcw==
X-ME-Sender: <xms:Owa_ZItPz_RhnDXHN0zRpimrOciL1_B4p1qQ0mt-pzPHe_blSAzK7g>
    <xme:Owa_ZFfc1aNcwN_wDuvDa3D4l4eXWhRDBKjXYvxS-jlBY5rM_4hRuKzQS4BYCgXUZ
    nmGCkUjQxhbgMgO>
X-ME-Received: <xmr:Owa_ZDxTmW96cltfkrIMo8dA6oXm0ioLIQzorlrMJybBfeOCILKMD-Frj7dovLC96AoIT_2SO9vrda0wNbb6uIzB6RsEfWseLDbXsrX1gY25RpgGOv2y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheelgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeekheevkeelkeekjefhheegfedtffduudejjeei
    heehudeuleelgefhueekfeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:Owa_ZLPEQ02oXKrOdrF5MCE_VS65kkrNgrih56GKJ0IhM3n0XD8epQ>
    <xmx:Owa_ZI9W25OJ2ilOuHmm7ZwILkOftO-o3D1ybbYqWwvchN0K5gDFeg>
    <xmx:Owa_ZDXx4lIzDzZNkqmMSBc5mqjPNz3fPwlRaSZsYR05vXl_J6DZiA>
    <xmx:PAa_ZHmHiQLegGVzbah0PIilpJ5Fy5opwvUkus15mFuS2q-BT7a9qw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jul 2023 19:16:10 -0400 (EDT)
Message-ID: <6a73a722-6bb5-6462-e7ff-a55866374758@fastmail.fm>
Date:   Tue, 25 Jul 2023 01:16:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 2/2] fuse: ensure that submounts lookup their root
To:     Krister Johansen <kjlx@templeofstupid.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>
References: <cover.1689038902.git.kjlx@templeofstupid.com>
 <69bb95c34deb25f56b3b842528edcb40a098d38d.1689038902.git.kjlx@templeofstupid.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <69bb95c34deb25f56b3b842528edcb40a098d38d.1689038902.git.kjlx@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/11/23 03:37, Krister Johansen wrote:
> Prior to this commit, the submount code assumed that the inode for the
> root filesystem could not be evicted.  When eviction occurs the server
> may forget the inode.  This author has observed a submount get an EBADF
> from a virtiofsd server that resulted from the sole dentry / inode
> pair getting evicted from a mount namespace and superblock where they
> were originally referenced.  The dentry shrinker triggered a forget
> after killing the dentry with the last reference.
> 
> As a result, a container that was also using this submount failed to
> access its filesystem because it had borrowed the reference instead of
> taking its own when setting up its superblock for the submount.
> 
> Fix by ensuring that submount superblock configuration looks up the
> nodeid for the submount as well.
> 
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> ---
>   fs/fuse/dir.c    | 10 +++++-----
>   fs/fuse/fuse_i.h |  6 ++++++
>   fs/fuse/inode.c  | 32 ++++++++++++++++++++++++++++----
>   3 files changed, 39 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index bdf5526a0733..fe6b3fd4a49c 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -193,11 +193,11 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
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
> index 9b7fc7d3c7f1..77b123eddb6d 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1309,6 +1309,12 @@ void fuse_dax_dontcache(struct inode *inode, unsigned int flags);
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
> index f19d748890f0..1032e4b05d9c 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1441,6 +1441,10 @@ static int fuse_fill_super_submount(struct super_block *sb,
>   	struct super_block *parent_sb = parent_fi->inode.i_sb;
>   	struct fuse_attr root_attr;
>   	struct inode *root;
> +	struct inode *parent;
> +	struct dentry *pdent;
> +	bool lookedup = false;
> +	int ret;
>   
>   	fuse_sb_defaults(sb);
>   	fm->sb = sb;
> @@ -1456,14 +1460,34 @@ static int fuse_fill_super_submount(struct super_block *sb,
>   	if (parent_sb->s_subtype && !sb->s_subtype)
>   		return -ENOMEM;
>   
> +	/*
> +	 * It is necessary to lookup the parent_if->nodeid in case the dentry
> +	 * that triggered the automount of the submount is later evicted.
> +	 * If this dentry is evicted without the lookup count getting increased
> +	 * on the submount root, then the server can subsequently forget this
> +	 * nodeid which leads to errors when trying to access the root of the
> +	 * submount.
> +	 */
> +	parent = &parent_fi->inode;
> +	pdent = d_find_alias(parent);
> +	if (pdent) {
> +		struct fuse_entry_out outarg;
> +
> +		ret = fuse_dentry_revalidate_lookup(fm, pdent, parent, &outarg,
> +						    &lookedup);
> +		dput(pdent);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>   	fuse_fill_attr_from_inode(&root_attr, parent_fi);
>   	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0);
>   	/*
> -	 * This inode is just a duplicate, so it is not looked up and
> -	 * its nlookup should not be incremented.  fuse_iget() does
> -	 * that, though, so undo it here.
> +	 * fuse_iget() sets nlookup to 1 at creation time.  If this nodeid was
> +	 * not successfully looked up then decrement the count.
>   	 */
> -	get_fuse_inode(root)->nlookup--;
> +	if (!lookedup)
> +		get_fuse_inode(root)->nlookup--;

How does a submount work with a parent mismatch? I wonder if this 
function should return an error if lookup of the parent failed.


Thanks,
Bernd
