Return-Path: <linux-fsdevel+bounces-77071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOqXADewjmlPDwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 06:01:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 556CC132ED8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 06:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EF79302C5C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 05:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAAF241696;
	Fri, 13 Feb 2026 05:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkYrhBN3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE224EED8
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 05:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770958888; cv=pass; b=ssr+LL0u2O+owTZQK1Wjrd6EL4ADfvtQShvMF/spYfjGTPd7ruE9vkoJTcFmqRGx/dx/DiFPRF3rpvDZPJDNVGvzIWYvTXl4HfARi4Tih+P+psZk1ffHW/NfwjECIbN6ub1ubcGYcgHyqnb8LUA1I3YYeY9sdqt9z7U5xE1hquw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770958888; c=relaxed/simple;
	bh=VV1oEPOIDQDiLLTRv81jhuclIHpQTs1mCyW98dM4Lh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpCWsTmahMjjNDk3W0WHMVu3TTf23tmZodtCJSd2iRvjm4/y335EYEyTQI4+5e1Fr6tPsuMTed7nhANyx/SNBEDrFeA2EgdwyEF67M1KZRx7b/jWw5T4fxb76zgiQDPUIdvd4cWss/HKMYIdC38ADfnhwsdaUFZ79AGfspjU2Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gkYrhBN3; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48318d08ec2so25395e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 21:01:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770958885; cv=none;
        d=google.com; s=arc-20240605;
        b=O4a2NEZBx17IciDQ6UQ41xz1xIF0hIZnCwU2UH9YVIvYl7HZ3sTLFXOrsA3PrLuwCC
         K7ffwuZV16T6RYgEqnEgGligEQhmwRlLZDn6E4ZFYNM2GsMSF/ZCcgwSEl4shlPh5M9l
         k/Nle3+sWTjKCHW2Xvz5OSV3/T6+7eapQxo3A35cfpT8mL8gAZGbVqD3eilqhnrGyCr+
         29tISNKNg5blQVa1JjyL9+dyanguG2qUnKJCEW5LGN1XQ/CTPolCISFmG55X1uhO/d/H
         MfF/nDjQVpDtzu0vJ2eqw2wE+tC1UvlmH5Hgc1Op48TxbBVrLYDLclHR17B7o74Ub1TP
         Ww2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F+gdGRO5WQmxL11L59saL1WXLHxYBJRsrTDD771Wy4o=;
        fh=dMqemoNL2EiM0Lg8BsbLrI9wPbFEQ37wbPvPAsj65Gw=;
        b=VuojP9sRaHPVKyLGX0QnA7Hqwwdkf7AmkjuzApmwCYRQYu5tEiloTFXLFLdkQLxIdD
         d8MUIKVuhfHFLtqy92fLtWlxxWfT1M8BP0kvr8MM9jj1sDIUB+d1o+4E7kqY3DH7V9V1
         Rk4FlF2T56k97V2UfytHYuv7H+CxrOZCcPYva2wT7ZndmafbFdGPkJM/AH1wjH9kVovK
         0XFxCxqRxi6TQb9qaeIsJC2SOeVgdg9UunO1+9sp/qtd6jXMtwGB0uWhp+djjSWzQ5Zh
         SpcV1GQXCirrLnQymJ9eLB1FqP7UxIeYSWAyW8XQUoixHivKeNjMfLc3rUnK5BkuGtSo
         9Y4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770958885; x=1771563685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+gdGRO5WQmxL11L59saL1WXLHxYBJRsrTDD771Wy4o=;
        b=gkYrhBN3xJZ1/0UGxWNBfMC5LQ3f5lGK4m1WKVb+/27CAP2IUYqiXwiq+pMGH0BGys
         kdBL19zgj4Qat1JSZ8GijSwqLQlJrqVe+cZGE2HDV4RBJaOKTmhdFIUj1UtFte/WpIA0
         fk3DujWB2Eglg8OWu8DsZGW47/r5gLPJ8C8bc9AHkDM9mf4xaXUhreLsgnovy76txaCm
         Xm6sDsOxTGdgJZapv7DjL+bWkaDCAmyAG0aFc8GzuQfd1RYlo/6yw4r8doRmoU4Wou3c
         dXm1uP/ROxbdx3pOtW96/7OlwPGT1dQM33TcwUQD2Qb6nwroKbpRbDePYQmKopPkMjLu
         HrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770958885; x=1771563685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F+gdGRO5WQmxL11L59saL1WXLHxYBJRsrTDD771Wy4o=;
        b=b6sxBvOpdubsLKR+QxHfaRPASdLCE1GXD5XmQgfoGK2GetG7jRKWe9Y9hC8SRt2Mhj
         3/Rcxd3sw5FRpsu3iybJY6FEXJpx8epVDyMLp+EBJKy/wwbHEI4eFjNEbgnm0RFi/6Rx
         7OCwYYnQ9o38B92uEw5CrGYywFFlLEWEj8DJSDNld3AP7GaQBMAGaOngZmZ1LOn15/xG
         4x9M/wJjLA41qm7UTt13oeRdc+HUrjrcKtZakNrctalnqJq1bF6wKx21wRCHBRI/osTt
         +4Xsrnev9XyJsnlfK/hXmYg/I2bzfR+jIcyCRDYGZJ5oPQCSlIxbhOeSjOzpy56uGEew
         sKfA==
