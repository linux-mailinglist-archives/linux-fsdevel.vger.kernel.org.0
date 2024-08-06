Return-Path: <linux-fsdevel+bounces-25120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BDC94949D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 17:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B9E1C209BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 15:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89141803A;
	Tue,  6 Aug 2024 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="OVPcifZx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o6bjgB85"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B73217BD9
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958443; cv=none; b=nnFK++tznQZt8zhmNXvwig/3epvfjI8qWQDMHXMUd6O4iXHA9H7/Ce19GxTD4et/WVhYcZCiil26lZySrUZgnHN3anrf2thgeFErnO7zmj9tK08LHw4bTFNUXYHiW+BmneD21dUljSZh9A3i6t4dGaTm/uDq8W5vtqsq6djVo4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958443; c=relaxed/simple;
	bh=QfSPD1da+9R7/ZDoa32VXVVbVIeZm594rYDFOFRzZic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvXIbpJuG17inu3Ksn0baVii7yEHusSsVQkipmuyuZnrNM7/sh+iyZpL1pbk8dTIWOWui19pupuQV7rvct+XIS1t8ncvK1XFGdrqf7bkcYXwbw2Ln+AIolgEDXZ4rZK5rxH8T14qZo2Xny0AhpT0cL73VbnHIeS5Ct2WnRQR7YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=OVPcifZx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o6bjgB85; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 50F70138A657;
	Tue,  6 Aug 2024 11:34:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 06 Aug 2024 11:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1722958440;
	 x=1723044840; bh=WwO1PXTuVgZHw7mkIAKUQ5AUs/y39EG6maq0U608N5k=; b=
	OVPcifZxw5mlqYtfEwlZzC/k1jDoRhraacZNzrddoCV7I52GSFJaau/tsF07BzOh
	D05JcveKAqCtHan0kkSC3t6XRmY3LRGjYkXi8rEUBsxcKfl5FKE4cW2a4xoVLZWx
	MQf0mtgI9rb26gOhcuyZ7zo2W0vAbCR6sozfq0pbni29h8z7V6icQRFbm2Bvtexr
	SBBo1lUaLvWcDeVCOEjNlmQGVzHMfRSOwFoA4woPchRdILUZQ89AEY5wfBSe8+w/
	Ljq3S6vnDFYrTShI4YKFPkyEE45tZytC/gpmd4hvcIMpDNBLCvPE8a2z4bmao4sb
	7M+kLUb/pjSkN6DpWDX5Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722958440; x=
	1723044840; bh=WwO1PXTuVgZHw7mkIAKUQ5AUs/y39EG6maq0U608N5k=; b=o
	6bjgB85NvFBdDb34EkqZ2iRgHGsw+ORbnMOkRdowW52AwAHeT9EbYv3CY9YWQhp+
	uXtnU6u9pi+YmCoAQRlrjCYGxZFoNs1EpzzLDTlTyB4ZT+7yjyIwojPDDhVtfUJ6
	aDJXLhtbYtB4p8mx+u3OulQufXuXnrytl52xHtWXpoPesIVbwFlDRnhn2N/aJE/J
	9xBROElRS1a/goUIR6V58qyrzdDIms3xYikUwmnAzIaOdqVD2F8l0Z8bLvGoBhbh
	VczrwBOf9Nb9FB7UPGtthWjzF03okKi3jm8e8WaiY5k0s5U53x5knufDQrYvaruX
	vHZ4zLZv9HPUByIS9GHLA==
X-ME-Sender: <xms:Z0KyZgJ-fsGvkcreSnezZggNLh9-DyhFa1_nvejrIzvW-6PcQDqHwA>
    <xme:Z0KyZgKP3zWWLwE3nwMM6ta9kBnh1F6gYfaZdyOOmCV_2cslBSPFVRLy36F50f-Ux
    XoVEhymknr8BLbd>
