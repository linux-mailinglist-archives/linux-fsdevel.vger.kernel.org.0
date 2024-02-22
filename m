Return-Path: <linux-fsdevel+bounces-12453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE3085F815
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 13:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC92D28B8CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61062612E1;
	Thu, 22 Feb 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="EUAlNGrf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420960879;
	Thu, 22 Feb 2024 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604659; cv=none; b=ePxy7uIi7iQ7cKyMmGQWM+24c96c9ThS1XvFG1/6J0HKVUbl4BbSiVNiIILHhWcidGIsL6IH0q+fxKAldb+oJsuBwsYLYPEzsUt34Fg+bTNQwj1xmRk4N6k3duHVkVoO1sKaW20HbVz1WD+DwJDGE7rb3RyyBp0779PnHrXYvvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604659; c=relaxed/simple;
	bh=SzkRLezEcoWqN5XMk5IQjv+zaBzCE6hGL4TlzpzvRx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jqq4cIuBMIuT1LY29CoWzB3VSng2OipdaLLoCvlXV8qIzVgBNRA2k5Lgof1pOLUBq76zDChdPRGjhccMqpSs9+oR2ddBlDgRRDYkBadcrUKBX4GX62+JfzcS0sLS69GVzlW7niJSEdXI0tB4zbCa0ugK/s73jZOLCJYZwcwAs6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=EUAlNGrf; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 49C831B3C16;
	Thu, 22 Feb 2024 13:24:12 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1708604653; bh=SzkRLezEcoWqN5XMk5IQjv+zaBzCE6hGL4TlzpzvRx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EUAlNGrf23R8w4oEXhdN8ZTdwZg1H7M4/emZPySrk6K9Tl0SxhgdNcc+GVXJzkF3K
	 jhjEkvp7rH7EDvKJP8N1WoE10a3c92Pf6/xWI/KNQXgf4YwqDhpDsD2Sz7vm2z7Lxu
	 QrFdVlvJFDd25mDM+o2lNSY2HQW6+zwnWeoZrkjI/dzsAj1ADwvpfvp+aYsPDhk7+s
	 +uJNHsQG4WSVKSkZg/cEwEkmeqqHv63GsosLISth1I21E6qnsVSxAZUr46A8h1ti5w
	 8xB2a1phVtvV+YvhVd8sMVHnIsWVImqVlHlq4wr1kEZ6CyLBGnCxeEbIFEyPI2fo5P
	 PuGFeTj8+894w==
Date: Thu, 22 Feb 2024 13:24:10 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com,
 penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
 rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
 yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
 hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
 ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org,
 ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
Subject: Re: [PATCH v4 06/36] mm: enumerate all gfp flags
Message-ID: <20240222132410.6e1a2599@meshulam.tesarici.cz>
In-Reply-To: <Zdc6LUWnPOBRmtZH@tiehlicka>
References: <20240221194052.927623-1-surenb@google.com>
	<20240221194052.927623-7-surenb@google.com>
	<Zdc6LUWnPOBRmtZH@tiehlicka>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Feb 2024 13:12:29 +0100
Michal Hocko <mhocko@suse.com> wrote:

> On Wed 21-02-24 11:40:19, Suren Baghdasaryan wrote:
> > Introduce GFP bits enumeration to let compiler track the number of used
> > bits (which depends on the config options) instead of hardcoding them.
> > That simplifies __GFP_BITS_SHIFT calculation.
> >=20
> > Suggested-by: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org> =20
>=20
> I thought I have responded to this patch but obviously not the case.
> I like this change. Makes sense even without the rest of the series.
> Acked-by: Michal Hocko <mhocko@suse.com>

Thank you, Michal. I also hope it can be merged without waiting for the
rest of the series.

Petr T

