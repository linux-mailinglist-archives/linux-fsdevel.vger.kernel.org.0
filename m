Return-Path: <linux-fsdevel+bounces-63286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0EEBB3F8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 15:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3528C4E25D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 13:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94834310630;
	Thu,  2 Oct 2025 13:01:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09C5283C93
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759410117; cv=none; b=YAfisgNgVe1/mraO29s0sid7B5iihx814xBoHfVp/BYeT6o50wa48CtkUAik6P9DQDsCSQjMGtyQghf0rwaaGIkku3QjwTtVl6dFk8J9FlvvZ36vtvb6B3whNBoqs4gTkZ4CINkG4glSWVav2o0B4uWDhuP8G64PBmuSjweSFmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759410117; c=relaxed/simple;
	bh=Bzm3UVzy5UmWZcilLMKv+UlC3Okbitce2Is02Gaxtrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEGykEKrmRs8jyhKRnhEQSxtbx2pYwWKPQdpbwvoGZG64Zdxwwy7v1NQIvTRvJ5eyMkXFI/xGiuEY77+3GmJ7U4mQwZjMD4GP3Kt6lZa0WZ7YpUTltDwFCJ3ni6EVTB8D+eNotZDCNTVhq+L8WFHCrKiMdfa4EvarlZo+x5oLRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-796fe71deecso9939656d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 06:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759410114; x=1760014914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ec+ndxQ3jnu1a8VNviNr06HkWUDsCBC6MfDIjOmWDIU=;
        b=cFDnwlFztOudLQiPb73VvkzPTwupUhubX2LTdkBLscgDMiy+J/Qmi3QKsG8H0kg9mj
         VUnPVgguJpNwfDfMa9IlbITSRVWYLxouDEXTNInUmCWG/PPs3wocSC2wLS0clvs0EZZQ
         T3l2c3j6AY08HDLx3qUv3bqm10+AvSFg/lndGqK7li7w9IITnwNC46Gq6zqEI5VgqXtG
         qkavDofDVJGR7SYtkLbgqqPA8oY2umtk5wdvklOPlV3OAl0o3ibHEYGd09zfhLqxJwDL
         MV6ZAnWiOAq63uTuYxB7STOTBvWcbt6jPJtMSFBQuBUXAruaUpVbFOdKATTHSj29DmbF
         ORaw==
X-Forwarded-Encrypted: i=1; AJvYcCVV7E1yNgL6MidR4Jo6Na0n2x5D2/zI0P2gCt9r0t+N8CdDdOc9TZvqkHn8ELlimWnTmHL2t3T2PKFoKy0z@vger.kernel.org
X-Gm-Message-State: AOJu0YwiHodtfkOMpUqZOR6sV5RYZLuS6rEFqYEAsfyky7ZMzR0+5oHg
	iNOgczJXnhrrS/IF87MOvBMtB+iYpa3LafX0KS4j5vEXkvl51XhaUWNRe6V+eIHRX3YbeA==
X-Gm-Gg: ASbGnctO7qwnOogljX+GRRjaYJTgK3lyZNmU5PeXfT/oFX0LP8Sy7A6cWucziYwxOTo
	Hq/syDWJol2GHeKfxHyNek0Oi4upVtipUE5HgkcMXQG9w9adJJaymLI6Vn12wxutDdtZDpBLvrR
	5Rqeh//x3QgLSWkEN2Lj8taUcciW2p1EJ3oi8hwrYA4AmZf2e7F82tatgxRLxU0fP+83PheysPy
	eQcZDGBwAFpcw9AUzdshE9ReM/YrYnBbzeuNp6xLOrgu2l1AxtP5UlGIaq80QhQXweD6Bpv9A++
	pob86SdQTcOJbBmqqUaeDZjyfdrP3rTcod+nN2p7c2Kyszl8rQRI92fKeDbkQ/d1r5Yg+1RMFWC
	F5PdEFfT7MzlgrC6M1LoauGhLxGwDRuL9G0G7QLq/v8eR9Kr4PV0MLMKnu2pQY0ru+rTWFFpzLX
	zbsrT80UbSGJ6a
