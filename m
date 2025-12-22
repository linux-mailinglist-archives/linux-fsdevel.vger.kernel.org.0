Return-Path: <linux-fsdevel+bounces-71834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C681CD6E85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 19:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 046A23028F6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 18:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229FD2F5492;
	Mon, 22 Dec 2025 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="Qe4SvWD8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08791E5207
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766429360; cv=none; b=QWrQB9PlK/8ZSFizl3YtC/8+g/JWcKomu/D0K4dKq6A849n/F/6PIcqFjED2EvYPjnMZ9StHCnmPWrFlUB1yBezb9WiugGhiU1oxOLy1gRCmhw0pZU96F3t8zZFrJiUWSg+JgW6jJoVGazurmYXSHfXvTlGccEvKOcn2SV2+A9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766429360; c=relaxed/simple;
	bh=34WAgTBs7oUHb7IC8gODm7AZRFN2dL9/w0lNN7ezjGc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=IQ2y4NCgNzqaqv1IQdHiyjanVdVW+jA4VGr1z+pJ3Quwj6D+762QvlbMh85ctM0HwpOeZVyFGUkgNdb1+YgEO+iqBElPC/l0Or1dFZIVOgNcMvcGHnlAe8R3JeQdhLOrh7tGARhNoNTw6GHkgDGy5R8tITzSq9zK8YdoGGlhvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=Qe4SvWD8; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id F13C13C014089;
	Mon, 22 Dec 2025 10:41:16 -0800 (PST)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id qIVzFfdb_oKF; Mon, 22 Dec 2025 10:41:16 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id C10DD3C01EBBA;
	Mon, 22 Dec 2025 10:41:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu C10DD3C01EBBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1766428876;
	bh=mk7FUg6bLZ9cQaAsPUFj6BySORxjskt3Gs80LOhU9Xk=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=Qe4SvWD8OGzBjjSgTu+GByfX4ZvLwEI7N1DzoN/S5zbWwnxEMtRp9OLNzpfznZR6a
	 w4XV+00AC9TkVofCVIUoHRjQ7lnjybcgrX8oU+0/BFmJi24NhBom84DNoNfUtNZmgF
	 43hwMw+JCmgWxeI/5c8Q5p6QKdjCKOZ+aC8Mc/qXoBtu50GGVlQBMcAhBBKbCiCiHC
	 VTib+2bqVB2cf6AF0v+O5wRCeBX2WWzFCJdKEpQKYmA4r+W66QkNgGoUCE11uBbXRv
	 PFEnjIvtDoYCD11OS49dTOapzOmF1R3M0789HpQmQP0BcqcgMt9PC/331zgBid+Pf5
	 JGHrbCkhIsaEA==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id sWDKB3OdaYza; Mon, 22 Dec 2025 10:41:16 -0800 (PST)
Received: from penguin.cs.ucla.edu (47-154-25-30.fdr01.snmn.ca.ip.frontiernet.net [47.154.25.30])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id 8FC213C014089;
	Mon, 22 Dec 2025 10:41:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------ha6o55AsdsB8QD7jgDHqz0kx"
Message-ID: <1a8636a8-bc53-4bb8-9ecb-677c0514efa2@cs.ucla.edu>
Date: Mon, 22 Dec 2025 10:41:16 -0800
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
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <CAFnufp1z=-BfUVEX+wiiv+Y5f-fGbzBTZYwwhXM7VFGxAQLexQ@mail.gmail.com>

