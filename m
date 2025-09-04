Return-Path: <linux-fsdevel+bounces-60306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6807EB448DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 23:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5DE3AD0D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 21:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8AA2D0C94;
	Thu,  4 Sep 2025 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q9/9jIab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104282C3245;
	Thu,  4 Sep 2025 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757022757; cv=none; b=pYlvEvlMzwj36SGw5cDNkuiFSNzx+ZMewQAFaGPHQhSUfFftmSS+bBSZVnK7yOOK7eLOEajA8Ja7BvBFdm746uE0ayQ/1IUEB/eYl27Jf2xrYRmrPBlCYMsyRQBSyrvfQkUyj/Hk9ITclFV6CT44iGeCa+tMPcb34jT3+x4FC14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757022757; c=relaxed/simple;
	bh=j8Lvx4LYs6RWWcXUE3HffvZSjpL5xNSLk0qqXdERQZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGQj9o3P/ovHR59TX9aJdSPDarVOlJIjJ2+aoVAlxf0HNK4aQ0aBRFuF94YHOU42E0BP/QSJaicg08HwXkWOx6c2fCbBf/u6BhN6s4S9l7Pbui+/I+aQkQnHmGECovaNyI7ox35e/PmjSHzxajjUxaoxOd/4hKLArEDeibbumHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q9/9jIab; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=A2XDTefiEP4Ka+Xqy3ySndJof3Li4Xag15XUVtOWBJ4=; b=q9/9jIabKB2C6T44yfpy3iTaNQ
	9jUT8ddamVcBmPYC3kMrxVKPQ4Db4hevnVkgfDG28tRvXnFvXW3g0I1i+TgHk6Zd67hj8ezYKqLJb
	A7tE1r8rDGi+iwnJuxqkgLzSGAvmrQaUIJuyFzae4ALVuYZ0e4HpakYjok0v4gsMYAFCYPpeYYGRi
	B9r6+JpyQhmwHazRCS3BVHG0tZva+ijgHsSbsZBMrSwsaxG/FvLyrxYVL2zlkLEOwaU4UlZGAppl+
	SJW1Hk0n+maeCXaF9Mp73mkw6Sok0UA1IdFiQrkP2g++Y0eJmVI2QV2HaEULBhYZ8TMcg0rTpg0Iu
	fP40fl/w==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuHsh-0000000Eg05-2dil;
	Thu, 04 Sep 2025 21:52:35 +0000
Message-ID: <b35f0ff7-8ffb-400f-b537-d15e83319808@infradead.org>
Date: Thu, 4 Sep 2025 14:52:34 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] uapi/linux/fcntl: remove AT_RENAME* macros
To: Florian Weimer <fweimer@redhat.com>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, David Howells <dhowells@redhat.com>,
 linux-api@vger.kernel.org
References: <20250904062215.2362311-1-rdunlap@infradead.org>
 <CAOQ4uxiJibbq_MX3HkNaFb3GXGsZ0nNehk+MNODxXxy_khSwEQ@mail.gmail.com>
 <lhua53auk7q.fsf@oldenburg.str.redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <lhua53auk7q.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/4/25 11:49 AM, Florian Weimer wrote:
> * Amir Goldstein:
> 
>> I find this end result a bit odd, but I don't want to suggest another variant
>> I already proposed one in v2 review [1] that maybe you did not like.
>> It's fine.
>> I'll let Aleksa and Christian chime in to decide on if and how they want this
>> comment to look or if we should just delete these definitions and be done with
>> this episode.
> 
> We should fix the definition in glibc to be identical token-wise to the
> kernel's.

That's probably a good suggestion...
while I tried the reverse of that and Amir opposed.

Now I find that I don't care enough to sustain this.

Thanks.

-- 
~Randy


