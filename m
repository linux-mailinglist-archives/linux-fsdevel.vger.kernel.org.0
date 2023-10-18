Return-Path: <linux-fsdevel+bounces-675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FF27CE40B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 19:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C92D1F22E62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACCB3D965;
	Wed, 18 Oct 2023 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhHQZJZl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4C537C89;
	Wed, 18 Oct 2023 17:13:05 +0000 (UTC)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE38109;
	Wed, 18 Oct 2023 10:13:03 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso7405106276.3;
        Wed, 18 Oct 2023 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697649183; x=1698253983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8MJitPq3EuZNqZzmcuBF44/gPicl41BPndNyHpIDdPA=;
        b=fhHQZJZleuVA3fmNCiG4lu2NmFreKXPyP0QEobY+eS4D7SSsgJlTMLFpUr1PlmyZ9N
         Jb31E58/ywSo+mLye/z3XELF3d14mdnAFJj+mNJqeIxsjSwZLKvxfWj5Ay2/0sgfMvWZ
         mhYaY3Lo4yC6jzENVds+hekpE7qlbJvXs/cYjyOylaHiICkOc2SvNB5T6fRAyQeh+e9X
         47Df55tVHHbgBu3JUcVakmbpCfhyTbcCTNAewxxP3Yff//F12ApwA3XVDow2G58P2qX/
         Jj0JYwDiNi8tfhGAUn/MhD4nscawpMJfYZ5JWMPODqSUY5YbDKVgqeuuj6JSEFLw24R5
         RcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697649183; x=1698253983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8MJitPq3EuZNqZzmcuBF44/gPicl41BPndNyHpIDdPA=;
        b=NQ1qdNLxCZSzwD591JlbM04CSW+lAi6QI6P7vzmLD021VsnczujeRGcOhiUyVuo+nb
         +0Nwk9VeUFNiKr+AcDzYFKgy5qjTlfhk98UHGUQDhMG8psEhoZSKh7upkmZbDW+McJRE
         zZSqHDCh+KMvdwuS5jUSo2gjkYPxqxpRbavzSAaktWASDsE+0yVLHoCsN68de2h9ISPj
         krreolBgvywS456FFkbLq7WWObN8EbUlL57M+hd2jACN6k009+FDFCTjfeiZux9Fog98
         xxTqFV74T27BTOz5OdKwBSYCMf0/7+qJDxHpfMD6qQExGMRJjotIStACpfGioMxodHP5
         fAdw==
X-Gm-Message-State: AOJu0YxCYIqoFNTLJR03b2cw+LLF0tWHcAJs6Me8KTH7ZsS+Mj/fLsRP
	4mY28Ey0jKSF0W+/UxysoTOLGF0+f6anxWsNsUg=
X-Google-Smtp-Source: AGHT+IF/y6EsJXDQNUP7bRk0kNzTiPGkV88lS7TU9UDxuXoGz49cYNI/VAUkz/gmbSrnOS1/cgnTcMYwipmRq4BjP8I=
X-Received: by 2002:a25:d617:0:b0:d9a:c8fe:265c with SMTP id
 n23-20020a25d617000000b00d9ac8fe265cmr5920594ybg.44.1697649182549; Wed, 18
 Oct 2023 10:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <fglmouoerwv2wedf5kmfyggalcs5hbdhru5ms4jqftlie6ta5a@2726hqdlcste>
In-Reply-To: <fglmouoerwv2wedf5kmfyggalcs5hbdhru5ms4jqftlie6ta5a@2726hqdlcste>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Wed, 18 Oct 2023 14:12:51 -0300
Message-ID: <CANeycqrZ6H83qx00EeZKh7SkDBjofoOg-10PnHgBkGbz-LRcJg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
To: "Ariel Miculas (amiculas)" <amiculas@cisco.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 18 Oct 2023 at 10:40, Ariel Miculas (amiculas)
<amiculas@cisco.com> wrote:

> I'm missing `CONFIG_NUMA`, which seems to guard `folio_alloc`
> (include/linux/gfp.h):
> ```
> #ifdef CONFIG_NUMA
> struct page *alloc_pages(gfp_t gfp, unsigned int order);
> struct folio *folio_alloc(gfp_t gfp, unsigned order);
> struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
>                 unsigned long addr, bool hugepage);
> #else
> ```

Hey Ariel, thanks for finding this.

When CONFIG_NUMA is not defined, `folio_alloc` is a static inline
function defined in the header file, so bindgen doesn't generate a
binding for it. I'll fix this by adding a helper in rust/helpers.c.

