Return-Path: <linux-fsdevel+bounces-75359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vqHpG3ISdWkAAgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 19:41:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DCC7E7F8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 19:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A0DF30041C0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 18:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AC624DD1F;
	Sat, 24 Jan 2026 18:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mtVEzuh0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF463EBF12
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769280109; cv=none; b=uMX4q2yIbO7yklj6q0h2XFpWYRx3Cr7kGHEDrG2xmt0VKRRngw6yMfqLV866i5ctlcQ4+Vv9I8pNvgnQ3JdhC2kpdI4+Nl0IiL0dS9Wi9VNqKWcQvtGSwMq9auBycHbI6VAURtJn+NKzhX8qQFAgu3WiC42D/Bwerh8Ca60lEKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769280109; c=relaxed/simple;
	bh=xSMpAPqJObAG0sakrAE/nSuU5Fl3LVqmho7a0gQm0S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvH1fdZo5oUwSAQgFpa+YOvb9B2UfgLvOAoE4Eh4wDa03+mw9Y5dVRWhD7Q48Qi2XTLfrThfKbJJR4fv+2/dXojvVLDY+d7J5haIKU+dVM2ulxYNkKicVc91Q4IXKuXHB4Od7/TX+Vii7kdDwiHjmFm20Anbtc0f6SOOMXdpNns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mtVEzuh0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u6zOcr8+yNYRxJncYYiB+i0pQJJKnzw3w1Zam97U1h0=; b=mtVEzuh0pksXgIBAmt/3MH3w6o
	6Uh4pAozj/uFB20UKGYO6fYnnm2CF1DKYi/L4fVhxJAPJIAi/gyYqlLM+cizlsQ+iIQLmLRksUIlY
	1UFG1IW9lVUCurCsOOCNtuEs9i5VMMRcR8Lo24vXjl5aK6v6ifRmESeqBej62DT1Uqsq69nkk71kr
	FJYKSWoPMAzIhwkOa/jFpKL61pGchYTHoGzcbGPQANwlVJa4griLhkx2qi3S4jwHZnNuo1L8HyF19
	D7804wqtPvk/mM9xPlyTK0yaSyiSiwDlhNkRCPIWilZktfX3/8HJm+WOwnd1QoDUbfUErtq8roSlW
	J+u220RQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vjibY-00000004JWx-3Qkt;
	Sat, 24 Jan 2026 18:43:29 +0000
Date: Sat, 24 Jan 2026 18:43:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH][RFC] get rid of busy-wait in shrink_dcache_tree()
Message-ID: <20260124184328.GM3183987@ZenIV>
References: <20260122202025.GG3183987@ZenIV>
 <CAHk-=wj1nKArJE8dj+mwF2bGu+N2-DL0P2ytaLYJRrDdPpa9MA@mail.gmail.com>
 <20260123003651.GH3183987@ZenIV>
 <20260124043623.GK3183987@ZenIV>
 <CAHk-=wgkSAHswtOzvTXeBOz1GLNfsohSPdyzZmnVYe2Qx4fetQ@mail.gmail.com>
 <20260124053639.GL3183987@ZenIV>
 <CAHk-=wgGCyjEC9ookrcVou4__nkPbSosP7RG6AwntBZbdeAjuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgGCyjEC9ookrcVou4__nkPbSosP7RG6AwntBZbdeAjuA@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-75359-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1DCC7E7F8
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 09:45:54AM -0800, Linus Torvalds wrote:
> On Fri, 23 Jan 2026 at 21:34, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > The only trouble is that as soon as some joker slaps __randomize_layout
> > on struct hlist_node they'll start flipping from sharing with ->next to
> > sharing with ->pprev, at random.
> 
> If somebody starts using randomize_layout on core data structures,
> they get what they deserve.
> 
> We have tons of data structures that are *NOT* randomizable.
> 
> In fact, RANDSTRUCT is so broken in general that we actually taint the
> kernel if you enable that crazy option in the first place. So no,
> "what if somebody enables it on random things" is not even remotely
> worth worrying about.

Very much agreed, but we *do* have that on e.g. struct path (two pointers),
as well as struct inode, struct file, struct mount, etc.  As far as VFS goes,
those are core data structures...

While we are at it, does anybody have objections to making dentry->d_u anonymous?
We are already using anonymous union members in struct dentry, so compiler support
is no longer a consideration.

Another thing in the same area:

#define for_each_alias(dentry, inode) \
	hlist_for_each_entry(dentry, &(inode)->i_dentry, d_u.d_alias)

to avoid the boilerplate.  Objections?

