Return-Path: <linux-fsdevel+bounces-76806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AExiM1S4imkCNQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 05:47:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DD1116E7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 05:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A15B43024A1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 04:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495C2328B53;
	Tue, 10 Feb 2026 04:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jowg2a7a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4BA481DD
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 04:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770698833; cv=pass; b=vASdoElc0T3Ku4a9rLyr/tnFYi3RGubMIG5rDwZCZTljnp/Sy90KMnXWaYsa/Z2e2GSwZG8T2ciyoky12b5XjgLh6HQ6WpQ5yOJK7eEUM4BhMIQnH/LR45SW70DNgPPP4jltXwbeVMQLLMMtqBy/lf62JUdha5nvnhadtnzhIa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770698833; c=relaxed/simple;
	bh=+JD3qLqbtfLwITX4lF+HYkXmbPPsiixEtOom0TyZqeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OP2MHhfrmfOqlLvDSIWUbND/GDw5tknz0DXGuEHnThj4zd5YrHlHfC39OEowUg8uwpwMiRnAd14kLY/HuraSBK2cUZt28Vh2arTPTG1s/gFc6RZqNyhk0jUpUFiEW9r273+Yaux/jOotLWlVTg8TXVKUUbGNHQFCPqEK9uc5WGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jowg2a7a; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806b0963a9so26065e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 20:47:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770698829; cv=none;
        d=google.com; s=arc-20240605;
        b=KlDeNWpHEOZLXO6V4oWmuKOCoUQbLQn+zhspTIOsumFGoqOy2X53Hl3gn5dGpV21p3
         C75mYv02+jlvsQKIRTl8xe5TN1C8pEtKmAPDKi49c9QmAiUVsrABI2+FaASrziCtapW5
         HB99V60M8+3opTjPTcDjVoF5bNuPfCHYjw4JC2qQO6/7RmsZcJuFCMf7HrQ9RGqoQWsP
         bYl8mZuMy3GcpAwsdhSKYa0kEU+9Fytrw4uNiY/6zW+Q8KXLEDSjMdBS0f3uUPFuGSmz
         VytkuK+RzulvqpjXTLXKJHpkM0cuTkuVy1NIwiKBHQQWLPnJQoiCHID9giFnkQ90j0HE
         NYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xh0cHnb2Uzw2254gJcy7ClMZ1utgFHkkePdFq3QRDkc=;
        fh=vvWZWpYwNE5lcfgcQS0GugRYwooFVg2mTZTWhqdlQf8=;
        b=bK72MVijrNj7+U9poySd7jY16u6ZYE4PnblIP+8LeaGh93VQCP7qI56dL3tH0RnNJV
         avc9Qw2p7o5+6vQCwoQHXd1/tseIYYI6z6BgsZkZiVWpeT920UkFcs2tOymneRzn5oZ6
         6QeYFTKHvHI+fOzJuR1HeXaHR7fSgFzNakMaQAfDCGXz1Hed8SBLBiPC8kGxmJm8poxj
         pAW+Vjmv6Gd0MH+iluG8/4ndf+c3f7fagsl3MnTM9yG2HcjMUAKDKlJyCtLY/UTv/cRv
         Lci1Hs5b8UAUduW/4CgSM50v3KHO+Oys3zac8Zr2BUbnkiBDgmFkIDHT6iVKb7liZH17
         QMYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770698829; x=1771303629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh0cHnb2Uzw2254gJcy7ClMZ1utgFHkkePdFq3QRDkc=;
        b=jowg2a7ai2O+Sq5jokLRysQ1N0JymsFT98FJUZXElaOYT05W2GPh31SPSFvwsr/MAx
         1PuWjR77wD1cWUK/zW1LgwefJJWwItP8JX9w7sQzNrLu7ToxoO/3erf+ws6xmBavO++8
         D+w85/+1bxs9HmvRfLGqbpEKMnmEApG4aeNlcjpb61/mm2CAyLyLgJGLe4ZqdDuwQCJk
         xWlmXlNOybDvqXjat553gBM1f0PnI5f5DqSrldAklffAHeek3RiHeAmm/V34lIsalHjl
         QOOgRhZK3sr3sN1mD+yhvLsnhVlN0g83ajENzMJuN99/bxGys7laacpVwwY/RKzFvIf5
         t6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770698829; x=1771303629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xh0cHnb2Uzw2254gJcy7ClMZ1utgFHkkePdFq3QRDkc=;
        b=nMaaj/edwqZNAFoLvw1p7teWwXY05fztyYqagk4GLlLkL8Ka2Ad2E9M7ao2wJ26XwY
         mJQpNWqvEs08txEdywbEWFiYVG5L1d0s5PlbkIQVVME1EmeiUaa7Sz0vhBGpMVekQsh4
         DKhEUgdjIrVHGbUPGcubBZbox8zI2KMz7pO5hsM0vcyQ3D58rJ3Id/0wd6SPAAA6xpw6
         m3yn7ncu9ufZK26SeyVQjWTPv5iLMalUX4AubqPdi0gma4aDOb6s5/WR3ny7FmyMKbI0
         45Nv/Uhn8hsaruyl5o6oHF/34v930ksGTvns+yat6cxQ7EkngXlmQKCnx9KeB41uCfDf
         xZmg==