X-Forwarded-Encrypted: i=1; AJvYcCVtv6+i94v/RmjFFayDxiHBk6ejxPJZPGgPwLEpD+XQRHDf+hEtFp9iumkx6+MP73uAUSUp9tummYcCe3yo@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8a4VZ0o40q3S73Yh10QstMl5xJwLo9/TJi/sL0D79sugCMdT8
	oUuPsGLz1j4LNeXyzXJTX1GLgW17jr3lyoQian445yE7iyv9e9BeSSR5iDI59zU5y/c6wCBeeE4
	wrc8bx4zVkmd73ZP/Un0+N4Jw8ZLa+0l6pDMBNBsz
X-Gm-Gg: AZuq6aKkscHgBg23rlCW46UX3REIb6eMfQVX5BJD3RdB3vpUiEsDeHe23UzjJwVonlk
	Im0ceonghnbVsXcagWMINGFNbT1GlQyKimjwZ4kARsZPtIFLsESvK9XUAqTqzqgv4R0XQ1cgtXE
	MBuAB9ZyzuJCp03xNsW3t79oRUNgk3QHfWmzCPB/Yvm+01wn75uT0vD8eMha3N0+LL82mvGjIP9
	637QlhCk11I79HO+AtIgtOS5BUI9yRxri9JORDM5Ia6w5X3/m7QT2IYS7M5Rn5g+kmVDQTCHCwC
	F8v3abFN8X016WXYy1u7alxrwsIHf7NCdNUEEEMw
X-Received: by 2002:a7b:c5ca:0:b0:477:95a8:3805 with SMTP id
 5b1f17b1804b1-48372ef5367mr158855e9.15.1770958884545; Thu, 12 Feb 2026
 21:01:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203192352.2674184-1-jiaqiyan@google.com> <20260203192352.2674184-2-jiaqiyan@google.com>
 <7ad34b69-2fb4-770b-14e5-bea13cf63d2f@huawei.com> <CACw3F50PwJ+sSOX0wySQgBzrEW2XOctxuX5jM37OG0HS_kHdbQ@mail.gmail.com>
 <31cc7bed-c30f-489c-3ac3-4842aa00b869@huawei.com>
In-Reply-To: <31cc7bed-c30f-489c-3ac3-4842aa00b869@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 12 Feb 2026 21:01:12 -0800
X-Gm-Features: AZwV_QhlllUi0eHTdCejlItd_Ytr-GAEoFEDHxBi4v3ZMGnCptGiz5Tmjy4xcP0
Message-ID: <CACw3F50BwnLJW75EXgz0t5g+eUhr+wKgJ3YfRFq5208N5KfaiA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm: memfd/hugetlb: introduce memfd-based userspace
 MFR policy
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77071-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 556CC132ED8
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 11:31=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> w=
rote:
>
> On 2026/2/10 12:47, Jiaqi Yan wrote:
> > On Mon, Feb 9, 2026 at 3:54=E2=80=AFAM Miaohe Lin <linmiaohe@huawei.com=
> wrote:
> >>
> >> On 2026/2/4 3:23, Jiaqi Yan wrote:
> >>> Sometimes immediately hard offlining a large chunk of contigous memor=
y
> >>> having uncorrected memory errors (UE) may not be the best option.
> >>> Cloud providers usually serve capacity- and performance-critical gues=
t
> >>> memory with 1G HugeTLB hugepages, as this significantly reduces the
> >>> overhead associated with managing page tables and TLB misses. However=
,
> >>> for today's HugeTLB system, once a byte of memory in a hugepage is
> >>> hardware corrupted, the kernel discards the whole hugepage, including
> >>> the healthy portion. Customer workload running in the VM can hardly
> >>> recover from such a great loss of memory.
> >>
> >> Thanks for your patch. Some questions below.
> >>
> >>>
> >>> Therefore keeping or discarding a large chunk of contiguous memory
> >>> owned by userspace (particularly to serve guest memory) due to
> >>> recoverable UE may better be controlled by userspace process
> >>> that owns the memory, e.g. VMM in the Cloud environment.
> >>>
> >>> Introduce a memfd-based userspace memory failure (MFR) policy,
> >>> MFD_MF_KEEP_UE_MAPPED. It is possible to support for other memfd,
> >>> but the current implementation only covers HugeTLB.
> >>>
> >>> For a hugepage associated with MFD_MF_KEEP_UE_MAPPED enabled memfd,
> >>> whenever it runs into a new UE,
> >>>
> >>> * MFR defers hard offline operations, i.e., unmapping and
> >>
> >> So the folio can't be unpoisoned until hugetlb folio becomes free?
> >
> > Are you asking from testing perspective, are we still able to clean up
> > injected test errors via unpoison_memory() with MFD_MF_KEEP_UE_MAPPED?
> >
> > If so, unpoison_memory() can't turn the HWPoison hugetlb page to
> > normal hugetlb page as MFD_MF_KEEP_UE_MAPPED automatically dissolves
>
> We might loss some testability but that should be an acceptable compromis=
e.

