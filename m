Return-Path: <linux-fsdevel+bounces-29540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B7C97A9E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 02:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C403BB23069
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 00:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489BF611E;
	Tue, 17 Sep 2024 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="n51OusJS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0DA7F6;
	Tue, 17 Sep 2024 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726532299; cv=none; b=PxgJUUKdrOYrz3+0v4a+FjPZjEuWSziqZepAH6Cv7uK+wlstQjpgFJTVHr7wAvCCk5VSy0x8VYuQCDEXY5xWztMNeBpTUcQSzoK57tB9TgakKpDgFzCOCTcLRPA1OZWD72ONpgbncGgXnZadaLJc7PHR5Kum69IoChKlwLjTtPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726532299; c=relaxed/simple;
	bh=WoOQFaL0Y91OIdupY2RuKodx73uY16jH/9yrW8snJOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItsBaQkRaZA6pUs9Zc5CaDBl4I4VLLPVn+PJlvfN3z5h8Ap4F/D2L079i/BhOKiC8YjH6kT4G13M8wKJW8+Yz7ptThHgv6EpWoI8gXY6ifXvG/LUBj3evAb0dogmrFKtxEwGlbTBgXsaNcp0vvNHBc3u/MfGTCoqu0Ypgz7gdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=n51OusJS; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726532288; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7GIfLCzeyMWB6rR4gwhPkw73w43jwPFWmSDKoY5Td70=;
	b=n51OusJSW6EkSmJH04obf0NssvbHBOESLGDGO7yR9gayqfoLrw8teR7IXxAwz2OeKzFRwqvljz60rs9AMb9SkISN0qwD7Ene1XW5voa7YezyVbWy1lWeDJCzUSzYG3e5fuPSamQeTfqp8wB6c2+dOgcDholOGDDRRw/gbo/w04Y=
Received: from 30.27.106.17(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WF9M2-u_1726532286)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 08:18:07 +0800
Message-ID: <aa7a902a-25f6-491c-88a3-ad0a3204d2ff@linux.alibaba.com>
Date: Tue, 17 Sep 2024 08:18:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/24] erofs: add superblock data structure in Rust
To: Greg KH <gregkh@linuxfoundation.org>, Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-3-toolmanp@tlmp.cc>
 <2024091655-sneeze-pacify-cf28@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024091655-sneeze-pacify-cf28@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

On 2024/9/17 01:55, Greg KH wrote:
> On Mon, Sep 16, 2024 at 09:56:12PM +0800, Yiyang Wu wrote:
>> diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
>> new file mode 100644
>> index 000000000000..0f1400175fc2
>> --- /dev/null
>> +++ b/fs/erofs/rust/erofs_sys.rs
>> @@ -0,0 +1,22 @@
>> +#![allow(dead_code)]
>> +// Copyright 2024 Yiyang Wu
>> +// SPDX-License-Identifier: MIT or GPL-2.0-or-later
> 
> Sorry, but I have to ask, why a dual license here?  You are only linking
> to GPL-2.0-only code, so why the different license?  Especially if you
> used the GPL-2.0-only code to "translate" from.
> 
> If you REALLY REALLY want to use a dual license, please get your
> lawyers to document why this is needed and put it in the changelog for
> the next time you submit this series when adding files with dual
> licenses so I don't have to ask again :)

As a new Rust kernel developper, Yiyang is working on EROFS Rust
userspace implementation too.

I think he just would like to share the common Rust logic between
kernel and userspace.  Since for the userspace side, Apache-2.0
or even MIT is more friendly for 3rd applications (especially
cloud-native applications). So the dual license is proposed here,
if you don't have strong opinion, I will ask Yiyang document this
in the next version.  Or we're fine to drop MIT too.

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h


