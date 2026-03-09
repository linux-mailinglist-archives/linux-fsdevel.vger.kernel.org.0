Return-Path: <linux-fsdevel+bounces-79729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNcXLF1SrmkMCQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 05:53:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EFD233BE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 05:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2597301E6F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 04:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8205E2D29B7;
	Mon,  9 Mar 2026 04:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikXdBxm3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7742C2010EE
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 04:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773032021; cv=pass; b=khuy7xN1S/DQxU9+1BmGqCE7Q5pIUBmrDjXNQIMCAb5RTGoFJkTiV81UXkDvXJ8Rd3B5PlXCAIzRonKld3Sdm+2CuMiURYRODDNoRws/Oy/pJe/d9EVsiO3fkoPoQJXkHbFqsapBzVwpn+vNJTDZfD4XHvAaDL7vtn4uK9XHV30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773032021; c=relaxed/simple;
	bh=xyG34UPg5b+tiwn/Yl8icGhEesX7YxcM7czzNU5ByLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqAkUjPQ/fHkEy8xqc3OJRzxtaglCB6Ov061sDvM3dEBzpbYi3cgVpoTJZms0pC+mXP4d9IWcD/6bUM+jwLwg0uYJWKleCQ3wd21UcGXwg/M9zEUbIGN4HZ9df1fpbKySpSWFO8nYQn/Hv2CBlMWvB6pAC6AGRONSCzKxD8eK0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ikXdBxm3; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4852af55981so88755e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Mar 2026 21:53:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773032018; cv=none;
        d=google.com; s=arc-20240605;
        b=YDmyCOmnsegXaMPrTBSChgh3uOmvDp1bHvLUQcp18YH3JSRkvFdcGvYcRrRDbKHkgg
         P1dhZNZo04qUZ8hyVN/4ThFT3jrNC+OWFxINKWCcdO151ZJtFxFjQaoyOpW6LKQ0oCKl
         32q6pzyLT4CYTirdcgzEumBNHamnIXBn5OgxBMsmdMMHLLYqCgh+HkP59C9SxhbIZIMh
         FOEVwHwZdiqI2TO3rVMotb5mF8jlEpCtv0BUZRfLW4kBbK2A8JaRi/ocXAdIQepnXMrQ
         hcrKMqJ51xkU2KniilJ+l12XU6C3OzlZjMC/SQz4wkgdlfqBh3XOkZbyBnhhx2jYQ2Y2
         gryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YKTCl3ZZHhLgk1TZ61Z+cLelMYdC4TOsqAIQ4YfDLnE=;
        fh=xhRZmyHWWP5NwH2vR8dgXSr9z7RWwh8cky0G72pgK6Q=;
        b=Ce2z45LEv/jRKSpXqRngiux/YTH596jjvEX+APwhbme6+JSHsumc/Vp91FHWjJh00F
         tq4xNMsEQo0cp+xYNw/WXr3OwBP8LfKp6KGPL6R6SWF33WWAu7AOJ1GrJtrM1F+xeT0J
         KjDekzZAGFScUDOEz1X+Y3qj1hllAdeb89kkQR0G7J1/raOo+9j2mMNeYdqwMO1ss5V+
         ORQUBs11glMwd9BhcgGry3p0tOiyNQ59IIcaNeXWk7T8gz3aSpFD3Nwdw/qOqmx+bX4p
         phXBdNwLSQg9nDh+iM7kBktb/ejlP22NOh8Jh7go4SO0gh4K00bY+PN9wt/cv2GZj7GD
         LD9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773032018; x=1773636818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKTCl3ZZHhLgk1TZ61Z+cLelMYdC4TOsqAIQ4YfDLnE=;
        b=ikXdBxm3iUj+AJa1EBeK4h2G/4E/FjbR4rlymGUKr6pGd3Drde2JVhHwYHmRhrChJ7
         I3niMUuhUWUDFgUMbfQMmsgowI8kISXdNb4GpYy46HF1s3B/juGyWh4qhykNZEH1qwPY
         DkgdRvRuvy2ScrQWzdU8Z4FsPtrVx6ctItl8UIn2ZBDYw14qrvIMwAPSBo+5I56i3U7w
         Im822wYGi3YlKHOcJsWDP1E+uKXxCJCgUzbTfq2Xaq0A2L3vag6ew0GNa3qaI3b0Fz15
         5vDGWMQR3MX0r4Ev7HzcnoxSZhrcSydFiL1RvLm8sgHPCJ6kLcZutEl4cNkk5U6PANyF
         wo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773032018; x=1773636818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YKTCl3ZZHhLgk1TZ61Z+cLelMYdC4TOsqAIQ4YfDLnE=;
        b=wRmzy1WiSozJL3wN5epxf2iXUC46rG4HbFTKCVp77vbztGv1loooMbz5tM3Wqu6oyL
         jnMdf5h2SUMj+4f82JeMT6wF/5MHYCMCnvzY1CB87nRC74tZGnWDwkC1RCbdXGm3dbJj
         +jFD8AS0cRi7EqWELMCzlB0q1/w1oOjwrDm4clp70NKiCV9Y9CwvlQQ3MMF0FhBNcm9x
         +WtzHs4jVD1OiDzG7q937kZLUoQJffIqQJqpKV1txozGurxiPgt6iHoCWMa9ZgiXQ0x/
         ArF/ifDV4o6pVJI2WKalk2S85FypTJYCIyanqdFJCFzb0np7dYn/96Tuded/ml8lLNLh
         2fYw==
