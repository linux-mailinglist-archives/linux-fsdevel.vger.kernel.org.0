Return-Path: <linux-fsdevel+bounces-60333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AC3B44FFC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 09:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479F5A44CC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 07:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE1625A340;
	Fri,  5 Sep 2025 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hziXKh6O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE951DE4E5;
	Fri,  5 Sep 2025 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057780; cv=none; b=VbTEHMMlEt49xf4CObHiQET3B0qJmgwwQJmTU9FrLyD3pgCfEjSBfleKNcqZ0tEo50u3RnSJ1TgSskLRAe2+2HMBweUtqtig9Uc9yf22MxT4nUqdkxv2YfWzBXjReBHDUTUCqm5WK4JqhOoC8hDxxDbnaUWMUyJz7iX2JKwEqyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057780; c=relaxed/simple;
	bh=8EM7YIGpDY0tGhraBQjUb70RYOiFiLY/METMliKnjno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9KUdxgMudqj1QEK0h1HaAqU+PaTof9i7Z6AG0q80XojTKoHTUVxcJVExhqA4sLFNfRd+i/FC82Gpf9titQetL8lqd7gIWu06moHtpLb2ENQismiT26BAf/Sf/5rn9d8NlPuZS5Sje9D6ycLf39TkQcj436CF6paRcZj7y7pMqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hziXKh6O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=3eyVixyMY6H4UWZNmEG6hl48LaJC3wZaar27La742gg=; b=hziXKh6OQavKdY8Y71UyDatU8a
	4G8mpf6IGqnQs45nZZGW7f5rGzFVgsih72sbFiq/f+ULMGzFvLjjaOxzlEc6bUsjFOOAEtOA3J8+y
	eF8tuj2LiCN9JcBAmHJ4PBUXTkiAz3cVo7naBBkccivmUK6wrJZukfcMqq6Xa3eEEVs0BgJ2nTA7t
	FlXdEwyKF19u1AA086a2AOP7oMp8/+YfdH4Ei+mMl9MiUtqffIX4oh9gjG9/WacHj0QIZGweAxmSq
	vDn1WkiKWTjISc2RMsN/XOQY4v3GWB20jw39RmrBKdoCbvwcNKVFklzZBreUlQS7DiMJoSBAvzF23
	O/M5JXzw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuQzZ-0000000040e-2Mt9;
	Fri, 05 Sep 2025 07:36:17 +0000
Message-ID: <227acf78-de97-409e-83ec-8aee71998f9e@infradead.org>
Date: Fri, 5 Sep 2025 00:36:11 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] uapi/linux/fcntl: remove AT_RENAME* macros
To: Florian Weimer <fweimer@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
 patches@lists.linux.dev, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Alexander Aring
 <alex.aring@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, David Howells <dhowells@redhat.com>,
 linux-api@vger.kernel.org
References: <20250904062215.2362311-1-rdunlap@infradead.org>
 <CAOQ4uxiJibbq_MX3HkNaFb3GXGsZ0nNehk+MNODxXxy_khSwEQ@mail.gmail.com>
 <lhua53auk7q.fsf@oldenburg.str.redhat.com>
 <b35f0ff7-8ffb-400f-b537-d15e83319808@infradead.org>
 <lhu7bydv01m.fsf@oldenburg.str.redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <lhu7bydv01m.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/5/25 12:19 AM, Florian Weimer wrote:
> * Randy Dunlap:
> 
>> On 9/4/25 11:49 AM, Florian Weimer wrote:
>>> * Amir Goldstein:
>>>
>>>> I find this end result a bit odd, but I don't want to suggest another variant
>>>> I already proposed one in v2 review [1] that maybe you did not like.
>>>> It's fine.
>>>> I'll let Aleksa and Christian chime in to decide on if and how they want this
>>>> comment to look or if we should just delete these definitions and be done with
>>>> this episode.
>>>
>>> We should fix the definition in glibc to be identical token-wise to the
>>> kernel's.
>>
>> That's probably a good suggestion...
>> while I tried the reverse of that and Amir opposed.
> 
> It's certainly odd that the kernel uses different token sequences for
> defining AT_RENAME_* and RENAME_*.  But it's probably too late to fix
> that.
> 
> Here's the glibc patch:
> 
>   [PATCH] libio: Define AT_RENAME_* with the same tokens as Linux
>   <https://inbox.sourceware.org/libc-alpha/lhubjnpv03o.fsf@oldenburg.str.redhat.com/T/#u>


Thanks!

-- 
~Randy


