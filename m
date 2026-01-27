Return-Path: <linux-fsdevel+bounces-75616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCtrFVvUeGmNtQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 16:06:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA216964C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 16:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE7C930CE074
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5B335C188;
	Tue, 27 Jan 2026 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6bBcinw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5B835CB76
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525799; cv=pass; b=jYJdJLsQsqD870VhSCTTX8BaauUHhZ3c22DWvnsuJWayv4kv19Od2nkvbjQp0HDFzI0IdoYYo1EftQjj5mD5IlgT1IWL/fBQ/VQwSSO1iydjeggqAXmRl/iXHQxdI6s8JrV3Bn6Wvwvy/olyVGi30XsCePvG4DClK+eW9OSI08U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525799; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcfOaOhn2qYSbJZxZzIt4kaf7Ys2zV1ZovPPYGFbeD8ybu42W0c+3pSoGkvDd36tEZlmdus1egvXL3Dlhr6/1pVBNlOk64kGAmwVQDGhfWcqN8iahd1x/65IV45w6/qloiA4YH3QI/OPyvbiyHyWNmJhSH/AMcpRQlgKPvadcq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6bBcinw; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6581af9c94aso10923451a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 06:56:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769525796; cv=none;
        d=google.com; s=arc-20240605;
        b=OBu5/XST/ENKhGvR1sFTnI3/w5F27AoaQ5eJy2EofropAy26g4fuerQJUaHmay1B+K
         Ff+uMvBmrkevZdDZbPJesKDd2/rShSa+ZiGBxF3SNW6f3A7bXI4PTemwETOVmtr4koKC
         D5igSbWa5ZBWkX0izhvxycy368Rr/4ieYZyk05abM51hO2Y9nBAI1qAohPVwQc41Ruaa
         +rA8wu7VowsvmkofiQ2EtGcPw72DB/p6RFVrk809+qYIu+EQo0GflvvePV/aETUnFcWK
         4e9lfCcFqZri0irLRhfvKRbbKWVTV+O0ocxGvW14Nqx4aQhjaHJX4xjqj6YkZMVlu+SO
         Ij/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=cKWUvbIBl8VQc6ENp2WMQGAQ+nXHjqqm+/HC2XORrAg=;
        b=RByCo/KnizSjuvE24E8SdNXLwmR0KITyvX4qz21Csdh83eEQoR0u5jKxQlrY2nM0zq
         OBZjY0n5vHiW2ir1XN9yqsot8lGuQ3NqxQ7E23xwpyi52JWJ6RUByyb+7jv80Te6yUYc
         KpihTHiOAH9oFgbvfS66vKVJYTqvTxjewdd0VSktGRZsaiNUszhZCzxPsPaQRU88WxL3
         XVT3sbw/hZt+f0XnEa3lYMi0FEUwl7XWR+SKwYNzV8LyBafA+IzzbhKUqJdseqLrDEmt
         t51mFJW0X+0JeUOqjrft3D3z+E7UnNso0BCLByQnhXJWCqnCm3ZohxRrojgrpQEIehIb
         eVfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769525796; x=1770130596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=D6bBcinwm0RIvdV6DoySuwScrLT2pRNjw/p8hTZY/XYRWCnIyhhgION4m2aHtOl4YD
         4fck5g7uO1UyVoYR3WOTP82KvNN2GO9B+1FijMglTVx6gVCOXX1zoHPnNMwZY4BLmGIj
         95xc51jH7r1vukxG3p07DTF9Hw3ziAUY7AV+7RwXMm7skCHlh3Sn/f8qjf865jaok4VB
         +dt5k9wpaF7Vqjo7Ool6yRfGKh94sFCIr9ZostDjpsOffEvA4+NCB+fu1DAebuDuR0Wg
         Ej/i9a827rfdU90sILJ9TVrM6LdrlaWoA7D5zB1Ayp2n74aoREgAxS0MXfd8+cdI39Qd
         r1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525796; x=1770130596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=o+sFlB3SmSwqXKm6Y5FYoMQvOdAGQ+NAwWuYoIZ8EYO7+xDpND2MUpQMOzgGixQa/c
         pMHy+8fWFXTVwHW2cWlD6Sx01uu5oQ0WuOOJSeJG3m1mMOdQkzRc69pbGmJmfpjPohRc
         h6cc6hbMJQr4/GSm7XT2AEZkeg+IM6amfxJqaHzjHy41P375EUebkBv8jdo1/b9nkKAj
         vWC7oxb3/80drVllqirPDKsaZWymgos9ghf+dUknp0b/94cU0/Z5EZN9LXXfOhR/b0QN
         oDdXSRpKx/4QqTDRvn9w8d2BtGTYKceFOHfQCLmNLYcuoKoTGkSOWNOsJ847ZjZ1OHxh
         KpXA==
X-Forwarded-Encrypted: i=1; AJvYcCVsDY3RDvFCjX17XxnuiQE0jOk/3Bet+5pe7qaDxaq6CStLPSSeCCcAvvjthMo+qnzwZZmEU3QSzAvFpts9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9vS3m5vFZFvoLm2VKMBlXvECC/njBdni7ibybczm4P2TFGvFo
	a3Mn/l0f1ueOCTPxiryYROMYcdaFZPBWZKDPmB2hI8cNENDazO1KNDg90ARZprpS6mxm6vueQoO
	mpKLgI7Fj5HAoRkPVZluM/XYdIrjYDA==
X-Gm-Gg: AZuq6aJ8QNRjAob1jGgEn6czhqMKVgO51+nyBzY0otig4iPk1hwL3oyoK2tN4sOlpZA
	gKe6FKzMjLBeO9qrmu8VwnnI+nsnlwbO3Kr4OUfY45blkgen7LY4UjW/nygpUUbMcNqVXUpKk/q
	YoOt+ZZIYkOA2YcreVamAbaY4Pb//AOQMjDoKGW1V6q/oj82VYc9Dsq/79l9ClRk4gVPkdIoxSb
	BV3uaIcyAzwCJdBFUYIVE/V1FXS/jK4qfDD2cyjZdMc7HBD23ZgGbxK5xYHlkyOysoO+CLgCICV
	ytOWRHaQWkV/FoC/t+zmqR8L+ITigXvXxDq3HgA0UOfZgt3VfJbHDzmonw==
X-Received: by 2002:a05:6402:358e:b0:64c:e9b6:14d8 with SMTP id
 4fb4d7f45d1cf-658a6086b03mr1532367a12.16.1769525796336; Tue, 27 Jan 2026
 06:56:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-4-hch@lst.de>
In-Reply-To: <20260121064339.206019-4-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 27 Jan 2026 20:25:59 +0530
X-Gm-Features: AZwV_QjH1kmIMaQrUVHIXGBlrGO-v9DSB6aQQaOIY-kGTdF4jliUvC8MjPPK3J8
Message-ID: <CACzX3AtYb5d8iySouG5Dn81vtuwwGtQzqZdWCm-d8ZUCLq-6Cw@mail.gmail.com>
Subject: Re: [PATCH 03/15] block: add a bdev_has_integrity_csum helper
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75616-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,samsung.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA216964C0
X-Rspamd-Action: no action

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

