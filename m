Return-Path: <linux-fsdevel+bounces-79325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCbsEfXwp2mWlwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 09:44:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B82381FCCCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 09:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 021BA30F1EAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 08:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E2639182D;
	Wed,  4 Mar 2026 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HEI+ScVO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E5B35B646;
	Wed,  4 Mar 2026 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613660; cv=none; b=L5+w76Ya6+1/JO2yAu1l17JUdcQDpUTYlGoBQhCgcC457JJbOypkxc6TrhcVdlp5E8dttAyH7/PpToY7uDJKwb2tHMb6FsdxN6YbYh+vWkPcfZnlnWuEPZvqkitLB1XgTM9wRvdgli5jPi6KwmDzy37Atu6ZNI97tLUVHNQAmWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613660; c=relaxed/simple;
	bh=mBdgEn/G1Y9jeWkB+kcGaBtFwETWmjylcM8TA7Ayb1w=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=sgOuhGo16L1fgbpjf6YDbQXhoVsNj8GOp3N0blbudMYyiNeUMmNoH0kfTXZVpad1kde8dKy1eNCOivMEtklb2jcHsiB2N3lTeufJErX9K8BcqhbfqlM7SjiwX+X3yjHa1zbQYztiLnzyajsiAPn99oBIbaMdzTR2UajXWW1OoZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HEI+ScVO; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1772613650; x=1773218450; i=markus.elfring@web.de;
	bh=mBdgEn/G1Y9jeWkB+kcGaBtFwETWmjylcM8TA7Ayb1w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HEI+ScVO9WyisB2BEohcXZIgBN6WC3iTZWRvQkNTzKphrTWbdeAtcNNW4h47ltvQ
	 togvZ1wFINZKHhbvCMW8ZpD4J9CQhdmvpReY0WbeDVGA73dPEcsZWmJsSZeffBaW0
	 e3qTiO3EG0Xu5Ljrg9S0vAvxFQY8QaJ2HKKV8nNj9MOvR47Vj2PPi8SS2G5F3g+iy
	 dQChU0isyddcK7UkYD/fwBOexgXWxQagJM1pcvCzHhiL/Ee09PVHF126HjgTVvFKs
	 HC7+wgv8ly6ozFHHYhcHNUEYiluuBGmNmrL2H6ADUjzbx7OAP/jvadnqR1WpGcMNg
	 B7yDzDScWg48ocwTsA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Xnl-1vWFHd2D35-014eER; Wed, 04
 Mar 2026 09:40:50 +0100
Message-ID: <10c20860-e879-4679-b9fb-e65c301a0b24@web.de>
Date: Wed, 4 Mar 2026 09:40:37 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Philipp Hahn <phahn-oss@avm.de>, linux-fsdevel@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>
References: <cover.1772534707.git.p.hahn@avm.de>
Subject: Re: exfat: Fix 2 issues found by static code analysis
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cover.1772534707.git.p.hahn@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9CFyrLTV0r0XEOEG8UOG9ztNq+PGvNFwO2ph5/HoK5wbNZFR+iF
 WCoTbtpO02kPw6oVDwwD5YrjiKSyy6G3igR7yNXDr1ziO3P4+3Jik2wxSldp5mKhzSJZc5H
 2FTMVwT1KdloKysqCUukeDffypn/eeS1XAfwXdJO0EvPQc2QmDySwUJs0T2Kzfjb4Iirf20
 gWmAapIpepn8fp4kH53PQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uSOZmD3vzXo=;4XNx4XhtY2TTgqa/9+qGoEDGz70
 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
 zLbp1svTWYQoL7gaw7OzFb6e4HHJl
X-Rspamd-Queue-Id: B82381FCCCD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79325-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

By the way:
It can be helpful to number prefixes according to message subjects in patch series.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.0-rc2#n711


> I'm going through our list of issues found by static code analysis using Klocwork.

Does this tool point any more implementation details out for further development considerations
(with other software components)?

Regards,
Markus

