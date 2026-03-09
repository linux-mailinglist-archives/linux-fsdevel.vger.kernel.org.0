Return-Path: <linux-fsdevel+bounces-79742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH9LL91+rmlfFQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 09:03:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D90B2353A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 09:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59264302EA8D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 08:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8CD36BCC4;
	Mon,  9 Mar 2026 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMeEWLFH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF0836B056
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773043325; cv=pass; b=ubLgmtBReHn/8wk+y4xEjTY6TvFZ/U36+YCSTLgwdTGYChbmE+AaEkiEABOvtB0iWjRbFywrFSMerZid01ISTzQkSNSDZMTQjrMeFdagBv4z3iDsR5p0s5hax4TbRNAnlcl9gndR4vxJ2mM3W118vkp0mtJgYKpr7T4cFvYPRCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773043325; c=relaxed/simple;
	bh=YZGVdYoM57Ljoy9ZvHaawIawTucwlY62ulstM6rXlh4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLhLCIF4kYkTiWRla6RcaMj7y4EmCdKVLIA/bhchrNSccLnaLZf1IgrFv7PuaOpFewWTbeADLFqnqSgNinfiSfEaNwZ0dckukygcJ5ID84Ps6XNEvNYvD/z1+jj9N0y4BzbpHOiNLW6UJUDzZKkFDufcGloWvdwQZd0rxdBNo0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bMeEWLFH; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5ffa277c156so933345137.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 01:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773043324; cv=none;
        d=google.com; s=arc-20240605;
        b=jpWxxm9hjnOpx2It3s1/NFi0e5aksZCYoHoA4a58fkefF168mO41FMtb2T/toF4awv
         +mnUs62w/5Klq27dGaFbTs37jrLx7Kr3/q0p1ksArzD3n5suGGyqiqou2wf01AYiUgiI
         gRpfjXp8+/BkQENRWfcpOAuaCZk5ZLC03Poy4WMs3OgS3PE7Ok/7K6Pk48mBFpylwqzw
         qKLasUh6Pw1LisbBTyAkTYJEwGAmG4LVJS2vyEUGAqmkDLws5kvGIl5oLU2gcZnRZ8Zl
         ANQF1GaLiVo1VVVouaN5jUWDBhp5PakDC8SE8YpKFpmoZFsy16vuc9R68v+5P1LtNiR8
         y+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=5iKTwpN//vgpsNCCXbcsIw/eIDxxyup8fH8lZJsZvpA=;
        fh=MrgHLHAvazJiaCQ3E5Voz2MenpToC9EOwYE0C0r8A/0=;
        b=DJcuSHheyxOYV3u3i7s0O2kkB3Gdt512ma6IbvYRVAwjZLOIUFqER24Kk8edTeTHdV
         jJqPwqPwyE5VUxJ7zCoZTzU61cmJ1EFFifHIczRhvnHomQVO666SvUNsBU5Q2DMxMmiy
         6hS79LoAUr+QQbmGMF/iyqOu/EhLUSZ3MaYcrYKbTLmfet08PpfCXvChkAXIYOLcWS62
         JZWrnRBB/FApWvoQgrAQSzyJ3GtWyQkQ+Tk5XncwMWymbOCkrlqe95Ow3u1Nt7htPRU2
         Jy9LgGIuA+sdMTKaEa81h8MdSGmvYRw1189rYbSpCkWyc2Vdn27y2U1TtZ1i6pnn8mEf
         xz8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773043324; x=1773648124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5iKTwpN//vgpsNCCXbcsIw/eIDxxyup8fH8lZJsZvpA=;
        b=bMeEWLFHPi89DslM8WJI/jzLMyY7qLB5p7V11q3O6F1OhvBt1YcnYtg/8G5xGWkLlZ
         3nQm1WDrm2wY0xMplRAThdr+lXFJXrhVGkZ+RE7DXjnUDTAU8Ma6F+BqRrzgOYbkIfkP
         0i9mAmxXC7ciGZnT9WrRF1vcQa/uvN4wFSG4TZbaZlS5mhjK4KSK8u+W8d/1ULiYVgba
         hx02PcgUpdZR+4qw+XrVAH5eWwwVWFP6+IeFipCf5s2ObDrT/ti4bmyjZycobs4DLJ2E
         2CzMcqV5himmziCW+4cmseEhJphf/YQXHjFaujyy4ileuqaPnz6cCjd7Zm7wXQ9I6uaX
         asHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773043324; x=1773648124;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iKTwpN//vgpsNCCXbcsIw/eIDxxyup8fH8lZJsZvpA=;
        b=qPVAkbsGxe0GbSd/JNY1r992HWKvrZB7ENrP8Ov+Tq4jQr8Qfu9Vguo6z9iy8H+ocN
         q0+TFuLSGaW94dmY5qU4z0fRzMVNT4oFdahHWzDRs/GeeyVreVSeXCJUmZzNMPy7zEbB
         x3CaaLMipWwfQws6lSY7KR5lXfXtSWxQi4/Q9GXVtLB0EMzq01CM7LKIdGZ219NJ1eV3
         WY5IYCkxk6yt1bxWHs4LJcsCEyBND8KcXJozEnGIMGWmICSULdgPMAzAqUVG7O85VSVv
         4Pa/xJ8j4hA66voV+DSZfi4oAE79ZA+3VVFJAjBa/Cyq9V0zjiWlPxFtoPlG0gjXVw9A
         Aarg==
