Return-Path: <linux-fsdevel+bounces-79741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMByCO59rmlfFQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 08:59:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D93C235254
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 08:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 221423052632
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A1936B06F;
	Mon,  9 Mar 2026 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQQ8sP7O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E98236A01B
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773043061; cv=pass; b=M4Um2vBmNuSL5XCQDcD5HZwgcMbHucSKdYtaqRborrDSwvaMWvPgi2/4LczReqaBqkbt2KC9/sOFPdQxDmD87yGAB2X4r4oaHEMiyb8GLW5WN0TOGPwLlC95HAE7RBelVI/wfKepgdynRECeiAxg54Chwc8Y03FE5HsEJ1LLd4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773043061; c=relaxed/simple;
	bh=Bc5YCzZwaugc6qlY/fyP8r1uGR0PYI0Vhk0jy+TRtSM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txayP9gFIU7oqMcFH9fTwyYP1/KNJh8pPao0qWvYcLmO9mjfn8m+FZ2jorUi8VYiJ/v6QdL/44WEr9QoDp802rW1A8gg7Fl/zC8qwPv85aXIsb9dk3lj3JI0VF/tpwPS74Zj5u/mYEjPMxliBLkLshEHxAXkCF1KtKDzZvTQFrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQQ8sP7O; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56b069fed64so1132623e0c.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 00:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773043059; cv=none;
        d=google.com; s=arc-20240605;
        b=UkmfhrCGAAxo4F23qlHBmPOHweFB6khS4oLreX5eTJeCcEiv5qoNWj/2Z/aMuPWiR/
         OEUTq1S7ogbrZCkQcREl1W7U/vRjl1kvpX1QECvTwNUx6MIyROVhoikxFx+ZwLIfJVk6
         +oBs6kpLomo5EicH++9+noJlDpCCfIgutvPw3Z+wzJbk+g1Uyh8znhxyC6eg+f9BClbR
         BLopHvJliF4sXf20/RIB+mUwiyi88YZScAA9lOvDi0jXQGywqosfWZzpBb2DdJsTUS2x
         p1Y3Jfn6qaYgeyylgXwL6klbqJbCOqvFSknJBXxfTMqHkhtV/eyfdzb0kgAynNOXLLJm
         eXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=G9secbmrLeczpRPZ42gZHzPMJ4soIG7S5n6DXzNQl4Q=;
        fh=nMXWmGgRaolFZD2YymApLpGyRhLpMV9a7UZFHBh6oOE=;
        b=Bje8ZJHIxIUZyRg5sLdomYXlveckLUUBZrqyVAVR30foTU+g9M1y4eP7YcAOFMHKAF
         YDRHBpxZNu7o/4wjL9Q5uLVaTLFHwcrXKM3kXYC2liDoYxFeatQykT3E6BXVytJSpEeO
         3Ab0Oa7cKc251A65D2YTo7sigzwIHTzGGFE0mY9E8ygG0O3Z+KA8n5rOpTIymHjs72Tw
         x4wMmLo8ffR2LIMDEKBm0W3KEUa0tnAnI4jOhojrQElAbJ828SEQrCrCUYdrY3MmA0No
         6EHgUkDJN5Tl+Xq/ecsn/myQU6QTDRlB0isfCYFwjoxu2P+TV/oNFdxMDvjAec8Dv9Mk
         qFOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773043059; x=1773647859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G9secbmrLeczpRPZ42gZHzPMJ4soIG7S5n6DXzNQl4Q=;
        b=wQQ8sP7OObRVcKgeGGv/EzwD3xLC5blExAfs9xMlsv9wXPz4gTY8BOntw4SjgTmNDN
         cRZQEL20ABBq7ZxLfp9oZTpp23v1pxAp5y732TxQdk8skhbNcTSzbNOB4VxkQOe+vEYT
         3QbGCZyRVGPxET4P2rhcv0Macc6trG4PottoMRTws7a2Us9OQGVoromoHQk5zZoeu5Fd
         1fiUjb4SDwZ+3wETlO2DfqSVB7fHEoT81J8viPUXHb4+2I6ZAcCuXh9+VtRsnrEhEaLR
         C2JzEkxC/jWSujXPW+/1iwtYKxKzbwiHRi8nf1xTmCbUR1n21O2CRV0XJqxff7GQpKT9
         HNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773043059; x=1773647859;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9secbmrLeczpRPZ42gZHzPMJ4soIG7S5n6DXzNQl4Q=;
        b=L5B60JWQJypnanEM10lAWJrMaLMcQjjGIm/UrgPX3iEDpa1L2pokIm7Ph3Sc3rFnOr
         ck9MqHefJJ8GG+vPz1Nf/etvgpUWWE0SLq1w9Iolz0wEVD9/82+l0QKZblHyxgtcLWor
         wg9OqH7oFTHMt2iSebhL6YJbkNfqyN/xPLFu83tiyae0tdS+0Zg4qDzo29XdGtdofKeh
         V2pUohUgXgi+KCU9TzJ7IRQoHI64xADKzNzhTt4Mc8NZWWB/gnm6mnX8hRGW4idvR08O
         y7b5MuCyiE3Koa87aOQtQJ5EtMfTawDIbkd5653BlgHyn5I3Vc1GT5wdNFrOPdPFkCEO
         NP7g==
