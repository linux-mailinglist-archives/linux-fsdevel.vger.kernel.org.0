Return-Path: <linux-fsdevel+bounces-40523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB6BA2458E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 00:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2881A3A2C25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 23:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9556192D87;
	Fri, 31 Jan 2025 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Kh+wTqDb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B585E1586CF
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 23:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738364486; cv=none; b=VdzqWDCnfhedl12AodTJJNjwBqC8IgM4vimo6/8fe/wSqbFF7oheSBuM6zZaQSMSgSjTStwLGkrivZpjZVmu/5PDMpn+avXVxV7lBpube9SVAK4z1ZMIHkrdz8P2q2KTO968ULGkl0RLs52C9cTpgyMD44rcNQjCjTx6t0jh4Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738364486; c=relaxed/simple;
	bh=IXpmFXTNMQIho/IWmjbJkAL98p+fodqDvET9hgbZrHY=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tPxhH9uszpLq9p9CUIGBZdYtgQlE5pgfbACx/7wi3mWYZ+aYnBcV2WI+OMw1dEoZoPd0iz5YMpLvvMVNbo3eYvGPPbrCfE2UbC0XelLxIOlhWAPVzrMfkXg4vSzWl25u82si/g8g8S2Q12gKk2+q0JGWj5kZRQku8W42ks769XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Kh+wTqDb; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738364486; x=1769900486;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=IXpmFXTNMQIho/IWmjbJkAL98p+fodqDvET9hgbZrHY=;
  b=Kh+wTqDbGrBDJhy45IgRoyX2WCPjfP/nEmTmuvVrWe+6a2RMXybpyy40
   zAFldo523eRRrrngcBf047FuGfDNDZ05dgj/a96PferIbQ4ns1WwDOt8G
   RucJv9eqtQKqCfOafBf2va6KRwNdgeFk5/mOHpGsbHD01Vn3EJmY03OIf
   8=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="62206162"
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Thread-Topic: [Lsf-pc] [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 23:01:24 +0000
Received: from EX19MTAUEB001.ant.amazon.com [10.0.29.78:42082]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.48.55:2525] with esmtp (Farcaster)
 id db3f9edf-5b74-41ad-91c3-67005ae5094f; Fri, 31 Jan 2025 23:01:23 +0000 (UTC)
