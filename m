Return-Path: <linux-fsdevel+bounces-1880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CC47DFB76
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 21:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2AB3B212AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 20:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D893B21A0B;
	Thu,  2 Nov 2023 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VVXw20Ck"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD63219F6
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 20:22:33 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50E8192
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 13:22:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32df66c691dso739276f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 13:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698956549; x=1699561349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2OmO/cSIWcHLs5m9Fp9R9ncrDst5FOA+aif1w7pvlY=;
        b=VVXw20Ck559qbFs8nOTmwLTg3VE6Z8QGY7PQOXI2emiI6FfSearhwJGE91XsXH/LHJ
         PV1O6YQ+5QyE2feTXU5dGonPqp68rzG83VTM75gHXFcW5Fdk7E1+9FnITs+rwAXOIVOQ
         wJF1hZ/X3aq7eZsAhdoXiDr6a99IH9n5/trPQimDxmavKwim5WGKUTA1c47Gto49/jqu
         bSmHF+kVgyqISE4xdsP6z3G4Z7wVER0N260qFgx09FNFSmwhjPaZQDswaD2xh5h8e8sP
         pQb4NCjityjzx1ywpFJyA7fyS9ZzLn6iHGzZCQmG7r6WpaB04M+d/g87+gHA7iXUpT6n
         FBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698956549; x=1699561349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2OmO/cSIWcHLs5m9Fp9R9ncrDst5FOA+aif1w7pvlY=;
        b=wa75thPcmCMsiDyX+dUXZlLCXzo7CJuRlJeku2210IkrXtVCemebjLIDRHVTZXY2eS
         aOLEROt55EJfFJkP2Eezs80JDohzWE3F9CkoY4bRlgIizWGj07FL06NrccWp7+YgI7od
         03TMBDQ+MFV8TI3DaK/9I1wILqh7Mo9gVa1omF7GNE6FFIeDu3GADMT3meX4WbU6PsE3
         usLy+/jBonLx+13WlF516tzP7oCqGaZSYnXhMoJ9bABDnPJ4lQgCD4+09mU/SEx1m/fX
         W3U3wrolzEu5A98PUME64kM2ZbMrWXlz0uvaxKt+DIjk75yNCu+H8r17u8iWJtV1nmF0
         Z2cQ==
X-Gm-Message-State: AOJu0YztshKZ0Sw83DONOmChZM+8aIxvgHZGL5aSyFGXmG6baPMqlsqr
	pwsQDqpauZddnOFzPjLoHt8eovtV2Qmk4U6Si+1/wA==
X-Google-Smtp-Source: AGHT+IGWJTOQ+YhYnai3xZ5GlBXEVrHAqeGyrw5YY2JPOXTz5UPWJyE0CwKm1+LwoDz/xF/C9pX5+Zcy8M468XbZ27o=
X-Received: by 2002:adf:f6c5:0:b0:323:36f1:c256 with SMTP id
 y5-20020adff6c5000000b0032336f1c256mr15140662wrp.11.1698956549087; Thu, 02
 Nov 2023 13:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com> <CAAPL-u_enAt7f9XUpwYNKkCOxz2uPbMrnE2RsoDFRcKwZdnRFQ@mail.gmail.com>
 <CA+CK2bC3rSGOoT9p_VmWMT8PBWYbp7Jo7Tp2FffGrJp-hX9xCg@mail.gmail.com>
 <CAAPL-u-4D5YKuVOsyfpDUR+PbaA3MOJmNtznS77bposQSNPjnA@mail.gmail.com>
 <1e99ff39-b1cf-48b8-8b6d-ba5391e00db5@redhat.com> <CA+CK2bDo6an35R8Nu-d99pbNQMEAw_t0yUm0Q+mJNwOJ1EdqQg@mail.gmail.com>
 <025ef794-91a9-4f0c-9eb6-b0a4856fa10a@redhat.com> <CA+CK2bDJDGaAK8ZmHtpr79JjJyNV5bM6TSyg84NLu2z+bCaEWg@mail.gmail.com>
 <99113dee-6d4d-4494-9eda-62b1faafdbae@redhat.com> <CA+CK2bApoY+trxxNW8FBnwyKnX6RVkrMZG4AcLEC2Nj6yZ6HEw@mail.gmail.com>
 <b71b28b9-1d41-4085-99f8-04d85892967e@redhat.com> <CA+CK2bCNRJXm2kEjsN=5a_M8twai4TJX3vpd72uOHFLGaDLg4g@mail.gmail.com>
 <CAAPL-u_OWFLrrNxszm4D+mNiZY6cSb3=jez3XJHFtN6q05dU2g@mail.gmail.com> <CA+CK2bBPBtAXFQAFUeF8nTxL_Sx926HgR3zLCj_6pKgbOGt8Wg@mail.gmail.com>
