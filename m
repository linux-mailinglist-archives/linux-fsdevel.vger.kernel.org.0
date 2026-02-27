Return-Path: <linux-fsdevel+bounces-78743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J5KKNe8oWmswAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:48:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0001BA3EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 378C53134C33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BE543E4AF;
	Fri, 27 Feb 2026 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="SwJZcnmO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7D043DA4E
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206907; cv=pass; b=jj6/eB2Xgpwc9mAUowWUtmBAcb+gMsAsEv5IgizhdHMTjECyQmh133sZd3+etnAcP57tlsDbTFpWGqVooyfnuXq/rXMtvcnQDhvT1vgNLd2zsuvi7AsIdfkSskjWAfuBOXkwFDWVWSrSOoliAEg/WDsGWiP/LYt++aUGkxGLzQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206907; c=relaxed/simple;
	bh=PHt4NiLzR7dgV3oqH9i3dVECclObgWcZBOq4W3yTzMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uP0ExaR7aCIQ+f698Rjn28mm2KKeNyDJpmeEyRLgWEfk/xMprjolKu81olyZ5FH7wjWdDkgFvEtf96G1Tde+3oBXPbHAt2kWEcBeTiDaME/IHaUtVpnjiwZbuLPlVFF+M7YpTchBWTULYt9nvJyQyQxbKd0cAKKHclH3Wu7hQ04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=SwJZcnmO; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50698970941so25706481cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 07:41:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772206902; cv=none;
        d=google.com; s=arc-20240605;
        b=j733vvYmdBU63ZCWm4IsVpnCBd+s320S774K1/WB5EW1j9v2oG8MZWYDPL2WJezK0v
         UJDqSi8PlD8LHfjUGdETJy/Btl/xVBDBauUsIdtUTPmPmYCnbI4CDvpwv1mu3L2jIKM3
         3s+pQ0rbkSqHvWQ9icSDuwGoSuiYyyXomenYM2ubTkpPXIHfSEafAoEdrvhj+A3F8TPS
         psKc06bsj6Zbx1quqxsxbvZO3hDXTeoRpBC8LMLykgjBK20kwp5oTnkzMsvStDevlyY9
         2HWARN59AvCdpDsBpqv30WMUJCi9qgoilt8NZH1aVEk+EeJH9w2BNpGwjvg7yyfXF2Iu
         NYog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XIL3GEy4W9JLXepAvHr6QNdM6M8cHoFdNaJMYaWbS34=;
        fh=7um94BVIsLQWq3CJ67dLePcAnV3nYRFiHTwygLnydls=;
        b=BQ8+a7KhwNgxPvRoak9J01O3CKIGMb3Pb5h5406OYTBcAszlGMyDMFmn3193Uzsj11
         T1EDVTC1kZJTXswMxjbN4U4valjJLoRzVqq0gJQOA2HKH5GWUn2OMJnhM8BHWP7HEftQ
         2pkd0AcPGnYpFmesZhqI7+ZHSp9rfl8pMZEwWkMukNVI4w5ZVKyLcChDl2twGa+gXo7y
         yx/LZO75GVpiBWTBY2e4/T6DtHhsoP7abOKWJNWDqPYTYIahxbckaXgss92PjSVc7Eew
         Q5MR0Qp+rnmoGT3dB8tLHM2ydlZj3jy0EoVWnXESfUO/kKLAuL3k8J6tK1Dh1/5XnU6G
         v73w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772206902; x=1772811702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XIL3GEy4W9JLXepAvHr6QNdM6M8cHoFdNaJMYaWbS34=;
        b=SwJZcnmOu6wh08M1Xcwya3uBHCM+t9rhGHWTsxCK3/arfcjGnFcvWufZoCzc8iDBGa
         2ycIoM637qeb+3OBObipt8+MvyjAlnSMJRK2jNRE6Fn9th/6/WBRnizbs9ujCSoZIwBk
         LNpLFKPjo/ntrTUZtRjmAFxzV76xLdjfVgNtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772206902; x=1772811702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIL3GEy4W9JLXepAvHr6QNdM6M8cHoFdNaJMYaWbS34=;
        b=SeaszgIkvMQ/5uHReYkbkFpqZ0aw2ZnmNDum9PZuYem0SOF0KZBtbwaP5YbFiuGclO
         Kt3UcW0JcPmXz1dmvYN8UIaxsowqb98oTHnQ8h3NoHowTj7xK6WpOl3s3ZBlQ31GwpJD
         dsbI6k0ActkogDT6468reGuF1zGIYJu/AjKJt2fp4cRegkNzlFNlDR7eE4WD/xiN/31J
         jit/oQF0ohDKJYftlf0SzujbqA9ZymZ/XhCLywbQZkk5w9LCIbbwiZCCkHNRtA+Avx6l
         bkLiKC2yPcwuTZVBahTb4lEUZywq8EYUVfIFsE2/5s+bJUk91qb07u+S0ecfEAWCZTi6
         cQnA==
