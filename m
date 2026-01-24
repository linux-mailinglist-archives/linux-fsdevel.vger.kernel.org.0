Return-Path: <linux-fsdevel+bounces-75330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SxFdOWYNdGly1wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:08:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9A87B977
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E921A3013EC3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43182AE8D;
	Sat, 24 Jan 2026 00:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GS73p9qk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CCAEADC
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 00:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769213281; cv=pass; b=BqQ7Ox/zWOApXFNT+7hBhI0aOx3BfJyh/9SSMk+puTzQYty+ujKWgvss4dNF/4spRuvo8tS0Gis0CA8wwaee/96KmheuvbkxPTfvKNZzBkWTw2DEXcUW6WM8jWg08Gpo4yYZEJ/j173tIZbpV+SM+OntNdSKwOSYNZyI8QD89Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769213281; c=relaxed/simple;
	bh=wSe7FuVJUHyRwwoVflyeXFFmY3WfXrs2ZcO7QxlO3W4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImetsfoHaKzIvlAx3MDNF5Yw7vyl+gilp/Zbd4cyfz8LPEScaATPhHgDJc/DsMMQD2Zh4LQATj0CNWrKN0MTTyHizB2Dl36TKHXjeHL5ON1J2SjwwflNHV1rAO2fW8m2COu5tk0PGTCrlIxCiTRS+z7Ab+tHdSoANcIxQfwlE2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GS73p9qk; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5664393d409so376519e0c.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 16:07:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769213279; cv=none;
        d=google.com; s=arc-20240605;
        b=Gc0wX2k1tzGPt9RlhZnySriUcoayQxvB8U0QMXPTv8mlyBfH/9tI4DpfIPrCN8p9os
         WrzdBWHc6lq7QICccZg/jF343ge7J6wz5cB7WYb+BTTalTo6LLVnlv3FiRdYENCbd1DP
         BejrvxFZ5zvZFJmmhMQhuDfYdLLS2zdrQa+V4L41yE6l6VEBPZQr9MpCRIhxme5updfp
         Zb0FvOmpGpVXHueC8VZfcicz0Oae0vd2uzLFgnsMAuuxcwFl4ZO3/gZNr/IPvXMJsor5
         2PN+byZrx+KR3PqyiQIv3chMWlb/sMvT/aUP21TvptJvjC3DorS5iXleMSi3+rV/6Lry
         s7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=/DNHlYn4p0TppVAhoBNqhHlPga7XxHNgUsUOejXrb08=;
        fh=nEl9GBPLvXHs6D6RySiFj+svC23ujPTVp9g0xpRLI80=;
        b=fgEwrP4FCQUjEaDVleNWV4/ykcvDU2Kb7zJUFNdKx3d1B5zI8Xehgvt/nncquj0O02
         3xV9vdVqSKkvraB6OIs4qBQjEAEPlxQwCdiui8FDiOmRp1z4omtlMAJQg/e+xCs898+g
         Lx4HLVDXlgonkIgekIQsvVE0L2UUotiQ+SNijgm5CE/yu4AiEzBkhM9FHcswMbBFHWn4
         flnr3k2rsMc6saL/93bq3kcK4n7+2mMl8mV3e51VIKmImhlCdq82AFcHWIV60avc/gsU
         eL3sEnnLcEwtJbrgyCj6ZpCJrusJbt7/5K2xp1CuPth87dL5t9tsLIkMxyPMB0iRHSe8
         KARQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769213279; x=1769818079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/DNHlYn4p0TppVAhoBNqhHlPga7XxHNgUsUOejXrb08=;
        b=GS73p9qk9k2uZbjNlfvSB0KZfJGIjLLaktV3kekj16d8bpOVuej/5YAGwMorScQAxB
         B4uQAeoqQm+rP8EY0ur48oVi5PJoEx7ggWP5E9KGA2iB2VrAhDeOsWQfi+dPM7QZULCj
         92MegSB+IFJuaqIA1oHe/b6vbnS/vJ0GsqsQmdIon0xy/OodDkZ7tQiOOVS2b67Mb8VC
         zT+pgRb75eapREX+VF1C6pJVuZTC++LTn9Qw/bFPLKesQHFZAZueB/SPin777/4zCzVQ
         +J6KltDANPJxKleiLkLnaC78cog/mfWJ78F7fvhEy8OE0iRe9YDBqVQNbKbDtfGqaisB
         37gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769213279; x=1769818079;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DNHlYn4p0TppVAhoBNqhHlPga7XxHNgUsUOejXrb08=;
        b=tgcz4DsrBznglk5eKhH/dsRnHbNihbvj9eL5yWGkcKhj1e+x1JSGw7wxjJq4vBN1rt
         D/D6/gjSLFlwVlSGoSNkWlsr4fmZe6AC5GIevTI1at8B6TA16ZfI7p6Y71n6loNbHzwM
         C7s4JQhqFfiZ+Y1rAtz3xhMEh+wektYQMpCESgNwNd1V+juFio3p6oEqkJ3xRlF16b7p
         MFJwPqGW6xS97KslAdpnzMRCt0eptY+ah3k4hFauImDMAETZ5tyeCNJ5QvVgMBmlj/Es
         6bAHRTXjp10A3bueWhvTevE3hiatCcbBPK+cm8WA1Xu0k0NyurBdMWkmGcWXWuXHNJ1/
         3oLw==
