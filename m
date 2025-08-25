Return-Path: <linux-fsdevel+bounces-59115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F59CB34959
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 19:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B79C7AC91A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE15304975;
	Mon, 25 Aug 2025 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TpJqZ5zP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB632E1EE6;
	Mon, 25 Aug 2025 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144355; cv=none; b=rx+vQOMGPl5jgKKb8WvWvAtwXoH9hp5Awn0OkM3zjxh160DtjtVBf1/e/Lon6UOuz7ljXgdxAGU1WxBVJmDA8XV593GYLBxHn8peD1XelUtN6JA48xvGS7+7yijLdCWBzErmtGJdiXMTVmcGzHHRsXKfHpWxd+XKx7nSOhElnQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144355; c=relaxed/simple;
	bh=+r4/vSpjwmPmrdxo+7nWUwBlgS2KHEGTtd/DtLd7Srg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+xNTtD2abajoZz3pE93UTIAdeJpWJ+xpPB86fQlm/RsJbiapvo1T3AX8Q5DiAWkynpxU71IaiQl5yvRjkPwLMos/ROILCHgehjl5vIXCuk63n+3rrAASfkC3HcaTYzfY4jAxDOcHMycmkroKUG1jF2CKDAwmGqg9HrB1/2fAgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TpJqZ5zP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=EeQgxrkP4KH8iLZz1W6HjZ1yyvbTPOkIS8xnCG44mfw=; b=TpJqZ5zP4aP8kC7kxuzuTyDmFB
	LbuF+KWibzw6hBm8c9QgHskTJw2Pkocli8jtUywKunC11x7Ncb6hBSWydOfPV2nWDmOpF2bGboY1H
	61BSY76yrYLFuMniFEMyPVo7Ed8a7UHjdaJ0zU6v96NEfw6XUZnsFpMpLXxNtJt6sXgKSpRdAAkIL
	F3/5sRKP0G2coy8HdzL6Q4TKRrdsBmawmaQ7rhoaMxn6gyWDb4hQjLnNXSjPjcMSTGqc0grFIYO/g
	1ZXJ48x/vJ/bII6LenY4CYMV4KHdKptQ2lR05Nz7/pJOXJCnE2T8FamtBK9oQwscCvPSbYhwn+tiu
	tR5Z9ihw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqbMu-00000008sEr-0IDV;
	Mon, 25 Aug 2025 17:52:32 +0000
Message-ID: <0c755ddc-9ed1-462e-a9f1-16762ebe0a19@infradead.org>
Date: Mon, 25 Aug 2025 10:52:31 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uapi/fcntl: conditionally define AT_RENAME* macros
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org
References: <20250824221055.86110-1-rdunlap@infradead.org>
 <aKuedOXEIapocQ8l@casper.infradead.org>
 <9b2c8fe2-cf17-445b-abd7-a1ed44812a73@infradead.org>
 <aKxfGix_o4glz8-Z@casper.infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aKxfGix_o4glz8-Z@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/25/25 6:03 AM, Matthew Wilcox wrote:
> On Sun, Aug 24, 2025 at 04:54:50PM -0700, Randy Dunlap wrote:
>> In file included from ../samples/vfs/test-statx.c:23:
>> usr/include/linux/fcntl.h:159:9: warning: ‘AT_RENAME_NOREPLACE’ redefined
>>   159 | #define AT_RENAME_NOREPLACE     0x0001
>> In file included from ../samples/vfs/test-statx.c:13:
>> /usr/include/stdio.h:171:10: note: this is the location of the previous definition
>>   171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
> 
> Oh dear.  This is going to be libc-version-dependent.
> 

I am not surprised at that.

> $ grep -r AT_RENAME_NOREPLACE /usr/include
> /usr/include/linux/fcntl.h:#define AT_RENAME_NOREPLACE	0x0001
> 
> It's not in stdio.h at all.  This is with libc6 2.41-10

It was added 2025-04-22:
2025-04-22  Joseph Myers  <josmyers@redhat.com>

	COMMIT: cf9241107d12e79073ddb03bab9de115e5e0e856
	Add AT_* constants from Linux 6.12

$ grep -r AT_RENAME_NOREPLACE /usr/include
/usr/include/stdio.h:# define AT_RENAME_NOREPLACE RENAME_NOREPLACE
/usr/include/linux/fcntl.h:#define AT_RENAME_NOREPLACE	0x0001

I have libc 2.42-1.1 (openSUSE).

thanks.
-- 
~Randy


