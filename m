Return-Path: <linux-fsdevel+bounces-70811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F822CA7426
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 11:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C049D303D321
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 10:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B659F329C52;
	Fri,  5 Dec 2025 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="pvHP9auW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender3-of-o55.zoho.com (sender3-of-o55.zoho.com [136.143.184.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C32A30CD8A;
	Fri,  5 Dec 2025 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764931899; cv=pass; b=GbF+SW7IsLIqBok7cDemxdaccLCFnU4fCRdccSgKcYmcMHzoqMNqwZWAyNQWjkmnT/swmbMALtwPa/lbKTUqQemFZHKtL38yQBnP9P6I2GOXER64PpN4KPqNpyQ8SHhsblOeO16HmregOrL/1mgXnb6HONqhrlDxxeXeXF0SFmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764931899; c=relaxed/simple;
	bh=d0aNk6WgoSVmyUthi2xxqzMYT6K50Z030FubRRIwIgo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uwTD0xI0Oy3XteLO49h/rgYfxjubjHt6+18aStbvg9MsUvMe+4NE2RNNdGGD9z119Ynr08memCWwIgx7t4e6Qxqs8Lz3CgGozBe+TbpHqy1d1JvV3MbJLuZkrjTGH6mVdGe23J/mnIVWEwMFNZaAwFPLXE+Oj2kJQ3tTNJeJc2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=pvHP9auW; arc=pass smtp.client-ip=136.143.184.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1764931881; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lMp9ROJj1zjWnxOhXzpKhNn9HERNCqxwdL91vd4BzrcionxXi4l55ln13r6l+wyeMAyo75i+gs7lez2vc3bQez3dvfTcrIb2QPy3BgS42Z6f7QsJUmI6wxi+Z7v+4HkpYHYGrUVHQAF7w1n8psAIJ2UzosdFCGBmUY1u+Dmw/wE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764931881; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=d0aNk6WgoSVmyUthi2xxqzMYT6K50Z030FubRRIwIgo=; 
	b=li0emkERwFpCxP8Ig1JE48Tr3sld6IGCkZJW6FJlq+kIdccmYQy5LfRBmqtIWQncPBAsq3pm1heBGRp5ssGhAkzbBQRlSYDUTI4aXarL5V7pnjaE70KVg2HwUH4zzFY0LrLKI6UXPtlwuAav70aQAXb8DXl3kOfcbZJTkWO3RdE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764931881;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=d0aNk6WgoSVmyUthi2xxqzMYT6K50Z030FubRRIwIgo=;
	b=pvHP9auWvRir8+fatMnLF3Zf1ggo6NQ9l/Ny3Bp7QUzkGgVEqJLckxkKEmS4+Lj4
	TiBO+tZgRiSBhWOgysXynijtDizlqxriOBUfOoMaTrZ4K56QPwFb/euBnWPndweaU/9
	ATS087e33VTJl7Fco0Who5I1d4+aO86oTaAqEuB0=
Received: by mx.zohomail.com with SMTPS id 1764931879412666.8539055240332;
	Fri, 5 Dec 2025 02:51:19 -0800 (PST)
Message-ID: <edc1773d7d2e36682f607549a1f69b1bc503f72e.camel@mpiricsoftware.com>
Subject: Re: [PATCH v4] lib: xarray: free unused spare node in
 xas_create_range()
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, willy@infradead.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dev.jain@arm.com, janak@mpiricsoftware.com, shardulsb08@gmail.com
Date: Fri, 05 Dec 2025 16:21:13 +0530
In-Reply-To: <d651e943-99f5-431e-a67d-e4e6784e720e@kernel.org>
References: <20251204142625.1763372-1-shardul.b@mpiricsoftware.com>
	 <d651e943-99f5-431e-a67d-e4e6784e720e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

