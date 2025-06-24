Return-Path: <linux-fsdevel+bounces-52716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 700C3AE5FFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E6F1922751
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4112797AA;
	Tue, 24 Jun 2025 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjtYQUcc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC0253950;
	Tue, 24 Jun 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750755279; cv=none; b=XRPR5hw5VFBRQXcr7WKLbstbrk1OwrA702KpINYQ2MXo4wLO6VF76BJzgnzFpUvMLERInjasgOtbAK5+DzNX2k+/5iadCpRkk1X3QPB+0vo49RfxK993XojPUEjMS6zstqRW4vnuMRwAAXDimJelgxdDUM6YNR5ML0ayv0+Dwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750755279; c=relaxed/simple;
	bh=Tw5L0Y1w0eip6mUVkK2HT5/KDLxY0+uzOBK1dmVDiD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNAiJKCUnjZLsuVQ3e1U+2SRjmepytOMFq9vM3Y9b4xTbrjJmr0GcMHK/DzBPOVsuDNotsZbxk7f78VL8+5I0OWZNbJsLKW5hmHGMPSvfN9mr4iyUpZc4vZLAf6R68b30fWyZAannVlKM9cbMPqwbakwoYfhYahXfTpPQdPvB9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjtYQUcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D02EC4CEE3;
	Tue, 24 Jun 2025 08:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750755278;
	bh=Tw5L0Y1w0eip6mUVkK2HT5/KDLxY0+uzOBK1dmVDiD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IjtYQUccuy67bxfo4Y1SLWqLxzse9kT8EqCIF8Sa1RskHRZ+Ve8RUSr5NbdJOwncr
	 TEWgX5BEYLo6t2NUbOBNQpydZjHSOc01HmLK0gE1BBhIcycLmdJlFqsA9/repMzIIq
	 P+ArXTpmEGCW/26jHv0sdBDNjHw5JGQg0p3o5tiMPc8kah0T4PF49+X1kjnwV+VH+m
	 +cfqkYsApLDQRY7+G//0CxKCTmKYziYXgEvJ2V46ZwQesAFzI16VO0K2SS3uKIzTZ9
	 X4rCymTEAPqyE1AQF935UKCM1dxPb8IoFwiZDI361EGjtkURXqIwUxSpyF61eLQCSq
	 +h0axsXpzmhXw==
Date: Tue, 24 Jun 2025 10:54:32 +0200
From: Christian Brauner <brauner@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next-20250623: arm64 devices kernel panic Internal error Oops at
 pidfs_free_pid (fs/pidfs.c:162)
Message-ID: <20250624-elastisch-errichten-a2aec974177e@brauner>
References: <CA+G9fYt0MfXMEKqHKHrdfqg3Q5NgQsuG1f+cXRt83d7AscX5Fw@mail.gmail.com>
 <20250623-salat-kilowatt-3368c5e29631@brauner>
 <CA+G9fYsfOg9uiwgYA1mHkBzwEkU6eLweneWJhFybt+X1Ekp55Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+G9fYsfOg9uiwgYA1mHkBzwEkU6eLweneWJhFybt+X1Ekp55Q@mail.gmail.com>

On Mon, Jun 23, 2025 at 08:26:32PM +0530, Naresh Kamboju wrote:
> On Mon, 23 Jun 2025 at 18:26, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Mon, Jun 23, 2025 at 05:29:38PM +0530, Naresh Kamboju wrote:
> > > Regressions on arm64 devices and qemu-arm64 while running LTP controllers
> > > and selftests cgroup test cases the following kernel Panic Internal error oops
> > > found on the Linux next-20250623 tag.
> > >
> > > Regressions found on arm64 device
> > >   - Kernel Panic Internal oops @ LTP controllers
> > >   - Kernel Panic Internal oops @ selftest cgroups
> > >
> > > Test environments:
> > >  - Dragonboard-410c
> > >  - e850-96
> > >  - FVP
> > >  - Juno-r2
> > >  - rk3399-rock-pi-4b
> > >  - qemu-arm64
> > >
> > > Regression Analysis:
> > >  - New regression? Yes
> > >  - Reproducibility? Yes
> > >
> > > Boot regression: arm64 devices kernel panic Internal error Oops at
> > > pidfs_free_pid (fs/pidfs.c:162)
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > ## Test log
> > > [   67.087303] Internal error: Oops: 0000000096000004 [#1]  SMP
> > > [   67.094021] Modules linked in: snd_soc_hdmi_codec venus_enc
> > > venus_dec videobuf2_dma_contig pm8916_wdt qcom_wcnss_pil
> > > coresight_cpu_debug coresight_tmc coresight_replicator qcom_camss
> > > coresight_stm snd_soc_lpass_apq8016 msm qrtr coresight_funnel
> > > snd_soc_msm8916_digital snd_soc_lpass_cpu coresight_tpiu
> > > snd_soc_msm8916_analog videobuf2_dma_sg stm_core coresight_cti
> > > snd_soc_lpass_platform snd_soc_apq8016_sbc venus_core
> > > snd_soc_qcom_common qcom_q6v5_mss v4l2_fwnode coresight snd_soc_core
> > > qcom_pil_info v4l2_async snd_compress llcc_qcom snd_pcm_dmaengine
> > > ocmem qcom_q6v5 v4l2_mem2mem videobuf2_memops snd_pcm qcom_sysmon
> > > drm_exec adv7511 snd_timer videobuf2_v4l2 gpu_sched qcom_common snd
> > > videodev drm_dp_aux_bus qcom_glink_smem soundcore qcom_spmi_vadc
> > > mdt_loader drm_display_helper qnoc_msm8916 qmi_helpers
> > > videobuf2_common qcom_vadc_common qcom_spmi_temp_alarm rtc_pm8xxx
> > > qcom_pon qcom_stats mc cec drm_client_lib qcom_rng rpmsg_ctrl
> > > display_connector rpmsg_char phy_qcom_usb_hs socinfo drm_kms_helper
> > > rmtfs_mem ramoops
> > > [   67.094437]  reed_solomon fuse drm backlight ip_tables x_tables
> > > [   67.189084] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted
> > > 6.16.0-rc3-next-20250623 #1 PREEMPT
> > > [   67.194810] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > > [   67.234078] pc : pidfs_free_pid (fs/pidfs.c:162)
> >
> > Thanks, I see the issue. I'm pushing out a fix. Please let me know if
> > that reproduces in the next few days.
> 
> Thanks. Please share the proposed fix patches.
> I would like to build and test in LKFT test framework.

It's in vfs-6.17.pidfs. Syzbot has a reproducer for the bug.

