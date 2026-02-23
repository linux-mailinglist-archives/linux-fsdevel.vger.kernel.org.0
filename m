Return-Path: <linux-fsdevel+bounces-78177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPxUK+zlnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:42:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5273617FCCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FDFB30364C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C7237FF5D;
	Mon, 23 Feb 2026 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4npmqqkZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BC337FF47
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890148; cv=pass; b=SjUQ+LlhItO9tjXoygwETq0Vn448OiWm+RVQOtOtvoGLCcVgb57BV5Og312/k5yDRCtG5SbqcqxXtR5ftSsxFfrq5qOdoDs6lPoI40BWaQIpeNU9lu5kcrVa82IRTMHPd51jd5QvHzWUwUtIFsZJvcMP9Z7fWkQrjMY8ggeeynE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890148; c=relaxed/simple;
	bh=G1G7Co3UGLp29oZTzIMMy89dawTZvG8ZKLFe9M3O6sY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CP+o6fxG/vDg1G7537i+oaKhc+6oewVTcpKAIKkJyUL4UWnWBCvjJYSJsfkbxG/cEFbDV+ITneFrmn6JtuEUU9lZYt8RxDo9it+KyLDvuqNSXO0i/aWwZKjMvIupc3adeztPq+J0/gl+ZYGzUoeFYJlXnko3v3hATaGlF09r8Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4npmqqkZ; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-948029fb1f2so1344027241.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 15:42:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771890146; cv=none;
        d=google.com; s=arc-20240605;
        b=UptUHifCA21gxySNcZonpSXfa9SoDHhBncbtz94Af1tCSjXBSq8YLa5NxQTVjh1zLq
         1eLW8elag/j/LiatmZJRW95VT/dFRNE/i7KaStM2Vv0lnJUvXCL3sndFkIyWyNs+bxEy
         Nb96w7qg9tYCUHe7FUFat0sNAvMriH6hZ2WQMvFI+aLzYTpN5lXyiqAtYTkMHAYC9iEO
         Bk9bxLB189n4ld9B2mJ4Nh+HkMls284fBqYPAM2sJAMoY6mICU2ZDgdbfceuxQdaJXtd
         FExWT1kk1FfockaQWlBQih6iIF1jamUAT0ociU+lGu/13T5Kgj7Fa7U8wncx3I55K8RX
         ohYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=G1G7Co3UGLp29oZTzIMMy89dawTZvG8ZKLFe9M3O6sY=;
        fh=s6d9tqh4jgXlujdHxvtWhRjeuMDPJqAkBRaCmARMJXM=;
        b=INIiuOpXDT4BEh9BR/a4rnSetQsXH/OvXkVPS1wZrgEiEfLBVUssRAywLji7cEXD6O
         J32sq6cAWpYiDf3zcQepn3FuWybNtO2YYoTu5pPF16QfrpMT5hm3OaSA7s9Qo1el1GJl
         dusQ3/CXbE5r5bHpNiVornbPrhe1mEZ23UfQwK2pZhPYfMmh1TuMekdZukURsIIclwCj
         bfh2ElN6tPrd0CiMrr4wjtndiOjXDJ9FuqhF8P7hNPFoGk14gfHIukvOq2y+LSbUHRnU
         arhwbr+IkOL8nMM/Dskdiac7BpDYZreBxskbiiPcRCiAbRCSgmuRdikCkkyRm1gWU/3M
         h9kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771890146; x=1772494946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G1G7Co3UGLp29oZTzIMMy89dawTZvG8ZKLFe9M3O6sY=;
        b=4npmqqkZVD4RdxyIRdLVN3GJ7fxWuMZCnqv7lxvXKBLGnYLdgHySwMxoi65MgG7ZHj
         q/mQv62NpefnTqLd5SVDhmDhjWjQs0eTdLhx0WK/S+dpkS6YzqJjbeGoLxj8en304v9P
         WjJ2xHvxEejgELw1MUKyU+IGjKcCUEP8bHGCB+O1WkB+bIxrm1Jm0LJp4ZXaMTq/Yjyw
         Aq1yTR4H6M+iZsZEIPqRNGjLmWUAxBEk/m3nKtxVTxufNpwaweCPnVtKKJvHPHnx85x5
         hcfTk2fuxe/ilc3cu/6XP5AlNVlhu4IkSHLUt2xOYN2xfWvB0+yB1nQhxnQ3gd84iVka
         Nmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771890146; x=1772494946;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1G7Co3UGLp29oZTzIMMy89dawTZvG8ZKLFe9M3O6sY=;
        b=tdpxUiscz1I+4F6T7K/eczwF7l8ASthedMZtz3NuEI7Ms/XEPdkbXlKN3BXPgu7Pea
         u/I4MAgoUkN9GMiIqaw2hnNyszHvRr9Tg6V7DjbwLQYnxYe83HiDtyCOLqgTEMLTJyH+
         SqRz3mLW2DTH8YH49PHI0K/jVq9YPH9Sa5FrdtxVAppl+n9MA75cfUgtK5wiLWxJ/st/
         UXjq1d0WAnsL6/UdOIZWefRK4rmaUdnfssQu2AxxXhNC31yCajk9P5sW83rJqtDD2VoJ
         TxDxY67p5WbNhVl9CSgbs06YerGgivzf1etdTujErfGLf4C6AV4ZI8IjEhqQBXVri9/B
         JwJA==