X-Forwarded-Encrypted: i=1; AJvYcCXGWi8YXao1D7H5bkABOf0bv6Gu73imNYh8qMcUYh5ktmQQm4xZoIChHyUs/+LuEKHCH1KLFbaTH8G5vctr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7uadXkqbaHan+Fzhni3k6fxP3lI3CYaKj2I/h3xuPoNDCdqFS
	0tuHcwLdm6ysKHv+GoEsX16nHUcm8HtKzXPRftYjFLA7vhUOPk0707M0dQABWt6Lm9fzt+JohKd
	OmjZPRhYdQ7n7bBuLOZXSnmpvh9Fmm9VPXEt0ioj0
X-Gm-Gg: ATEYQzwBzRHNH7smYO9MnHy2DUvOTvmKc7mcpQmfW6zE31yFkeVYniOZ4f5gNNEIlIw
	Tai+7Xa1Ui/7+9wp89zqpy9bXAH+xQwpJCR+AoUDOGYvPVLH7zUHNmic2AnmX1FKfzGRONmKcuT
	eMS0O/mgyBjV3Ez2ZP/YrQefzGoP1zuhFE95docs9ipuxapNCLemogZrrvGzwYJNRUm+R+lJVRd
	ktVEZyfgk81NP0dHGxGvYL5MUijUZojRerj+ZD2sOxdpXCZX+02Ik8HuTQBqTjtTZOqiatMJ1Qr
	gb/aUHtgZVhOSYIfPAWqvvHDUdYo/7IkOmSv4H1pnqbLcnqU7GJAw8eiRGFWVMbLjgVqAQ==
X-Received: by 2002:a05:6102:4194:b0:5ff:cee8:660c with SMTP id
 ada2fe7eead31-5ffe61bf0d2mr3868411137.31.1773043322886; Mon, 09 Mar 2026
 01:02:02 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Mar 2026 01:02:02 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Mar 2026 01:02:02 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aahNprLw0_Cdhzxp@google.com>
References: <20260225-gmem-st-blocks-v2-0-87d7098119a9@google.com>
 <20260225-gmem-st-blocks-v2-2-87d7098119a9@google.com> <5097ff66-b727-4eac-b845-3bd08d1a0ead@suse.com>
 <aahNprLw0_Cdhzxp@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Mar 2026 01:02:02 -0700
X-Gm-Features: AaiRm52tdsuammFV80Tf5JuKg-WPQwxrDNCct9c5X_bV6T_IkMHGIVZ0r4R166A
Message-ID: <CAEvNRgFwyqY0q-PTvMGjK82rxvbCfPxK8-RUPML3w_8mzAk8xA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/6] KVM: guest_memfd: Directly allocate folios
 with filemap_alloc_folio()
To: Sean Christopherson <seanjc@google.com>, Vlastimil Babka <vbabka@suse.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	rientjes@google.com, rick.p.edgecombe@intel.com, yan.y.zhao@intel.com, 
	fvdl@google.com, jthoughton@google.com, vannapurve@google.com, 
	shivankg@amd.com, michael.roth@amd.com, pratyush@kernel.org, 
	pasha.tatashin@soleen.com, kalyazin@amazon.com, tabba@google.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6D90B2353A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79742-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.952];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Mar 02, 2026, Vlastimil Babka wrote:
>> On 2/25/26 08:20, Ackerley Tng wrote:
>> > __filemap_get_folio_mpol() is parametrized by a bunch of GFP flags, which
>>
>>                                                            FGP?
>>
>> > adds complexity for the reader. Since guest_memfd doesn't meaningfully use
>> > any of the other FGP flags, undo that complexity by directly calling
>> > filemap_alloc_folio().
>> >
>> > Directly calling filemap_alloc_folio() also allows the order of 0 to be
>> > explicitly specified, which is the only order guest_memfd supports. This is
>> > easier to understand,
>
> That's debatable.  IMO, one isn't clearly better than the other, especially since
> filemap_lock_folio() is itself a wrapper for __filemap_get_folio_mpol().  And there
> is a cost to open-coding, as it means we risk missing something if there's a change
> in __filemap_get_folio_mpol() that's beneficial to guest_memfd.
>
> As Vlastimil said, if this greatly simplifies accounting, then I'm ok with it.
> But the changelog needs to focus on that aspect, because I don't see this as a
> clear win versus using __filemap_get_folio_mpol().
>

FGF_GET_ORDER() indeed caps the order at 0. I was overly focused on the
earlier line where it did mapping_min_folio_order(), where I thought
other code could possibly influence the eventual order.

I'll revert to __filemap_get_folio_mpol() in the next version and see
how that goes. Thanks!

> And if we go through with this, we should probably revert 16a542e22339 ("mm/filemap:
> Extend __filemap_get_folio() to support NUMA memory policies"), because guest_memfd
> is/was the only user.
>
>> > +static struct folio *__kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>> > +{
>> > +	/* TODO: Support huge pages. */
>> > +	struct mempolicy *policy;
>> > +	struct folio *folio;
>> > +	gfp_t gfp;
>> > +	int ret;
>> > +
>> > +	/*
>> > +	 * Fast-path: See if folio is already present in mapping to avoid
>> > +	 * policy_lookup.
>> > +	 */
>> > +	folio = filemap_lock_folio(inode->i_mapping, index);
>> > +	if (!IS_ERR(folio))
>> > +		return folio;
>> > +
>> > +	gfp = mapping_gfp_mask(inode->i_mapping);
>> > +
>> > +	policy = mpol_shared_policy_lookup(&GMEM_I(inode)->policy, index);
>
> This is a potential performance regression.  Previously, KVM would do a policy
> lookup once per retry loop.  Now KVM will do the lookup
>
> I doubt it will matter in practice, because on EEXIST filemap_lock_folio() should
> be all but guaranteed to find the existing folio.  But it's also something that
> should be easy enough to avoid, and it's also another argument for using
> __filemap_get_folio_mpol() instead of open coding our own version.

