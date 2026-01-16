Return-Path: <linux-fsdevel+bounces-74060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 208F5D2CD3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 07:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 557653066464
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 06:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AD434F481;
	Fri, 16 Jan 2026 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uJ5raEU6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2C134EF13
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768546689; cv=none; b=DC16QaeTMdydiWRqnBwtYq2wkikK7CueAk4r+iIYzKsmhsEnh3OuWrUCpsIjwZ6BEnKC05A9lSjg8zO+G0k+nkqYMp2pJOg/xsUUIKKMvKgJ7zJZ0WrDAnVlmNPjKs5sRl5FPJnKqdZmo8cJzDWXvftnYV8w/dfXT64WFsnR5VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768546689; c=relaxed/simple;
	bh=XxMfkQzXZBloiEzhfmMyGg5BLiik01g/ayw2P3Ef+uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTQXCnxm+xFqsjEd3NJVEFRKauDiIYFO+K24eLNJeCMSWKYInaDtGizAxRWd4zD8cdaxEMJ/4xkFVeHbWtAacQufQfD82WgiIcTsjOP00G+RazGPA+IQH5G0ENVTWbVRafJqAZpuPNy/Dapc+GSeozofr9Bhtp6+snAolTxb7mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uJ5raEU6; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e6e34879-cf33-4e94-a31c-aa1c66254184@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768546685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TpZHEIhDVZUYNbouuf4WeuCvv5XReGcdIsU3/YXDkLg=;
	b=uJ5raEU6EQAsUqtzDFgi5GqH6avFKF9NWG9r+Nvffn++zeg6LmW/HLc5tfvKU7olmhQTfd
	Pebke8/HtYdSX0lDUeBsslumm6YuGaJwegdHcfhjASQUzkRhakP75KARxVB+/pKB5ieUrx
	hjFsh7VcPq6IcZbAbDeBXegJavNpFZg=
Date: Fri, 16 Jan 2026 14:57:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 00/37] cifs: Scripted header file cleanup and SMB1 split
To: Steve French <smfrench@gmail.com>, David Howells <dhowells@redhat.com>
Cc: Enzo Matsumiya <ematsumiya@suse.de>, Paulo Alcantara <pc@manguebit.org>,
 CIFS <linux-cifs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Henrique Carvalho <henrique.carvalho@suse.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
 <sijmvmcozfmtp3rkamjbgr6xk7ola2wlxc2wvs4t4lcanjsaza@w4bcxcxkmyfc>
 <CAH2r5mtgC_s2J9g0smr5NDxSp1TO7d+dtZ7=afnuw9hMxQ4TYQ@mail.gmail.com>
 <ccbe5da5-0922-4ba2-b4cb-fc1d0f4ce325@linux.dev>
 <CAH2r5msqwTqvCzpozKz_SPZsB-qP3RV_pfXZxZwMKMXWfmJHDg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <CAH2r5msqwTqvCzpozKz_SPZsB-qP3RV_pfXZxZwMKMXWfmJHDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Conflicts have been resolved. Please see the last five patches in the 
GitHub repository tag `smb2maperror`: 
https://github.com/chenxiaosonggithub/linux/commits/smb2maperror/

   smb/client: introduce KUnit test to check search result of 
smb2_error_map_table
   smb/client: use bsearch() to find target in smb2_error_map_table
   smb/client: check whether smb2_error_map_table is sorted in ascending 
order
   cifs: Autogenerate SMB2 error mapping table
   cifs: Label SMB2 statuses with errors

Thanks,
ChenXiaoSong <chenxiaosong@kylinos.cn>

On 1/16/26 12:32, Steve French wrote:
> Kernel branch would be good


