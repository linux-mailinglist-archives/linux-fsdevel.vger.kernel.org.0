Return-Path: <linux-fsdevel+bounces-6332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC36815CCE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 01:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF1D2854F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 00:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3616A643;
	Sun, 17 Dec 2023 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XAhLRpzB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57375366;
	Sun, 17 Dec 2023 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=UmhjuIC+i3niD7s22hOLxzfyohGKz2fOc8wk4Hhr30o=; b=XAhLRpzB623ksRVtLDlHFWBDbZ
	EtIZFtTiaEAe/aAGXYsnvPuxT2dfKCyqllfO1r7aioBpBREOnBdlTHSe7mgzHJjl+15eDYcrREtM6
	t6NKdS1iFYmOMxz7cvLBi42OYGOW+Kjlc66SGaBAhCDgAArJ46ehcEnOiuUPsdN+E9KH61Bx8YnUc
	14ZaSU371BZKcZAF6KzKp9VLPNGq5P5ESWtonHbxx+ADY6tXh5RWfHkVPpmPu+/3RSuUtaL8dey1I
	oOOk9HOLf6wryCKv09JFMD/IayYdoxsUVkvsymy97nMiUiOiM7kPudKtcyPbVekLdbb7MTThSUouL
	H+EB/Rrw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEezZ-006ukF-1A;
	Sun, 17 Dec 2023 00:26:49 +0000
Message-ID: <90558702-2d94-4396-8e85-2ffa7777e87c@infradead.org>
Date: Sat, 16 Dec 2023 16:26:48 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 46/50] preempt.h: Kill dependency on list.h
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, tglx@linutronix.de,
 x86@kernel.org, tj@kernel.org, peterz@infradead.org,
 mathieu.desnoyers@efficios.com, paulmck@kernel.org, keescook@chromium.org,
 dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
 longman@redhat.com, boqun.feng@gmail.com, brauner@kernel.org
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-3-kent.overstreet@linux.dev>
 <ZX1AFVAWXMfbo+Ry@casper.infradead.org>
 <20231216223522.s4skrclervsskx32@moria.home.lan>
 <82ed43c2-2a9d-4c5e-8ccd-8078397b7953@infradead.org>
 <20231217001849.hmilfx63q44tv3vj@moria.home.lan>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231217001849.hmilfx63q44tv3vj@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/16/23 16:18, Kent Overstreet wrote:
> On Sat, Dec 16, 2023 at 04:04:43PM -0800, Randy Dunlap wrote:
>>
>>
>> On 12/16/23 14:35, Kent Overstreet wrote:
>>> On Sat, Dec 16, 2023 at 06:13:41AM +0000, Matthew Wilcox wrote:
>>>> On Fri, Dec 15, 2023 at 10:35:47PM -0500, Kent Overstreet wrote:
>>>>> -	INIT_HLIST_NODE(&notifier->link);
>>>>> +	/* INIT_HLIST_NODE() open coded, to avoid dependency on list.h */
>>>>> +	notifier->link.next = NULL;
>>>>> +	notifier->link.pprev = NULL;
>>>>
>>>> Arguably INIT_HLIST_NODE() belongs in types.h -- we already have
>>>> RCUREF_INIT() and ATOMIC_INIT() in there.
>>>
>>> I think I'd prefer to keep types.h as minimal as possible - as soon as
>>> we start putting non type stuff in there people won't know what the
>>> distinction is and it'll grow.
>>>
>>> preempt.h is a bit unusual too, normally we'd just split out a _types.h
>>> header there but it's not so easy to split up usefully.
>>>
>>
>> I don't feel like I have NAK power, but if I did, I would NAK
>> open coding of INIT_HLIST_HEAD() or anything like it.
>> I would expect some $maintainer to do likewise, but I could be
>> surprised.
> 
> It's INIT_HLIST_HEAD(), there's approximately zero chance of the
> implementation changing, and there's a comment.

s/_HEAD/_NODE/ for both of us.  :)

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

