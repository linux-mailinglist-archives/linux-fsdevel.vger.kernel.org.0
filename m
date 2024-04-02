Return-Path: <linux-fsdevel+bounces-15937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83513895E96
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 23:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D321F27548
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 21:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD67915E1F9;
	Tue,  2 Apr 2024 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="WKefr9dd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sJ0hyTNy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E170F15E202
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092702; cv=none; b=B3Wv7YkYZRSJ/WbrCpIDr5qmuQ5gdY4z2CCo8qPbxq097+j5ZiCo5DA72K0/9I6l2ermONl1WqwlKGbjyevtj3d+t6onZ3t2x39NXgguQuElO65goSoi3nksleGdVOKnnrrXwIpQnVIU2y+5eTC/Qlex3wbrg3uQaohNn73Lfho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092702; c=relaxed/simple;
	bh=7k6h5fLgd8JxHEikiMZpnLAyeN9t3xA6dgECMo39esk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLoP0Zr2us6bwCqZnprZQRgE3PljCLZGMzOmO7skZ+RerYLWzxPIxuJvYKRC9g++QzSIIzJ7dxS4ZTqxL8XOR2y0jN5cipvJQObBMkAak57ird/hw3L8zEkNpvsi1mJvnK87/6zPKgNWoe3nS1linf+jkrUlz136VEEL/wCOWqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=WKefr9dd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sJ0hyTNy; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id EA3B91380252;
	Tue,  2 Apr 2024 17:18:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 02 Apr 2024 17:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1712092698;
	 x=1712179098; bh=/q77q8gmFMS8C/DlRIi22kuaC5WJF2abFNy3uDt1F9A=; b=
	WKefr9ddQOYVusxMxEta28C10iAZcTon1N48bvbRPUPIKomXWYnucsDWPsUS0Uxw
	yhqzE2WVuT9Dg5GNgC/Y3WGwKChjzEBrPj6s6Z2gUkdRYm4NGupnVpx0nTN5SJUQ
	D+gK0Z28QGhtfoOWt0JqTBQLaHzGi0GZuVEjXwWJ0ISc15zynVnXWo7NBHpgcLXv
	1VNkHHU6Foar1ACW3WEunUN1HNGUhj84Axn4NrI+igOy1NMEAMNilxLcozavQ/Cu
	IMxx1PKpLMarhbqNExCGWoBJRaai43NXjWux83w8bs0VbVFirpDgQUep9dXdqJ86
	X0h/44l2s58p7OJRzK0W8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712092698; x=
	1712179098; bh=/q77q8gmFMS8C/DlRIi22kuaC5WJF2abFNy3uDt1F9A=; b=s
	J0hyTNyIptfamWDa4fcK1TnX3qpfT3Q1GyDWC5PkVBk/AGNclHrUGN8dvipxd3gF
	aylUs/MLpwVj3bHHtQq7KYdJcp7T/L0J3kyxe2WfGSgDU47Scw8thfAqSUaIHiX4
	c81QIf6J8lSJ68Y8jA840hOodaAJFk2XJ73juTHCtFKt1ZbcZnfAc4AWhNe44S2P
	JEEQspTuLYqvqSjFxkDAzQguv5ZF0Q0h9zgT5rp6yW02UaQjit0zf0ho/rxlOGTq
	64OeG17OoCRNL7omatLTKgJCYE0yvP/Y7vDEM3WcpU6i1pz6l8wulDWqnV/CTfRG
	m9+1HvXNe6KDq6YWY0mnA==
X-ME-Sender: <xms:GnYMZjMqVkxNR8HgeaIiUxOwwdiL2FqC7rmyKkyVS0fPyOzFnkEk7w>
    <xme:GnYMZt_lk1N-9lhfXWX0rCH_9lhN5KqWYM3pfIOELDyq52Itfigj9iBND4NG9IY6u
    nqAJ3CjF4F7wc_A>
X-ME-Received: <xmr:GnYMZiSSc7k0VHQpVnnnR78ro9orRnxDrhrtaUYjN-CToTaDA3B_mXpKSS6WJLBxYpcQb0qmCwcGTBabMjFBakTZQTF-jDnkL_Vgn6BGsyHkLnLYRQxe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeevgfeukedtfeeugfekueeikeeileejheff
    jeehleduieefteeufefhteeuhefhfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhn
    ugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:GnYMZnv9lAETcsQqsJ4LexI-_VTr7sfu2s0_ni39SVZeOaYcIdB36Q>
    <xmx:GnYMZrcz1Bs_7x13x3iIQc866V2mY1ari2BelLBIxJfYMyC36BUbSw>
    <xmx:GnYMZj0La19BluB0snZvIRmO0eMT9Y_uqv3uUYUJ7ET_iwUEu-1epg>
    <xmx:GnYMZn8ohoGyfXlM1mHDQxUKbDyQRMTkEvl5tBT4Dyi7bsInMniPPg>
    <xmx:GnYMZsHl9699ehq9PtWEltyigoyTSho1oFdd-gtSGtoaO2obKZtoSQhm>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 17:18:17 -0400 (EDT)
