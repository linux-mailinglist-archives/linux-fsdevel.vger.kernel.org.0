Return-Path: <linux-fsdevel+bounces-75614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIzULArSeGmNtQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:56:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7A19619A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 084FC30247FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4998335CBA6;
	Tue, 27 Jan 2026 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfDWTu68"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7335B65C
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525755; cv=pass; b=r0pKAHfB7QRhkyTlqThNmZQN5/stwC30Qu6LZq/Ua/MsorFzZu+bxP4+6RQal0MQkDXG4mjqTzdKwkAr2HHSACO4V8PMmUDw7TMQtmAGDPxGSepnFdyguIEN4p5T8j2dg0uDCPOubfPkdbTEDjHqlvFlqrw7nWbQVU/sgUB7WNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525755; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+ls7vhodPcKg+4REm1CwrTxISAo2UCsWyM5Ab28nwKzKGOSKau/Ie5IWeS6bZKdHWTAzIbGZX9gQ4CjeBNYfc/iPoeTtb4qxbD4YeFyrKfJF/rD0uhiffprGrZJB6iE81aGIPPx0+cH7V0ydPwK/5bBDd00M1nROFPlwmmjiA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfDWTu68; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso11584331a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 06:55:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769525753; cv=none;
        d=google.com; s=arc-20240605;
        b=QUIm1HvM++AbMLDRBBKl+MU59mx45x4FJsAkZ8Oayjsa7XugKIt+ZsHL/pqKUfQcqz
         Jegcpg+ofJ7JaRYjZDEHm9+Sn5Hpr7u5IQuXluR7nShRYmRh3yQlGhsRoMmIY4zPwHoi
         Lqm0zhL/mUoSnqnt0SsxE+d6Xs2LOdfcPa1PScwPhAaj1r8H1ah1HTX4Hr4XDO5dWSdo
         62lu4xYkioGM01/i0V2KR9wYBLEzyHXac7Mf85F1BIOKNdpCYJ5PYvffute11jCmBXxc
         4ylCoT3UezHb2UFiWsL3bed4E3t5UwmyTZcoKXgX9j22zYPzgnsbe21hd1RfSXhXH3rm
         +3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=T7L4nqjD8DJHPMZCNHUI00zdf3EKUEM0zBSPhslaU/c=;
        b=PO446vqvH82jnG7OHvad5WA3PrVEsu3vEbfORoh6PLiqotOpPk6u6mvcoa81lin3Me
         pbEvnGJM6/MLO45wq3aYnnpSDAEOjOWpXd/RD6JneLaELfv7QVUB68ikn42kJOyCMoZj
         /HQUl9RaxjTguijhZtyjXdH7EQTjlBcqvF+G8pqneP8O2EqoAHRMi+LDaTE7a1L6Byzx
         gBog/dXgz+jJB4ZEUv4OCrVrpppAgyfEeqxwBwn6J8Ip1K6tNZf1E22Ijgj+pMh1GZ/4
         IPj0D5UJPVkMikC62R51tcMuDVzXd2jQlw1BhK74YTh08fSrMSXiy0FijyBMHfwfgxn6
         4C8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769525753; x=1770130553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=YfDWTu68rfjJPyRNgFqZvPZYxub+lCjaRdoiP3hCroWvGiqPsSxOw64HsiYAuiz6m1
         Z2EWpIzmQbewlKMvPMz7HCYu1Hmc8UKsWZeJKv096tQTfIw/qRA9FbRk3guXC24sTWL1
         UF84T6rTf3PxYMgUZ4L5GpOsyTs2qqmlbB9Z0pNPyHm088T+oWw7N9PHVUqMKVwCTCJu
         FUvWofElWIR1YWK+VU3MCP+YBPIcEuEaK2OBaRq8D2bqgefWkkKz1xnYfJf9t2nxoeUK
         BrvU5k83P+iePMimd9bAflS7rh9K1neP4UfWe1z6fZVq98pYdPl6mJW1PHdfN4jsxGIf
         OVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525753; x=1770130553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=H0EseJ5BjyQZZIfxjfxsfTnIGgKfJya8GyCtZf9f739BDZL4ml3h7J13FlMFzLsCXG
         jBTjXCXWOgCfBEsr4UrHX92i1NvXF+gNaqIQhfFQZZK64bsEkNrGBWzLvgXYroIZyRBE
         M75XHy4CAvfDo+PU+YGzo/dFSMyJhAVodOgdM/YboU70ZGrLDPigJJuyfcrheE54I8rR
         ZFR6Vm6Y8iwisLxQaKPO5cbr+j9LlpWyaN5TuonyBno9TjPc1EM8itU63WSb7vLj2ll/
         NlWelbY66rnQsEQdAFQDj+nA9R02cleckWL29vCadbiFqIlW4UxTWPqv29rIccTJ9o8m
         MVpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOjrINrpK9fvuZzAEmhXohPSgJSfHOIWWzzXfG9DEVEMb0WYlhBt5q1s50OLR68En4ztnyM6WjLLvijpaK@vger.kernel.org
X-Gm-Message-State: AOJu0YzGZ96aF4xmFpg2POhdGhHIJ7NNRogzRBEAyOqVbccf2jCDYNFx
	LXU7wRNlpN2tFPZRtFI0K3GUzCNYWu/eoonpAJ1zWuT/KCsGhPEuUXXLbupK2Qo0bNJMOkBL6kJ
	TFrARxFd+DiPt5xM6Tezr2C2yLrTD3A==
X-Gm-Gg: AZuq6aL7HWjd7YrfD/DTnxu4yk8l1fHTscOUJ/xOrF/f1svof8wdiErMTl4ELOp2JmD
	xzmNtTxco8jsIbpxRY5Wl5aLVok0EJif5q7mBnMQv3V5eHkCvhVywwaEaPSdvysLm2pq1fWAj0c
	92mpyLCHBwUV4Eu3uh7eGx+RegMK5SkEDRZSGdyhurGa7/ihJPi5FUCOSh1z/+UDFX4NNaYbPhz
	qw+41HVMcPrp6459se2P4/0TET5mtWafu8YH7FxMlrVqPvdDaSp0wMMXwnl+5xmNVW673Y89Zig
	jJpPFDNH3vDfpcdzcueBseBsoliVIrPKavTmQ+14iaoXvYbDUYEBy1DY+Q==
X-Received: by 2002:a17:906:fe07:b0:b88:4b1f:5b1f with SMTP id
 a640c23a62f3a-b8dab423cfamr153134566b.38.1769525752488; Tue, 27 Jan 2026
 06:55:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-2-hch@lst.de>
In-Reply-To: <20260121064339.206019-2-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 27 Jan 2026 20:25:14 +0530
X-Gm-Features: AZwV_Qh0N_xMlo-Jek-4Bqvm2KfCqCHKR16PVHuC2EtfsXWdRHcPY9i5RteQhPQ
Message-ID: <CACzX3Av31ZUXb9mVGkEm1=+gbH8SFeCd_k7hG6MD5MHosWKBHA@mail.gmail.com>
Subject: Re: [PATCH 01/15] block: factor out a bio_integrity_action helper
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75614-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C7A19619A
X-Rspamd-Action: no action

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

