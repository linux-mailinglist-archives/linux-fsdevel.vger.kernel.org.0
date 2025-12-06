Return-Path: <linux-fsdevel+bounces-70937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E95CDCAA44A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 11:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8255630A9CB2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 10:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB1B2F12DC;
	Sat,  6 Dec 2025 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEDOZiuX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5567628D83F
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Dec 2025 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765017876; cv=none; b=WuhOivLuQe/n0L/JKz4NZSkg4fWqfv5T1lQ/vRGoIv+/OgGElJFJhq2/KCCVX+I8C+nkQ0F5NYA+z+gK9XypR0i/iunOvW7M335pyuDHj5MpDRfxYezs0DR/rxFkeR2nddQfkbXbhUtNtbMG6RUycc88qAU0yUTai1LJXjZfyrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765017876; c=relaxed/simple;
	bh=AQ7g9IP4vTIPuOfOz0jpeYCgd3MtpaUhpjwjBRBVTmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yt4o9atzaV+1IRK0XKIlbJ5QcYsHRUd5lpNnxEh4wreMCTAdlbe58/0ATR6ajnFb10jVUB98L/sOSqLAXfVAvtmw/z8RF0vs3RAcbIOyvHiJdlfaL96w2tvCyPJJiu0AufH2sT3cPRMG+ahU9ONQfCOJn4W9KVeCkqrWxt9AxO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEDOZiuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0B1C116C6
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Dec 2025 10:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765017876;
	bh=AQ7g9IP4vTIPuOfOz0jpeYCgd3MtpaUhpjwjBRBVTmo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jEDOZiuXTwAPKDg13GDPbBQA4OS0mSAYoihGg8EFtGFqJ9xQgJoJaejCdfFK42BxF
	 tzW5IMpgEZd80+ehygY5vzKyBJQuks57SoTWO+9FEes6ICZeg5c2f5B9mVlc4ugHnG
	 TVxklBlwsMwmXTbfMQ4GY334SQQIOaSgUJcC8JoIBeUvsAtsp8aHUpNpRV981blSC3
	 Rk+9iu/e5NyKXO988meM/xl8gWdm/NhbMKVeb9d2tlnnYdRCOa9ikwgu2pAAAT1ees
	 YDxzBGwH/jhi+SRXGRvgsn45Xy6IFN4ybluoSL/fxugChfCODusrW/07GCLkN+9aBM
	 58gGbx42S+QSA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-647a44f6dcaso4002610a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Dec 2025 02:44:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXu50AgNqfF0OeqiDYmejq4KsMMrB+e2pEgnT+pYvKgv4txukKuuZ6EHWoLa3DqlEZgMo5g7BZ6OrnskRFa@vger.kernel.org
X-Gm-Message-State: AOJu0YzCDOoD8UgO+7fgDTFTPtvKahan+SCs3X9qioRky6xzy2xWPfrU
	Ff7GG53BO2AS08RyfAvIpdHIe1M/nohCbFF5FsY6/gRa1zR99tRa/RRJTArp5qIizchKCaNAb6n
	dAh8c/70gVoIN6io6x1MWdvTMcH/NdSM=
X-Google-Smtp-Source: AGHT+IGhlKujR4fHAFEKiM/19ac4Lj5PT9RPa4L9tAsinDUJybbHemSEtnvMmGAaRLQ9STTuGyYxSv+/UgOn2oC32Ts=
X-Received: by 2002:a05:6402:2813:b0:645:cd33:7db5 with SMTP id
 4fb4d7f45d1cf-6491a819f4emr1412092a12.24.1765017874647; Sat, 06 Dec 2025
 02:44:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203070813.1448-1-vulab@iscas.ac.cn> <20251205015904.1186-1-vulab@iscas.ac.cn>
In-Reply-To: <20251205015904.1186-1-vulab@iscas.ac.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 6 Dec 2025 19:44:22 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8rZ0_fjBK0tRLSrEqsY40r7hba3QVvJzNaLkexHfcWhQ@mail.gmail.com>
X-Gm-Features: AQt7F2ptv_V7OVvoV7f5mLyfMHntYtxlWMAkEZUTN-GA5NMZgykOeomlTWzwKbU
Message-ID: <CAKYAXd8rZ0_fjBK0tRLSrEqsY40r7hba3QVvJzNaLkexHfcWhQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs: exfat: improve error code handling in exfat_find_empty_entry()
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 10:59=E2=80=AFAM Haotian Zhang <vulab@iscas.ac.cn> w=
rote:
>
> Change the type of 'ret' from unsigned int to int in
> exfat_find_empty_entry(). Although the implicit type conversion
> (int -> unsigned int -> int) does not cause actual bugs in
> practice, using int directly is more appropriate for storing
> error codes returned by exfat_alloc_cluster().
>
> This improves code clarity and consistency with standard error
> handling practices.
>
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
Applied it to #dev.
Thanks!

