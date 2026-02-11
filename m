Return-Path: <linux-fsdevel+bounces-76927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LshJnc1jGmojAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 08:53:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B584121F46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 08:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA6FD301B7B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 07:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B6134EF14;
	Wed, 11 Feb 2026 07:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCO90GH+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128EC28725B;
	Wed, 11 Feb 2026 07:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770796401; cv=none; b=U/n9f8dRB27K1FwoJLxuHkvb04dh3nMxOvbK3fVtN7On71zHC+nLEcTqRMzQscSOAmI+Atki/rX4BJZ0YdS/OhuBESpG0ajiHw3sLrrpTvhzz+PHT4XbWgSlP8U9169jUqorGAqH8Uhr42Piae6gpxlGseuQD5UNCbsBX/kaEJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770796401; c=relaxed/simple;
	bh=8PdTrcrRLxnw1GH1MFtzUQ7Fyaxjnmz8RBfXIHwfsmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cqf8kuypTQ5A5FMOyjnFCQWQdKyhuLMs2gbHIxlatp3GCKPqeESrQZGlTSyooeB62Fd98+PdOL3KM8yCF+j9a8F5EaVnk1er9116CmSEdHZXxemvMg9lpcgKALz4MAheg5JxN6NN+kihD7LKAETJWgUSSSOz/xzNToTDVFgQB/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCO90GH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC49C4CEF7;
	Wed, 11 Feb 2026 07:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770796400;
	bh=8PdTrcrRLxnw1GH1MFtzUQ7Fyaxjnmz8RBfXIHwfsmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VCO90GH+qa3KUnBsKAzo9i1qJLRJ5ms6iYx1XZ6jXKrw9mztE8wrs22g6b2BUAOHB
	 U2TzQhOesk7RAKwHYokjKLy3697eDUykyaQqhWIuhj5hZxlXyQZcIDxBfEuMuG18vc
	 1dFTwKuoaxfFS/9BvHS6Tw4uOnhNdPjBqT8MEkg4Ir4NdkStgmVzlyojjA8Bh8W2NB
	 5uo3L1Iu7FsAhbbvLIOD9OowYteDwDgsg+RdgtrZTjnHYokDvZkf17uubE91/Yq+LO
	 UqRFSU94n0btLZ1bx+dUeuaQmkfIDgOfcPVGABg++XjyTqs36JzCzIWbR3a0wD1Slo
	 e++2j/xLtYWqw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Matthew Wood <thepacketgeek@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 hch@infradead.org, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org,
 netdev@vger.kernel.org, gustavold@gmail.com, asantostc@gmail.com,
 calvin@wbinvd.org, kernel-team@meta.com
Subject: Re: [PATCH RFC 0/2] configfs: enable kernel-space item registration
In-Reply-To: <aYnnHJ2TQEcD_xMS@gmail.com>
References: <fdieWSRrkaRJDRuUJYwp6EBe1NodHTz3PpVgkS662Ja0JcX3vfDbNo_bs1BM7zIkVsHmxHjeDi6jmq4sPKOCIw==@protonmail.internalid>
 <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
 <878qfgx25r.fsf@t14s.mail-host-address-is-not-set>
 <-6hh70JX5nq4ruTMbNQPMoUi6wz8vmM2MQxqB3VNK3Zt97c-oxWOo3y0cQ7_h6BSfcp78fR9GmzxcTQb_WB-XA==@protonmail.internalid>
 <ineirxyguevlbqe7j4qpkcooqstpl5ogvzhg2bqutkic4lxwu5@vgtygbngs242>
 <875xakwwvz.fsf@t14s.mail-host-address-is-not-set>
 <C6V44SxiJH8NxRosmbshR-sfcBisrA5yWQpDmfQXe5vOX3uI6SM-r7wwUr7WxfPMS5ETUQ9GYDlptRs911A_Qg==@protonmail.internalid>
 <aYTWbElo_U_neJZi@deathstar>
 <87qzquuqsx.fsf@t14s.mail-host-address-is-not-set>
 <aYnnHJ2TQEcD_xMS@gmail.com>
Date: Wed, 11 Feb 2026 08:53:12 +0100
Message-ID: <877bsjvhqv.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76927-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,infradead.org,evilplan.org,wbinvd.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[t14s.mail-host-address-is-not-set:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B584121F46
X-Rspamd-Action: no action

Breno Leitao <leitao@debian.org> writes:

> On Mon, Feb 09, 2026 at 11:58:22AM +0100, Andreas Hindborg wrote:
>> Perhaps we should discuss this at a venue where we can get some more
>> people together? LPC or LSF maybe?
>
> Certainly, I agree. I=E2=80=99ve submitted my subscription to LSFMMBPF wi=
th the main
> goal to discuss this topic. I wasn=E2=80=99t planning to present it this,=
 given it was
> a "overkill"?, but I=E2=80=99m happy to do so if that is the right direct=
ion.

I'd appreciate if we can get some people in a room and force them to
think about this. I think it is a good idea if you submit a topic. If we
don't get a slot, we can see what we can do in the hallway, and if that
does not work out we are forced to make a decision between the 4 of us
participating on list. At least nobody can say we did not try to collect
input and opinions then.


Best regards,
Andreas Hindborg



