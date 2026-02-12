Return-Path: <linux-fsdevel+bounces-76988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FTsJEJGjWlj0gAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 04:17:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFB3129FE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 04:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 512FC302AF24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 03:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471F323EA97;
	Thu, 12 Feb 2026 03:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0+EMFEop"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1B921765B
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 03:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770866238; cv=pass; b=n4mud/YO32lUo8Pwo67+Q0IXW23xYCMVtAMoVf+4hl6UOWUShdIRBQs14RUXGZbhFGyWf5ezbbVBARgIyer9x+yvySi3+FkSPeoojAbI1pboD/PrHDv7d/zLw5sljmjiQDCceXmvvP6kkNexvFIS2uUxNHBu+4I2/2gCFftUolo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770866238; c=relaxed/simple;
	bh=myejyAY6+trMq2217gubmIhKoo+IyTluOWjrjF1r/Gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kcbf168JxpekswtkiZ3VtlKu+KaOBfJG4KPG651R2hU/lUPEx3P+GqJi6yyKZRMgvJLtRK1jn++4yStkbmUHxANZjmSSY/DOm/4KbGso+F3SJbcbznIaPGxI3hLrCvMdhgd7RTaF3v8uBYnHe+R4D+CSo0gxOpPXftpLZs6sl1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0+EMFEop; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48324da63b9so24525e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 19:17:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770866235; cv=none;
        d=google.com; s=arc-20240605;
        b=HarC638YDzQI3Kwd/4rHqkyu/bUsXxfDDbNRfE3OnT/R6mbK4XcqbAupEyLOWHKPAb
         LCvMwugTW+wMQGlXK4nw0i2wl7G5ZWgyB/Dq7Jz4N4oY+oAHpABNb3806j/tpFeL8cFq
         Zqz3miGkXSBDXfDmY8BqqSpUa11kquhvh0ckdFFrpp6ptPnW/rW3tg6uVLMBqAj2Ug7Y
         2Yq76pCGfwrR3oUO6BtG5+IHN5onSrFiYNJsUqaFRLJ25w/RENBUhon24qUHZoCJzk/p
         /YZ4Q11vVbvKbUP+877OKMUPVZhUyJLSxl32bIJESZm8DivcowcqBytsvKtVEd/NwfzW
         sdlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=myejyAY6+trMq2217gubmIhKoo+IyTluOWjrjF1r/Gk=;
        fh=P+6ULJ4eY03yJfhB5/U63ZFcQq7cwVjZatrCbERiiHo=;
        b=R42jLqPxDxHKLy35OvUp3d8tRgW5yRniH8Ldv8NLab9bWaPbhh+76WJozoHV0sF4XU
         ugs1oLjpJvmfmOZXaHJFNzsLai73sQzPTKoYE20OWXtAoLIQmnp9DPv5VsayqnUgmyl9
         iZoM25EfkvySLUVRHEa0vTVWwq6vhFGVkqfYQ4r5tkFKY2GysOM4Jg6hjoOAhdMHm8nk
         fdormt/c/Cbt5kERPAQk3YsNMCtXeNA0vO5+i0kTH3M24qeyV2/ytCKobWolIqbG+1mQ
         FnHp+wnCSD4rlmXziTsBhOG+AjvjjOy2NJHFeDBV7Nh6FMLnUgZN7MUH554GBjK363gC
         NSnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770866235; x=1771471035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myejyAY6+trMq2217gubmIhKoo+IyTluOWjrjF1r/Gk=;
        b=0+EMFEopQqbjbTeyTdzmcIwRMiqkkZSwbf3v58HFXfdKpld3f83VVWyvH3Zxd5GH6j
         w1Nsgxpw3q56j9Clz2RC18ZWY38sZXyVNWl/GolW5AKVSPbncolaVv550Qw4boNVHwkO
         4RHu5bSWzio/G2dSw+FfPP6FwEvF90s9i+QG5uI5mritdqvXkmPcgRen3EOT92V4vmof
         F/MIRbxKhMUhh5uOuzUq75dIFBY7zkl+i1mzCa2g+l8ykbQrfvOcqn+v5CvQdAFfw8ot
         NYUMYlj3rqu/GFrYLj0Nqoki+r+aFxGHI8fk9S7DTP5pSfgOV9B5XP2Am0nr3wnN0H+k
         fAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770866235; x=1771471035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=myejyAY6+trMq2217gubmIhKoo+IyTluOWjrjF1r/Gk=;
        b=hIkPk4eiICvcQ+AtopCcEPzCescLrF0eD9htz3ao0D2cSoGioqClO0v7Q0Ml1p/zk4
         RBaO20Om0Y+0BrAxczfIo8CB5FRCN6+r9c6cyv02N4inzoOD1nc941WFoV0GwwaUc+pg
         czAuWs4qbv7pZoEjoIY1XVo0aKVv1o2lVOQvZvat685axqP1gVtf7MD+SSfqmdwgd5a8
         zeCwrIvEdbupzMYx8YRFmUCo4O1y6ctta0NMU0nP4QB6shUDoQfr7TZDhckGzpLAOcfi
         WwaWwEiZfAlfjMUrWzabIcNx2CqPjz0N1N3tSAvwc3OjTPWkGlFFJEOt2l5y9xvZATxC
         Oy3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWR5Q7Xqd3avBSudzX18EOqjTE5NJN2IjzYNEBneMSuRSJ7HDWOm7JqciXdFIQy6IFGMi6FBgM2irdt6y4/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz76t/jIws5Pc8Irf98FDnd8SjKn7muOMsX+wkQjEBd0EsHc/jV
	IQsD+xz1MzbniS6pA6mWjoz0s3ih/VATFL3epz8VHArnfn2gfhLEhnaNvQMRQLuF4vG0X/gF05z
	b6PzOF4eutm19nphiOS4Mmz35PIVZRQZdHDlRhDHR
