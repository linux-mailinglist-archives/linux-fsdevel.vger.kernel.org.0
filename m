Return-Path: <linux-fsdevel+bounces-963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1B57D3FBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 21:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDF36B20E75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F1C21A01;
	Mon, 23 Oct 2023 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMoDV5oP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B61F219EE
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 19:00:33 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FB2172C
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 12:00:21 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7fb84f6ceso34950637b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698087621; x=1698692421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtdA9ub/ANr7ejS62Fd8050vwxz1kSazOAjElqLmkxM=;
        b=PMoDV5oPWWZLd9mFQbXBvL+JlLndRu926JSGLEhJMxss3Lp8WoBDWKdmp+xRF0Lf7E
         GkLPVBkUCV3ME9LzUyD+VC283keAsJ+wwhGBV3N/tgEZXRGXnJtTj12tteov5HxVufgm
         b67/0BZddh+lo0ekqlQnsY42r4/wrmeMXmSA60x1Tq4L5SaBijYBr8w3Hn6Hntsv6w8V
         PoTJY8RclYmTmh2JWK/rYqkD58NVAK/WffOkhzICBJE4/FjvdRRd1fPHCH09StKc5/6b
         pGc6SRBHBCOq6QCdQdDcB/x1zCG1BmlluAhrbtZq9KyZ8AL+F8AhBPdLXebKQiOunsOS
         KtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698087621; x=1698692421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtdA9ub/ANr7ejS62Fd8050vwxz1kSazOAjElqLmkxM=;
        b=F+ZUraGhNG+Uxw21A65GC4CSNJ49oIeTRvXnmUI4qQ+he+vE4Bf09D3l9s1X8TarGk
         k8zUZTo9PIfCzvDymWKYMeMTIUK7rv/1Z09+mMSe+kUJwPhix3wVRmxI6N/EzoAxkqAn
         DthV5ty8wdJ2wMYy0wFZDOCSwwa53/QWDV1liRvmyQ7nd7iT96Kfz9bLUGuHGTgwt8GO
         rhon0SP1mJpPE8FXkf6T7bqSCj87xOQfgB9utAvibVkLhNjQmDsQ9a1zjTTtWbyVTaQl
         2XDdbNumhfe4ERqzlmWhmzdtKD/gr06Ai6oF0yv/qLMt1KAY0MZDXyW+tjlsn5K/XNLC
         8/kQ==
X-Gm-Message-State: AOJu0Yy6Ki0cwOIKaJCkw3NEemt3cgCSzIEDfAC4SnmL3Cfhi/UYDLNi
	PP5R8FnBwEFC60YbZpcQ7ImSp4kKFxp7JlfEcUxIKg==
X-Google-Smtp-Source: AGHT+IHoBU3f92OsehjvOqFbu0XBgHXFL1aR9fooZex3IOmb5ltIYm/8vL48yXoinuA4SJCQtcFh+3IhHsrl1XTH5gA=
X-Received: by 2002:a25:86c1:0:b0:d9a:b522:6870 with SMTP id
 y1-20020a2586c1000000b00d9ab5226870mr8756763ybm.0.1698087620747; Mon, 23 Oct
 2023 12:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com> <20231009064230.2952396-3-surenb@google.com>
 <721366d0-7909-45c9-ae49-f652c8369b9d@redhat.com> <045c35ba-7872-40a7-bd86-e37771076b88@redhat.com>
In-Reply-To: <045c35ba-7872-40a7-bd86-e37771076b88@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 23 Oct 2023 12:00:09 -0700
Message-ID: <CAJuCfpH8oare_erzHuhiV0knbwVEmOzq6DnoywNQpOCAqJMucA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com, 
	peterx@redhat.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 8:53=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 23.10.23 14:29, David Hildenbrand wrote:
> >> +
> >> +    /* Only allow remapping if both are mlocked or both aren't */
> >> +    if ((src_vma->vm_flags & VM_LOCKED) !=3D (dst_vma->vm_flags & VM_=
LOCKED))
> >> +            return -EINVAL;
> >> +
> >> +    if (!(src_vma->vm_flags & VM_WRITE) || !(dst_vma->vm_flags & VM_W=
RITE))
> >> +            return -EINVAL;
> >
> > Why does one of both need VM_WRITE? If one really needs it, then the
> > destination (where we're moving stuff to).
>
> Just realized that we want both to be writable.
>
> If you have this in place, there is no need to use maybe*_mkwrite(), you
> can use the non-maybe variants.

Ack.

>
> I recall that for UFFDIO_COPY we even support PROT_NONE VMAs, is there
> any reason why we want to have different semantics here?

I don't think so. At least not for the single-mm case.

>
> --
> Cheers,
>
> David / dhildenb
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

