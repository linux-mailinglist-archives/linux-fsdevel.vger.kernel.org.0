Return-Path: <linux-fsdevel+bounces-7755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269E782A3FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 23:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA6F1C22D1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 22:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D154F89F;
	Wed, 10 Jan 2024 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="n5ociDYi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MJJWzZbG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52B04F888;
	Wed, 10 Jan 2024 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 095D25C016D;
	Wed, 10 Jan 2024 17:34:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 10 Jan 2024 17:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1704926061;
	 x=1705012461; bh=UnVUbz9SQXayg60OJLWAme7bYrBOjB6TLqClz8YLU18=; b=
	n5ociDYiPw4LafeAUZGIls2h1LmMgnhVS22kTCVjZva0NRl22lXX88Nfr8KoSKwP
	TjSx5W2OozAuNiFI4nf3eSOBfGd7I7cMm4q0Hn+AdujPx2kV5qYl6WEr7XQ68Wmo
	5w+xC0mFE29uqAIDQ1EZOgnEFlbZx8TQKzY3ICbN+KWmd8hLkmrsll46I2dP//Hy
	EGFvPwRm+wfXK3YjDjfvpyJ9ZxYacAICgIalR0piAICnKnGyABh/Q9obRnIX70xB
	wXKJsjvkb6YdLuzFniwsdNqZM7D3u4Q7fp2gS3grHIBpWZjC/PmVINzDnMGp0Sbf
	LyX5+q3pb8X2P6kb+a1wGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704926061; x=
	1705012461; bh=UnVUbz9SQXayg60OJLWAme7bYrBOjB6TLqClz8YLU18=; b=M
	JJWzZbGKXCbc7ludf4of73BPkMwMFlc2flsA7wJxg6tJ69i/TlFSjNfJ8wr2n6bD
	9y02R2D4bvgAPZHuS2VkeVDfF0+lC3o2iCYf8l7IegRSDtr5dxe9q6vI/Pe50ec3
	gg7icc8Cx18tYdQ2M0Q7kMQwmFMJk0hWBlRBYesrC+sMUTicx91Y1OzEXejSfsRm
	0ZLbpJW5wnzDwcyuTjz2ppHtFSP1+zmSYIX20nXZVprCFksWxbQ5R9FE7qS6q7QF
	zZP0Bc4MMcZL/PDVtvdKQnjdzXkGjJZYwBm2Nlt2C/XWrKytID2vC+3upHZxNqXF
	lfVAJZyKj/xO+2ls1mjYA==
X-ME-Sender: <xms:axufZXeMyE6Lj5S2c0gbyvsujRY_b44dZ4W4yjmifuhO2DGFSBkGsg>
    <xme:axufZdPUQLH1RprjyBwSr0Q7TFT6ODH9w9bFoNZMwIo2mhoB3OXo3E7bOuUnMpFb-
    cqGLyMXYvfoteaM>
X-ME-Received: <xmr:axufZQiItNsp8GLf5odKDX4cehUH3b5GWm9Q-r2AdpA-cmsxL5rsYzusX2xS-oe0Ih3hbPudh83yumerEcxS8vgY3qA4kurOOLcDKe_F24-n2y6TeGaK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiuddgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduveduveelgeelffffkedukeeg
    veelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:bBufZY-HWFo9EYIUqMqmNBxPMZqptW5qrJRr2xFAQWidYvT0_EajdA>
    <xmx:bBufZTv2kzfWM1Tv0mJWkjRpRsN9g3F1G9polhhgc2oCGb7plcCl9w>
    <xmx:bBufZXF1g0KuarOnIxF9nQ7Warxg1PsBKryC2NiLu3ZOwHTIXBhvCw>
    <xmx:bRufZc85JQXAnYIzHfR62-QGw78qWo8OOYRaJebi9MGDkcaeLCRC5g>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 17:34:18 -0500 (EST)
Message-ID: <e6b866f1-4102-44aa-85cd-274d2ae0ab7e@fastmail.fm>
Date: Wed, 10 Jan 2024 23:34:17 +0100
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
 <b6c0d521-bba8-447f-b114-0a679ca89e4b@fastmail.fm>
 <c71c80af-2813-dee5-a8e5-3782b34e9eb9@huaweicloud.com>