T24gRnJpLCAyMDI1LTEyLTA1IGF0IDA4OjIyICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCAoUmVk
IEhhdCkgd3JvdGU6Cj4gPiBMaW5rOgo+ID4gaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20v
YnVnP2lkPWEyNzRkNjVmYzczMzQ0OGVkNTE4YWQxNTQ4MWVkNTc1NjY5ZGQ5OGMKPiAuLi4KPiBS
ZXZpZXdlZC1ieTogRGF2aWQgSGlsZGVuYnJhbmQgKFJlZCBIYXQpIDxkYXZpZEBrZXJuZWwub3Jn
Pgo+IAo+IAo+IEJUVywgZG8gd2UgaGF2ZSBhIHdheSB0byB0ZXN0IHRoaXMgaW4gYSB0ZXN0IGNh
c2U/CkhpIERhdmlkLAoKVGhhbmtzIGZvciB0aGUgcmV2aWV3IGFuZCB0aGUgUmV2aWV3ZWQtYnku
CgpSZWdhcmRpbmcgYSB0ZXN0IGNhc2U6IEkgZG9u4oCZdCBoYXZlIGEgZm9jdXNlZCBzZWxmdGVz
dCBvciBmYXVsdC0KaW5qZWN0aW9uIHNldHVwIHlldCB0aGF0IHJlbGlhYmx5IGhpdHMgdGhpcyB4
YXNfbm9tZW0oKSArCnhhc19jcmVhdGVfcmFuZ2UoKSBjb3JuZXIgY2FzZS4gCkkgbm90aWNlZCB0
aGlzIHNwYXJlLW5vZGUgbGVhayB3aGlsZSBhbmFseXppbmcgdGhlIFN5emJvdCByZXBvcnQgSQpy
ZWZlcmVuY2VkIGluIHRoZSBMaW5rOiB0YWcsIGJ1dCB0aGUgcmVwcm9kdWNlciBJIHNlZSB0aGVy
ZSBkb2VzbuKAmXQKaXNvbGF0ZSB0aGlzIHBhdGggYW5kIHJlcG9ydHMgb3RoZXIga21lbWxlYWtz
LgoKRm9yIG5vdyBJ4oCZZCBwcmVmZXIgdG8gdHJlYXQgdGhpcyBhcyBhIHNtYWxsIGNvcnJlY3Ru
ZXNzIGZpeCBpbiB4YXJyYXkKaXRzZWxmLiBJZiBJIG1hbmFnZSB0byBjb21lIHVwIHdpdGggYSBy
b2J1c3Qgd2F5IHRvIGV4ZXJjaXNlIHRoaXMgcGF0aAppbiBhIHNlbGZ0ZXN0IChlLmcuIHZpYSB0
YXJnZXRlZCBmYXVsdCBpbmplY3Rpb24gaW4gbGliL3Rlc3RfeGFycmF5LmMpLApJIGNhbiBmb2xs
b3cgdXAgd2l0aCBhIHNlcGFyYXRlIHBhdGNoLCBidXQgSSBkb27igJl0IGhhdmUgYW55dGhpbmcg
c29saWQKdG8gcHJvcG9zZSB0b2RheS4KCj4gCj4gCj4gQSBmb2xsb3ctdXAgY2xlYW51cCB0aGF0
IGF2b2lkcyBsYWJlbHMgY291bGQgYmUgc29tZXRoaW5nIGxpa2UKPiAodW50ZXN0ZWQpOgo+IAo+
IAo+IGRpZmYgLS1naXQgYS9saWIveGFycmF5LmMgYi9saWIveGFycmF5LmMKPiBpbmRleCA5YThi
NDkxNjU0MGNmLi4zMjVmMjY0NTMwZmIyIDEwMDY0NAo+IC0tLSBhL2xpYi94YXJyYXkuYwo+ICsr
KyBiL2xpYi94YXJyYXkuYwo+IEBAIC03MTQsNiArNzE0LDcgQEAgdm9pZCB4YXNfY3JlYXRlX3Jh
bmdlKHN0cnVjdCB4YV9zdGF0ZSAqeGFzKQo+IMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9u
ZyBpbmRleCA9IHhhcy0+eGFfaW5kZXg7Cj4gwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBjaGFy
IHNoaWZ0ID0geGFzLT54YV9zaGlmdDsKPiDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGNoYXIg
c2licyA9IHhhcy0+eGFfc2liczsKPiArwqDCoMKgwqDCoMKgIGJvb2wgc3VjY2VzcyA9IGZhbHNl
Owo+IMKgIAo+IMKgwqDCoMKgwqDCoMKgwqAgeGFzLT54YV9pbmRleCB8PSAoKHNpYnMgKyAxVUwp
IDw8IHNoaWZ0KSAtIDE7Cj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoeGFzX2lzX25vZGUoeGFzKSAm
JiB4YXMtPnhhX25vZGUtPnNoaWZ0ID09IHhhcy0KPiA+eGFfc2hpZnQpCj4gQEAgLTcyNCw5ICs3
MjUsMTEgQEAgdm9pZCB4YXNfY3JlYXRlX3JhbmdlKHN0cnVjdCB4YV9zdGF0ZSAqeGFzKQo+IMKg
wqDCoMKgwqDCoMKgwqAgZm9yICg7Oykgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHhhc19jcmVhdGUoeGFzLCB0cnVlKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoeGFzX2Vycm9yKHhhcykpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGdvdG8gcmVzdG9yZTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoeGFzLT54YV9pbmRleCA8PSAoaW5kZXggfCBYQV9DSFVOS19NQVNLKSkKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBzdWNjZXNzOwo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhawo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh4YXMtPnhhX2luZGV4IDw9IChpbmRleCB8
IFhBX0NIVU5LX01BU0spKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHN1Y2NlZXNzID0gdHJ1ZTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHhhcy0+eGFfaW5kZXggLT0gWEFf
Q0hVTktfU0laRTsKPiDCoCAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3Ig
KDs7KSB7Cj4gQEAgLTc0MCwxNSArNzQzLDE3IEBAIHZvaWQgeGFzX2NyZWF0ZV9yYW5nZShzdHJ1
Y3QgeGFfc3RhdGUgKnhhcykKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4g
wqDCoMKgwqDCoMKgwqDCoCB9Cj4gwqAgCj4gLXJlc3RvcmU6Cj4gLcKgwqDCoMKgwqDCoCB4YXMt
PnhhX3NoaWZ0ID0gc2hpZnQ7Cj4gLcKgwqDCoMKgwqDCoCB4YXMtPnhhX3NpYnMgPSBzaWJzOwo+
IC3CoMKgwqDCoMKgwqAgeGFzLT54YV9pbmRleCA9IGluZGV4Owo+IC3CoMKgwqDCoMKgwqAgcmV0
dXJuOwo+IC1zdWNjZXNzOgo+IC3CoMKgwqDCoMKgwqAgeGFzLT54YV9pbmRleCA9IGluZGV4Owo+
IC3CoMKgwqDCoMKgwqAgaWYgKHhhcy0+eGFfbm9kZSkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB4YXNfc2V0X29mZnNldCh4YXMpOwo+ICvCoMKgwqDCoMKgwqAgaWYgKHN1Y2Nlc3Mp
IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4YXMtPnhhX2luZGV4ID0gaW5kZXg7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHhhcy0+eGFfbm9kZSkKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeGFzX3NldF9vZmZzZXQo
eGFzKTsKPiArwqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgeGFzLT54YV9zaGlmdCA9IHNoaWZ0Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHhhcy0+eGFfc2licyA9IHNpYnM7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
eGFzLT54YV9pbmRleCA9IGluZGV4Owo+ICvCoMKgwqDCoMKgwqAgfQo+ICvCoMKgwqDCoMKgwqAg
LyogRnJlZSBhbnkgdW51c2VkIHNwYXJlIG5vZGUgZnJvbSB4YXNfbm9tZW0oKSAqLwo+ICvCoMKg
wqDCoMKgwqAgeGFzX2Rlc3Ryb3koeGFzKTsKPiDCoCB9Cj4gwqAgRVhQT1JUX1NZTUJPTF9HUEwo
eGFzX2NyZWF0ZV9yYW5nZSk7Cj4gCj4gCllvdXIgYm9vbC1iYXNlZCB2ZXJzaW9uIHJlYWRzIG5p
Y2VyOyBJ4oCZbSBoYXBweSB0byBmb2xsb3cgdXAgd2l0aCBhCnNtYWxsIGNsZWFudXAgcGF0Y2gg
b24gdG9wIHRoYXQgc3dpdGNoZXMgeGFzX2NyZWF0ZV9yYW5nZSgpIG92ZXIgdG8KdGhhdCBzdHls
ZSAod2l0aCBhIFN1Z2dlc3RlZC1ieSB0YWcpLgoKVGhhbmtzIGFuZCBSZWdhcmRzLApTaGFyZHVs
Cgo=


