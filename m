Return-Path: <linux-fsdevel+bounces-40158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A39EBA1DD96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 21:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78DB1886C2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 20:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62066198A38;
	Mon, 27 Jan 2025 20:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l1f1C9g3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6292918E756;
	Mon, 27 Jan 2025 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738011173; cv=none; b=q6RBbV6mOKQz3RjQfZxacvetM2G/FDaRlb39FXmp3epcDDhgTj/ggNYSaK7V3nnRpPF6QfiR1t/IQRk3y/IJBqngXQjC+VVlDmCWEMrs/6OTWNVyaXkIGydRogSiHY94qzhY//SYd23xhhe9I0mIO0nqUKDtt0bIW5ZwRvonUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738011173; c=relaxed/simple;
	bh=T51EV7oWtnzeq2xUVL424UiG8rTTRLgv2HL6D6q2fg0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=AH73B91tiyv31JPQ19Zn4GTRML36SkXKY2477S66/gfQHHQEKPSvHM61RAn/j89uFMgEcO7uAbkW/RExrfSjdhqOIMV6Wqbh8FAhMPtgJmS8uy6QCMnFsPOljeMRVJCi/3l8fp0VJIfXbgfO5T2Kf0dNql0+FE+kU/nLbqVxrMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l1f1C9g3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738011171; x=1769547171;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=T51EV7oWtnzeq2xUVL424UiG8rTTRLgv2HL6D6q2fg0=;
  b=l1f1C9g3xQIoFhUmcleZIRSRP4o03lY/f6Ek6k1BTVKans+U/5Fmvc3B
   j4BxDLpBjLXh5WXlX6NjX85pmhhe1RGbpdANHQddvlRdOS0TqES03VU+a
   t4HrkFHb/CklCAWolWgpS6y3FJdLLvsGRMF2l2ufTxZNVLU3iJYlGktHT
   suIe+UmwhNoY94lJH0SNRciCnND699ik3ndS2AZvdg+ECpZH2/8wgp+b1
   ReGDQoFilJv7HFrXbh/mj8i3syHc0iAsBR8qIV8Z3bsCAci3n8HMzV09Q
   4jon+Qf0h+Cqf1m27lDWyZ0uAm8H38vtn2fLxup6PR7oZfiw92UkZPI8H
   w==;
X-CSE-ConnectionGUID: ASdK+v0CQ66oyOzNqh78tA==
X-CSE-MsgGUID: 69Y0RLAQTomRDAk4aeSuKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="37689169"
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="37689169"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 12:52:50 -0800
X-CSE-ConnectionGUID: fSZ43H5NSki9tZzVVNYLYQ==
X-CSE-MsgGUID: K1yFmy9oRuaIYHLaSbiIEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="108348881"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.220.126]) ([10.124.220.126])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 12:52:50 -0800
Content-Type: multipart/mixed; boundary="------------0TEcSh69VAAa8CV0XmvFTA5D"
Message-ID: <76b80fff-0f62-4708-95e6-87de272f35a5@intel.com>
Date: Mon, 27 Jan 2025 12:52:51 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: use private version of page_zero_new_buffers() for
 data=journal mode
To: Mateusz Guzik <mjguzik@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
 akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
References: <20151007154303.GC24678@thunk.org>
 <1444363269-25956-1-git-send-email-tytso@mit.edu>
 <yxyuijjfd6yknryji2q64j3keq2ygw6ca6fs5jwyolklzvo45s@4u63qqqyosy2>
 <CAHk-=wigdcg+FtWm5Fds5M2P_7GKSfXxpk-m9jkx0C6FMCJ_Jw@mail.gmail.com>
 <CAGudoHGJah8VNm6V1pZo2-C0P-y6aUbjMedp1SeAGwwDLua2OQ@mail.gmail.com>
 <CAHk-=wh=UVTC1ayTBTksd+mWiuA+pgLq75Ude2++ybAoSZAX3g@mail.gmail.com>
 <CAGudoHHyEQ1swCJkFDicb8hYYSMCXyMUcRVrtWkbeYwSChCmpQ@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CAGudoHHyEQ1swCJkFDicb8hYYSMCXyMUcRVrtWkbeYwSChCmpQ@mail.gmail.com>

This is a multi-part message in MIME format.
--------------0TEcSh69VAAa8CV0XmvFTA5D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/25 14:45, Mateusz Guzik wrote:
>>
>> So if you don't get around to it, and _if_ I remember this when the
>> merge window is open, I might do it in my local tree, but then it will
>> end up being too late for this merge window.
>>
> The to-be-unreverted change was written by Dave (cc'ed).
> 
> I had a brief chat with him on irc, he said he is going to submit an
> updated patch.

I poked at it a bit today. There's obviously been the page=>folio churn
and also iov_iter_fault_in_readable() got renamed and got some slightly
new semantics.

Additionally, I'm doubting the explicit pagefault_disable(). The
original patch did this:

+      pagefault_disable();
       copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
+      pagefault_enable();

and the modern generic_perform_write() is using:

       copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);

But the "atomic" copy is using kmap_atomic() internally which has a
built-in pagefault_disable(). It wouldn't be super atomic if it were
handling page faults of course.

So I don't think generic_perform_write() needs to do its own
pagefault_disable().

I actually still had the original decade-old test case sitting around
compiled on my test box. It still triggers the issue and _will_ livelock
if fault_in_iov_iter_readable() isn't called somewhere.

