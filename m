Return-Path: <linux-fsdevel+bounces-78456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKZrFzUUoGlAfgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:36:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C040D1A388B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71B5E3141875
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 09:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED623A0E94;
	Thu, 26 Feb 2026 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig9S7SfN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262F2F12A1
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098139; cv=none; b=XivdQeEh4LUMzVtmGeV5R8shI+Tk2DzDOzyNrKTKs34DwJZ4ZhVrgf5hjPCdQf4aeJKCkcygT/aWAeEooizUrlHJ28eelsIlgvbB1sAqNmQGEsNAZI9r/tN3gd+aJlCI3I7k9YLFnr0aXJ2KNcZiqtTgvSpsxHy7XXOgpC3dJ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098139; c=relaxed/simple;
	bh=DvmNYGhyGPcviKkSp+bVGHg6C3uepRL92yrgil5pNGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srtEOz+HQB9I+vpDXprIiqzqrUw5YbSdGLM4S89kiO81NvvolWSm9j+svQNbKbIgBYranjthy3acXEBw7f8S3Oa0SwluSYU1K3pTZNuMJzSF0HAJmmyxLLIYUrCTDep/zEWPMG9GkWtZvnYpqvpkDep6Jn2Rf2z4/MziQxOQ0Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig9S7SfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A18C19424
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772098139;
	bh=DvmNYGhyGPcviKkSp+bVGHg6C3uepRL92yrgil5pNGI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ig9S7SfNYfXbJx5tavyDBcb4TFLfNY05ShX2sZbKbCa5Y6+NiS94U5Ilj8nDthDww
	 gr/OW/B5vhk7RYWdZ8ol69cC8nUNO6jS4v2I1VJNM8mISso99Zh7yBJsoMa4sPvEIS
	 Y6QC7PUazHHHvFKu/DAxXKcS7gjYyZBEcikEvR7AJOZ+q/6Z1ecHEenBSyI5Q/HJpD
	 l8sMnUX1xJme/6FWkoWge4jq1Wbfp5dmS5Vt2z+uwpTZJppTgGvR249Nxh1C3Kt7BU
	 qNlazcqZrGXeSK8++fSRMtxkOhtCFlGCcnJEFiNCig8Og9c8bpZMTwa7P/G30rIe57
	 XsviF7f2aW4iw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8f8d80faebso282000366b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 01:28:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUd1NEeHUw97mnVnAQX5TzMHNXBRg+xC51vKtn0ofq/sScM6GgqLnwZxMQwnA0xD3araHP+2wFgiLQ4Jfw/@vger.kernel.org
X-Gm-Message-State: AOJu0YyBKHXBircs43Yde9cyHDdHsLsX6iyLg6AT1v8DqmvqKqBiQp2A
	/BlgABflg+ZK0exnO97hJw4OdhIzOlkPfy7m2LbZk/x4QfBxgNFp+btb2WCUM2rSrPSEfhkmu7x
	fe/xMr5AUOz6j3zawBhXBktlUy7wiGOI=
X-Received: by 2002:a17:906:f585:b0:b8f:d2a0:c283 with SMTP id
 a640c23a62f3a-b9356f0260bmr120493066b.1.1772098137974; Thu, 26 Feb 2026
 01:28:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226020615.495490-1-rdunlap@infradead.org>
In-Reply-To: <20260226020615.495490-1-rdunlap@infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 26 Feb 2026 18:28:45 +0900
X-Gmail-Original-Message-ID: <CAKYAXd84GaSYX7bijQMkTM9yr+enDEN5fKLsUegc6cphO__jgg@mail.gmail.com>
X-Gm-Features: AaiRm53M0RdXPQelOzRBjPOkbPr6jFJWyznMRC8cqcvjl2o1jqykJLA_aXNFKxk
Message-ID: <CAKYAXd84GaSYX7bijQMkTM9yr+enDEN5fKLsUegc6cphO__jgg@mail.gmail.com>
Subject: Re: [PATCH] ntfs: repair docum. malformed table
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Hyunchul Lee <hyc.lee@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78456-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lwn.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: C040D1A388B
X-Rspamd-Action: no action

T24gVGh1LCBGZWIgMjYsIDIwMjYgYXQgMTE6MDbigK9BTSBSYW5keSBEdW5sYXAgPHJkdW5sYXBA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+DQo+IE1ha2UgdGhlIHRvcCBhbmQgYm90dG9tIGJvcmRl
cnMgYmUgdGhhdCBzYW1lIGxlbmd0aCB0bw0KPiBhdm9pZCBhIGRvY3VtZW50YXRpb24gYnVpbGQg
ZXJyb3I6DQo+DQo+IERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvbnRmcy5yc3Q6MTU5OiBFUlJP
UjogTWFsZm9ybWVkIHRhYmxlLg0KPiBCb3R0b20gYm9yZGVyIG9yIGhlYWRlciBydWxlIGRvZXMg
bm90IG1hdGNoIHRvcCBib3JkZXIuDQo+DQo+ICh0b3ApDQo+ID09PT09PT09PT09PT09PT09PT09
PT09ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
PiAoYm90dG9tKQ0KPiA9PT09PT09PT09PT09PT09PT09PT09PSA9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBSYW5k
eSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCkFwcGxpZWQgaXQgdG8gI250ZnMtbmV4
dC4NClRoYW5rcyENCg==

