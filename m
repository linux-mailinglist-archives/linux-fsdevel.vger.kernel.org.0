Return-Path: <linux-fsdevel+bounces-49702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA86EAC191C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 03:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D456A24BEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 01:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F0B221F3F;
	Fri, 23 May 2025 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EuBPmj2f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50CF21FF35;
	Fri, 23 May 2025 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962025; cv=none; b=ramHjCl0DZ938SBtE/NHauKkNLR/EcpWwY7aSFoinnb9p1HsZxapm988C+avBQn6NXemwXgcdW/Xhben1cNTk4QmPJZjzzsLWBTwiMUNDFm9L14rVYJOEx8x35pdGJKhIO3nl4T6WXJc9P92KVrKhUu+XEa07u5Gv/OEZt4C9nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962025; c=relaxed/simple;
	bh=mBllmWspxUb6WMZ6UgK2YeCavB2WwSWS5l+56LBR2Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgbASe+6WQdWwbPa84SnMHriMvnd71Pbv4r0dQfTtYp+NS7slHvIwtWEH90/6gXBv44wiTT7kGXfaXM4iNAzN/eeGAVzQNQMV0xPsL/m+sSlNm2L44EbYEePJ5SiR0VlalrY04s13HhzLLQd48hkTbBuwfRj1thsmDZDWzP4tZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EuBPmj2f; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=JQsG2xym9H00ve0pF5UnE9P2+sIgGX1YRykP3ytbG4A=; b=EuBPmj2f/169O1QWRM8OH0oEg4
	ErDjjMvJ0JkGLK6eWwWcNtvIPebe0phapWl7re5RBSxmdWOKf3TGAmlNmuQs9LUMADckZl+k652Bh
	YPYj5y5LNPWRl+3NCPBg6o/2s9YcHFgEd9ZuvDYZzUxBT+eIE8xMdEq8ok2TNp1BtLl0P/cfwMLAE
	bfcjummeMYWjGrmfWZoqBObaxXjj3bSJDC4hEPhsxqttWnYK97QmHCR0DLi2n+KpKFF+f9oceR3+e
	1xi4vRgPxHPRfwo/e7/g8FxEQL/n57G15bVpMqv1jm7Yr9WYvJDmOrc6EMxb/oAmu640LaRb764LZ
	TbwDeW+A==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uIGlE-000000016zC-1qFs;
	Fri, 23 May 2025 01:00:15 +0000
Message-ID: <5e9ccdad-a9f4-4c8f-85b0-430edd910590@infradead.org>
Date: Thu, 22 May 2025 17:59:39 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/9] coredump: add coredump socket
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jann Horn <jannh@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Daan De Meyer <daan.j.demeyer@gmail.com>,
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>,
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>,
 Luca Boccassi <luca.boccassi@gmail.com>, Mike Yuan <me@yhndnzj.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
References: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
 <20250516-work-coredump-socket-v8-4-664f3caf2516@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250516-work-coredump-socket-v8-4-664f3caf2516@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/16/25 4:25 AM, Christian Brauner wrote:
> Coredumping currently supports two modes:
> 

> ---
>  fs/coredump.c       | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/net.h |   1 +
>  net/unix/af_unix.c  |  54 ++++++++++++++++++------
>  3 files changed, 156 insertions(+), 17 deletions(-)
> 

[snip]

git a/include/linux/net.h b/include/linux/net.h> index 0ff950eecc6b..139c85d0f2ea 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -81,6 +81,7 @@ enum sock_type {
>  #ifndef SOCK_NONBLOCK
>  #define SOCK_NONBLOCK	O_NONBLOCK
>  #endif
> +#define SOCK_COREDUMP	O_NOCTTY
>  
>  #endif /* ARCH_HAS_SOCKET_TYPES */

MIPS sets ARCH_HAS_SOCKET_TYPES so the new define above is not used,
causing:


net/unix/af_unix.c:1152:21: error: 'SOCK_COREDUMP' undeclared (f
irst use in this function); did you mean 'SOCK_RDM'?


-- 
~Randy


