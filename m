Return-Path: <linux-fsdevel+bounces-29538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3D197A9D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 01:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E425E1F229AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 23:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1FA15B57A;
	Mon, 16 Sep 2024 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qrBvKWwL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA0514D43D;
	Mon, 16 Sep 2024 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726531119; cv=none; b=am+4SJXP2i8TafBBnyi2i+Orc8klMFeT6msd8c8ifOo2rvQiKsU813UzWdTRrja2e1IEbVIzPr1z/4HyuVOy0EUk7ImkjM1zcSxeb7ycwqpgO5s9kajX4qtJCL2iEvkUJqbH7mi5jNyqSgUawtIxonPzGn6MnMbfIOauhMVDdiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726531119; c=relaxed/simple;
	bh=jOPX79pQYTa+acSPRfSWzxYnVrqvjkdmS2IYO5zjv+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfPkehvf1YZXbkndPw9rRgUD53XeM8Gxk8lZIxqY6C9vfKp6SsC1KKSBgzHwrhV5YKBHQ9MsCRhlJrtehJgl+SwCo5dI5ZBCbOJtxH3+Rm8PtI+u3XbN9SrCoJF2WCjFvU78m5rN+2XxxaL967pBEfyGJ0nPdalfF5UA3hfA9o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qrBvKWwL; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726531108; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yLAj4r6pPBKpE+85JctjglgVpEkYjcC6fvMHSgvTiHQ=;
	b=qrBvKWwLGQdAVVqD2uCtMmWGr3fMkF6jPWqBweC5HV50hxYxJOr3B9iuz/EPgEUwT4LGbhQOTjauQhi9BO+xO8nhTDGS7WKx5AE5JLh6I2eLTRdHEIOlnHSZxVmU0viqbI4IXI2/ALVsOhBSdVPeE7nz6QUMXkdjPFFpCLJiZC4=
Received: from 30.27.106.17(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WF9MKgN_1726531106)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 07:58:27 +0800
Message-ID: <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
Date: Tue, 17 Sep 2024 07:58:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Gary Guo <gary@garyguo.net>, Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
 <20240916210111.502e7d6d.gary@garyguo.net>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240916210111.502e7d6d.gary@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gary,

On 2024/9/17 04:01, Gary Guo wrote:
> On Mon, 16 Sep 2024 21:56:13 +0800
> Yiyang Wu <toolmanp@tlmp.cc> wrote:
> 
>> Introduce Errno to Rust side code. Note that in current Rust For Linux,
>> Errnos are implemented as core::ffi::c_uint unit structs.
>> However, EUCLEAN, a.k.a EFSCORRUPTED is missing from error crate.
>>
>> Since the errno_base hasn't changed for over 13 years,
>> This patch merely serves as a temporary workaround for the missing
>> errno in the Rust For Linux.
>>
>> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> 
> As Greg said, please add missing errno that you need to kernel crate
> instead.

I've answered Greg about this in another email.

> 
> Also, it seems that you're building abstractions into EROFS directly
> without building a generic abstraction. We have been avoiding that. If
> there's an abstraction that you need and missing, please add that
> abstraction. In fact, there're a bunch of people trying to add FS

No, I'd like to try to replace some EROFS C logic first to Rust (by
using EROFS C API interfaces) and try if Rust is really useful for
a real in-tree filesystem.  If Rust can improve EROFS security or
performance (although I'm sceptical on performance), As an EROFS
maintainer, I'm totally fine to accept EROFS Rust logic landed to
help the whole filesystem better.

For Rust VFS abstraction, that is a different and indepenent story,
Yiyang don't have any bandwidth on this due to his limited time.
And I _also_ don't think an incomplete ROFS VFS Rust abstraction
is useful to Linux community (because IMO for generic interface
design, we need a global vision for all filesystems instead of
just ROFSes.  No existing user is not an excuse for an incomplete
abstraction.)

If a reasonble Rust VFS abstraction landed, I think we will switch
to use that, but as I said, they are completely two stories.

> support, please coordinate instead of rolling your own.
> 
> You also have been referencing `kernel::bindings::` directly in various
> places in the patch series. The module is marked as `#[doc(hidden)]`
> for a reason -- it's not supposed to referenced directly. It's only
> exposed so that macros can reference them. In fact, we have a policy
> that direct reference to raw bindings are not allowed from drivers.

This patch can be avoided if EUCLEAN is added to errno.

Thanks,
Gao Xiang

