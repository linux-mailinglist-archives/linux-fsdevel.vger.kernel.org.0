Return-Path: <linux-fsdevel+bounces-78706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAExK1uAoWkUtgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 12:30:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF831B692F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 12:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A808310CFD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 11:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A469B3EFD09;
	Fri, 27 Feb 2026 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="SkiKxtlm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E903EF0D3
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191757; cv=pass; b=Z3bZCzNr3mRWXJNGEYoKiwPZREKVXZZzQkB3fIduyRhpW3+9F1qm30KltpzkaXnjAgTbHBiDlBq4c2G5GYtDN/g78KHCbjtEwqkPb9J8dXYwUWlhIM6Rw7+5Ps9XJdaeCqzTCjJiVQWA6OJMj/uz3oosVSokRh5v3SUAix51gvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191757; c=relaxed/simple;
	bh=5apxEmsZ5k/V4WaJUnpn0eyx24PQ+sSpGfBIGPwBrFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJOO8Z1HHTM11aB3EsC3M0zFpq93/KPIF8xuUa1KeWvifnxwtJSFcf+f/JIhrlzz3QW/Z8YpblKElkjv+T4n8IXE68dcXMYIYx+XEEOEMfeNpUaYu8BX13PFFLvQ8W8EXsfQHNYBHoJlyLeRbikmHgB34vptP0OkXq+jm7eX56M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=SkiKxtlm; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506362ac5f7so17876031cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 03:29:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772191752; cv=none;
        d=google.com; s=arc-20240605;
        b=VRcZ5uKDK0MxRxX2j1avP5X7KG6r9ncCl20+z7Kmx6RlffxPJEsEdD+Bw2XyXPQvJN
         Yq61e60/DIaGbjTPK+0FfvSrpt34dlKzkzcwNjInw0G/50ZkhgVNG6+cQFCWGxtQB7Br
         0tECnPEHX7u0EQMLWHXNQgL7hynumFyuXyk8B2hhRVEqXp2mWQtKqi2o+m5T9WZizTN5
         8BUyvV0G8CzPsIHaKPLDYlG34gnP3RVKDqTEzVdUGdx03Z+BRQD9eABmgj4MJuYDz45L
         A0QQ2pLS/i1tCD5I4a3m5fltw/Aq11n8aMglXFQREZ31fE2xNfBOPtwY6xt0Gpj1r2S0
         /qAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m8LFRyqi+lkEuWrw8hv5m1iY3CSZorTJdV9oCqgI28c=;
        fh=WqekBisCs40BrqORJEDvh74PKdYD8MXGUWMRMN7akrg=;
        b=BJ5uKZ5e+3xcgvP4ycIZwGodbxzh1R2MtGliaXwTSxhIt4vws21aI6OO6rmUUFT0g/
         7q4VoI2RSNQgIwRwKg+LnXSiExKp1Qi99ERF/bLJaTOHaj7+9v8eXbdrdJawoA0xsexF
         UWrq5S+2RRPmpYAcUUUCe0vp8hg9885Y0Pg0mSAXAXxwjebCd4NSULjqxmLiqgeEn7yM
         gMHCS4axElCQAQQl7NhODi4waTIn2IkG6Xw1yTECbTUCkobqrdxECwzl/fxg4LsKoOgO
         3+Pjh6zEueOHUx2gEVeMZPHv4VpKf8DaowN5pFZ3MDbYRlNqOV0Qd+DAQd48BStJZKSP
         9ayQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772191752; x=1772796552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m8LFRyqi+lkEuWrw8hv5m1iY3CSZorTJdV9oCqgI28c=;
        b=SkiKxtlmQquTqKnMhYMlC+R9renJiVu/7tVy/FiG7uSciTGlo/H8dDiPSLO4R/KPLx
         Q0YVv/cZiBkuNFGWP9GwdAbTe/9aUCnLtAjN2HCM8Ow42SfsbeCJPTtO6LDYJC5Od/rN
         UOgqlCLfq4mMrHrW3iI0WuUhtR/sH77D7wzOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772191752; x=1772796552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8LFRyqi+lkEuWrw8hv5m1iY3CSZorTJdV9oCqgI28c=;
        b=hIvQs2ap3TXlEZ8WgNbuxMDIDyhyYn1LTB8H6xO62pcq2DeFUsDvzhKKhE6zpcol6/
         iu27BdU+k415jkMtSm+L96oytYS9eVkZ1mx88hoAFSDSE+0waqTZI/ALq1DcxPtGOwka
         sbzrAyDTi2/U2G5G9Hzwk0uTvmjq9UZYTxy8A/geML2sP/4xUsgFGaRd8cQ/NdA8shSa
         7qH04z0oqePMD50x9ux1X4m+EkGyCq2su8OOg0I4WqDHushojVWA6+ZtE82k42hVESjr
         cG2kUVp5r4nx5rslOFurDXoVbiLhf8yddi/G8lK/tK2bwf3iatQQzLB4l9brO/2fVt2Y
         Pq3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXa6xWxJOBuQcD5VZyrNVasLOZufma9IoYkYNbrQz1LNFVvdKrTvOLqapFMtRAhZAdD0LT3snc+QIkA/WON@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9IQN2IQDh3mIIgMiHSmI2M1aCH25LBulnb3PD/xQdxGu6fJj
	H9wQFy9zcNV8JUxsCu1EFg4kyPZOaVVW/7zTgruhJBJlPG9gOEzKpO6ohev9L3WrYD+0jTwNgi0
	sW0VtwdXmJRBTcK/2azvIr0ssXV03pcNP9kMpbLT5iQ==
