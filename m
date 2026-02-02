Return-Path: <linux-fsdevel+bounces-76029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EuCIHxVgGkd6gIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 08:42:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD301C9458
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 08:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14C1F30226A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 07:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EC129BDBC;
	Mon,  2 Feb 2026 07:39:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail01.ukr.de (mail01.ukr.de [193.175.194.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5F721FF5F;
	Mon,  2 Feb 2026 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.194.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770017978; cv=none; b=puv3ATkwr2wZXnyLmfeDD0GrL6ofX0yI+EtGah9MYaiN1kT4eFl/V+/pn/9A0Mets2tgm3+OsHzBElBVVJ1olD2A21vsxhJzd8HVgAaLOBgTLWsI/xrRFogLUJ18RH5yydUhcuYJcOa6ZtOMq1zmdEaDiUwD5nTF8X6TD2jynzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770017978; c=relaxed/simple;
	bh=+Pts+qy34nNJTSg0Q4nyvFfkxhkO9rQKpVGpGbpZ7V8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RWDxY/ltA0iX9GtDvFvIfxKpgHOGyP5nGTURujfUGUMpWEKqoMwQGUkZbN37xtWc6o9kTttyJc6I7KJZuMIGHuZT2h9ys0Ugj1+XKWWl3w77rEsatkYTfNCAKIYe4omwJpZiVVT9mv7qXo/PjHeHgbo01W5M2dyat5hlNMzR18E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ukr.de; spf=pass smtp.mailfrom=ukr.de; arc=none smtp.client-ip=193.175.194.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ukr.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ukr.de
X-CSE-ConnectionGUID: LkNsD08bQi+Y45I06WsNBw==
X-CSE-MsgGUID: TJS8Az6HQESDNgsGIQt/QA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="2534877"
X-IronPort-AV: E=Sophos;i="6.21,268,1763420400"; 
   d="scan'208";a="2534877"
Received: from unknown (HELO ukr.de) ([172.24.2.107])
  by dmz-infcsg01.ukr.dmz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 08:38:24 +0100
Received: from ukr-excmb07.ukr.local (172.24.2.107) by ukr-excmb07.ukr.local
 (172.24.2.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 2 Feb
 2026 08:38:23 +0100
Received: from ukr-excmb07.ukr.local ([fe80::4dee:3e0b:b33f:60ac]) by
 ukr-excmb07.ukr.local ([fe80::4dee:3e0b:b33f:60ac%8]) with mapi id
 15.02.2562.035; Mon, 2 Feb 2026 08:38:23 +0100
From: "Windl, Ulrich" <u.windl@ukr.de>
To: "H. Peter Anvin" <hpa@zytor.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lennart
 Poettering" <lennart@poettering.net>, "systemd-devel@lists.freedesktop.org"
	<systemd-devel@lists.freedesktop.org>
Subject: RE: [EXT] [systemd-devel] [PATCH 0/3] Add the ability to mount
 filesystems during initramfs expansion
Thread-Topic: [EXT] [systemd-devel] [PATCH 0/3] Add the ability to mount
 filesystems during initramfs expansion
Thread-Index: AQHcjMt8Qr920kO9zkquhZDKntdOELVvE4ZA
Date: Mon, 2 Feb 2026 07:38:23 +0000
Message-ID: <51265a7170d7408a92192c5112c1e613@ukr.de>
References: <20260124003939.426931-1-hpa@zytor.com>
In-Reply-To: <20260124003939.426931-1-hpa@zytor.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-snts-smtp: B9CBB8B8612B45BE3480AB84915063B64470FD77E2D8070E0A0CE1770EBF5B212000:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76029-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ukr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.windl@ukr.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,lwn.net:email,lists.freedesktop.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zytor.com:email,poettering.net:email,linux.org.uk:email]
X-Rspamd-Queue-Id: DD301C9458
X-Rspamd-Action: no action

SGkhDQoNCkkgd29uZGVyOiB3b3VsZG4ndCBpdCBiZSBuaWNlciB0byB1c2UgYSBzdWJkaXJlY3Rv
cnkgbGlrZSAiLnN5c3RlbWQtbWFnaWMiIHRvIHBsYWNlIHN1Y2ggbWFnaWMgZmlsZXMgdGhlcmUg
dGhhdCBhcmUgaW50ZXJwcmV0ZWQgYnkgc3lzdGVtZD8gVGhlbiAiISEhTU9VTlQhISEiIHdvdWxk
IGJlY29tZSBhIHNpbXBsZSAibW91bnQiIG9yIG1heWJlICJmc3RhYiIgb3IgIm1vdW50dHRhYiIs
IC4uLg0KDQpLaW5kIHJlZ2FyZHMsDQpVbHJpY2ggV2luZGwNCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBzeXN0ZW1kLWRldmVsIDxzeXN0ZW1kLWRldmVsLWJvdW5jZXNA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbg0KPiBCZWhhbGYgT2YgSC4gUGV0ZXIgQW52aW4NCj4g
U2VudDogU2F0dXJkYXksIEphbnVhcnkgMjQsIDIwMjYgMTo0MCBBTQ0KPiBUbzogQWxleGFuZGVy
IFZpcm8gPHZpcm9AemVuaXYubGludXgub3JnLnVrPjsgQ2hyaXN0aWFuIEJyYXVuZXINCj4gPGJy
YXVuZXJAa2VybmVsLm9yZz47IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+OyBKb25hdGhhbiBDb3Ji
ZXQNCj4gPGNvcmJldEBsd24ubmV0PjsgSC4gUGV0ZXIgQW52aW4gPGhwYUB6eXRvci5jb20+DQo+
IENjOiBsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtZG9jQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExlbm5hcnQgUG9ldHRlcmlu
ZyA8bGVubmFydEBwb2V0dGVyaW5nLm5ldD47DQo+IHN5c3RlbWQtZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFtzeXN0ZW1kLWRldmVsXSBbUEFUQ0ggMC8zXSBB
ZGQgdGhlIGFiaWxpdHkgdG8gbW91bnQNCj4gZmlsZXN5c3RlbXMgZHVyaW5nIGluaXRyYW1mcyBl
eHBhbnNpb24NCj4gDQo+IA0KPiBBdCBQbHVtYmVyJ3MgMjAyNCwgTGVubmFydCBQb2V0dGVyaW5n
IG9mIHRoZSBzeXN0ZW1kIHByb2plY3QgcmVxdWVzdGVkDQo+IHRoZSBhYmlsaXR5IHRvIG92ZXJt
b3VudCB0aGUgcm9vdGZzIHdpdGggYSBzZXBhcmF0ZSB0bXBmcyBiZWZvcmUNCj4gaW5pdHJhbWZz
IGV4cGFuc2lvbiwgc28gdGhlIHBvcHVsYXRlZCB0bXBmcyBjYW4gYmUgdW5tb3VudGVkLg0KPiAN
Cj4gVGhpcyBwYXRjaHNldCB0YWtlcyB0aGlzIHJlcXVlc3QgYW5kIGdvZXMgb25lIHN0ZXAgZnVy
dGhlcjogaXQgYWxsb3dzDQo+IChtb3N0bHkpIGFyYml0cmFyeSBmaWxlc3lzdGVtcyBtb3VudHMg
ZHVyaW5nIGluaXRyYW1mcyBwcm9jZXNzaW5nLg0KPiANCj4gVGhpcyBpcyBkb25lIGJ5IGhhdmlu
ZyB0aGUgaW5pdHJhbWZzIGV4cGFuc2lvbiBjb2RlIGRldGVjdCB0aGUgc3BlY2lhbA0KPiBmaWxl
bmFtZSAiISEhTU9VTlQhISEiIHdoaWNoIGlzIHRoZW4gcGFyc2VkIGludG8gYSBzaW1wbGlmaWVk
DQo+IGZzdGFiLXR5cGUgbW91bnQgc3BlY2lmaWNhdGlvbiBhbmQgdGhlIGRpcmVjdG9yeSBpbiB3
aGljaCB0aGUNCj4gISEhTU9VTlQhISEgZW50cnkgaXMgdXNlZCBhcyB0aGUgbW91bnQgcG9pbnQu
DQo+IA0KPiBUaGlzIHNwZWNpZmljIG1ldGhvZCB3YXMgY2hvc2VuIGZvciB0aGUgZm9sbG93aW5n
IHJlYXNvbnM6DQo+IA0KPiAxLiBUaGlzIGluZm9ybWF0aW9uIGlzIHNwZWNpZmljIHRvIHRoZSBl
eHBlY3RhdGlvbnMgb2YgdGhlIGluaXRyYW1mczsNCj4gICAgdGhlcmVmb3JlIHVzaW5nIGtlcm5l
bCBjb21tYW5kIGxpbmUgb3B0aW9ucyBpcyBub3QNCj4gICAgYXBwcm9wcmlhdGUuIFRoaXMgd2F5
IHRoZSBpbmZvcm1hdGlvbiBpcyBmdWxseSBjb250YWluZWQgd2l0aGluIHRoZQ0KPiAgICBpbml0
cmFtZnMgaXRzZWxmLg0KPiAyLiBUaGUgc2VxdWVuY2UgISEhIGlzIGFscmVhZHkgc3BlY2lhbCBp
biBjcGlvLCBkdWUgdG8gdGhlICJUUkFJTEVSISEhIg0KPiAgICBlbnRyaWVzLg0KPiAzLiBUaGUg
ZmlsZW5hbWUgIiEhIU1PVU5UISEhIiB3aWxsIHR5cGljYWxseSBiZSBzb3J0ZWQgZmlyc3QsIHdo
aWNoDQo+ICAgIG1lYW5zIHVzaW5nIHN0YW5kYXJkIGZpbmQrY3BpbyB0b29scyB0byBjcmVhdGUg
dGhlIGluaXRyYW1mcyBzdGlsbA0KPiAgICB3b3JrLg0KPiA0LiBTaW1pbGFybHksIHN0YW5kYXJk
IGNwaW8gY2FuIHN0aWxsIGV4cGFuZCB0aGUgaW5pdHJhbWZzLg0KPiA1LiBJZiBydW4gb24gYSBs
ZWdhY3kga2VybmVsLCB0aGUgISEhTU9VTlQhISEgZmlsZSBpcyBjcmVhdGVkLCB3aGljaA0KPiAg
ICBpcyBlYXN5IHRvIGRldGVjdCBpbiB0aGUgaW5pdHJhbWZzIGNvZGUgd2hpY2ggY2FuIHRoZW4g
YWN0aXZhdGUNCj4gICAgc29tZSBmYWxsYmFjayBjb2RlLg0KPiA2LiBJdCBhbGxvd3MgZm9yIG11
bHRpcGxlIGZpbGVzeXN0ZW1zIHRvIGJlIG1vdW50ZWQsIHBvc3NpYmx5IG9mDQo+ICAgIGRpZmZl
cmVudCB0eXBlcyBhbmQgaW4gZGlmZmVyZW50IGxvY2F0aW9ucywgZS5nLiB0aGUgaW5pdHJhbWZz
IGNhbg0KPiAgICBnZXQgc3RhcnRlZCB3aXRoIC9kZXYsIC9wcm9jLCBhbmQgL3N5cyBhbHJlYWR5
IGJvb3RlZC4NCj4gDQo+IFRoZSBwYXRjaGVzIGFyZToNCj4gDQo+ICAgICAxLzM6IGZzL2luaXQ6
IG1vdmUgY3JlYXRpbmcgdGhlIG1vdW50IGRhdGFfcGFnZSBpbnRvIGluaXRfbW91bnQoKQ0KPiAg
ICAgMi8zOiBpbml0cmFtZnM6IHN1cHBvcnQgbW91bnRpbmcgZmlsZXN5c3RlbXMgZHVyaW5nIGlu
aXRyYW1mcyBleHBhbnNpb24NCj4gICAgIDMvMzogRG9jdW1lbnRhdGlvbi9pbml0cmFtZnM6IGRv
Y3VtZW50IG1vdW50IHBvaW50cyBpbiBpbml0cmFtZnMNCj4gDQo+IC0tLQ0KPiAgLi4uL2RyaXZl
ci1hcGkvZWFybHktdXNlcnNwYWNlL2J1ZmZlci1mb3JtYXQucnN0ICAgfCA2MCArKysrKysrKysr
KysrLQ0KPiAgZnMvaW5pdC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAyMyArKysrKy0NCj4gIGluY2x1ZGUvbGludXgvaW5pdF9zeXNjYWxscy5oICAgICAgICAg
ICAgICAgICAgICAgIHwgIDMgKy0NCj4gIGluaXQvZG9fbW91bnRzLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgMTcgKy0tLQ0KPiAgaW5pdC9pbml0cmFtZnMuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA5NSArKysrKysrKysrKysrKysrKysrKystDQo+
ICA1IGZpbGVzIGNoYW5nZWQsIDE3NSBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCg==

