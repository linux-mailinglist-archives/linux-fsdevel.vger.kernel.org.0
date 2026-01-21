Return-Path: <linux-fsdevel+bounces-74841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMPBI8ezcGndZAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 12:08:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B7C55BA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 12:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB12F929960
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5974A45349C;
	Wed, 21 Jan 2026 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJeU3gVA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3F13A1A42
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768991726; cv=pass; b=inOn0du1lFEnfin0iVdNuIg09Jnv+7wPhPGUoSJNBfWe4YYP/8CwXl8fkw6k1dimutPDa+GOn9PM2MrLoD15mXVXvqZ6X9uWtyjbtMSdsgfhrtuqxSobHFtV3GX0jZK+nciCCDweMoqmfEC7X36ySTz0iYxYgl01vj8Or+4tfWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768991726; c=relaxed/simple;
	bh=HCVFPrVsh8yYQPNLkV9YSvR87FAoMumOEiYeXt5IvRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhTu0yRPh7PzRMdJT1Ss3fyZaVi31HZcGLuExXdFcgQe2b8Xo9lzSR9sL1j/aqpuzmHwjsrLYTvi9SwkzJ2yMMcmpoUqFdEPrmVSkULxh+fmCWbqrPoIGFOLFoKNNNeV9RpKB2DHED0y7FYI1NW5maPyx46BNbEOhlg+Dtyoh5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJeU3gVA; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64bea6c5819so10414925a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 02:35:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768991723; cv=none;
        d=google.com; s=arc-20240605;
        b=gXU52ePdOXWUaIrgNXFudlJEUWhxbhGLWerUlFQiuZ1h/EI6pshUKPHDXvsuCFfrYz
         r82sagaJTXqBbp/Q00ycwUX/dzz1Oo60R2+jNtfZUtohFDwuA3xgkiZRnuy6cTIR4zf6
         TYpwHgxnAJfuRiuKML68H4wOs7p/CG+w/5RbQQNBSmVAFEdHIKzILSYlE3Gh+b/ieyIJ
         Eynf29pigCXT+k+ugZhpfx2Yy3g7uPIwECJXYXNiEEN2cRNIXmLFh+VV3f/uuXyWqo83
         TxGb1w7jW+mYivMLZFrSoq27vJNWV9nsDHQl/fdfunMEpTbg6xShhO1CHSxTu6IH946q
         8+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UVlylO3YGYDqflXHt2qRDCA7u2RSaxauLDqmU1sFQMI=;
        fh=r2sPMGElqFcwrbsp6yV0+58hr3+MlazOWRuZyQpoZbE=;
        b=DSbu5FxCWVAaGpXNcgNL1qd0DaHwhgxiQH3wKIPl0sajTGXiDcOHgGoN4g5/kVVTcZ
         V+X6dbzm+2QL1jgZ4qR68D4llbeEZUjft64A9OYWDLKed8L+hOjhbxclzP8GKtCTg+Dc
         1SJ53nf7CCLzgTrcT3oCVJJx37QdgNpQbpAiIQAvT4b3IdowV4vaQ0Cc5cINyx4SUGi2
         gjgO6EaI3gKqyYgiWHLnT4nNDLQrrEXFl5Y9pG/24yImvFXaDjmW1Q9Ixe9vRKWsr22T
         qbKYhPif38dw38mu3haJJit/IBbTNTkpHj7cXZYCsU9yDsv7ED91Q6Owsced2MNs/Y+G
         Qrag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768991723; x=1769596523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVlylO3YGYDqflXHt2qRDCA7u2RSaxauLDqmU1sFQMI=;
        b=PJeU3gVAjiY911eHTuIYwyiB8wdaAOt0xaWo/ZN77okheuRQT2wcL2gH7y2YBIy6FI
         7DYt/7pCUNs0MrCXp54FKKZCAkuMKlUZdgu2zTzFLCSK4pPLyojw0MvkEciKlxyuo2Hn
         hcIJIlOx26HUzEQnZCj9UrIYG8xLEFtQPRupkoOY1ZGcAc0cL356Vrb0sBP0GQhmqdcd
         0FS4tzRIN/P2U9q7DAJc5akmnO687hqGxlcs6Q5k+O7f7UU1WyN1kfsgeUhmbG6hyWIl
         NtjzySWKpkfJarzyESngD4XYIfwy75pte9x9pyV2G0v7yTygO6VhzwhFnwiqI2q056JF
         QZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768991723; x=1769596523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UVlylO3YGYDqflXHt2qRDCA7u2RSaxauLDqmU1sFQMI=;
        b=rsOQnzTFm3K1iw8B0MtkuXcxrtX8WhNjAus1oDD2acIaUGEqYFIEalpxkyI59UXcJy
         VCaLe2hKwH2kDjSE8+c1y55GYt8XZXA5gUCv7WwLk2iF1Zl3rSkcZbNUES6kHp2nFF+f
         vSEW2emEa5Hp301c2hPAkLmxekMocUSqi3iqlV4szJoNo+UGR/sXOAdLrDSXDSIWlTjH
         SYh08FmubN4KhDut/Ety6j7noawdZDhdvVHPpl9T3XFQDBKbNX/cFS8+9i2IXs0Y88z+
         6Auvvis9+apXYx1G+dnLFa9XMcv02fm/Kx57T5HnZwP4zUjIpTgzp6tTbQ1c9K0O7+em
         0wWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR5zQ7Noz0OCs47hvWUE51PWuQXQmcb7B+xhjDedu+FpnngrIH7hZ7rsmVsTE8KyZLZbUtH7+iAMTLN9d9@vger.kernel.org
