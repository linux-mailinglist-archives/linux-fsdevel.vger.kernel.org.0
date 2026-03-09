Return-Path: <linux-fsdevel+bounces-79803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD0uA63srmkWKQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 16:52:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB3623C1BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 16:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6F5F302173D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCE31E7C23;
	Mon,  9 Mar 2026 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oI9lHYZX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CB123AB88
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071248; cv=pass; b=Fsi0bVb70ibSdSfEDVgkQlmU62gM88k+GmsfdBVnBdO5T6DSWozuEKUuqrpfr6sHNdkVbENDYJmiDfR2CKBNRCtrk+fa5e9W1LZ0mPR/WYCxRg8LJ+JkvN05Z1bhYQ38QXZGge3MyYQF8y/hinGObb8uNLFmmy7xqQx3hco+EX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071248; c=relaxed/simple;
	bh=OX+Sj4Ey2OQv1RVhEjYT+aF4lDb3fVw/6s6OzQk/qEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXPs9Utktv2lpvzgGci/s2QzvUWZ7BFVZNFYkelxWnSHmcej4Zk9W0UJphuf88uX5ZePiKmB2rZJVudKxC7VUT4NiRNSleSS29Q2smqYUGE3YUgVxxrqb9vALhg7bdyt29JVKTSNK6Tbe6Gk2igV0TAArR3HJlxDvRBL78BGKI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oI9lHYZX; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-485317b6bd0so99155e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 08:47:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773071245; cv=none;
        d=google.com; s=arc-20240605;
        b=QrnDxiI/M81Ja4P+e+pnIoTdsyp9YJoo4N5hMlvxR6WhLj63SaoZ4r032HWPjbSshM
         Y/AboOGf2/JIpXAqrJKgDQeQM+9Ij7jxvoYqq1Dspr4EeV3zH9o8PhSZfBetK4/Du3RC
         yAAALrcGA+SSv4n2xHELUK8xWfHOSuHcXbw48jHt4tgghvmN8lP9y+jRD4FPIAzeiaZL
         vd+gLybR/ol8bGyvS6GLM0HEArW6y2oFCRabov5h51OGxxnlx2YfM5GoYtUBs0ti/T9P
         uKRSVnFIN75lQ8gkdrXTdOygWIhU0aYEz7LH5KKShrJlOOD/oBx3lD9ziRMxkwd60DjY
         8NFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lG/w5nH34EyLvyhitTi/enqIK8fRsce1UJOwmSqWnO8=;
        fh=VTE8k2P88TjM/tH7vAvkWhyIQnIz4tfwPLa9mzPl+gE=;
        b=BvxvCb+wRsX65/BRe4tlosWE6sqoWnqHV+s111zsqmqhgmyDhFpDmEU/xIWu77quQc
         2XTdBuKhpQjNHXZ6Ako60qUODuqyD6f+HFqp27IEfnNVmMYXBv1KxtBoy/8TPcGVDY8+
         4NgCx7FBEBAgUy4Y7gzo4RDNcad/UlRVRldPF3NZyITVSbwtVlhxvfmQbpPqQKrMRg7J
         vSqMzAc+9IicGq5cak3TQpcUxTGTuUpQlee9ZTY4RTNlLVTs2FFDllrWPa06JNcYF5WD
         YYlNQ0kU23bGvysWpIc1oMyiBk39ca+MiLDYUWTSCRwx+hgkWDvl2Lvzq1KhBHZsth1l
         i1lA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773071245; x=1773676045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG/w5nH34EyLvyhitTi/enqIK8fRsce1UJOwmSqWnO8=;
        b=oI9lHYZXlm4jJ/Da/6SR3wetaqu5pHfTNA0tStd/+s02TXwc9paojKrRhMaShAyuwW
         rTqC30ivGg+p1YnQJQu1mdtiE6VCSuZxY2amzTL+r4MWH5RO5y39fvqpJIrOxW9zRAwU
         6dxwrBE5v5xmuxjmgWrTTPbY5BmR57h6vIKQpaMmclCP7SgXlpi/8ZeqNmRLNhHwyEQ2
         IpN0OxaJoRsWigixh8DBgcOM+xcVjCvxI/Bpoj0dcS2rUvkXPYged85TUdy2rshRwW2l
         iqU5mCjVAyU/7jWcc+114Sd4PJe74pxzDYeytWDD05n8iN3nuHfKVMNIKids8kxzfNuv
         aZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773071245; x=1773676045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lG/w5nH34EyLvyhitTi/enqIK8fRsce1UJOwmSqWnO8=;
        b=Vj1oMpI6ISeZLbOXg+numSjSOxCW3EKekUi7eSae3iQ5uEhUPyiZg5vpqdp7AOdk81
         2cMsAA+5+qI8idN/4VV/naRnChRc2u+HxVl7WVkxv4sYu2UF+9BnfZSM4D7Vuy0Ey8lX
         SLjxy2u/MGTjcliHQDUUXEdIY9uhONmIaFDU5SoXqH8lr841SiaBciHvD+8CLhxjp6MI
         FtTKi4vaA8sBzYM5f3T5tVcF5OtEkkVCSGH4Nln0Mz0uIR3bQdi99edAn/tNebCXHfEP
         4xe8zYK0Kgv4c2uoIXIh4Y26WUGpMGFGtEK+vfMowmtwqU1npGdPaTpLonnGmPXFptMO
         mtSw==
