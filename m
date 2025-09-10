Return-Path: <linux-fsdevel+bounces-60752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D37B5138C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 12:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B01F4E2054
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 10:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BF331576D;
	Wed, 10 Sep 2025 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AX0hEfls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A78A3093C9;
	Wed, 10 Sep 2025 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498982; cv=none; b=OuKqv8xFkdq0AxbqgAMJmfBzV+16MidjIC/2LRbWqfMu1wm8dEU05wWXJjUkRTorgywNH7Xe/axRMWMilKdP2ix6GZtwMY/qjLZCg8wLCPJnP+l1hf4qwjQxnFtQnPm8JZVD1ECZl9dQRyoREVMTEAFkSJ8eCPxI7Cycj6oVIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498982; c=relaxed/simple;
	bh=1UvNFkY9J6CckYEK5bZDHatUQZ3qeTYpEL85P5I5lHc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=l5N+OBIW+RNP63F4VrZ2sxjW/U3HSSRirYliCeaVuMDE26AYiCKtZmmEKgiulUO7ag7iaZ/I2uoquyvlSqtdk96GTrYT08/S6+iPFNqrgnTln2yy5ONN/Dno7AT/ih0h2AgmgOY/t8XaJs/Ko25LgPgSiufLKgNRdfsyH5TjTLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AX0hEfls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C297CC4CEF0;
	Wed, 10 Sep 2025 10:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757498982;
	bh=1UvNFkY9J6CckYEK5bZDHatUQZ3qeTYpEL85P5I5lHc=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=AX0hEflskIl9B/vFLEUSTKk6AnoTe9UBYRjcSGuK2QLWGx6jgxPCvO56N8sDtALTb
	 RxrD/y/OA/AN0mjw6DltCgw67PlLAPoeAy0+Tmgo6TJbjdIbW9R8OUJEYf0qIgOdjT
	 YWJG/Ir25IwtaQnhMa2+jEdO/lRJESEILDEH7za3pWzv/WAztMeQ0Y/1Z/NOXNxlMn
	 GupwBvbPQIHKqQkRtN6sBSvaMUGdOtsjnG3PUsEmakMVFMdR0c/elor0IA9uRG39DF
	 wEjquPgEnXAJdRr31fn02lIbQeLR9howH2rrgOlImauVukGM6nLjfYlNwuom8MnRQ9
	 4cmolwxpT7e3A==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 12:09:38 +0200
Message-Id: <DCP1E4UJ385D.JEXXJV4PPLJS@kernel.org>
To: "Greg KH" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] USB: core: remove the move buf action
Cc: "Edward Adam Davis" <eadavis@qq.com>,
 <syzbot+b6445765657b5855e869@syzkaller.appspotmail.com>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rafael@kernel.org>, <syzkaller-bugs@googlegroups.com>
References: <68c118e8.a70a0220.3543fc.000e.GAE@google.com>
 <tencent_B32D6D8C9450EBFEEE5ACC2C7B0E6C402D0A@qq.com>
 <2025091007-stricken-relock-ef72@gregkh>
In-Reply-To: <2025091007-stricken-relock-ef72@gregkh>

On Wed Sep 10, 2025 at 11:00 AM CEST, Greg KH wrote:
> On Wed, Sep 10, 2025 at 03:58:47PM +0800, Edward Adam Davis wrote:
>> The buffer size of sysfs is fixed at PAGE_SIZE, and the page offset
>> of the buf parameter of sysfs_emit_at() must be 0, there is no need
>> to manually manage the buf pointer offset.
>>=20
>> Fixes: 711d41ab4a0e ("usb: core: Use sysfs_emit_at() when showing dynami=
c IDs")
>> Reported-by: syzbot+b6445765657b5855e869@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=3Db6445765657b5855e869
>> Tested-by: syzbot+b6445765657b5855e869@syzkaller.appspotmail.com
>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>> ---
>>  drivers/usb/core/driver.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> While this fix looks correct, your cc: list is very odd as this is a
> linux-usb bug, not a driver core issue, right?

I think Edward derived the Cc: list from the recipients of the syzbot repor=
t
in [1].

Not sure how syzbot figures out the relevant recipients to send the report =
to
though. :)

[1] https://lore.kernel.org/all/68c118e8.a70a0220.3543fc.000e.GAE@google.co=
m/

