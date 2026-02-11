Return-Path: <linux-fsdevel+bounces-76930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIlOBTZMjGmukgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 10:30:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE10122BF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 10:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 675FD3028001
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 09:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2A33559C4;
	Wed, 11 Feb 2026 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="nUe8gnPl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58D2E2846;
	Wed, 11 Feb 2026 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802213; cv=none; b=GrzoGZyqp5likY6ttpaf31iZ0kHJapFD800D2reENsI5Nsf2NY8qM+3VUxwbXCRM49ZAJymd0wPKvtgKVFKHVdGj6dIO6Axa5yfx+RDsHy2rFPqPCrWYw74rXPdZGzEOSKRmvElhn/XsuLuWhkxxGSGVulXj5SAkC3ad7I8PeeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802213; c=relaxed/simple;
	bh=EqakioYghRNqkCQBAO5HuncnmYB7Lk+8kffgMpM3l/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6WoCj7KE6lXsh6zvhEk8uUoW0G+LK5pRvdHsFIaHecdERRkajQeEbZYapvqr1p4oQTUnpcrk8gm+dlscl3xZfEdAEuwDE2lMxsBZYkbnHkAYHj3yFLu4qN4hp5Cz0Ya/t8URU4LlA1gdYhEmPBFApNhHirMXxPysiT/m41sEdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nUe8gnPl; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=/p0l5jRRZK2EQAfLRLRqfh8VdcD5GwZDTrR8qMHZTVo=; b=nUe8gnPlDe0cRJqScxzvF7yE96
	0h6s/ZbNlh5NaKG20kfA3ejNa+5bCi4M4P7wk/X4Q22I639APluyeTL2lhlfUdDzW1ckkhh1jeMwo
	l7RSgGbW4YC+4Q7iJ57ZCruwyDcgoMHXwCZ2h0eLA5gr89esgjcoz8g/C3mGhSjU6lI3NskDTefZI
	Bc+a2Y+V1Sc+jc7D+30IshwlhJPLJOhmtZVQd1iiW88BzqpGDcd+36dEu/xx+fUQdN2xvK/ttuIFu
	vllrmlwhgdMjhQXxUQxR0X8K/Ws6POcqtpfnf9U9Lkb1w16Qo8zpHqJVMBj+CeBeKKc/5SegxELiw
	VvFodD8g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vq6Xp-00Aw2T-0w; Wed, 11 Feb 2026 09:30:01 +0000
Date: Wed, 11 Feb 2026 01:29:54 -0800
From: Breno Leitao <leitao@debian.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Matthew Wood <thepacketgeek@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, hch@infradead.org, 
	jlbec@evilplan.org, linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org, kernel-team@meta.com
Subject: Re: [PATCH RFC 0/2] configfs: enable kernel-space item registration
Message-ID: <aYxL7d4MxbepGnKb@gmail.com>
References: <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
 <878qfgx25r.fsf@t14s.mail-host-address-is-not-set>
 <-6hh70JX5nq4ruTMbNQPMoUi6wz8vmM2MQxqB3VNK3Zt97c-oxWOo3y0cQ7_h6BSfcp78fR9GmzxcTQb_WB-XA==@protonmail.internalid>
 <ineirxyguevlbqe7j4qpkcooqstpl5ogvzhg2bqutkic4lxwu5@vgtygbngs242>
 <875xakwwvz.fsf@t14s.mail-host-address-is-not-set>
 <C6V44SxiJH8NxRosmbshR-sfcBisrA5yWQpDmfQXe5vOX3uI6SM-r7wwUr7WxfPMS5ETUQ9GYDlptRs911A_Qg==@protonmail.internalid>
 <aYTWbElo_U_neJZi@deathstar>
 <87qzquuqsx.fsf@t14s.mail-host-address-is-not-set>
 <aYnnHJ2TQEcD_xMS@gmail.com>
 <877bsjvhqv.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877bsjvhqv.fsf@t14s.mail-host-address-is-not-set>
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76930-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,infradead.org,evilplan.org,wbinvd.org,meta.com];
	TAGGED_RCPT(0.00)[linux-fsdevel,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AEE10122BF4
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 08:53:12AM +0100, Andreas Hindborg wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
> > On Mon, Feb 09, 2026 at 11:58:22AM +0100, Andreas Hindborg wrote:
> >> Perhaps we should discuss this at a venue where we can get some more
> >> people together? LPC or LSF maybe?
> >
> > Certainly, I agree. I’ve submitted my subscription to LSFMMBPF with the main
> > goal to discuss this topic. I wasn’t planning to present it this, given it was
> > a "overkill"?, but I’m happy to do so if that is the right direction.
> 
> I'd appreciate if we can get some people in a room and force them to
> think about this. I think it is a good idea if you submit a topic. If we
> don't get a slot, we can see what we can do in the hallway, and if that
> does not work out we are forced to make a decision between the 4 of us
> participating on list. At least nobody can say we did not try to collect
> input and opinions then.

That is an excellent follow-up and direction, let me submit a topic in there.

--breno

