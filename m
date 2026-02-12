Return-Path: <linux-fsdevel+bounces-77051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DM0GxUojmkMAQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:20:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D715F130A78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F29B30417A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 19:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A4726E70E;
	Thu, 12 Feb 2026 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Hs3hbO2m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F269C3EBF3F
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770924045; cv=none; b=rrfgAqP3dyGjgc6M3CoIXTfhcHsSz/VYJT4HLwUGdbdq3sXx/VJCJomMCNUia7NI6w+73wxPoPRTIL8LddFaLhH1Q5Dsxf96vP52LGQkY1NHRiWSVL/SHGeeVsv2YdoHGWjz7KgApIS72S015VQQxddmYu7ROX9sRWYPrrv/VVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770924045; c=relaxed/simple;
	bh=MlpBW/OtVnPFuOYKeYody2iK9V9sYUf8O+QFfNgw1Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebzNGQ5wwsC/JgGW01UXolN+/TLtOBlNvLMubdLezKOJZQjiqU1QrZKrwhG8IkLFaELg8ovPDhBbbxDBO2h7Aasyw/oDKiq7OKoT7Jr1WTqUbfDJkPri1keeWUaDgquq1a4IT34zZ1Xv27UCBCrKunc7Q1zcQxsdY4KQEHYWyKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Hs3hbO2m; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kGUFQESGdsCsSAUeMyRVXFjlRygdIpycJaM4lrSe8w8=; b=Hs3hbO2mjDT8a2XSKyQm3jDTLs
	VXhlBXc/I85REZk8wz6Bs8BMEWB1BNz1PHf8S4dEJSpXfCoS5g3gOFyB5t1yyxSMK/ivV11vwh90n
	Iw0wKxnd1/eWfekL7VGrOv+5aySxT01cLbt6vZtLvc0MIqdEM9dNY/V8UQ/P/H6BhNRECny4PAhFT
	GJMdTYaOTf1B/tqO9ucElwrnbtjdvtZJQvqUr1H4KMtfIGFZfrr94m6CAqSt15Exs6nnduTozCyr1
	KP/daiipvnxw/zIK2lmzV34xuPP0NfGzA15KN4O53k65bqGxTk0OqMMFdEXe5PoB2uW6t0ttlmpDV
	w678LC6w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vqcH8-00000005oPA-28KM;
	Thu, 12 Feb 2026 19:22:55 +0000
Date: Thu, 12 Feb 2026 19:22:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <christian@brauner.io>,
	Jan Kara <jack@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
	Werner Almesberger <werner@almesberger.net>
Subject: Re: [RFC] pivot_root(2) races
Message-ID: <20260212192254.GO3183987@ZenIV>
References: <20260209003437.GF3183987@ZenIV>
 <CAHk-=whoVEhWbBJK9SiA0XoUbyurn9gN8O0gUAne88a4gXDLyQ@mail.gmail.com>
 <20260209063454.GI3183987@ZenIV>
 <CAHk-=wikNJ82dh097VZbqNf_jAiwwZ_opzfvMr-8Ub3_1cx3jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wikNJ82dh097VZbqNf_jAiwwZ_opzfvMr-8Ub3_1cx3jQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77051-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.org.uk:dkim]
X-Rspamd-Queue-Id: D715F130A78
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 10:44:31PM -0800, Linus Torvalds wrote:

> 
> Am I mis-reading things entirely, or can a random process in that
> container (that has mount permissions in that thing) basically do
> pivot_root(), and in the process change the CWD of that root process
> that just happens to be looking at that container state?

They can.  But then they can do other fun things to the environment
there, so naive root process walking in might be in for really
unpleasant things.  Creating use of mount --move, for example.  Or
umount -l, or...

We could restrict the set of those who could be flipped, but I doubt
that "could ptrace" is workable - that would exclude all kernel threads,
and that could easily break existing setups in hard-to-recover ways.