X-ME-Received: <xmr:Z0KyZgsI5FPyuTq5o-ZJNBWdIrRfuJto-E5AKAGwMfF1SYYmBcOu_ueoCq7UXD2N_Ttua9iIQDhRoGR3OyF7c1_cg6beqoCK33q3HTbiipkgznWFNygV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeeutdekieelgeehudekgffhtdduvddugfehleej
    jeegleeuffeukeehfeehffevleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:Z0KyZta6WNB9p7jDYJPNDkE53qU58RB9OBgr6LIDEpC6Bnfj3PxIPg>
    <xmx:Z0KyZnaVL3vdgvdFJdlovBuhj-i1cUJjAYSnfIMRQ3QbujJvC4Bbgg>
    <xmx:Z0KyZpBDOdEqh1jUSQb2nOiM9zNtJUvvIgOUWsOpEtl6riXt2-kLuA>
    <xmx:Z0KyZta1ciN-BR5ARCprA-U6av7t9z26xuOUVgglB81Hbzd-6iKQJw>
    <xmx:aEKyZiwUMaEhTZu6ZGZiH0rWfxZCP6SDDkgszgzkhWdl6arKyureI0Jx>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 11:33:59 -0400 (EDT)
Message-ID: <dea03551-0025-47ef-9d3a-b132d34bb626@fastmail.fm>
Date: Tue, 6 Aug 2024 17:33:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: Allow page aligned writes
To: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com
References: <20240802215200.2842855-1-bschubert@ddn.com>
 <CAJnrk1bzOSR_jOjZN8C+HTcWxU0Erh_=0rZD63zLskUne9d7Jw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, fr, ru
In-Reply-To: <CAJnrk1bzOSR_jOjZN8C+HTcWxU0Erh_=0rZD63zLskUne9d7Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/5/24 22:32, Joanne Koong wrote:
> On Fri, Aug 2, 2024 at 2:52 PM Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> Read/writes IOs should be page aligned as fuse server
> 
> I think you meant just "write IOs"  here and not reads?

Yeah sorry.

