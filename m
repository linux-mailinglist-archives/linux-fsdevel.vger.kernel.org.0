Return-Path: <linux-fsdevel+bounces-77790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAGUMAdJmGk6FQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 12:44:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 848D9167578
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 12:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCC6130333E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 11:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF5C341650;
	Fri, 20 Feb 2026 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yal/v/0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2417D33F8C6
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771587838; cv=none; b=IQj9OsKXplHgzDPpQ1qLhjT2yR0QFBsFuqZ0xucTlOwxfVIbrGKl/GgSd+RnRM/KANLDUDy2xziDoBq1RaDc4i1vbai93Wwv60TekuvgBcL0LZKr4LFrIaL5QCyRnBRGG56l5NJU1hGTjbsmgoQyyTfAkIQtW4izgV5zLcJ1uU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771587838; c=relaxed/simple;
	bh=wBX6cnPwCpCSH4iNWjZA4c3kEfk5E/AuDIwwlVfhzyo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J9c8ABqunuCTGqaq/bjhFCsARt+E1NWtq6dAKxmOFaEHxYc6P63XDPFyJjktT140QZMgpFbTZ6I26K6HYLkjleMe6w+R6uJmGPlHJ5d7gp2w5HomOuXQK8B3pnHttH6a9suiw06ugWdLIma/OEZFU5OXcNAy5h6BRe8JiUU1OpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yal/v/0j; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43638a3330dso1676807f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 03:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771587835; x=1772192635; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wBX6cnPwCpCSH4iNWjZA4c3kEfk5E/AuDIwwlVfhzyo=;
        b=Yal/v/0jQhM5+l2jIqgauYveEuUrKLvkqMrKR8HlT7yS06pxHGNDp5XYOxQQ4dIfBb
         NUcU4UJ2rELzwf3YZkdz3okIJT+nK8y+kxAAYXeu2UtbMXNLy6TP053mOWFH566ovnko
         2ODtiaTNkbycAn23FF6xVoeLfB1va4T5E6nuJbXNJRn0jSinWcrfFHdDjQRvbjOsYEeO
         DVZtk3NWFEi5tHoK28wCF5mnDgvgjzZ5Hiv1ObhXnJbDd8By0HGiPW5AXPIZrh2YXE1P
         BEC4MYUkz/TG30BobMPa/fDTpjzCsDLxXeydP3bLc8x5+VEigtPrXUo+4Oe/OUYhcgXZ
         bMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771587835; x=1772192635;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBX6cnPwCpCSH4iNWjZA4c3kEfk5E/AuDIwwlVfhzyo=;
        b=bZEbqFcF2pW9L9vMoJEzQy+8jcdoPUQYnK23Vn7qLaei+ndt8uNbCtdlZl8zcoEvu6
         ocp7HRqRiDfW0mKddx9MJwMS4EFL5IzCcF4rQoSgYS6uhbdUlfgdaWTPtYPjLK2aDjyc
         qqpnF51xieZY98sDaQgDbazCaUqy4EB1uzoVzOtTsRrSFOfVe7DxevDXLZ/qNtbmKP0f
         +UIYyjoXR8ohXu60V7BupqxMfwXrc8P8KIZ6GOXE16TB5HHkShikOlmEDytjyPGnvXDY
         e0ZKMRl6CUJi5b1jgrmI3bgRXtWOm1wFZB0rap1Ahzew2xZs/lIyaSElM9GUEMQv9ION
         OQLA==
X-Forwarded-Encrypted: i=1; AJvYcCV8QczmM3SmSjJCGvwjVteNWrhTn19JgYXol75x90/SbWCgAworm35MmxTY2jYyVDJBXL9idhSIzjHovsB9@vger.kernel.org
X-Gm-Message-State: AOJu0YxaX66XvsQ0wJmz7UiDtzWPAvWAiNO1iqXw3GXdnnq5I90aMgss
	HS1NozGq6ae+s6BK2VEbUc0gEMAlYpDi6gcn54yYSOM2asIstMEKo2o0p54ORbNZ/HQ=
