Return-Path: <linux-fsdevel+bounces-79659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Rs7WBPg0q2k6bAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 21:11:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA82276BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 21:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBCBC3042FFE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 20:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93CF37648E;
	Fri,  6 Mar 2026 20:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JUCmnEFR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F0F346FAE
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772827888; cv=none; b=hNkBt0NTfFJNjQUu7/PbTogDmqPkUG7JK3JPK4h9vXRpC2/83Yl25N1+u4FVROH4HHQs9qltKbCyIRKmCa5HFomE8CmwbhQhBCQEm8kjznD2/NGker5TYVoX+8yNw0IjLTJb4t2liMbuxfxUVWShjkIRXyrY1BzXlkUDBB6aNY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772827888; c=relaxed/simple;
	bh=4bAzUe+NS36GjNZ+I1UgoM17eFvdFdZWkcbTBVS4PfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyBMyRdOjQEjai5x9ttAyZyCM2TLrByodwv2r1qU43bRBUqiZTreCOeKqrFIL4jyhwlCli7eD6GeMZNLOJdORM7F1CWPONHIKBy4Y7XdcFtXF552s9XJSPz0DnYh6GtIO/RcfTXcJWL8/i0Caw/NxLDLG+kD2/OaZHQckRjiBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JUCmnEFR; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d19d3c7208so7062841a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2026 12:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772827886; x=1773432686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FiOnenw1jcYxE+BclNNPW1TPwN0VcI9bkCDAzXXwTsc=;
        b=JUCmnEFRJ0+LwcWtetuxT2CYC6aebpGGxjtUFfjTeAYg4mzZExUjYtpbxZ+uhiQv7N
         Hl0/HsnNfDLXiZxE+BDGzjrmqaFiJjtzTRhVJVBluayglxjHOzy6jiR0vsU8iZJVcQIg
         NqEl/jdNnJl+b2hnS6OPtT7Qi+aXjE82nDx7zXg1Lyg9yb6yGz+2KAtVhlssWQfL8XMC
         gZEDcn2fzBU+KfUhOq/dg7o9i4MBSOzXDf5dQBNWgxN2NlwtZIBsUeMLlbfbohxFQRIf
         RK9SXS7nb8j1uqEeYM9WdlySbcrJsjbnUf+10ibe+Miye3x0NsuQi6NeuKf7EdOEbbbD
         nS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772827886; x=1773432686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiOnenw1jcYxE+BclNNPW1TPwN0VcI9bkCDAzXXwTsc=;
        b=fKauqgTQfsmv+AV8bxK/C1MfnMaRG4VPQRzRyDeuAIZoh+u19vOUmRxZZwres6nMJc
         VPBjtCrbJOaAiO2ijNFldff5wkRLqXIBLDZeodU1MFPZy3RxZC8aJvATNd8BX62zWzKi
         5kh4udumzYQ+5N/RPYqOdQsmTU/Xa8gckBR35SYVPv/zaPFGKnfdvfT6X05cpF1sRDFF
         ag3pPrgXi6edvCQXVUgY2mt6DD+iI7etKPywdo4aTgpN8ZBm+xVet4oJhex9inZyGi3E
         GGWJ6EDtOfyWyvicvxX0P7H+wQpEcK50RpQb5a3trhLglwc3lbPec2XFU4dByniV7Wag
         6+iw==
X-Forwarded-Encrypted: i=1; AJvYcCWHMfp4wN3sWbT0CqSiUsFvBmwPtEsc+FZwuLzHJiVX7DdXcJEqffQSkFrWUYH7u380eNsNVjqXCS8X2XYh@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqvmuu/uzQkHShoZj82hWowOml1G6dQFi+9XLsrU6koxenfnrY
	W0MoX8/76gl1r9gFwoUReWG8cXUBvA+hDwYruuuTPrdXYV6Tp/yggLzZRk4lDAM72+Q=
X-Gm-Gg: ATEYQzy1Dl2G0DjuSniUvLFS3PZhJhOHDV/LRfeY/+H6emuklZ37am4I6CBqSp5crgD
	IuScl3HIcwp4uOK02Wzp4+fQ1vU3X2ucLAKnDGH+GXNpxcU6xDVIwuJulbhfrSikGkz8qR90bfM
	eOow509QxiCqjFK1oAoDVN5D7nHn85nyKQr4ZEqoM4WdCRhcpTG0pS++lwogqJlICeGMQpH4pi5
	GtnTONWQ5c56BdBSQu+iY/TbjIChinXSaNAE1OA8U3tg29m0tBg/pLsQzvln7SyZk29Lo23RlXB
	0CPefDtLShWLu1/AbQ8YKeVPQTajXKAlSydCzP2jXxG321AIfl2Pn0Jc6PcxAcc1n/EUPtguGpm
	CPl8Kpk1ZtwF11VE6NXUCJQof6ZI9Fq1GOjnMc9FMHz2YJIbYF6vhJxyuof/5vmEepir6623ubJ
	Ym5xEaz5qo5vWu+bv5
