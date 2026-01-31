Return-Path: <linux-fsdevel+bounces-75988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPFHCraRfWmiSgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 06:23:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E58C0BD9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 06:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6EF13024109
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 05:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7494329E5A;
	Sat, 31 Jan 2026 05:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aAK8OpyR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F0B324B1C
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 05:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836934; cv=pass; b=ij+1TKw6nxz1oQehIZ16NLJFWa4FHWgsReybrE0NyjtAvDfcHg5x/YQTAzgojzUmFlZ1sVs9WjqhOqPJaZFkf+X659JoOcAVM9tKMZsbn7ZHew0go/K7OqoUjjfOwbRj+KjUzPBPQ6lw653Wp2wcL4QcFy491AlLIkf5l4SH6rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836934; c=relaxed/simple;
	bh=XoYGY3dVjMKj+fSor4glUM8Cil1fyHoalW7RRC74P4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7js02oRxhKZD8g7IxZV50bADg4yw4BYPuL2bolmGmWEyiPFbPmbhHcmweFES4feg+5oowiUi0X/5we7hbATURAtSfiF/NgliYDsFasRXRkXynxQ9MKIvRjZB/0KWy9DMOovpvQgnNfs7bM3gYCsNU0RZ1Imh0mby7F8uRbDEKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aAK8OpyR; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4806b0963a9so23965e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 21:22:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769836930; cv=none;
        d=google.com; s=arc-20240605;
        b=W68P8QIk/qgQxJ5lVs8jfwQgQwnxY5favNpc/v4d4QOwdWoRulRg2nb1JVmgVNT2WP
         O0RUcbjXUp6mMny797uISfd/VWG6zBYUEr+stlKNdrHALpryO/QVOEezUk05wHl4mnN8
         GL4lMLnqUK7HpTKgeyiOJjRxaoqPkY8y3NfCJMqdXJTLgPX0YqevT9stEaw7HWK/sw/W
         6zuv3bYAtr5WjJSauMuxD3xGbxGhzjOy8p9o2ypw9oHiOeK03SSbYjEYUxTy26FYfJP1
         F05awrusZVK5E6fNit72T+kioRkn4CW2ByyPRLDOjUanRc4BPXpK42JdpU4EeGPdUTLl
         hYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aqbuj1RcfrAvy7V6cbhroU0aoAlPDCA0FikcXviwmoc=;
        fh=sF7nsOZNxu9aX7mAPG8YfSZo4EZmJb19Nlr2ajXKDNs=;
        b=ObPdWBOXYWP63GwkumQ4lj8MT1dV1OfM894EDxMyGGqXG5eahA4Atl9bqJGxaMVexN
         zatbvRHI1jA/y9LU78n6o2yRDf53KcDOknFb3tYNGVLfB01+80t2qfVdnnUK2V+yyVG7
         RnsLUV1N0qAxLxcxpCvaVvWETcyrLLYsSl1IMg0ApEsK7YA1lrBDmJ1btzLOH/eMQfKA
         M/wmZ0xITKg921KaCi8vu7MnbFLmT6LO9JsDcVqnuznbWJcGg6GLrJE9cpbxi9+FeQ9m
         ClJHYGFD0SDu2L/JFcBGm23MCaikZobC4I9FKCNmOeVj7j31ry8TFxau81TLKlFCyLGQ
         iOIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769836930; x=1770441730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqbuj1RcfrAvy7V6cbhroU0aoAlPDCA0FikcXviwmoc=;
        b=aAK8OpyRRBytPjYaJh264k1eNqd+8ji3ioTskKG93jts3ElY1erD6PUyHa4B6grlcd
         8ZYTwv5Xynv5sF9ZR3REmo31VMV/1xVu/dlPGk5hERsAh9Ij7rJ7RmQyBZs1ikykTmxF
         2loFEuIMM7tE8QUsRzBSk87s4d36r0nEk/NjmdejXfDcjtPwWEKsQonCig4kxkYSEmj+
         szyCDD1J4jGV7FSJgGPrvlj6CA0yPHoZ6bpKFtYRJXpDtlI/Z6Pz23GCYJzcEJfpJ8gU
         WY4tfbfqrPhGK8HWa5EAonxPdxa6Cy6adc84tQy86xJEIM7nxm1j/p8WC0T/yIWi+VbK
         gqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836930; x=1770441730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aqbuj1RcfrAvy7V6cbhroU0aoAlPDCA0FikcXviwmoc=;
        b=LijXvsvhRIUyUuCKsJSOaJtu6QzIVjrVvaazMIAT9QqPS4TGfJIRtT43ng0h8hot1k
         /yyMp1LyivEwyZwjWlEOGkzJASglOq41DplFU2wX4ie0nidVPG/U0ifh8pRDPg9ETZDQ
         rBZPuyPtU/kcQ1hS7Z/I8a5txAX9W9cu+GjlVgFjYTEX2Kn4mKv5opNubf7eb90TjHD/
         XPdraQqToyq2PuselKWsgG1NWBuI+WKhktj/tbMJd2/ZoMaQiBWdnkJRAbwHiHdavtDT
         SjBqbTNHKKXWKKEqRDsJWj6KzaKqph862hQYv5oeQGf5DLpYMIkl0uSwZNsK3n2uaOwO
         7rQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJFJXjcRvZvZvUp7UQID1K/WuoF+p4dHL6H8xG3JwAK+v89JTh9eE3DREzh4RIoDWaEQ0aqYB7GDBhDhT9@vger.kernel.org