X-Gm-Gg: AZuq6aK4gQQmwViIZPXppOOi/W5/H1b8FuzRrErF+4XYIyQBX+Za//EVThEvC/O5Ijw
	sQp9sxvaawv4/d9qLn88ord9K/8vVvOLdnWCH2I/HfhqPggqbcTcpijIgqhlHF7qYMygffXgIZ4
	b4cPr5YAF7b426mI/6Tumb03knzjDtopR8JsDFHBf0B1w2gbNHFQWyOW49oFIO4nqQRseMGXk7x
	MsqMXR0Ok6wsD1H5oHkOeAI29ZGZLTwaRGoMnbNMUY1pFg07v9ljPeXixCyvhBGvpgDI7RP+sPM
	f4xDZXuN7mU/pt9Xw3UvyBMN82sdUMncUzSafdUc3mOF0RqUGVnbauAHq9iZCDASxy09OcVs2Vq
	gDhzjwFIv6DH/1y9reRpxtvx9slFN2B0sIzANKfKuX1/+MOYN219khSY3R3ALON9nOdl6t8Fgps
	RKXUMPJ08B1JOS6c0qwnXf2cB+VGyASlkgDc9FrVSKv6v/6+hmHwJ9+co45ZTwDg==
X-Received: by 2002:a5d:5f93:0:b0:435:e060:8071 with SMTP id ffacd0b85a97d-4379db61767mr35206496f8f.16.1771587835206;
        Fri, 20 Feb 2026 03:43:55 -0800 (PST)