X-Forwarded-Encrypted: i=1; AJvYcCWZM8uluWu2mywe8LwbLKeVcNDxqeUUi/zCIuvYowg0TgjvScVQ4panmnLNkbRLIZ0ABFtCBMUT1YGZwJjt@vger.kernel.org
X-Gm-Message-State: AOJu0YzgAsNDmvC+T3PIvV8PsfSqqUuOTO7QrkD35rgyxmQEbMnFgrXP
	b5cBGHbai6yV19ZqjtGzGlGyjeUWhRlZ48RHIT4v5jV6+w7mDhNVXWnWpezeZpJ8hBO+/Jc15UI
	cqvzxOTxNW5b/MT7orHEVSW0/MUPWl1jpFfA3KGfD
X-Gm-Gg: ATEYQzy7vqLL010McUiqUmznCc7LoEszHTimTqR0CvldNdfq4xz90rIsw430pr7BIIS
	AIhKCEzPDPqc51TV4UyRcXdEY3wAgOnbmA6WqA/lq7J7pazW2gFdIAMsCQfB/3EDo6ibFh8d75d
	COBOR+HCSq2izGFmj+R2lkl9fs8QCOUCTuSGQGgeFeNgs0+Wp65RIF00GsgzCGQc6Uw5QF6z9Km
	6u+TNbbLApXZeyZyCp2Q2+73aIaJbpkHZEeRzJHO6xu3aiEWrZJR/YfQY/F7gzBoQbmPbGFaGdk
	0c8ypTKeOg9oropyGJIO6kA/Huh4a5L+OHLAWGyiRA==
X-Received: by 2002:a05:6102:3053:b0:5f5:32e2:5ea2 with SMTP id
 ada2fe7eead31-5feb30fc3a8mr3035084137.37.1771890145956; Mon, 23 Feb 2026
 15:42:25 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 15:42:25 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 15:42:25 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <a97045a9-8866-40fe-aa15-d319cafa6f2c@kernel.org>
References: <cover.1771826352.git.ackerleytng@google.com> <a97045a9-8866-40fe-aa15-d319cafa6f2c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Feb 2026 15:42:25 -0800
X-Gm-Features: AaiRm52aDnZI9CEbv5M2DeAz_Eaea7Sv4JJPWItwl1wMCqksqqJ4XC4LTodyGY8
Message-ID: <CAEvNRgFF0+g9pmp1yitX48ebK=fDpYKSOQDmRfOjzSHxM5UpeQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/10] guest_memfd: Track amount of memory
 allocated on inode
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, willy@infradead.org, pbonzini@redhat.com, shuah@kernel.org, 
	seanjc@google.com, shivankg@amd.com, rick.p.edgecombe@intel.com, 
	yan.y.zhao@intel.com, rientjes@google.com, fvdl@google.com, 
	jthoughton@google.com, vannapurve@google.com, pratyush@kernel.org, 
	pasha.tatashin@soleen.com, kalyazin@amazon.com, tabba@google.com, 
	michael.roth@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78177-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5273617FCCC
X-Rspamd-Action: no action

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> On 2/23/26 08:04, Ackerley Tng wrote:
>> Hi,
>>
>> Currently, guest_memfd doesn't update inode's i_blocks or i_bytes at
>> all. Hence, st_blocks in the struct populated by a userspace fstat()
>> call on a guest_memfd will always be 0. This patch series makes
>> guest_memfd track the amount of memory allocated on an inode, which
>> allows fstat() to accurately report that on requests from userspace.
>>
>> The inode's i_blocks and i_bytes fields are updated when the folio is
>> associated or disassociated from the guest_memfd inode, which are at
>> allocation and truncation times respectively.
>>
>> To update inode fields at truncation time, this series implements a
>> custom truncation function for guest_memfd. An alternative would be to
>> update truncate_inode_pages_range() to return the number of bytes
>> truncated or add/use some hook.
>>
>> Implementing a custom truncation function was chosen to provide
>> flexibility for handling truncations in future when guest_memfd
>> supports sources of pages other than the buddy allocator. This
>> approach of a custom truncation function also aligns with shmem, which
>> has a custom shmem_truncate_range().
>
> Just wondered how shmem does it: it's through
> dquot_alloc_block_nodirty() / dquot_free_block_nodirty().
>
> It's a shame we can't just use folio_free().

Yup, Hugh pointed out that struct address_space *mapping (and inode) may already
have been freed by the time .free_folio() is called [1].

[1] https://lore.kernel.org/all/7c2677e1-daf7-3b49-0a04-1efdf451379a@google.com/

> Could we maybe have a
> different callback (when the mapping is still guaranteed to be around)
> from where we could update i_blocks on the freeing path?

Do you mean that we should add a new callback to struct
address_space_operations?

.invalidate_folio semantically seems suitable. This is called from
truncate_cleanup_folio() and is conditioned on
folio_needs_release(). guest_memfd could make itself need release, but
IIUC that would cause a NULL pointer dereference in
filemap_release_folio() since try_to_free_buffers() -> drop_buffers()
will dereference folio->private.

From the name, .release_folio sounds eligible, but this is meant for
releasing data attached to a folio, not quite the same as updating inode
fields. This is also not called in the truncation path.

>
> --
> Cheers,
>
> David

