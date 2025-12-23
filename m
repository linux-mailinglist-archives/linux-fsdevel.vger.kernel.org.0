Return-Path: <linux-fsdevel+bounces-71990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A73CDA617
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 20:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 533383027DA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A7934A3B0;
	Tue, 23 Dec 2025 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="auKpKh/z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F03043BE
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766518857; cv=none; b=ozMbZnPIBJv5qPjHH9f2WAczXrotMLurmR+x399JxX3sBcApbzVREM2eW+ZAd/tYZ/bZ8nGYT3RQVPPSHDbixX6cOTIGRPagBwBNEO+uB/QPs0dhJ0RmdOiW1ruMWIsHzKr2D9ePZ8fgZvHmH2MVBMuv+Fyj2eJm8iHhlAB0ujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766518857; c=relaxed/simple;
	bh=Xx3euzo8JsWpM4HuNB4iypu06/3WVjD3FDfG04EVXxY=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=DNGCp3c/hhbfDCubJFiHPL626i10TOg6VCOnPdohOFqJiSEEUMWKhEcoR/p39R67gJHQSRhN4nk24CRoWmfCqGfGiMFMtXEt7bPXIexUnprHorB+6RgJ7+0RI8LO3n6t/Zsjf75d+K/xUGMeSpvnNZnTnFb9ruloaCia7HJZErE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=auKpKh/z; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 5D1A43C02486F;
	Tue, 23 Dec 2025 11:40:49 -0800 (PST)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id aeTpBgZkgPI2; Tue, 23 Dec 2025 11:40:49 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 331CB3C0275C4;
	Tue, 23 Dec 2025 11:40:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 331CB3C0275C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1766518849;
	bh=h+GHcq9d2k1qyAwEc7ywNQzuIIkIukwHxJD3c5WJc6M=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=auKpKh/zFOIb3zbz/qGk+Rkb9XOKIscUCRQ01FI9YABnpw3es4CcjeAJ6AlDfXz/6
	 AVngYeKvdXkle8dWekqzyzXI5k48arTijRNcMc94EfOloeUfpLHYHlqRBGDsro8851
	 Jsppgl68MTbKnmka0ouRMDRBdyjs0lgGvTjra9IgbYlKsLFFwo8yhM8UVshgs1isnt
	 N6M8JmWzXcxvwEFODr1TW+coFcPwV3HP/e+Hh7Bsdu4MPDayofME/O0JmFcKL2m5yS
	 Z0P6CrtxkkLyGZM0S/tnd9bA2qPiSSZJCu5fCRaqlcPgt9mXkBDibGETbb+xlQ21Xq
	 9v6z4H3/z61lw==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id E2KYPiVH8sFn; Tue, 23 Dec 2025 11:40:49 -0800 (PST)
Received: from penguin.cs.ucla.edu (47-154-25-30.fdr01.snmn.ca.ip.frontiernet.net [47.154.25.30])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id 06E153C02486F;
	Tue, 23 Dec 2025 11:40:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------ysP6xHvxw38w0XT34ZMGNeUx"
Message-ID: <7e74a2c1-3053-4c2a-b1de-967d3d4f58a1@cs.ucla.edu>
Date: Tue, 23 Dec 2025 11:40:48 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cat: adjust the maximum data copied by copy_file_range
To: Matteo Croce <technoboy85@gmail.com>
Cc: Collin Funk <collin.funk1@gmail.com>, coreutils@gnu.org,
 =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigbrady.com>,
 linux-fsdevel@vger.kernel.org
References: <CAFnufp2ZD5u6pp84xtTcZKqQWtmtwN8n_d7-9UpqoUJUsEwwAA@mail.gmail.com>
 <87345fxayu.fsf@gmail.com> <8cd912f2-587b-45ff-a3aa-951272f1f538@cs.ucla.edu>
 <CAFnufp0zMe04Hh41-z6Yi8RTc0gZ7i74F6zRBDqOS5k9DZu2TQ@mail.gmail.com>
 <dabc0311-8872-4744-89ec-82a3170880b1@draigBrady.com>
 <CAFnufp35pGf6SDYRxf8YW17tdT0sTTXt_SXnPjpdWtg4ndojZA@mail.gmail.com>
 <4b3d3a05-09db-4a6a-80e2-8d6131d56366@cs.ucla.edu>
 <CAFnufp26+PnkY2OM=5NMvxDxrBf3F=FfoKBU8e0XVu4im6ZU0g@mail.gmail.com>
 <6831a0c6-baa1-4fbb-b021-4de4026922ab@cs.ucla.edu>
 <CAFnufp1z=-BfUVEX+wiiv+Y5f-fGbzBTZYwwhXM7VFGxAQLexQ@mail.gmail.com>
 <1a8636a8-bc53-4bb8-9ecb-677c0514efa2@cs.ucla.edu>
 <CAFnufp072=wSfU4TUY7DcymJCqY5VYw2dqxt=OAY3Op3zZwEpw@mail.gmail.com>
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <CAFnufp072=wSfU4TUY7DcymJCqY5VYw2dqxt=OAY3Op3zZwEpw@mail.gmail.com>

