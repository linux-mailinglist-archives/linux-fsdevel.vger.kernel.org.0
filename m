Return-Path: <linux-fsdevel+bounces-79764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIxgOlezrmkSHwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 12:47:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF023823E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 12:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED539304ADBD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 11:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8283A63F6;
	Mon,  9 Mar 2026 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="DLzWTYCm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693C355F3A;
	Mon,  9 Mar 2026 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056849; cv=pass; b=T/fnnDrK/iympVK1PTXkovyA9rvc0UTyevQKlYIAT03i0ny8bBoW6yLGjTcavI/kRJWXUIvSvWA16K9wAHofGKNOEuhKZNVvN1Vb7AeiDr4utcg5WaJpKl15xpDaDLyAf3nNBLBxF9tBIROOfu6XIR/Mxpq5GiXvEohsNi14Bc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056849; c=relaxed/simple;
	bh=PYNYckGRfY55lIs6Za3Sc6zgUdbTRwBvFGtXfYlRsnE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kHrzRr0r1O7mwUXCSHM6A2nzIxm59uW47MX6g2UlQ41lGa2IGpQN44fqMU7DWGUqp9vVlQmeYL8MqS2zmxW7+S53531HCNMKKIsqXeXKN3WEkGHtvM97RtRV69dw4SW9jc/KO4/wSIx+IaW/h/WkGLX833poXDc6+Io/Z9pv6lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=DLzWTYCm; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1773056828; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SB46gieg3ttnDmbnGv37FmUgZiiuaTjYGmoexT1bY6iZ8cWM+XIo1/mFRNb7eLM5zruSaVsl7adK6bBNrZSR5d8EgmMXSH+qAot8zlfkbbrkrprcAgQxQ1wvAqkTBGBCDR5vedNS64UAzpQfauHFFz2jMqNPtOqZ0r/yWzjdQUM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773056828; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PYNYckGRfY55lIs6Za3Sc6zgUdbTRwBvFGtXfYlRsnE=; 
	b=oFeMkNefkxsYufm7o+8XhPq4j/iOx0yHC6JLBkjBOZ9Hmz9ql90GJSNLxL9sgZIKwX6gA8maR4B3ikA/bEVFpE2waYfPXsH1+y7X65HqPOlQiBQnT9r+e6ZYcOUIJIySLpG5RgGxJWrVrnWfuPuz5qOY18h+0o8WM4Jhlm3wueU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773056828;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=PYNYckGRfY55lIs6Za3Sc6zgUdbTRwBvFGtXfYlRsnE=;
	b=DLzWTYCmAVVtZP6+ZCbO421hRiiLJjNwsgdCplPxaN4ZZ/pXQL9cHOBx4S4dZEci
	KxHvh9wi+gp2WVFLiopQBTVKxsZHDfQwKbGG66GxG9k0Ki5MYFWLXEWdf2ErTHSpnUt
	JLOoDZ1qA2H2J/VfrwOFKNxncx3aIkEO6DjIg22I=
Received: by mx.zohomail.com with SMTPS id 1773056825578831.9677499454527;
	Mon, 9 Mar 2026 04:47:05 -0700 (PDT)
Message-ID: <66104cc5521c69a4745b894be307eec25333eb09.camel@mpiricsoftware.com>
Subject: Re:  [PATCH v5 2/2] hfsplus: validate b-tree node 0 bitmap at mount
 time
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"glaubitz@physik.fu-berlin.de"
	 <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"slava@dubeyko.com"
	 <slava@dubeyko.com>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Cc: "janak@mpiric.us" <janak@mpiric.us>, "janak@mpiricsoftware.com"
	 <janak@mpiricsoftware.com>, 
	"syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	 <syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>, 
	shardulsb08@gmail.com