This is a multi-part message in MIME format.
--------------ha6o55AsdsB8QD7jgDHqz0kx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[cc'ing linux-fsdevel@vger.kernel.org; this coreutils thread can be 
found in <https://lists.gnu.org/r/coreutils/2025-12/threads.html#00055>.]

On 2025-12-20 00:51, Matteo Croce wrote:
> This can be triggered with a huge file:
> 
> $ truncate -s $((2**63 - 1)) file1
> 
> $ ( dd bs=1M skip=$((2**43 - 2)) count=0 && cat ) < file1
> 0+0 records in
> 0+0 records out
> 0 bytes copied, 2,825e-05 s, 0,0 kB/s
> cat: -: Invalid argument
> 
> $ dd if=file1 bs=1M skip=$((2**43 - 2))
> dd: error reading 'file1': Invalid argument
> 1+0 records in
> 1+0 records out
> 1048576 bytes (1,0 MB, 1,0 MiB) copied, 0,103536 s, 10,1 MB/s

OK, but in bleeding-edge coreutils neither of these examples call 
copy_file_range. The diagnostics result from plain 'read' syscalls near 
TYPE_MAXIMUM (off_t). (dd never calls copy_file_range, and ironically 
the code in 'cat' that does call copy_file_range avoids the overflow 
itself, before invoking copy_file_range, and relies on plain 'read' to 
do the right thing near TYPE_MAXIMUM (off_t).) So these examples have 
nothing to do with copy_file_range.

You've found a Linux kernel bug that affects countless apps, and we 
can't reasonably expect app developers to patch all the apps to work 
around the bug. So the fix should be done in the kernel.

I looked at the kernel patch you suggested in 
<https://lore.kernel.org/linux-fsdevel/20251219125250.65245-1-teknoraver@meta.com/T/>. 
Unfortunately, I see two problems with it, the first minor, the second 
less so.

The minor problem is that the unpatched kernel code is merely 
incorrectly checking whether pos + count fits into loff_t. MAX_RW_COUNT 
should not be involved with the fix, as MAX_RW_COUNT is irrelevant to 
file offset range. Better would be to do correct overflow checks, with 
something like the attached patch (which I have not compiled or tested).

Second and more important, the patch doesn't fix the real bug which is 
that read(FD, BUF, SIZE) fails with -EINVAL if adding SIZE to the 
current file position would overflow off_t. That's wrong: the syscall 
should read whatever bytes are present (up to EOF), and then report the 
number of bytes read. We cannot fix this bug merely via something like 
the attached patch.

One possible fix for the second problem would be to change 
rw_verify_area's API to return the possibly-smaller number of bytes that 
can be read, and then modify its callers to do the right thing. 
("correct" in the sense of "don't try to read past TYPE_MAXIMUM 
(off_t)".) Alternatively, we could fix rw_verify_area's callers to not 
try to read past TYPE_MAXIMUM (off_t), without changing the API.
--------------ha6o55AsdsB8QD7jgDHqz0kx
Content-Type: text/x-patch; charset=UTF-8; name="rw_verify_area-overflow.diff"
Content-Disposition: attachment; filename="rw_verify_area-overflow.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL3JlYWRfd3JpdGUuYyBiL2ZzL3JlYWRfd3JpdGUuYwppbmRleCA4
MzNiYWUwNjg3NzAuLjIxNWQ3Y2RiYjFhYSAxMDA2NDQKLS0tIGEvZnMvcmVhZF93cml0ZS5j
CisrKyBiL2ZzL3JlYWRfd3JpdGUuYwpAQCAtNDU5LDEzICs0NTksMTcgQEAgaW50IHJ3X3Zl
cmlmeV9hcmVhKGludCByZWFkX3dyaXRlLCBzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgbG9m
Zl90ICpwcG9zLCBzaXplX3QKIAlpZiAocHBvcykgewogCQlsb2ZmX3QgcG9zID0gKnBwb3M7
CiAKLQkJaWYgKHVubGlrZWx5KHBvcyA8IDApKSB7CiAJCQlpZiAoIXVuc2lnbmVkX29mZnNl
dHMoZmlsZSkpCiAJCQkJcmV0dXJuIC1FSU5WQUw7Ci0JCQlpZiAoY291bnQgPj0gLXBvcykg
LyogYm90aCB2YWx1ZXMgYXJlIGluIDAuLkxMT05HX01BWCAqLwotCQkJCXJldHVybiAtRU9W
RVJGTE9XOwotCQl9IGVsc2UgaWYgKHVubGlrZWx5KChsb2ZmX3QpIChwb3MgKyBjb3VudCkg
PCAwKSkgewotCQkJaWYgKCF1bnNpZ25lZF9vZmZzZXRzKGZpbGUpKQorCQl9CisJCWlmICh1
bnNpZ25lZF9vZmZzZXRzKGZpbGUpKSB7CisJCQlpZiAoY2hlY2tfYWRkX292ZXJmbG93ICgo
dW9mZl90KSBwb3MsIGNvdW50LAorCQkJCQkJJih1b2ZmX3QpIHswfSkpCisJCQkJcmV0dXJu
IC1FSU5WQUw7CisJCX0gZWxzZSB7CisJCQlpZiAodW5saWtlbHkocG9zIDwgMCkpCisJCQkJ
cmV0dXJuIC1FSU5WQUw7CisJCQlpZiAoY2hlY2tfYWRkX292ZXJmbG93IChwb3MsIGNvdW50
LCAmKGxvZmZfdCkgezB9KSkKIAkJCQlyZXR1cm4gLUVJTlZBTDsKIAkJfQogCX0K

--------------ha6o55AsdsB8QD7jgDHqz0kx--

