Return-Path: <linux-fsdevel+bounces-29546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F21D297AB29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 07:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E53BFB2C872
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 05:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CE06CDBA;
	Tue, 17 Sep 2024 05:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ghpYZ6Ea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0DF4595B;
	Tue, 17 Sep 2024 05:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551956; cv=none; b=XBHR4w+KaXteX0qAJ/lw88H3mq7cIaHqBbAgODIHKYrpUDj2drbrmiCMdO4POwl9aFAKhwcXR2LNWnG5SP4cdjKsUn8OK+P0qlvPhUmtTgc0RWxH4wH6AZ0+D7Yf34Y9+B5+LkxHxT+VIqTbwWWdgigJ7z5pmU4arGWI+pqMnis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551956; c=relaxed/simple;
	bh=mP3PoPRK7kLa1mY1jxVsusmKfpieOKIdeJVcjXDMbCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSsH2E1HWoIS9uFpr4JVHUSRxkqkjxjBrc4MO0fZJhcjWJp8gfOsIPXmsslUekz3kexkffNoIrpJNHLQ2H7/SSRYnEMsBow4jUG0P+7lh5Bq9ymMyCCJjWCAXwWc+Ax//7Ax3VNY501fr/KWEM0ZC5cb5QxsCxVD0vhI42prCOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ghpYZ6Ea; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726551945; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xDEH82Zgluj/gfAW11o3LnXM+W8TtjK147IvqunUm2g=;
	b=ghpYZ6Ea2se7xsb0fcZato4y76PVigL85cuzbVMlTSg9yu0NU1Eurx2FbsKzMGQKsfB8lNr+2BddE7B922b3PF1ZK0X5iKZ7vsgO4SjU3b9K9054ojDbtNPiCO63NtwFe8VhrYpOHypKBkoCLfZVzk6LfHYOnYoRctOSez787tw=
Received: from 30.27.106.17(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFA17GO_1726551943)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 13:45:44 +0800
Message-ID: <35fbc99c-b914-4a0e-92c1-d680a3ae2345@linux.alibaba.com>
Date: Tue, 17 Sep 2024 13:45:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/24] erofs: add superblock data structure in Rust
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Yiyang Wu <toolmanp@tlmp.cc>, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 rust-for-linux@vger.kernel.org
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-3-toolmanp@tlmp.cc>
 <2024091655-sneeze-pacify-cf28@gregkh>
 <aa7a902a-25f6-491c-88a3-ad0a3204d2ff@linux.alibaba.com>
 <2024091702-easiest-prelude-7d4f@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024091702-easiest-prelude-7d4f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/17 13:34, Greg KH wrote:
> On Tue, Sep 17, 2024 at 08:18:06AM +0800, Gao Xiang wrote:
>> Hi Greg,
>>
>> On 2024/9/17 01:55, Greg KH wrote:
>>> On Mon, Sep 16, 2024 at 09:56:12PM +0800, Yiyang Wu wrote:
>>>> diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
>>>> new file mode 100644
>>>> index 000000000000..0f1400175fc2
>>>> --- /dev/null
>>>> +++ b/fs/erofs/rust/erofs_sys.rs
>>>> @@ -0,0 +1,22 @@
>>>> +#![allow(dead_code)]
>>>> +// Copyright 2024 Yiyang Wu
>>>> +// SPDX-License-Identifier: MIT or GPL-2.0-or-later
>>>
>>> Sorry, but I have to ask, why a dual license here?  You are only linking
>>> to GPL-2.0-only code, so why the different license?  Especially if you
>>> used the GPL-2.0-only code to "translate" from.
>>>
>>> If you REALLY REALLY want to use a dual license, please get your
>>> lawyers to document why this is needed and put it in the changelog for
>>> the next time you submit this series when adding files with dual
>>> licenses so I don't have to ask again :)
>>
>> As a new Rust kernel developper, Yiyang is working on EROFS Rust
>> userspace implementation too.
>>
>> I think he just would like to share the common Rust logic between
>> kernel and userspace.
> 
> Is that actually possible here?  This is very kernel-specific code from
> what I can tell, and again, it's based on the existing GPL-v2 code, so
> you are kind of changing the license in the transformation to a
> different language, right?

It's possible, Yiyang implemented a total userspace Rust crates
to parse EROFS format with limited APIs:

https://github.com/ToolmanP/erofs-rs

Also take another C example, kernel XFS (fs/libxfs) and xfsprogs
(userspace) use the same codebase.  Although they both use GPL
license only.

> 
>> Since for the userspace side, Apache-2.0
>> or even MIT is more friendly for 3rd applications (especially
>> cloud-native applications). So the dual license is proposed here,
>> if you don't have strong opinion, I will ask Yiyang document this
>> in the next version.  Or we're fine to drop MIT too.
> 
> If you do not have explicit reasons to do this, AND legal approval with
> the understanding of how to do dual license kernel code properly, I
> would not do it at all as it's a lot of extra work.  Again, talk to your
> lawyers about this please.  And if you come up with the "we really want
> to do this," great, just document it properly as to what is going on
> here and why this decision is made.

Ok, then let's stay with GPL only.  Although as I mentioned,
cloud-native applications are happy with Apache-2.0 or MIT, which
means there could be diverged for kernel and userspace on the Rust
side too.

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h