Date: Mon, 09 Mar 2026 17:16:59 +0530
In-Reply-To: <4442aca3ca4745748a7f181189bd16b2b345428e.camel@ibm.com>
References: <20260228122305.1406308-1-shardul.b@mpiricsoftware.com>
	 <20260228122305.1406308-3-shardul.b@mpiricsoftware.com>
	 <4442aca3ca4745748a7f181189bd16b2b345428e.camel@ibm.com>
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
X-Rspamd-Queue-Id: 4DAF023823E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mpiricsoftware.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mpiricsoftware.com:s=mpiric];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79764-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mpiric.us,mpiricsoftware.com,syzkaller.appspotmail.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[mpiricsoftware.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAzLTAyIGF0IDIzOjQ1ICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6Cj4gT24gU2F0LCAyMDI2LTAyLTI4IGF0IDE3OjUzICswNTMwLCBTaGFyZHVsIEJhbmthciB3
cm90ZToKPiA+IGRpZmYgLS1naXQgYS9mcy9oZnNwbHVzL2J0cmVlLmMgYi9mcy9oZnNwbHVzL2J0
cmVlLmMKPiA+IGluZGV4IDg3NjUwZTIzY2Q2NS4uZWUxZWRiMDNhMzhlIDEwMDY0NAo+ID4gLS0t
IGEvZnMvaGZzcGx1cy9idHJlZS5jCj4gPiArKysgYi9mcy9oZnNwbHVzL2J0cmVlLmMKPiA+IEBA
IC0yMzksMTUgKzIzOSwzMSBAQCBzdGF0aWMgaW50IGhmc19ibWFwX2NsZWFyX2JpdChzdHJ1Y3QK
PiA+IGhmc19ibm9kZSAqbm9kZSwgdTMyIGJpdF9pZHgpCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0
dXJuIDA7Cj4gPiDCoH0KPiA+IMKgCj4gPiArc3RhdGljIGNvbnN0IGNoYXIgKmhmc19idHJlZV9u
YW1lKHUzMiBjbmlkKQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqDCoHN0YXRpYyBjb25zdCBjaGFy
ICogY29uc3QgdHJlZV9uYW1lc1tdID0gewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoFtIRlNQTFVTX0VYVF9DTklEXSA9ICJFeHRlbnRzIiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBbSEZTUExVU19DQVRfQ05JRF0gPSAiQ2F0YWxvZyIsCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgW0hGU1BMVVNfQVRUUl9DTklEXSA9ICJBdHRyaWJ1dGVz
IiwKPiA+ICvCoMKgwqDCoMKgwqDCoH07Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoY25p
ZCA8IEFSUkFZX1NJWkUodHJlZV9uYW1lcykgJiYgdHJlZV9uYW1lc1tjbmlkXSkKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gdHJlZV9uYW1lc1tjbmlkXTsKPiA+ICsK
PiAKPiAjZGVmaW5lIEhGU19QT1JfQ05JRMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDHCoMKgwqDC
oMKgwqDCoC8qIFBhcmVudCBPZiB0aGUgUm9vdCAqLwo+ICNkZWZpbmUgSEZTUExVU19QT1JfQ05J
RMKgwqDCoMKgwqDCoMKgwqBIRlNfUE9SX0NOSUQKPiAjZGVmaW5lIEhGU19ST09UX0NOSUTCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgMsKgwqDCoMKgwqDCoMKgLyogUk9PVCBkaXJlY3RvcnkgKi8KPiAj
ZGVmaW5lIEhGU1BMVVNfUk9PVF9DTklEwqDCoMKgwqDCoMKgwqBIRlNfUk9PVF9DTklECj4gI2Rl
ZmluZSBIRlNfRVhUX0NOSUTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAzwqDCoMKgwqDCoMKgwqAv
KiBFWFRlbnRzIEItdHJlZSAqLwo+ICNkZWZpbmUgSEZTUExVU19FWFRfQ05JRMKgwqDCoMKgwqDC
oMKgwqBIRlNfRVhUX0NOSUQKPiAjZGVmaW5lIEhGU19DQVRfQ05JRMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoDTCoMKgwqDCoMKgwqDCoC8qIENBVGFsb2cgQi10cmVlICovCj4gI2RlZmluZSBIRlNQ
TFVTX0NBVF9DTklEwqDCoMKgwqDCoMKgwqDCoEhGU19DQVRfQ05JRAo+ICNkZWZpbmUgSEZTX0JB
RF9DTklEwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgNcKgwqDCoMKgwqDCoMKgLyogQkFEIGJsb2Nr
cyBmaWxlICovCj4gI2RlZmluZSBIRlNQTFVTX0JBRF9DTklEwqDCoMKgwqDCoMKgwqDCoEhGU19C
QURfQ05JRAo+ICNkZWZpbmUgSEZTX0FMTE9DX0NOSUTCoMKgwqDCoMKgwqDCoMKgwqDCoDbCoMKg
wqDCoMKgwqDCoC8qIEFMTE9DYXRpb24gZmlsZSAoSEZTKykgKi8KPiAjZGVmaW5lIEhGU1BMVVNf
QUxMT0NfQ05JRMKgwqDCoMKgwqDCoEhGU19BTExPQ19DTklECj4gI2RlZmluZSBIRlNfU1RBUlRf
Q05JRMKgwqDCoMKgwqDCoMKgwqDCoMKgN8KgwqDCoMKgwqDCoMKgLyogU1RBUlR1cCBmaWxlIChI
RlMrKSAqLwo+ICNkZWZpbmUgSEZTUExVU19TVEFSVF9DTklEwqDCoMKgwqDCoMKgSEZTX1NUQVJU
X0NOSUQKPiAjZGVmaW5lIEhGU19BVFRSX0NOSUTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgOMKgwqDC
oMKgwqDCoMKgLyogQVRUUmlidXRlcyBmaWxlIChIRlMrKSAqLwo+ICNkZWZpbmUgSEZTUExVU19B
VFRSX0NOSUTCoMKgwqDCoMKgwqDCoEhGU19BVFRSX0NOSUQKPiAjZGVmaW5lIEhGU19FWENIX0NO
SUTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMTXCoMKgwqDCoMKgwqAvKiBFeGNoYW5nZUZpbGVzIHRl
bXAgaWQgKi8KPiAjZGVmaW5lIEhGU1BMVVNfRVhDSF9DTklEwqDCoMKgwqDCoMKgwqBIRlNfRVhD
SF9DTklECj4gI2RlZmluZSBIRlNfRklSU1RVU0VSX0NOSUTCoMKgwqDCoMKgwqAxNsKgwqDCoMKg
wqDCoC8qIGZpcnN0IGF2YWlsYWJsZSB1c2VyIGlkICovCj4gI2RlZmluZSBIRlNQTFVTX0ZJUlNU
VVNFUl9DTklEwqDCoEhGU19GSVJTVFVTRVJfQ05JRAo+IAo+IFdoYXQgaWYgY25pZCB3aWxsIGJl
IDEsIDIsIDU/IEhvdyBjb3JyZWN0bHkgd2lsbCBsb2dpYyB3b3Jrcz8gRm9yIG1heQo+IHRhc3Rl
LCB0aGUKPiBkZWNsYXJhdGlvbiBsb29rcyBzbGlnaHRseSBkYW5nZXJvdXMuCj4gCj4gSXQgd2ls
bCBtdWNoIGVhc2llciBzaW1wbHkgaW50cm9kdWNlIHRoZSBzdHJpbmcgY29uc3RhbnRzOgo+IAo+
ICNkZWZpbmUgSEZTX0VYVEVOVF9UUkVFX05BTUXCoCAiRXh0ZW50cyIKPiAuLi4KPiAjZGVmaW5l
IEhGU19VTktOT1dOX0JUUkVFX05BTUXCoCAiVW5rbm93biIKPiAKPiBQcm9iYWJseSwgc2ltcGxl
IHN3aXRjaCB3aWxsIGJlIHNpbXBsZXIgaW1wbGVtZW50YXRpb24gaGVyZToKPiAKPiBzd2l0Y2gg
KGNuaWQpIHsKPiBjYXNlIEhGU1BMVVNfRVhUX0NOSUQ6Cj4gwqDCoMKgIHJldHVybiBIRlNfRVhU
RU5UX1RSRUVfTkFNRTsKPiAuLi4KPiBkZWZhdWx0Ogo+IMKgwqDCoCByZXR1cm4gSEZTX1VOS05P
V05fQlRSRUVfTkFNRTsKPiB9Cj4gCj4gT3IgaXQgbmVlZHMgdG8gaW50cm9kdWNlIGFycmF5IHRo
YXQgd2lsbCBpbml0aWFsaXplIGFsbCBpdGVtcyBmcm9tIDAKPiAtIDE1Lgo+IAo+IE1heWJlLCBJ
IGFtIHRvbyBwaWNreSBoZXJlLiBUaGlzIGxvZ2ljIHNob3VsZCB3b3JrLiBCdXQgSSBwcmVmZXIg
dG8KPiBoYXZlIHN0cmluZwo+IGRlY2xhcmF0aW9ucyBvdXRzaWRlIG9mIGZ1bmN0aW9uLgo+IAoK
SSBvcmlnaW5hbGx5IHVzZWQgdGhlIGFycmF5IGJhc2VkIG9uIHlvdXIgZmVlZGJhY2sgZnJvbSB0
aGUgdjQgcmV2aWV3LAp3aGVyZSB5b3UgbWVudGlvbmVkIHByZWZlcnJpbmcgYW4gYXJyYXkgb2Yg
Y29uc3RhbnQgc3RyaW5ncyBvdmVyIGEKc3dpdGNoIHN0YXRlbWVudC4KClRvIGFkZHJlc3MgeW91
ciBjb25jZXJuIGFib3V0IHVubGlzdGVkIGluZGljZXMgbGlrZSAxLCAyLCBhbmQgNTogSQp0ZXN0
ZWQgdGhpcyBjYXNlIGxvY2FsbHkgdG8gYmUgYWJzb2x1dGVseSBzdXJlLiBCZWNhdXNlIG9mIGhv
dyB0aGUKY29tcGlsZXIgaW5pdGlhbGl6ZXMgYXJyYXlzLCBhbnkgaW5kZXggbm90IGV4cGxpY2l0
bHkgZGVmaW5lZCBpcyBzZXQgdG8KTlVMTCAoMCkuIEZvciBleGFtcGxlLCBJIHRlbXBvcmFyaWx5
IHJlbW92ZWQgSEZTUExVU19DQVRfQ05JRCBmcm9tIHRoZQphcnJheSBhbmQgdHJpZ2dlcmVkIHRo
ZSBidWcuIFRoZSBpZiAodHJlZV9uYW1lc1tjbmlkXSkgY29uZGl0aW9uCnN1Y2Nlc3NmdWxseSBj
YXVnaHQgdGhlIE5VTEwgYW5kIHRoZSBrZXJuZWwgc2FmZWx5IGxvZ2dlZDoKaGZzcGx1czogKGxv
b3AwKTogVW5rbm93biBCdHJlZSAoY25pZCAweDQpIGJpdG1hcCBjb3JydXB0aW9uCmRldGVjdGVk
Li4uCgpUaGF0IGJlaW5nIHNhaWQsIEkgYWdyZWUgdGhhdCBkZWZpbmluZyB0aGUgc3RyaW5ncyBh
cyBtYWNyb3Mgb3V0c2lkZQp0aGUgZnVuY3Rpb24gY29tYmluZWQgd2l0aCBhIHN0YW5kYXJkIHN3
aXRjaCBzdGF0ZW1lbnQgbWFrZXMgdGhlCmRlZmluaXRpb25zIG11Y2ggbW9yZSB2aXNpYmxlIHRv
IHRoZSByZXN0IG9mIHRoZSBzdWJzeXN0ZW0uIEkgYW0gbW9yZQp0aGFuIGhhcHB5IHRvIHJld3Jp
dGUgaXQgdXNpbmcgdGhlICNkZWZpbmUgYW5kIHN3aXRjaCBhcHByb2FjaCBleGFjdGx5CmFzIHlv
dSBzdWdnZXN0ZWQgZm9yIHY2LiBMZXQgbWUga25vdyB3aGljaCBhcHByb2FjaCB5b3UgcHJlZmVy
LgoKVGhhbmtzLApTaGFyZHVsCg==


