Return-Path: <linux-fsdevel+bounces-7609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B06E8286E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 14:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79D4282B6B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 13:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3801C38F95;
	Tue,  9 Jan 2024 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="X8Vb15PX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5CO2jxrk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B702D621;
	Tue,  9 Jan 2024 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id EF8C432004AE;
	Tue,  9 Jan 2024 08:12:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 09 Jan 2024 08:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1704805922;
	 x=1704892322; bh=VM2pbmFsilZIz7Bfq/RLLHqcIAJ63YE0r1M21zIz0TM=; b=
	X8Vb15PX9N14+iATt/OvCwUce1t+nhTx0uzQI+TFHYusnerwYAvsSGY3RPOLD178
	BGYLVADvWxaUYXuzxrjeK/gxfPezoqQuzWMhwAs2TyVczp9eHeGfebL95DCi0ZZK
	1A8XSGkhYNOBkcvAeCXIR0aJla7RWdWeYeDcjtAgW24wkq1Ts5R4aIC0TRSs9MkC
	9jfWkxOWaorytRuHUUG5X9OFY4X6HqQjyOxIQs0b2EZ8BIQ7UATh81WxMBWIO+A/
	8r4VxCuwwpwpCWebbhB/I6JzC51CVL+I3z7+YFRLWEIQ6s0uNlJkiPh2jyVIhyZ4
	o6MdxOHfbT88UMRuzMuRzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704805922; x=
	1704892322; bh=VM2pbmFsilZIz7Bfq/RLLHqcIAJ63YE0r1M21zIz0TM=; b=5
	CO2jxrkqAg+1kUcS2nD9qP1xi+OqxwP6fHcGxfN3SowlKABdcErAdlcz9XnL6NHR
	pBN82LNv8o/3d8DYtDATbZjdZ9G7Y0SHtFG/W84hj7HzJlNCjhLWWXn0Lw8jig37
	DVDsGW4PPRlzZou88G43F6yMyWSolP1PYu9wIEJzYw5i1sH4G6yv020mkq1PwTOS
	emKTPMOxsNL4rzuax9i1PJlWX5h2KHRyWQRnq9FkIH1a4o5JIs3UorahbH1EsEIR
	l0WWpN7qGnd8V1PHztjKXq3iZ2lA9Nzm+7vIiSUMCUhElf95J5XL6AlqyqbAStL3
	Wti3KxZmRCwlLqDT/Gpzw==
X-ME-Sender: <xms:IUadZaCAdX4_NH-JgO1zxn-C0uIAvZFe8s1yZ9rAmLibOkaBuLtjhw>
    <xme:IUadZUigDQWkEJgSq4nNkRgBuY4jji9R0K9r1rTF9o70gviyT6ZcN3B9QfHtPHjYz
    8zOeLXcyE7rfryN>
X-ME-Received: <xmr:IUadZdlGjo7r2AVy56i2C-4OEYSuPpEAQchJV-qoujoaF3bmDwgWq7CpVC05V5NAPoRB4q03rLr8YN5NaTrXP8Z4rjpxOnOP5gydUUbbfFpeyu-Uqgaa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehledggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:IUadZYyMKklQkpyB_9EIAc1hwVf0Z67LgiBCyZkXwyAaZ6eGExQ61g>
    <xmx:IUadZfRjt5ZX2CKZfDatacJvZWaJN2LG5VhjHtIMfZVWejD5Fu2-sA>
    <xmx:IUadZTZjuS3HA1xdLqoOdkC2dmJUA2FwJrQ_Z509gTQkZKueYsmNcg>
    <xmx:IkadZYTMv_ZoB13zo4Tc7gOTZE5l3CkwTNZxMcDObjXdM1HLsFZqWw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jan 2024 08:12:00 -0500 (EST)
Message-ID: <b6c0d521-bba8-447f-b114-0a679ca89e4b@fastmail.fm>
Date: Tue, 9 Jan 2024 14:11:58 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtiofs: limit the length of ITER_KVEC dio by
 max_nopage_rw
To: Hou Tao <houtao@huaweicloud.com>, linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, houtao1@huawei.com
References: <20240103105929.1902658-1-houtao@huaweicloud.com>
Content-Language: en-US, de-DE, fr
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20240103105929.1902658-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/3/24 11:59, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When trying to insert a 10MB kernel module kept in a virtiofs with cache
> disabled, the following warning was reported:
> 
>    ------------[ cut here ]------------
>    WARNING: CPU: 2 PID: 439 at mm/page_alloc.c:4544 ......
>    Modules linked in:
>    CPU: 2 PID: 439 Comm: insmod Not tainted 6.7.0-rc7+ #33
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ......
>    RIP: 0010:__alloc_pages+0x2c4/0x360
>    ......
>    Call Trace:
>     <TASK>
>     ? __warn+0x8f/0x150
>     ? __alloc_pages+0x2c4/0x360
>     __kmalloc_large_node+0x86/0x160
>     __kmalloc+0xcd/0x140
>     virtio_fs_enqueue_req+0x240/0x6d0
>     virtio_fs_wake_pending_and_unlock+0x7f/0x190
>     queue_request_and_unlock+0x58/0x70
>     fuse_simple_request+0x18b/0x2e0
>     fuse_direct_io+0x58a/0x850
>     fuse_file_read_iter+0xdb/0x130
>     __kernel_read+0xf3/0x260
>     kernel_read+0x45/0x60
>     kernel_read_file+0x1ad/0x2b0
>     init_module_from_file+0x6a/0xe0
>     idempotent_init_module+0x179/0x230
>     __x64_sys_finit_module+0x5d/0xb0
>     do_syscall_64+0x36/0xb0
>     entry_SYSCALL_64_after_hwframe+0x6e/0x76
>     ......
>     </TASK>
>    ---[ end trace 0000000000000000 ]---
> 
> The warning happened as follow. In copy_args_to_argbuf(), virtiofs uses
> kmalloc-ed memory as bound buffer for fuse args, but
> fuse_get_user_pages() only limits the length of fuse arg by max_read or
> max_write for IOV_KVEC io (e.g., kernel_read_file from finit_module()).
> For virtiofs, max_read is UINT_MAX, so a big read request which is about


