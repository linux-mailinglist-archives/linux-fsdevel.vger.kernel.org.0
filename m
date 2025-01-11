Return-Path: <linux-fsdevel+bounces-38944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9A7A0A235
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 10:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42303A5CFF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 09:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269E1188734;
	Sat, 11 Jan 2025 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="WICqlTsz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3776517E472;
	Sat, 11 Jan 2025 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736587076; cv=none; b=f/jmVlnH7ph3RUvIOc5in6kv7fAtpxl+mqKd/VC16dOaudoRLF0Vl8yKjTv2LWTvr/pqwsOYTl+8A+VI9uSpSXZvowQFVil7G4TFAemmQ4dL3Bga9+U6LyfYNcaw0yrHB/R+j7QRdEDtTpL1SZc1geAjLBuZw3vEDHzPCMUJ5Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736587076; c=relaxed/simple;
	bh=ixqMGuuKFDVNMkNVmpMMIAyYeVMfV812g+GglJjKRMQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=i6XW0gkbtRpDnbSRdFBoa5Yt3xfukZsEgSMtn/rWSf4NaweuNxs4oYS9dwTvFvakRzJ3Ds0pd6lAmSp1juBhx1UKxf00It2LoIfRR62qJjYFSImadSO/GlkAmAuBkUDfS62jWZCI21Dx69N27nLIXqcr0IieVCQ69JCJLEFgzOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=WICqlTsz; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1736587072; x=1737191872; i=aros@gmx.com;
	bh=0y9kdtvsjN5QHpBk4RhAs/eZpN4T+QK1R+Puzd/4g7g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WICqlTszBdlQqrIMgNpJOrpBqqchEd0ITTwzjjqpWpE0C9AFoIX4wFK6rMwrmwq8
	 lxFUqJFogg+9cmFi0R1O/tZuONjqSSVayTv2d8GUAPVcTTNAvWbxYe7b44AInzbJg
	 D3Xing1ZD+lEDWjJRDeeaFsaxtdPfJ0d6CjblQTvuSoqUF50gyaqW3NEoursranfS
	 iENRntXPwlUF+OcfPuiN+ftKtpUmpRfybg0OxqOxInZoE3DTzo++wd4znia+h2bln
	 WEtWZa3lcQUgpabFnuv7SikjIYap7EBHf2IeY+PFDe4oQSW4HPGGn1AZlbDzxqvT0
	 WUs8+rCIoJqOnGBVaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.21.12.20] ([98.159.234.22]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8QS8-1tavL5460O-00946i; Sat, 11
 Jan 2025 10:17:52 +0100
Message-ID: <ba4f3df5-027b-405e-8e6e-a3630f7eef93@gmx.com>
Date: Sat, 11 Jan 2025 09:17:49 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Artem S. Tashkinov" <aros@gmx.com>
Subject: Spooling large metadata updates / Proposal for a new API/feature in
 the Linux Kernel (VFS/Filesystems):
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RGbUu9CrQIfjPyXoPO1KUQxhTsdIH+FL8Q4hehWvybdESw/MAcb
 z7SRzbNI4NT7hTo9aZEoymYCg1O7F1M6B20bDwDl5ko/gFrj+9CiagfrX7MaIrErD4htVN+
 VaqeXNfgqjNNWmI+1sdh8Hx48eidcd5i7yXjWoa6vvfdz0bR9r6l/yVSPB/lr0egloTBbjK
 SWeos+GQDJO3ZbIN654Zg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:azeKCnXdfOY=;Xg3mtGC1dBQamf77bylMhLreqYz
 S+s7IgZoddiIjYktAVMjDO4oUJP++JgcU33pADvvKJFoBN6Ih4DCiDrAE31nYmkw4HWdtiLiM
 xwL7xSYbB4HeD+KpIAr0XWyGeSZ2ORQwHunlwCSvrBXzdab/PCRgUopGrWBPG/nuCK5duSiyo
 T9oIWUkhF9oS/btYvlS4NA+5EgdhdAZ0LxgWwnqOC1bUUmO5TTpgzeqJmR6WQ1P5RR76bGbVb
 0T3icRwl3DKxj6aovCqQhA0zbcvTDJC2j5eQPL4H8LOUnnfujmvyLoStsuKXrpSZwJokT5ZTI
 CsPEg/BRqy5OEVMMqQAtLAsvAFDFXYYgifwd3uAUt5LeJPckgXaQUDXcEub6XAzSIbZJSe5ir
 bF0xRlXDMi+8yZWtQdGqYkMWN0l+dn8VorSwZ0Hjexols0MM9SlelGpqHTZBv82nQY5cgXypg
 TFImQYDDa1ZeJM3F9GiYAvMnDjRDAuQoiOI9VzWNqYsxecnoR6QBAwJLJporOUuEsg5mqL87d
 n4vQeRZJRIgLsicVvMGCobKhUBjpFdeUKIZamSz2Ae0hbl8OgoigldX61rCtqIRLs2FRrYkGV
 CVWjHQUKhV6MFIGln/Vh9/KoCLtK3vHrocFW+anIUB6o2LT0jVM3Hc6DWf7jc/0cX0tmt1B4z
 mMO5tS4ut5K3oxRbkXJOKY01SWoO77gz6YTEvG/fgpjrmahvaHqDku7v+PrfHqcQNGGgo9w9s
 HeeYg4Ln/jZ4unxXdhkVo0p58L9TqCQ6MvEoZpIpw/FTZsOEJWxQ0uCpCJ3jI6yXAbSV1TVE/
 JRCFBNu9abiq1+3pLFaxpvlM6bCzYC26+uW2F7c5+5wsi5lJ4ZyZt4Ji5Az9k7AzvgppHtXNt
 TZORKpOsFa6nSIdlCQL7nliaKUcQdwUgg7Lde64s7Vqa3tXa2R2utOIoxX2/rqdAtkP/e4Qvv
 41bFOWqqh6TlLYNWLrsGtawgl5chlUatIIpTzqeW4O08fOwb23RqEYzzeYTRH6+JkyBaECZpf
 MZ7pjaENLMwkp1FChgah6IXWnkQc9OwWXvxpx3a8kf9rJqCv2Gp0/dkds4KiNUZpATgJUr7wU
 QwxgNvBkFzlsN1Z7KuW68KJ9Kl3JaW

Hello,

I had this idea on 2021-11-07, then I thought it was wrong/stupid, now
I've asked AI and it said it was actually not bad, so I'm bringing it
forward now:

Imagine the following scenarios:

  * You need to delete tens of thousands of files.
  * You need to change the permissions, ownership, or security context
(chmod, chown, chcon) for tens of thousands of files.
  * You need to update timestamps for tens of thousands of files.

All these operations are currently relatively slow because they are
executed sequentially, generating significant I/O overhead.

What if these operations could be spooled and performed as a single
transaction? By bundling metadata updates into one atomic operation,
such tasks could become near-instant or significantly faster. This would
also reduce the number of writes, leading to less wear and tear on
storage devices.

Does this idea make sense? If it already exists, or if there=E2=80=99s a r=
eason
it wouldn=E2=80=99t work, please let me know.


Best regards,
Artem