X-Forwarded-Encrypted: i=1; AJvYcCVMjaS8veNjQ9K2ssYRg+n7dURdIAjHwSrNe/wWK7lh1OuPwatT+g9eVKWuAdYrn8R9HUz3MvqNhkLI2GXD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw365nR6C2YojMemXkkSwMxYGemSfkVdyUtG9cznGe2l0W/7ErB
	zP0JT3XcBExyIb0r61ubcWuIKupOv46wTuImC6yDU8X6exRCOtSgW7wLMYfv/Ku2qYDIIRQpMwS
	a5ofHIv3TPkt+FPMOQkQPhNXA47ATsJeKhno8avlw
X-Gm-Gg: ATEYQzy3O9N0tPAI3Y3OnCaz7Z+oOkNSiON7qaKi4BE8FLGlMzvGHybcCpyFFkpAoLl
	yrOxO06uEuomtYUOzXeD2WpKn6BTaIMIRwKcRd0YjhBOUDqwtctgW3fu6tcDcwZusGwD5IaVTQT
	1/fsvexlIThF0KJFB6rOr/B1f532UTmeujDkxWxCPJY/SS/C1tt0gwYiSKCm03BPazeH2ZoToFJ
	G1ghLBjitXKGdHfAZvQVFa98GY/bQjT1BwIAgXAMtSy4vtOPzPLiRaDw8Z7LnNEO/M5Hrhxo4R4
	fQzos/kg4ZOA27ycHlAME9s0f/UqYTj1XvQiB9E=
X-Received: by 2002:a05:600c:c171:b0:485:302f:f27f with SMTP id
 5b1f17b1804b1-485303007b7mr1934615e9.17.1773071244439; Mon, 09 Mar 2026
 08:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203192352.2674184-1-jiaqiyan@google.com> <20260203192352.2674184-2-jiaqiyan@google.com>
 <7ad34b69-2fb4-770b-14e5-bea13cf63d2f@huawei.com> <CACw3F50PwJ+sSOX0wySQgBzrEW2XOctxuX5jM37OG0HS_kHdbQ@mail.gmail.com>
 <31cc7bed-c30f-489c-3ac3-4842aa00b869@huawei.com> <CACw3F50BwnLJW75EXgz0t5g+eUhr+wKgJ3YfRFq5208N5KfaiA@mail.gmail.com>
 <a0d25caf-a18b-e3d8-e74f-fc18fa85252e@huawei.com> <CACw3F51+bAm03nvucV54bkThnYc-4ewgqGzq_c5i6oMmnGdEtw@mail.gmail.com>
 <a3ff8c7b-69c1-fecc-3564-ecaa3e8a7e67@huawei.com>
