Return-Path: <linux-fsdevel+bounces-79208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIt5I/3NpmntWQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 13:03:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D601EEE97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 13:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFFE4304FBAE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE92A33C53A;
	Tue,  3 Mar 2026 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vYUwCl+3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE36431E852;
	Tue,  3 Mar 2026 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538629; cv=none; b=nfRlQw1WiNVaGCnkeWfjKLzG9bgTZas7sKJmkk41fANRjYG8DNgtBASMJchTtBOpEynuQ73Qs+Zon6oKv1MRZ/vdelQmu10nnYJW4G348X3zNX9ZILt0+n3eNVILoOIz3FfmU7EntcfKnrDAW6fY0nGcAnqTwenPuCQ8gBhdrMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538629; c=relaxed/simple;
	bh=rEnfXoK9PPeLhRGTx7/bqbqwciYbLBCA0DEw/rKp1oU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=HydQJkUoeR6OrIiMrps1xRBXVUKq/DWA1LXZNAp2cJaz8MIy2EmWdOp+wMdJQHu7kBvPciyd5TKztpW9+7RSbpUD7r0L3wZCvVAE72aytTQvd35wvKGYsVVOvEthPK/fz+0du9S57WLnU0KeoCuOpaMpg2mlzlnfFChv2XDmXow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vYUwCl+3; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1772538620; x=1773143420; i=markus.elfring@web.de;
	bh=ryf9jAZuujJ5wov4A6y9YG3AmyvtJMpMR3CViMzAwjA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vYUwCl+3os1Wwf6wnZgVM1iTJCL2ds7z4d9PveDXAWMR75Qz0YLusUFc2UtqS4ms
	 za1XHuo0RnTo4MzeyD+asV28ic1z+l4fa7wqllXpIBgZ2zip4SuXU8eydGZ6kn8zT
	 SZIp95eMKM1tTCUnv2jm6HbWwEaM0YX/Xw9W/bAqTzH/8RmO9eafl1RNtWTmtwB6r
	 kY5CBAlEcx6mn9u9mu8sfTWKjB0ToghHElxG0fTRM/pg1XQ/kFrReM2DkP6Nv6ala
	 k5N0Hv/YfmAIshcVgnkhh4uigc5/5VceTExOQLQ0Zop4g7uTXXSyo9VEfqcXLNEKT
	 iCppbJCQYHMeP6XcPA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRF3W-1wIF20155I-00JCLb; Tue, 03
 Mar 2026 12:50:20 +0100
Message-ID: <a53ff72a-6464-438c-8210-01834dc27512@web.de>
Date: Tue, 3 Mar 2026 12:50:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Philipp Hahn <phahn-oss@avm.de>, linux-fsdevel@vger.kernel.org,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <36b3573bb3e4277ad448852479f2cfea7a8ba902.1772534707.git.p.hahn@avm.de>
Subject: Re: [PATCH] exfat: Drop dead assignment of num_clusters
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <36b3573bb3e4277ad448852479f2cfea7a8ba902.1772534707.git.p.hahn@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KUp/H0no3P4bexvbAKJNM8AmYkdZf04GQcygzCspu8tonHyBNwM
 GjTKn2Hhy9r/CQWKPoiTZjrWKJYQQXBHdKg0wSftoPMwIgyZqc3GnqujuBEEYRiE2PAhGxK
 1yUWA92AEhYAgKssQgOgJOr1C6kpfGM1QHVDKx1czKCjm/vx8CMSltic/7DJ5vKtuaEANE0
 LLf6JX2r84f1zLwmkWbSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qLm9o7vcQ6c=;YNbXwSJmO8HYC9RJMXipM4BScnV
 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
 oZcBVvgD39bW/oAxk=
X-Rspamd-Queue-Id: 90D601EEE97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79208-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[web.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

> num_clusters is not used naywhere afterwards. =E2=80=A6

                           anywhere?

Regards,
Markus

