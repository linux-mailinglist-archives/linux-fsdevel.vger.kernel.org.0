Return-Path: <linux-fsdevel+bounces-77921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KrLJ5cRnGna/QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 09:36:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8601731AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 09:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8DC63031E9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D72C34D3BE;
	Mon, 23 Feb 2026 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EqFJVJGR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B81F34D391
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771835706; cv=none; b=IFZoz1KVhtf4Ikvvyo8Es1dCkacJ3MSHIKaiwJwDDnyTSDwUbGsdU4u3lqCdGErdtXJPx6jVfpMdogS/HobLelz9MpXV3gOxz5lWx/nZoimCZ8G0XpWqm/TpNAjTd5iR/xky3scJclQhQVGkWIGi6dn00wwEezZ3Pd9Jy6ZU/e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771835706; c=relaxed/simple;
	bh=oD7+X79ct0fHHthUw1slK4FuWBROkKkRq34r8OEMvsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kuj9vht4ILWR+5KACIZxH2Z5YLKf2PXCHIBMWu+ZC5lMgFfTHDE//JLgMcJJ48h3F4+uEPRkIcj+Mvy08m5sE+C6g/csYgXJaHBmaCM0ZU5V1r5L3W8lrDpb3kW3dtq//JT/C4VGwOOYx1hPEp/vDI8qC7T/Jf066wpiBgCvGY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EqFJVJGR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48375f1defeso28306835e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 00:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771835703; x=1772440503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hAizR7Bvz+Bw0LuK1AlDU6wp4T74bA7euWnDx6p9HnI=;
        b=EqFJVJGRbCz+FhYIgdx5tbyA+V9+L/Tcsu0x/33TYae+YLQ7BEaVhxiWr4yFHvIbAk
         naEOJBwiJnjvQ1tO47/rdD9thbDXCcgxegNcNreffn1U+jnZYus0GxcBt/bHnpLiGbS4
         KlCMJbEQC2iHncFkJEtOLj0ZeCeMbIY5+v7FBh4EzUh5WbMuLictUCaVLXjyaTJGsHoI
         eMocUoaTj/aisbo4r8WCylJzPzppUjOBHMsEWpYpaV5OBGnBUmeRfAcSfa3h9FokXlHn
         eo2fMxo0yzcKFs/uKz31+49A2hA4dsMnO1MFhPa1zVFjMy79GDJdr1+HIcpiuwXH2ybr
         pr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771835703; x=1772440503;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAizR7Bvz+Bw0LuK1AlDU6wp4T74bA7euWnDx6p9HnI=;
        b=nSZU3xZdaWwjD7uXr/6Jhg39PVgZqGgVKJ9fM3Vi33BDZLirJPz8CnB/YybFWAJDGC
         Mk5WOgXFIrKDaxI54CgjPO2TiDueVYqYYZD4SgBSlKzD14h6tI0/p46B86FBlKg7UbfN
         OLTcpmGrUJCinZ6e0VgRgNgg1/sZcYNHArcDOzkbzXxvDm/8vPH2hsR8DlsugsmHO2fS
         iFCT3jx0ULZqB3CRyy/7iwhVdfvQR/aBrsBRIX86d8JmO7NH748KFafoKvmD0Mw+ds/5
         yEzYDj0D4r4zlHOXkliwDDxPAn5LvROZ3eSg8TWrNoGeBQcYRhY04+7Vjpal2L3Kekzg
         OGdQ==
X-Gm-Message-State: AOJu0YwEngNR1PxmlvlSQUFfcZw+h6yI/QG9+ERA5+RgBMP/ymwswhQv
	i8LyeU5fuZdwmP+xPpYTgCyTrpNsKonPEFmDyFGDTMNCyIc+daJFmen5uerhqF6qEgE=
X-Gm-Gg: AZuq6aLLK7VaxSv9XXFgsXXzIG/WKTZp4l9zEqHd78ODt9pDIS8puuXNDLklU1eQf/4
	IvmweVaukuYX1EkwhyfegsktTTxJVzeXEqhuS15VGNYDZNKXzM48oBwV4NPPcjfgERJFg4tqvOx
	gpUGnL337bSlY9F7Yy4xc7xi7sRWkhfXG6Q///xVsaFsy+xJuF/HLtHQg6Hf71J7VahfDr4OlDs
	LmflSE3zYal0T17jT9jB2n/VKpgiPqK53texV/gPiRXJW8Tg0cSE8hAuaZIotXEvn29Fp8nnu6D
	c5k5VMFt/0p9LhGk+MFB1o+0LZ7IbJfDYdn/8/mXUkSmi2BXiVJLnTvXu53U+iPG4JoMKaWF4bj
	o4/pofOSPcoednd2Vd16CKNkF4E1oFg+OvI+tFipbpj1ybuRuQbtRCMEG99ZTxIS6bLIj/lRWMr
	CbktUGP7yk1GGfn356B73x0EmvrkughvE6nStNYTSGzB7XGFMfjuoJbQrKTbHAPQ==
X-Received: by 2002:a05:600c:c4a5:b0:483:a2ce:f461 with SMTP id 5b1f17b1804b1-483a95eb453mr124814625e9.4.1771835702691;
        Mon, 23 Feb 2026 00:35:02 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358a1b8e0cdsm6145415a91.2.2026.02.23.00.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 00:35:01 -0800 (PST)
