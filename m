Return-Path: <linux-fsdevel+bounces-78401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGq8Lj51n2m2cAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:18:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEAE19E39E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ED433064E99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 22:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F84531326C;
	Wed, 25 Feb 2026 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fJKubMqI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA302C11C4;
	Wed, 25 Feb 2026 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772057909; cv=none; b=M7KwhoM8UsQE9khqnaavAr14fjUVYfH5/RywCGha2efcXc85McUiAyxu/Yw6pjMeIKAw/tECr6tKqi7ZxSDA1HpYgWPyK/tetSzBsuTGabB1Y9xRhltVwExeZ93DVJhPSrfIeu8MDJQr2jKDD75ksPZSOW0bPZDSgL/l/m6ppUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772057909; c=relaxed/simple;
	bh=MESPtGKDRlt8IJwv5TniQrMU7gYs8ROvSpwh8dseSGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJG8+M93o6SpSwzkUZEfgK2BbI78QUi2uLbWr1ytuIPukKsWkbBsKTAfTlqkz+RMm2XyrYiJ0usk8VDNGvqFfzP/APSWmspnSVOXRihlJ+y3BTrZ8bp6ggmzEB6v/hlwjwAecNYcihamjR3OsRbK2ynOLz3d4N9mBkxWnlsTg3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fJKubMqI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Wzia6SA/gXRo19NNrlRI89I0YLP8n7DiRr5Nl4I8F14=; b=fJKubMqIlE1O4tZ7mpUGJSQM+B
	WAkJuF6i/l6jscnZHWTIfOIQYU4ZfPrk4SMMX7gSqukXOLpHslLr6Liiw/BmWR5cGE4wslx7QaoWf
	O6P8VbW8fUOl3sOfTHRsGWbRcHjYz7ECSCZBNxKOL7IhZ6rC6tfAnueCxX5hcok6b5Wkam6mLyiEL
	gwNKhQhCpJJJLsK5VUA391ijz2qfcT9nwwBwXkrSUFjQTFvfyOWPlX3CHCq9HN85ZVMTVTrKG17rb
	pW6eB52GGuhNb/LgVihLtbUuvB88h6d4jn+fNnseKoV9OvU/CENPEmWu5ogOMHhn0xIrf/2ZWWdnV
	U6/isCaA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvND4-00000001jW3-2K9k;
	Wed, 25 Feb 2026 22:18:22 +0000
Date: Wed, 25 Feb 2026 22:18:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "anishm7030@gmail.com" <anishm7030@gmail.com>,
	"jack@suse.cz" <jack@suse.cz>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: convert alloc_pages() to folio_alloc() in
 ramfs_nommu_expand_for_mapping()
Message-ID: <aZ91LpkKStjWXTZD@casper.infradead.org>
References: <20260224203134.101436-1-anishm7030@gmail.com>
 <9a40c9e323e30b61527f96796e10daffef5d06e7.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a40c9e323e30b61527f96796e10daffef5d06e7.camel@ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78401-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,vger.kernel.org,oracle.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[casper.infradead.org:mid,infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0AEAE19E39E
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 06:44:28PM +0000, Viacheslav Dubeyko wrote:
> CC: linux-fsdevel@vger.kernel.org

Good plan.

> On Tue, 2026-02-24 at 15:31 -0500, AnishMulay wrote:
> > Currently, ramfs_nommu_expand_for_mapping() utilizes the deprecated
> > alloc_pages() API. This patch converts the allocation step to use

alloc_pages() is not deprecated.  There are no plans for its removal.

> > the modern folio_alloc() API, removing a legacy caller and helping
> > pave the way for the eventual removal of alloc_pages().
> > 
> > Because nommu architectures require physically contiguous memory that
> > often needs to be trimmed to the exact requested size, the allocated
> > folio is immediately shattered using split_page().

Except that split_page() doesn't work on folios.  It says so right there
in the documentation:

 * split_page takes a non-compound higher-order page, and splits it into

Folios are compound pages.  This should have told you that you were
going the wrong thing.

> > Since split_page() destroys the compound folio metadata, using folio
> > iteration helpers (like folio_page) becomes unsafe. Therefore, this
> > patch deliberately drops back to a standard struct page array after
> > the split. This safely isolates the folio conversion to the allocation
> > phase while strictly preserving the existing trimming and page cache
> > insertion behavior.

Please stop trying to help, particularly for code you can't test.