X-Forwarded-Encrypted: i=1; AJvYcCUu4cr0IRmRJoh6pH3UeVKOS0exD0WlZahzf7hUTBDUaMcc4mKsZBtr7NbfA4wPvNIA65xlgpg/mC7uz53C@vger.kernel.org
X-Gm-Message-State: AOJu0YzKrOKqPICZyrQRhtKh42m86WHusQn1/RjrA2EMY9XrGM9mxEfh
	NGyZPmbNdyFcAHslKIjrf48hVdQJJqpbgZeGiPya/tV1H8/MlSVFfdRabycsteub0/IqEVHOE9k
	45DbYd2GVT0s9yKm4b2aBIUkfN6cpBp+XEwwv06bO
X-Gm-Gg: AZuq6aIERO91qJAo8S8N98xs08WGPFtg2xz2uLDwlbBxOPUZrWeslnC/Yq/useoJSfm
	zSDxYthq9o1hvgunnodxOoPdZjTfGDlbIK5P64+s1JwiQqXDPr2VbY7qSNwO+ebh9iifnQ7WGlY
	vG8b13dvzZo7A+3yAmI52co4G6D6X4W7DCSxAJ8i8xOiihG8apgpaLwFEyjQf5si3h4k2JAT9I+
	/+Y+lHkD03x1OaWwm63BbbSF6AFaAbKEq2DPZkj2tT5CVLa1ejoiETl/IXE2Ik/kJno4otIxMtW
	oKiVndsSVN8XVKrxBs8DHMevGIdnzKKOZQT3QIAB
X-Received: by 2002:a05:600c:a0d:b0:483:1093:f29b with SMTP id
 5b1f17b1804b1-4834efac31fmr722865e9.8.1770698828448; Mon, 09 Feb 2026
 20:47:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203192352.2674184-1-jiaqiyan@google.com> <20260203192352.2674184-2-jiaqiyan@google.com>
 <01d1c0f5-5b07-4084-b2d4-33fb3b7c02b4@oracle.com>
In-Reply-To: <01d1c0f5-5b07-4084-b2d4-33fb3b7c02b4@oracle.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 9 Feb 2026 20:46:57 -0800
X-Gm-Features: AZwV_QjV91dFot7ayh0f1ZjXLIniXMg-clH4kIMK48-lKWBdDzOW989Sj-GjMWQ
Message-ID: <CACw3F528fGutxsdiaA6ef6iP=O2hPVL0fuhwokvmOvbNVtsf+Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm: memfd/hugetlb: introduce memfd-based userspace
 MFR policy
