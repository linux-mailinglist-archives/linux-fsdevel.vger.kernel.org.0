Return-Path: <linux-fsdevel+bounces-46564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5DBA905DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 16:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1AB189CB22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 14:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1401F4165;
	Wed, 16 Apr 2025 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObejyvKg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0409B1C3C14;
	Wed, 16 Apr 2025 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812381; cv=none; b=b8JXXhCBBehHAJkY/otfl+3q1bnhC4vImA7HmU6Y7LdeEZkZR18RBpOacquHwlxLI3z0Pua21jJBiF5MxbHp3gzpykGrAaaAdX6kk38j8GtVmnnBZscE7274xwGvMeTCis3VsnZFoTwGIo2Gk8gLhbTCD/3WTmbzwsamNL0IWzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812381; c=relaxed/simple;
	bh=L1vQBJZ0pEuBomI2Rjg1mYSVRoUCuxnpc3yOTBbiKVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYeo0BoqYWw/fEgxMaoG5izlZLjXd2LdDlZJY+YtMuaw57T6v9G7coUy2nq41Q3By3pOLm3BXc7/+obGxbI5R3WWdHZFUtSn6CHUxB77qrt0OcgadvadupZZnMgyR37QomdxDchXEQD2QAD1OOOeo6Y/MIYJfml7JXDeZVQR5yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObejyvKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D19BC4CEE2;
	Wed, 16 Apr 2025 14:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744812380;
	bh=L1vQBJZ0pEuBomI2Rjg1mYSVRoUCuxnpc3yOTBbiKVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ObejyvKg12cMcI1czwl1rRMRHrEGhl3F8y3L+tIxfbhu/zv2dZWEQRY3TLIBeIya0
	 rgDUUWWzndrOk66nzTsJcgTPUvRYYyE6wuZHdY9JWWNfmge/TU4q0f5l9Wwxd5nJ1G
	 BdOXQG8+FPSzQ1PJMH69MXrKzef7oRp7KBgy/CYCGG3MP18/y/AlBODruRC7EAJg5B
	 NNDHLxIRxY7QME7+ue9I/pqb2yJHaONl+uHyPwFWTUKBScJ5XbSa2q2yizziCkWrwx
	 zwUsIZp2SKTtt7kxPug9gsty0lve2dVd9jVQQxu4L+XngSHSI2n5riYfdxWhm3dwqT
	 bxMcUI2TCqFRg==
Date: Wed, 16 Apr 2025 16:06:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: remove uselib() system call
Message-ID: <20250416-abfinden-poeten-c1d0e0307dbd@brauner>
References: <20250415-kanufahren-besten-02ac00e6becd@brauner>
 <202504150916.5E6B4CD82@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202504150916.5E6B4CD82@keescook>

On Tue, Apr 15, 2025 at 09:39:53AM -0700, Kees Cook wrote:
> On Tue, Apr 15, 2025 at 10:27:50AM +0200, Christian Brauner wrote:
> > This system call has been deprecated for quite a while now.
> > Let's try and remove it from the kernel completely.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Yes please. Though I see Debian still has this enabled for alpha and
> m68k:
> https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/config/alpha/config#L779
> https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/config/m68k/config#L684

Let's just try it. If we fail we'll try again next year. Keeping the
pressure up. :) The reverts should all be fairly simple and I'll keep
the burden for Linus low by doing them myself if we have to.

