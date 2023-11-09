Return-Path: <linux-fsdevel+bounces-2535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A247E6D61
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC922810C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05A720318;
	Thu,  9 Nov 2023 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvLH+kTd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90FB200C1
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:25:52 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A2330EB;
	Thu,  9 Nov 2023 07:25:51 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7789a4c01easo62493285a.0;
        Thu, 09 Nov 2023 07:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699543551; x=1700148351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rC3ut+QDwWGJd16zKaR1Aa64yp9JWUypYzqCq6w3+Pc=;
        b=YvLH+kTdtTAnFYE85ZgGP95iiNs6Ij+vD/VeS1yisckwv+nc+S7tqRKoR+q3Yd6PAI
         qmrYlQkdMiMIVqHUD4NXVuVjoHNqshZY8Pg/lA+wfYZlcHnRvp41IlUkQH/kJb0/FTJo
         s6l2pOkOT+O/+fG6fZYJMgDqcop3L2kZFJS6mkv+ksVi22tR6LoSOzH6Hy6CEDPxD5HF
         drsisC0T2XLPSeUs4zcBlzyvKB0Z63wpwPN+u1vjIngPST6WQFY3wWrWkGzIONmJezIc
         5tEYUgrdmAv5KWEHnSf2rltruKJSN5gT/vW0aaYO7TcGufePqToQL+kvuN4e96SWDhKO
         pBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699543551; x=1700148351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC3ut+QDwWGJd16zKaR1Aa64yp9JWUypYzqCq6w3+Pc=;
        b=M76jgOQy31fiE5sfzIdHmSQwIIXTXn9UEPrJgMhGEaDYdQPPUPYvZkszqZ+SB2bcyK
         vt9H872KT92+RAjXk4pxl5+7NO2i9+3wNKY/0sXCimNVjtzNGUT2997svFSaybbrpPoo
         q09AdcPqwHft0cUi5wgcwBZFw0GMJGcaxJ9e8H9C8e8yUGJP4bmJp+v0q8aCNiyo0/4M
         gFN/yqyLo4txFVacsbdNlBotfUfGiV1C1XxG8XSOKlAhaNdUyfMOCEhryiXzfbBpdi4C
         cLhz7d8aX9Os9L83kdMSuSYYXxf5WGkXHEdDO8436nh1Q/OhRJCUP+6CIR0a+ru7+H53
         uB2Q==
X-Gm-Message-State: AOJu0Yzg27p4jfCpbfi8UMNzQtH2s8vCnaY9caRIQy6b/pPfn0v1H/0o
	PWgt9QGcBUUbafR5qcE+hzlBAjgJvpH7vGbbxFI0HJA0tJJjww==
X-Google-Smtp-Source: AGHT+IH12JGuhOXnPwkMPyPNFnzyOyheXgVEpowG96l+3VnSwwf5LCOXbq2mTxHi20e+2b2YPv9tAK1ilFkNQdumMR8=
X-Received: by 2002:a17:90b:4b84:b0:280:2823:6615 with SMTP id
 lr4-20020a17090b4b8400b0028028236615mr1829826pjb.36.1699543530439; Thu, 09
 Nov 2023 07:25:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109032521.392217-1-jeff.xie@linux.dev> <20231109032521.392217-2-jeff.xie@linux.dev>
 <ZUzl0U++a5fRpCQm@casper.infradead.org>
In-Reply-To: <ZUzl0U++a5fRpCQm@casper.infradead.org>
From: Jeff Xie <xiehuan09@gmail.com>
Date: Thu, 9 Nov 2023 23:25:18 +0800
Message-ID: <CAEr6+EB5q3ksmgYruOVngiwf6KJcrzABchd=Osyk0MiVDGQyQQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/4] mm, page_owner: add folio allocate post callback
 for struct page_owner to make the owner clearer
To: Matthew Wilcox <willy@infradead.org>
Cc: Jeff Xie <jeff.xie@linux.dev>, akpm@linux-foundation.org, iamjoonsoo.kim@lge.com, 
	vbabka@suse.cz, cl@linux.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chensong_2000@189.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Thu, Nov 9, 2023 at 10:00=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Nov 09, 2023 at 11:25:18AM +0800, Jeff Xie wrote:
> > adding a callback function in the struct page_owner to let the slab lay=
er or the
> > anon/file handler layer or any other memory-allocated layers to impleme=
nt what
> > they would like to tell.
>
> There's no need to add a callback.  We can tell what a folio is.
>
> > +     if (page_owner->folio_alloc_post_page_owner) {
> > +             rcu_read_lock();
> > +             tsk =3D find_task_by_pid_ns(page_owner->pid, &init_pid_ns=
);
> > +             rcu_read_unlock();
> > +             ret +=3D page_owner->folio_alloc_post_page_owner(page_fol=
io(page), tsk, page_owner->data,
> > +                             kbuf + ret, count - ret);
> > +     } else
> > +             ret +=3D scnprintf(kbuf + ret, count - ret, "OTHER_PAGE\n=
");
>
>         if (folio_test_slab(folio))
>                 ret +=3D slab_page_owner_info(folio, kbuf + ret, count - =
ret);
>         else if (folio_test_anon(folio))
>                 ret +=3D anon_page_owner_info(folio, kbuf + ret, count - =
ret);
>         else if (folio_test_movable(folio))
>                 ret +=3D null_page_owner_info(folio, kbuf + ret, count - =
ret);
>         else if (folio->mapping)
>                 ret +=3D file_page_owner_info(folio, kbuf + ret, count - =
ret);
>         else
>                 ret +=3D null_page_owner_info(folio, kbuf + ret, count - =
ret);
>
> In this scenario, I have the anon handling ksm pages, but if that's not
> desirable, we can add
>
>         else if (folio_test_ksm(folio))
>                 ret +=3D ksm_page_owner_info(folio, kbuf + ret, count - r=
et);
>
> right before the folio_test_anon() clause

Thank you very much for your advice and guidance.
From the perspective of a folio, it cannot obtain information about
all the situations in which folios are allocated.
If we want to determine whether a folio is related to vmalloc or
kernel_stack or the other memory allocation process,
using just a folio parameter is not sufficient. To achieve this goal,
we can add a callback function to provide more extensibility and
information.

for example:

=EF=BC=88the following "OTHER_PAGE" will be replaced with the specified
information later=EF=BC=89

 Page allocated via order 0, mask
0x2102(__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 0, tgid 0
(swapper/0), ts 167618849 ns
OTHER_PAGE
PFN 0x4a92 type Unmovable Block 37 type Unmovable Flags
0x1fffc0000000000(node=3D0|zone=3D1|lastcpupid=3D0x3fff)
 post_alloc_hook+0x77/0xf0
 get_page_from_freelist+0x58d/0x14e0
 __alloc_pages+0x1b2/0x380
 __alloc_pages_bulk+0x39f/0x620
 alloc_pages_bulk_array_mempolicy+0x1f4/0x210
 __vmalloc_node_range+0x756/0x870
 __vmalloc_node+0x48/0x60
 gen_pool_add_owner+0x3e/0xb0
 mce_gen_pool_init+0x5a/0x90
 mcheck_cpu_init+0x170/0x4c0
 identify_cpu+0x55f/0x7e0
 arch_cpu_finalize_init+0x10/0x100
 start_kernel+0x517/0x8e0
 x86_64_start_reservations+0x18/0x30
 x86_64_start_kernel+0xc6/0xe0
 secondary_startup_64_no_verify+0x178/0x17b

--=20
Thanks,
JeffXie