X-Gm-Message-State: AOJu0YwPOyG+OQk5sqe5iFO+MbZo4/dJoqKfo23WssPHbA6L6F61gyPT
	5ngP8FQiP2rTKvUX0BsHVqsYU99g/zLdr27RnuZpKFsxlJ0ODD09cL1yXivohnwEQaI1FCgPx5s
	2ihEbnSyr1+L9QSS8XwZeQfXFTyTe1asyVpy1ScoC
X-Gm-Gg: AZuq6aJfZGX6z+HYKTueEQS/r8Dl18zO9LVf8Ui6injO3NfOu7lMA/41LZGna+TQGca
	aL9FDFyVTs2QsspYijlpMN7NbUPin1IPw/I0jHPJP8iR4GNdPcLqs8Amj8CRrPbPqSt0OEgjCRe
	DhAAST+xjukeksy5QgZtRY7Fx1FP4TOAFikrTM4exAzXtN1LQEl1ciXNf8b3SNBPycW4qwW/AYD
	FnmYN8dGyzCyFnumiJXSxlFgewFvJWZKxUKuTx5usWYymm7zdHTfdMJPS5jLeAjhj57orw31/Jr
	pALY2WXYuMOm+CCXJdQt4gOpfQuq
X-Received: by 2002:a05:600c:64ce:b0:477:772e:9b76 with SMTP id
 5b1f17b1804b1-482ea45ea83mr312635e9.7.1769836929183; Fri, 30 Jan 2026
 21:22:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116013223.1557158-1-jiaqiyan@google.com> <20251116013223.1557158-2-jiaqiyan@google.com>
 <8e1b84f9-e14f-4946-8097-12325516cdfa@oracle.com>
In-Reply-To: <8e1b84f9-e14f-4946-8097-12325516cdfa@oracle.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 30 Jan 2026 21:21:57 -0800
X-Gm-Features: AZwV_QjV7b28BUeDy66odxvU6FaINtY1e_-1X3YiYRTV9Y4bIzVUNPn9UO814ds
Message-ID: <CACw3F519AtT-d8K3ur3S=5Z7entLZMpxmpZTgn=i_cfz15HUcA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm: memfd/hugetlb: introduce memfd-based userspace
 MFR policy
To: William Roche <william.roche@oracle.com>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, harry.yoo@oracle.com, 
	tony.luck@intel.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	jane.chu@oracle.com, akpm@linux-foundation.org, osalvador@suse.de, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75988-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,oracle.com,intel.com,infradead.org,linux-foundation.org,suse.de,google.com,nvidia.com,redhat.com,linux.intel.com,linux.dev,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiaqiyan@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: A7E58C0BD9