To: William Roche <william.roche@oracle.com>
Cc: linmiaohe@huawei.com, harry.yoo@oracle.com, jane.chu@oracle.com, 
	nao.horiguchi@gmail.com, tony.luck@intel.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org, akpm@linux-foundation.org, osalvador@suse.de, 
	rientjes@google.com, duenwen@google.com, jthoughton@google.com, 
	jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com, 
	sidhartha.kumar@oracle.com, ziy@nvidia.com, david@redhat.com, 
	dave.hansen@linux.intel.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-76806-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiaqiyan@google.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[huawei.com,oracle.com,gmail.com,intel.com,infradead.org,linux-foundation.org,suse.de,google.com,nvidia.com,redhat.com,linux.intel.com,linux.dev,kvack.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 43DD1116E7F
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 9:30=E2=80=AFAM William Roche <william.roche@oracle.=
com> wrote:
>
> On 2/3/26 20:23, Jiaqi Yan wrote:
> > [...]
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index 3b4c152c5c73a..8b0f5aa49711f 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -551,6 +551,18 @@ static bool remove_inode_single_folio(struct hstat=
e *h, struct inode *inode,
> >       }
> >
> >       folio_unlock(folio);
> > +
> > +     /*
> > +      * There may be pending HWPoison-ed folios when a memfd is being
> > +      * removed or part of it is being truncated.
> > +      *
> > +      * HugeTLBFS' error_remove_folio keeps the HWPoison-ed folios in
> > +      * page cache until mm wants to drop the folio at the end of the
> > +      * of the filemap. At this point, if memory failure was delayed
>
> "of the" is repeated
>
> > +      * by MFD_MF_KEEP_UE_MAPPED in the past, we can now deal with it.
> > +      */
> > +     filemap_offline_hwpoison_folio(mapping, folio);
> > +
> >       return ret;
> >   }
> >
> > @@ -582,13 +594,13 @@ static void remove_inode_hugepages(struct inode *=
inode, loff_t lstart,
> >       const pgoff_t end =3D lend >> PAGE_SHIFT;
> >       struct folio_batch fbatch;
> >       pgoff_t next, index;
> > -     int i, freed =3D 0;
> > +     int i, j, freed =3D 0;
> >       bool truncate_op =3D (lend =3D=3D LLONG_MAX);
> >
> >       folio_batch_init(&fbatch);
> >       next =3D lstart >> PAGE_SHIFT;
> >       while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
> > -             for (i =3D 0; i < folio_batch_count(&fbatch); ++i) {
> > +             for (i =3D 0, j =3D 0; i < folio_batch_count(&fbatch); ++=
i) {
> >                       struct folio *folio =3D fbatch.folios[i];
> >                       u32 hash =3D 0;
> >
> > @@ -603,8 +615,17 @@ static void remove_inode_hugepages(struct inode *i=
node, loff_t lstart,
> >                                                       index, truncate_o=
p))
> >                               freed++;
> >
> > +                     /*
> > +                      * Skip HWPoison-ed hugepages, which should no
> > +                      * longer be hugetlb if successfully dissolved.
> > +                      */
> > +                     if (folio_test_hugetlb(folio))
> > +                             fbatch.folios[j++] =3D folio;
> > +
> >                       mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> >               }
> > +             fbatch.nr =3D j;
> > +
> >               folio_batch_release(&fbatch);
> >               cond_resched();
> >       }
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index e51b8ef0cebd9..7fadf1772335d 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -879,10 +879,17 @@ int dissolve_free_hugetlb_folios(unsigned long st=
art_pfn,
> >
> >   #ifdef CONFIG_MEMORY_FAILURE
> >   extern void folio_clear_hugetlb_hwpoison(struct folio *folio);
> > +extern bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio,
> > +                                             struct address_space *map=
ping);
> >   #else
> >   static inline void folio_clear_hugetlb_hwpoison(struct folio *folio)
> >   {
> >   }
> > +static inline bool hugetlb_should_keep_hwpoison_mapped(struct folio *f=
olio
>
> comma is missing
>
> > +                                                    struct address_spa=
ce *mapping)
> > +{
> > +     return false;
> > +}
> >   #endif
> >
> >   #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index ec442af3f8861..53772c29451eb 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -211,6 +211,7 @@ enum mapping_flags {
> >       AS_KERNEL_FILE =3D 10,    /* mapping for a fake kernel file that =
shouldn't
> >                                  account usage to user cgroups */
> >       AS_NO_DATA_INTEGRITY =3D 11, /* no data integrity guarantees */
> > +     AS_MF_KEEP_UE_MAPPED =3D 12, /* For MFD_MF_KEEP_UE_MAPPED. */
> >       /* Bits 16-25 are used for FOLIO_ORDER */
> >       AS_FOLIO_ORDER_BITS =3D 5,
> >       AS_FOLIO_ORDER_MIN =3D 16,
> > @@ -356,6 +357,16 @@ static inline bool mapping_no_data_integrity(const=
 struct address_space *mapping
> >       return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> >   }
> >
> > +static inline bool mapping_mf_keep_ue_mapped(const struct address_spac=
e *mapping)
> > +{
> > +     return test_bit(AS_MF_KEEP_UE_MAPPED, &mapping->flags);
> > +}
> > +
> > +static inline void mapping_set_mf_keep_ue_mapped(struct address_space =
*mapping)
> > +{
> > +     set_bit(AS_MF_KEEP_UE_MAPPED, &mapping->flags);
> > +}
> > +
> >   static inline gfp_t mapping_gfp_mask(const struct address_space *mapp=
ing)
> >   {
> >       return mapping->gfp_mask;
> > @@ -1303,6 +1314,18 @@ void replace_page_cache_folio(struct folio *old,=
 struct folio *new);
> >   void delete_from_page_cache_batch(struct address_space *mapping,
> >                                 struct folio_batch *fbatch);
> >   bool filemap_release_folio(struct folio *folio, gfp_t gfp);
> > +#ifdef CONFIG_MEMORY_FAILURE
> > +/*
> > + * Provided by memory failure to offline HWPoison-ed folio managed by =
memfd.
> > + */
> > +void filemap_offline_hwpoison_folio(struct address_space *mapping,
> > +                                 struct folio *folio);
> > +#else
> > +static inline void filemap_offline_hwpoison_folio(struct address_space=
 *mapping,
> > +                                               struct folio *folio)
> > +{
> > +}
> > +#endif
> >   loff_t mapping_seek_hole_data(struct address_space *, loff_t start, l=
off_t end,
> >               int whence);
> >
> > diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
> > index 273a4e15dfcff..d9875da551b7f 100644
> > --- a/include/uapi/linux/memfd.h
> > +++ b/include/uapi/linux/memfd.h
> > @@ -12,6 +12,12 @@
> >   #define MFD_NOEXEC_SEAL             0x0008U
> >   /* executable */
> >   #define MFD_EXEC            0x0010U
> > +/*
> > + * Keep owned folios mapped when uncorrectable memory errors (UE) caus=
es
> > + * memory failure (MF) within the folio. Only at the end of the mappin=
g
> > + * will its HWPoison-ed folios be dealt with.
> > + */
> > +#define MFD_MF_KEEP_UE_MAPPED        0x0020U
> >
> >   /*
> >    * Huge page size encoding when MFD_HUGETLB is specified, and a huge =
page
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index a1832da0f6236..2a161c281da2a 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -5836,9 +5836,11 @@ static vm_fault_t hugetlb_no_page(struct address=
_space *mapping,
> >                * So we need to block hugepage fault by PG_hwpoison bit =
check.
> >                */
> >               if (unlikely(folio_test_hwpoison(folio))) {
> > -                     ret =3D VM_FAULT_HWPOISON_LARGE |
> > -                             VM_FAULT_SET_HINDEX(hstate_index(h));
> > -                     goto backout_unlocked;
> > +                     if (!mapping_mf_keep_ue_mapped(mapping)) {
> > +                             ret =3D VM_FAULT_HWPOISON_LARGE |
> > +                                   VM_FAULT_SET_HINDEX(hstate_index(h)=
);
> > +                             goto backout_unlocked;
> > +                     }
> >               }
> >
> >               /* Check for page in userfault range. */
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index ab5312aff14b9..f9fdf014b67ba 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> > @@ -340,7 +340,8 @@ long memfd_fcntl(struct file *file, unsigned int cm=
d, unsigned int arg)
> >   #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
> >   #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
> >
> > -#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB |=
 MFD_NOEXEC_SEAL | MFD_EXEC)