X-Forwarded-Encrypted: i=1; AJvYcCW1BSgw+MhDTVNnrhFTcbdq7gNbSbZ+2azCFTOSKHb2CKpKeFUehY7A7mqwjhjXPnr84uZAlKXu2cVt5t59@vger.kernel.org
X-Gm-Message-State: AOJu0YygHfU6irJPQVq2xXs3vLI5xG9qFxLV3O4W4ay56a0feHLcl4qU
	7OJIxEhMItM2rIygu7JyhxjFJn45zBreKK4H4j5dE0nNZ/dcODP79DsKQlwMv+HV2csEWAuDgS6
	cM8MbSVN8u0KC73p7KohmrIgiAjsJ4fo3B7aTKTqt
X-Gm-Gg: AZuq6aImJC9gAHnABT4385oL2c2vT164uodN94cw0uQiUqFv5DPfSTmMFZEpeyUel2U
	rwDo6osDcZuSLg2UgTWqlu68bRjGQSb+QXkp93OlSwzE2jmNDC93T4lob3wB9PhTCqB7eM/zGFP
	rvh9E6elTyIRNM/NBZt6UaRmjNYzfyxDcJqbNVnwsSCQ1giZC9Mzs/cGLCeWv/JD4xY4HmPwFL8
	TGGUFiuSIPaKWJ74T04OF3bde8O9pOF6hE3WV1oSrIotaCpHH8OeFVJgsjqCWiFFhSZhSXj9dB+
	pYgSgjFO99x9HmVhYsbHlGZBeA==
X-Received: by 2002:a05:6102:374b:b0:5f5:30e4:c8cd with SMTP id
 ada2fe7eead31-5f55874acd1mr847220137.42.1769213278639; Fri, 23 Jan 2026
 16:07:58 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Jan 2026 16:07:57 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Jan 2026 16:07:57 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
References: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 23 Jan 2026 16:07:57 -0800
X-Gm-Features: AZwV_QiZSx8uXBlkjUzf-XEIBRHwTGQ0-9_ksNxOa1FVccYAoX0KqqZc1VcdbW4
Message-ID: <CAEvNRgFmq8DP_=V7mrY8qza3i9h4-Bn0OWt72iDj6mELu+BiZg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
To: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: david@kernel.org, fvdl@google.com, ira.weiny@intel.com, 
	jthoughton@google.com, michael.roth@amd.com, pankaj.gupta@amd.com, 
	rick.p.edgecombe@intel.com, seanjc@google.com, vannapurve@google.com, 
	yan.y.zhao@intel.com, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-75330-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 4A9A87B977
X-Rspamd-Action: no action

Ackerley Tng <ackerleytng@google.com> writes:

Re-using this thread to collect discussions related to guest_memfd
HugeTLB support, also trimmed cc list.

Here's the latest public version Vishal and I have:

  https://github.com/googleprodkernel/linux-cc/tree/wip-gmem-conversions-hugetlb-restructuring-12-08-25

On the guest_memfd call on 2026-01-22, Michael found another bug to do
with multiple threads trying to allocate within the same huge page at
the same time.

The fix we're using to make progress is to use hugetlb_fault_mutex_lock.

unsigned int gmem_hugetlb_mapping_index_lock(struct address_space *mapping,
					     pgoff_t index, u8 page_order)
{
	pgoff_t index_floor = round_down(index, 1ULL << page_order);

	return hugetlb_fault_mutex_lock(mapping, index_floor);
}

void gmem_hugetlb_mapping_index_unlock(unsigned int hash)
{
	hugetlb_fault_mutex_unlock(hash);
}

and then

static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
{
        ... declarations ...

	if (gmem_is_hugetlb(gi->flags))
		lock_id = gmem_hugetlb_mapping_index_lock(mapping, index, gi->page_order);

        ... and this right at the end ...

	if (gmem_is_hugetlb(gi->flags))
		gmem_hugetlb_mapping_index_unlock(lock_id);
}

Yan also found some bugs (thanks!) and there's a discussion at [*].

[*] https://lore.kernel.org/all/CAEvNRgGG+xYhsz62foOrTeAxUCYxpCKCJnNgTAMYMV=w2eq+6Q@mail.gmail.com/

