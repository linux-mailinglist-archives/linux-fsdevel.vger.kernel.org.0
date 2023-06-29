Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2CD742B11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 19:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjF2RNP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 13:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjF2RNN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:13:13 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731593595
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 10:13:12 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D817E5C02EC;
        Thu, 29 Jun 2023 13:13:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 29 Jun 2023 13:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1688058791; x=1688145191; bh=a22mgjLBmXlIMbp14+vdOPZHk1sePLEC0De
        5lXjKr6s=; b=ca3Q9X3/uxwK3sZ2ZmvBqa3AOJTGhZSXSruJb5hKpmHew2sdvh0
        ZVql5fO5z5br7AVxip+6D+lRsvR2SUU2afIeKpmAooewFlM+s1dNoZJ+qReuI0H6
        O4JyCEYGDbNAxvv/o2ux4Iaa+6n9RRDQC+ChNlYKpinLXZ2Kir+YXNqm/ii78IXE
        glhCnsIE9ZB0eZBZIVvr7+GZsauL/KLhNVGGensij7GyA1FBYShmGDKDe7RY5ah2
        D0lb/Q9/LHqqVi41kG9qsjWCcNCj5l9uoAHfk2cZXjMkEkNYYisgiPgIUCtAIxFU
        czd6ZxW5zKoq6AtjZWF+LUuiR74iQyXZLig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688058791; x=1688145191; bh=a22mgjLBmXlIMbp14+vdOPZHk1sePLEC0De
        5lXjKr6s=; b=ZlZaxNStotDHNucliwBA8Z2pGqH0u6H3wZb9t9vpqyqCVAEVnnm
        KT7GHhZ/1fmL405IwpdEULvQAd28n/TwFCGMHIU+s9OOKBqDReEaQWfootESnk+U
        YX4Wjo5cxHUM8D/dTfKWEdqvxcmEXTgcJtkolm+S8IAWT8O3zbg19sgf4u28wZQG
        fcCBlhrNVqQ62BpEDwK4Gpk1Ev8se9kCRldnjA9dYTv5CbLH6asSXbDwQQObI1lp
        mJlrtEN/H8bYBDJZaRnmLsYwaKr2zi2g7LjEYfIuaFRmyIMgyS2x9etbkV25haco
        BXxBkjb5p+14m2fQXuwoi+SMbihOf2TztJw==
X-ME-Sender: <xms:prudZHhf7uyEbj92JABDT6rNQgMmURu7xRo31f16OLMvd17P3TouTA>
    <xme:prudZECS2mXJsPDGOuR3o0WIRsbLD1Jp1TgAUMszBtLB0_9fR-Tx5pXkHIl9J6yl4
    2kVB1S3ybTTte49>
X-ME-Received: <xmr:prudZHEd1gcRwgq-jWe0dSXT2wMEAjbLDlssD6Ff7cbGP1E4nHduvPMPl8ma92fPp1EarLnc3PBUmSpJWcE1qlL_BjcDKi9STghxSOf1wS2G2-xfymCe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeggdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:prudZER7rRu48TnXVWHfn97Q4bdppVA4pW95yBSVRP-2YeCMoc7I0g>
    <xmx:prudZExYkHxqGrzOGmMxEADj0vE1ipy_e4G-v-C03Y_oAfgV3Gi4jg>
    <xmx:prudZK58wIc8RTSt69bvxVcbYod6R6C3JC_J37WEX9k7-7iXRykoFQ>
    <xmx:p7udZOvhoXjQHSPbxGvzVkaCw5K3lQJsJjR1RvP16RyIk4RTS7TuDg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jun 2023 13:13:10 -0400 (EDT)
Message-ID: <1f0bf6c6-eac8-1a13-17b2-48cec5e991e2@fastmail.fm>
Date:   Thu, 29 Jun 2023 19:13:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [fuse-devel] [PATCH v2] fuse: add a new fuse init flag to relax
 restrictions in no cache mode