X-Farcaster-Flow-ID: db3f9edf-5b74-41ad-91c3-67005ae5094f
Received: from EX19D017UEA004.ant.amazon.com (10.252.134.70) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 23:01:22 +0000
Received: from EX19D017UEA001.ant.amazon.com (10.252.134.93) by
 EX19D017UEA004.ant.amazon.com (10.252.134.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 23:01:22 +0000
Received: from EX19D017UEA001.ant.amazon.com ([fe80::bffb:623f:af5e:ebed]) by
 EX19D017UEA001.ant.amazon.com ([fe80::bffb:623f:af5e:ebed%3]) with mapi id
 15.02.1258.039; Fri, 31 Jan 2025 23:01:22 +0000
From: "Day, Timothy" <timday@amazon.com>
To: Amir Goldstein <amir73il@gmail.com>, Andreas Dilger <adilger@ddn.com>
CC: Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jsimmons@infradead.org" <jsimmons@infradead.org>, "neilb@suse.de"
	<neilb@suse.de>
Thread-Index: AQHbdC0lJT0shTaEGUaJ4/a5JPi6tbMxK+qA
Date: Fri, 31 Jan 2025 23:01:22 +0000
Message-ID: <1A60CCB2-5412-4223-849C-F6824F82B1B2@amazon.com>
References: <5A3D5719-1705-466D-9A86-96DAFD7EAABD@amazon.com>
 <Z5h1wmTawx6P8lfK@infradead.org>
 <DD162239-D4B3-433C-A7C1-2DBEBFA881EC@amazon.com>
 <20250130142820.GA401886@mit.edu>
 <4044F3FF-D0CE-4823-B104-0544A986DF7B@ddn.com>
 <CAOQ4uxgpDy-WFJgpha38SQxSYZDVSaACexJ5ZMr2hN7XkzsBqQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgpDy-WFJgpha38SQxSYZDVSaACexJ5ZMr2hN7XkzsBqQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <63D23F477D380649A38EFDE3E74A957A@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMS8zMS8yNSwgNToxMSBQTSwgIkFtaXIgR29sZHN0ZWluIiA8YW1pcjczaWxAZ21haWwuY29t
IDxtYWlsdG86YW1pcjczaWxAZ21haWwuY29tPj4gd3JvdGU6DQo+IE9uIEZyaSwgSmFuIDMxLCAy
MDI1IGF0IDM6MzUgQU0gQW5kcmVhcyBEaWxnZXIgdmlhIExzZi1wYw0KPiA8bHNmLXBjQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnIDxtYWlsdG86bHNmLXBjQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnPj4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+IEFzIFRpbSBtZW50aW9uZWQsIGl0IGlzIHBv
c3NpYmxlIHRvIG1vdW50IGEgTHVzdHJlIGNsaWVudCAob3IgdHdvKSBwbHVzIG9uZSBvcg0KPiA+
IG1vcmUgTURUL09TVCBvbiBhIHNpbmdsZSB+M0dCIFZNIHdpdGggbG9vcGJhY2sgZmlsZXMgaW4g
L3RtcCBhbmQgcnVuIHRlc3RpbmcuDQo+ID4gVGhlcmUgaXMgYSBzaW1wbGUgc2NyaXB0IHdlIHVz
ZSB0byBmb3JtYXQgYW5kIG1vdW50IDQgTURUcyBhbmQgNCBPU1RzIG9uDQo+ID4gdGVtcG9yYXJ5
IGxvb3AgZmlsZXMgYW5kIG1vdW50IGEgY2xpZW50IGZyb20gdGhlIEx1c3RyZSBidWlsZCB0cmVl
Lg0KPiA+DQo+ID4gVGhlcmUgaGF2ZW4ndCBiZWVuIGFueSBWRlMgcGF0Y2hlcyBuZWVkZWQgZm9y
IHllYXJzIGZvciBMdXN0cmUgdG8gYmUgcnVuLA0KPiA+IHRob3VnaCB0aGVyZSBhcmUgYSBudW1i
ZXIgcGF0Y2hlcyBuZWVkZWQgYWdhaW5zdCBhIGNvcGllZCBleHQ0IHRyZWUgdG8NCj4gPiBleHBv
cnQgc29tZSBvZiB0aGUgZnVuY3Rpb25zIGFuZCBhZGQgc29tZSBmaWxlc3lzdGVtIGZlYXR1cmVz
LiBVbnRpbCB0aGUNCj4gPiBleHQ0IHBhdGNoZXMgYXJlIG1lcmdlZCwgaXQgd291bGQgYWxzbyBi
ZSBwb3NzaWJsZSB0byBydW4gbGlnaHQgdGVzdGluZyB3aXRoDQo+ID4gVGltJ3MgUkFNLWJhc2Vk
IE9TRCB3aXRob3V0IGFueSBsb29wYmFjayBkZXZpY2VzIGF0IGFsbCAodGhvdWdoIHdpdGggYQ0K
PiA+IGhhcmQgbGltaXRhdGlvbiBvbiB0aGUgc2l6ZSBvZiB0aGUgZmlsZXN5c3RlbSkuDQo+DQo+
DQo+IFJlY29tbWVuZGF0aW9uOiBpZiBpdCBpcyBlYXN5IHRvIHNldHVwIGxvb3BiYWNrIGx1c3Ry
ZSBzZXJ2ZXIsIHRoZW4gdGhlIGJlc3QNCj4gcHJhY3RpY2Ugd291bGQgYmUgdG8gYWRkIGx1c3Ry
ZSBmc3Rlc3RzIHN1cHBvcnQsIHNhbWUgYXMgbmZzL2Fmcy9jaWZzIGNhbiBiZQ0KPiB0ZXN0ZWQg
d2l0aCBmc3Rlc3RzLg0KPg0KPg0KPiBBZGRpbmcgZnN0ZXN0cyBzdXBwb3J0IHdpbGwgbm90IGd1
YXJhbnRlZSB0aGF0IHZmcyBkZXZlbG9wZXJzIHdpbGwgcnVuIGZzdGVzdA0KPiB3aXRoIHlvdXIg
ZmlsZXN5c3RlbSwgYnV0IGlmIHlvdSBtYWtlIGlzIHN1cGVyIGVhc3kgZm9yIHZmcyBkZXZlbG9w
ZXJzIHRvDQo+IHRlc3QgeW91ciBmaWxlc3lzdGVtIHdpdGggYSB0aGUgZGUtZmFjdG8gc3RhbmRh
cmQgZm9yIGZzIHRlc3RpbmcsIHRoZW4gYXQgbGVhc3QNCj4gdGhleSBoYXZlIGFuIG9wdGlvbiB0
byB2ZXJpZnkgdGhhdCB0aGVpciB2ZnMgY2hhbmdlcyBhcmUgbm90IGJyZWFraW5nIHlvdXINCj4g
ZmlsZXN5c3RlbSwgd2hpY2ggaXMgd2hhdCB1cHN0cmVhbWluZyBpcyBzdXBwb3NlZCB0byBwcm92
aWRlLg0KDQpJIHdhcyBob3BpbmcgdG8gZG8gZXhhY3RseSB0aGF0LiBJJ3ZlIGJlZW4gYWJsZSBy
dW4gdG8gZnN0ZXN0cyBvbiBMdXN0cmUNCihpbiBhbiBhZGhvYyBtYW5uZXIpLCBidXQgSSB3YW50
ZWQgdG8gcHV0IHRvZ2V0aGVyIGEgcGF0Y2ggc2VyaWVzIHRvDQphZGQgcHJvcGVyIHN1cHBvcnQu
IFdvdWxkIGZzdGVzdHMgYWNjZXB0IEx1c3RyZSBzdXBwb3J0IGJlZm9yZSBMdXN0cmUNCmdldHMg
YWNjZXB0ZWQgdXBzdHJlYW0/IE9yIHNob3VsZCBpdCBiZSBtYWludGFpbmVkIGFzIGEgc2VwYXJh
dGUNCmJyYW5jaD8NCg0KVGltIERheQ0KDQo=