X-Forwarded-Encrypted: i=1; AJvYcCXS5UGrKpl20teIn3TImsUrhTFYtTud2Ps/MG8SYDD8y2sYZF/5MNr5T/WnIzKowKxU7DuSdPMfkhk7B+Ae@vger.kernel.org
X-Gm-Message-State: AOJu0Yyclp42Py6zuWJV7TQsTmTCVYWkKb5HfKo3PWvpcftcpu6TbXbo
	FpszEAUHY+6AWGBFoAC0ZYmx7BB8iFWn7kqLC7fMs8dNg8UCMTu7nq78mAsz2Rt5mN2TuhjLFxP
	uL+7+ktxAlwPgQCsrYzo6nCK9HwZG17tqPpBRRXmj
X-Gm-Gg: ATEYQzyn3JCkEBq+eKFE3fGlzh7mTUOUMhE3ZwUoRheLEEQFsseCOLzJPpbAhUe30DY
	aHW7RMq/Fjtcu8M111QPhGWMHRPQ/soo/hst/8N3piFNydsefcpFvr+Nzw0A3If4u6yIsWrjI+B
	E9F/TF6zMOtvR52CyMNivwASZxsZ19Y++NYIe7dYugCdfylWg8vng/y6fi/gQfytYnDrjILUMJI
	bShmDdaVLsxHQeo2FBp+4XMRbh+c0T5cAK/twxQrdx3+HEKY3yf1+fqbSBDDmXNCoq12ElYMf0l
	ckXYrrtyvROJc21DAxgujdyTVrAhaNtamDsDmOc=
X-Received: by 2002:a05:600c:3b86:b0:483:6f85:b16e with SMTP id
 5b1f17b1804b1-4852e45a28dmr1925675e9.3.1773032017478; Sun, 08 Mar 2026
 21:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203192352.2674184-1-jiaqiyan@google.com> <20260203192352.2674184-2-jiaqiyan@google.com>
 <7ad34b69-2fb4-770b-14e5-bea13cf63d2f@huawei.com> <CACw3F50PwJ+sSOX0wySQgBzrEW2XOctxuX5jM37OG0HS_kHdbQ@mail.gmail.com>
 <31cc7bed-c30f-489c-3ac3-4842aa00b869@huawei.com> <CACw3F50BwnLJW75EXgz0t5g+eUhr+wKgJ3YfRFq5208N5KfaiA@mail.gmail.com>
 <a0d25caf-a18b-e3d8-e74f-fc18fa85252e@huawei.com>