X-Gm-Gg: AZuq6aKNGln3SN9p3v+Gdzgq4yhJdmEgKFT6nXiHFRPIkO5jNEO6ThI8CWldpWp/6eG
	JpZ2EgohRJVLYoMTnpdL1ehzvYyibLR43qc8hc0c21rvt0IMiY3n8rWeuTL/6zzwNktL/QhE6Vw
	OR0mmTBepadUJRvR4BZXDdSN0M+pIuGC4NKpZBsRo7nNkjrXnzYQ1je+3bKPkY4CylBMdBVJLSM
	18VzDFBChRn23oqiP1xb+nPIkw322tx1IdhG/a48YNFR3qAu/QZnWb0vxczNj7fKpvwQPQDO69d
	mpVUDT2hWmi/Jop75HWCYAsX3LjHMJfPeg6mcXBP
X-Received: by 2002:a05:600c:8288:b0:477:86fd:fb47 with SMTP id
 5b1f17b1804b1-4836593a321mr490675e9.8.1770866234921; Wed, 11 Feb 2026
 19:17:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203192352.2674184-1-jiaqiyan@google.com> <20260203192352.2674184-3-jiaqiyan@google.com>
 <26a7803a-bf20-c60b-459d-2c8f82f2f4f6@huawei.com>
In-Reply-To: <26a7803a-bf20-c60b-459d-2c8f82f2f4f6@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Wed, 11 Feb 2026 19:17:03 -0800
X-Gm-Features: AZwV_QjvMCktCSOSG3Cg-wYQo1ai5b8Q1OUS6kQKYvkGyQjOIsUwWhbDhSlmNcM
Message-ID: <CACw3F52kCHc5HF2wSg6W0_ApuMcW3VUk=vde1kiwRxQ+tkW9jQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] selftests/mm: test userspace MFR for HugeTLB hugepage
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: nao.horiguchi@gmail.com, tony.luck@intel.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org, akpm@linux-foundation.org, osalvador@suse.de, 
	rientjes@google.com, duenwen@google.com, jthoughton@google.com, 
	jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com, 
	sidhartha.kumar@oracle.com, ziy@nvidia.com, david@redhat.com, 
	dave.hansen@linux.intel.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	william.roche@oracle.com, harry.yoo@oracle.com, jane.chu@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76988-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiaqiyan@google.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,huawei.com,infradead.org,linux-foundation.org,suse.de,google.com,nvidia.com,redhat.com,oracle.com,linux.intel.com,linux.dev,kvack.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0CFB3129FE3
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 4:01=E2=80=AFAM Miaohe Lin <linmiaohe@huawei.com> wr=
ote:
>
> On 2026/2/4 3:23, Jiaqi Yan wrote:
> > Test the userspace memory failure recovery (MFR) policy for HugeTLB:
> >
> > 1. Create a memfd backed by HugeTLB and had MFD_MF_KEEP_UE_MAPPED set.
> >
> > 2. Allocate and map 4 hugepages to the process.
> >
> > 3. Create sub-threads to MADV_HWPOISON inner addresses of the 1st hugep=
age.
> >
> > 4. Check if the process gets correct SIGBUS for each poisoned raw page.
> >
> > 5. Check if all memory are still accessible and content valid.
> >
> > 6. Check if the poisoned hugepage is dealt with after memfd released.
> >
> > Two configurables in the test:
> >
> > - hugepage_size: size of the hugepage, 1G or 2M.
> >
> > - nr_hwp_pages: number of pages within the 1st hugepage to MADV_HWPOISO=
N.
> >
> > Reviewed-by: Jane Chu <jane.chu@oracle.com>
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
>
> It's not required but could this testcase be written into the tools/testi=
ng/selftests/mm/memory-failure.c [1]?

Good point, let me catch up with your new test fixtures and see what I
can do with this new test.

>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=
=3Dmm-unstable&id=3Dcf2929c618fec0a22702b3abd0778bbdde6e458e
>
> Thanks.
> .

