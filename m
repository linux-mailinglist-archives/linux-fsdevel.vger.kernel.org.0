Return-Path: <linux-fsdevel+bounces-75182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPanMFHCcmnvpAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:35:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B846ECF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6EE13008338
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 00:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B703358A0;
	Fri, 23 Jan 2026 00:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZMxdkN8I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749033555F
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 00:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769128523; cv=none; b=aQvCFy/IuEJmER29jZFu0YSKWtOewzEXocZ9ZM2LxypETjugVpQI6ladxP1C1TLBC+2Dvq83PF4VTWO8MhKnkrCkymqM2cFvGhE5OUZlx+akQ5GDoCMnm2Sm0P/caByrm7P/DRjp6ZXNqB1/cvv8AeV/3UsOs3onjP4aXesp71c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769128523; c=relaxed/simple;
	bh=eP61JBRIVRbFbol+02mYcO07gAQGmMkyJf5+xCYd2JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4DAfpy9fHeNcGUsVvitt21FBWD4rkgLiOwch5/+G89Ue2CVUnIrGiDQjpj8NsoxQZPp7fyk6k7oLHIAgHWLOkjMrrfzNxv1Izy2qAx+s3+qVxmbHO5KUoSg/krTJzXvyy5/Pr0vkM+nNcPBFxJ6dxhHF2vlq36BRhShtKSFvuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZMxdkN8I; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0tOYeDoU4/E4b6+1OEKEKixKU2p+ACg3Gd9swuYqwKg=; b=ZMxdkN8IGaHUarQ5OnSH6m1hYU
	Uifc6ntFmoEF3NU4FqehHVoy3W0g9L5KDPxhddXuPYV8jHkv76GsrLdRxfmcceEzsIHcpEefD/pWw
	fYs+UJMViIToTq2+LTiY5UqAnL37VWOWy61XqVPwth3F78VmokEVnzRlyy4Xbhhnhs2WxvPAz7sMm
	0zDW6ziCk29I90h/TPSkm12SCwmTmbvQ4BhJ7Y1iL+gHsWsjIWsFlMIeCgdpknCDcyYG4kg+be+Gh
	2El/vZU5DzS6QWphI+VZa8VDjxiI5kn5vp43/AUIjlJga91oVyEca+nW50H3AmBOt/S9oL2RkltYx
	auSzaDzQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vj5AR-0000000GBas-48m2;
	Fri, 23 Jan 2026 00:36:52 +0000
Date: Fri, 23 Jan 2026 00:36:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH][RFC] get rid of busy-wait in shrink_dcache_tree()
Message-ID: <20260123003651.GH3183987@ZenIV>
References: <20260122202025.GG3183987@ZenIV>
 <CAHk-=wj1nKArJE8dj+mwF2bGu+N2-DL0P2ytaLYJRrDdPpa9MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj1nKArJE8dj+mwF2bGu+N2-DL0P2ytaLYJRrDdPpa9MA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75182-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65B846ECF7
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 04:19:56PM -0800, Linus Torvalds wrote:
> On Thu, 22 Jan 2026 at 12:18, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > +static inline void d_add_waiter(struct dentry *dentry, struct select_data *p)
> > +{
> > +       struct select_data *v = (void *)dentry->d_u.d_alias.next;
> > +       init_completion(&p->completion);
> > +       p->next = v;
> > +       dentry->d_u.d_alias.next = (void *)p;
> > +}
> 
> I tend to not love it when I see new users of completions - I've seen
> too many mis-uses - but this does seem to be a good use-case for them.
> 
> That said, I absolutely abhor your cast. Christ - that 'd_u' is
> *already* a union, exactly because that thing gets used for different
> things - just add a new union member, instead of mis-using an existing
> union member that then requires you to cast the data to a different
> form.
> 
> Yes, you had an explanation for why you used d_alias.next, but please
> make that explanation be in the union itself, not in the commit
> message of something that mis-uses the union. Please?
> 
> That way there's no need for a cast, and you can name that new union
> member something that also clarifies things on a source level
> ("eviction_completion" or whatever).
> 
> Or am I missing something?

In practice it doesn't really matter, but we don't want to initialize
that field to NULL - no good place for doing that.  Sure, the entire
d_alias has been subject to hlist_del_init() or INIT_HLIST_NODE(), so
any pointer field unioned with it will end up being NULL without
any assignments to it, but...  ugh.  "We have a union of two-pointer
struct, a pointer and some other stuff; we'd set both members of that
struct member to NULL and count upon the pointer member of union
having been zeroed by that" leaves a bad taste.

