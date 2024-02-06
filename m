Return-Path: <linux-fsdevel+bounces-10499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA9684BAC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 17:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC83F1C239F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 16:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966B81350C5;
	Tue,  6 Feb 2024 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAZh3RV4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB381E49B;
	Tue,  6 Feb 2024 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236562; cv=none; b=A0a5qXxFqUuL1Q+4vPlj/+oX43lBNhEWmRyvVijoj+8vAkC8rJ/beBN/uXbj95nbOY47dTtKVRTqynpAgn5BDOZLTFGOge8Grx9iGXVEDPTmrJk8+46eUXx58xEjvSF4ukhZfssgcCdzxN/3DQhkupAVqbu8wSUYm5U9ZrWOWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236562; c=relaxed/simple;
	bh=9CPWKpsQYkI3BqJRpaVlLK8ZC0X64MdLzyKCF7APEVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2f6JLFlNWtRkvtUf+PdGxI5wOhXLaTkUK/adnB7awxzin568ynk5Lq3lNOgrEgkDzJXJMzxbJBXD0TN2Dljr7Y/qlRzPlimTUFwwuNoV2GNvv7cBpkjA5W6sFRyYURj3XNcOInEWiObT9VXmpqBAvk157hkoOtLw03GVftaNX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAZh3RV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A20C433C7;
	Tue,  6 Feb 2024 16:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707236561;
	bh=9CPWKpsQYkI3BqJRpaVlLK8ZC0X64MdLzyKCF7APEVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oAZh3RV4A3dRMoUBvHujL1RRdxTuJ+l92+NuYuNT7GwO4J89xoZoJsJVq5jZp/gvR
	 Lj13jxd5GmPmn5dGIn920C97f9XEKaGgVOhkMEklD/I+2y8/HKg5sgL7veiooFk2gZ
	 H8HlnZJdxb56K0vQCda9dMRcRQwYPOBzdsBDNfhkeWWjwSRzzFFf8YU6dBirT4Gq2a
	 CbU7chUZXwWFj0M4uyiRaFkENxCmG0a5p/yQDSeIIYOESg4P3LzIbgyiriVsvIDwMD
	 77USiQ1IZaVfzfJpUs+IQ0+BpMuCND8a8vWThW5AYBL6paMB0ZFPuThM8o0Wro/Ujn
	 WtOW4LMz1e1Jg==
Date: Tue, 6 Feb 2024 17:22:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/6] filesystem visibility ioctls
Message-ID: <20240206-aufwuchs-atomkraftgegner-dc53ce1e435f@brauner>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240205200529.546646-1-kent.overstreet@linux.dev>

On Mon, Feb 05, 2024 at 03:05:11PM -0500, Kent Overstreet wrote:
> Hi all,
> 
> this patchset adds a few new ioctls to standardize a few interfaces we
> want
>  - get/set UUID

Last time I spoke in favor of exposing the UUID as a generic ioctl most
were supportive. But I remember that setting the UUID was a lot more
contentious. If that's changed though then great.

>  - get sysfs path
> 
> The get/set UUID ioctls are lifted versions of the ext4 ioctls with one
> difference, killing the flexible array member - we'll never have UUIDs
> more than 16 bytes, and getting rid of the flexible array member makes
> them easier to use.
> 
> FS_IOC_GETSYSFSNAME is new, but it addresses something that we've been
> doing in fs specific code for awhile - "given a path on a mounted
> filesystem, tell me where it lives in sysfs".
> 
> Cheers,
> Kent

When you send v2 could you please just put me in to. Makes it easier for
me to pick this series from the list. Thanks!

