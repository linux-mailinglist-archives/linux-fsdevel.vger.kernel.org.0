Return-Path: <linux-fsdevel+bounces-40404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A96A231AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 17:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A883A772F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 16:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E11B1EBFF5;
	Thu, 30 Jan 2025 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NN807k+y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6871E9B3A
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738253912; cv=none; b=Q+t25nEzeUHHUQH28+iwQDs4qgRBfyQq53TNt9ihFIhmgzVaaufHo4c3lAea98gsfgkyNR5Xm9TyKs9acPJYzUETehata/VkecJhogIsp2Tbf2Qvl6XIaElO6ittySAqFuqcLMaID7iiwtCJMdSbL/x/XzIeIHKIlcDiccTnhvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738253912; c=relaxed/simple;
	bh=UuTVasloS+4IPS6W9HnNa2RwA4nkKrtMzBVAWVrkZdM=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F1KAR9NW1KtI5Ip95E/HytbMTcY3i4nDwgyzfIiKzayCnB9/YBLazxflo/7fC+1Xc/wYIbmZbSwEFTUa5pNoHG3QfgTP4HkxOJkBsG8H1oxd3t0u7OehOi4GNeAeU784kyywOcIrdk8EQqERAYAG4Ny+4cFre/oS+klLX/D3FwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NN807k+y; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738253911; x=1769789911;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=UuTVasloS+4IPS6W9HnNa2RwA4nkKrtMzBVAWVrkZdM=;
  b=NN807k+yUy5RA1MKClmy+8P0QajGkhDPgZu9jbyjoZu5ccuGhgOxzEJl
   9szjhYAeo9Sf1MGGU+h7PPRIc44oo1MfL1mU8k/46Ls0wIzBWGv7mSoS7
   AVwGY49rImIN0qqk6nYEXJhS275zwPQ1S1iVw8OH5C333/f1dZykShEMi
   k=;
X-IronPort-AV: E=Sophos;i="6.13,245,1732579200"; 
   d="scan'208";a="165529826"
Subject: Re: [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Thread-Topic: [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 16:18:30 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.29.78:56773]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.87.35:2525] with esmtp (Farcaster)
 id 1a476b3a-57da-4392-9d79-bc38b1caf41e; Thu, 30 Jan 2025 16:18:29 +0000 (UTC)
X-Farcaster-Flow-ID: 1a476b3a-57da-4392-9d79-bc38b1caf41e
Received: from EX19D017UEA002.ant.amazon.com (10.252.134.77) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 30 Jan 2025 16:18:29 +0000
Received: from EX19D017UEA001.ant.amazon.com (10.252.134.93) by
 EX19D017UEA002.ant.amazon.com (10.252.134.77) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 30 Jan 2025 16:18:29 +0000
Received: from EX19D017UEA001.ant.amazon.com ([fe80::bffb:623f:af5e:ebed]) by
 EX19D017UEA001.ant.amazon.com ([fe80::bffb:623f:af5e:ebed%3]) with mapi id
 15.02.1258.039; Thu, 30 Jan 2025 16:18:29 +0000
From: "Day, Timothy" <timday@amazon.com>
To: Theodore Ts'o <tytso@mit.edu>
CC: Christoph Hellwig <hch@infradead.org>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "jsimmons@infradead.org"
	<jsimmons@infradead.org>, Andreas Dilger <adilger@ddn.com>, "neilb@suse.de"
	<neilb@suse.de>
Thread-Index: AQHbbqGKPQGkNCnWmkGOpAnSPDKrX7MruoAAgABZxoCAA1TiAP//yvQA
Date: Thu, 30 Jan 2025 16:18:29 +0000
Message-ID: <0E992E6A-AF0D-4DFB-A014-5A08184821CD@amazon.com>
References: <5A3D5719-1705-466D-9A86-96DAFD7EAABD@amazon.com>
 <Z5h1wmTawx6P8lfK@infradead.org>
 <DD162239-D4B3-433C-A7C1-2DBEBFA881EC@amazon.com>
 <20250130142820.GA401886@mit.edu>