In-Reply-To: <CA+CK2bBPBtAXFQAFUeF8nTxL_Sx926HgR3zLCj_6pKgbOGt8Wg@mail.gmail.com>
From: Wei Xu <weixugc@google.com>
Date: Thu, 2 Nov 2023 13:22:17 -0700
Message-ID: <CAAPL-u9HHgPDj_xTTx=GqPg49DcrpGP1FF8zhaog=9awwu0f_Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: David Hildenbrand <david@redhat.com>, Sourav Panda <souravpanda@google.com>, corbet@lwn.net, 
	gregkh@linuxfoundation.org, rafael@kernel.org, akpm@linux-foundation.org, 
	mike.kravetz@oracle.com, muchun.song@linux.dev, rppt@kernel.org, 
	rdunlap@infradead.org, chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, 
	tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com, 
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com, 
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 11:34=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> > > > I could have sworn that I pointed that out in a previous version an=
d
> > > > requested to document that special case in the patch description. :=
)
> > >
> > > Sounds, good we will document that parts of per-page may not be part
> > > of MemTotal.
> >
> > But this still doesn't answer how we can use the new PageMetadata
> > field to help break down the runtime kernel overhead within MemUsed
> > (MemTotal - MemFree).
>
> I am not sure it matters to the end users: they look at PageMetadata
> with or without Page Owner, page_table_check, HugeTLB and it shows
> exactly how much per-page overhead changed. Where the kernel allocated
> that memory is not that important to the end user as long as that
> memory became available to them.
>
> In addition, it is still possible to estimate the actual memblock part
> of Per-page metadata by looking at /proc/zoneinfo:
>
> Memblock reserved per-page metadata: "present_pages - managed_pages"

This assumes that all reserved memblocks are per-page metadata. As I
mentioned earlier, it is not a robust approach.

> If there is something big that we will allocate in that range, we
> should probably also export it in some form.
>
> If this field does not fit in /proc/meminfo due to not fully being
> part of MemTotal, we could just keep it under nodeN/, as a separate
> file, as suggested by Greg.
>
> However, I think it is useful enough to have an easy system wide view
> for Per-page metadata.

It is fine to have this as a separate, informational sysfs file under
nodeN/, outside of meminfo. I just don't think as in the current
implementation (where PageMetadata is a mixture of buddy and memblock
allocations), it can help with the use case that motivates this
change, i.e. to improve the breakdown of the kernel overhead.

> > > > > are allocated), so what would be the best way to export page meta=
data
> > > > > without redefining MemTotal? Keep the new field in /proc/meminfo =
but
> > > > > be ok that it is not part of MemTotal or do two counters? If we d=
o two
> > > > > counters, we will still need to keep one that is a buddy allocato=
r in
> > > > > /proc/meminfo and the other one somewhere outside?
> > > >
> >
> > I think the simplest thing to do now is to only report the buddy
> > allocations of per-page metadata in meminfo.  The meaning of the new
>
> This will cause PageMetadata to be 0 on 99% of the systems, and
> essentially become useless to the vast majority of users.

I don't think it is a major issue. There are other fields (e.g. Zswap)
in meminfo that remain 0 when the feature is not used.

