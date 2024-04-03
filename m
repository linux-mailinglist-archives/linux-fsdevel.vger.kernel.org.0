Return-Path: <linux-fsdevel+bounces-15970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991E089640C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5058B284BB3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 05:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D37487B3;
	Wed,  3 Apr 2024 05:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="MlpXF1Lc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2153C46425;
	Wed,  3 Apr 2024 05:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712122363; cv=none; b=Z9G2ctFlO0GOgsjoJkalbJ2rLBBAwkzxD3rMXbbrX9kqjkLFPVwboIyn6EE/XMF7SH7fiPl0KDycYPuytAvsH5C9R2H4fKkTQwDB4bCquDdZ4PNfpmY0d59WFoU1vXrSB1O6Gl45UvZIL6xJFT2Rfr3xrb+Sun4eZqdDFJgGI0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712122363; c=relaxed/simple;
	bh=NRiy2LGJHBtCVOE6rfX9SqNFWfLvoY+5HcH/4vLD7bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jrMvUN/VlrhJ90jrObtWeKT5ZS8anqO37WmbtCnC371w0Exw2ehM7NSnn5L09jzXK2hgbtx2YMl3oLg1urTqS1AdeE789CRSOnyQmXQkNoQF78RKHxi+YU/TTzp/69c5DClv1OCWwI4dTD0n3aBBPwWJZceLpDkOnPDY1yZQLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=MlpXF1Lc; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id B5D63807C8;
	Wed,  3 Apr 2024 01:32:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712122354; bh=NRiy2LGJHBtCVOE6rfX9SqNFWfLvoY+5HcH/4vLD7bQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=MlpXF1LcmKpE26Q6X3yy3eCYlZqQU2KcgdjnVJSAEKvnY8rHu8l5pFY+AQaMYRRuj
	 gIee5zuj7ETV/9qWlFN9+cpuspm4vkFJYddmWJ59/HiDTExS79MzpUr1ce9hOv162K
	 zvvOfCizde1o9nK39WuLBNfhaZoy9yxtXD844EQpxeoD3RK5SSGloaw0sYWwIfAZAR
	 srwqZzl2ScCqTN+VBjx4WggowP7gc0XFCSqHV0+wFNFsy2RRSSkKf3usSKCEokP9CM
	 TSicEaw0nYMN0DTg0CUMcYa1XLiSbU0LnzZ0inDv0b6YnuaHxiF8Ef5uB3GN2gswPb
	 NNM/Rz9TghlDA==