Message-ID: <a939b9b5-fb66-42ea-9855-6c7275f17452@fastmail.fm>
Date: Tue, 2 Apr 2024 23:18:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 9/9] fuse: auto-invalidate inode attributes in
 passthrough mode
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
References: <20240206142453.1906268-1-amir73il@gmail.com>
 <20240206142453.1906268-10-amir73il@gmail.com>
 <c52a81b4-2e88-4a89-b2e5-fecbb3e3d03e@dorminy.me>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <c52a81b4-2e88-4a89-b2e5-fecbb3e3d03e@dorminy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/2/24 22:13, Sweet Tea Dorminy wrote:
> 
> 
> On 2/6/24 09:24, Amir Goldstein wrote:
>> After passthrough read/write, we invalidate a/c/mtime/size attributes
>> if the backing inode attributes differ from FUSE inode attributes.
>>
>> Do the same in fuse_getattr() and after detach of backing inode, so that
>> passthrough mmap read/write changes to a/c/mtime/size attribute of the
>> backing inode will be propagated to the FUSE inode.
>>
>> The rules of invalidating a/c/mtime/size attributes with writeback cache
>> are more complicated, so for now, writeback cache and passthrough cannot
>> be enabled on the same filesystem.
>>
>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>> ---
>>   fs/fuse/dir.c         |  4 ++++
>>   fs/fuse/fuse_i.h      |  2 ++
>>   fs/fuse/inode.c       |  4 ++++
>>   fs/fuse/iomode.c      |  5 +++-
>>   fs/fuse/passthrough.c | 55 ++++++++++++++++++++++++++++++++++++-------
>>   5 files changed, 61 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> index 95330c2ca3d8..7f9d002b8f23 100644
>> --- a/fs/fuse/dir.c
>> +++ b/fs/fuse/dir.c
>> @@ -2118,6 +2118,10 @@ static int fuse_getattr(struct mnt_idmap *idmap,
>>           return -EACCES;
>>       }
>>   +    /* Maybe update/invalidate attributes from backing inode */
>> +    if (fuse_inode_backing(get_fuse_inode(inode)))
>> +        fuse_backing_update_attr_mask(inode, request_mask);
>> +
>>       return fuse_update_get_attr(inode, NULL, stat, request_mask,
>> flags);
>>   }
>>   diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>> index 98f878a52af1..4b011d31012f 100644
>> --- a/fs/fuse/fuse_i.h
>> +++ b/fs/fuse/fuse_i.h
>> @@ -1456,6 +1456,8 @@ void fuse_backing_files_init(struct fuse_conn *fc);
>>   void fuse_backing_files_free(struct fuse_conn *fc);
>>   int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map
>> *map);
>>   int fuse_backing_close(struct fuse_conn *fc, int backing_id);
>> +void fuse_backing_update_attr(struct inode *inode, struct
>> fuse_backing *fb);
>> +void fuse_backing_update_attr_mask(struct inode *inode, u32
>> request_mask);
>>     struct fuse_backing *fuse_passthrough_open(struct file *file,
>>                          struct inode *inode,
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index c26a84439934..c68f005b6e86 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -1302,9 +1302,13 @@ static void process_init_reply(struct
>> fuse_mount *fm, struct fuse_args *args,
>>                * on a stacked fs (e.g. overlayfs) themselves and with
>>                * max_stack_depth == 1, FUSE fs can be stacked as the
>>                * underlying fs of a stacked fs (e.g. overlayfs).
>> +             *
>> +             * For now, writeback cache and passthrough cannot be
>> +             * enabled on the same filesystem.
>>                */
>>               if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) &&
>>                   (flags & FUSE_PASSTHROUGH) &&
>> +                !fc->writeback_cache &&
>>                   arg->max_stack_depth > 0 &&
>>                   arg->max_stack_depth <= FILESYSTEM_MAX_STACK_DEPTH) {
>>                   fc->passthrough = 1;
>> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
>> index c545058a01e1..96eb311fe7bd 100644
>> --- a/fs/fuse/iomode.c
>> +++ b/fs/fuse/iomode.c
>> @@ -157,8 +157,11 @@ void fuse_file_uncached_io_end(struct inode *inode)
>>       spin_unlock(&fi->lock);
>>       if (!uncached_io)
>>           wake_up(&fi->direct_io_waitq);
>> -    if (oldfb)
>> +    if (oldfb) {
>> +        /* Maybe update attributes after detaching backing inode */
>> +        fuse_backing_update_attr(inode, oldfb);
>>           fuse_backing_put(oldfb);
>> +    }
>>   }
>>     /*
>> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
>> index 260e76fc72d5..c1bb80a6e536 100644
>> --- a/fs/fuse/passthrough.c
>> +++ b/fs/fuse/passthrough.c
>> @@ -11,11 +11,8 @@
>>   #include <linux/backing-file.h>
>>   #include <linux/splice.h>
>>   -static void fuse_file_accessed(struct file *file)
>> +static void fuse_backing_accessed(struct inode *inode, struct
>> fuse_backing *fb)
>>   {
>> -    struct inode *inode = file_inode(file);
>> -    struct fuse_inode *fi = get_fuse_inode(inode);
>> -    struct fuse_backing *fb = fuse_inode_backing(fi);
>>       struct inode *backing_inode = file_inode(fb->file);
>>       struct timespec64 atime = inode_get_atime(inode);
>>       struct timespec64 batime = inode_get_atime(backing_inode);
>> @@ -25,11 +22,8 @@ static void fuse_file_accessed(struct file *file)
>>           fuse_invalidate_atime(inode);
>>   }
>>   -static void fuse_file_modified(struct file *file)
>> +static void fuse_backing_modified(struct inode *inode, struct
>> fuse_backing *fb)
>>   {
>> -    struct inode *inode = file_inode(file);
>> -    struct fuse_inode *fi = get_fuse_inode(inode);
>> -    struct fuse_backing *fb = fuse_inode_backing(fi);
>>       struct inode *backing_inode = file_inode(fb->file);
>>       struct timespec64 ctime = inode_get_ctime(inode);
>>       struct timespec64 mtime = inode_get_mtime(inode);
>> @@ -42,6 +36,51 @@ static void fuse_file_modified(struct file *file)
>>           fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
>>   }
>>   +/* Called from fuse_file_uncached_io_end() after detach of backing
>> inode */
>> +void fuse_backing_update_attr(struct inode *inode, struct
>> fuse_backing *fb)
>> +{
>> +    fuse_backing_modified(inode, fb);
>> +    fuse_backing_accessed(inode, fb);
>> +}
>> +
>> +/* Called from fuse_getattr() - may race with detach of backing inode */
>> +void fuse_backing_update_attr_mask(struct inode *inode, u32
>> request_mask)
>> +{
>> +    struct fuse_inode *fi = get_fuse_inode(inode);
>> +    struct fuse_backing *fb;
>> +
>> +    rcu_read_lock();
>> +    fb = fuse_backing_get(fuse_inode_backing(fi));
>> +    rcu_read_unlock();
>> +    if (!fb)
>> +        return;
>> +
>> +    if (request_mask & FUSE_STATX_MODSIZE)
>> +        fuse_backing_modified(inode, fb);
>> +    if (request_mask & STATX_ATIME)
>> +        fuse_backing_accessed(inode, fb);
>> +
>> +    fuse_backing_put(fb);
>> +}
>> +
>> +static void fuse_file_accessed(struct file *file)
>> +{
>> +    struct inode *inode = file_inode(file);
>> +    struct fuse_inode *fi = get_fuse_inode(inode);
>> +    struct fuse_backing *fb = fuse_inode_backing(fi);
>> +
>> +    fuse_backing_accessed(inode, fb);
>> +}
>> +
>> +static void fuse_file_modified(struct file *file)
>> +{
>> +    struct inode *inode = file_inode(file);
>> +    struct fuse_inode *fi = get_fuse_inode(inode);
>> +    struct fuse_backing *fb = fuse_inode_backing(fi);
>> +
>> +    fuse_backing_modified(inode, fb);
>> +}
>> +
>>   ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct
>> iov_iter *iter)
>>   {
>>       struct file *file = iocb->ki_filp;
> 
> I noticed this patch doesn't seem to have made it into 6.9 like the rest
> of these passthrough patches -- may I ask why it didn't make it? I think
> it still makes sense but I might be missing some change between what's
> in 6.9 and this version of the patches.
> 
> Thanks!
> 
> Sweet Tea

See here please
https://lore.kernel.org/all/CAOQ4uxj8Az6VEZ-Ky5gs33gc0N9hjv4XqL6XC_kc+vsVpaBCOg@mail.gmail.com/


Bernd

