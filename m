Return-Path: <linux-fsdevel+bounces-79332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NH0HmT9p2mlnAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 10:37:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F3B1FDB80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 10:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51DD2303935E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 09:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486E239A055;
	Wed,  4 Mar 2026 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bQpEhmaS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFF2396B6F
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772617054; cv=pass; b=B9nkZ+Z2OCsO175uuXp8H6dr36lGpAfA7Posz3Fpk2tm0l14DJcLPtsWgevBtXNf+o0zOZUXNYuw/kPten8q7rlKqXKdA+2fyqHny24Bfvwy0Xwx6EfbRSjLxV/GCwda3E16wXMSr1YjOdUIhJhzCi5+kX8iwg+UVadDKtiezW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772617054; c=relaxed/simple;
	bh=zsST4vH6zXvQE27TSVWpSLHeefE99tu9SotK9R52mCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAj5/u7JNNjkd/Qy3W8lzPTgge92xMBDBeXhiguTu5rPt61hGzkS/sApJRlRPF33jzyiBIujiaPo/lveukh57PJiLwqu1gSaBK9saATQUmD6lEflQwUfMuKqwqZIuNWjs9GW4JOGPrN4R+JAboVwllWG1UxdyPCQfRiEYf6WhcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=bQpEhmaS; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5069df1d711so58280051cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2026 01:37:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772617051; cv=none;
        d=google.com; s=arc-20240605;
        b=IA8hf+SQi8WDinQts/4YwWYwthmhmz64NxO5NKeCHkwnZbkkvjsq5tDQ3iGqN/XNIs
         Qbh7HOFQof9m+27eV0OXfwdMRhMTBwAFeodkQMYjHDSVvOy5KKEA/PEg2o2zwWxFycXM
         pRiI4e8rFRrs/c/G3jMdFOOCc3X7MLGzH07kkXf91bDUc3xWyhtaXZxhLOISgd5dgYg8
         oq/e2aqZIQObQxV2p9JMHTsKG04GlDuOF8jXsNIve6DZ1ikE4Qx5/Zo+veTvOhV372Hh
         3Im1+hvkQ556Fq+51zvJhg93WmCyNd6gfkZcjotni8l+zzU+Kk7E4hqJI5iKqxbhH1OJ
         mhbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h8A4SJsih3ZyMtVSALohi7dXqkCY75NqK7TWsk8YPwU=;
        fh=O7KGQwoIjliGcwRixeWWW3rBsU33cOv2s+vAoDC7YjI=;
        b=TSmfmFn8GlJe3MNlNs4XH9Qrxn1Wkc0y+LZos4o+nooCy0nY3jZNDTtaF5HTvrt1zi
         tUSwtI04PjTps4e6976MpQ9XakLF4KN1486aNU4oppWRxoGdpLx5Cr88VRZRFJ1vJBLQ
         KYzy3VRpHofEm0KwXkw+QPHl/wTXeLABIL5vqrI5s/tONipCsx32JJluAG6cbpCjsswx
         T9PajbARMz83Uraon4E5KxRj3hlwSV8NoJKYxF68VuEJ/rBwqIYXAaC7/6btMtLVI2W9
         FmTudrV7Zp3oy3szf7cdUMzxEV2qTqxH+TM1TNrkQjeNifPoxsTX6E6l2V6NwJ3Dj9gY
         5pKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772617051; x=1773221851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h8A4SJsih3ZyMtVSALohi7dXqkCY75NqK7TWsk8YPwU=;
        b=bQpEhmaS6C4nR9alMfJ5EAE3ATrYI0uLxStYGmSqjCzD75cyC89O9N9o2p11T/gyUb
         nJ6Ju6dje64C/y2G2UHcpDwCv5AAb5AtFV/bphYVh0ob4T/FNfOpuM47KFfbZisASfdP
         Jo0NSyC83uWR9ibuDXprl4oWWDFPIVy5HRRKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772617051; x=1773221851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8A4SJsih3ZyMtVSALohi7dXqkCY75NqK7TWsk8YPwU=;
        b=PMXbprWRRmc4c3dhjthbUPrMoAdhTym+u0Vpv+LjVHYFnl9PA633eNcWfvT7+C+34K
         5yi2WTVXoCSXEkEJh4s//HtD5G9XK7l56Sn5/8HGmCVVD1DVhwk/h94N5pqh0rjRdXkG
         fv68MxgRENnUSep9mazO2r0kUERmTNcZOZqOnXnn7HjTV8nf87m9MdPKxfImyl95Uhx5
         mp+mOmExzrfa23hRdjHPxxEDp9WQmlT7HbYbP4/mU8y/eIKEFF4xPDB4L2Dgdlx/T1HF
         UQfIAqRtl2HqpV1jNcf+Sio8YmVhAq6nhcpvcOtoBC6ov8B98PtYC2kGe2YTDm2HpdYf
         bWAw==
