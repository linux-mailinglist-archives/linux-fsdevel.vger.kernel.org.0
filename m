Return-Path: <linux-fsdevel+bounces-14255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255A1879F86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 00:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4378282F8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 23:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2399046449;
	Tue, 12 Mar 2024 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="oKAd34fb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5534B14293
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710284895; cv=none; b=Mb9W5DDG64PVRFal6Ep+pJV4YVGR0ZQ9myeqZIEbkOOLEU5CKFcOkjZhqDu9E5PCdLKl4LuodsTUMwHbKA+osWu2D5EwqPolkQ/UEupju7EpG6xTieWZfEPPHGOPRKtlVZX3hySeJOZvrxP688SMHn2mivWi3bgelY/vARdI7FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710284895; c=relaxed/simple;
	bh=dJliIEIoRYtcPue1g52yRjOV8Quf32Akb5yaDYwe3jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvDqu5LuBFrZBnDiewTUlNXL1tck+TbZA09F9KfdiU8BmyUKCIZ6QsEoT4WZyu9aTNTl4+PnymByo9obkTFndGKc3Q0g/3k+pg9lFl5b3qB8b16UlPFR9UyG7GXDWoAseH7gYNMcO7tQpKxJ4jujGJqK0Ov6OEo20wneAUtMBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=oKAd34fb; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id C52A081268;
	Tue, 12 Mar 2024 19:08:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1710284891; bh=dJliIEIoRYtcPue1g52yRjOV8Quf32Akb5yaDYwe3jI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oKAd34fb3GvlAGOU6AVGQ0sPmsP+CFiOePcDejxRu/DQXS6esHXPqwXk1cTYgJ6xj
	 OgblQuN9kXXEwXSXMsJpjh48NagwJIPTev5OlLUdExOBvzcYsv0kRZIW7Qq2c2aNlN
	 FOyy7ZXn1OaXZWNSc1tqB5KwMr8cQoOLzk/hu8xVrSzlTD3zuQGYXBMJQVvSqL1mxr
	 uJUCokq4ihvkrvfGHJxL5zn1l+KMLlRXgMGGYUG1rye3qQ2RdwEKJey40PWxrcxJ9M
	 feJk5nchFOyBWyJNanZpm//VjM0NNOcusHAW/Ug0X5rAqia4sy4WMrjvqIizewWx/l
	 KQrAmLCbcCGqw==
Message-ID: <e6a5e45f-fe17-4805-86bb-64d5b1400d37@dorminy.me>
Date: Tue, 12 Mar 2024 19:08:09 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] fuse: update size attr before doing IO
Content-Language: en-US
To: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
 josef@toxicpanda.com, amir73il@gmail.com
References: <9d71a4fd1f1d8d4cfc28480f01e5fe3dc5a7e3f0.1709821568.git.sweettea-kernel@dorminy.me>
 <CAJfpeguHZCkkY2MZjJJZ2HhvhQuMhmwqnqGoxV-+wjsKwijX6w@mail.gmail.com>
 <4911426f-cf12-44f4-aef1-1000668ad3a0@dorminy.me>
 <2172443f-8c83-4abf-a7bb-cc3ca252c7c5@fastmail.fm>
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <2172443f-8c83-4abf-a7bb-cc3ca252c7c5@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/12/24 17:55, Bernd Schubert wrote:
> 
> 
> On 3/12/24 19:18, Sweet Tea Dorminy wrote:
>>
>>
>> On 3/11/24 06:01, Miklos Szeredi wrote:
>>> On Thu, 7 Mar 2024 at 16:10, Sweet Tea Dorminy
>>> <sweettea-kernel@dorminy.me> wrote:
>>>>
>>>> All calls into generic vfs functions need to make sure that the inode
>>>> attributes used by those functions are up to date, by calling
>>>> fuse_update_attributes() as appropriate.
>>>>
>>>> generic_write_checks() accesses inode size in order to get the
>>>> appropriate file offset for files opened with O_APPEND. Currently, in
>>>> some cases, fuse_update_attributes() is not called before
>>>> generic_write_checks(), potentially resulting in corruption/overwrite of
>>>> previously appended data if i_size is out of date in the cached inode.
>>>
>>> While this all sounds good, I don't think it makes sense.
>>>
>>> Why?  Because doing cached O_APPEND writes without any sort of
>>> exclusion with remote writes is just not going to work.
>>>
>>> Either the server ignores the current size and writes at the offset
>>> that the kernel supplied (which will be the cached size of the file)
>>> and executes the write at that position, or it appends the write to
>>> the current EOF.  In the former case the cache will be consistent, but
>>> append semantics are not observed, while in the latter case the append
>>> semantics are observed, but the cache will be inconsistent.
>>>
>>> Solution: either exclude remote writes or don't use the cache.
>>>
>>> Updating the file size before the write does not prevent the race,
>>> only makes the window smaller.
>>
>> Definitely agree with you.
>>
>> The usecase at hand is a sort of NFS-like network filesystem, where
>> there's exclusion of remote writes while the file is open, but no
>> problem with remote writes while the file is closed.
>>
>> The alternative we considered was to add a fuse_update_attributes() call
>> to open.
>>
>> We thought about doing so during d_revalidate/lookup_fast(). But as far
>> as I understand, lookup_fast() is not just called during open, and will
>> use the cached inode if the dentry timeout hasn't expired. We tried
>> setting dentry timeout to 0, but that lost too much performance. So that
>> didn't seem to work.
>>
>> But updating attributes after giving the filesystem a chance to
>> invalidate them during open() would work, I think?
> 
> You mean something like this?
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index d19cbf34c634..2723270323d9 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -204,7 +204,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
>          if (inode && fuse_is_bad(inode))
>                  goto invalid;
>          else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
> -                (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TARGET))) {
> +                (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TARGET | LOOKUP_OPEN))) {
>                  struct fuse_entry_out outarg;
>                  FUSE_ARGS(args);
>                  struct fuse_forget_link *forget;
> 
> 
> I think this would make sense and could be caught by the atomic-open/revalidate
> (once I get back to it).
> 
> 

That's an idea I like a lot, although I think that leaves open a window 
for a race and I can't see how to fix it easily.

If we passed the lookup_open flag down to the filesystem daemon, for it 
to exclusively lock the file, then we'd need a call to 
un-exclusively-lock it on an error later in the open process.

But if we don't do that and exclusively locked during fuse_send_open(), 
the window between lookup and fuse_send_open() would allow stat updates 
still before the file was exclusively locked.

Thanks,

Sweet Tea