X-Forwarded-Encrypted: i=1; AJvYcCVXUbqKdnTwyy/iWKrkQYs+ANTpJcfLkWUXxftwPjjC+yM3rpZA8BLGNm9BZgKEOFBHbhjlsg6pp31AW6tF@vger.kernel.org
X-Gm-Message-State: AOJu0YziqejogQKotjvAQuExrdXu9s0K2TICu3g6o8Lg4klhM4TxbitI
	Q+c2jUcKsk4ZWd0AuvkbJtunSbOPd0ft/lFWrI+y0PZ+e2wvOUM06EaCNDIFhUjeAch5qAf2uls
	0o2+0Dp6yK19iC1/5h8uuel6PD0IJtekl2hIY5vRX
X-Gm-Gg: ATEYQzy3jwh2OM8L227RYTe7O5PH5PIRQPGAgFjL1GPklGaR8aEofTkJL+X2m2SEOhP
	G5mt9kVLWmjFyzWapNKU+GOSeEsYFVznwNPbHARuDscCo+SNviC7VnPeSCktwHM7xG7w7iaZvjo
	/2HhIxx9TUkcPQHCbT/hTxjYcdaDXepG2+b785+R8qeRImKdgT1zhO6hwj5n+gOtHgdzf22vgEW
	cPyvq8J/gFXRPPDwscxqhq+AaR1eXxQvjbTE8IxVyemMuKYXuY6PwfYJgryKq0H/FY7v3PsP/44
	YbucUQthyxddFYhf1XRoh5VoUavgaTNEB0RaKqyRzg0yJSqQJ1yy6H/a87eHIzvUxEi+Cw==
X-Received: by 2002:a05:6102:d8c:b0:5ff:d192:ff2c with SMTP id
 ada2fe7eead31-5ffe6213645mr3556252137.34.1773043058690; Mon, 09 Mar 2026
 00:57:38 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Mar 2026 00:57:38 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Mar 2026 00:57:38 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <2s33j7wg6ehizvdoz5fggc6kfa5byrs4yg2hk4fvwvfjp7nigo@se7fhyaknqqm>
References: <20260225-gmem-st-blocks-v2-0-87d7098119a9@google.com>
 <20260225-gmem-st-blocks-v2-3-87d7098119a9@google.com> <2s33j7wg6ehizvdoz5fggc6kfa5byrs4yg2hk4fvwvfjp7nigo@se7fhyaknqqm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Mar 2026 00:57:38 -0700
X-Gm-Features: AaiRm539ncfsVFw5AP9VoOkialmaGifm5bQJ7k_NAlY4DMAWUCQTSVmir1fUcmo
Message-ID: <CAEvNRgEH5X79zwFr8t4EayDccED8i5__-oFyBZ4nb_RkX8826A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/6] fs: Add .unaccount_folio callback
To: Jan Kara <jack@suse.cz>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, seanjc@google.com, 
	rientjes@google.com, rick.p.edgecombe@intel.com, yan.y.zhao@intel.com, 
	fvdl@google.com, jthoughton@google.com, vannapurve@google.com, 
	shivankg@amd.com, michael.roth@amd.com, pratyush@kernel.org, 
	pasha.tatashin@soleen.com, kalyazin@amazon.com, tabba@google.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6D93C235254
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79741-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.947];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email]
X-Rspamd-Action: no action

Jan Kara <jack@suse.cz> writes:

> On Wed 25-02-26 07:20:38, Ackerley Tng wrote:
>> Add .unaccount_folio callback to allow filesystems to do accounting-related
>> updates to the inode or struct address_space mapping, when the folio is
>> about to be removed from the filemap/page_cache.
>>
>> .free_folio cannot be used since .free_folio cannot assume that struct
>> address_space mapping still exists.
>
> I agree .free_folio isn't the right place.
>
>> From the name, .invalidate_folio and .release_folio seem suitable, but
>> those are meant only to handle freeing of a folio's private
>> data. .release_folio is also not called in the truncation path.
>
> But this I don't quite understand. .invalidate_folio is called when
> the file is truncated (or when the whole inode is being evicted from
> memory). Filesystem can do whatever it wishes there, not just free folio
> private data. Are you pointing at folio_needs_release() check? But you can
> mark your mappings with mapping_release_always() - it's there exactly for
> such usecases... Am I missing something?
>

Looking at it again, mapping_release_always() gates both
.release_folio() in filemap_release_folio() and .invalidate_folio() in
truncate_cleanup_folio() and truncate_inode_partial_folio().

Let me try that out in the next revision. Thanks for pointing this out!

> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

