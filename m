Return-Path: <linux-fsdevel+bounces-15976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3705D8965FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16B61F27466
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C15A5813E;
	Wed,  3 Apr 2024 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="T1gRHCQ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E125F45BE1;
	Wed,  3 Apr 2024 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128703; cv=none; b=sUxqJy3CNkLK0aPNwFTo+EL4Wwb40NYuJgObdbzPPLPBGrMMZoKrsdpElM4skMiHoa2SR89zUUVeUYfPirIH5ko+TRxfNMFer2IwchtpnA0+ApSl8xq5P7/RZe48uDakuCReb0rACrqxsJknH29jhPBoTZVSbg2CzwodkqIYrsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128703; c=relaxed/simple;
	bh=Bk9js/MfI08l6jPdLqN/viHKCIfVYvOaZJKwM1hfuAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nmxq4aeQXi1MrrrfM8nfEQwAaeh2/P4cri8FxvBJqOZBMwboWjs69i382ApxO/bMYWkXvClry0um8sd8qD0D5dK/X1xkwwKivMeeHSywEPVNh4KZ8ytLYs+U2iWMQg0H/VkVspDY/HQjmKNuW1At75VUGQ8SvWJDP0FTFiHhOfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=T1gRHCQ3; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 11456805C3;
	Wed,  3 Apr 2024 03:18:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712128701; bh=Bk9js/MfI08l6jPdLqN/viHKCIfVYvOaZJKwM1hfuAs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=T1gRHCQ3MCrsp7BfMW6trWrX3CG07X4l5PnpymJl0JYbPMVFO0jgcIAC9IlijYO98
	 OU54i3ohXtaZ9LWvI/hCX0o+C36Oyd7ghpaMFtwzgYM5RV1rkGnVG4KesUtwq8KN46
	 yx4PsB/fBGle4DGL+BMGxzH3mCPqyCIEJaqLgoLXOSYUII/txYsAaeRlYHDV9ybUK5
	 zbBDbv5xHI52C7ku00thZvfu4ujOW5TOYwNSgO5zheTpJXVCdZ2qnND22nRldTSLdI
	 U25dEAUVnRsEqgxow2Z3D7dgPQrRNuJBQsdAuXgijblEaLo9XayjheYeg4zOOV9TuH
	 B/2tfRedW2Tmw==