> 
>> might need to copy data to another buffer otherwise in
>> order to fulfill network or device storage requirements.
>>
>> Simple reproducer is with libfuse, example/passthrough*
>> and opening a file with O_DIRECT - without this change
>> writing to that file failed with -EINVAL if the underlying
>> file system was requiring alignment.
>>
>> Required server side changes:
>> Server needs to seek to the next page, without splice that is
>> just page size buffer alignment, with splice another splice
>> syscall is needed to seek over the unaligned area.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>
>> ---
>>
>> Changes since v1:
>> - Fuse client does not send the alignment offset anymore in the write
>>   header.
>> - Use FOPEN_ALIGNED_WRITES to be filled in by FUSE_OPEN and FUSE_CREATE
>>   instead of a FUSE_INIT flag to allow control per file and to safe
>>   init flags.
>> - Instead of seeking a fixed offset, fuse_copy_align() just seeks to the
>>   next page.
>> - Added sanity checks in fuse_copy_align().
>>
>> libfuse patch:
>> https://github.com/libfuse/libfuse/pull/983
>>
>> From implmentation point of view it is debatable if request type
>> parsing should be done in fuse_copy_args() or if alignment
>> should be stored in struct fuse_arg / fuse_in_arg.
>> ---
>>  fs/fuse/dev.c             | 25 +++++++++++++++++++++++--
>>  fs/fuse/file.c            |  6 ++++++
>>  fs/fuse/fuse_i.h          |  6 ++++--
>>  include/uapi/linux/fuse.h |  9 ++++++++-
>>  4 files changed, 41 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 9eb191b5c4de..e0db408db90f 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -1009,6 +1009,24 @@ static int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsigned size)
>>         return 0;
>>  }
>>
>> +/* Align to the next page */
>> +static int fuse_copy_align(struct fuse_copy_state *cs)
>> +{
>> +       if (WARN_ON(!cs->write))
>> +               return -EIO;
> 
> I understand why you have the check here but in my opinion,
> fuse_copy_align should just be a generic api since the rest of the arg
> copying APIs are generic and with having "align" as a bit in the args
> field, align capability seems generic as well.

I can remove it no issue. I had in there as wrong alignment action will
cause data corruption.

> 
>> +
>> +       if (WARN_ON(cs->move_pages))
>> +               return -EIO;
>> +
>> +       if (WARN_ON(cs->len == PAGE_SIZE || cs->offset == 0))
>> +               return -EIO;
>> +
>> +       /* Seek to the next page */
>> +       cs->offset += cs->len;
>> +       cs->len = 0;
>> +       return 0;
>> +}
>> +
>>  /* Copy request arguments to/from userspace buffer */
>>  static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
>>                           unsigned argpages, struct fuse_arg *args,
>> @@ -1019,10 +1037,13 @@ static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
>>
>>         for (i = 0; !err && i < numargs; i++)  {
>>                 struct fuse_arg *arg = &args[i];
>> -               if (i == numargs - 1 && argpages)
>> +               if (i == numargs - 1 && argpages) {
>>                         err = fuse_copy_pages(cs, arg->size, zeroing);
>> -               else
>> +               } else {
>>                         err = fuse_copy_one(cs, arg->value, arg->size);
>> +                       if (!err && arg->align)
>> +                               err = fuse_copy_align(cs);
>> +               }
>>         }
>>         return err;
>>  }
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index f39456c65ed7..931e7324137f 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -1062,6 +1062,12 @@ static void fuse_write_args_fill(struct fuse_io_args *ia, struct fuse_file *ff,
>>                 args->in_args[0].size = FUSE_COMPAT_WRITE_IN_SIZE;
>>         else
>>                 args->in_args[0].size = sizeof(ia->write.in);
>> +
>> +       if (ff->open_flags & FOPEN_ALIGNED_WRITES) {
>> +               args->in_args[0].align = 1;
> 
> This is more of a nit so feel free to disregard, but I think the code
> is easier to understand if the align bit gets set on the arg that
> needs alignment instead of on the preceding arg. I think this would
> also make fuse_copy_args() easier to grok, since the alignment would
> be done before doing fuse_copy_pages(), which makes it more obvious
> that the alignment is for the copied out pages

Makes sense, going to change it to args->in_args[1].

> 
>> +               ia->write.in.write_flags |= FUSE_WRITE_ALIGNED;
>> +       }
>> +
>>         args->in_args[0].value = &ia->write.in;
>>         args->in_args[1].size = count;
>>         args->out_numargs = 1;
>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>> index f23919610313..1600bd7b1d0d 100644
>> --- a/fs/fuse/fuse_i.h
>> +++ b/fs/fuse/fuse_i.h
>> @@ -275,13 +275,15 @@ struct fuse_file {
>>
>>  /** One input argument of a request */
>>  struct fuse_in_arg {
>> -       unsigned size;
>> +       unsigned int size;
>> +       unsigned int align:1;
>>         const void *value;
>>  };
>>
>>  /** One output argument of a request */
>>  struct fuse_arg {
>> -       unsigned size;
>> +       unsigned int size;
>> +       unsigned int align:1;
>>         void *value;
>>  };
>>
>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>> index d08b99d60f6f..742262c7c1eb 100644
>> --- a/include/uapi/linux/fuse.h
>> +++ b/include/uapi/linux/fuse.h
>> @@ -217,6 +217,9 @@
>>   *  - add backing_id to fuse_open_out, add FOPEN_PASSTHROUGH open flag
>>   *  - add FUSE_NO_EXPORT_SUPPORT init flag
>>   *  - add FUSE_NOTIFY_RESEND, add FUSE_HAS_RESEND init flag
>> + *
>> + * 7.41
>> + *  - add FOPEN_ALIGNED_WRITES open flag and FUSE_WRITE_ALIGNED write flag
>>   */
>>
>>  #ifndef _LINUX_FUSE_H
>> @@ -252,7 +255,7 @@
>>  #define FUSE_KERNEL_VERSION 7
>>
>>  /** Minor version number of this interface */
>> -#define FUSE_KERNEL_MINOR_VERSION 40
>> +#define FUSE_KERNEL_MINOR_VERSION 41
>>
>>  /** The node ID of the root inode */
>>  #define FUSE_ROOT_ID 1
>> @@ -360,6 +363,7 @@ struct fuse_file_lock {
>>   * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
>>   * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
>>   * FOPEN_PASSTHROUGH: passthrough read/write io for this open file
>> + * FOPEN_ALIGNED_WRITES: Page align write io data
>>   */
>>  #define FOPEN_DIRECT_IO                (1 << 0)
>>  #define FOPEN_KEEP_CACHE       (1 << 1)
>> @@ -369,6 +373,7 @@ struct fuse_file_lock {
>>  #define FOPEN_NOFLUSH          (1 << 5)
>>  #define FOPEN_PARALLEL_DIRECT_WRITES   (1 << 6)
>>  #define FOPEN_PASSTHROUGH      (1 << 7)
>> +#define FOPEN_ALIGNED_WRITES   (1 << 8)
> 
> Nice, I like how you made the flag on open instead of init to allow
> this option to be file-specific.
> 
>>
>>  /**
>>   * INIT request/reply flags
>> @@ -496,10 +501,12 @@ struct fuse_file_lock {
>>   * FUSE_WRITE_CACHE: delayed write from page cache, file handle is guessed
>>   * FUSE_WRITE_LOCKOWNER: lock_owner field is valid
>>   * FUSE_WRITE_KILL_SUIDGID: kill suid and sgid bits
>> + * FUSE_WRITE_ALIGNED: Write io data are page aligned
>>   */
>>  #define FUSE_WRITE_CACHE       (1 << 0)
>>  #define FUSE_WRITE_LOCKOWNER   (1 << 1)
>>  #define FUSE_WRITE_KILL_SUIDGID (1 << 2)
>> +#define FUSE_WRITE_ALIGNED      (1 << 3)
>>
>>  /* Obsolete alias; this flag implies killing suid/sgid only. */
>>  #define FUSE_WRITE_KILL_PRIV   FUSE_WRITE_KILL_SUIDGID
>> --
>> 2.43.0
>>
> Regarding where/how alignment should be stored, eg request type
> parsing vs in fuse_arg/fuse_in_arg structs -
> 
> I don't feel strongly about this but it feels cleaner to me to do
> request type parsing given that alignment is only needed for fuse
> write requests. In my mind, it would look something like this:
> 
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1012,17 +1012,21 @@ static int fuse_copy_one(struct
> fuse_copy_state *cs, void *val, unsigned size)
>  /* Copy request arguments to/from userspace buffer */
>  static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
>                           unsigned argpages, struct fuse_arg *args,
> -                         int zeroing)
> +                         int zeroing, bool align)
>  {
>         int err = 0;
>         unsigned i;
> 
>         for (i = 0; !err && i < numargs; i++)  {
>                 struct fuse_arg *arg = &args[i];
> -               if (i == numargs - 1 && argpages)
> -                       err = fuse_copy_pages(cs, arg->size, zeroing);
> -               else
> +               if (i == numargs - 1 && argpages) {
> +                       if (align)
> +                               err = fuse_copy_align(cs);
> +                       if (!err)
> +                               err = fuse_copy_pages(cs, arg->size, zeroing);
> +               } else {
>                         err = fuse_copy_one(cs, arg->value, arg->size);
> +               }
>         }
>         return err;
>  }
> 
> +static bool should_align_copy_pages(struct file *file, struct fuse_args *args)
> +{
> +       struct fuse_file *ff = file->private_data;
> +
> +       return (ff->open_flags & FOPEN_ALIGNED_WRITES) && args->opcode
> == FUSE_WRITE;
> +}
> +
> @@ -1212,6 +1223,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev
> *fud, struct file *file,
>         struct fuse_args *args;
>         unsigned reqsize;
>         unsigned int hash;
> +       bool align;
> 
>         /*
>          * Require sane minimum read buffer - that has capacity for fixed part
> @@ -1296,9 +1308,10 @@ static ssize_t fuse_dev_do_read(struct fuse_dev
> *fud, struct file *file,
>         spin_unlock(&fpq->lock);
>         cs->req = req;
>         err = fuse_copy_one(cs, &req->in.h, sizeof(req->in.h));
> +       align = should_align_copy_pages(file, args);
>         if (!err)
>                 err = fuse_copy_args(cs, args->in_numargs, args->in_pages,
> -                                    (struct fuse_arg *) args->in_args, 0);
> +                                    (struct fuse_arg *)
> args->in_args, 0, align);
>         fuse_copy_finish(cs);
>         spin_lock(&fpq->lock);
>         clear_bit(FR_LOCKED, &req->flags);
> @@ -1896,7 +1909,7 @@ static int copy_out_args(struct fuse_copy_state
> *cs, struct fuse_args *args,
>                 lastarg->size -= diffsize;
>         }
>         return fuse_copy_args(cs, args->out_numargs, args->out_pages,
> -                             args->out_args, args->page_zeroing);
> +                             args->out_args, args->page_zeroing, false);
>  }
> 
> which also seems to me easier to follow in logic than having the align
> bit in the args. But if align will be something that other operations
> will also need/request, then I think it makes sense to have it in the
> args.

Personally I prefer to have it as args parameter. I had a version with a
FUSE_WRITE check in fuse_copy_args() - from my point of view, if at all
it should go there. Maybe it is only me, but I would prefer to avoid
adding conditions in fuse_dev_do_read() (if it can be avoided) as that
function is already a bit complex.

My guess is also that we will need to align FUSE_SETXATTR, although I
don't have an immediate use case for it.


Thanks for your review!


Bernd