X-Gm-Message-State: AOJu0YxjWJUjyj0hF/fjo10bqxyInHyqnOte9rkdovJiCDqHH9VObUk4
	cSYn9bpx9cU9bZiqr8qVwHCvo525j0DTpmnfUADDFLCa65oymsXX1zs2c4SXm+QrWiOiGA1NAma
	YK03L/UmAE67AmQGgMbgl7+5tfpVUzC8=
X-Gm-Gg: AZuq6aLo6eL7MrnWOf4VOYMPDlZDqTDOQ8gJIDyls18rXwSpTiUpmdcv0+/+0mf+6Fx
	1BuSJOsDIqwUTHYXSA9x8MUadvVo2dFhyiHeHeCRKgrtMwDU6yuEYj2AV3FLWHHVkLIPCcXUNyB
	LZoQPTQcyRTM+9piWLcY2Cw3/hiatdZ2Q/De+PuW6LklChnFFpGbVpWKS7l4YWTYRUfE1Z8rvTg
	+miz84n5e9WGueWQ4RFRlhH84jJ/ec0Y4k+DRu8BJ5Dsh13UdcIK4y5u2B2UG7VzDrc0C87dWjw
	lu0qhl6yahr/DMWy+SWzi4xH/xkXuA==
X-Received: by 2002:a05:6402:40d4:b0:653:9849:df10 with SMTP id
 4fb4d7f45d1cf-65452bcc095mr13159728a12.26.1768991722841; Wed, 21 Jan 2026
 02:35:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121085028.558164-1-amir73il@gmail.com> <20260121101234.GA22918@lst.de>
In-Reply-To: <20260121101234.GA22918@lst.de>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 21 Jan 2026 11:35:11 +0100
X-Gm-Features: AZwV_Qhb1hDPnShB571U21dRAUavqxXadkzMZfF3dTUiJ4-e-KtsyK8ayJd39rY
Message-ID: <CAOQ4uxjRoK-tEEr+QsdSm-yce1+n2XZkkO-uFKrbhLXdyw4cgA@mail.gmail.com>
Subject: Re: [PATCH] nfsd: do not allow exporting of special kernel filesystems
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-74841-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: F0B7C55BA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 11:12=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Wed, Jan 21, 2026 at 09:50:27AM +0100, Amir Goldstein wrote:
> > pidfs and nsfs recently gained support for encode/decode of file handle=
s
> > via name_to_handle_at(2)/opan_by_handle_at(2).
> >
> > These special kernel filesystems have custom ->open() and ->permission(=
)
> > export methods, which nfsd does not respect and it was never meant to b=
e
> > used for exporting those filesystems by nfsd.
> >
> > Therefore, do not allow nfsd to export filesystems with custom ->open()
> > or ->permission() methods.
>
> Yeah, this was added in and not used in the existing export_ops users.
>

Not used in existing users (nfsd) on purpose to my understanding
That's the point of this patch - to fix this misunderstanding

> > +     /*
> > +      * The requirements for a filesystem to be exportable:
> > +      * 1. The filehandle must identify a filesystem by number
> > +      * 2. The filehandle must uniquely identify an inode
> > +      * 3. The filesystem must not have custom filehandle open/perm me=
thods
> > +      * 4. The requested file must not reside on an idmapped mount
> >        */
>
> Please spell out here why ->open and ->permission are not allowed.
> Listing what the code does is generally not that useful, while why
> it does that provides value.

This is what I had in the RFC patch:
/*
+ * Do not allow exporting to NFS filesystems with custom ->open() and
+ * ->permission() ops, which nfsd does not respect (e.g. pidfs, nsfs).
+ */

I took Chuck's suggestion to rewrite the requirements, but TBH,
I'd rather not touch the existing comment myself at all.
I prefer that Check and Jeff apply a separate patch to rewrite the
documentation if they feel that this is needed or to propose the
phrasing that they prefer.

>
> While looking this I have to say the API documentation for these
> methods in exportfs.h is unfortunately completely useless as well.
> It doesn't mention the limitation that it's only used by the
> non-exportfs code, and also doesn't mention why a file system
> would implement or have to implement them :(  The commit messages
> adding them are just as bad as well.

I will leave that to Christian for a followup patch or to suggest
the phrasing.

Thanks,
Amir.

