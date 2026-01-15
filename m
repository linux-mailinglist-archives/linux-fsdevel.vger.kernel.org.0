Return-Path: <linux-fsdevel+bounces-73928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E926D24F9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 15:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74CE9300A7AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 14:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9AF3A4AA5;
	Thu, 15 Jan 2026 14:35:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976DD52F88;
	Thu, 15 Jan 2026 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487714; cv=none; b=YiKgaPsLGTIScMI33iLg80rxpkJkJmJlte3vItv6Js+zf5JTT3G360Kpb5tmYNdK3dNpmeRgjSqxvCGmLOax8hS+RGEsqydcnFvc13aekSlfdIkO5/JBapLVq8QSXG5keh1s6fPJXKYrs09K3PAPkTzLJnWxP/zOy906OuIitsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487714; c=relaxed/simple;
	bh=dH/EA7hXhybTYsOZI9avo9L4VyzjVlNynKt9cwnP6qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7v4OPqPPnERH69ZLOC8AY0KFAqBgOSWVnkq1TvZnnG3ye0FNrxGMKR/vSsaaY55HHM/gHKumk6wYG6+ri37e6vYNu+vm67C82pfsDJD/SsckX7WJj5eFFpHeGTDOU7j94Xek5bBWpc76KQ9TLCa/Ux7Pp20ItFbgtKHnvxOunM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from [10.26.132.114] (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [101.226.143.247])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30cb81324;
	Thu, 15 Jan 2026 22:34:55 +0800 (GMT+08:00)
Message-ID: <a0ccfa28-4107-46ed-af79-faf55c004da0@ustc.edu>
Date: Thu, 15 Jan 2026 22:34:55 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] fuse: Add new flag to reuse the backing file of
 fuse_inode
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, paullawrence@google.com
References: <20260115072032.402-1-luochunsheng@ustc.edu>
 <20260115072032.402-3-luochunsheng@ustc.edu>
 <aWjnHvP5jsafQeag@amir-ThinkPad-T480>
From: Chunsheng Luo <luochunsheng@ustc.edu>
In-Reply-To: <aWjnHvP5jsafQeag@amir-ThinkPad-T480>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9bc214b59503a2kunma658ff67226d7d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTx5OVkoaTx1NGklKSRgdTVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKS0pVSUlNVUpPSFVJT0xZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++



On 1/15/26 9:09 PM, Amir Goldstein wrote:
> Hi Chunsheng,
> 
> Please CC me for future fuse passthrough patch sets.
> 
Ok.

> On Thu, Jan 15, 2026 at 03:20:31PM +0800, Chunsheng Luo wrote:
>> To simplify crash recovery and reduce performance impact, backing_ids
>> are not persisted across daemon restarts. However, this creates a
>> problem: when the daemon restarts and a process opens the same FUSE
>> file, a new backing_id may be allocated for the same backing file. If
>> the inode already has a cached backing file from before the restart,
>> subsequent open requests with the new backing_id will fail in
>> fuse_inode_uncached_io_start() due to fb mismatch, even though both
>> IDs reference the identical underlying file.
> 
> I don't think that your proposal makes this guaranty.
> 

Yes, this proposal does not apply to all situations.

