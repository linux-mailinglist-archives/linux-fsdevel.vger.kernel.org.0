Return-Path: <linux-fsdevel+bounces-79685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TIrSLzjcq2mehQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 09:05:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5E922AB52
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 09:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8919300F1AE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 08:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA3C376BE1;
	Sat,  7 Mar 2026 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="IXkrqWVt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35800285066
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772870709; cv=none; b=ahz1DYqOOPYRMCUa27r8Llib6Uzss5qLgpdShLnjHYnm2wV1WIloVEoZm5dYHf0V4fonHH7ihRrSLR/fLQZgdKXWORb7wL7Ca4A83QX32u2Fh0lJ32ZxFQ0qg2D2ghJ3zKaYJVlTgUnIEMe47JulPrIMpI6TiOGz8+l0T/Ce13E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772870709; c=relaxed/simple;
	bh=p/oQf7OAnEmY7GI/8p20hllVLt8N2QfpfBVusiMjt4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yo2TO8r+UYW8K6kC+1pOUB4CpnC0Vs13dlhNk7RSaAgV0DfZ+WPGHMmJ9i3qCFKUiv6AS2B5etu2YHa/P1YiZ1kqh8T6SgS+EsQmv7waec/5ofs+GPx7Mika9d/ERTPh2Fww7Lw4ZUYpfm/cU1EKlL56Z9oQtqhZcCyuJa4DSrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=IXkrqWVt; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 80B2D1D490;
	Sat,  7 Mar 2026 08:05:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 80B2D1D490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1772870701; bh=p/oQf7OAnEmY7GI/8p20hllVLt8N2QfpfBVusiMjt4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IXkrqWVt73/hUJ7jaIbwQxNmsd71U0mrcYPPPyFhNNEpgJaBzjGrXW/gRIPycAMqY
	 Wz+t3PEva/ssrfGPtz5UINU1sIK9IutqJbRogD6aD6NkvTUCqfDGJIAzF2dnwLVFcu
	 pflR7zkMfzrPyfupTp/J7INTmikAd8cACqUA44so=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id QtUMCizcq2m/1AIA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sat, 07 Mar 2026 08:05:00 +0000
Message-ID: <72446d20-f3ae-4acc-86cc-bd8fa3d86f41@dev.snart.me>
Date: Sat, 7 Mar 2026 17:04:53 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] exfat: EXFAT_IOC_GET_VALID_DATA ioctl
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>
References: <CAKYAXd_8vG6V0NRT_kb76n_yo+d9vvcx6JZbMARC5+C1ovboqw@mail.gmail.com>
 <20260304141713.533168-1-dxdt@dev.snart.me>
 <20260304141713.533168-2-dxdt@dev.snart.me>
 <CAKYAXd_RiCKF1nJK_Jg385VeGxeOUo08s0a_SNgtty2508wDmg@mail.gmail.com>
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
In-Reply-To: <CAKYAXd_RiCKF1nJK_Jg385VeGxeOUo08s0a_SNgtty2508wDmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2B5E922AB52
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[dev.snart.me,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[dev.snart.me:s=00];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dev.snart.me:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79685-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dxdt@dev.snart.me,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.960];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lwn.net:url,dev.snart.me:dkim,dev.snart.me:mid]
X-Rspamd-Action: no action

> What do you think about having its own
> dedicated magic number (e.g., EXFAT_IOCTL_MAGIC : 0xEF) for
> exFAT-specific extensions?
Absolutely. I was expecting this discusstion about the ioctl magic.

https://lwn.net/Articles/897202/

My intuition was that the 16-bit namespace is already quite crowded
hence my initial decision to add to the existing FAT magic. If the new
magic could be afforded, that's definitely the right way forward.
However, the ioctl namespace is becoming a scarce commodity in Linux.
(ex)FAT is a simple filesystem by design, so there's not a whole lot to
it. Perhaps it doesn't really deserve its own ioctl magic. I'd like to
leave it up to the skillful maintainers.

FYI, the room to grow(TODO) for exFAT/NTFS on my list include(somewhat
related to the topic, not in particular order):

1. FIEMAP support for 512-bytes-per-sector flash memory drives with
capacities over 2TB(512 * 2^32). Don't worry - exFAT works fine with 4k
advanced format and > 2TB 512B LBA. This is only for filefrag report
2. VDL in NTFS. Although different in on-disk format, the behaviour
apparent to userspace is identical (share the ioctl?)
3. exFAT/NTFS fs-level encryption(EFS, similar to Ext4 encryption) which
may require a set of ioctls for key management - if allowed, that is(EFS
could be patent/licence protected)
4. bad cluster tagging(offline or online) and some ioctl facilities to
query info about bad clusters

I'd say, exFAT and NTFS specs are designed maintained by the same
organisation and that often leads to new filesystem features ending up
similar or almost identical. So, yes, assign a new magic but maybe share
it between exFAT and NTFS, if that doesn't break any rules I'm not aware of.

Davo