X-Google-Smtp-Source: AGHT+IHTxr/N9F7kpLFmIiNvxzRFNM5EBp1nJtdDzK10CE2f539sMM3wiedX1wQDrEmppuHaAxTUuA==
X-Received: by 2002:a05:6214:8083:b0:878:ee25:427d with SMTP id 6a1803df08f44-878ee25486cmr27167976d6.59.1759410114102;
        Thu, 02 Oct 2025 06:01:54 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf53430sm18644506d6.48.2025.10.02.06.01.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 06:01:53 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4db385e046dso9810601cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 06:01:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqybQkzwaQOa1f6bGFTzNzmkWB+inP68eUIXwpht37OYatDzijho7lPihZ9Bt6bSddbYrLeku+8IQrhorY@vger.kernel.org
X-Received: by 2002:a67:f74a:0:b0:5d3:fecb:e4e8 with SMTP id
 ada2fe7eead31-5d3fecbe643mr2057033137.5.1759409779799; Thu, 02 Oct 2025
 05:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002081247.51255-1-byungchul@sk.com> <20251002081247.51255-3-byungchul@sk.com>
 <2025100255-tapestry-elite-31b0@gregkh>
In-Reply-To: <2025100255-tapestry-elite-31b0@gregkh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:56:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWXuXh4SVu-ORghAqsZa7U6_mcW44++id9ioUm5Y4KTLw@mail.gmail.com>
X-Gm-Features: AS18NWCmqHU8DKNueQjpF6Ifrv2W5fzYfUTjQ8XBBt-1KrFWqeUHHsvmYo_0fpY
Message-ID: <CAMuHMdWXuXh4SVu-ORghAqsZa7U6_mcW44++id9ioUm5Y4KTLw@mail.gmail.com>
Subject: Re: [PATCH v17 02/47] dept: implement DEPT(DEPendency Tracker)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org, kernel_team@skhynix.com, 
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com, 
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org, 
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch, 
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu, 
	willy@infradead.org, david@fromorbit.com, amir73il@gmail.com, 
	kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org, 
	mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org, 
	vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, 
	cl@linux.com, penberg@kernel.org, rientjes@google.com, vbabka@suse.cz, 
	ngupta@vflare.org, linux-block@vger.kernel.org, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org, 
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org, 
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com, 
	melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com, 
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, 
	max.byungchul.park@gmail.com, boqun.feng@gmail.com, longman@redhat.com, 
	yunseong.kim@ericsson.com, ysk@kzalloc.com, yeoreum.yun@arm.com, 
	netdev@vger.kernel.org, matthew.brost@intel.com, her0gyugyu@gmail.com, 
	corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org, 
	sumit.semwal@linaro.org, gustavo@padovan.org, christian.koenig@amd.com, 
	andi.shyti@kernel.org, arnd@arndb.de, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com, 
	mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	samitolvanen@google.com, paulmck@kernel.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org, 
	urezki@gmail.com, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang@linux.dev, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, 
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	mark.rutland@arm.com, ada.coupriediaz@arm.com, kristina.martsenko@arm.com, 
	wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com, 
	dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com, 
	yuzhao@google.com, baolin.wang@linux.alibaba.com, usamaarif642@gmail.com, 
	joel.granados@kernel.org, richard.weiyang@gmail.com, geert+renesas@glider.be, 
	tim.c.chen@linux.intel.com, linux@treblig.org, 
	alexander.shishkin@linux.intel.com, lillian@star-ark.net, 
	chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com, 
	link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org, brauner@kernel.org, 
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com, 
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Thu, 2 Oct 2025 at 10:25, Greg KH <gregkh@linuxfoundation.org> wrote:
> > @@ -0,0 +1,446 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * DEPT(DEPendency Tracker) - runtime dependency tracker
> > + *
> > + * Started by Byungchul Park <max.byungchul.park@gmail.com>:
> > + *
> > + *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
> > + *  Copyright (c) 2024 SK hynix, Inc., Byungchul Park
>
> Nit, it's now 2025 :)

The last non-trivial change to this file was between the last version
posted in 2024 (v14) and the first version posted in 2025 (v15),
so 2024 doesn't sound that off to me.
You are not supposed to bump the copyright year when republishing
without any actual changes.  It is meant to be the work=E2=80=99s first yea=
r
of publication.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

