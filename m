Return-Path: <linux-fsdevel+bounces-60004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA45B40ACE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 18:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7DCD207599
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 16:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AE5320A1C;
	Tue,  2 Sep 2025 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gotplt.org header.i=@gotplt.org header.b="YAen422m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1463331CA5F
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831171; cv=pass; b=LAvhFmZpuDZh6ska5sZkPgiHBCtbaNE/JgkH0kSAU2PaTJQ1Kx3ZIwAQraoNAEtoB3S/xiexWIL8QRUfJlYvQszUPulOT5Pgq/21lyt5vi9IJBGm0FZSdJvwpFdwRWGwuja/dfBA+s+v3vgf9ZMKBZlNh7dwRgBtoG+3N4o0CQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831171; c=relaxed/simple;
	bh=1DqA0w/5+D00ICXK11993TmMzqKx66Pq191XTGAbTYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nroXJ+fOOjXiCvZfNr83q9S1iLOa2dgTAUtEm9+s5J4almBTsYIkmA/DVG6sXIyQKbtiOZIEDx4PjPBMjloltzP2IXdrV/qMBqy4AwQzEUW8On++JawSxGkZDUhqCa/XmRt/JsYiTrhD+hJBYFJjbGbwFXVgwoMBC1tUMp/W+68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gotplt.org; spf=pass smtp.mailfrom=gotplt.org; dkim=pass (2048-bit key) header.d=gotplt.org header.i=@gotplt.org header.b=YAen422m; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gotplt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7E3208A2F25;
	Tue,  2 Sep 2025 16:39:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (100-101-146-44.trex-nlb.outbound.svc.cluster.local [100.101.146.44])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 203848A5941;
	Tue,  2 Sep 2025 16:39:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1756831162; a=rsa-sha256;
	cv=none;
	b=Gvqs4P/kow2s1GsGATqMaDFCnI/wLM4b+N4fX8ZKN2sgm/ib0Q6PBE9GYgBuT1jlGVxcjX
	pkqTUoizkiD+yp8cNRZS2qUNp7nI1auO5wGZQQ348sgboTWdS6j3tfMHLSrAqgf+/aQKAg
	58qZ1F4rdJh2OJkcSl/q+jzQAzhT9x3ljTWwh6Kgk4Oyw8tADuSBQWYuESVz0HzTU2T5jS
	ezPnj5isQihJNxseKxI4NM/xUf35rTTXN/zAtiSznc6TrI3U+41oHootZ5R90a3MseIdDM
	ocV8+zSh8WaevXQSuFf3GJnZ3+n8eX2GYMILK5Yg+0nI/GSqGd6hiF1ht8VlZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1756831162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=N8FdcJfj23kTOh+ESM/CmROX6cIACvGQj908hUKEmW4=;
	b=iOtZN7Nj052hc7fZyqLJXlwKp4/pFJ3WFyZMWHt8PO5xWLygsF92TF9+ZbX9+tF1iTfKxe
	y7GQRaJaMcUuxHl1uClePwdDonArl0YTYlhxBm3qidRkkOY6B7SaDFe7OHHRWk3EesW9/H
	ozRtjPqwV1V6qKvhVvlXekS7LTXNMwfJd1DcV0/uUdz4pR7Pr039alUOgN+XmX4FbmeFhV
	75A70PoFEIw/fcPTCBCppzuvWl1sJHDQ8Q9ipzdAwR/GtkQiGFVkK/XZS85evR0Ts8D4or
	+mIBit/Vw49emutM186EQEzekJtRlw1tvLTog4mx+TTVYUc2ix8c2e77gxugFQ==
ARC-Authentication-Results: i=1;
	rspamd-77486b5f64-54lng;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Left-Drop: 5ea7d9132bf8c3e8_1756831162392_3024158319
X-MC-Loop-Signature: 1756831162392:2510259285
X-MC-Ingress-Time: 1756831162392
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.146.44 (trex/7.1.3);
	Tue, 02 Sep 2025 16:39:22 +0000
Received: from [192.168.0.135] (unknown [38.23.181.90])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: siddhesh@gotplt.org)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4cGWfd2VmfzDF;
	Tue,  2 Sep 2025 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
	s=dreamhost; t=1756831162;
	bh=N8FdcJfj23kTOh+ESM/CmROX6cIACvGQj908hUKEmW4=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=YAen422meEfoHkBXgWgdZEyhxCqDXFPHCIDcKFLa5YM+iLWbq9x0ykQJ8pDeEUgOp
	 OxOIot9G4XFv9GI1i0UEgTGhTVWzrQlUWf1TA1mUwb7cAmwhIHnbcR4vnxSzdIq6RJ
	 17Kmawj0TFHkty7L4HDblLzjG4bkh/b+af60Dy9fBD/MmLWP8jvIRSJTmMk5J4v1Qc
	 sHq2Wz5QO/sAP3ZdnKuQQMg/GrrGnEiXROg9aVttmedVN7zjW98ZXrEIziV1GDVKl5
	 I66TPy7IGF870+Qw3CSh12TK9P35v+cP/N1Ik0QECkB6TR0QctEAwTghXA2OxgS4ep
	 Zp4t9Q22FBbiQ==
Message-ID: <28c931f8-27fb-4ee3-bae9-60a85be10501@gotplt.org>
Date: Tue, 2 Sep 2025 12:39:20 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] does # really need to be escaped in devnames?
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 jack@suse.cz, Ian Kent <raven@themaw.net>,
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
References: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk>
 <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV>
 <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
 <20250829060306.GC39973@ZenIV> <20250829060522.GB659926@ZenIV>
 <20250829-achthundert-kollabieren-ee721905a753@brauner>
 <20250829163717.GD39973@ZenIV> <20250830043624.GE39973@ZenIV>
 <20250830073325.GF39973@ZenIV>
 <CAHk-=wiSNJ4yBYoLoMgF1M2VRrGfjqJZzem=RAjKhK8W=KohzQ@mail.gmail.com>
 <ed70bad5-c1a8-409f-981e-5ca7678a3f08@gotplt.org>
 <CAHk-=whb6Jpj-w4GKkY2XccG2DQ4a2thSH=bVNXhbTG8-V+FSQ@mail.gmail.com>
Content-Language: en-US
From: Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <CAHk-=whb6Jpj-w4GKkY2XccG2DQ4a2thSH=bVNXhbTG8-V+FSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-02 12:30, Linus Torvalds wrote:
> On Tue, 2 Sept 2025 at 08:03, Siddhesh Poyarekar <siddhesh@gotplt.org> wrote:
>>
>> This was actually the original issue I had tried to address, escaping
>> '#' in the beginning of the devname because it ends up in the beginning
>> of the line, thus masking out the entire line in mounts.  I don't
>> remember at what point I concluded that escaping '#' always was the
>> answer (maybe to protect against any future instances where userspace
>> ends up ignoring the rest of the line following the '#'), but it appears
>> to be wrong.
> 
> I wonder if instead of escaping hash-marks we could just disallow them
> as the first character in devname.
> 
> How did this issue with hash-marks get found? Is there some real use -
> in which case we obviously can't disallow them - or was this from some
> fuzzing test that happened to hit it?

The original issue was that devname being blank broke parsing of mounts, 
which was fixed with Ian's patch[1].  While debugging that issue I 
stumbled onto the fact that if the devname started with #, it would make 
the mount invisible to getmntent in glibc, since it ignores lines 
starting with #.

Sid

[1] https://lkml.org/lkml/2022/6/17/27