Content-Language: en-US, de-DE, fr
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <c71c80af-2813-dee5-a8e5-3782b34e9eb9@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/10/24 02:16, Hou Tao wrote:
> Hi,
> 
> On 1/9/2024 9:11 PM, Bernd Schubert wrote:
>>
>>
>> On 1/3/24 11:59, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> When trying to insert a 10MB kernel module kept in a virtiofs with cache
>>> disabled, the following warning was reported:
>>>
>>>     ------------[ cut here ]------------
>>>     WARNING: CPU: 2 PID: 439 at mm/page_alloc.c:4544 ......
>>>     Modules linked in:
>>>     CPU: 2 PID: 439 Comm: insmod Not tainted 6.7.0-rc7+ #33
>>>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ......
>>>     RIP: 0010:__alloc_pages+0x2c4/0x360
>>>     ......
>>>     Call Trace:
>>>      <TASK>
>>>      ? __warn+0x8f/0x150
>>>      ? __alloc_pages+0x2c4/0x360
>>>      __kmalloc_large_node+0x86/0x160
>>>      __kmalloc+0xcd/0x140
>>>      virtio_fs_enqueue_req+0x240/0x6d0
>>>      virtio_fs_wake_pending_and_unlock+0x7f/0x190
>>>      queue_request_and_unlock+0x58/0x70
>>>      fuse_simple_request+0x18b/0x2e0
>>>      fuse_direct_io+0x58a/0x850
>>>      fuse_file_read_iter+0xdb/0x130
>>>      __kernel_read+0xf3/0x260
>>>      kernel_read+0x45/0x60
>>>      kernel_read_file+0x1ad/0x2b0
>>>      init_module_from_file+0x6a/0xe0
>>>      idempotent_init_module+0x179/0x230
>>>      __x64_sys_finit_module+0x5d/0xb0
>>>      do_syscall_64+0x36/0xb0
>>>      entry_SYSCALL_64_after_hwframe+0x6e/0x76
>>>      ......
>>>      </TASK>
>>>     ---[ end trace 0000000000000000 ]---
>>>
>>> The warning happened as follow. In copy_args_to_argbuf(), virtiofs uses
>>> kmalloc-ed memory as bound buffer for fuse args, but
>>> fuse_get_user_pages() only limits the length of fuse arg by max_read or
>>> max_write for IOV_KVEC io (e.g., kernel_read_file from finit_module()).
>>> For virtiofs, max_read is UINT_MAX, so a big read request which is about
>>
>>
>> I find this part of the explanation a bit confusing. I guess you
>> wanted to write something like
>>
>> fuse_direct_io() -> fuse_get_user_pages() is limited by
>> fc->max_write/fc->max_read and fc->max_pages. For virtiofs max_pages
>> does not apply as ITER_KVEC is used. As virtiofs sets fc->max_read to
>> UINT_MAX basically no limit is applied at all.
> 
> Yes, what you said is just as expected but it is not the root cause of
> the warning. The culprit of the warning is kmalloc() in
> copy_args_to_argbuf() just as said in commit message. vmalloc() is also
> not acceptable, because the physical memory needs to be contiguous. For
> the problem, because there is no page involved, so there will be extra
> sg available, maybe we can use these sg to break the big read/write
> request into page.

Hmm ok, I was hoping that contiguous memory is not needed.
I see that ENOMEM is handled, but how that that perform (or even 
complete) on a really badly fragmented system? I guess splitting into 
smaller pages or at least adding some reserve kmem_cache (or even 
mempool) would make sense?

>>
>> I also wonder if it wouldn't it make sense to set a sensible limit in
>> virtio_fs_ctx_set_defaults() instead of introducing a new variable?
> 
> As said in the commit message:
> 
> A feasible solution is to limit the value of max_read for virtiofs, so
> the length passed to kmalloc() will be limited. However it will affects
> the max read size for ITER_IOVEC io and the value of max_write also needs
> limitation.
> 
> It is a bit hard to set a reasonable value for both max_read and
> max_write to handle both normal ITER_IOVEC io and ITER_KVEC io. And
> considering ITER_KVEC io + dio case is uncommon, I think using a new
> limitation is more reasonable.

For ITER_IOVEC max_pages applies - which is limited to 
FUSE_MAX_MAX_PAGES - why can't this be used in virtio_fs_ctx_set_defaults?

@Miklos, is there a reason why there is no upper fc->max_{read,write} 
limit in process_init_reply()? Shouldn't both be limited to
(FUSE_MAX_MAX_PAGES * PAGE_SIZE). Or any other reasonable limit?


Thanks,
Bernd