Anyway, here's a patch that compiles, boots and doesn't immediately fall
over on ext4 in case anyone else wants to poke at it. I'll do a real
changelog, SoB, etc.... and send it out for real tomorrow if it holds up.
--------------0TEcSh69VAAa8CV0XmvFTA5D
Content-Type: text/x-patch; charset=UTF-8;
 name="generic_perform_write-1.patch"
Content-Disposition: attachment; filename="generic_perform_write-1.patch"
Content-Transfer-Encoding: base64

CmluZGV4IDRmNDc2NDExYTlhMmQuLjk4YjM3ZTRjNmQ0M2MgMTAwNjQ0CgotLS0KCiBiL21t
L2ZpbGVtYXAuYyB8ICAgMjUgKysrKysrKysrKysrKystLS0tLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtcHVOIG1t
L2ZpbGVtYXAuY35nZW5lcmljX3BlcmZvcm1fd3JpdGUtMSBtbS9maWxlbWFwLmMKLS0tIGEv
bW0vZmlsZW1hcC5jfmdlbmVyaWNfcGVyZm9ybV93cml0ZS0xCTIwMjUtMDEtMjcgMDk6NTM6
MTMuMjE5MTIwOTY5IC0wODAwCisrKyBiL21tL2ZpbGVtYXAuYwkyMDI1LTAxLTI3IDEyOjI4
OjQwLjMzMzkyMDQzNCAtMDgwMApAQCAtNDAyNywxNyArNDAyNyw2IEBAIHJldHJ5OgogCQli
eXRlcyA9IG1pbihjaHVuayAtIG9mZnNldCwgYnl0ZXMpOwogCQliYWxhbmNlX2RpcnR5X3Bh
Z2VzX3JhdGVsaW1pdGVkKG1hcHBpbmcpOwogCi0JCS8qCi0JCSAqIEJyaW5nIGluIHRoZSB1
c2VyIHBhZ2UgdGhhdCB3ZSB3aWxsIGNvcHkgZnJvbSBfZmlyc3RfLgotCQkgKiBPdGhlcndp
c2UgdGhlcmUncyBhIG5hc3R5IGRlYWRsb2NrIG9uIGNvcHlpbmcgZnJvbSB0aGUKLQkJICog
c2FtZSBwYWdlIGFzIHdlJ3JlIHdyaXRpbmcgdG8sIHdpdGhvdXQgaXQgYmVpbmcgbWFya2Vk
Ci0JCSAqIHVwLXRvLWRhdGUuCi0JCSAqLwotCQlpZiAodW5saWtlbHkoZmF1bHRfaW5faW92
X2l0ZXJfcmVhZGFibGUoaSwgYnl0ZXMpID09IGJ5dGVzKSkgewotCQkJc3RhdHVzID0gLUVG
QVVMVDsKLQkJCWJyZWFrOwotCQl9Ci0KIAkJaWYgKGZhdGFsX3NpZ25hbF9wZW5kaW5nKGN1
cnJlbnQpKSB7CiAJCQlzdGF0dXMgPSAtRUlOVFI7CiAJCQlicmVhazsKQEAgLTQwNTUsNiAr
NDA0NCwxMSBAQCByZXRyeToKIAkJaWYgKG1hcHBpbmdfd3JpdGFibHlfbWFwcGVkKG1hcHBp
bmcpKQogCQkJZmx1c2hfZGNhY2hlX2ZvbGlvKGZvbGlvKTsKIAorCQkvKgorCQkgKiBUaGlz
IG5lZWRzIHRvIGJlIGF0b21pYyBiZWNhdXNlIGFjdHVhbGx5IGhhbmRsaW5nIHBhZ2UKKwkJ
ICogZmF1bHRzIG9uICdpJyBjYW4gZGVhZGxvY2sgaWYgdGhlIGNvcHkgdGFyZ2V0cyBhCisJ
CSAqIHVzZXJzcGFjZSBtYXBwaW5nIG9mICdmb2xpbycuCisJCSAqLwogCQljb3BpZWQgPSBj
b3B5X2ZvbGlvX2Zyb21faXRlcl9hdG9taWMoZm9saW8sIG9mZnNldCwgYnl0ZXMsIGkpOwog
CQlmbHVzaF9kY2FjaGVfZm9saW8oZm9saW8pOwogCkBAIC00MDgwLDYgKzQwNzQsMTUgQEAg
cmV0cnk6CiAJCQkJYnl0ZXMgPSBjb3BpZWQ7CiAJCQkJZ290byByZXRyeTsKIAkJCX0KKwkJ
CS8qCisJCQkgKiAnZm9saW8nIGlzIG5vdyB1bmxvY2tlZCBhbmQgZmF1bHRzIG9uIGl0IGNh
biBiZQorCQkJICogaGFuZGxlZC4gRW5zdXJlIGZvcndhcmQgcHJvZ3Jlc3MgYnkgdHJ5aW5n
IHRvCisJCQkgKiBmYXVsdCBpdCBpbiBub3cuCisJCQkgKi8KKyAgICAgICAgICAgICAgICAg
ICAgICAgIGlmIChmYXVsdF9pbl9pb3ZfaXRlcl9yZWFkYWJsZShpLCBieXRlcykgPT0gYnl0
ZXMpIHsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzID0gLUVGQVVM
VDsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7CisgICAgICAgICAg
ICAgICAgICAgICAgICB9CiAJCX0gZWxzZSB7CiAJCQlwb3MgKz0gc3RhdHVzOwogCQkJd3Jp
dHRlbiArPSBzdGF0dXM7Cl8K

--------------0TEcSh69VAAa8CV0XmvFTA5D--

