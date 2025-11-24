Return-Path: <linux-fsdevel+bounces-69686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42808C81139
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 375CF4E4F14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 14:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1587E2820DB;
	Mon, 24 Nov 2025 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="dCMc99RX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2DC283129;
	Mon, 24 Nov 2025 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995266; cv=none; b=SnFSnCUcykxOPPWHp19/fkcgYZarMvSZlD9Kw2DjHNhnxGipUv4QrBQpeln4Xky3BLcWBfWT/i+KPkSf0x9NaxRgYqe5Y/locXTFYOv+BAum4+VixtlAXa0LywJuMJ/4oYFMOP0nBoS0xYjLMLsa6UnkxNMRCzVApFnirRC6LkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995266; c=relaxed/simple;
	bh=c31krYZOvEW1zLqANNmn2JHy7OgtRs74OUcPCcCmGic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFT+WSErzLfZ0M/J1Macw9JB7okHjeoqMR/9Xk+S52Qg6Copgro6BohSO7RNdbmhx2CwRZM5gKW1l1PAkCV2i8D3edkWJy3S0+jRgmJ3EFwtY1ccdiVB3Q3wuiuyPpQKyXfVm0JB1+2hZJDCygmsmMw48xh+2EQaELQuX+55tMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=dCMc99RX; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=OvcAVI+ceoeNJ66k9onkDPL8+bvLcfHJSQM9OZ9OQcM=; b=dCMc99RXc8Pzr4UJPfQ5KlW1yJ
	HWrYEXr1lC4EYj4gyJyRuuYUrkDcBH+X3AiXkaWynrQ+wNoCtzH5+SwABnvsYxuqYX4kkl+IYeq5f
	Q2b0PbXfiO76K+tRpsMrc1YbAYvP0Dgx0zPrPp/HExphPxXfc4Ed+9bz9G1vFSq4X+nhaTArYBtiB
	1euvCaR8lGhk7HgsbVAoGIxT1IAi/+0xkviB1UpZHC5n1M2FWANJHyHyWw4aBQaP9W7pmavwkd5fI
	t7Er4z3wHSbGfSgEAzwK07f+rMSMz/YQU/WUkHmHTNvAkhIQQ85A/SyF+OiddUXyAakJBe2NxFZCV
	so2EoUTZ6mQgWMdpSgd/5L6I4HeFxHgQgj+SCBKLEy1Sr6nd+mqub/qRJS7Nh/sHR88MfNyjC4DYO
	J2jI/WGyob19SLNEFd8/ohVmFXm45tetuNVcbmIIu70FfduxfeuNNVI75lQTERaTPpj+Idh/3ALrB
	4wVAU3pPsqqP91JkMViPvCUy;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vNXkR-00FQB0-1r;
	Mon, 24 Nov 2025 14:40:59 +0000
Message-ID: <ad8ef7da-db2a-4033-8701-cf2fc61b8a1d@samba.org>
Date: Mon, 24 Nov 2025 15:40:59 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] cifs: Clean up some places where an extra kvec[]
 was required for rfc1002
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
 Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tom Talpey <tom@talpey.com>
References: <7b897d50-f637-4f96-ba64-26920e314739@samba.org>
 <20251124124251.3565566-1-dhowells@redhat.com>
 <20251124124251.3565566-8-dhowells@redhat.com>
 <3635951.1763995018@warthog.procyon.org.uk>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <3635951.1763995018@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 24.11.25 um 15:36 schrieb David Howells:
> Hi Stefan,
> 
> Stefan Metzmacher <metze@samba.org> wrote:
> 
>> I had to squash this into the patch
>>
>> I'm using smatch when building and got the following error
>> with this change:
>>
>>      client/transport.c:1073 compound_send_recv() error: we previously assumed 'resp_iov' could be null (see line 1051)
>> ...
>>   	if ((ses->ses_status == SES_NEW) || (optype & CIFS_NEG_OP) || (optype & CIFS_SESS_OP)) {
> 
> In this case smatch is wrong, though it can't work this out as the context
> spans more than one file.  This clause applies only to certain operations
> (such as session setup and negotiate) that will always have a response buffer.
> But I've no objection to adding this warning to splat the warning.

Ok, I can just squash as well as the EIO changes below my branch
I'll hopefully be able to post later today or tomorrow.

My idea would be that my branch would replace ksmbd-for-next
and add your any my changes on top.

Thanks!
metze

