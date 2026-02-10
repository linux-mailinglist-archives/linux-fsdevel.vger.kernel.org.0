Return-Path: <linux-fsdevel+bounces-76807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEc5IXC4imkCNQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 05:47:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD58116E8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 05:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3521302411F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 04:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EDF32AADF;
	Tue, 10 Feb 2026 04:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="21VyuBmK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFEA284898
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770698837; cv=pass; b=duQd8iU9+AUUiiVqGfI7hLlHqPn0i4UnDpKD1EWeiCTi/6VvvxfZLCHFVH8VESgEVp8AJ351WY+JBTK/eU5FYM5tirCacZDJQRBm2qqR6497KVNSCiOE3zXQaxOTjkrB2nrcrVyb4vvTEd6+P5Y9eidFQi/zzmG115TB/6aUNOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770698837; c=relaxed/simple;
	bh=c6ihwfVgG+f8JUNLLI1YUybGrPBfRQTmZzmDnu+dN2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Addbogh0w45hOSp1bEz8d701NwfPWqayCkmaoYs6D0smlRp4ohJxxqrRvTJzm2LAISn03mK2eimDtTS//OpQyF06CagJ4yJIBen/LklA0kblg6YfAMtbcoYkd0z7wHUVipfm3zwn1JX6bpRLUA8wKA0ZruGOgwOAzD1HfXgWSrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=21VyuBmK; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48324da63b9so28455e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 20:47:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770698834; cv=none;
        d=google.com; s=arc-20240605;
        b=E9/A8Iz10ssbHntIuNwDxuRM/F7pWpG4wimrlg01/WJmI2bxUaVHElRUDLh/Egwxrl
         7ZZbO3CoPKzshJ8OBsOvFHQN9DHoNNI37vRfO9f/KDVkouK4o0iCGbDvrIBPskVAIx10
         1KZ0JUjJfM512lVLBH6XB9cLv8KayEb3mrO3rU09L2zZUzV6y2YnNnNar+vtW4DUIBFj
         HrG/ynM4D11TZ7vg3DvT/ezniQTccD712Lno+/gqZcV67bs1PQqS/BbIYrLutGdxG7R6
         T0YFz8Ia6Qhq+FJeUEhydiHvwQsIFOJ0zlaSJTV5neczZVewwFCfrj0QmMZwpMgHGgfA
         Ukbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NaTvCCyL2SECSfcnxtPR3yusX8hMpPBJMqgLEmTvlFU=;
        fh=POBCeHc9wvc07gUyfeW2Z1r81U20gqkB7yBaWN4eyqc=;
        b=h87PvXuZ1+o2uf79uYcKAfBOOZ0soVhrmbCu3U0Hv++Cd30aRJwkhFfD6RPJ1PeU1Z
         2gsWt7Zo211ZuF3QxERCUPeuSkpqhKz3kfgcyh4Vy6e8l3JsFWO64cfcB9ui6Rqj3rfq
         1zXnphZSI++pwn7TpNoJPXszzRHt77SOgOI1+pfEXPZy/wlVfMnDDUQki3b4gsoHtnc4
         i4JpbCOqEsj2XSaAFsFHMigY0DP3ghEf5Me1FP3urWajkWseVZWHpHt57Mm7Tr/GXl/3
         3w7tnRZxdOJq0KKs+gzIHXAkm1lIwvJ//acoy0IyNd2ob2bgMJtpfEu3hHWrSQVI+wbf
         TbAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770698834; x=1771303634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaTvCCyL2SECSfcnxtPR3yusX8hMpPBJMqgLEmTvlFU=;
        b=21VyuBmKdFye536URWzcrgxJNgZp3hhzN47lr8v/mQ3G6O3MOvc7/zOkT3+6nOEbe/
         IkHawMLbc58ER/+NeNHPhpWavhJR50wSI0S0ovVYs//uT5UG4qwza5EQbBX8mfLOupRs
         Hp/aM1QXCSkW3TGDs45E8Cc9SIJN9vNn50v5n4BKDTDg1qevt6UzLGsgkanmUuV8x2Dy
         xJ+QsJI8pAW5EsQ85+i94vwZF8azNTMfZ5B+TXjOC96guU52di8xtdVM1phtwYAE33xF
         rATefc5XtLpU/WGCpE/iO+wOYBTl1HVZ3IYmxB5Am5Hv/c8MlOGamRFr9T8sp0ZdngRV
         qrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770698834; x=1771303634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NaTvCCyL2SECSfcnxtPR3yusX8hMpPBJMqgLEmTvlFU=;
        b=b0Va/ISuPBqU3A1OgnxTi8wHiR9ulqTvwLb+xKqljgdzbZ56Die3jr8a/pGH8bK8va
         ftzaBTAYATkEoKrjUGHA6f9RIRjqrz/ZE27m/htAZyx+S9ZcM3PRr/SjnSS5tIXvrUML
         6zJvkcElMRm/qYEmRS6Yvi14chLYg/Hti9NKguw2DxnhEEVIvAFJqaHrDNZWDlo3m5qb
         iGYkxr7BYMueYbIRuHA5fEmDglvL0nuGqbgqAY3Q79u8SLOcW9U0LRa8MnAsrcsR8h/2
         wjXpiiJ/tGaIuOUn6kWa9Rv0+pDviWIFMi/GxgImDhkIECaTZL+VN978xjFJwp3cLozJ
         9Hmg==
