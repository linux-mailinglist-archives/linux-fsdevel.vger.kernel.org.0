Return-Path: <linux-fsdevel+bounces-4929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028B8806644
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 05:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E2B280CA6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 04:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9EEA57
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 04:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="C043Y/o3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401EC1B6
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 18:58:13 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-423c28db22eso2677471cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 18:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701831492; x=1702436292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+W/qJKZ4cbrJ9KJlY0HysuZCkaE03MWjevhyEtd/+k=;
        b=C043Y/o3nmZqO5drW/ytixLfQ3/Yg2tetNJ0mozl0W+LJt8PrvkZDAAIKO//77o7xS
         0vqPrnh0AqwIRYO3RKVoC5ULQcJfkvb/hru7xXNasnVGsAPahqk16ksdIVuzY9m7ZPUf
         re6qs37H9QdFVzcLsxMv/4Ias8TG8Qd/jvNo8H4/2IcQN9MMZn/cSe+z1fFc/AOMpi9n
         x8wq5qimJhIL8H4RTe1di1VNm1dSN2c6r0v68/rRjx1+NtfNHJ8swQDXd5oHh8enH4Mr
         N8/keY1Gykp3G+pSqxTDs5MRp9GN0a8yzS7JrndjN7fO4b3X3N6pGougdIX03jUMTvQn
         ZXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701831492; x=1702436292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+W/qJKZ4cbrJ9KJlY0HysuZCkaE03MWjevhyEtd/+k=;
        b=qokkxab4iO0H2hChc0IJL3mmH0sS1UKrwn7sHDowQT5sXJNMXaWsENimFE0MtbEiwZ
         oYYabQ52qKLMKS5LDimV/bIJxIfJK04LD/PzwjQTFytVg+4HXyS5SQkG7UDElqlM0+mM
         Yf6YbIVWTkzrc0RxyevmsfEQG2A5wUe7MgAM/WLd9ZvpIOYOmbHUdRk3WhYxBOe1vhkj
         urbh+vx86lYg1+yKCcwCTPWooMzyICTuP5Suqu2tTobnel6TLLuZ9S20heQ1t74vLMaV
         z/lH9y0DdavnS8C6uXUHa5sLv0Tra3rTiy+tGgGPUNTDPiWSr+CTZ1iV0vWfQTxdfdkJ
         YupQ==
X-Gm-Message-State: AOJu0YxJUi6OJCjmfzeStS8U1/zHT1hG5zd10Eh+Y/OIMlDtDgRYdsDQ
	meL0ikYYib7luljFQmCkbKiEbZGM/Jh7hdm+KUTI3JF+a9bSXNOB/+k=
X-Google-Smtp-Source: AGHT+IF/PbeDPHGTwTbaA2pV4mOFvfRBSKmJB7XTO8IsjUWL5YNJ6TW8QV1NfT/POdd4ka0OvkcYQJe1EpzjjtkHa0g=
X-Received: by 2002:a05:622a:1315:b0:425:4420:c176 with SMTP id
 v21-20020a05622a131500b004254420c176mr3223260qtk.27.1701831492370; Tue, 05
 Dec 2023 18:58:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205223118.3575485-1-souravpanda@google.com> <2023120648-droplet-slit-0e31@gregkh>
In-Reply-To: <2023120648-droplet-slit-0e31@gregkh>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 5 Dec 2023 21:57:36 -0500
Message-ID: <CA+CK2bARjZgnMBL9bOD7p1u=02-fGgWwfiGvsFVpsJWL-VR2ng@mail.gmail.com>
Subject: Re: [PATCH v6 0/1] mm: report per-page metadata information
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

Hi Greg,

Sourav removed the new field from sys/device../nodeN/meminfo as you
requested; however, in nodeN/vmstat fields still get appended, as
there is code that displays every item in zone_stat_item,
node_stat_item without option to opt-out. I mentioned it to you at
LPC.

In my IOMMU [1] series, there are also fields that are added to
node_stat_item that as result are appended to nodeN/vmstat.

Pasha

[1] https://lore.kernel.org/all/20231130201504.2322355-1-pasha.tatashin@sol=
een.com

On Tue, Dec 5, 2023 at 9:36=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Tue, Dec 05, 2023 at 02:31:17PM -0800, Sourav Panda wrote:
> > Changelog:
> > v6:
> >       - Interface changes
> >               - Added per-node nr_page_metadata and
> >                 nr_page_metadata_boot fields that are exported
> >                 in /sys/devices/system/node/nodeN/vmstat
>
> Again, please do not add any new fields to existing sysfs files, that's
> not going to work well.  You can add a new sysfs file, that's file, but
> do not continue the abuse of the sysfs api in this file.
>
> thanks,
>
> greg k-h