> > +#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB |=
 \
> > +                    MFD_NOEXEC_SEAL | MFD_EXEC | MFD_MF_KEEP_UE_MAPPED=
)
> >
> >   static int check_sysctl_memfd_noexec(unsigned int *flags)
> >   {
> > @@ -414,6 +415,8 @@ static int sanitize_flags(unsigned int *flags_ptr)
> >       if (!(flags & MFD_HUGETLB)) {
> >               if (flags & ~MFD_ALL_FLAGS)
> >                       return -EINVAL;
> > +             if (flags & MFD_MF_KEEP_UE_MAPPED)
> > +                     return -EINVAL;
> >       } else {
> >               /* Allow huge page size encoding in flags. */
> >               if (flags & ~(MFD_ALL_FLAGS |
> > @@ -486,6 +489,16 @@ static struct file *alloc_file(const char *name, u=
nsigned int flags)
> >       file->f_mode |=3D FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
> >       file->f_flags |=3D O_LARGEFILE;
> >
> > +     /*
> > +      * MFD_MF_KEEP_UE_MAPPED can only be specified in memfd_create;
> > +      * no API to update it once memfd is created. MFD_MF_KEEP_UE_MAPP=
ED
> > +      * is not seal-able.
> > +      *
> > +      * For now MFD_MF_KEEP_UE_MAPPED is only supported by HugeTLBFS.
> > +      */
> > +     if (flags & MFD_MF_KEEP_UE_MAPPED)
> > +             mapping_set_mf_keep_ue_mapped(file->f_mapping);
> > +
> >       if (flags & MFD_NOEXEC_SEAL) {
> >               inode->i_mode &=3D ~0111;
> >               file_seals =3D memfd_file_seals_ptr(file);
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 58b34f5d2c05d..b9cecbbe08dae 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -410,6 +410,8 @@ static void __add_to_kill(struct task_struct *tsk, =
const struct page *p,
> >                         unsigned long addr)
> >   {
> >       struct to_kill *tk;
> > +     const struct folio *folio;
> > +     struct address_space *mapping;
> >
> >       tk =3D kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
> >       if (!tk) {
> > @@ -420,8 +422,19 @@ static void __add_to_kill(struct task_struct *tsk,=
 const struct page *p,
> >       tk->addr =3D addr;
> >       if (is_zone_device_page(p))
> >               tk->size_shift =3D dev_pagemap_mapping_shift(vma, tk->add=
r);
> > -     else
> > -             tk->size_shift =3D folio_shift(page_folio(p));
> > +     else {
> > +             folio =3D page_folio(p);
> > +             mapping =3D folio_mapping(folio);
> > +             if (mapping && mapping_mf_keep_ue_mapped(mapping))
> > +                     /*
> > +                      * Let userspace know the radius of HWPoison is
> > +                      * the size of raw page; accessing other pages
> > +                      * inside the folio is still ok.
> > +                      */
> > +                     tk->size_shift =3D PAGE_SHIFT;
> > +             else
> > +                     tk->size_shift =3D folio_shift(folio);
> > +     }
> >
> >       /*
> >        * Send SIGKILL if "tk->addr =3D=3D -EFAULT". Also, as
> > @@ -844,6 +857,8 @@ static int kill_accessing_process(struct task_struc=
t *p, unsigned long pfn,
> >                                 int flags)
> >   {
> >       int ret;
> > +     struct folio *folio;
> > +     struct address_space *mapping;
> >       struct hwpoison_walk priv =3D {
> >               .pfn =3D pfn,
> >       };
> > @@ -861,8 +876,14 @@ static int kill_accessing_process(struct task_stru=
ct *p, unsigned long pfn,
> >        * ret =3D 0 when poison page is a clean page and it's dropped, n=
o
> >        * SIGBUS is needed.
> >        */
> > -     if (ret =3D=3D 1 && priv.tk.addr)
> > +     if (ret =3D=3D 1 && priv.tk.addr) {
> > +             folio =3D pfn_folio(pfn);
> > +             mapping =3D folio_mapping(folio);
> > +             if (mapping && mapping_mf_keep_ue_mapped(mapping))
> > +                     priv.tk.size_shift =3D PAGE_SHIFT;
> > +
> >               kill_proc(&priv.tk, pfn, flags);
> > +     }
> >       mmap_read_unlock(p->mm);
> >
> >       return ret > 0 ? -EHWPOISON : 0;
> > @@ -1206,6 +1227,13 @@ static int me_huge_page(struct page_state *ps, s=
truct page *p)
> >               }
> >       }
> >
> > +     /*
> > +      * MF still needs to holds a refcount for the deferred actions in
>
> to hold (without the s)
>
> > +      * filemap_offline_hwpoison_folio.
> > +      */
> > +     if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
> > +             return res;
> > +
> >       if (has_extra_refcount(ps, p, extra_pins))
> >               res =3D MF_FAILED;
> >
> > @@ -1602,6 +1630,7 @@ static bool hwpoison_user_mappings(struct folio *=
folio, struct page *p,
> >   {
> >       LIST_HEAD(tokill);
> >       bool unmap_success;
> > +     bool keep_mapped;
> >       int forcekill;
> >       bool mlocked =3D folio_test_mlocked(folio);
> >
> > @@ -1629,8 +1658,12 @@ static bool hwpoison_user_mappings(struct folio =
*folio, struct page *p,
> >        */
> >       collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
> >
> > -     unmap_success =3D !unmap_poisoned_folio(folio, pfn, flags & MF_MU=
ST_KILL);
> > -     if (!unmap_success)
> > +     keep_mapped =3D hugetlb_should_keep_hwpoison_mapped(folio, folio-=
>mapping);
>
> We shoud use folio_mapping(folio) instead of folio->mapping.
>
> But more importantly this function can be called on non hugepages
> folios, and hugetlb_should_keep_hwpoison_mapped() is warning (ONCE) in
> this case. So shouldn't the caller make sure that we are dealing with
> hugepages first ?

I guess the WARN_ON_ONCE() in hugetlb_should_keep_hwpoison_mapped() is
confusing. I want hugetlb_should_keep_hwpoison_mapped() to test and
return false for non hugepage. Let me remove WARN_ON_ONCE().

>
>
> > +     if (!keep_mapped)
> > +             unmap_poisoned_folio(folio, pfn, flags & MF_MUST_KILL);
> > +
> > +     unmap_success =3D !folio_mapped(folio);
> > +     if (!keep_mapped && !unmap_success)
> >               pr_err("%#lx: failed to unmap page (folio mapcount=3D%d)\=
n",
> >                      pfn, folio_mapcount(folio));
> >
> > @@ -1655,7 +1688,7 @@ static bool hwpoison_user_mappings(struct folio *=
folio, struct page *p,
> >                   !unmap_success;
> >       kill_procs(&tokill, forcekill, pfn, flags);
> >
> > -     return unmap_success;
> > +     return unmap_success || keep_mapped;
> >   }
> >
> >   static int identify_page_state(unsigned long pfn, struct page *p,
> > @@ -1896,6 +1929,13 @@ static unsigned long __folio_free_raw_hwp(struct=
 folio *folio, bool move_flag)
> >       unsigned long count =3D 0;
> >
> >       head =3D llist_del_all(raw_hwp_list_head(folio));
> > +     /*
> > +      * If filemap_offline_hwpoison_folio_hugetlb is handling this fol=
io,
> > +      * it has already taken off the head of the llist.
> > +      */
> > +     if (head =3D=3D NULL)
> > +             return 0;
> > +
> >       llist_for_each_entry_safe(p, next, head, node) {
> >               if (move_flag)
> >                       SetPageHWPoison(p->page);
> > @@ -1912,7 +1952,8 @@ static int folio_set_hugetlb_hwpoison(struct foli=
o *folio, struct page *page)
> >       struct llist_head *head;
> >       struct raw_hwp_page *raw_hwp;
> >       struct raw_hwp_page *p;
> > -     int ret =3D folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
> > +     struct address_space *mapping =3D folio->mapping;
>
> Same here - We shoud use folio_mapping(folio) instead of folio->mapping.
>
> > +     bool has_hwpoison =3D folio_test_set_hwpoison(folio);
> >
> >       /*
> >        * Once the hwpoison hugepage has lost reliable raw error info,
> > @@ -1931,8 +1972,15 @@ static int folio_set_hugetlb_hwpoison(struct fol=
io *folio, struct page *page)
> >       if (raw_hwp) {
> >               raw_hwp->page =3D page;
> >               llist_add(&raw_hwp->node, head);
> > +             if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
> > +                     /*
> > +                      * A new raw HWPoison page. Don't return HWPOISON=
.
> > +                      * Error event will be counted in action_result()=
.
> > +                      */
> > +                     return 0;
> > +
> >               /* the first error event will be counted in action_result=
(). */
> > -             if (ret)
> > +             if (has_hwpoison)
> >                       num_poisoned_pages_inc(page_to_pfn(page));
> >       } else {
> >               /*
> > @@ -1947,7 +1995,8 @@ static int folio_set_hugetlb_hwpoison(struct foli=
o *folio, struct page *page)
> >                */
> >               __folio_free_raw_hwp(folio, false);
> >       }
> > -     return ret;
> > +
> > +     return has_hwpoison ? -EHWPOISON : 0;
> >   }
> >
> >   static unsigned long folio_free_raw_hwp(struct folio *folio, bool mov=
e_flag)
> > @@ -1980,6 +2029,18 @@ void folio_clear_hugetlb_hwpoison(struct folio *=
folio)
> >       folio_free_raw_hwp(folio, true);
> >   }
> >
> > +bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio,
> > +                                      struct address_space *mapping)
> > +{
> > +     if (WARN_ON_ONCE(!folio_test_hugetlb(folio)))
> > +             return false;
> > +
> > +     if (!mapping)
> > +             return false;
> > +
> > +     return mapping_mf_keep_ue_mapped(mapping);
> > +}
>
> The definition of this above function should be encapsulated with
> #ifdef CONFIG_MEMORY_FAILURE
> #endif
>
> > +
> >   /*
> >    * Called from hugetlb code with hugetlb_lock held.
> >    *
> > @@ -2037,6 +2098,51 @@ int __get_huge_page_for_hwpoison(unsigned long p=
fn, int flags,
> >       return ret;
> >   }
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
> > +             SetPageHWPoison(curr->page);
> > +             kfree(curr);
> > +     }
> > +
> > +     /* Refcount now should be zero and ready to dissolve folio. */
> > +     ret =3D dissolve_free_hugetlb_folio(folio);
> > +     if (ret)
> > +             pr_err("failed to dissolve hugetlb folio: %d\n", ret);
> > +}
> > +
> > +void filemap_offline_hwpoison_folio(struct address_space *mapping,
> > +                                 struct folio *folio)
> > +{
> > +     WARN_ON_ONCE(!mapping);
> > +
> > +     if (!folio_test_hwpoison(folio))
> > +             return;
> > +
> > +     /* Pending MFR currently only exist for hugetlb. */
> > +     if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
> > +             filemap_offline_hwpoison_folio_hugetlb(folio);
>
> Shouldn't we also test here that we are dealing with hugepages first
> before testing hugetlb_should_keep_hwpoison_mapped(folio, mapping) ?
>
> > +}
> > +
> >   /*
> >    * Taking refcount of hugetlb pages needs extra care about race condi=
tions
> >    * with basic operations like hugepage allocation/free/demotion.
>
>
> Don't we also need to take into account the repeated errors in
> try_memory_failure_hugetlb() ?

Ah, looks like I haven't pull the recently commit a148a2040191
("mm/memory-failure: fix missing ->mf_stats count in hugetlb poison").

When dealing with a new error in already HWPoison folio,
MFD_MF_KEEP_UE_MAPPED makes folio_set_hugetlb_hwpoison() return 0 (now
MF_HUGETLB_IN_USED for hugetlb_update_hwpoison()) so
__get_huge_page_for_hwpoison() can return 1/MF_HUGETLB_IN_USED. The
idea is to make try_memory_failure_hugetlb() just handle new error as
a first-time poisoned in-use hugetlb page.

Of course for an old error __get_huge_page_for_hwpoison should return
MF_HUGETLB_PAGE_PRE_POISONED.

>
> Something like that:
>
> @@ -2036,9 +2099,10 @@ static int try_memory_failure_hugetlb(unsigned
> long pfn, int flags, int *hugetlb
>   {
>         int res, rv;
>         struct page *p =3D pfn_to_page(pfn);
> -       struct folio *folio;
> +       struct folio *folio =3D page_folio(p);
>         unsigned long page_flags;
>         bool migratable_cleared =3D false;
> +       struct address_space *mapping =3D folio_mapping(folio);
>
>         *hugetlb =3D 1;
>   retry:
> @@ -2060,15 +2124,17 @@ static int try_memory_failure_hugetlb(unsigned
> long pfn, int flags, int *hugetlb
>                         rv =3D kill_accessing_process(current, pfn, flags=
);
>                 if (res =3D=3D MF_HUGETLB_PAGE_PRE_POISONED)
>                         action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FA=
ILED);
> -               else
> +               else {
> +                       if (hugetlb_should_keep_hwpoison_mapped(folio, ma=
pping))
> +                               return action_result(pfn, MF_MSG_UNMAP_FA=
ILED, MF_DELAYED);

If hugetlb_update_hwpoison() returns MF_HUGETLB_IN_USED for
MFD_MF_KEEP_UE_MAPPED, then try_memory_failure_hugetlb() should
normally run to the end and report MF_MSG_HUGE + MF_RECOVERED.

>                         action_result(pfn, MF_MSG_HUGE, MF_FAILED);
> +               }
>                 return rv;
>         default:
>                 WARN_ON((res !=3D MF_HUGETLB_FREED) && (res !=3D MF_HUGET=
LB_IN_USED));
>                 break;
>         }
>
> -       folio =3D page_folio(p);
>         folio_lock(folio);
>
>         if (hwpoison_filter(p)) {
>
>
> So that we don't call action_result(pfn, MF_MSG_HUGE, MF_FAILED); for a
> repeated error ?
>
>
> --
> 2.47.3
>

