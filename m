Return-Path: <linux-fsdevel+bounces-77712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ7MKpMTl2n7uAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 14:43:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3690C15F32B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 14:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CE7C305309C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DF733374F;
	Thu, 19 Feb 2026 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="L/wkYczO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF7233A70A
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771508513; cv=none; b=muIDSau514tACHAM06BkymP1zY7kXxhsbwvxkuTNMWP8QS2CmEQTlrYzU7RfMnavQB8qMjjg8h3oYm8NbKne//KUkjuO2FxR3L4luSUtnAiYOOUImcnBCVgKv69TmqU1zQ1u/9rf6IcpvGeBFeJIT49yzOqHQoSdU4R0u5hvVf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771508513; c=relaxed/simple;
	bh=+PHJREU1D0gwtdVNTv7mLIZ7ylBAXc/C0tnqE9Jgovg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAU5YZT6RuSHd9aLviXFm/1p39pXZkA88MiazuHRPf+jE5hUqmdCPozmyFxiSvYE8T53muk+P5uqP0L9tQ8TfBQrbls6MLUPU2X0ByUMuGuAkbLhukJbEj2e6mUc6BleHWD2vZoYzrEGYxAIOcNSE2OqTDu8k/5+AMa4VJi5i9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=L/wkYczO; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 0EA751D49A;
	Thu, 19 Feb 2026 13:41:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 0EA751D49A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1771508510; bh=+PHJREU1D0gwtdVNTv7mLIZ7ylBAXc/C0tnqE9Jgovg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L/wkYczOHH+xSCjNR3ffU/AxfjiFOXAHOkeCzVsomb07+/NcIJoxfs+6qRC6fXMLl
	 /LjKnqNN1cMg/Kh6fFbD2ZLU9ksBsK6Pa7F4gj+lR/jhHaRFqCWBtit8btoy3vjAHJ
	 ecZ7LM6ABESC30a3cn4t+aDF15GU5nrkB6lqX5Eo=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id tfKnLR0Tl2kGVgIA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Thu, 19 Feb 2026 13:41:49 +0000
Message-ID: <4555f7ec-5c52-497e-89db-e3278ddf0e5a@dev.snart.me>
Date: Thu, 19 Feb 2026 22:41:42 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exfat: add fallocate support
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>
References: <d0e5da23-90ed-4529-b919-11ae551611f3@dev.snart.me>
 <CAKYAXd-oj5Aa4rccp4iESFgoVUyPq2v+u=2m1AM8KQPpaZOOGg@mail.gmail.com>
 <8709a255-0c8e-40d8-ab75-b3ea974f5823@dev.snart.me>
 <CAKYAXd98fz=evAudpa8-GFhTfGbcLVioXFsO30pCKu_Q_ek8mg@mail.gmail.com>
From: David Timber <dxdt@dev.snart.me>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <CAKYAXd98fz=evAudpa8-GFhTfGbcLVioXFsO30pCKu_Q_ek8mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[dev.snart.me,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dev.snart.me:s=00];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dev.snart.me:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77712-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dxdt@dev.snart.me,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3690C15F32B
X-Rspamd-Action: no action

I think what you're implying is that FAT's KEEP_SIZE mode behavour was a
mistake which is a fair point. I can live with that. In fact, we've got
VDL so I get the point that it's unnecessary at this point. I know it's
not that simple because VDL is nowhere near a perfect solution for
implementing sparse files.

On 2/19/26 20:37, Namjae Jeon wrote:
> It is not that simple. In FAT, mode 0 seems to be hardly practical;
> the need to zero out preallocated clusters leads to significant
> latency. So the fallocate operation itself would be unnecessary
> without the keep size flag. Furthermore, I doubt we can easily remove
> it since there may already be applications relying on this. Unlike
> FAT, exFAT provides both data_size and valid_size, so there is no need
> to zero-out preallocated clusters in mode 0.
The current exfat implementation aleady exhibit such behaviour by
allowing up truncation. When truncating up, only the new clusters get
allocated to the node and the VDL(ValidDataLength) is unchanged. No
implicit zeroing out occurs until the application decides to lseek() to
skip over the VDL and do write(). As outlined in the pathed doc, this
operation cannot be cancelled - which makes it a caveat.

ftruncate(2):
> ERRORS
>
>        EPERM  The underlying filesystem does not support extending a file
>               beyond its current size.
>
> VERSIONS
>
>        The details in DESCRIPTION are for XSI-compliant systems.  For
>        non-XSI-compliant systems, the POSIX standard allows two behaviors
>        for ftruncate() when length exceeds the file length (note that
>        truncate() is not specified at all in such an environment): either
>        returning an error, or extending the file.  Like most UNIX
>        implementations, Linux follows the XSI requirement when dealing
>        with native filesystems.  However, some nonnative filesystems do
>        not permit truncate() and ftruncate() to be used to extend a file
>        beyond its current length: a notable example on Linux is VFAT.
exFAT does not give up with an error. If the latency was unacceptable,
this shouldn't have been allowed in the first place. I believe
applications that wishes to do explicit zeroing out usually choose to
use posix_fallocate() but don't quote me on that.

What I'm suggesting is that fallocate() should just mirror the current
behaviour of ftruncate() so that the applications that only expand the
contents of files sequentially can benefit from fast fallocate() that
the current exfat's use of VDL provides and quite possibly less
fragmentation.

