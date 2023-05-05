Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B8F6F84ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 16:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjEEOjW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 10:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjEEOjT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 10:39:19 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30983C38
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 07:39:17 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 78CE85C0313;
        Fri,  5 May 2023 10:39:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 05 May 2023 10:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1683297555; x=1683383955; bh=wVa/J106VvsZqfC08p7UYupOdc0cKf0b/WA
        ttADbguk=; b=M0RIXS2xW9Nn6GB5oZlJI80LIN4xOMMfdmWjXLGaZfZGcBmY0fE
        6a0F8UENNBmpcCNbDtgAux3GSQtBcRbX1bPsVAbnUOwaE3DdUok0TWTnleEKRK+Y
        hfxMOBlkuB8fKeLBUca4971lBKjuuxo8xwUFutyS7+ROlkpHWdX9/iWG9xrkU6uC
        XAgoMGKFyvr2b37uNjPF3D3jeBnUZGorZcNlzh9Gwzj09ffOO5Jn/V4Bg5dLcodL
        rInlI7UWLCT1LmAm1zUwkRxZ832ETmysUPYzAMi8+Tfy+6CaUoGFPjnt+axed7J1
        WUOUkGvpUI7NuZwpmYw3eS0BfIWAnNMSY6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683297555; x=1683383955; bh=wVa/J106VvsZqfC08p7UYupOdc0cKf0b/WA
        ttADbguk=; b=H2tguZ6I15X6RnWajp1sgGL1uZBS9i+oOv1a2VnpIldu8fKDZ7P
        bmxe6wWGFC0pFKDQXSlJVb7AtR/NASy1ScWLWH5zPnssV7hoqmJJWMfXjZBMFV5X
        tmi534YVD4l80mLsLl+6pP36kDwXe9sUj/4v35Es84y24PWHMCo7ovOtmUre8cRi
        MDQzsdAMHk6anIWlHaKvX3CgkfDgyNXrLx6jY7M567T1jJ7EXNpeEX+GaaFpJ8Y9
        K/Qm9SaZkz6K1sdxR1VHudNUDhnSl+/m1Gjr+ilCXlUzEYQ/8kfOzCZr34+oKY3R
        gGqDf1oDd+Upy8jv6D1fetlz8+YNHzWvGTA==
X-ME-Sender: <xms:ExVVZOZphQgOnovgAX5FyR8nA-1rhaGYEe5-OuLS4q5Rvlr4iZZFTQ>
    <xme:ExVVZBbX8NlGUrOMzfh6Q1vT7AHSfAfxDeDVHuvToavssAqXIfdWAzaDb0QeMKJsn
    SyAMkJVhXTnoSef>
X-ME-Received: <xmr:ExVVZI-wcYBNzbJiSXeEnYE-bHaD9ZQ4Jyg-dt0hFhAaOsDkeWEc7OLw_DDfppGlKyIBhXwmmcDsB_VlpCiX5MXJY549uSuYmeD_JZLQRWKmCYGUJ2na>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefvddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:ExVVZAoTwN9G_0CWNVkMQ-EQP_MhOA4XZyqROsAwjSjb_okw3rEY4w>
    <xmx:ExVVZJrbXkvhF1rH_kTSFoZxxCu6pyN3qdRnbYuzaRns0Mz4uUth4Q>
    <xmx:ExVVZOR4js9FjvfIzJmvaYTwOCxgEfP_SILTOlRWT59ZhzmzK106Tw>
    <xmx:ExVVZA0CrMGzYxVyjrGHa9CiKlyl0StX8O9EhMf-xagT64Vbj_QNyg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 10:39:14 -0400 (EDT)
Message-ID: <fc6fe539-64ae-aa35-8b6e-3b22e07af31f@fastmail.fm>
Date:   Fri, 5 May 2023 16:39:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [fuse-devel] [PATCH] fuse: add a new flag to allow shared mmap in
 FOPEN_DIRECT_IO mode
To:     Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
References: <20230505081652.43008-1-hao.xu@linux.dev>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230505081652.43008-1-hao.xu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/5/23 10:16, Hao Xu wrote:
> From: Hao Xu <howeyxu@tencent.com>
> 
> FOPEN_DIRECT_IO is usually set by fuse daemon to indicate need of strong
> coherency, e.g. network filesystems. Thus shared mmap is disabled since
> it leverages page cache and may write to it, which may cause
> inconsistence. But FOPEN_DIRECT_IO can be used not for coherency but to
> reduce memory footprint as well, e.g. reduce guest memory usage with
> virtiofs. Therefore, add a new flag FOPEN_DIRECT_IO_SHARED_MMAP to allow
> shared mmap for these cases.
> 
> Signed-off-by: Hao Xu <howeyxu@tencent.com>
> ---
>   fs/fuse/file.c            | 11 ++++++++---
>   include/uapi/linux/fuse.h |  2 ++
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 89d97f6188e0..655896bdb0d5 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -161,7 +161,8 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
>   	}
>   
>   	if (isdir)
> -		ff->open_flags &= ~FOPEN_DIRECT_IO;
> +		ff->open_flags &=
> +			~(FOPEN_DIRECT_IO | FOPEN_DIRECT_IO_SHARED_MMAP);
>   
>   	ff->nodeid = nodeid;
>   
> @@ -2509,8 +2510,12 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
>   		return fuse_dax_mmap(file, vma);
>   
>   	if (ff->open_flags & FOPEN_DIRECT_IO) {
> -		/* Can't provide the coherency needed for MAP_SHARED */
> -		if (vma->vm_flags & VM_MAYSHARE)
> +		/* Can't provide the coherency needed for MAP_SHARED.
> +		 * So disable it if FOPEN_DIRECT_IO_SHARED_MMAP is not
> +		 * set, which means we do need strong coherency.
> +		 */
> +		if (!(ff->open_flags & FOPEN_DIRECT_IO_SHARED_MMAP) &&
> +		    vma->vm_flags & VM_MAYSHARE)
>   			return -ENODEV;
>   
>   		invalidate_inode_pages2(file->f_mapping);
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 1b9d0dfae72d..003dcf42e8c2 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -314,6 +314,7 @@ struct fuse_file_lock {
>    * FOPEN_STREAM: the file is stream-like (no file position at all)
>    * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
>    * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
> + * FOPEN_DIRECT_IO_SHARED_MMAP: allow shared mmap when FOPEN_DIRECT_IO is set
>    */
>   #define FOPEN_DIRECT_IO		(1 << 0)
>   #define FOPEN_KEEP_CACHE	(1 << 1)
> @@ -322,6 +323,7 @@ struct fuse_file_lock {
>   #define FOPEN_STREAM		(1 << 4)
>   #define FOPEN_NOFLUSH		(1 << 5)
>   #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
> +#define FOPEN_DIRECT_IO_SHARED_MMAP	(1 << 7)

Thanks, that is what I had in my mind as well.

I don't have a strong opinion on it (so don't change it before Miklos 
commented), but maybe FOPEN_DIRECT_IO_WEAK? Just in case there would be 
later on other conditions that need to be weakened? The comment would 
say then something like
"Weakens FOPEN_DIRECT_IO enforcement, allows MAP_SHARED mmap"

Thanks,
Bernd