I find this part of the explanation a bit confusing. I guess you wanted 
to write something like

fuse_direct_io() -> fuse_get_user_pages() is limited by 
fc->max_write/fc->max_read and fc->max_pages. For virtiofs max_pages 
does not apply as ITER_KVEC is used. As virtiofs sets fc->max_read to 
UINT_MAX basically no limit is applied at all.

I also wonder if it wouldn't it make sense to set a sensible limit in
virtio_fs_ctx_set_defaults() instead of introducing a new variable?

Also, I guess the issue is kmalloc_array() in virtio_fs_enqueue_req? 
Wouldn't it make sense to use kvm_alloc_array/kvfree in that function?


Thanks,
Bernd


> 10MB is passed to copy_args_to_argbuf(), kmalloc() is called in turn
> with len=10MB, and triggers the warning in __alloc_pages():
> WARN_ON_ONCE_GFP(order > MAX_ORDER, gfp)).
> 
> A feasible solution is to limit the value of max_read for virtiofs, so
> the length passed to kmalloc() will be limited. However it will affects
> the max read size for ITER_IOVEC io and the value of max_write also needs
> limitation. So instead of limiting the values of max_read and max_write,
> introducing max_nopage_rw to cap both the values of max_read and
> max_write when the fuse dio read/write request is initiated from kernel.
> 
> Considering that fuse read/write request from kernel is uncommon and to
> decrease the demand for large contiguous pages, set max_nopage_rw as
> 256KB instead of KMALLOC_MAX_SIZE - 4096 or similar.
> 
> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   fs/fuse/file.c      | 12 +++++++++++-
>   fs/fuse/fuse_i.h    |  3 +++
>   fs/fuse/inode.c     |  1 +
>   fs/fuse/virtio_fs.c |  6 ++++++
>   4 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index a660f1f21540..f1beb7c0b782 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1422,6 +1422,16 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>   	return ret < 0 ? ret : 0;
>   }
>   
> +static size_t fuse_max_dio_rw_size(const struct fuse_conn *fc,
> +				   const struct iov_iter *iter, int write)
> +{
> +	unsigned int nmax = write ? fc->max_write : fc->max_read;
> +
> +	if (iov_iter_is_kvec(iter))
> +		nmax = min(nmax, fc->max_nopage_rw);
> +	return nmax;
> +}
> +
>   ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>   		       loff_t *ppos, int flags)
>   {
> @@ -1432,7 +1442,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>   	struct inode *inode = mapping->host;
>   	struct fuse_file *ff = file->private_data;
>   	struct fuse_conn *fc = ff->fm->fc;
> -	size_t nmax = write ? fc->max_write : fc->max_read;
> +	size_t nmax = fuse_max_dio_rw_size(fc, iter, write);
>   	loff_t pos = *ppos;
>   	size_t count = iov_iter_count(iter);
>   	pgoff_t idx_from = pos >> PAGE_SHIFT;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 1df83eebda92..fc753cd34211 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -594,6 +594,9 @@ struct fuse_conn {
>   	/** Constrain ->max_pages to this value during feature negotiation */
>   	unsigned int max_pages_limit;
>   
> +	/** Maximum read/write size when there is no page in request */
> +	unsigned int max_nopage_rw;
> +
>   	/** Input queue */
>   	struct fuse_iqueue iq;
>   
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 2a6d44f91729..4cbbcb4a4b71 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -923,6 +923,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
>   	fc->user_ns = get_user_ns(user_ns);
>   	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
>   	fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
> +	fc->max_nopage_rw = UINT_MAX;
>   
>   	INIT_LIST_HEAD(&fc->mounts);
>   	list_add(&fm->fc_entry, &fc->mounts);
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 5f1be1da92ce..3aac31d45198 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1452,6 +1452,12 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>   	/* Tell FUSE to split requests that exceed the virtqueue's size */
>   	fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
>   				    virtqueue_size - FUSE_HEADER_OVERHEAD);
> +	/* copy_args_to_argbuf() uses kmalloc-ed memory as bounce buffer
> +	 * for fuse args, so limit the total size of these args to prevent
> +	 * the warning in __alloc_pages() and decrease the demand for large
> +	 * contiguous pages.
> +	 */
> +	fc->max_nopage_rw = min(fc->max_nopage_rw, 256U << 10);
>   
>   	fsc->s_fs_info = fm;
>   	sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);

