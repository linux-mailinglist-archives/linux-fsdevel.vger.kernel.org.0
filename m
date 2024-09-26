Return-Path: <linux-fsdevel+bounces-30145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0215B986F40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 10:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BB2FB22168
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 08:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068411A7256;
	Thu, 26 Sep 2024 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vHPIi/v1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB9C22318;
	Thu, 26 Sep 2024 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340527; cv=none; b=Vc7oe0FUDWSf8bxKs6eNTRhGdj+l6OVRcC90UdCfrGxZfaIclGfdpPM4i7mhmy3p3qgBdOeWRnQLz/cX7SNcAz7acTScpelWhTibo1WDeghAcC2HqJn92dWvIMefjSZCaNWVgnR+XQfYkx3PLHOoRvoB0qsVFXkVknC+8sj3uzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340527; c=relaxed/simple;
	bh=DCQ2pc7FZkSIz/C9VVBl6Bnm3uHB7Myprvos+/WrPwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hn3rocqVKLml9aF69pHGeEaovgzqXrr3a9RAG15QZlCu0PKScMaj8Tz0TK7IOrsFGmb5YPH6YHPqpgOf6RMZpo/x6nzx4nyeAkC47dlzUA2gpTYLqw164quTbLs4t5Q8WGD2w8h3sOmyOEmT9Xb4QiLMTYA7A6RGKxmzoONLo7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vHPIi/v1; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727340516; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vql8xWm4ugnb2a4wcV5wGjvZCN0btIoVoInfiJaEEYI=;
	b=vHPIi/v1fAJX+fRvuqucuw0BGnyOp8n77cbxersp/WObTzYPhVXIe9Xtrq/HRzlM9Fm2T6oZI/xAY6C8u4hZ/XwzXMvw2XiVxFSdg3M3Kwm4ZttvV+CM9lL4OWpsPFhgBYqiJvtRn5oMgTyRukEsiah3ylPnZTGXzcMA9LBTp5s=
Received: from 30.221.129.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFmi89h_1727340514)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 16:48:35 +0800
Message-ID: <4c4e92bf-663f-4acf-a812-782536bf34d4@linux.alibaba.com>
Date: Thu, 26 Sep 2024 16:48:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Ariel Miculas <amiculas@cisco.com>
Cc: Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Gary Guo <gary@garyguo.net>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
References: <20240916210111.502e7d6d.gary@garyguo.net>
 <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
 <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
 <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
 <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
 <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/26 16:10, Ariel Miculas via Linux-erofs wrote:
> On 24/09/26 09:04, Gao Xiang wrote:
>>
>>
>> On 2024/9/26 08:40, Gao Xiang wrote:
>>>
>>>
>>> On 2024/9/26 05:45, Ariel Miculas wrote:
>>
>> ...
>>
>>>>
>>>> I honestly don't see how it would look good if they're not using the
>>>> existing filesystem abstractions. And I'm not convinced that Rust in the
>>>> kernel would be useful in any way without the many subsystem
>>>> abstractions which were implemented by the Rust for Linux team for the
>>>> past few years.
>>>
>>> So let's see the next version.
>>
>> Some more words, regardless of in-tree "fs/xfs/libxfs",
>> you also claimed "Another goal is to share the same code between user
>> space and kernel space in order to provide one secure implementation."
>> for example in [1].
>>
>> I wonder Rust kernel VFS abstraction is forcely used in your userspace
>> implementation, or (somewhat) your argument is still broken here.
> 
> Of course the implementations cannot be identical, but there is a lot of
> shared code between the user space and kernel space PuzzleFS
> implementations. The user space implementation uses the fuser [1] crate
If you know what you're doing, you may know what Yiyang is doing
here, he will just form a Rust EROFS core logic and upstream later.

Thanks,
Gao Xiang


