Return-Path: <linux-fsdevel+bounces-20484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7888D3F48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 22:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4491C23810
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 20:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A061C6896;
	Wed, 29 May 2024 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ow0UF7WK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178C51C2331;
	Wed, 29 May 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717012968; cv=none; b=PsGCpHwYXOte8iX5v5vg0Zxb4s5QuQ23kljN/wvfppFReGYCylNhT6MRNctuQJ9LMYrj/yn2m/874mjEOGgne5JX1ifeaR5Y/t5usYjFydTQO/L1DmwMgxCq2zgta2+KWabLmWd6MInXPgpTKLCxoalvzo873Qom1RaQPRABKcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717012968; c=relaxed/simple;
	bh=Y/ESTVVAkjsvmXaBdtby+Vc8As3H/qHnNZC8K6XqLsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQ7CkfNUgmCEjxsLXocJis6qx4hduxTwAKORCCw7x2agp8brVDkd+KSEj3rygQS1rcRa30+RR+UyfW3TzPZPdAjyZPDiFf8IZKWE4K43yHXBd4Ouus3iQu1KuObz8y8bDUevfgxvinrfZvfvqJtizY1Tqg5WpGCd65divKwgDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ow0UF7WK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712B2C113CC;
	Wed, 29 May 2024 20:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717012967;
	bh=Y/ESTVVAkjsvmXaBdtby+Vc8As3H/qHnNZC8K6XqLsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ow0UF7WK4apR7AobaMK1aEi/PLo42imdWF/MIv2+GtRMN3MhZqFtBQdf66X0QE9u4
	 lhy2W3jwiLmp+AartzW5UmN97ZX2YkSHaBeT5jC8eRzyGiKdzG1lS+p3TWwyG7trzv
	 nw3B6oEYvhm0nsoE8EdDTHtWzkz1FPaVOzulKL/0=
Date: Wed, 29 May 2024 16:02:46 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, viro@zeniv.linux.org.uk, 
	jack@suse.cz, kent.overstreet@linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, adilger@dilger.ca, ebiggers@kernel.org
Subject: Re: [PATCH] statx: Update offset commentary for struct statx
Message-ID: <20240529-meaty-bulky-kagu-e0a422@lemur>
References: <20240529081725.3769290-1-john.g.garry@oracle.com>
 <20240529-ballkontakt-vergibt-b7f8c960eed5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240529-ballkontakt-vergibt-b7f8c960eed5@brauner>

On Wed, May 29, 2024 at 10:42:48AM GMT, Christian Brauner wrote:
> But note that your patch format seems to have tripped b4. I had to apply
> it manually.

Looks like it was some mail relay that QP-encoded DKIM headers.
I've committed a fix for it.

Cheers,
-K

