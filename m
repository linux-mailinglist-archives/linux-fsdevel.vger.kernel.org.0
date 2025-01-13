Return-Path: <linux-fsdevel+bounces-39050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E51A0BB0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 16:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40BB3AA440
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCEF1FBBDF;
	Mon, 13 Jan 2025 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPr7kCVm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7922DF97
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780228; cv=none; b=kMKFACUwiAhxFxXmV3wwRSGhNHzaARDPvfXMzy3FNrlMPQ8HZab00IiPUkYdgOaocyjSeZLxo+HsGwGc69TmLhNuL3j4WaIsLyPNVZRRLMzKmicRokMAxd7WBwpDnFlMjN4gbWVV8+RqoWAlu3BffWHWlIvz1a1oIn/R5kleUPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780228; c=relaxed/simple;
	bh=L0UIc+EzjQ6xcKWA5y6+TdB3wrHsUhNT6tBRgktol4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERVkNdgEgaYUvK5u0Ee2qe70hePJnAtlU7GbUk41WEm5uYCynvMyjT3lfsqS6dmkGSg2+UwKcx7uT9cIuIO6OG8nbwNn/tdv/Ph/N4MuDvnAycHzBKciSGCrDq2aPbODboqwx5brgF7GjmZOOU9VhVnHfrtNETacoFrBwVCTtoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPr7kCVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E4CC4CED6;
	Mon, 13 Jan 2025 14:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736780228;
	bh=L0UIc+EzjQ6xcKWA5y6+TdB3wrHsUhNT6tBRgktol4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPr7kCVmdQeVc2wDaCSEN2149Kst+Rp/lPkSXrr/UZ47q8dkZByi6j7d4TmKnxd3X
	 AfTP7iaL5EYjis+duWXtJbH7vVz36/Kv3onGrG8YbCp7SEsA49HMkzshleHd1Rhvnn
	 eiajoZ4jbfDeG7tsBFCPYTUZ2JzKvgFwULh2gBB7sj2wGPoGJBsT6tOVCBNGCoZxhs
	 clDguIfem6qlvtW5191mFLQZmSMgvH8NOSPlNzy2QB217taHapSOHO9qgd16emri6Z
	 IP5S10lDbmGTgfhbBv6WXJ7J/58+l3Bam0wW3JLesOfbKKDW6JcPDNw6xWp0VWPZRS
	 fkHd+xFjIPonA==
Date: Mon, 13 Jan 2025 15:57:04 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 06/21] debugfs: take debugfs_short_fops definition out
 of ifdef
Message-ID: <20250113-datum-kleben-c4db6f41df29@brauner>
References: <20250112080545.GX1977892@ZenIV>
 <20250112080705.141166-1-viro@zeniv.linux.org.uk>
 <20250112080705.141166-6-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250112080705.141166-6-viro@zeniv.linux.org.uk>

On Sun, Jan 12, 2025 at 08:06:50AM +0000, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