In-Reply-To: <a3ff8c7b-69c1-fecc-3564-ecaa3e8a7e67@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 9 Mar 2026 08:47:12 -0700
X-Gm-Features: AaiRm50LMW6sKrWbVlgM7Z4RSdPgjZRf5FHF4xv3HNCCFfBrg3jrKW38LOlQCIY
Message-ID: <CACw3F53qr1Af=r__SNxU1ohr69s8apHqHz9tcEHg1hDSLsk5TQ@mail.gmail.com>
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
X-Rspamd-Queue-Id: 7FB3623C1BE
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
	TAGGED_FROM(0.00)[bounces-79803-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 12:41=E2=80=AFAM Miaohe Lin <linmiaohe@huawei.com> w=
rote:
>
> On 2026/3/9 12:53, Jiaqi Yan wrote:
> > On Mon, Feb 23, 2026 at 11:30=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.c=
om> wrote:
> >>
> >> On 2026/2/13 13:01, Jiaqi Yan wrote:
> >>> On Mon, Feb 9, 2026 at 11:31=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.=
com> wrote:
> >>>>
> >>>> On 2026/2/10 12:47, Jiaqi Yan wrote:
> >>>>> On Mon, Feb 9, 2026 at 3:54=E2=80=AFAM Miaohe Lin <linmiaohe@huawei=
.com> wrote:
> >>>>>>
> >>>>>> On 2026/2/4 3:23, Jiaqi Yan wrote:
> >>>>>>> Sometimes immediately hard offlining a large chunk of contigous m=
emory
> >>>>>>> having uncorrected memory errors (UE) may not be the best option.
> >>>>>>> Cloud providers usually serve capacity- and performance-critical =
guest
> >>>>>>> memory with 1G HugeTLB hugepages, as this significantly reduces t=
he
> >>>>>>> overhead associated with managing page tables and TLB misses. How=
ever,
> >>>>>>> for today's HugeTLB system, once a byte of memory in a hugepage i=
s
> >>>>>>> hardware corrupted, the kernel discards the whole hugepage, inclu=
ding
> >>>>>>> the healthy portion. Customer workload running in the VM can hard=
ly
> >>>>>>> recover from such a great loss of memory.
> >>>>>>
> >>>>>> Thanks for your patch. Some questions below.
> >>>>>>
> >>>>>>>
> >>>>>>> Therefore keeping or discarding a large chunk of contiguous memor=
y
> >>>>>>> owned by userspace (particularly to serve guest memory) due to
> >>>>>>> recoverable UE may better be controlled by userspace process
> >>>>>>> that owns the memory, e.g. VMM in the Cloud environment.
> >>>>>>>
> >>>>>>> Introduce a memfd-based userspace memory failure (MFR) policy,
> >>>>>>> MFD_MF_KEEP_UE_MAPPED. It is possible to support for other memfd,
> >>>>>>> but the current implementation only covers HugeTLB.
> >>>>>>>
> >>>>>>> For a hugepage associated with MFD_MF_KEEP_UE_MAPPED enabled memf=
d,
> >>>>>>> whenever it runs into a new UE,
> >>>>>>>
> >>>>>>> * MFR defers hard offline operations, i.e., unmapping and
> >>>>>>
> >>>>>> So the folio can't be unpoisoned until hugetlb folio becomes free?
> >>>>>
> >>>>> Are you asking from testing perspective, are we still able to clean=
 up
> >>>>> injected test errors via unpoison_memory() with MFD_MF_KEEP_UE_MAPP=
ED?
> >>>>>
> >>>>> If so, unpoison_memory() can't turn the HWPoison hugetlb page to
> >>>>> normal hugetlb page as MFD_MF_KEEP_UE_MAPPED automatically dissolve=
s
> >>>>
> >>>> We might loss some testability but that should be an acceptable comp=
romise.
> >>>
> >>> To clarify, looking at unpoison_memory(), it seems unpoison should
> >>> still work if called before truncated or memfd closed.
> >>>
> >>> What I wanted to say is, for my test hugetlb-mfr.c, since I really
> >>> want to test the cleanup code (dissolving free hugepage having
> >>> multiple errors) after truncation or memfd closed, so we can only
> >>> unpoison the raw pages rejected by buddy allocator.
> >>>
> >>>>
> >>>>> it. unpoison_memory(pfn) can probably still turn the HWPoison raw p=
age
> >>>>> back to a normal one, but you already lost the hugetlb page.
> >>>>>
> >>>>>>
> >>>>>>>   dissolving. MFR still sets HWPoison flag, holds a refcount
> >>>>>>>   for every raw HWPoison page, record them in a list, sends SIGBU=
S
> >>>>>>>   to the consuming thread, but si_addr_lsb is reduced to PAGE_SHI=
FT.
> >>>>>>>   If userspace is able to handle the SIGBUS, the HWPoison hugepag=
e
> >>>>>>>   remains accessible via the mapping created with that memfd.
> >>>>>>>
> >>>>>>> * If the memory was not faulted in yet, the fault handler also
> >>>>>>>   allows fault in the HWPoison folio.
> >>>>>>>
> >>>>>>> For a MFD_MF_KEEP_UE_MAPPED enabled memfd, when it is closed, or
> >>>>>>> when userspace process truncates its hugepages:
> >>>>>>>
> >>>>>>> * When the HugeTLB in-memory file system removes the filemap's
> >>>>>>>   folios one by one, it asks MFR to deal with HWPoison folios
> >>>>>>>   on the fly, implemented by filemap_offline_hwpoison_folio().
> >>>>>>>
> >>>>>>> * MFR drops the refcounts being held for the raw HWPoison
> >>>>>>>   pages within the folio. Now that the HWPoison folio becomes
> >>>>>>>   free, MFR dissolves it into a set of raw pages. The healthy pag=
es
> >>>>>>>   are recycled into buddy allocator, while the HWPoison ones are
> >>>>>>>   prevented from re-allocation.
> >>>>>>>
> >>>>>> ...
> >>>>>>
> >>>>>>>
> >>>>>>> +static void filemap_offline_hwpoison_folio_hugetlb(struct folio =
*folio)
> >>>>>>> +{
> >>>>>>> +     int ret;
> >>>>>>> +     struct llist_node *head;
> >>>>>>> +     struct raw_hwp_page *curr, *next;
> >>>>>>> +
> >>>>>>> +     /*
> >>>>>>> +      * Since folio is still in the folio_batch, drop the refcou=
nt
> >>>>>>> +      * elevated by filemap_get_folios.
> >>>>>>> +      */
> >>>>>>> +     folio_put_refs(folio, 1);
> >>>>>>> +     head =3D llist_del_all(raw_hwp_list_head(folio));
> >>>>>>
> >>>>>> We might race with get_huge_page_for_hwpoison()? llist_add() might=
 be called
> >>>>>> by folio_set_hugetlb_hwpoison() just after llist_del_all()?
> >>>>>
> >>>>> Oh, when there is a new UE while we releasing the folio here, right=
?
> >>>>
> >>>> Right.
> >>>>
> >>>>> In that case, would mutex_lock(&mf_mutex) eliminate potential race?
> >>>>
> >>>> IMO spin_lock_irq(&hugetlb_lock) might be better.
> >>>
> >>> Looks like I don't need any lock given the correction below.
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>>> +
> >>>>>>> +     /*
> >>>>>>> +      * Release refcounts held by try_memory_failure_hugetlb, on=
e per
> >>>>>>> +      * HWPoison-ed page in the raw hwp list.
> >>>>>>> +      *
> >>>>>>> +      * Set HWPoison flag on each page so that free_has_hwpoison=
ed()
> >>>>>>> +      * can exclude them during dissolve_free_hugetlb_folio().
> >>>>>>> +      */
> >>>>>>> +     llist_for_each_entry_safe(curr, next, head, node) {
> >>>>>>> +             folio_put(folio);
> >>>>>>
> >>>>>> The hugetlb folio refcnt will only be increased once even if it co=
ntains multiple UE sub-pages.
> >>>>>> See __get_huge_page_for_hwpoison() for details. So folio_put() mig=
ht be called more times than
> >>>>>> folio_try_get() in __get_huge_page_for_hwpoison().
> >>>>>
> >>>>> The changes in folio_set_hugetlb_hwpoison() should make
> >>>>> __get_huge_page_for_hwpoison() not to take the "out" path which
> >>>>> decrease the increased refcount for folio. IOW, every time a new UE
> >>>>> happens, we handle the hugetlb page as if it is an in-use hugetlb
> >>>>> page.
> >>>>
> >>>> See below code snippet (comment [1] and [2]):
> >>>>
> >>>> int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
> >>>>                                  bool *migratable_cleared)
> >>>> {
> >>>>         struct page *page =3D pfn_to_page(pfn);
> >>>>         struct folio *folio =3D page_folio(page);
> >>>>         int ret =3D 2;    /* fallback to normal page handling */
> >>>>         bool count_increased =3D false;
> >>>>
> >>>>         if (!folio_test_hugetlb(folio))
> >>>>                 goto out;
> >>>>
> >>>>         if (flags & MF_COUNT_INCREASED) {
> >>>>                 ret =3D 1;
> >>>>                 count_increased =3D true;
> >>>>         } else if (folio_test_hugetlb_freed(folio)) {
> >>>>                 ret =3D 0;
> >>>>         } else if (folio_test_hugetlb_migratable(folio)) {
> >>>>
> >>>>                    ^^^^*hugetlb_migratable is checked before trying =
to get folio refcnt* [1]
> >>>>
> >>>>                 ret =3D folio_try_get(folio);
> >>>>                 if (ret)
> >>>>                         count_increased =3D true;
> >>>>         } else {
> >>>>                 ret =3D -EBUSY;
> >>>>                 if (!(flags & MF_NO_RETRY))
> >>>>                         goto out;
> >>>>         }
> >>>>
> >>>>         if (folio_set_hugetlb_hwpoison(folio, page)) {
> >>>>                 ret =3D -EHWPOISON;
> >>>>                 goto out;
> >>>>         }
> >>>>
> >>>>         /*
> >>>>          * Clearing hugetlb_migratable for hwpoisoned hugepages to p=
revent them
> >>>>          * from being migrated by memory hotremove.
> >>>>          */
> >>>>         if (count_increased && folio_test_hugetlb_migratable(folio))=
 {
> >>>>                 folio_clear_hugetlb_migratable(folio);
> >>>>
> >>>>                 ^^^^^*hugetlb_migratable is cleared when first time =
seeing folio* [2]
> >>>>
> >>>>                 *migratable_cleared =3D true;
> >>>>         }
> >>>>
> >>>> Or am I miss something?
> >>>
> >>> Thanks for your explaination! You are absolutely right. It turns out
> >>> the extra refcount I saw (during running hugetlb-mfr.c) on the folio
> >>> at the moment of filemap_offline_hwpoison_folio_hugetlb() is actually
> >>> because of the MF_COUNT_INCREASED during MADV_HWPOISON. In the past I
> >>> used to think that is the effect of folio_try_get() in
> >>> __get_huge_page_for_hwpoison(), and it is wrong. Now I see two cases:
> >>> - MADV_HWPOISON: instead of __get_huge_page_for_hwpoison(),
> >>> madvise_inject_error() is the one that increments hugepage refcount
> >>> for every error injected. Different from other cases,
> >>> MFD_MF_KEEP_UE_MAPPED makes the hugepage still a in-use page after
> >>> memory_failure(MF_COUNT_INCREASED), so I think madvise_inject_error()
> >>> should decrement in MFD_MF_KEEP_UE_MAPPED case.
> >>> - In the real world: as you pointed out, MF always just increments
> >>> hugepage refcount once in __get_huge_page_for_hwpoison(), even if it
> >>> runs into multiple errors. When
> >>
> >> This might not always hold true. When MF occurs while hugetlb folio is=
 under isolation(hugetlb_migratable is
> >> cleared and extra folio refcnt is held by isolating code in that case)=
, __get_huge_page_for_hwpoison won't get
> >> extra folio refcnt.
> >>
> >>> filemap_offline_hwpoison_folio_hugetlb() drops the refcount elevated
> >>> by filemap_get_folios(), it only needs to decrement again if
> >>> folio_ref_dec_and_test() returns false. I tested something like below=
:
> >>>
> >>>     /* drop the refcount elevated by filemap_get_folios. */
> >>>     folio_put(folio);
> >>>     if (folio_ref_count(folio))
> >>>         folio_put(folio);
> >>>     /* now refcount should be zero. */
> >>>     ret =3D dissolve_free_hugetlb_folio(folio);
> >>
> >> So I think above code might drop the folio refcnt held by isolating co=
de.
> >
> > Hi Miaohe, thanks for raising the concern. Given two things below
> > - both folio_isolate_hugetlb() and get_huge_page_for_hwpoison() are
> > guarded by hugetlb_lock.
> > - hugetlb_update_hwpoison() only folio_test_set_hwpoison() for
> > non-isolated folio after folio_try_get() succeeds.
> >
> > as long as folio_test_set_hwpoison() is true here, this refcount
> > should never come from folio_isolate_hugetlb(). What do you think?
> >
>
> Let's think about below scenario. When __get_huge_page_for_hwpoison() enc=
ounters an
> isolated hugetlb folio:
>
> int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>                                  bool *migratable_cleared)
> {
>         struct page *page =3D pfn_to_page(pfn);
>         struct folio *folio =3D page_folio(page);
>         bool count_increased =3D false;
>         int ret, rc;
>
>         if (!folio_test_hugetlb(folio)) {
>                 ret =3D MF_HUGETLB_NON_HUGEPAGE;
>                 goto out;
>         } else if (flags & MF_COUNT_INCREASED) {
>                 ret =3D MF_HUGETLB_IN_USED;
>                 count_increased =3D true;
>         } else if (folio_test_hugetlb_freed(folio)) {
>                 ret =3D MF_HUGETLB_FREED;
>         } else if (folio_test_hugetlb_migratable(folio)) {
>
>                    ^^^^*Since hugetlb_migratable is cleared for the isola=
ted hugetlb folio*
>
>                 if (folio_try_get(folio)) {
>                         ret =3D MF_HUGETLB_IN_USED;
>                         count_increased =3D true;
>                 } else {
>                         ret =3D MF_HUGETLB_FREED;
>                 }
>         } else {
>
>                   ^^^^*Code will reach here without extra refcnt increase=
d*
>
>                 ret =3D MF_HUGETLB_RETRY;
>                 if (!(flags & MF_NO_RETRY))
>                         goto out;
>         }
>
>         *Code will reach here after retry*

You are right, thanks for pointing that out. Let me think about more
how to handle this.

>         rc =3D hugetlb_update_hwpoison(folio, page);
>         if (rc >=3D MF_HUGETLB_FOLIO_PRE_POISONED) {
>                 ret =3D rc;
>                 goto out;
>         }
>
> So hugetlb_update_hwpoison() will be called even for folio under isolatio=
n
> without folio_try_get(). Or am I miss something?

Just a random question: if MF never increments a hugepage's refcount,
what does the folio_put() in me_huge_page() (when mapping =3D null) do?
Is it dropping for something other than MF?

>
> Thanks.
> .