X-Rspamd-Action: no action

Hi William,

Thanks for your reviews, I should be able to address your comments in v3.

On Tue, Nov 25, 2025 at 2:04=E2=80=AFPM William Roche <william.roche@oracle=
.com> wrote:
>
> Sorry, resending for the non-HTML version.
>   --
>
> Hello Jiaqi,
>
> Here is a summary of a few nits in this code:
>
>   - Some functions declarations are problematic according to me
>   - The parameter testing to activate the feature looks incorrect
>   - The function signature change is probably not necessary
>   - Maybe we should wait for an agreement on your other proposal:
> [PATCH v1 0/2] Only free healthy pages in high-order HWPoison folio
>
> The last item is not a nit, but as your above proposal may require to
> keep all data of a
> hugetlb folio to recycle it correctly (especially the list of poisoned
> sub-pages), and
> to avoid the race condition with returning poisoned pages to the
> freelist right before
> removing them; you may need to change some aspects of this current code.
>
>
>
>
> On 11/16/25 02:32, Jiaqi Yan wrote:
> > [...]
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 8e63e46b8e1f0..b7733ef5ee917 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -871,10 +871,17 @@ int dissolve_free_hugetlb_folios(unsigned long st=
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
> > +                                                    struct address_spa=
ce *mapping)
> > +{
> > +     return false;
> > +}
> >   #endif
>
> You are conditionally declaring this
> hugetlb_should_keep_hwpoison_mapped() function and implementing
> it into mm/hugetlb.c, but this file can be compiled in both cases
> (CONFIG_MEMORY_FAILURE enabled or not)
> So you either need to have a single consistent declaration with the
> implementation and use something like that:
>
>   bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio,
>                                           struct address_space *mapping)
>   {
> +#ifdef CONFIG_MEMORY_FAILURE
>          if (WARN_ON_ONCE(!folio_test_hugetlb(folio)))
>                  return false;
>
> @@ -6087,6 +6088,9 @@ bool hugetlb_should_keep_hwpoison_mapped(struct
> folio *folio,
>                  return false;
>
>          return mapping_mf_keep_ue_mapped(mapping);
> +#else
> +       return false;
> +#endif
>   }
>
> Or keep your double declaration and hide the implementation when
> CONFIG_MEMORY_FAILURE is enabled:
>
> +#ifdef CONFIG_MEMORY_FAILURE
>   bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio,
>                                           struct address_space *mapping)
>   {
>          if (WARN_ON_ONCE(!folio_test_hugetlb(folio)))
>                  return false;
>
>   @@ -6087,6 +6088,9 @@ bool hugetlb_should_keep_hwpoison_mapped(struct
> folio *folio,
>                  return false;
>
>          return mapping_mf_keep_ue_mapped(mapping);
>   }
> +#endif
>

Thanks for your suggestions! I think probably I can move the real
hugetlb_should_keep_hwpoison_mapped() implementation to
memory_failure.c, similar to how folio_clear_hugetlb_hwpoison() is
implemented.

>
>
> >
> >   #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 09b581c1d878d..9ad511aacde7c 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -213,6 +213,8 @@ enum mapping_flags {
> >       AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM =3D 9,
> >       AS_KERNEL_FILE =3D 10,    /* mapping for a fake kernel file that =
shouldn't
> >                                  account usage to user cgroups */
> > +     /* For MFD_MF_KEEP_UE_MAPPED. */
> > +     AS_MF_KEEP_UE_MAPPED =3D 11,
> >       /* Bits 16-25 are used for FOLIO_ORDER */
> >       AS_FOLIO_ORDER_BITS =3D 5,
> >       AS_FOLIO_ORDER_MIN =3D 16,
> > @@ -348,6 +350,16 @@ static inline bool mapping_writeback_may_deadlock_=
on_reclaim(const struct addres
> >       return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->f=
lags);
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
> > @@ -1274,6 +1286,18 @@ void replace_page_cache_folio(struct folio *old,=
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
> > +void filemap_offline_hwpoison_folio(struct address_space *mapping,
> > +                                 struct folio *folio)
> > +{
> > +}
> > +#endif
> >   loff_t mapping_seek_hole_data(struct address_space *, loff_t start, l=
off_t end,
> >               int whence);
> >
>
> This filemap_offline_hwpoison_folio() declaration also is problematic in
> the case without
> CONFIG_MEMORY_FAILURE, as we implement a public function
> filemap_offline_hwpoison_folio()
> in all the files including this "pagemap.h" header.
>
> This coud be solved using "static inline" in this second case.

Yep, will do in v3.

>
>
>
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index 1d109c1acf211..bfdde4cf90500 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> > @@ -313,7 +313,8 @@ long memfd_fcntl(struct file *file, unsigned int cm=
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
> > @@ -387,6 +388,8 @@ static int sanitize_flags(unsigned int *flags_ptr)
> >       if (!(flags & MFD_HUGETLB)) {
> >               if (flags & ~MFD_ALL_FLAGS)
> >                       return -EINVAL;
> > +             if (flags & MFD_MF_KEEP_UE_MAPPED)
> > +                     return -EINVAL;
> >       } else {
> >               /* Allow huge page size encoding in flags. */
> >               if (flags & ~(MFD_ALL_FLAGS |
> > @@ -447,6 +450,16 @@ static struct file *alloc_file(const char *name, u=
nsigned int flags)
> >       file->f_mode |=3D FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
> >       file->f_flags |=3D O_LARGEFILE;
> >
> > +     /*
> > +      * MFD_MF_KEEP_UE_MAPPED can only be specified in memfd_create; n=
o API
> > +      * to update it once memfd is created. MFD_MF_KEEP_UE_MAPPED is n=
ot
> > +      * seal-able.
> > +      *
> > +      * For now MFD_MF_KEEP_UE_MAPPED is only supported by HugeTLBFS.
> > +      */
> > +     if (flags & (MFD_HUGETLB | MFD_MF_KEEP_UE_MAPPED))
> > +             mapping_set_mf_keep_ue_mapped(file->f_mapping);
> > +
>
> The flags value that we need to have in order to set the "keep" value on
> the address space
> is MFD_MF_KEEP_UE_MAPPED alone, as we already verified that the value is
> only given combined
> to MFD_HUGETLB.
> This is a nit identified by Harry Yoo during our internal conversations.
> Thanks Harry !

Yeah, this is redundant to sanitize_flags(). Will simplify in v3.

>
>
> >       if (flags & MFD_NOEXEC_SEAL) {
> >               struct inode *inode =3D file_inode(file);
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 3edebb0cda30b..c5e3e28872797 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -373,11 +373,13 @@ static unsigned long dev_pagemap_mapping_shift(st=
ruct vm_area_struct *vma,
> >    * Schedule a process for later kill.
> >    * Uses GFP_ATOMIC allocations to avoid potential recursions in the V=
M.
> >    */
> > -static void __add_to_kill(struct task_struct *tsk, const struct page *=
p,
> > +static void __add_to_kill(struct task_struct *tsk, struct page *p,
> >                         struct vm_area_struct *vma, struct list_head *t=
o_kill,
> >                         unsigned long addr)
>
> Is there any reason to remove the "const" on the page structure in the
> signature ?
> It looks like you only do that for the new call to page_folio(p), but we
> don't touch the page
>
>
> >   {
> >       struct to_kill *tk;
> > +     struct folio *folio;
>
> You could use a "const" struct folio *folio too.

Yes, will revert the changes to "const" all over the places.

>
>
>
> > +     struct address_space *mapping;
> >
> >       tk =3D kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
> >       if (!tk) {
> > @@ -388,8 +390,19 @@ static void __add_to_kill(struct task_struct *tsk,=
 const struct page *p,
> >       tk->addr =3D addr;
> >       if (is_zone_device_page(p))
> >               tk->size_shift =3D dev_pagemap_mapping_shift(vma, tk->add=
r);
> > -     else
> > -             tk->size_shift =3D folio_shift(page_folio(p));
> > +     else {
> > +             folio =3D page_folio(p);
>
> Now with both folio and p being "const", the code should work.
>
>
>
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
> > @@ -414,7 +427,7 @@ static void __add_to_kill(struct task_struct *tsk, =
const struct page *p,
> >       list_add_tail(&tk->nd, to_kill);
> >   }
> >
> > -static void add_to_kill_anon_file(struct task_struct *tsk, const struc=
t page *p,
> > +static void add_to_kill_anon_file(struct task_struct *tsk, struct page=
 *p,
>
> No need to change the signature here too (otherwise you would have
> missed both functions
> add_to_kill_fsdax() and add_to_kill_ksm().
>
>
> >               struct vm_area_struct *vma, struct list_head *to_kill,
> >               unsigned long addr)
> >   {
> > @@ -535,7 +548,7 @@ struct task_struct *task_early_kill(struct task_str=
uct *tsk, int force_early)
> >    * Collect processes when the error hit an anonymous page.
> >    */
> >   static void collect_procs_anon(const struct folio *folio,
> > -             const struct page *page, struct list_head *to_kill,
> > +             struct page *page, struct list_head *to_kill,
>
> No need to change
>
>
> >               int force_early)
> >   {
> >       struct task_struct *tsk;
> > @@ -573,7 +586,7 @@ static void collect_procs_anon(const struct folio *=
folio,
> >    * Collect processes when the error hit a file mapped page.
> >    */
> >   static void collect_procs_file(const struct folio *folio,
> > -             const struct page *page, struct list_head *to_kill,
> > +             struct page *page, struct list_head *to_kill,
> >               int force_early)
>
> No need to change
>
> >   {
> >       struct vm_area_struct *vma;
> > @@ -655,7 +668,7 @@ static void collect_procs_fsdax(const struct page *=
page,
> >   /*
> >    * Collect the processes who have the corrupted page mapped to kill.
> >    */
> > -static void collect_procs(const struct folio *folio, const struct page=
 *page,
> > +static void collect_procs(const struct folio *folio, struct page *page=
,
> >               struct list_head *tokill, int force_early)
> >   {
> >       if (!folio->mapping)
> > @@ -1173,6 +1186,13 @@ static int me_huge_page(struct page_state *ps, s=
truct page *p)
> >               }
> >       }
> >
> > +     /*
> > +      * MF still needs to holds a refcount for the deferred actions in
> > +      * filemap_offline_hwpoison_folio.
> > +      */
> > +     if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
> > +             return res;
> > +
> >       if (has_extra_refcount(ps, p, extra_pins))
> >               res =3D MF_FAILED;
> >
> > @@ -1569,6 +1589,7 @@ static bool hwpoison_user_mappings(struct folio *=
folio, struct page *p,
> >   {
> >       LIST_HEAD(tokill);
> >       bool unmap_success;
> > +     bool keep_mapped;
> >       int forcekill;
> >       bool mlocked =3D folio_test_mlocked(folio);
> >
> > @@ -1596,8 +1617,12 @@ static bool hwpoison_user_mappings(struct folio =
*folio, struct page *p,
> >        */
> >       collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
> >
> > -     unmap_success =3D !unmap_poisoned_folio(folio, pfn, flags & MF_MU=
ST_KILL);
> > -     if (!unmap_success)
> > +     keep_mapped =3D hugetlb_should_keep_hwpoison_mapped(folio, folio-=
>mapping);
> > +     if (!keep_mapped)
> > +             unmap_poisoned_folio(folio, pfn, flags & MF_MUST_KILL);
> > +
> > +     unmap_success =3D !folio_mapped(folio);
> > +     if (!keep_mapped && !unmap_success)
> >               pr_err("%#lx: failed to unmap page (folio mapcount=3D%d)\=
n",
> >                      pfn, folio_mapcount(folio));
> >
> > @@ -1622,7 +1647,7 @@ static bool hwpoison_user_mappings(struct folio *=
folio, struct page *p,
> >                   !unmap_success;
> >       kill_procs(&tokill, forcekill, pfn, flags);
> >
> > -     return unmap_success;
> > +     return unmap_success || keep_mapped;
> >   }
> >
> >   static int identify_page_state(unsigned long pfn, struct page *p,
> > @@ -1862,6 +1887,13 @@ static unsigned long __folio_free_raw_hwp(struct=
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
>
> This may not be necessary depending on how we recycle hugetlb pages --
> see below too.
>
> >       llist_for_each_entry_safe(p, next, head, node) {
> >               if (move_flag)
> >                       SetPageHWPoison(p->page);
> > @@ -1878,7 +1910,8 @@ static int folio_set_hugetlb_hwpoison(struct foli=
o *folio, struct page *page)
> >       struct llist_head *head;
> >       struct raw_hwp_page *raw_hwp;
> >       struct raw_hwp_page *p;
> > -     int ret =3D folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
> > +     struct address_space *mapping =3D folio->mapping;
> > +     bool has_hwpoison =3D folio_test_set_hwpoison(folio);
> >
> >       /*
> >        * Once the hwpoison hugepage has lost reliable raw error info,
> > @@ -1897,8 +1930,15 @@ static int folio_set_hugetlb_hwpoison(struct fol=
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
> > @@ -1913,7 +1953,8 @@ static int folio_set_hugetlb_hwpoison(struct foli=
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
> > @@ -2002,6 +2043,63 @@ int __get_huge_page_for_hwpoison(unsigned long p=
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
> > +     struct page *page;
> > +     unsigned long pfn;
> > +
> > +     /*
> > +      * Since folio is still in the folio_batch, drop the refcount
> > +      * elevated by filemap_get_folios.
> > +      */
> > +     folio_put_refs(folio, 1);
> > +     head =3D llist_del_all(raw_hwp_list_head(folio));
>
> According to me we should wait until your other patch set is approved to
> decide if the folio raw_hwp_list
> has to be removed from the folio or if is should be left there so that
> the recycling of this huge page
> works correctly...
>
> > +
> > +     /*
> > +      * Release refcounts held by try_memory_failure_hugetlb, one per
> > +      * HWPoison-ed page in the raw hwp list.
> > +      */
> > +     llist_for_each_entry(curr, head, node) {
> > +             SetPageHWPoison(curr->page);
> > +             folio_put(folio);
> > +     }
> > +
> > +     /* Refcount now should be zero and ready to dissolve folio. */
> > +     ret =3D dissolve_free_hugetlb_folio(folio);
> > +     if (ret) {
> > +             pr_err("failed to dissolve hugetlb folio: %d\n", ret);
> > +             return;
> > +     }
> > +
> > +     llist_for_each_entry_safe(curr, next, head, node) {
> > +             page =3D curr->page;
> > +             pfn =3D page_to_pfn(page);
> > +             drain_all_pages(page_zone(page));
> > +             if (!take_page_off_buddy(page))
> > +                     pr_err("%#lx: unable to take off buddy allocator\=
n", pfn);
> > +
> > +             page_ref_inc(page);
> > +             kfree(curr);
> > +             pr_info("%#lx: pending hard offline completed\n", pfn);
> > +     }
> > +}
>
> Let's revisit this above function when an agreement is reached on the
> recycling hugetlb pages proposal.

From what I can tell, free_has_hwpoisoned() is promising. So in v3 I
will post much simplified filemap_offline_hwpoison_folio_hugetlb(),
assuming dissolve_free_hugetlb_folio() recycles only the healthy
pages.

>
>
>
>
>
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
> > +}
> > +
> >   /*
> >    * Taking refcount of hugetlb pages needs extra care about race condi=
tions
> >    * with basic operations like hugepage allocation/free/demotion.
>
>
> HTH
>
> Best regards,
> William.