Received: from ?IPv6:2804:5078:822:3100:58f2:fc97:371f:2? ([2804:5078:822:3100:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5d156sm60289350f8f.5.2026.02.20.03.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 03:43:54 -0800 (PST)
Message-ID: <f074138f16e49e9966512cce2c07724ae9a77975.camel@suse.com>
Subject: Re: [PATCH 00/19] printk cleanup - part 3
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov	
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson	 <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, Petr Mladek	 <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, John Ogness	 <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>,  Jiri Slaby <jirislaby@kernel.org>,
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook	
 <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"	
 <gpiccoli@igalia.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy	 <christophe.leroy@csgroup.eu>, Andreas Larsson
 <andreas@gaisler.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue	
 <alexandre.torgue@foss.st.com>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Date: Fri, 20 Feb 2026 08:43:42 -0300
In-Reply-To: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.58.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77790-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nod.at,cambridgegreys.com,sipsolutions.net,linuxfoundation.org,windriver.com,kernel.org,chromium.org,suse.com,goodmis.org,linutronix.de,debian.org,lunn.ch,davemloft.net,google.com,redhat.com,linux-m68k.org,intel.com,igalia.com,linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,gaisler.com,linux.intel.com,foss.st.com,nuvoton.com,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mpdesouza@suse.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[linux-fsdevel,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 848D9167578
X-Rspamd-Action: no action

T24gU2F0LCAyMDI1LTEyLTI3IGF0IDA5OjE2IC0wMzAwLCBNYXJjb3MgUGF1bG8gZGUgU291emEg
d3JvdGU6Cj4gVGhlIHBhcnRzIDEgYW5kIDIgY2FuIGJlIGZvdW5kIGhlcmUgWzFdIGFuZCBoZXJl
WzJdLgo+IAo+IFRoZSBjaGFuZ2VzIHByb3Bvc2VkIGluIHRoaXMgcGFydCAzIGFyZSBtb3N0bHkg
dG8gY2xhcmlmeSB0aGUgdXNhZ2UKPiBvZgo+IHRoZSBpbnRlcmZhY2VzIGZvciBOQkNPTiwgYW5k
IHVzZSB0aGUgcHJpbnRrIGhlbHBlcnMgbW9yZSBicm9hZGx5Lgo+IEJlc2lkZXMgaXQsIGl0IGFs
c28gaW50cm9kdWNlcyBhIG5ldyB3YXkgdG8gcmVnaXN0ZXIgY29uc29sZXMKPiBhbmQgZHJvcCB0
aGVzIHRoZSBDT05fRU5BQkxFRCBmbGFnLiBJdCBzZWVtcyB0b28gbXVjaCwgYnV0IGluIHJlYWxp
dHkKPiB0aGUgY2hhbmdlcyBhcmUgbm90IGNvbXBsZXgsIGFuZCBhcyB0aGUgdGl0bGUgc2F5cywg
aXQncyBiYXNpY2FsbHkgYQo+IGNsZWFudXAgd2l0aG91dCBjaGFuZ2luZyB0aGUgZnVuY3Rpb25h
bCBjaGFuZ2VzLgo+IAo+IFRoaXMgcGF0Y2hzZXQgaW5jbHVkZXMgYSBwYXRjaCBmcm9tIHBhcnQg
MiB0aGF0IG5lZWRlZCBtb3JlIHdvcmsgWzNdLAo+IGFzCj4gc3VnZ2VzdGVkIGJ5IFBldHIgTWxh
ZGVrLgo+IAo+IFRoZXNlIGNoYW5nZXMgd2VyZSB0ZXN0ZWQgYnkgcmV2ZXJ0aW5nIGY3OWIxNjNj
NDIzMQo+ICgiUmV2ZXJ0ICJzZXJpYWw6IDgyNTA6IFN3aXRjaCB0byBuYmNvbiBjb25zb2xlIiIp
LCBhbmQgdXNlZCBxZW11IHRvCj4gdGVzdAo+IHN1c3BlbmQvcmVzdW1lIGN5Y2xlcywgYW5kIGV2
ZXJ5dGhpbmcgd29ya2VkIGFzIGV4cGVjdGVkLgo+IAo+IFBTOiBiNCAtLWF1dG8tdG8tY2MgYWRk
ZWQgYSBidW5jaCBvZiBwZW9wbGUgYXMgQ0MsIHNvIEknbSBub3Qgc3VyZSBpZgo+IEkgc2hvdWxk
IHJlbW92ZSBzb21lIG9yIG5vdCwgc28gSSdtIGxlYXZpbmcgdGhlIGxpc3QgYXMgaXQgaXMuIElm
IHRoZQo+IHBhdGNoc2V0IG5lZWRzIGEgdjIsIGFuZCB5b3UgZmVlbCB0aGF0IHlvdSBkb24ndCBu
ZWVkIHRvIGNvcGllZCwganVzdAo+IGxldCBtZSBrbm93Lgo+IAo+IFRoYW5rcyBmb3IgY2hlY2tp
bmcgdGhlIHBhdGNoZXMsIGFuZCBoYXBweSBob2xpZGF5cyEKPiAKPiBbMV06Cj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC8yMDI1MDIyNi1wcmludGstcmVuYW1pbmctdjEtMC0wYjg3ODU3
N2YyZTZAc3VzZS5jb20vI3QKPiBbMl06Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
c2VyaWFsLzIwMjUxMTIxLXByaW50ay1jbGVhbnVwLXBhcnQyLXYyLTAtNTdiOGI3ODY0N2Y0QHN1
c2UuY29tLwo+IFszXToKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1zZXJpYWwvYVNn
ZXFNM0RXdlI4LWNNWUBwYXRod2F5LnN1c2UuY3ovCj4gCj4gU2lnbmVkLW9mZi1ieTogTWFyY29z
IFBhdWxvIGRlIFNvdXphIDxtcGRlc291emFAc3VzZS5jb20+Cj4gLS0tCj4gTWFyY29zIFBhdWxv
IGRlIFNvdXphICgxOSk6Cj4gwqDCoMKgwqDCoCBwcmludGsvbmJjb246IFVzZSBhbiBlbnVtIHRv
IHNwZWNpZnkgdGhlIHJlcXVpcmVkIGNhbGxiYWNrIGluCj4gY29uc29sZV9pc191c2FibGUoKQo+
IMKgwqDCoMKgwqAgcHJpbnRrOiBJbnRyb2R1Y2UgY29uc29sZV9pc19uYmNvbgo+IMKgwqDCoMKg
wqAgcHJpbnRrOiBEcm9wIGZsYWdzIGFyZ3VtZW50IGZyb20gY29uc29sZV9pc191c2FibGUKPiDC
oMKgwqDCoMKgIHByaW50azogUmVpbnRyb2R1Y2UgY29uc29sZXNfc3VzcGVuZGVkIGdsb2JhbCBz
dGF0ZQo+IMKgwqDCoMKgwqAgcHJpbnRrOiBBZGQgbW9yZSBjb250ZXh0IHRvIHN1c3BlbmQvcmVz
dW1lIGZ1bmN0aW9ucwo+IMKgwqDCoMKgwqAgcHJpbnRrOiBJbnRyb2R1Y2UgcmVnaXN0ZXJfY29u
c29sZV9mb3JjZQo+IMKgwqDCoMKgwqAgZHJpdmVyczogbmV0Y29uc29sZTogTWlncmF0ZSB0byBy
ZWdpc3Rlcl9jb25zb2xlX2ZvcmNlIGhlbHBlcgo+IMKgwqDCoMKgwqAgZGVidWc6IGRlYnVnX2Nv
cmU6IE1pZ3JhdGUgdG8gcmVnaXN0ZXJfY29uc29sZV9mb3JjZSBoZWxwZXIKPiDCoMKgwqDCoMKg
IG02OGs6IGVtdTogbmZjb24uYzogTWlncmF0ZSB0byByZWdpc3Rlcl9jb25zb2xlX2ZvcmNlIGhl
bHBlcgo+IMKgwqDCoMKgwqAgZnM6IHBzdG9yZTogcGxhdGZvcm06IE1pZ3JhdGUgdG8gcmVnaXN0
ZXJfY29uc29sZV9mb3JjZSBoZWxwZXIKPiDCoMKgwqDCoMKgIHBvd2VycGM6IGtlcm5lbDogdWRi
ZzogTWlncmF0ZSB0byByZWdpc3Rlcl9jb25zb2xlX2ZvcmNlIGhlbHBlcgo+IMKgwqDCoMKgwqAg
c3BhcmM6IGtlcm5lbDogYnRleHQ6IE1pZ3JhdGUgdG8gcmVnaXN0ZXJfY29uc29sZV9mb3JjZSBo
ZWxwZXIKPiDCoMKgwqDCoMKgIHVtOiBkcml2ZXJzOiBtY29uc29sZV9rZXJuLmM6IE1pZ3JhdGUg
dG8gcmVnaXN0ZXJfY29uc29sZV9mb3JjZQo+IGhlbHBlcgo+IMKgwqDCoMKgwqAgZHJpdmVyczog
aHd0cmFjaW5nOiBzdG06IGNvbnNvbGUuYzogTWlncmF0ZSB0bwo+IHJlZ2lzdGVyX2NvbnNvbGVf
Zm9yY2UgaGVscGVyCj4gwqDCoMKgwqDCoCBkcml2ZXJzOiB0dHk6IHNlcmlhbDogbXV4LmM6IE1p
Z3JhdGUgdG8gcmVnaXN0ZXJfY29uc29sZV9mb3JjZQo+IGhlbHBlcgo+IMKgwqDCoMKgwqAgZHJp
dmVyczogdHR5OiBzZXJpYWw6IG1hMzVkMV9zZXJpYWw6IE1pZ3JhdGUgdG8KPiByZWdpc3Rlcl9j
b25zb2xlX2ZvcmNlIGhlbHBlcgo+IMKgwqDCoMKgwqAgZHJpdmVyczogdHR5OiBlaHZfYnl0ZWNo
YW46IE1pZ3JhdGUgdG8gcmVnaXN0ZXJfY29uc29sZV9mb3JjZQo+IGhlbHBlcgo+IMKgwqDCoMKg
wqAgZHJpdmVyczogYnJhaWxsZTogY29uc29sZTogRHJvcCBDT05fRU5BQkxFRCBjb25zb2xlIGZs
YWcKPiDCoMKgwqDCoMKgIHByaW50azogUmVtb3ZlIENPTl9FTkFCTEVEIGZsYWcKPiAKPiDCoGFy
Y2gvbTY4ay9lbXUvbmZjb24uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgwqAgNSArLQo+IMKgYXJjaC9wb3dlcnBjL2tlcm5lbC91ZGJnLmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNCArLQo+IMKg
YXJjaC9zcGFyYy9rZXJuZWwvYnRleHQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoMKgIDQgKy0KPiDCoGFyY2gvdW0vZHJpdmVycy9tY29uc29sZV9rZXJu
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAzICstCj4gwqBhcmNoL3Vt
L2tlcm5lbC9rbXNnX2R1bXAuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqDCoCAyICstCj4gwqBkcml2ZXJzL2FjY2Vzc2liaWxpdHkvYnJhaWxsZS9icmFpbGxl
X2NvbnNvbGUuYyB8wqDCoCAxIC0KPiDCoGRyaXZlcnMvaHd0cmFjaW5nL3N0bS9jb25zb2xlLmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA0ICstCj4gwqBkcml2ZXJzL25l
dC9uZXRjb25zb2xlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCAxMyArLS0KPiDCoGRyaXZlcnMvdHR5L2Vodl9ieXRlY2hhbi5jwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDQgKy0KPiDCoGRyaXZlcnMvdHR5
L3NlcmlhbC9tYTM1ZDFfc2VyaWFsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA0
ICstCj4gwqBkcml2ZXJzL3R0eS9zZXJpYWwvbXV4LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDQgKy0KPiDCoGRyaXZlcnMvdHR5L3R0eV9pby5j
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgIDYgKy0KPiDCoGZzL3Byb2MvY29uc29sZXMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSAtCj4gwqBmcy9wc3RvcmUv
cGxhdGZvcm0uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqDCoCA2ICstCj4gwqBpbmNsdWRlL2xpbnV4L2NvbnNvbGUuaMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE0Mwo+ICsrKysrKysrKysr
KysrKysrKystLS0tLQo+IMKga2VybmVsL2RlYnVnL2RlYnVnX2NvcmUuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDYgKy0KPiDCoGtlcm5lbC9kZWJ1
Zy9rZGIva2RiX2lvLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqDCoCA2ICstCj4gwqBrZXJuZWwvcHJpbnRrL25iY29uLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxNyArLS0KPiDCoGtlcm5lbC9w
cmludGsvcHJpbnRrLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8IDE0MCArKysrKysrKysrKystLQo+IC0tLS0tLS0tLQo+IMKgMTkgZmlsZXMgY2hh
bmdlZCwgMjMwIGluc2VydGlvbnMoKyksIDE0MyBkZWxldGlvbnMoLSkKClRoaXMgcGF0Y2hzZXQs
IHdpdGhvdXQgdGhlIHJlY2VudCBjbGVhbnVwIGZyb20gUGV0ciBNbGFkZWsgWzFdLCBoYXMgYQpy
ZWdyZXNzaW9uLiBJJ2xsIHdhaXQgZm9yIGl0IHRvIGJlIG1lcmdlZCBmaXJzdCBiZWZvcmUgc2Vu
ZGluZyBhIG5ldwp2ZXJzaW9uIG9mIHRoaXMgcGF0Y2hzZXQuIFRoYW5rcyBmb3IgYWxsIHRoZSBy
ZXZpZXdzIQoKWzFdOgpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjYwMjA2MTY1MDAy
LjQ5NjcyNC0xLXBtbGFkZWtAc3VzZS5jb20vCgo+IC0tLQo+IGJhc2UtY29tbWl0OiA5M2Q2NTU4
NzQ3OWNmYzk3YzBkN2U0MWI1ZThjNjM3OGNhNjgxNjMyCj4gY2hhbmdlLWlkOiAyMDI1MTIwMi1w
cmludGstY2xlYW51cC1wYXJ0My1lYTExNmIxMWIzYTYKPiAKPiBCZXN0IHJlZ2FyZHMsCj4gLS3C
oCAKPiBNYXJjb3MgUGF1bG8gZGUgU291emEgPG1wZGVzb3V6YUBzdXNlLmNvbT4K