X-Forwarded-Encrypted: i=1; AJvYcCUzwgKS0e7TAqefelXI/hbLWls4jMKkCvJM8LXUU0e+JH/kW50+dZVPhLJk+9EHfvfyPIBntLCGeVGxFeaz@vger.kernel.org
X-Gm-Message-State: AOJu0YwXCKTfMEF5Nxu9NuLqueqlZihkV9nT8xqn+5Eaf7x1o4TSg7EM
	+/zK+rKg2DGhCZ1kTN4Q0xodCvkKQdkowf64fHYVbnfxbnQYA3Fhpcrvou1CbdtWHrhrWkubE+h
	lvqxJkdsMgBnDYdpJLrqeZUKJYll6OR4Ww2oWTAiQ
X-Gm-Gg: AZuq6aLkloxmbWjQtByzS85oMEPSde3mW1adU7VhxjDkDGfeunDaAVlTP2byx1Ar2yP
	Gj1+UuNH+6NngIldtThX5W9zjDBkzj3CHcl8xtoE3mqi+MlZhZybWpnmogcBTiY4RJkd7pQM5b/
	beGV2k3LqlIKTz6TQyKzmhpDG+BBxUfeQ3TDRApsmT3IKHkbc0gMMwaKEGAMoVfsAPHVbnmV69j
	J1wtoKkDdIae38vBWW7z49XOfJSVpLkNDIuSVj024PzucvdTzRKKJnAXffF+FH0C73OZuIIMbkf
	OEhSWkZp1dJ/cWsSxa66cX6dlAm4YTPbfY9RHNod
X-Received: by 2002:a05:600c:17c3:b0:477:b358:d7aa with SMTP id
 5b1f17b1804b1-4834efc30c2mr283185e9.18.1770698833730; Mon, 09 Feb 2026
 20:47:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203192352.2674184-1-jiaqiyan@google.com> <20260203192352.2674184-2-jiaqiyan@google.com>
 <7ad34b69-2fb4-770b-14e5-bea13cf63d2f@huawei.com>
In-Reply-To: <7ad34b69-2fb4-770b-14e5-bea13cf63d2f@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 9 Feb 2026 20:47:01 -0800
X-Gm-Features: AZwV_QjdqW_fxGf25INcby_KBRQEkpKFKpIh5TStYvQvKDlNDRUknJQJqJFGxlQ
Message-ID: <CACw3F50PwJ+sSOX0wySQgBzrEW2XOctxuX5jM37OG0HS_kHdbQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76807-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: CFD58116E8D
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 3:54=E2=80=AFAM Miaohe Lin <linmiaohe@huawei.com> wr=
ote:
>
> On 2026/2/4 3:23, Jiaqi Yan wrote:
> > Sometimes immediately hard offlining a large chunk of contigous memory
> > having uncorrected memory errors (UE) may not be the best option.
> > Cloud providers usually serve capacity- and performance-critical guest
> > memory with 1G HugeTLB hugepages, as this significantly reduces the
> > overhead associated with managing page tables and TLB misses. However,
> > for today's HugeTLB system, once a byte of memory in a hugepage is
> > hardware corrupted, the kernel discards the whole hugepage, including
> > the healthy portion. Customer workload running in the VM can hardly
> > recover from such a great loss of memory.
>
> Thanks for your patch. Some questions below.
>
> >
> > Therefore keeping or discarding a large chunk of contiguous memory
> > owned by userspace (particularly to serve guest memory) due to
> > recoverable UE may better be controlled by userspace process
> > that owns the memory, e.g. VMM in the Cloud environment.
> >
> > Introduce a memfd-based userspace memory failure (MFR) policy,
> > MFD_MF_KEEP_UE_MAPPED. It is possible to support for other memfd,
> > but the current implementation only covers HugeTLB.
> >
> > For a hugepage associated with MFD_MF_KEEP_UE_MAPPED enabled memfd,
> > whenever it runs into a new UE,
> >
> > * MFR defers hard offline operations, i.e., unmapping and
>
> So the folio can't be unpoisoned until hugetlb folio becomes free?