Message-ID: <ff320741-0516-410f-9aba-fc2d9d7a6b01@dorminy.me>
Date: Wed, 3 Apr 2024 01:32:31 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/5] btrfs: fiemap: return extent physical size
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-doc@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <cover.1711588701.git.sweettea-kernel@dorminy.me>
 <93686d5c4467befe12f76e4921bfc20a13a74e2d.1711588701.git.sweettea-kernel@dorminy.me>
 <a2d3cdef-ed4e-41f0-b0d9-801c781f9512@suse.com>
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <a2d3cdef-ed4e-41f0-b0d9-801c781f9512@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/31/24 05:03, Qu Wenruo wrote:
> 
> 
> 在 2024/3/28 11:52, Sweet Tea Dorminy 写道:
>> Now that fiemap allows returning extent physical size, make btrfs return
>> the appropriate extent's actual disk size.
>>
>> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> [...]
>> @@ -3221,7 +3239,9 @@ int extent_fiemap(struct btrfs_inode *inode, 
>> struct fiemap_extent_info *fieinfo,
>>               ret = emit_fiemap_extent(fieinfo, &cache, key.offset,
>>                            disk_bytenr + extent_offset,
>> -                         extent_len, flags);
>> +                         extent_len,
>> +                         disk_size - extent_offset,
> 
> This means, we will emit a entry that uses the end to the physical 
> extent end.
> 
> Considering a file layout like this:
> 
>      item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
>          generation 7 type 1 (regular)
>          extent data disk byte 13631488 nr 65536
>          extent data offset 0 nr 4096 ram 65536
>          extent compression 0 (none)
>      item 7 key (257 EXTENT_DATA 4096) itemoff 15763 itemsize 53
>          generation 8 type 1 (regular)
>          extent data disk byte 13697024 nr 4096
>          extent data offset 0 nr 4096 ram 4096
>          extent compression 0 (none)
>      item 8 key (257 EXTENT_DATA 8192) itemoff 15710 itemsize 53
>          generation 7 type 1 (regular)
>          extent data disk byte 13631488 nr 65536
>          extent data offset 8192 nr 57344 ram 65536
>          extent compression 0 (none)
> 
> For fiemap, we would got something like this:
> 
> fileoff 0, logical len 4k, phy 13631488, phy len 64K
> fileoff 4k, logical len 4k, phy 13697024, phy len 4k
> fileoff 8k, logical len 56k, phy 13631488 + 8k, phylen 56k
> 
> [HOW TO CALCULATE WASTED SPACE IN USER SPACE]
> My concern is on the first entry. It indicates that we have wasted 60K 
> (phy len is 64K, while logical len is only 4K)
> 
> But that information is not correct, as in reality we only wasted 4K, 
> the remaining 56K is still referred by file range [8K, 64K).
> 
> Do you mean that user space program should maintain a mapping of each 
> utilized physical range, and when handling the reported file range [8K, 
> 64K), the user space program should find that the physical range covers 
> with one existing extent, and do calculation correctly?

My goal is to give an unprivileged interface for tools like compsize to 
figure out how much space is used by a particular set of files. They 
report the total disk space referenced by the provided list of files, 
currently by doing a tree search (CAP_SYS_ADMIN) for all the extents 
pertaining to the requested files and deduplicating extents based on 
disk_bytenr.

It seems simplest to me for userspace for the kernel to emit the entire 
extent for each part of it referenced in a file, and let userspace deal 
with deduplicating extents. This is also most similar to the existing 
tree-search based interface. Reporting whole extents gives more 
flexibility for userspace to figure out how to report bookend extents, 
or shared extents, or ...

It does seem a little weird where if you request with fiemap only e.g. 
4k-16k range in that example file you'll get reported all 68k involved, 
but I can't figure out a way to fix that without having the kernel keep 
track of used parts of the extents as part of reporting, which sounds 
expensive.

You're right that I'm being inconsistent, taking off extent_offset from 
the reported disk size when that isn't what I should be doing, so I 
fixed that in v3.

> 
> [COMPRESSION REPRESENTATION]
> The biggest problem other than the complexity in user space is the 
> handling of compressed extents.
> 
> Should we return the physical bytenr (disk_bytenr of file extent item) 
> directly or with the extent offset added?
> Either way it doesn't look consistent to me, compared to non-compressed 
> extents.
> 

As I understand it, the goal of reporting physical bytenr is to provide 
a number which we could theoretically then resolve into a disk location 
or few if we cared, but which doesn't necessarily have any physical 
meaning. To quote the fiemap documentation page: "It is always undefined 
to try to update the data in-place by writing to the indicated location 
without the assistance of the filesystem". So I think I'd prefer to 
always report the entire size of the entire extent being referenced.

> [ALTERNATIVE FORMAT]
> The other alternative would be following the btrfs ondisk format, 
> providing a unique physical bytenr for any file extent, then the 
> offset/referred length inside the uncompressed extent.
> 
> That would handle compressed and regular extents more consistent, and a 
> little easier for user space tool to handle (really just a tiny bit 
> easier, no range overlap check needed), but more complex to represent, 
> and I'm not sure if any other filesystem would be happy to accept the 
> extra members they don't care.

I really want to make sure that this interface reports the unused space 
in e.g bookend extents well -- compsize has been an important tool for 
me in this respect, e.g. a time when a 10g file was taking up 110g of 
actual disk space. If we report the entire length of the entire extent, 
then when used on whole files one can establish the space referenced by 
that file but not used; similarly on multiple files. So while I like the 
simplicity of just reporting the used length, I don't think there's a 
way to make compsize unprivileged with that approach.

Thank you!!