>>
>> Also, I guess the issue is kmalloc_array() in virtio_fs_enqueue_req?
>> Wouldn't it make sense to use kvm_alloc_array/kvfree in that function?
>>
>>
>> Thanks,
>> Bernd
>>
>>
>>> 10MB is passed to copy_args_to_argbuf(), kmalloc() is called in turn
>>> with len=10MB, and triggers the warning in __alloc_pages():
>>> WARN_ON_ONCE_GFP(order > MAX_ORDER, gfp)).
>>>
>>> A feasible solution is to limit the value of max_read for virtiofs, so
>>> the length passed to kmalloc() will be limited. However it will affects
>>> the max read size for ITER_IOVEC io and the value of max_write also
>>> needs
>>> limitation. So instead of limiting the values of max_read and max_write,
>>> introducing max_nopage_rw to cap both the values of max_read and
>>> max_write when the fuse dio read/write request is initiated from kernel.
>>>
>>> Considering that fuse read/write request from kernel is uncommon and to
>>> decrease the demand for large contiguous pages, set max_nopage_rw as
>>> 256KB instead of KMALLOC_MAX_SIZE - 4096 or similar.
>>>
>>> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>> ---
>>>    fs/fuse/file.c      | 12 +++++++++++-
>>>    fs/fuse/fuse_i.h    |  3 +++
>>>    fs/fuse/inode.c     |  1 +
>>>    fs/fuse/virtio_fs.c |  6 ++++++
>>>    4 files changed, 21 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>> index a660f1f21540..f1beb7c0b782 100644
>>> --- a/fs/fuse/file.c
>>> +++ b/fs/fuse/file.c
>>> @@ -1422,6 +1422,16 @@ static int fuse_get_user_pages(struct
>>> fuse_args_pages *ap, struct iov_iter *ii,
>>>        return ret < 0 ? ret : 0;
>>>    }
>>>    +static size_t fuse_max_dio_rw_size(const struct fuse_conn *fc,
>>> +                   const struct iov_iter *iter, int write)
>>> +{
>>> +    unsigned int nmax = write ? fc->max_write : fc->max_read;
>>> +
>>> +    if (iov_iter_is_kvec(iter))
>>> +        nmax = min(nmax, fc->max_nopage_rw);
>>> +    return nmax;
>>> +}
>>> +
>>>    ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>>>                   loff_t *ppos, int flags)
>>>    {
>>> @@ -1432,7 +1442,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io,
>>> struct iov_iter *iter,
>>>        struct inode *inode = mapping->host;
>>>        struct fuse_file *ff = file->private_data;
>>>        struct fuse_conn *fc = ff->fm->fc;
>>> -    size_t nmax = write ? fc->max_write : fc->max_read;
>>> +    size_t nmax = fuse_max_dio_rw_size(fc, iter, write);
>>>        loff_t pos = *ppos;
>>>        size_t count = iov_iter_count(iter);
>>>        pgoff_t idx_from = pos >> PAGE_SHIFT;
>>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>>> index 1df83eebda92..fc753cd34211 100644
>>> --- a/fs/fuse/fuse_i.h
>>> +++ b/fs/fuse/fuse_i.h
>>> @@ -594,6 +594,9 @@ struct fuse_conn {
>>>        /** Constrain ->max_pages to this value during feature
>>> negotiation */
>>>        unsigned int max_pages_limit;
>>>    +    /** Maximum read/write size when there is no page in request */
>>> +    unsigned int max_nopage_rw;
>>> +
>>>        /** Input queue */
>>>        struct fuse_iqueue iq;
>>>    diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>> index 2a6d44f91729..4cbbcb4a4b71 100644
>>> --- a/fs/fuse/inode.c
>>> +++ b/fs/fuse/inode.c
>>> @@ -923,6 +923,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct
>>> fuse_mount *fm,
>>>        fc->user_ns = get_user_ns(user_ns);
>>>        fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
>>>        fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
>>> +    fc->max_nopage_rw = UINT_MAX;
>>>          INIT_LIST_HEAD(&fc->mounts);
>>>        list_add(&fm->fc_entry, &fc->mounts);
>>> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
>>> index 5f1be1da92ce..3aac31d45198 100644
>>> --- a/fs/fuse/virtio_fs.c
>>> +++ b/fs/fuse/virtio_fs.c
>>> @@ -1452,6 +1452,12 @@ static int virtio_fs_get_tree(struct
>>> fs_context *fsc)
>>>        /* Tell FUSE to split requests that exceed the virtqueue's size */
>>>        fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
>>>                        virtqueue_size - FUSE_HEADER_OVERHEAD);
>>> +    /* copy_args_to_argbuf() uses kmalloc-ed memory as bounce buffer
>>> +     * for fuse args, so limit the total size of these args to prevent
>>> +     * the warning in __alloc_pages() and decrease the demand for large
>>> +     * contiguous pages.
>>> +     */
>>> +    fc->max_nopage_rw = min(fc->max_nopage_rw, 256U << 10);
>>>          fsc->s_fs_info = fm;
>>>        sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
>> .
> 
> 

