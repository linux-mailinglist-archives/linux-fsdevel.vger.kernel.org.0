Return-Path: <linux-fsdevel+bounces-14209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF5F8795AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 15:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2471F213FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF1B7A73F;
	Tue, 12 Mar 2024 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDPhDzwz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BF77A72F;
	Tue, 12 Mar 2024 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252568; cv=none; b=eRgOYCgG6aVOBDSkMb7751LERHW7fb5JglBUV2xBmJurSIXFN9hNqmTVpEkGrdKOg1mC9vlU/iUUNaVTqK5qLamq5koW2tzavwGVrdlOWaCNv9aAH0TKGMOubNCkyBEJzYXoGRAVzCi7IZw/k38sMzC/X+xyCFem6TG9p/lgnwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252568; c=relaxed/simple;
	bh=OHs6gIp06vpbC5HdsLdDt0/n/SfwHjJGPz0I98zSqfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNFcLXevuEu0FBGjX9tkVaeHFkDz5E7lXliJYv4st6wHJoxgBZt3fijV1+rI478f7CVVXgakDCkV6XCJZki2ht9p0gX+RKJB4xoGRV98CEgFQrYT2bYWycmEfLJFkFaA7gBuxYAgHdVsuXUAMrYKotFrRVBVbwbIrJdp8osy0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDPhDzwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03886C433F1;
	Tue, 12 Mar 2024 14:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710252568;
	bh=OHs6gIp06vpbC5HdsLdDt0/n/SfwHjJGPz0I98zSqfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SDPhDzwzLqpuGijqDS+OzUrakyRVTlV1DR+spBDFh//uvaNDw4JC9VkrVVAbDkq3d
	 S53lr4jBcpaLd04yul/H5zKEMrAfsy0dY1vPYMXluXzxbHFH4YYg+Srz/w1H6M8SPe
	 RHkzEMq1FXDffGOuklgN/QnvkO9mdWHNEnjoWPAKWl7OBrWw2on5uXOnwDzDr/+dA1
	 0WV4mTZJzWPk/IGLBnA5xqQevzs2wf3zMpCk/MySOti4UC0ndNQAzUZNCu5HPvd48f
	 1tYrsP91FWoL3iQv3hukk3F3h9Zixx5lv1m5cH2ubbDzyH+VLBr9ZXazJE1woVvBoD
	 Oy8lQU/9ly9dg==
Date: Tue, 12 Mar 2024 15:09:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240312-akzeptabel-ablegen-d82c1e8f4e23@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <71bc82f4-b2df-c813-3aba-107d95c67d33@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71bc82f4-b2df-c813-3aba-107d95c67d33@linux-m68k.org>

> What is the risk this will not stay entirely optional?  I.e. can it
> become a requirement for modern userspace, and thus be used as a stick
> to kill support for 32-bit architectures?

Yeah, Linus has requested to remove the config option.
I'm about to send him a patch.

