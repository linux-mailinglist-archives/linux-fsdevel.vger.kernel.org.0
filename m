Return-Path: <linux-fsdevel+bounces-15973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF4F896454
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 08:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB83B23C05
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 06:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1C04EB5F;
	Wed,  3 Apr 2024 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="OQr4Z5gg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E834D117;
	Wed,  3 Apr 2024 06:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712124153; cv=none; b=KHPv2VHGRTk/4YXTT+x17ZbKgBdGEPHDkCrEMNScD2dW9OeeC/alS+Exm2uU1bON9NoKoaLVEZEW3PmLh9epJEUn+h/Gu1PkAP5+ShH7v9GfsP6n8myVgn8K+luFLPatwIEMaa7xLavEDWjXtc0HjNYbeAFb1i7YueEuf5fAjTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712124153; c=relaxed/simple;
	bh=rzXbHeyJ/9o+6UEDEOJYVqyrbxJV+Tcf6YMwKwFBkBQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=h8+hSB+QBrUeZlngcATZf52Q7Q4yHCa+c5IftGDW2embJjAhUSPyxiMOBBg7NSTRoDAacmWU2TCGZy98h6IWziQPv3jFfWQJuYeEuvnXPlwMk2Eyvq2YBH2YSEOjkZizfKh/5/tmpbqmB0sR7jOkCUa0TQBfd5Hfp/uIti+l1xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=OQr4Z5gg; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id C0E7080818;
	Wed,  3 Apr 2024 02:02:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712124150; bh=rzXbHeyJ/9o+6UEDEOJYVqyrbxJV+Tcf6YMwKwFBkBQ=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=OQr4Z5ggeR/gh79M0z9MJwXoIMiY8Lp+Z3jHON0B+EeHFQ5QQbSdyIdz3fhhhe+OC
	 kK56COJmGDpWFvgXgLDK7UgQndSNp447NDlTbQcUdAR9OSefTCogo18TQNunYaZ63c
	 vOYaK4V6jX4Ll8fR4pQ0hcf1qycRqoM/RfIn+TSUOkQqsYuVmrvmcPt1ZolGdbc5TQ
	 05RQfBA+pMswHMlPPHWY65Y0r1Gkq1YKtqmlTvRPcrNsUMu0OeHALLAO7QsXrWdJLi
	 wGe7zfn9Hc8Zr6bZQibHfFmQ6lKxi/CbrcpvqKYKweEF/SaRcoMGEy+Ce9jPkdBTBD
	 rBX8pR+K8Kmiw==
Message-ID: <d01b4606-38fa-4f27-8fbd-31de505ba3a3@dorminy.me>
Date: Wed, 3 Apr 2024 02:02:27 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/5] btrfs: fiemap: return extent physical size
Content-Language: en-US
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: Qu Wenruo <wqu@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-doc@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <cover.1711588701.git.sweettea-kernel@dorminy.me>
 <93686d5c4467befe12f76e4921bfc20a13a74e2d.1711588701.git.sweettea-kernel@dorminy.me>
 <a2d3cdef-ed4e-41f0-b0d9-801c781f9512@suse.com>
 <ff320741-0516-410f-9aba-fc2d9d7a6b01@dorminy.me>
In-Reply-To: <ff320741-0516-410f-9aba-fc2d9d7a6b01@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>> This means, we will emit a entry that uses the end to the physical 
>> extent end.
>>
>> Considering a file layout like this:
>>
>>      item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
>>          generation 7 type 1 (regular)
>>          extent data disk byte 13631488 nr 65536
>>          extent data offset 0 nr 4096 ram 65536
>>          extent compression 0 (none)
>>      item 7 key (257 EXTENT_DATA 4096) itemoff 15763 itemsize 53
>>          generation 8 type 1 (regular)
>>          extent data disk byte 13697024 nr 4096
>>          extent data offset 0 nr 4096 ram 4096
>>          extent compression 0 (none)
>>      item 8 key (257 EXTENT_DATA 8192) itemoff 15710 itemsize 53
>>          generation 7 type 1 (regular)
>>          extent data disk byte 13631488 nr 65536
>>          extent data offset 8192 nr 57344 ram 65536
>>          extent compression 0 (none)
>>
>> For fiemap, we would got something like this:
>>
>> fileoff 0, logical len 4k, phy 13631488, phy len 64K
>> fileoff 4k, logical len 4k, phy 13697024, phy len 4k
>> fileoff 8k, logical len 56k, phy 13631488 + 8k, phylen 56k
>>
>> [HOW TO CALCULATE WASTED SPACE IN USER SPACE]
>> My concern is on the first entry. It indicates that we have wasted 60K 
>> (phy len is 64K, while logical len is only 4K)
>>
>> But that information is not correct, as in reality we only wasted 4K, 
>> the remaining 56K is still referred by file range [8K, 64K).
>>
>> Do you mean that user space program should maintain a mapping of each 
>> utilized physical range, and when handling the reported file range 
>> [8K, 64K), the user space program should find that the physical range 
>> covers with one existing extent, and do calculation correctly?
> 
> My goal is to give an unprivileged interface for tools like compsize to 
> figure out how much space is used by a particular set of files. They 
> report the total disk space referenced by the provided list of files, 
> currently by doing a tree search (CAP_SYS_ADMIN) for all the extents 
> pertaining to the requested files and deduplicating extents based on 
> disk_bytenr.
> 
> It seems simplest to me for userspace for the kernel to emit the entire 
> extent for each part of it referenced in a file, and let userspace deal 
> with deduplicating extents. This is also most similar to the existing 
> tree-search based interface. Reporting whole extents gives more 
> flexibility for userspace to figure out how to report bookend extents, 
> or shared extents, or ...
> 
> It does seem a little weird where if you request with fiemap only e.g. 
> 4k-16k range in that example file you'll get reported all 68k involved, 
> but I can't figure out a way to fix that without having the kernel keep 
> track of used parts of the extents as part of reporting, which sounds 
> expensive.
> 
> You're right that I'm being inconsistent, taking off extent_offset from 
> the reported disk size when that isn't what I should be doing, so I 
> fixed that in v3.

Ah, I think I grasp a point I'd missed before.
- Without setting disk_bytenr to the actual start of the data on disk, 
there's no way to find the location of the actual data on disk within 
the extent from fiemap alone
- But reporting disk_bytenr + offset, to get actual start of data on 
disk, means we need to report a physical size to figure out the end of 
the extent and we can't know the beginning.

We can't convey both actual location, start, and end of the extent in 
just two pieces of information.

On the other hand, if someone really needs to know the actual location 
on disk of their data, they could use the tree_search ioctl as root to 
do so?

So I still think we should be reporting entire extents but am less 
confident that it doesn't break existing users. I am not sure how common 
it is to take fiemap output on btrfs and use it to try to get to 
physical data on disk - do you know of a tool that does so?

Thank you!