X-Forwarded-Encrypted: i=1; AJvYcCU0qHLBueYNF2H1eJzGGxTW2e5bx6HKV8ngJ0/NK5Fgwd8YBhZoMnzmjr+ekYR19CvxSD6EFN9GvhKewdsU@vger.kernel.org
X-Gm-Message-State: AOJu0YzBQXnp9mAdhWfahGL/h+LKIk1bkyyCP3o8L+H3azdzjlWbv86r
	zJA4iDtO3ZnqEAblN1CgwMI9lvjv72lISFfC8pJEb1SeQtJ/Oqm5uukPr6L7jMolzKQ/Rn6Gyxc
	Bw8jZBcEjcnnGwWk8kaFcEmNxmv3qIQxn3JiKtPPb3WTIbwMavfhF
X-Gm-Gg: ATEYQzyG3+on2Z9OgcrwrzVZt3KgbL+x0jB9LjxYz9rdi3Kt+A5iWbgVDlsgBsJLJaM
	x06ii6PaRZlQ5Q2RlEBCtRp/nOjpDalsKW6TmjiAH6b6SBB/LKnMLWf9jJiXuhb64TSh3TdRI1L
	ub3XakD1zg4DfBYd/+Iukt6iA7lQH45scYd7yUEearYMr1h8+QpP5WdxUenm3kAvlqtAJ0a654t
	q7DeohyyDnucLxZ/HgXd0Dx6NPSLzOqBITeG807TyMWl1/x1OH2ouDLQ+/9oqlHk1KzcTmRxxxT
	XmLvHw==
X-Received: by 2002:a05:622a:3c7:b0:4ee:56c0:712f with SMTP id
 d75a77b69052e-507528fbdc3mr40426491cf.76.1772206902556; Fri, 27 Feb 2026
 07:41:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225112439.27276-1-luis@igalia.com> <20260225112439.27276-4-luis@igalia.com>
In-Reply-To: <20260225112439.27276-4-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 27 Feb 2026 16:41:31 +0100
X-Gm-Features: AaiRm53v_gaQtg1rspbTONuu-Nf29AaoczBKJCkTetHtBXTDw2umJbJdIYPlpYg
Message-ID: <CAJfpegtCNoNn-Ro04QO+k25_25v0_AyR=Po7hpnz1r4o=2Lnjg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/8] fuse: store index of the variable length argument
To: Luis Henriques <luis@igalia.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, 
	Bernd Schubert <bernd@bsbernd.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matt Harvey <mharvey@jumptrading.com>, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78743-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ddn.com,bsbernd.com,kernel.org,vger.kernel.org,jumptrading.com,igalia.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,igalia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,szeredi.hu:dkim]
X-Rspamd-Queue-Id: 1B0001BA3EF
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 at 12:25, Luis Henriques <luis@igalia.com> wrote:
>
> Operations that have a variable length argument assume that it will always
> be the last argument on the list.  This patch allows this assumption to be
> removed by keeping track of the index of variable length argument.

Example please.

Thanks,
Miklos

