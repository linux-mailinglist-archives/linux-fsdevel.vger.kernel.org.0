Return-Path: <linux-fsdevel+bounces-56377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 184FAB16ECD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 11:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FEC318C6A8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 09:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B516829E0EC;
	Thu, 31 Jul 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4g1iD7N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F79427CCE2;
	Thu, 31 Jul 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954816; cv=none; b=GEHISpzprNSsC223q0jtsI0M6f6SiZZ1ASlD1ArC5OxgWqzjU8jSdPUPQagewp9wMjilP43uYpwZoPgJvrn4aXrVFNvxS/+EPbg0rDUg2BEH3Nc3Hqpjen/8bEWSeTMQDVYVj1Dcx4FWcLC1KmQ7SF2FS1nPVvbMfrdHndrFhAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954816; c=relaxed/simple;
	bh=/v4W+ecBJEKcoK16F3xL7ibkkRyri3KAZESkCFC+vpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YD9ZjEcHdtcpSSmhw3JsDOob80o52lShX2snr+XdKx9I//mdydT1Xe5O9wvuGm3DfAvkx4sPsBeKGmPO3yNK/g5ctUI5a+i/koWZEl2Z8MOkqgko6dpSq7nrbhVClxJrJUy4nxY0rg+WsjeM274cdbxgbAlWveQgKv1GA4FkBc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4g1iD7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D113CC4CEEF;
	Thu, 31 Jul 2025 09:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753954815;
	bh=/v4W+ecBJEKcoK16F3xL7ibkkRyri3KAZESkCFC+vpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4g1iD7NO7JAppxw0XxuCQnUXtdsv/XvQ79mFzAAL8cEZXR+acbyrEJnJhsfD63jP
	 qqRwpJcIh/Yp231HcBNVPXLGIoMZiZyraKH0+SnD48BUX57Tgt3A2WSrlRyfoVSUk8
	 xzZrKHcL2+3sZxDMZ/KgQnucuqug5kMDAKhF3cGPPEk7NAO6BRAvQlomjsjeSS4irR
	 lQSoIMBE98VPJDeCyU7pLB0XMXQRDM6/l6XOKvKZJlKdtP8ohvK4k01QmKYncRGcoh
	 aX+9r6Q4KgOp+f3KhNvaMIba7kysp00dQdk9M0xGam/Vn3G5V73HXadLEZvUEJ0gQF
	 sbmH1Bz/pKMYQ==
Date: Thu, 31 Jul 2025 11:40:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 00/14 for v6.17] vfs 6.17
Message-ID: <20250731-vorschau-erziehen-82e6753df3af@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725-vfs-617-1bcbd4ae2ea6@brauner>

> Lucky for me the v6.17 merge window coincides with me moving. IOW, I'm
> currently getting squashed by moving boxes and disassembled furniture.

Fyi, the move is now mostly over. We're not really done yet setting
everything up and so on but I managed to get back behind a computer for
once. So I'm slowly trying to catch up with everything.

