Return-Path: <linux-fsdevel+bounces-79327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMWpCaj0p2mtmwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 10:00:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ECB1FD0CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 10:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 318B73023528
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 08:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FC8383C89;
	Wed,  4 Mar 2026 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="IgwhGUHg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e3i214.smtp2go.com (e3i214.smtp2go.com [158.120.84.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A414308F26
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614790; cv=none; b=oXg2s6W75SqlNk7FYPuv19mT4lVIz65yF+WzmOa2NygH7VjfOea5aDM5msSHy0SvQBhw9XKH6C/LIVTYs//g3awpEnL1FGTeD/7od58KpO7vQ44zGlHG3+r3FcuGdv7f6C+GgfITnWXcqva9Z5y55S2wxPnDdE0WeqhWfdFISss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614790; c=relaxed/simple;
	bh=s3YTevfNULOu7OTTUNNxgQc2Xj3CV6y1o+18YQgmD7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feyQg/r49VytPz7+cuUriV7GAM/83I/6rb8F2kfByneAeZJwTaLEuo3rQrmrmTd1Q7PHzrvyAAGN0K+5QuGZOIc5M1jVtApnhLt9dROKedIynBtcCmbAo1bmZkbyq7IJMvcTI30wSujCDKqkVJ9GkjfLrXygG7VTBmo8k8FjKpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=IgwhGUHg; arc=none smtp.client-ip=158.120.84.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1772613880; h=from : subject
 : to : message-id : date;
 bh=xbrA9YZeGMtG25RjPVPDTCWMxFBr6tAPEzmQlhLARLA=;
 b=IgwhGUHgo+YW3cS0sPmIigDTi+tAoZzO9QeQHmj6UDQK2PjpeRBzlTyBGke1eG1JDk+Dt
 Gpd4P4r93RD39Ooi5C909SyWlphHzSYUTPrt4gr9XKF08pgeoaPJjWVJjkrip1SUEtySTd2
 xBFGG20jlzF7HqRj/Pazln1VxjjKCNYxMp8HHAkOjKQhnJu7VrW4M8eJ9PC+Cn9vw4MeJj/
 QdAoFlrkxFo1zMcaV1i69aD5JJb0apAoUSDrOQiCMjrvEFWgkH6niYClpRvUVWm2v4Z2eRF
 QFMnyd3Y+hUPlXeuPNOhbKyXMYCh2BpwArlZJ1H+21zijcmgz801+FrHgecg==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1vxhqL-4o5NDgroe1r-qrjL;
	Wed, 04 Mar 2026 08:44:33 +0000
Date: Wed, 4 Mar 2026 09:25:27 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH v3 2/4] 9p: Add mount option for negative dentry cache
 retention
Message-ID: <aafsd7ScsUFs7xhp@pilgrim>
References: <cover.1772178819.git.repk@triplefau.lt>
 <7c2a5ba3e229b4e820f0fcd565ca38ab3ca5493f.1772178819.git.repk@triplefau.lt>
 <4490625.ejJDZkT8p0@weasel>
 <aadWf2Ox2YXdy0Yl@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aadWf2Ox2YXdy0Yl@codewreck.org>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sdCwzjTJ0C
X-smtpcorp-track: ekPbQi5zuc_G.zuiPp7gv_52L.bFKSMQv3zn0
X-Rspamd-Queue-Id: E5ECB1FD0CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[triplefau.lt,quarantine];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79327-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[triplefau.lt:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,triplefau.lt:dkim]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 06:45:35AM +0900, Dominique Martinet wrote:
> Christian Schoenebeck wrote on Tue, Mar 03, 2026 at 03:53:47PM +0100:
> > > +	fsparam_string	("source",		Opt_source),
> > > +	fsparam_u32hex	("debug",		Opt_debug),
> > > +	fsparam_uid	("dfltuid",		Opt_dfltuid),
> > > +	fsparam_gid	("dfltgid",		Opt_dfltgid),
> > > +	fsparam_u32	("afid",		Opt_afid),
> > > +	fsparam_string	("uname",		Opt_uname),
> > > +	fsparam_string	("aname",		Opt_remotename),
> > > +	fsparam_flag	("nodevmap",		Opt_nodevmap),
> > > +	fsparam_flag	("noxattr",		Opt_noxattr),
> > > +	fsparam_flag	("directio",		Opt_directio),
> > > +	fsparam_flag	("ignoreqv",		Opt_ignoreqv),
> > > +	fsparam_string	("cache",		Opt_cache),
> > > +	fsparam_string	("cachetag",		Opt_cachetag),
> > > +	fsparam_string	("access",		Opt_access),
> > > +	fsparam_flag	("posixacl",		Opt_posixacl),
> > > +	fsparam_u32	("locktimeout",		Opt_locktimeout),
> > > +	fsparam_flag	("ndentrycache",	Opt_ndentrycache),
> > > +	fsparam_u32	("ndentrycache",	Opt_ndentrycachetmo),
> > 
> > That double entry is surprising. So this mount option is supposed to be used
> > like ndentrycache=n for a specific timeout value (in ms) and just ndentrycache
> > (without any assignment) for infinite timeout. That's a bit weird.

Yes I have seen this used in several other fs (see init_itable mount
option for ext4fs or compress one for btrfs). I do agree that is a bit
weird but this allow the whole 32bit range for timeout.

> 
> Could make it a s32 and say <0 means infinite? I think we have that
> somewhere

I did that on previous version, but was afraid that ~20days timeout max
value may be too restrictive?

I do agree that this is a bit odd though and if you both think s32 is
better that is fine with me.

> 
> > Documentation/filesystems/9p.rst should be updated as well BTW.
> > 
> > Nevertheless, like mentioned before, I really think the string "timeout"
> > should be used, at least in a user visible mount option. Keep in mind that
> > timeouts are a common issue to look at, so it is common to just grep for
> > "timeout" in a code base or documentation. An abbrevation like "tmo" or
> > leaving it out entirely is for me therefore IMHO inappropriate.
> > 
> > You found "ndentrycachetimeout" too horribly long, or was that again just
> > motivated by the code indention below? I personally find those indention
> > alignments completely irrelevant, not sure how Dominique sees that.
> > Personally I avoid them, as they cost unnecessary time on git blame.
> 
> I rarely use blame at all and it's possible to ignore whitespaces for
> blame, but I'd tend to agree here, I don't care if this stays aligned.
> 
> OTOH ndentrycachetimeout as a mount option is a mouthful,
> negativetimeout or negtimeout sounds clear enough to me?
> I can't think of anything else that'd be negative related
> to timeouts, but perhaps it's the lack of sleep speaking

No strong opinion on the option name though so any name that suits you
is alse fine by me.

-- 
Remi

