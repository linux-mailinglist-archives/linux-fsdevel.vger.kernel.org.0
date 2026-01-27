Return-Path: <linux-fsdevel+bounces-75615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJDiJVTWeGmOtgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 16:14:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E12C96732
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 16:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95C283105471
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE70F35CBB4;
	Tue, 27 Jan 2026 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJyRaMh2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13082320A37
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525782; cv=pass; b=M0bPrNQpBEzFz7HvMkr008pVjeFTjE88tdQeQ3Xqf6ROquB6M5Jmj2CvzF7e8u/b/ElgqzSak3LsYfzuqo/+PDSmIO3XcrsUdAbuo8ArzrH6RCm3n/RWIgQSFXBPn87bzii/MyQ6ZSppTQl3OyMyMHVFVpztbZFQ5d/78TrF78U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525782; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4Oc7DJnre30EreG7odyGVqx85wwBopUqhF+13OQzc5w6bqDszba53NW+Ey0z92Iv15q4QUQ42D7b0hM+5iKfEhVOgylvSusxGLCZKOssQQN6G7Sm7m9aIJH9gCVo3cbBkCZ+v26hUxSx+FfnT5rcrQSXd5U5bJSS7G0jJsROGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJyRaMh2; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b885e8c6727so820362566b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 06:56:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769525779; cv=none;
        d=google.com; s=arc-20240605;
        b=Aky2c5bYsaIoIJrvSFquYucUZ2qT5RheYN5BnculCLazkXT8MuRcsbA/xvc8WwLkwM
         dFlvVOcTkOayTCkI1LnyzbRoTK6vD5Cimwd0j0tIQHus3uF4vDt+Qk9vLZ+U2UZ4YU8g
         v6NSo7LKHauXY4lOqYrnAfDC2EAuIcc/0Y0DfrPvXJEkilCuCClg7akGgrhK1i9AIUjn
         EI20hThx3/bRPGZQXE1sH3ByacOEdFPq6GIJuZam8Lw4u5YfJYc2+fLiQlGzIyX+jT8m
         vUDHezyXy2dvaRyol6/eWIfD5druiZVIWxz3fdoqWMzYfj4aLiF6w94qEDz37BFqzpDm
         ggCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=Yoftkxa+ReggqlT1C4xCuv4hFjRJS7YSkqvH8tKxbLw=;
        b=ZyHxRzlaTVO2inQJxAvmOZ62KQjLhWP933GLjHM7wR3thDVenQJyMuOjW3zj2YLPRR
         efkrUQuOZLXqzSygo/3XqJ9mpT3EcmRs+oyEB16Ye0G/Py/mnJeUuTbJ60aQf1OMuiRg
         zOMucz0Q9rSoHzJR5+ZzhyUm3lGqoG6ryJX4GzxMPuoVO3CJqukDni2z6NHJu9FnDt4o
         Q/IrmwTUjKPRc+bzpKhQdF/kj5WM+J8sEtI6H1J+sl1KESM4QXj5C035i5EL0pFGMlEV
         I4uWiS5lDkowbAml3WSx7C7veAsIx18GLaI2QUUDdw6FnJJHjHHG0T0tymHDLVRvBoZK
         4iDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769525779; x=1770130579; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=GJyRaMh2hh7lb0M6VyaLLCzza/TMpZb1J86mIXRz6Yo20W+MPiXlQXGJyYHnUXVkp2
         4zkzhhX11FCyyF9Abwz+RCL5VQG+LmQWGIn6OIyV+pBxqlVaREMv/fwfgyPXNUKlvUGn
         VhTG189FB0jZ/deo4BlehOKXXAPjW4NL+qpTQtbQNcqL0smfb6UV6XgOmFRQtphMx2kF
         hQaoFjkg7D4x61jWPPSyRXvnksvG8Dc8WF9cxHB+kIDz0GL8eETd6FS25ZiMGuG7ImFA
         3GxrYvGl2AlZHWlkCxtysaxXYit0C9fPSMKsRQINM2hdqHHRN/ige7H/a32G907gH39Y
         MoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525779; x=1770130579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=oJjsniFDHjvEoo2ELL2NUJdAs+B/QCEHaH91hH3yD1UKQ1+Vg/dPM992KpKyatrIuK
         Xq89tVJDixNhQJjLY1GCMxF1aDmmdhXi7RXMjvrRjBY6kJ+Zf9KvnIiAyE7YO2t0pqpM
         YnzWl/iw9Ac8oE+eMB8ugLe/QfuSWVkj8953i2t0P8kCASw0cVVfqP5hlBoFK3Tn+JIk
         RxaBMGJZhdGSpVe725uvhm1WH9/D4RVJav5ksw0121QSmuhzUrTAdxbUqDYr1raxyjDn
         BGxPdn2WNfrGmYLS3Y5g7oQL7UL2QnmW600NmfSI6bdEXUiYuEMeJTh48aB4wN014e/+
         ZZ7g==
X-Forwarded-Encrypted: i=1; AJvYcCU0TE0vf2Yu+m754DMZIMneeBMwaNLT9S1/3MikBysajYGp4c7yVFpYg8si/pUCfl1+bJFpuu67LDqQ64A1@vger.kernel.org
X-Gm-Message-State: AOJu0YxynED0I5Tcsn+Gqt6Aio0DbovIlcND4sfoEhdHmuiRu/ETmwrc
	6tq2Eu+eFb91VcT+HvpZDzoLUM02C/GWurkh/RJ8gg1Z3R8l8DKTJjhE+3KfDCUJUquXULQs2Iv
	hBii/lafDq2ujjB49ylBZ8grWaWHaEA==
X-Gm-Gg: AZuq6aIpAfClkvz6nPtRe/umJqSEqKT3mak3WF/3+50y8QDuqMA1raXZHar1WjV4Bwp
	ydrSqJj7Q2N7tmNx5rKAe5o9T2nIwRtgeudU5IMUch/shnP7BMjD69iPiznYXkt9qt1D7kbgktT
	WRchVfKk5+K9Z6YpWWf9KMMm70TtCgfbpXk3FB5lhx4DnPrLPzLWrvW+m5ye5SCAwAIzXx88bO3
	VJs75VQTuxhDeIRMSmrPAUdaU5nkexiUZuuEhJBSTzCqAAtWmFmr8yDCV4URq4qVECgMeuoJn9Y
	K9LkW2yVD5OSUwkVvupJhhCEvYDSJY6Z/o2zZ5ly5bGEoEXo2Pfge5bojNXHA6qCP8Ki
X-Received: by 2002:a17:907:2d08:b0:b76:d8cc:dfd9 with SMTP id
 a640c23a62f3a-b8daca2128fmr161899866b.18.1769525779240; Tue, 27 Jan 2026
 06:56:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-3-hch@lst.de>
In-Reply-To: <20260121064339.206019-3-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 27 Jan 2026 20:25:39 +0530
X-Gm-Features: AZwV_QiAoKA4QtWy_y0NR6iP_vvxOusoftdbzNUmcHtGTAMptU2eKdF9ySt53aI
Message-ID: <CACzX3AtY6PBV58jXS=jwD-o6Dd=m_3HkB=jRp-3Xt4Ab_U+RSw@mail.gmail.com>
Subject: Re: [PATCH 02/15] block: factor out a bio_integrity_setup_default helper
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75615-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anuj1072538@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,samsung.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E12C96732
X-Rspamd-Action: no action

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

