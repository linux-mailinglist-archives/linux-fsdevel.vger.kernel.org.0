Return-Path: <linux-fsdevel+bounces-40650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132A9A263B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 20:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FAD3A5361
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 19:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A15C20E01B;
	Mon,  3 Feb 2025 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="tgQKtGRi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB62D20CCEB
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 19:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610555; cv=none; b=V1rKMy/6I2+1AqAdDFJkEnIWUIIECNOraliHWLo6B2anIMYZvPzf2KzkYurhhYpVhm8kyTNZMxAH5hv4ilm18CW51MX2GPJZiE0w9TF0UvhX0TpgU5sFTL8HllrGqfCDEc0Oq9SNov9r8aVSke9GJXX1fULKBoBlXMapHemgDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610555; c=relaxed/simple;
	bh=JL7t1NcN589qKokREOPuuyfYDvMpCgpk8JZk4sRr4a4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qH79YMtfOjiZXIZNQWNthPEbkJUdQvx1abJNhjZs0OrMbugZEHC5PiqC638go98fm1lKgWt1uEZAtgmU0ru5h8fCzAoXLwQVEkvwXcooY7lqM6pN7t0AIZbn8junL46KiH6evjkurM39de8DoznXdZ54r2YD0LZ8HkHWnB7AIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=tgQKtGRi; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 07813827D6;
	Mon,  3 Feb 2025 14:14:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1738610088; bh=JL7t1NcN589qKokREOPuuyfYDvMpCgpk8JZk4sRr4a4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tgQKtGRiX2wJAdSL0kFZH+gguvSj782s0DujXgwz3c5twIg90YGIsmzApYxJoUdUi
	 txqSNzUEPVlrHrjRZJJBkjmFCqZPoBMo62Qv0fpA1rwJywamXLTBYO5Fs0sMOo1TwT
	 JPHznEHz6gzemvlucDvNsMSRcb3oeZtHeHMoW+8ZaN0O5ofBKsGQQKNhTo1pLPfhBT
	 LyOT53mwLyUnsUluVKqZDGGWCpLyYCyMxY34VP4dRjK2meLpJLFBkCcAq1S46nm8vm
	 j/OnuOfbMlR5YbOiq0GzcAW3iuw/GiofI/5eGBelcVt+loJjv/zb0vmP6gn7FnLdKL
	 dCVcf0l860W8Q==
Message-ID: <757e596a-ce3e-48b4-a45a-5bda7f0f3d74@dorminy.me>
Date: Mon, 3 Feb 2025 14:14:47 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF TOPIC] Long Duration Stress Testing Filesystems
To: Boris Burkov <boris@bur.io>, lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, Matthew Sakai <msakai@redhat.com>,
 dm-devel@redhat.com
References: <20250203185519.GA2888598@zen.localdomain>
Content-Language: en-US
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20250203185519.GA2888598@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> I attempted to study the prior art on this and so far have found:
> - fsstress/fsx and the attendant tests in fstests/. There are ~150-200
>    tests using fsstress and fsx in fstests/. Most of them are xfs and
>    btrfs tests following the aforementioned pattern of racing fsstress
>    with some scary operations. Most of them tend to run for 30s, though
>    some are longer (and of course subject to TIME_FACTOR configuration)
> - Similar duration error injection tests in fstests (e.g. generic/475)
> - The NFSv4 Test Project
>    https://www.kernel.org/doc/ols/2006/ols2006v2-pages-275-294.pdf
>    A choice quote regarding stress testing:
>    "One year after we started using FSSTRESS (in April 2005) Linux NFSv4
>    was able to sustain the concurrent load of 10 processes during 24
>    hours, without any problem. Three months later, NFSv4 reached 72 hours
>    of stress under FSSTRESS, without any bugs. From this date, NFSv4
>    filesystem tree manipulation is considered to be stable."
> 
> 
> I would like to discuss:
> - Am I missing other strategies people are employing? Apologies if there
>    are obvious ones, but I tried to hunt around for a few days :)
> - What is the universe of interesting stressors (e.g., reflink, scrub,
>    online repair, balance, etc.)
It's not a filesystem, but the dm-vdo project has some similarities, 
doing deduplication, compression, and thin provisioning. As such, they 
have a fairly extensive set of tests of dm-vdo, and in particular they 
do a fair bit of stress testing.

For them, the universe is reboots, crashes, complete rebuilds, read-only 
entry and exit, compression enable/disable, and 512 byte sector mode 
enable/disable. They've been running about fifty hours a week of these 
tests inside of Red Hat. For instance, 
https://github.com/dm-vdo/vdo-devel/blob/main/src/perl/vdotest/VDOTest/RebuildStress03.pm 
is one of the tests showing the random selection of operations.

When these tests were first introduced eight years ago, they did catch 
some crash or data corruption bugs which were not covered by the 
existing universe of fstests-like tests for dm-vdo. There was also a 
filesystem inconsistency uncovered at the time: 
https://lore.kernel.org/all/CALoZfD4-uqhRSfEh0Y+v8jjSDY2KkAh-hhwdLnRgZopHEETUXA@mail.gmail.com/

I would suggest Matt Sakai, cc'd, or another of the VDO folks as a 
valuable contributor to this discussion, given the VDO folks' long 
experience with stress testing.

Sweet Tea