Are you asking from testing perspective, are we still able to clean up
injected test errors via unpoison_memory() with MFD_MF_KEEP_UE_MAPPED?

If so, unpoison_memory() can't turn the HWPoison hugetlb page to
normal hugetlb page as MFD_MF_KEEP_UE_MAPPED automatically dissolves
it. unpoison_memory(pfn) can probably still turn the HWPoison raw page
back to a normal one, but you already lost the hugetlb page.

>
> >   dissolving. MFR still sets HWPoison flag, holds a refcount
> >   for every raw HWPoison page, record them in a list, sends SIGBUS
> >   to the consuming thread, but si_addr_lsb is reduced to PAGE_SHIFT.
> >   If userspace is able to handle the SIGBUS, the HWPoison hugepage
> >   remains accessible via the mapping created with that memfd.
> >
> > * If the memory was not faulted in yet, the fault handler also
> >   allows fault in the HWPoison folio.
> >
> > For a MFD_MF_KEEP_UE_MAPPED enabled memfd, when it is closed, or
> > when userspace process truncates its hugepages:
> >
> > * When the HugeTLB in-memory file system removes the filemap's
> >   folios one by one, it asks MFR to deal with HWPoison folios
> >   on the fly, implemented by filemap_offline_hwpoison_folio().
> >
> > * MFR drops the refcounts being held for the raw HWPoison
> >   pages within the folio. Now that the HWPoison folio becomes
> >   free, MFR dissolves it into a set of raw pages. The healthy pages
> >   are recycled into buddy allocator, while the HWPoison ones are
> >   prevented from re-allocation.
> >
> ...
>
> >
> > +static void filemap_offline_hwpoison_folio_hugetlb(struct folio *folio=
)
> > +{
> > +     int ret;
> > +     struct llist_node *head;
> > +     struct raw_hwp_page *curr, *next;
> > +
> > +     /*
> > +      * Since folio is still in the folio_batch, drop the refcount
> > +      * elevated by filemap_get_folios.
> > +      */
> > +     folio_put_refs(folio, 1);
> > +     head =3D llist_del_all(raw_hwp_list_head(folio));
>
> We might race with get_huge_page_for_hwpoison()? llist_add() might be cal=
led
> by folio_set_hugetlb_hwpoison() just after llist_del_all()?

Oh, when there is a new UE while we releasing the folio here, right?
In that case, would mutex_lock(&mf_mutex) eliminate potential race?

>
> > +
> > +     /*
> > +      * Release refcounts held by try_memory_failure_hugetlb, one per
> > +      * HWPoison-ed page in the raw hwp list.
> > +      *
> > +      * Set HWPoison flag on each page so that free_has_hwpoisoned()
> > +      * can exclude them during dissolve_free_hugetlb_folio().
> > +      */
> > +     llist_for_each_entry_safe(curr, next, head, node) {
> > +             folio_put(folio);
>
> The hugetlb folio refcnt will only be increased once even if it contains =
multiple UE sub-pages.
> See __get_huge_page_for_hwpoison() for details. So folio_put() might be c=
alled more times than
> folio_try_get() in __get_huge_page_for_hwpoison().

The changes in folio_set_hugetlb_hwpoison() should make
__get_huge_page_for_hwpoison() not to take the "out" path which
decrease the increased refcount for folio. IOW, every time a new UE
happens, we handle the hugetlb page as if it is an in-use hugetlb
page.

>
> > +             SetPageHWPoison(curr->page);
>
> If hugetlb folio vmemmap is optimized, I think SetPageHWPoison might trig=
ger BUG.

Ah, I see, vmemmap optimization doesn't allow us to move flags from
raw_hwp_list to tail pages. I guess the best I can do is to bail out
if vmemmap is enabled like folio_clear_hugetlb_hwpoison().

>
> > +             kfree(curr);
> > +     }
>
> Above logic is almost same as folio_clear_hugetlb_hwpoison. Maybe we can =
reuse that?

Will give it a try.

>
> > +
> > +     /* Refcount now should be zero and ready to dissolve folio. */
> > +     ret =3D dissolve_free_hugetlb_folio(folio);
> > +     if (ret)
> > +             pr_err("failed to dissolve hugetlb folio: %d\n", ret);
> > +}
> > +
>
> Thanks.
> .
>