In-Reply-To: <a0d25caf-a18b-e3d8-e74f-fc18fa85252e@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Sun, 8 Mar 2026 21:53:25 -0700
X-Gm-Features: AaiRm52OugVEfS8g75Px5seZ5I3SYFZ1Jdyd2NzqUgRjpWBwmGWtg6DYu0FRfQg
Message-ID: <CACw3F51+bAm03nvucV54bkThnYc-4ewgqGzq_c5i6oMmnGdEtw@mail.gmail.com>
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
X-Rspamd-Queue-Id: 12EFD233BE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79729-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,huawei.com,infradead.org,linux-foundation.org,suse.de,google.com,nvidia.com,redhat.com,oracle.com,linux.intel.com,linux.dev,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiaqiyan@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,huawei.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 11:30=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> =
wrote:
>
> On 2026/2/13 13:01, Jiaqi Yan wrote:
> > On Mon, Feb 9, 2026 at 11:31=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.co=
m> wrote:
> >>
> >> On 2026/2/10 12:47, Jiaqi Yan wrote:
> >>> On Mon, Feb 9, 2026 at 3:54=E2=80=AFAM Miaohe Lin <linmiaohe@huawei.c=
om> wrote:
> >>>>
> >>>> On 2026/2/4 3:23, Jiaqi Yan wrote:
> >>>>> Sometimes immediately hard offlining a large chunk of contigous mem=
ory
> >>>>> having uncorrected memory errors (UE) may not be the best option.
> >>>>> Cloud providers usually serve capacity- and performance-critical gu=
est
> >>>>> memory with 1G HugeTLB hugepages, as this significantly reduces the
> >>>>> overhead associated with managing page tables and TLB misses. Howev=
er,
> >>>>> for today's HugeTLB system, once a byte of memory in a hugepage is
> >>>>> hardware corrupted, the kernel discards the whole hugepage, includi=
ng
> >>>>> the healthy portion. Customer workload running in the VM can hardly
> >>>>> recover from such a great loss of memory.
> >>>>
> >>>> Thanks for your patch. Some questions below.
> >>>>
> >>>>>
> >>>>> Therefore keeping or discarding a large chunk of contiguous memory
> >>>>> owned by userspace (particularly to serve guest memory) due to
> >>>>> recoverable UE may better be controlled by userspace process
> >>>>> that owns the memory, e.g. VMM in the Cloud environment.
> >>>>>
> >>>>> Introduce a memfd-based userspace memory failure (MFR) policy,
> >>>>> MFD_MF_KEEP_UE_MAPPED. It is possible to support for other memfd,
> >>>>> but the current implementation only covers HugeTLB.
> >>>>>
> >>>>> For a hugepage associated with MFD_MF_KEEP_UE_MAPPED enabled memfd,
> >>>>> whenever it runs into a new UE,
> >>>>>
> >>>>> * MFR defers hard offline operations, i.e., unmapping and
> >>>>
> >>>> So the folio can't be unpoisoned until hugetlb folio becomes free?
> >>>
> >>> Are you asking from testing perspective, are we still able to clean u=
p
> >>> injected test errors via unpoison_memory() with MFD_MF_KEEP_UE_MAPPED=
?
> >>>
> >>> If so, unpoison_memory() can't turn the HWPoison hugetlb page to
> >>> normal hugetlb page as MFD_MF_KEEP_UE_MAPPED automatically dissolves
> >>
> >> We might loss some testability but that should be an acceptable compro=
mise.
> >
> > To clarify, looking at unpoison_memory(), it seems unpoison should
> > still work if called before truncated or memfd closed.
> >
> > What I wanted to say is, for my test hugetlb-mfr.c, since I really
> > want to test the cleanup code (dissolving free hugepage having
> > multiple errors) after truncation or memfd closed, so we can only
> > unpoison the raw pages rejected by buddy allocator.
> >
> >>
> >>> it. unpoison_memory(pfn) can probably still turn the HWPoison raw pag=
e
> >>> back to a normal one, but you already lost the hugetlb page.
> >>>
> >>>>
> >>>>>   dissolving. MFR still sets HWPoison flag, holds a refcount
> >>>>>   for every raw HWPoison page, record them in a list, sends SIGBUS
> >>>>>   to the consuming thread, but si_addr_lsb is reduced to PAGE_SHIFT=
.
> >>>>>   If userspace is able to handle the SIGBUS, the HWPoison hugepage
> >>>>>   remains accessible via the mapping created with that memfd.
> >>>>>
> >>>>> * If the memory was not faulted in yet, the fault handler also
> >>>>>   allows fault in the HWPoison folio.
> >>>>>
> >>>>> For a MFD_MF_KEEP_UE_MAPPED enabled memfd, when it is closed, or
> >>>>> when userspace process truncates its hugepages:
> >>>>>
> >>>>> * When the HugeTLB in-memory file system removes the filemap's
> >>>>>   folios one by one, it asks MFR to deal with HWPoison folios
> >>>>>   on the fly, implemented by filemap_offline_hwpoison_folio().
> >>>>>
> >>>>> * MFR drops the refcounts being held for the raw HWPoison
> >>>>>   pages within the folio. Now that the HWPoison folio becomes
> >>>>>   free, MFR dissolves it into a set of raw pages. The healthy pages
> >>>>>   are recycled into buddy allocator, while the HWPoison ones are
> >>>>>   prevented from re-allocation.
> >>>>>
> >>>> ...
> >>>>
> >>>>>
> >>>>> +static void filemap_offline_hwpoison_folio_hugetlb(struct folio *f=
olio)
> >>>>> +{
> >>>>> +     int ret;
> >>>>> +     struct llist_node *head;
> >>>>> +     struct raw_hwp_page *curr, *next;
> >>>>> +
> >>>>> +     /*
> >>>>> +      * Since folio is still in the folio_batch, drop the refcount
> >>>>> +      * elevated by filemap_get_folios.
> >>>>> +      */
> >>>>> +     folio_put_refs(folio, 1);
> >>>>> +     head =3D llist_del_all(raw_hwp_list_head(folio));
> >>>>
> >>>> We might race with get_huge_page_for_hwpoison()? llist_add() might b=
e called
> >>>> by folio_set_hugetlb_hwpoison() just after llist_del_all()?
> >>>
> >>> Oh, when there is a new UE while we releasing the folio here, right?
> >>
> >> Right.
> >>
> >>> In that case, would mutex_lock(&mf_mutex) eliminate potential race?
> >>
> >> IMO spin_lock_irq(&hugetlb_lock) might be better.
> >
> > Looks like I don't need any lock given the correction below.
> >
> >>
> >>>
> >>>>
> >>>>> +
> >>>>> +     /*
> >>>>> +      * Release refcounts held by try_memory_failure_hugetlb, one =
per
> >>>>> +      * HWPoison-ed page in the raw hwp list.
> >>>>> +      *
> >>>>> +      * Set HWPoison flag on each page so that free_has_hwpoisoned=
()
> >>>>> +      * can exclude them during dissolve_free_hugetlb_folio().
> >>>>> +      */
> >>>>> +     llist_for_each_entry_safe(curr, next, head, node) {
> >>>>> +             folio_put(folio);
> >>>>
> >>>> The hugetlb folio refcnt will only be increased once even if it cont=
ains multiple UE sub-pages.
> >>>> See __get_huge_page_for_hwpoison() for details. So folio_put() might=
 be called more times than
> >>>> folio_try_get() in __get_huge_page_for_hwpoison().
> >>>
> >>> The changes in folio_set_hugetlb_hwpoison() should make
> >>> __get_huge_page_for_hwpoison() not to take the "out" path which
> >>> decrease the increased refcount for folio. IOW, every time a new UE
> >>> happens, we handle the hugetlb page as if it is an in-use hugetlb
> >>> page.
> >>
> >> See below code snippet (comment [1] and [2]):
> >>
> >> int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
> >>                                  bool *migratable_cleared)
> >> {
> >>         struct page *page =3D pfn_to_page(pfn);
> >>         struct folio *folio =3D page_folio(page);
> >>         int ret =3D 2;    /* fallback to normal page handling */
> >>         bool count_increased =3D false;
> >>
> >>         if (!folio_test_hugetlb(folio))
> >>                 goto out;
> >>
> >>         if (flags & MF_COUNT_INCREASED) {
> >>                 ret =3D 1;
> >>                 count_increased =3D true;
> >>         } else if (folio_test_hugetlb_freed(folio)) {
> >>                 ret =3D 0;
> >>         } else if (folio_test_hugetlb_migratable(folio)) {
> >>
> >>                    ^^^^*hugetlb_migratable is checked before trying to=
 get folio refcnt* [1]
> >>
> >>                 ret =3D folio_try_get(folio);
> >>                 if (ret)
> >>                         count_increased =3D true;
> >>         } else {
> >>                 ret =3D -EBUSY;
> >>                 if (!(flags & MF_NO_RETRY))
> >>                         goto out;
> >>         }
> >>
> >>         if (folio_set_hugetlb_hwpoison(folio, page)) {
> >>                 ret =3D -EHWPOISON;
> >>                 goto out;
> >>         }
> >>
> >>         /*
> >>          * Clearing hugetlb_migratable for hwpoisoned hugepages to pre=
vent them
> >>          * from being migrated by memory hotremove.
> >>          */
> >>         if (count_increased && folio_test_hugetlb_migratable(folio)) {
> >>                 folio_clear_hugetlb_migratable(folio);
> >>
> >>                 ^^^^^*hugetlb_migratable is cleared when first time se=
eing folio* [2]
> >>
> >>                 *migratable_cleared =3D true;
> >>         }
> >>
> >> Or am I miss something?
> >
> > Thanks for your explaination! You are absolutely right. It turns out
> > the extra refcount I saw (during running hugetlb-mfr.c) on the folio
> > at the moment of filemap_offline_hwpoison_folio_hugetlb() is actually
> > because of the MF_COUNT_INCREASED during MADV_HWPOISON. In the past I
> > used to think that is the effect of folio_try_get() in
> > __get_huge_page_for_hwpoison(), and it is wrong. Now I see two cases:
> > - MADV_HWPOISON: instead of __get_huge_page_for_hwpoison(),
> > madvise_inject_error() is the one that increments hugepage refcount
> > for every error injected. Different from other cases,
> > MFD_MF_KEEP_UE_MAPPED makes the hugepage still a in-use page after
> > memory_failure(MF_COUNT_INCREASED), so I think madvise_inject_error()
> > should decrement in MFD_MF_KEEP_UE_MAPPED case.
> > - In the real world: as you pointed out, MF always just increments
> > hugepage refcount once in __get_huge_page_for_hwpoison(), even if it
> > runs into multiple errors. When
>
> This might not always hold true. When MF occurs while hugetlb folio is un=
der isolation(hugetlb_migratable is
> cleared and extra folio refcnt is held by isolating code in that case), _=
_get_huge_page_for_hwpoison won't get
> extra folio refcnt.
>
> > filemap_offline_hwpoison_folio_hugetlb() drops the refcount elevated
> > by filemap_get_folios(), it only needs to decrement again if
> > folio_ref_dec_and_test() returns false. I tested something like below:
> >
> >     /* drop the refcount elevated by filemap_get_folios. */
> >     folio_put(folio);
> >     if (folio_ref_count(folio))
> >         folio_put(folio);
> >     /* now refcount should be zero. */
> >     ret =3D dissolve_free_hugetlb_folio(folio);
>
> So I think above code might drop the folio refcnt held by isolating code.

Hi Miaohe, thanks for raising the concern. Given two things below
- both folio_isolate_hugetlb() and get_huge_page_for_hwpoison() are
guarded by hugetlb_lock.
- hugetlb_update_hwpoison() only folio_test_set_hwpoison() for
non-isolated folio after folio_try_get() succeeds.

as long as folio_test_set_hwpoison() is true here, this refcount
should never come from folio_isolate_hugetlb(). What do you think?

For folio under isolation, MF ignores it without
folio_test_set_hwpoison(), and
filemap_offline_hwpoison_folio_hugetlb() won't happen at all.
For HWPoison folio, MF has made the folio no longer being able to
isolate/migrate.

>
> Thanks.
> .