Content-Language: en-US, de-DE
To:     Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        cgxu519@mykernel.net, miklos@szeredi.hu
References: <20230629081733.11309-1-hao.xu@linux.dev>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230629081733.11309-1-hao.xu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/29/23 10:17, Hao Xu wrote:
> From: Hao Xu <howeyxu@tencent.com>
> 
> FOPEN_DIRECT_IO is usually set by fuse daemon to indicate need of strong
> coherency, e.g. network filesystems. Thus shared mmap is disabled since
> it leverages page cache and may write to it, which may cause
> inconsistence. But FOPEN_DIRECT_IO can be used not for coherency but to
> reduce memory footprint as well, e.g. reduce guest memory usage with
> virtiofs. Therefore, add a new fuse init flag FUSE_DIRECT_IO_RELAX to
> relax restrictions in that mode, currently, it allows shared mmap.
> One thing to note is to make sure it doesn't break coherency in your
> use case.
> 
> Signed-off-by: Hao Xu <howeyxu@tencent.com>
> ---
> 
> v1 -> v2:
>      make the new flag a fuse init one rather than a open flag since it's
>      not common that different files in a filesystem has different
>      strategy of shared mmap.
> 
>   fs/fuse/file.c            | 8 ++++++--
>   fs/fuse/fuse_i.h          | 3 +++
>   fs/fuse/inode.c           | 5 ++++-
>   include/uapi/linux/fuse.h | 1 +
>   4 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index bc4115288eec..871b66b54322 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2478,14 +2478,18 @@ static const struct vm_operations_struct fuse_file_vm_ops = {
>   static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
>   {
>   	struct fuse_file *ff = file->private_data;
> +	struct fuse_conn *fc = ff->fm->fc;
>   
>   	/* DAX mmap is superior to direct_io mmap */
>   	if (FUSE_IS_DAX(file_inode(file)))
>   		return fuse_dax_mmap(file, vma);
>   
>   	if (ff->open_flags & FOPEN_DIRECT_IO) {
> -		/* Can't provide the coherency needed for MAP_SHARED */
> -		if (vma->vm_flags & VM_MAYSHARE)
> +		/* Can't provide the coherency needed for MAP_SHARED
> +		 * if FUSE_DIRECT_IO_RELAX isn't set.
> +		 */
> +		if (!(ff->open_flags & fc->direct_io_relax) &&
> +		    vma->vm_flags & VM_MAYSHARE)
>   			return -ENODEV;

I'm confused here, the idea was that open_flags do not need additional 
flags? Why is this not just

if (ff->open_flags & FOPEN_DIRECT_IO) {
		/* Can't provide the coherency needed for MAP_SHARED */
		if (vma->vm_flags & VM_MAYSHARE && !fc->direct_io_relax)
			return -ENODEV;


>   
>   		invalidate_inode_pages2(file->f_mapping);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 9b7fc7d3c7f1..d830c2360aef 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -792,6 +792,9 @@ struct fuse_conn {
>   	/* Is tmpfile not implemented by fs? */
>   	unsigned int no_tmpfile:1;
>   
> +	/* relax restrictions in FOPEN_DIRECT_IO mode */
> +	unsigned int direct_io_relax:1;
> +
>   	/** The number of requests waiting for completion */
>   	atomic_t num_waiting;
>   
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index d66070af145d..049f9ee547d5 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1209,6 +1209,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>   				fc->init_security = 1;
>   			if (flags & FUSE_CREATE_SUPP_GROUP)
>   				fc->create_supp_group = 1;
> +
> +			if (flags & FUSE_DIRECT_IO_RELAX)
> +				fc->direct_io_relax = 1;
>   		} else {
>   			ra_pages = fc->max_read / PAGE_SIZE;
>   			fc->no_lock = 1;
> @@ -1254,7 +1257,7 @@ void fuse_send_init(struct fuse_mount *fm)
>   		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
>   		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
>   		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
> -		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP;
> +		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP | FUSE_DIRECT_IO_RELAX;
>   #ifdef CONFIG_FUSE_DAX
>   	if (fm->fc->dax)
>   		flags |= FUSE_MAP_ALIGNMENT;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 1b9d0dfae72d..2da2acec6bf4 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -406,6 +406,7 @@ struct fuse_file_lock {
>   #define FUSE_SECURITY_CTX	(1ULL << 32)
>   #define FUSE_HAS_INODE_DAX	(1ULL << 33)
>   #define FUSE_CREATE_SUPP_GROUP	(1ULL << 34)
> +#define FUSE_DIRECT_IO_RELAX	(1ULL << 35)
>   
>   /**
>    * CUSE INIT request/reply flags


Thanks,
Bernd