Message-ID: <851fd25e-78fd-4d6d-9572-f074a85bb30e@dorminy.me>
Date: Wed, 3 Apr 2024 03:18:19 -0400
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
 <ff320741-0516-410f-9aba-fc2d9d7a6b01@dorminy.me>
 <821adc74-1c35-4003-aa31-a2562791dde8@suse.com>
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <821adc74-1c35-4003-aa31-a2562791dde8@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/3/24 01:52, Qu Wenruo wrote:
> 
> 
> 在 2024/4/3 16:02, Sweet Tea Dorminy 写道:
> [...]
>>>
>>> fileoff 0, logical len 4k, phy 13631488, phy len 64K
>>> fileoff 4k, logical len 4k, phy 13697024, phy len 4k
>>> fileoff 8k, logical len 56k, phy 13631488 + 8k, phylen 56k
>>>
>>> [HOW TO CALCULATE WASTED SPACE IN USER SPACE]
>>> My concern is on the first entry. It indicates that we have wasted 
>>> 60K (phy len is 64K, while logical len is only 4K)
>>>
>>> But that information is not correct, as in reality we only wasted 4K, 
>>> the remaining 56K is still referred by file range [8K, 64K).
>>>
>>> Do you mean that user space program should maintain a mapping of each 
>>> utilized physical range, and when handling the reported file range 
>>> [8K, 64K), the user space program should find that the physical range 
>>> covers with one existing extent, and do calculation correctly?
>>
>> My goal is to give an unprivileged interface for tools like compsize 
>> to figure out how much space is used by a particular set of files. 
>> They report the total disk space referenced by the provided list of 
>> files, currently by doing a tree search (CAP_SYS_ADMIN) for all the 
>> extents pertaining to the requested files and deduplicating extents 
>> based on disk_bytenr.
>>
>> It seems simplest to me for userspace for the kernel to emit the 
>> entire extent for each part of it referenced in a file, and let 
>> userspace deal with deduplicating extents. This is also most similar 
>> to the existing tree-search based interface. Reporting whole extents 
>> gives more flexibility for userspace to figure out how to report 
>> bookend extents, or shared extents, or ...
> 
> That's totally fine, no matter what solution you go, (reporting exactly 
> as the on-disk file extent, or with offset into consideration), user 
> space always need to maintain some type of mapping to calculate the 
> wasted space by bookend extents.
> 
>>
>> It does seem a little weird where if you request with fiemap only e.g. 
>> 4k-16k range in that example file you'll get reported all 68k 
>> involved, but I can't figure out a way to fix that without having the 
>> kernel keep track of used parts of the extents as part of reporting, 
>> which sounds expensive.
> 
> I do not think mapping 4k-16K is a common scenario either, but since you 
> mentioned, at least we need a consistent way to emit a filemap entry.
> 
> The tracking part can be done in the user space.
> 
>>
>> You're right that I'm being inconsistent, taking off extent_offset 
>> from the reported disk size when that isn't what I should be doing, so 
>> I fixed that in v3.
>>
>>>
>>> [COMPRESSION REPRESENTATION]
>>> The biggest problem other than the complexity in user space is the 
>>> handling of compressed extents.
>>>
>>> Should we return the physical bytenr (disk_bytenr of file extent 
>>> item) directly or with the extent offset added?
>>> Either way it doesn't look consistent to me, compared to 
>>> non-compressed extents.
>>>
>>
>> As I understand it, the goal of reporting physical bytenr is to 
>> provide a number which we could theoretically then resolve into a disk 
>> location or few if we cared, but which doesn't necessarily have any 
>> physical meaning. To quote the fiemap documentation page: "It is 
>> always undefined to try to update the data in-place by writing to the 
>> indicated location without the assistance of the filesystem". So I 
>> think I'd prefer to always report the entire size of the entire extent 
>> being referenced.
> 
> The concern is, if we have a compressed file extent, reflinked to 
> different part of the file.
> 
> Then the fiemap returns all different physical bytenr (since offset is 
> added), user space tool have no idea they are the same extent on-disk.
> Furthermore, if we emit the physical + offset directly to user space 
> (which can be beyond the compressed extent), then we also have another 
> uncompressed extent at previous physical + offset.
> 
> Would that lead to bad calculation in user space to determine how many 
> bytes are really used?
> 
>>
>>> [ALTERNATIVE FORMAT]
>>> The other alternative would be following the btrfs ondisk format, 
>>> providing a unique physical bytenr for any file extent, then the 
>>> offset/referred length inside the uncompressed extent.
>>>
>>> That would handle compressed and regular extents more consistent, and 
>>> a little easier for user space tool to handle (really just a tiny bit 
>>> easier, no range overlap check needed), but more complex to 
>>> represent, and I'm not sure if any other filesystem would be happy to 
>>> accept the extra members they don't care.
>>
>> I really want to make sure that this interface reports the unused 
>> space in e.g bookend extents well -- compsize has been an important 
>> tool for me in this respect, e.g. a time when a 10g file was taking up 
>> 110g of actual disk space. If we report the entire length of the 
>> entire extent, then when used on whole files one can establish the 
>> space referenced by that file but not used; similarly on multiple 
>> files. So while I like the simplicity of just reporting the used 
>> length, I don't think there's a way to make compsize unprivileged with 
>> that approach.
> 
> Why not? In user space we just need to maintain a mapping of each 
> referred range.
> 
> Then we get the real actual disk space, meanwhile the fiemap report is 
> no different than "btrfs ins dump-tree" for file extents (we have all 
> the things we need, filepos, length (num_bytes), disk_bytenr, 
> disk_num_bytes, offset, and ram_bytes

The fiemap output (in this changeset) has equivalents of filepos, 
length; disk_bytenr + offset, disk_num_bytes - offset -- we don't get 
ram_bytes and we get two computed values from the three dump-tree outputs.
If it were reporting whole extents, it'd be disk_bytenr, disk_num_bytes, 
and we'd be missing offset.
I think we'd need a third piece of information about physical space in 
order to convey all three equivalents of disk_bytenr, disk_num_bytes, 
offset. And without that third piece of information, we can't both match 
up disk extents and also know exactly what disk bytenr data is stored 
at, I think? But maybe you're proposing exactly that, having a third number?