X-Gm-Gg: ATEYQzyB1d1yU/nsX/7JfBZumLrQr1p+7xILsb0v2USvm23lsuL4H8f/mguaw1RB9Zo
	WGS3668W8VuUZyRVWpHltH+ZbWlK+MriHKRf0/Nq40p60rFDVxi5YhsgiiZdTfuQSd+/y4F2a85
	mXNEKo2J8GuaMJThXRowO4mq2DW8uHmiRLw9HAf1CIG9ANbokRGxCkQKOOBROHQzANENJYbFcpX
	wWtVpHD9wVDP8dbjqqwE8cfL2lXowSsP7nZomlDWT4369EfLnvPOcZozoSNPf3Nc3iS169bbfi7
	zGcW2g==
X-Received: by 2002:a05:622a:138d:b0:506:a15c:507e with SMTP id
 d75a77b69052e-507528a836dmr26409931cf.64.1772191752216; Fri, 27 Feb 2026
 03:29:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-1-8585c5fcd2fc@ddn.com>
 <CAJfpegsNpWb-miyx+P-W_=11dB3Shz6ikNOQ6Qp_hyOp1DqE9A@mail.gmail.com> <aaFyQX9ZI4KmqtFQ@fedora.fritz.box>
In-Reply-To: <aaFyQX9ZI4KmqtFQ@fedora.fritz.box>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 27 Feb 2026 12:29:00 +0100
X-Gm-Features: AaiRm523z_EYulx2QM9-2LVxnRAiAEizZFDVZrMwNhoCQ9mXbVysXKBSnBwScUk
Message-ID: <CAJfpegun=NNM099f6GC2_E2TbG0s936V_sW5SExt6mOEC0_WMQ@mail.gmail.com>
Subject: Re: Re: [PATCH v6 1/3] fuse: add compound command to combine multiple requests
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Horst Birthelmer <horst@birthelmer.com>, Bernd Schubert <bschubert@ddn.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-78706-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,szeredi.hu:dkim]
X-Rspamd-Queue-Id: 0EF831B692F
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 at 11:48, Horst Birthelmer <horst@birthelmer.de> wrote:

> > FUSE_SUB_IS_ENTRY - this sub request will return a new entry on
> > success (nodeid, filehandle)
> > FUSE_SUB_DEP_ENTRY - this sub request depends on the result of a previous lookup
> >
>
> we don't need this if we use my converters from above.

Dependencies need to be handled by the kernel and libfuse as well.
Makes no sense to have two separate mechanisms for handling
dependencies, so the kernel should use the same flags.

> Could you maybe provide some examples of usecases, that I should try to drill the
> new logic?

- LOOKUP + GETATTR[L]
- MKOBJ + (SETXATTR[L]  (only for posix_acl inheritance)) + GETATTR[L]
+ (OPEN[L] (optional)
- SETATTR + SETXATTR (setting posix_acl that modifies mode or setting
mode on file with posix_acl)
- INIT + LOOKUP_ROOT + GETATTR[L]
- OPEN + IOCTL[O] + RELEASE[O] (fileattr_get/set)

Only two dependencies here: lookup or open.  Both are simple in terms
of just needing to copy a field from a previous request to the current
one with fixed positions in all of the above cases.

The LOOKUP + MKNOD one *is* more complicated, because it makes
execution of the MKNOD dependent on the result of the LOOKUP, so the
dependency handler needs to look inside the result and decide how to
proceed based on that.  Some pros and cons of both approaches, so I'm
curious to see how yours looks like.

> I have used compounds to send groups of semantically linked requests to the fuse server
> signalling to it if the kernel expects it to be one atomic operation or a preferred
> 'group' of requests (like open+getattr, nothing happens if those are not processed atomic
> in a distributed file system)

Which is the case where the kernel expects them to be atomic?

Thanks,
Miklos

