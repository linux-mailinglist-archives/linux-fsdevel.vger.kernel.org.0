Return-Path: <linux-fsdevel+bounces-42068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD47A3BF98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 14:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8B23A8309
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 13:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934551E47D6;
	Wed, 19 Feb 2025 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJKzK6yb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A61E284C;
	Wed, 19 Feb 2025 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970775; cv=none; b=khBafa6Yl5hvULniXkt1E1x2uu3uV+nhXVrVgThzaalxw6gMxAS9By04J4WqeRyCIJx6MNkpskTRK9kWzNkYkYWu4jEBemUEOLhGgIWYk9jYWSA/e6uFjunI9pcYpt/Asgce7yoJoSSAtHLLGA92+8oUTNkLdi/tCq6LnEyZ4xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970775; c=relaxed/simple;
	bh=EhxxxV7E0uO1esFIV4nz+bZFgvgKVk8fP60K9rcnwSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z36PGwa9Rxc/CRgO4h3UCWHlFxR88mcmnp3/maU84PvEwaIBAxURUtluxXnzwpTVML32CO4Znxv/aChkSS00MOOVWqXtOw0jPm27aSy/d6wVSB/3Wqu4GG4GCShy6B4XpZPIhoX/KN100i/dBbdKLxSdXhpmllatSndQC0QZqlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJKzK6yb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644D6C4CEE8;
	Wed, 19 Feb 2025 13:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739970774;
	bh=EhxxxV7E0uO1esFIV4nz+bZFgvgKVk8fP60K9rcnwSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJKzK6ybmownJAwsfjn04ISdbTfMVsDcalgphQ7pxJGdFub9y91cb1M4ZDic0xUh6
	 jGvJsY0PDyuxyAujLR80aN0LmeRqjZEMNk/3yMyXQ/oCVAB7sgHS2/UBfMw24CJ+qa
	 aStFgrl+P4H+wT4ChBncS468np/Y4jxvAb2MtA3WQq7fxbqymJNLMX8NL1v2WJej48
	 ix7whlcyXKp80qp9uTLYTrARrIVEwUm3V8zBgwYSd9y/WGepnC+eTw+vTC6nhstFEZ
	 cZHXS8oX2cPr0b0cPPTRtGPhd5NLpaN9tgFy9CJ00fqJSp4izrWQ1VTedW5Ff1DeKv
	 +AxT3bNuwT3qg==
Date: Wed, 19 Feb 2025 14:12:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Karel Zak <kzak@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.41-rc1
Message-ID: <20250219-gerudert-leibgericht-a4bc4353029d@brauner>
References: <yjic6yol5fmaftythlppbfoafsaqhaoh77spzp6m2izd757pcg@siegv7vwz6lf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <yjic6yol5fmaftythlppbfoafsaqhaoh77spzp6m2izd757pcg@siegv7vwz6lf>

On Tue, Feb 18, 2025 at 10:08:22PM +0100, Karel Zak wrote:
> 
> The util-linux release v2.41-rc1 is now available at
>  
>   http://www.kernel.org/pub/linux/utils/util-linux/v2.41/
>  
> Feedback and bug reports, as always, are welcomed.
>  
>   Karel
> 
> 
> 
> util-linux 2.41 Release Notes
> =============================

[...]

> 
> libmount:
>   - Added experimental support for statmount() and listmount() syscalls.
>   - This new functionality can be accessed using "findmnt --kernel=listmount".

Very nice! Thanks for working on this!