X-Received: by 2002:a05:6830:8384:b0:7c7:5f79:40ca with SMTP id 46e09a7af769-7d726ff8ecdmr2318481a34.29.1772827885967;
        Fri, 06 Mar 2026 12:11:25 -0800 (PST)
Received: from 20HS2G4 ([2a09:bac1:76c0:540::3ce:23])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d728d2e9dcsm1552615a34.23.2026.03.06.12.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 12:11:24 -0800 (PST)
Date: Fri, 6 Mar 2026 14:11:22 -0600
From: Chris Arges <carges@cloudflare.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, akpm@linux-foundation.org,
	william.kucharski@oracle.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [PATCH RFC 1/1] mm/filemap: handle large folio split race in
 page cache lookups
Message-ID: <aas06mfCrJuzZd0-@20HS2G4>
References: <20260305183438.1062312-1-carges@cloudflare.com>
 <20260305183438.1062312-2-carges@cloudflare.com>
 <aanYdvdJVG6f5WL2@casper.infradead.org>
 <aarVMrFptdXhHsX1@thinkstation>
 <aasAo8qRCV9XSuax@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aasAo8qRCV9XSuax@casper.infradead.org>
X-Rspamd-Queue-Id: 6DDA82276BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TAGGED_FROM(0.00)[bounces-79659-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cloudflare.com:dkim]
X-Rspamd-Action: no action

On 2026-03-06 16:28:19, Matthew Wilcox wrote:
> On Fri, Mar 06, 2026 at 02:13:26PM +0000, Kiryl Shutsemau wrote:
> > On Thu, Mar 05, 2026 at 07:24:38PM +0000, Matthew Wilcox wrote:
> > > folio_split() needs to be sure that it's the only one holding a reference
> > > to the folio.  To that end, it calculates the expected refcount of the
> > > folio, and freezes it (sets the refcount to 0 if the refcount is the
> > > expected value).  Once filemap_get_entry() has incremented the refcount,
> > > freezing will fail.
> > > 
> > > But of course, we can race.  filemap_get_entry() can load a folio first,
> > > the entire folio_split can happen, then it calls folio_try_get() and
> > > succeeds, but it no longer covers the index we were looking for.  That's
> > > what the xas_reload() is trying to prevent -- if the index is for a
> > > folio which has changed, then the xas_reload() should come back with a
> > > different folio and we goto repeat.
> > > 
> > > So how did we get through this with a reference to the wrong folio?
> > 
> > What would xas_reload() return if we raced with split and index pointed
> > to a tail page before the split?
> > 
> > Wouldn't it return the folio that was a head and check will pass?
> 
> It's not supposed to return the head in this case.  But, check the code:
> 
>         if (!node)
>                 return xa_head(xas->xa);
>         if (IS_ENABLED(CONFIG_XARRAY_MULTI)) {
>                 offset = (xas->xa_index >> node->shift) & XA_CHUNK_MASK;
>                 entry = xa_entry(xas->xa, node, offset);
>                 if (!xa_is_sibling(entry))
>                         return entry;
>                 offset = xa_to_sibling(entry);
>         }
>         return xa_entry(xas->xa, node, offset);
> 
> (obviously CONFIG_XARRAY_MULTI is enabled)
>
Yes we have this CONFIG enabled.

Also FWIW, happy to run some additional experiments or more debugging. We _can_
reproduce this, as a machine hits this about every day on a sample of ~128
machines. We also do get crashdumps so we can poke around there as needed.

I was going to deploy this patch onto a subset of machines, but reading through
this thread I'm a bit concerned if a retry doesn't actually fix the problem,
then we will just loop on this condition and hang.

--chris

> !node is almost certainly not true -- that's only the case if there's a
> single entry at offset 0, and we're talking about a situation where we
> have a large folio.
> 
> I think we have two cases to consider; one where we've allocated a new
> node because we split an entry from order >=6 to order <6, and one where
> we just split an entry that stays at the same level in the tree.
> 
> So let's say we're looking up an entry at index 1499 and first we got
> a folio that is at index 1024 order 9.  So first, let's look at what
> happens if it's split into two order-8 folios.  We get a reference on the
> first one, then we calculate offset as ((1499 >> 6) & 63) which is 23.
> Unless folio splitting is buggy, the original folio is in slot 16 and
> has sibling entries in 17,18,19 and the new folio is in slot 20 and has
> sibling entries in 21,22,23.  So we should find a sibling entry in slot
> 23 that points to 20, then return the new folio in slot 20 which would
> mismatch the old folio that we got a refcount on.
> 
> Then let's consider what happens if we split the index at 1499 into an
> order-0 folio.  folio split allocated a new node and put it at offset 23
> (and populated the new node, but we don't need to be concerned with that
> here).  This time the lookup finds the new node and actually returns the
> node instead of a folio.  But that's OK, because we'ree just checking
> for pointer equality, and there's no way this node compares equal to
> any folio we found (not least because it has a low bit set to indicate
> this is a node and not a pointer).  So again the pointer equality check
> fails and we drop the speculative refcount we obtained and retry the loop.
> 
> Have I missed something?  Maybe a memory ordering problem?