This is a multi-part message in MIME format.
--------------ysP6xHvxw38w0XT34ZMGNeUx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-22 17:28, Matteo Croce wrote:

> Where in cat.c the code avoids the overflow? I see:
> 
> ssize_t copy_max = MIN (SSIZE_MAX, SIZE_MAX) >> 30 << 30;
> 
> which should evaluate to 0x7FFFFFFFC0000000

Oh, I might be mistaken here. I was looking at my experimental copy of 
coreutils, which has some changes/fixes in this area.

> also strace says:
> 
> $ strace -e copy_file_range cat /etc/fstab >fstab
> copy_file_range(3, NULL, 1, NULL, 9223372035781033984, 0) = 568
> copy_file_range(3, NULL, 1, NULL, 9223372035781033984, 0) = 0
> +++ exited with 0 +++

Those particular copy_file_range calls don't tickle the kernel bug, as 
the files are at offset 0. But you're right, you can probably tickle the 
kernel bug in other uses.

> Yes, the kernel bug has to be fixed, of course.
> Your patch doesn't compile due to an unmatched curly brace, I fixed it
> but it panics at boot, can you check if I preserved the correct logic?

No, but that's understandable as my patch was hopelessly munged. You can 
try the attached instead. (Notice that it does not fail with EOVERFLOW; 
either the requested area is valid or it's not.)
--------------ysP6xHvxw38w0XT34ZMGNeUx
Content-Type: text/x-patch; charset=UTF-8;
 name="rw_verify_area-overflow1.diff"
Content-Disposition: attachment; filename="rw_verify_area-overflow1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL3JlYWRfd3JpdGUuYyBiL2ZzL3JlYWRfd3JpdGUuYwppbmRleCA4
MzNiYWUwNjg3NzAuLjMyMmE4NzExNzQ1NSAxMDA2NDQKLS0tIGEvZnMvcmVhZF93cml0ZS5j
CisrKyBiL2ZzL3JlYWRfd3JpdGUuYwpAQCAtNDU5LDEzICs0NTksMTQgQEAgaW50IHJ3X3Zl
cmlmeV9hcmVhKGludCByZWFkX3dyaXRlLCBzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgbG9m
Zl90ICpwcG9zLCBzaXplX3QKIAlpZiAocHBvcykgewogCQlsb2ZmX3QgcG9zID0gKnBwb3M7
CiAKLQkJaWYgKHVubGlrZWx5KHBvcyA8IDApKSB7Ci0JCQlpZiAoIXVuc2lnbmVkX29mZnNl
dHMoZmlsZSkpCisJCWlmICh1bnNpZ25lZF9vZmZzZXRzKGZpbGUpKSB7CisJCQlpZiAoY2hl
Y2tfYWRkX292ZXJmbG93ICgodW9mZl90KSBwb3MsIGNvdW50LAorCQkJCQkJJih1b2ZmX3Qp
IHswfSkpCiAJCQkJcmV0dXJuIC1FSU5WQUw7Ci0JCQlpZiAoY291bnQgPj0gLXBvcykgLyog
Ym90aCB2YWx1ZXMgYXJlIGluIDAuLkxMT05HX01BWCAqLwotCQkJCXJldHVybiAtRU9WRVJG
TE9XOwotCQl9IGVsc2UgaWYgKHVubGlrZWx5KChsb2ZmX3QpIChwb3MgKyBjb3VudCkgPCAw
KSkgewotCQkJaWYgKCF1bnNpZ25lZF9vZmZzZXRzKGZpbGUpKQorCQl9IGVsc2UgeworCQkJ
aWYgKHVubGlrZWx5KHBvcyA8IDApKQorCQkJCXJldHVybiAtRUlOVkFMOworCQkJaWYgKGNo
ZWNrX2FkZF9vdmVyZmxvdyAocG9zLCBjb3VudCwgJihsb2ZmX3QpIHswfSkpCiAJCQkJcmV0
dXJuIC1FSU5WQUw7CiAJCX0KIAl9Cg==

--------------ysP6xHvxw38w0XT34ZMGNeUx--