In-Reply-To: <20250130142820.GA401886@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DFF9C487E55254F8EC4649067AA1334@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMS8zMC8yNSwgOToyOCBBTSwgIlRoZW9kb3JlIFRzJ28iIDx0eXRzb0BtaXQuZWR1IDxtYWls
dG86dHl0c29AbWl0LmVkdT4+IHdyb3RlOg0KPiBPbiBUdWUsIEphbiAyOCwgMjAyNSBhdCAwNDoz
NTo0NlBNICswMDAwLCBEYXksIFRpbW90aHkgd3JvdGU6DQo+ID4gTXkgYmlnZ2VzdCBxdWVzdGlv
biBmb3IgTFNGIGlzIGFyb3VuZCBkZXZlbG9wbWVudCBtb2RlbDoNCj4gPiBPdXIgY3VycmVudCBk
ZXZlbG9wbWVudCBtb2RlbCBpcyBzdGlsbCBvcnRob2dvbmFsIHRvIHdoYXQNCj4gPiBtb3N0IG90
aGVyIHN1YnN5c3RlbXMvZHJpdmVycyBkby4gQnV0IGFzIHdlIGV2b2x2ZSwgaG93IGRvDQo+ID4g
d2UgZGVtb25zdHJhdGUgdGhhdCBvdXIgZGV2ZWxvcG1lbnQgbW9kZWwgaXMgcmVhc29uYWJsZT8N
Cj4gPiBTZW5kaW5nIHRoZSBpbml0aWFsIHBhdGNoZXMgaXMgb25lIHRoaW5nLiBDb252aW5jaW5n
IGV2ZXJ5b25lDQo+ID4gdGhhdCB0aGUgbW9kZWwgaXMgc3VzdGFpbmFibGUgaXMgYW5vdGhlci4N
Cj4NCj4gSSBzdXNwZWN0IG9uZSBvZiB0aGUgcmVhc29ucyB3aHkgbW9zdCBkZXZlbG9wbWVudCBp
cyBoYXBwZW5pbmcgb3V0LW9mLXRyZWUNCj4gaXMgcHJldHR5IG11Y2ggYWxsIG9mIHRoZSB1c2Vy
cyBvZiBMdXN0cmUgYXJlIHVzaW5nIGRpc3RybyAoYW5kIHZlcnkNCj4gb2Z0ZW4sIEVudGVycHJp
c2UpIGtlcm5lbHMuIEFyZSB0aGVyZSBhbnkgcGVvcGxlIG91dHNpZGUgb2YgdGhlIGNvcmUNCj4g
THVzdHJlIHRlYW0gKG1vc3Qgb2Ygd2hvbSBhcmUgcHJvYmFibHkgd29ya2luZyBmb3IgREROPykg
dGhhdCB1c2UNCj4gTHVzdHJlIG9yIGNhbiBldmVuIHRlc3QgTHVzdHJlIHVzaW5nIHRoZSB1cHN0
cmVhbSBrZXJuZWw/DQoNCkx1c3RyZSBoYXMgYSBsb3Qgb2YgdXNhZ2UgYW5kIGRldmVsb3BtZW50
IG91dHNpZGUgb2YgREROL1doYW1jbG91ZCBbMV1bMl0uDQpIUEUsIEFXUywgU3VTZSwgQXp1cmUs
IGV0Yy4gQW5kIGF0IGxlYXN0IGF0IEFXUywgd2UgdXNlIEx1c3RyZSBvbiBmYWlybHkNCnVwLXRv
LWRhdGUga2VybmVscyBbM11bNF0uIEFuZCBJIHRoaW5rIHRoaXMgaXMgYmVjb21pbmcgbW9yZSBj
b21tb24gLSBhbHRob3VnaA0KSSBkb24ndCBoYXZlIHNvbGlkIGRhdGEgb24gdGhhdC4NCg0KWzFd
IGh0dHBzOi8vZW4ud2lraXBlZGlhLm9yZy93aWtpL0x1c3RyZV8oZmlsZV9zeXN0ZW0pI0NvbW1l
cmNpYWxfdGVjaG5pY2FsX3N1cHBvcnQNClsyXSBodHRwczovL3lvdXR1LmJlL0JFLS15U1ZRYjJN
P3NpPVlNSGl0SmZjRTRBU1dRY0UmdD05NjANClszXSBBTDIwMjMgNi4xIC0gaHR0cHM6Ly9naXRo
dWIuY29tL2FtYXpvbmxpbnV4L2xpbnV4L2NvbW1pdC9lZjk2NjAwOTE3MTJmYTllZGQxMzcxODBi
ODkyNWVhNjMxNmM4MDQzDQpbNF0gQUwyMDIzIDYuMTIgKFNvb24pIC0gaHR0cHM6Ly9naXRodWIu
Y29tL2FtYXpvbmxpbnV4L2xpbnV4L2NvbW1pdHMvYW1hem9uLTYuMTIueS9tYWlubGluZS8NCg0K
PiBJJ2xsIGxldCBBbmRyZWFzIHRvIGNvbW1lbnQgZnVydGhlciwgYnV0IGZyb20gbXkgcGVyc3Bl
Y3RpdmUsIGlmIHdlDQo+IHdhbnQgdG8gdXBzdHJlYW1pbmcgTHVzdHJlIHRvIGJlIHN1Y2Nlc3Nm
dWwsIHBlcmhhcHMgb25lIHN0cmF0ZWd5DQo+IHdvdWxkIGJlIHRvIG1ha2UgaXQgZWFzaWVyIGZv
ciB1cHN0cmVhbSB1c2VycyBhbmQgZGV2ZWxvcGVycyB0byB1c2UNCj4gTHVzdHJlLCBwZXJoYXBz
IGluIGEgc21hbGxlciBzY2FsZSB0aGFuIHdoYXQgYSB0eXBpY2FsIERETiBjdXN0b21lcg0KPiB3
b3VsZCB0eXBpY2FsbHkgdXNlLg0KDQpJZiB3ZSB1cHN0cmVhbWVkIHRoZSBzZXJ2ZXIgYWxvbmdz
aWRlIHRoZSBjbGllbnQgLSBpdCdkIGJlIGVhc3kgZW5vdWdoDQpmb3IgdXBzdHJlYW0gZGV2ZWxv
cGVycyB0byBzZXR1cCBhIGNvbGxvY2F0ZWQgTHVzdHJlIGNsaWVudC9zZXJ2ZXINCmFuZCBydW4g
eGZzdGVzdHMgYXQgbGVhc3QuIEF0IHNvbWUgcG9pbnQgKGluIHRoZSBuZWFyLWlzaCBmdXR1cmUp
LCBJIHdhbnQNCnRvIHB1dCB0b2dldGhlciBhIHBhdGNoIHNlcmllcyBmb3IgeGZzdGVzdHMvTHVz
dHJlIHN1cHBvcnQuDQoNCkFuZCBpZiB5b3UgaGF2ZSBkZWRpY2F0ZWQgaGFyZHdhcmUgLSBzZXR0
aW5nIHVwIGEgc21hbGwgZmlsZXN5c3RlbSBvdmVyDQpUQ1AvSVAgaXNuJ3QgbXVjaCBoYXJkZXIg
dGhhbiBhbiBORlMgc2VydmVyIElNSE8uIEp1c3QgYSBta2ZzIGFuZA0KbW91bnQgcGVyIHN0b3Jh
Z2UgdGFyZ2V0LiBXaXRoIGEgc2luZ2xlIE1EUyBhbmQgT1NTLCB5b3Ugb25seSBuZWVkIHR3bw0K
ZGlza3MuIFNvIEkgdGhpbmsgd2UgaGF2ZSBldmVyeXRoaW5nIHdlIG5lZWQgdG8gZW5hYmxlIHVw
c3RyZWFtDQp1c2Vycy9kZXZzIHRvIHVzZSBMdXN0cmUgd2l0aG91dCB0b28gbXVjaCBoYXNzbGUu
IEkgdGhpbmsgaXQncyBtb3N0bHkgYQ0KbWF0dGVyIG9mIGRvY3VtZW50YXRpb24gYW5kIHNjcmlw
dGluZy4NCg0KVGltIERheQ0KDQo=

