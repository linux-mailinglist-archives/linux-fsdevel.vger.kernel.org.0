Return-Path: <linux-fsdevel+bounces-6333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01DA815D1C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 03:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A891F22265
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 02:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6F1ED8;
	Sun, 17 Dec 2023 02:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1SC7We7T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB64A32;
	Sun, 17 Dec 2023 02:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=wSxaOslInFaYonzYXDSErFQurFpPyX2ZAWJ45tnIxmU=; b=1SC7We7TfTkAliYcUVp07bbaHo
	sEKhmoTHHkl+lZeeuq9Z7k5SLs66o8RXWdkUTSw5Oeq9lzilQeiRBzD1RjJNTlkQVm8jBq+9Gdmwm
	KabnLTExPA5zrWt5QpMWLVPPujApVtez+zmVUASsNzhEmHS2ihFLO4Ln82TRfsxa2DcrblKgUs5nx
	WpdAA1sz91RwOztxpm9W+v+TSAu68OhQ/QojCdTyo4ZbRnBDg1xU/eST1X1ZYQuxAEUHc2Lxha7Gx
	uS0PFSz9HfrcyX/rekKwkv2RFIHwbpDY+YaJTi4qSskTQbef8Un5o0/Z7mOgzjxqbPat2iVmaFI6e
	hR/Pb9lw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEgVF-0070Vy-0E;
	Sun, 17 Dec 2023 02:03:37 +0000
Message-ID: <8625718c-b8c2-448b-a2a8-7153aa74ce29@infradead.org>
Date: Sat, 16 Dec 2023 18:03:36 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 46/50] preempt.h: Kill dependency on list.h
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
 tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
 paulmck@kernel.org, keescook@chromium.org, dave.hansen@linux.intel.com,
 mingo@redhat.com, will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
 brauner@kernel.org
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-3-kent.overstreet@linux.dev>
 <ZX1AFVAWXMfbo+Ry@casper.infradead.org>
 <20231216223522.s4skrclervsskx32@moria.home.lan>
 <82ed43c2-2a9d-4c5e-8ccd-8078397b7953@infradead.org>
 <ZX4+STzh5MFhVHrw@casper.infradead.org>
 <20231217002028.shjg6p7wa2cmtkq2@moria.home.lan>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231217002028.shjg6p7wa2cmtkq2@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/16/23 16:20, Kent Overstreet wrote:
> On Sun, Dec 17, 2023 at 12:18:17AM +0000, Matthew Wilcox wrote:
>> On Sat, Dec 16, 2023 at 04:04:43PM -0800, Randy Dunlap wrote:
>>>
>>>
>>> On 12/16/23 14:35, Kent Overstreet wrote:
>>>> On Sat, Dec 16, 2023 at 06:13:41AM +0000, Matthew Wilcox wrote:
>>>>> On Fri, Dec 15, 2023 at 10:35:47PM -0500, Kent Overstreet wrote:
>>>>>> -	INIT_HLIST_NODE(&notifier->link);
>>>>>> +	/* INIT_HLIST_NODE() open coded, to avoid dependency on list.h */
>>>>>> +	notifier->link.next = NULL;
>>>>>> +	notifier->link.pprev = NULL;
>>>>>
>>>>> Arguably INIT_HLIST_NODE() belongs in types.h -- we already have
>>>>> RCUREF_INIT() and ATOMIC_INIT() in there.
>>>>
>>>> I think I'd prefer to keep types.h as minimal as possible - as soon as
>>>> we start putting non type stuff in there people won't know what the
>>>> distinction is and it'll grow.
>>>>
>>>> preempt.h is a bit unusual too, normally we'd just split out a _types.h
>>>> header there but it's not so easy to split up usefully.
>>>>
>>>
>>> I don't feel like I have NAK power, but if I did, I would NAK
>>> open coding of INIT_HLIST_HEAD() or anything like it.
>>> I would expect some $maintainer to do likewise, but I could be
>>> surprised.
>>
>> There is another solution here (although I prefer moving INIT_HLIST_HEAD
>> into types.h).  The preprocessor allows redefinitions as long as the two
>> definitions match exactly.  So you can copy INIT_HLIST_HEAD into
>> preempt.h and if the definition ever changes, we'll notice.
> 
> I like it.

Possible to revert 490d6ab170c9 ? although with something list
this inserted:

	struct hlist_node *_p = h;
and then use _p instead of h (or the old macro's 'ptr')

The code looks the same to me, although I could have mucked something
up:     https://godbolt.org/z/z76nsqGx3

although Andrew prefers inlines for type checking.


-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