Message-ID: <8a66f4d4-601c-4e1c-97f0-0ba7781d6ae8@suse.com>
Date: Mon, 23 Feb 2026 19:04:55 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Iomap and compression? (Was "Re: [LSF/MM/BPF TOPIC] Large folio
 support: iomap framework changes versus filesystem-specific implementations")
To: Nanzhe Zhao <nzzhao@126.com>, lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 willy@infradead.org, yi.zhang@huaweicloud.com, jaegeuk@kernel.org,
 Chao Yu <chao@kernel.org>, Barry Song <21cnbao@gmail.com>
References: <75f43184.d57.19c7b2269dd.Coremail.nzzhao@126.com>
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
In-Reply-To: <75f43184.d57.19c7b2269dd.Coremail.nzzhao@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,huaweicloud.com,kernel.org,gmail.com];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-77921-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim];
	FREEMAIL_TO(0.00)[126.com,lists.linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 1F8601731AC
X-Rspamd-Action: no action



在 2026/2/20 23:29, Nanzhe Zhao 写道:
> Large folios can reduce per-page overhead and improve throughput for large buffered I/O, but enabling them in filesystems is not a mechanical “page → folio” conversion. The core difficulty is preserving correctness and performance when a folio must maintain subrange state, while existing filesystem code paths and the iomap buffered I/O framework make different assumptions about state tracking, locking lifetime, block mapping, and writeback semantics.
> 
> This session proposes a cross-filesystem discussion around two directions that are actively being explored:
> 
> Iomap approach: adopt iomap buffered I/O paths and benefit from iomap-style subrange folio state machinery. However, much of this machinery lives as static helpers inside iomap’s implementation (e.g., in buffered-io.c) and is not available as a reusable API, which pushes filesystems toward re-implementing similar logic. Moreover, iomap’s per-folio state relies on folio-private metadata storage, which can clash with filesystem-specific folio-private usage.
> 
> 
> Native fs approach: keep native buffered I/O paths and implement filesystem-specific folio_state tracking and helpers to avoid whole-folio dirtying/write amplification and to match filesystem-private metadata (e.g., private flags). This avoids some iomap integration constraints and preserves filesystem-specific optimizations, but it increases filesystem-local complexity and long-term maintenance cost.

Please note that, btrfs chose this "native fs" way only because there 
are a lot of blockage preventing us from going full iomap directly.

Our long term objective is to go full iomap, and Goldwyn is already 
working on non-compressed buffered write path.
And I'm working on the compressed write path, firstly to get rid of the 
complex async submission thing, which makes btrfs per-folio tracking way 
more complex than iomap.


So there is no real "native fs" approach, it's just a middle ground 
before we fully figure out how to do our buffered write path correct.

[BTRFS COMPRESSION DILEMMA]

I just want to take the chance to get the feedback from iomap guys on 
how to support compression.

Btrfs supports compression and implemented it in a very flex but also 
very complex way.

For the example of flexibility, any dirty range >= 2 fs blocks can go 
through compression, and there is no alignment requirement other than fs 
block size at all.

And for the example of complexity, btrfs has a complex async extent 
submission at delalloc time (similar to iomap_begin time), where we keep 
the whole contig dirty range (can go beyond the current folio) locked, 
and do the compression in a workqueue, and submit them in that workqueue.

This introduced a lot of extra sub-folio tracking for locked/writeback 
fs blocks, and kills concurrency (can not read the page cache since it's 
locked during compression).


Furthermore there are a lot of different corner cases we need to 
address, e.g:

- Compressed >= input

   We need to fall back to non-compressed path.

- Compression is done, but extent allocator failed

   E.g. we got a 128K data, compressed it to 64K, but our on-disk free
   space is fragmented, can only provide two 32K extents.

   We still need to fallback to non-compressed path, as we do not support
   splitting a compressed extent into two.


[DELAYED UNTIL SUBMISSION]

Although we're far from migrating to iomap, my current compression 
rework will go a delayed method like the following, mostly to get rid of 
the async submission code:

- Allocate a place holder ordered extent at iomap_begin/delalloc time
   Unlike regular iomap_begin() or run_delalloc_range(), we do not
   reserve any on-disk space.

   And the ordered extent will have a special flag to notify that the bio
   should not be written into disk directly.

- Queue the folio into a bio and submit
   So the involved folios will get its dirty flags cleared, and set
   writeback flags just before submission.

   And at submission time, we find the bio has a special delayed flag,
   and will queue the work load into a workqueue to handle the special
   bio.

- Do real work in the workqueue, including:

   * Do the compression

   * Allocate real on-disk extent(s)

   * Assemble the real bio(s)
     If the compression and allocation succeeded, we assmeble
     the bio with compressed data.

     Otherwise fallback to non-compressed path, using the page cache
     to assemble the bio.

   * Submit all involved bio(s) and wait for them to finish

   * Do the endio of the original bio
     Which will clear the writeback flags of all involved page cache
     folios, and end ordered extents for them.

[IOMAP WITH COMPRESSION?]
If we want to apply this method to iomap, it means we will have a new 
iomap type (DELAYED), and let the fs handle most of the work during 
submission, and mostly kill the generification of iomap.

Any ideas on this? Or will there be a better solution?

Thanks,
Qu

