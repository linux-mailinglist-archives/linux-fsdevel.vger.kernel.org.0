Return-Path: <linux-fsdevel+bounces-16408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA7589D193
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 06:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7881F22D3F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 04:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246F647F57;
	Tue,  9 Apr 2024 04:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHfYXpYb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798682B2DD;
	Tue,  9 Apr 2024 04:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712637770; cv=none; b=FesxdQH8dQ7tVBD6+2elGi5UHuNLJKBh6hrF+S5AkAd3UbViYY2Vew+e9gZModgHtdcHfY6tRgIcTj88vH2mn0g5GsWd/Q2Gh3zbWhSSAEffxPT+xIv84Fr/eQddTKsIbHS0L8fFq65LvjNp+BGfkZtNb2I2Esz935k9VvSp8eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712637770; c=relaxed/simple;
	bh=JFbZNk8mb02YpBM/O5nMtUS4h1aYnwPEPANCirIIKZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBDoTM+cZBkbqvS9z5ZfWFl0ofPhn6F++t223OZECNaEGJfzGixrmJWSywG2XYcLqFix0OXIin20j6dUJJPnu34rX2WUkbUEytZleNRZMhlFe+I4E2aANAuYNiPgt5REoglF+NP1sEEL37d32Rtk1vaKZbgou8oQlTIzKczqrtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHfYXpYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF5AC433F1;
	Tue,  9 Apr 2024 04:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712637770;
	bh=JFbZNk8mb02YpBM/O5nMtUS4h1aYnwPEPANCirIIKZI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EHfYXpYbHN1Va9DLKcXpYcgKWfWUIam//u4IpGno21wQXwA0he3rx9ByrTyq3hwty
	 1nIaJQnGGv885Ovo9rDLZNK2V6M1mfT2mr/0RwcZ52d64j5R3YKDoQTwJGKBankMZc
	 jEGI/9uVGSdlbW1t7deZ/FyEBOvr0CUDS9EOAFHhy/XuTGTFzkj3jbbbbeFtTA3+mP
	 m0amaUnwhEoNcnlNDF/B9GK8jwATOgISE0Fw7haRBvYPCc4Fj3IKE/KVYCl8VI0UYc
	 bwfGsDLfx1x9aFUa1YmSbPdz0N2gQClLvMBKF+gTmMiWLXl3iwQiswBtwMaeVrCLr+
	 9+0rpVV36ixeQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 91185CE12F2; Mon,  8 Apr 2024 21:42:49 -0700 (PDT)
Date: Mon, 8 Apr 2024 21:42:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 fs/proc/bootconfig 0/2] remove redundant comments from
 /proc/bootconfig
Message-ID: <b1ab4893-46cb-4611-80d8-e05f32305d61@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f036c5b0-20cc-40c1-85f9-69fa9edd0c95@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f036c5b0-20cc-40c1-85f9-69fa9edd0c95@paulmck-laptop>

Hello!

This series removes redundant comments from /proc/bootconfig:

1.	fs/proc: remove redundant comments from /proc/bootconfig,
	courtesy of Zhenhua Huang.

2.	fs/proc: Skip bootloader comment if no embedded kernel parameters,
	courtesy of Masami Hiramatsu.

						Thanx, Paul

------------------------------------------------------------------------

 b/fs/proc/bootconfig.c       |   12 ++++++------
 b/include/linux/bootconfig.h |    1 +
 b/init/main.c                |    5 +++++
 fs/proc/bootconfig.c         |    2 +-
 4 files changed, 13 insertions(+), 7 deletions(-)