To clarify, looking at unpoison_memory(), it seems unpoison should
still work if called before truncated or memfd closed.

What I wanted to say is, for my test hugetlb-mfr.c, since I really
want to test the cleanup code (dissolving free hugepage having
multiple errors) after truncation or memfd closed, so we can only
unpoison the raw pages rejected by buddy allocator.

>
> > it. unpoison_memory(pfn) can probably still turn the HWPoison raw page
> > back to a normal one, but you already lost the hugetlb page.
> >
> >>
> >>>   dissolving. MFR still sets HWPoison flag, holds a refcount
> >>>   for every raw HWPoison page, record them in a list, sends SIGBUS
> >>>   to the consuming thread, but si_addr_lsb is reduced to PAGE_SHIFT.
> >>>   If userspace is able to handle the SIGBUS, the HWPoison hugepage
> >>>   remains accessible via the mapping created with that memfd.
> >>>
> >>> * If the memory was not faulted in yet, the fault handler also
> >>>   allows fault in the HWPoison folio.
> >>>
> >>> For a MFD_MF_KEEP_UE_MAPPED enabled memfd, when it is closed, or
> >>> when userspace process truncates its hugepages:
> >>>
> >>> * When the HugeTLB in-memory file system removes the filemap's
> >>>   folios one by one, it asks MFR to deal with HWPoison folios
> >>>   on the fly, implemented by filemap_offline_hwpoison_folio().
> >>>
> >>> * MFR drops the refcounts being held for the raw HWPoison
> >>>   pages within the folio. Now that the HWPoison folio becomes
> >>>   free, MFR dissolves it into a set of raw pages. The healthy pages
> >>>   are recycled into buddy allocator, while the HWPoison ones are
> >>>   prevented from re-allocation.
> >>>
> >> ...
> >>
> >>>
> >>> +static void filemap_offline_hwpoison_folio_hugetlb(struct folio *fol=
io)
> >>> +{
> >>> +     int ret;
> >>> +     struct llist_node *head;
> >>> +     struct raw_hwp_page *curr, *next;
> >>> +
> >>> +     /*
> >>> +      * Since folio is still in the folio_batch, drop the refcount
> >>> +      * elevated by filemap_get_folios.
> >>> +      */
> >>> +     folio_put_refs(folio, 1);
> >>> +     head =3D llist_del_all(raw_hwp_list_head(folio));
> >>
> >> We might race with get_huge_page_for_hwpoison()? llist_add() might be =
called
> >> by folio_set_hugetlb_hwpoison() just after llist_del_all()?
> >
> > Oh, when there is a new UE while we releasing the folio here, right?
>
> Right.
>
> > In that case, would mutex_lock(&mf_mutex) eliminate potential race?
>
> IMO spin_lock_irq(&hugetlb_lock) might be better.

Looks like I don't need any lock given the correction below.

>
> >
> >>
> >>> +
> >>> +     /*
> >>> +      * Release refcounts held by try_memory_failure_hugetlb, one pe=
r
> >>> +      * HWPoison-ed page in the raw hwp list.
> >>> +      *
> >>> +      * Set HWPoison flag on each page so that free_has_hwpoisoned()
> >>> +      * can exclude them during dissolve_free_hugetlb_folio().
> >>> +      */
> >>> +     llist_for_each_entry_safe(curr, next, head, node) {
> >>> +             folio_put(folio);
> >>
> >> The hugetlb folio refcnt will only be increased once even if it contai=
ns multiple UE sub-pages.
> >> See __get_huge_page_for_hwpoison() for details. So folio_put() might b=
e called more times than
> >> folio_try_get() in __get_huge_page_for_hwpoison().
> >
> > The changes in folio_set_hugetlb_hwpoison() should make
> > __get_huge_page_for_hwpoison() not to take the "out" path which
> > decrease the increased refcount for folio. IOW, every time a new UE
> > happens, we handle the hugetlb page as if it is an in-use hugetlb
> > page.
>
> See below code snippet (comment [1] and [2]):
>
> int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>                                  bool *migratable_cleared)
> {
>         struct page *page =3D pfn_to_page(pfn);
>         struct folio *folio =3D page_folio(page);
>         int ret =3D 2;    /* fallback to normal page handling */
>         bool count_increased =3D false;
>
>         if (!folio_test_hugetlb(folio))
>                 goto out;
>
>         if (flags & MF_COUNT_INCREASED) {
>                 ret =3D 1;
>                 count_increased =3D true;
>         } else if (folio_test_hugetlb_freed(folio)) {
>                 ret =3D 0;
>         } else if (folio_test_hugetlb_migratable(folio)) {
>
>                    ^^^^*hugetlb_migratable is checked before trying to ge=
t folio refcnt* [1]
>
>                 ret =3D folio_try_get(folio);
>                 if (ret)
>                         count_increased =3D true;
>         } else {
>                 ret =3D -EBUSY;
>                 if (!(flags & MF_NO_RETRY))
>                         goto out;
>         }
>
>         if (folio_set_hugetlb_hwpoison(folio, page)) {
>                 ret =3D -EHWPOISON;
>                 goto out;
>         }
>
>         /*
>          * Clearing hugetlb_migratable for hwpoisoned hugepages to preven=
t them
>          * from being migrated by memory hotremove.
>          */
>         if (count_increased && folio_test_hugetlb_migratable(folio)) {
>                 folio_clear_hugetlb_migratable(folio);
>
>                 ^^^^^*hugetlb_migratable is cleared when first time seein=
g folio* [2]
>
>                 *migratable_cleared =3D true;
>         }
>
> Or am I miss something?

Thanks for your explaination! You are absolutely right. It turns out
the extra refcount I saw (during running hugetlb-mfr.c) on the folio
at the moment of filemap_offline_hwpoison_folio_hugetlb() is actually
because of the MF_COUNT_INCREASED during MADV_HWPOISON. In the past I
used to think that is the effect of folio_try_get() in
__get_huge_page_for_hwpoison(), and it is wrong. Now I see two cases:
- MADV_HWPOISON: instead of __get_huge_page_for_hwpoison(),
madvise_inject_error() is the one that increments hugepage refcount
for every error injected. Different from other cases,
MFD_MF_KEEP_UE_MAPPED makes the hugepage still a in-use page after
memory_failure(MF_COUNT_INCREASED), so I think madvise_inject_error()
should decrement in MFD_MF_KEEP_UE_MAPPED case.
- In the real world: as you pointed out, MF always just increments
hugepage refcount once in __get_huge_page_for_hwpoison(), even if it
runs into multiple errors. When
filemap_offline_hwpoison_folio_hugetlb() drops the refcount elevated
by filemap_get_folios(), it only needs to decrement again if
folio_ref_dec_and_test() returns false. I tested something like below:

    /* drop the refcount elevated by filemap_get_folios. */
    folio_put(folio);
    if (folio_ref_count(folio))
        folio_put(folio);
    /* now refcount should be zero. */
    ret =3D dissolve_free_hugetlb_folio(folio);

Besides, the good news is that
filemap_offline_hwpoison_folio_hugetlb() no longer needs to touch
raw_hwp_list.

>
> >
> >>
> >>> +             SetPageHWPoison(curr->page);
> >>
> >> If hugetlb folio vmemmap is optimized, I think SetPageHWPoison might t=
rigger BUG.
> >
> > Ah, I see, vmemmap optimization doesn't allow us to move flags from
> > raw_hwp_list to tail pages. I guess the best I can do is to bail out
> > if vmemmap is enabled like folio_clear_hugetlb_hwpoison().
>
> I think you can do this after hugetlb_vmemmap_restore_folio() is called.

Since I can get rid of the wrong folio_put() per raw HWPoison page, I
can just rely on dissolve_free_hugetlb_folio() to do the
hugetlb_vmemmap_restore_folio() and reuse the
folio_clear_hugetlb_hwpoison() code to move HWPoison flags to raw
pages.

I will do some more testing while preparing v4. Will also try if I can
avoid adding a speical cased folio_put() in madvise_inject_error().

>
> Thanks.
> .