X-Forwarded-Encrypted: i=1; AJvYcCV5nS0zF8/960FLU3AVU2yj+tNzIeH4CcB3NLao6EhMSwCYchStMZ1zeexybNoUaMFQZRmbCihZV/o34Wes@vger.kernel.org
X-Gm-Message-State: AOJu0YyIbA+Hr53UqY6LZKWucYY3hm64pbSWZbHbhFbMncMzMy9CjjtK
	LJAkmeY5tJaoKNPl7PEagIXpw7WCf4akiddJ1i+DcjIEUYeTmryHcWcXng/t3Kse3qZoEotM/4X
	8ZT4GvdkSoj5E3VtyxXa/9RVLJ4wb9FA3oGj503d3sg==
X-Gm-Gg: ATEYQzzpru2lYV1rRqhjOTnMzlC2qvPPj0uNIpt+MkmNkaAP++lohkH/vQkxhZHFS4w
	qsQHEQZFG7h5FvqHVBAPfFY6zm87j+fL3HK0Nu/i4CR9LOTI+a1RW/OMqtJwK7rgg5h+2OSfgkj
	4460miDcjKnjPUaoQobO7dVrDO3tLJS85av/0omtCqoSoTPu57QjKmOfsqvJeB9Msn3eqs0c8dc
	KpX/2qU9RVJT2L+bLlrYr80VQfTQnF+wH9TYmki6YFg/y7z0O6wc6+Bi8U3ht/A11/n9UH8eOLz
	RtkcHDOrxQ==
X-Received: by 2002:a05:622a:54c:b0:501:3e36:1513 with SMTP id
 d75a77b69052e-508db23d427mr17087431cf.6.1772617051379; Wed, 04 Mar 2026
 01:37:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-3-8585c5fcd2fc@ddn.com>
 <CAJnrk1ZsvtZh9vZoN=ca_wrs5enTfAQeNBYppOzZH=c+ARaP3Q@mail.gmail.com>
 <aaFJEeeeDrdqSEX9@fedora.fritz.box> <CAJnrk1ZiKyi4jVN=mP2N-27nmcf929jsN7u6LhzdYePiEzJWaA@mail.gmail.com>
 <CAJnrk1ZQN6vGog2p_CsOh=C=O_jg6qHgXA0s4dKsgNbZycN2Cg@mail.gmail.com>
 <aaKiWhdfLqF0qI3w@fedora.fritz.box> <CAJnrk1bHSRxiKNefNH_SUq1E93Ysnyk-POjh5GWxy+=8BewKtA@mail.gmail.com>
 <62edc506-2b0c-4470-8bdd-ee2d7fcc1cf1@ddn.com> <20260303050614.GO13829@frogsfrogsfrogs>
 <CAJfpegtTdL5Sxjtm3cKu9ZuYwceCfa2bX15Q3Wr_GQ2JNb84EA@mail.gmail.com> <CAJnrk1bVfeHhdFC_8tpzffKGXtSeGN4GKEtV173D+AymT5uk=w@mail.gmail.com>
In-Reply-To: <CAJnrk1bVfeHhdFC_8tpzffKGXtSeGN4GKEtV173D+AymT5uk=w@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 4 Mar 2026 10:37:19 +0100
X-Gm-Features: AaiRm50I8As9aSPopp7G-dIycPmNhBKlCrjfrW4tRz4327h5H5iU4M50E3lBoNM
Message-ID: <CAJfpegtqF3om3zJA4Q7+01vcXgHFa00XyZsfrE=oiKxAv1SQCw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] fuse: add an implementation of open+getattr
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bschubert@ddn.com>, 
	Horst Birthelmer <horst@birthelmer.de>, Horst Birthelmer <horst@birthelmer.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E4F3B1FDB80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79332-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,szeredi.hu:dkim]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 at 00:13, Joanne Koong <joannelkoong@gmail.com> wrote:

> I think right now the only option is for the fuse server to just
> handle append semantics itself if it detects the O_APPEND flag in the
> write request and just ignore the kernel-provided offset (assuming the
> distributed backend synchronizes access amongst multiple clients).

Right.  It can also send a NOTIFY_INVAL_INODE in case it detects that
the offset was wrong.  This will fix the file size, but not the file
position.

fuse_write_out could be extended with a file offset, which would fix
both issues.

Thanks,
Miklos

