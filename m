Return-Path: <linux-fsdevel+bounces-78005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBCTKr3NnGnjKQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 22:59:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 292FC17DE3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 22:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3BC9311A4C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 21:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B336337998C;
	Mon, 23 Feb 2026 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Aqpkj20r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C6D376BD6
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 21:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883624; cv=none; b=FVz6Js6ph+DOyl4Pc/ck7jkSeGhU1E1GbD1ku5feUTNZj9KjkoFm5+bPqoG7CaecLn4i87arePn1GyBZuqTrIxpt1zb/RNFfFihWfHQUXUCDoYj/MH8lYmtdnxolJMssftgJ/PcvGgRVpXcGUFmMUdPsA09rLU/Ywv9FoDUd9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883624; c=relaxed/simple;
	bh=Wi5iurDA9KXrcNSaEgjktM4iW0Bd0uEZosac2pE+/Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCHSeo5fF9QHZj0OJCao8r3CIylGSXPYBS0L1sbODhWLzZELNtSAuGSKM1SqJWrs4da5440JPmEQ9GtKZPDKuqdTYyklFGO6IcOZEK82F0XN3L5I1G3/paA2TW7l+kKoYxF+CbKrZW0Lzq8oxn8N+pr93mgGylvJUgTgn6B8ZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Aqpkj20r; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so60160765e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 13:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771883621; x=1772488421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3evNLQ1WZTXbvAuC87kmsxM/9zMcivXkFxDGP3Hkotc=;
        b=Aqpkj20rvp2fgENLB6Q/0g2oWr6K8t3t5dkH+YrwElxVj3JSQz/8HhYVFFuq1D2nNa
         RD6GUydA3hikgdgaSnNLU5o70swjIy13BiMbWmj+WSPQq3oaFPl9CLhzP/AaZXLxCyxk
         FbZAhWCcG7lYF3J+BNaAej/3XD/j9Blgg6X54osVH+bA5aZSv/DHZHI2Icjsa4/IZTRN
         t8hQoif5Qj+6I79+6vPflGNJqBBfT1g4q6W69ViIWqHhoaITjhPM12RprIuIGcXHqCbC
         aRfADLK5sS/1JgpquH5cMzfNX19eblMJQ2slLTCFiwZzCuy7Yqu3AFBvoWdvUkuzdHRZ
         Fd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771883621; x=1772488421;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3evNLQ1WZTXbvAuC87kmsxM/9zMcivXkFxDGP3Hkotc=;
        b=VgFU+8gP56w2AjvlmHsfNa3pf2nxHKlTY6BaaDkHj08rDFJI/rwmiZpB22K/JawcT+
         KPcHpdmmdi0CWEyTYO3dDph8XtuJ18E6GW6/vhxg7zM5kSpJfZGhQZybjQovhaJp74Hw
         peD2u5QppUwMrUW0d1pSKa0dJEIIyEodALwKhAbHk8oDOwk3AYzN3gwQrshh2hlF1RaN
         1LYmFhy0bYZEtOECm9QzFFmbJyNhzotxa5/VbBdN0EzbTcXcJiEylabHuCe32yQStaE4
         w9l5go4HYAljCwl1VA66CuDEoT9HbVY9WDdw+w+QsuhKeALssDTN5DW27IeZia1yVjaK
         K/2g==
X-Forwarded-Encrypted: i=1; AJvYcCWaMru6dIedFnKRA8DUS1zCqsqRRc5im7B0L8LukrAYRTJYDEKGdOIklWu1BSdXzZ6VB8uAjDcFJ2W/Kc6s@vger.kernel.org
X-Gm-Message-State: AOJu0YwOR6sVxWBkJd4ypFVE0oeFYJ+oNQwEJBCoeXR4jrPhtsz8O0wq
	fbZ0L1VlLq6NEQDm18mgui5Nj3yewtTOkGr/WAZGTSXwVFmFdxuA0pYCz4KeFw6DKUNdxCBQzHa
	91mbO8eM=
X-Gm-Gg: AZuq6aK1EzviKpRQbIo3nVevNq9sbldisyVSIGpnQ+y6xn8r6lb6FmcOKmndd2aHN/z
	5Lw83D9b07DvDpJ6e/ol7JwwxISiotVU8A/7pB9VEK6+/ZxTEP/7OQGhMhVhgBluRJhqCWPw+U+
	pZmTJ/bHO1mofPfg3AXm1BnstIMYeZ+jde6XzKOhTnT8gWqvY718Ca6em+h+wb0qpf4ZDbkBi43
	1uMjQqQB1hlDVfJ//TK6b20WDAV4EHwGVQg9ASrZuNBQj1SU3UxnsWZ5akJBJrSQ8G/IaVkljHT
	gIOxj4PEWwFzIl/sTxmy9yPhlPK7lX+NPoJunq9gxQH8E95hnI5WEAj/dMJJ+pyHYn3nsScTJGx
	gLqiJZRKiqZ02t0IG5p7PhGat16yPs/mGPFtHxEUARV2K5zWaTghXZLDFMkEG++5WFADmpmRttG
	e4yNCD/v50d1+Cs9Gy//5d4luCDs3q8aeZJTujVlUfOx0p99ZCS6M=
X-Received: by 2002:a05:600c:c4a2:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-483a95e96e4mr154427145e9.21.1771883621094;
        Mon, 23 Feb 2026 13:53:41 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358af9133c9sm7931061a91.9.2026.02.23.13.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 13:53:40 -0800 (PST)
Message-ID: <a89cc9a0-37d1-431c-ab98-eed58d5bd93c@suse.com>
Date: Tue, 24 Feb 2026 08:23:35 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Iomap and compression? (Was "Re: [LSF/MM/BPF TOPIC] Large folio
 support: iomap framework changes versus filesystem-specific implementations")
To: Christoph Hellwig <hch@infradead.org>
Cc: Nanzhe Zhao <nzzhao@126.com>, lsf-pc@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, willy@infradead.org,
 yi.zhang@huaweicloud.com, jaegeuk@kernel.org, Chao Yu <chao@kernel.org>,
 Barry Song <21cnbao@gmail.com>
References: <75f43184.d57.19c7b2269dd.Coremail.nzzhao@126.com>
 <8a66f4d4-601c-4e1c-97f0-0ba7781d6ae8@suse.com>
 <aZxQ0kwaDqknE8Gq@infradead.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <aZxQ0kwaDqknE8Gq@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[126.com,lists.linux-foundation.org,vger.kernel.org,infradead.org,huaweicloud.com,kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78005-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 292FC17DE3C
X-Rspamd-Action: no action



在 2026/2/23 23:36, Christoph Hellwig 写道:
> On Mon, Feb 23, 2026 at 07:04:55PM +1030, Qu Wenruo wrote:
>> And for the example of complexity, btrfs has a complex async extent
>> submission at delalloc time (similar to iomap_begin time), where we keep the
>> whole contig dirty range (can go beyond the current folio) locked, and do
>> the compression in a workqueue, and submit them in that workqueue.
> 
> I still think btrfs would benefit greatly from killing the async
> submission workqueue,

That's for sure. Although without that workqueue, where should the 
compression workload happen?

Even we kill async submission workqueue, we still want to take advantage 
of multi-thread compression, just at a different timing (without locking 
every involved folio).

> and I hope that the multiple writeback thread
> work going on currently will help with this.  I think you really should
> talk to Kundan.

Mind to CC him/her?

Thanks,
Qu