>>
>> Introduce the FOPEN_PASSTHROUGH_INODE_CACHE flag to address this
>> issue. When set, the kernel reuses the backing file already cached in
>> the inode.
>>
>> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
>> ---
>>   fs/fuse/iomode.c          |  2 +-
>>   fs/fuse/passthrough.c     | 11 +++++++++++
>>   include/uapi/linux/fuse.h |  2 ++
>>   3 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
>> index 3728933188f3..b200bb248598 100644
>> --- a/fs/fuse/iomode.c
>> +++ b/fs/fuse/iomode.c
>> @@ -163,7 +163,7 @@ static void fuse_file_uncached_io_release(struct fuse_file *ff,
>>    */
>>   #define FOPEN_PASSTHROUGH_MASK \
>>   	(FOPEN_PASSTHROUGH | FOPEN_DIRECT_IO | FOPEN_PARALLEL_DIRECT_WRITES | \
>> -	 FOPEN_NOFLUSH)
>> +	 FOPEN_NOFLUSH | FOPEN_PASSTHROUGH_INODE_CACHE)
>>   
>>   static int fuse_file_passthrough_open(struct inode *inode, struct file *file)
>>   {
>> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
>> index 72de97c03d0e..fde4ac0c5737 100644
>> --- a/fs/fuse/passthrough.c
>> +++ b/fs/fuse/passthrough.c
>> @@ -147,16 +147,26 @@ ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
>>   /*
>>    * Setup passthrough to a backing file.
>>    *
>> + * If fuse inode backing is provided and FOPEN_PASSTHROUGH_INODE_CACHE flag
>> + * is set, try to reuse it first before looking up backing_id.
>> + *
>>    * Returns an fb object with elevated refcount to be stored in fuse inode.
>>    */
>>   struct fuse_backing *fuse_passthrough_open(struct file *file, int backing_id)
>>   {
>>   	struct fuse_file *ff = file->private_data;
>>   	struct fuse_conn *fc = ff->fm->fc;
>> +	struct fuse_inode *fi = get_fuse_inode(file->f_inode);
>>   	struct fuse_backing *fb = NULL;
>>   	struct file *backing_file;
>>   	int err;
>>   
>> +	if (ff->open_flags & FOPEN_PASSTHROUGH_INODE_CACHE) {
>> +		fb = fuse_backing_get(fuse_inode_backing(fi));
>> +		if (fb)
>> +			goto do_open;
>> +	}
>> +
> 
> Maybe an explicit FOPEN_PASSTHROUGH_INODE_CACHE flag is a good idea,
> but just FYI, I intentionally reserved backing_id 0 for this purpose.
> For example, for setting up the backing id on lookup [1] and then
> open does not need to specify the backing_id.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20250804173228.1990317-1-paullawrence@google.com/
> 

This is a great idea. However, we need to consider the lifecycle 
management of the backing file associated with a FUSE inode. 
Specifically, will the same backing_idbe retained for the entire 
lifetime of the FUSE inode until it is deleted?

Additionally, since each backing_idcorresponds to an open file 
descriptor (fd) for the backing file, if a fuse_inode holds onto a 
backing_id indefinitely without a suitable release mechanism, could this 
accumulation of file descriptors cause the process to exceed its open 
files limit?

> But what you are proposing is a little bit odd API IMO:
> "Use this backing_id with this backing file, unless you find another
>   backing file so use that one instead" - this sounds a bit awkward to me.
> 
> I think it would be saner and simpler to relax the check in
> fuse_inode_uncached_io_start() to check that old and new fuse_backing
> objects refer to the same backing inode:
> 
> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> index 3728933188f30..c6070c361d855 100644
> --- a/fs/fuse/iomode.c
> +++ b/fs/fuse/iomode.c
> @@ -88,9 +88,9 @@ int fuse_inode_uncached_io_start(struct fuse_inode *fi, struct fuse_backing *fb)
>   	int err = 0;
>   
>   	spin_lock(&fi->lock);
> -	/* deny conflicting backing files on same fuse inode */
> +	/* deny conflicting backing inodes on same fuse inode */
>   	oldfb = fuse_inode_backing(fi);
> -	if (fb && oldfb && oldfb != fb) {
> +	if (fb && oldfb && file_inode(oldfb->file) != file_inode(fb->file)) {
>   		err = -EBUSY;
>   		goto unlock;
>   	}
> --
> 
> I don't think that this requires opt-in flag.
> 
> Thanks,
> Amir.

I agree that modifying the condition to `file_inode(oldfb->file) != 
file_inode(fb->file)` is a reasonable fix, and it does address the first 
scenario I described.

However, it doesn't fully resolve the second scenario: in a read-only 
FUSE filesystem, the backing file itself might be cleaned up and 
re-downloaded (resulting in a new inode with identical content). In this 
case, reusing the cached fuse_inode's fb after a daemon restart still be 
safe, but the inode comparison would incorrectly reject it. Is there a 
more robust approach for handling this scenario?

Thanks.
Chunsheng Luo
> 
> 


