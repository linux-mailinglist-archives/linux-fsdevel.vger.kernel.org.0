Return-Path: <linux-fsdevel+bounces-1839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CA67DF5C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 16:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63121C20F3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 15:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147351C282;
	Thu,  2 Nov 2023 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="k5GtqmgI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458105227
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 15:11:45 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA8D138
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 08:11:41 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-418201cb9e9so5760841cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1698937900; x=1699542700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAw9sv/T68KQfbkbViSCXGIX3HBnIacj63UFeeK2mDo=;
        b=k5GtqmgIetQC+bLlwfHCHMHhhhPrSzC/+VXFqILAjNBSj2ivUOKMmdTww8BL4waky0
         Kb7gO9lLLL2aGWD/5kA4KVIiaUNrhNAFgwAYY7vWhqYXWzciryo540xOoRQ3v2VoTkIm
         9vrPft4TRSHG73aD4ecg564Y8Rrn2UvCP/2FGqXhPrkpMFhsGsnasz/j2lvrZtTkwS2Z
         KuuIM1lsulAFBcu6mE7DsJqW55c2i24g4lg3zAGan0wVBGKyyKfM2Kh+sMZecJTPvxv+
         OPtNCB3vJkp8OleOizYkZ4542JeD3rRevI+jIQ3/X+5V0sVWrWlVP3p3h3O59jmtJFux
         yWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698937900; x=1699542700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAw9sv/T68KQfbkbViSCXGIX3HBnIacj63UFeeK2mDo=;
        b=M3DQnoeV6gGKsYa16IrEsl5xjVHQeus1ckGaSJ6/kg5E9cFJXFHnMHlTnOvS66JKwO
         XHQrwLTHvR8sfT+U0qIDyWiEIYBZQ1eGi+4W1pWFla3Ts16aZmVRWA+fFScZBKeSLz7b
         uyaSqKmaYshKoNFcOuWtoX8oyixhL4rL3bjfyQS/qBupOKKimimsrSB9iCo5yDGVqIl0
         4ZcFKNRGX4LjbylmuGzM2HCrTJm4DCa3FDEWzoL1dAwbH3i3NeiI7XAzsa97IRfo8ZNo
         348GwfFy0aggr8EIPVa7BkqlbpG6b25tHrrbmtmIlCuGyG6S5NRf1h3RUrDRLTalIg0a
         iaeA==
X-Gm-Message-State: AOJu0Yy76MCbG5b6/bhOOlfgNFBHwaBxN0puuJQz+FgAp0kXcQrk5tL6
	+Ysj4DyhVYV+DM8FfF3tKY2PART5qdTAmve4qdCT5Q==
X-Google-Smtp-Source: AGHT+IHcYzPWiAFmBoXSyJoDI64wpvja1WI+ECLeWeUah15PFIwLSppZZtojijKSQdF7suJdY1SYkg/gdOmnHPwYHJk=
X-Received: by 2002:ac8:5f06:0:b0:41e:2112:611f with SMTP id
 x6-20020ac85f06000000b0041e2112611fmr20358911qta.39.1698937900089; Thu, 02
 Nov 2023 08:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com> <2023110205-enquirer-sponge-4f35@gregkh>
 <CA+CK2bDUaQDwgF-Q0vfNzHfXmn-QhnHTSE32_RfttHSGB7O3DA@mail.gmail.com> <2023110216-labrador-neurosis-1e6e@gregkh>
In-Reply-To: <2023110216-labrador-neurosis-1e6e@gregkh>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 Nov 2023 11:11:03 -0400
Message-ID: <CA+CK2bCFgwLXp=pUTKezWtRoCKiDC41DqGXx_kahg0UcB53sPw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sourav Panda <souravpanda@google.com>, corbet@lwn.net, rafael@kernel.org, 
	akpm@linux-foundation.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	rppt@kernel.org, david@redhat.com, rdunlap@infradead.org, 
	chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com, 
	bhelgaas@google.com, ivan@cloudflare.com, yosryahmed@google.com, 
	hannes@cmpxchg.org, shakeelb@google.com, kirill.shutemov@linux.intel.com, 
	wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, weixugc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 10:29=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Nov 02, 2023 at 10:24:04AM -0400, Pasha Tatashin wrote:
> > On Thu, Nov 2, 2023 at 1:42=E2=80=AFAM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Wed, Nov 01, 2023 at 04:08:16PM -0700, Sourav Panda wrote:
> > > > Adds a new per-node PageMetadata field to
> > > > /sys/devices/system/node/nodeN/meminfo
> > >
> > > No, this file is already an abuse of sysfs and we need to get rid of =
it
> > > (it has multiple values in one file.)  Please do not add to the
> > > nightmare by adding new values.
> >
> > Hi Greg,
> >
> > Today, nodeN/meminfo is a counterpart of /proc/meminfo, they contain
> > almost identical fields, but show node-wide and system-wide views.
>
> And that is wrong, and again, an abuse of sysfs, please do not continue
> to add to it, that will only cause problems.
>
> > Since per-page metadata is added into /proc/meminfo, it is logical to
> > add into nodeN/meminfo, some nodes can have more or less struct page
> > data based on size of the node, and also the way memory is configured,
> > such as use of vmemamp optimization etc, therefore this information is
> > useful to users.
> >
> > I am not aware of any example of where a system-wide field from
> > /proc/meminfo is represented as a separate sysfs file under node0/. If
> > nodeN/meminfo is ever broken down into separate files it will affect
> > all the fields in it the same way with or without per-page metadata
>
> All of the fields should be individual files, please start adding them
> if you want to add new items, I do not want to see additional abuse here

Sounds good, in our next patch version we will create a new file under
nodeN/ to contain per-page metadata overhead, and add an ABI doc file
for it.

Thanks,
Pasha

