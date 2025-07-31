Return-Path: <linux-fsdevel+bounces-56371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 601BDB16D85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 10:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BD218C61A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 08:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BE328D8D8;
	Thu, 31 Jul 2025 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGtPRPV1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29BBA94A;
	Thu, 31 Jul 2025 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753950575; cv=none; b=Ek03Qo0emHPKiFFyusIyzrF/tRtW1c8iLgJp8058m93cNb8omYV03sQpOMX0k2N7mTTQ7JtDVRdY/lGq+DUse1cdW5UYUhYc6hw5eOtbhuwece7HtnIkois741MYOQ4WyP7buGf9vgXPTcBJ1zeVoFuYSkdDiatE+Y7gaA9PpaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753950575; c=relaxed/simple;
	bh=wbyB/6uqV02O6yvORkZE8rBafqgsS7EHu1mnTGg9dPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMNrz63gK1j9WGBOJiMXwujI2+FBF+jnUXJlunlzE1c/3c/y5D2qrSx9aOTE4ajIZQNs8vCqsy+cbAMRTRh0g+RqV5vnmuB3Rqd6Apdsl2X01/BrEKc7xcYwFogcGHNHd2V2BOgBGFttUgWyzv9qsZrDxp4OdDA0t57qTQ+5vrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGtPRPV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7546C4CEF9;
	Thu, 31 Jul 2025 08:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753950575;
	bh=wbyB/6uqV02O6yvORkZE8rBafqgsS7EHu1mnTGg9dPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGtPRPV1Wkiw184K2GIcUgHqknmuUFkkvWoU8hKCX7kzYjWG5QZa1+De1JyAelBny
	 ZC3udalJ/M5JmO3waGRM/r1XX4kLwG9ysrwmrU3HE61SwO6rQMwe8X0lSrgzSunAq2
	 9YXBRzP1bF4oR5KfbhH5jlNTsNtdGBXMx7oX9feE/+TvZC3fIo52DjuTWzYBMaNnFS
	 MAl/9ZdAC5aE6J4hMtt5hATWoY66um0ka5arJbWnHfAlo6eEhjLp2/i/61nQjqsZ1i
	 h+0NiUTE0zVEP4z5uBF01KOSL+Fye3RD/asG1gEsajZ3p3887KK+jfWG3HsOijm7c+
	 myuz/9fQHqmHA==
Date: Thu, 31 Jul 2025 10:29:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 14/14 for v6.17] vfs iomap
Message-ID: <20250731-unakzeptabel-anfragen-7ccdab9911ea@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
 <20250725-vfs-iomap-e5f67758f577@brauner>
 <aIYlKgQZNF7-LgIp@lappy>
 <CAJnrk1Z3mPjbBnYRgAgAe9t9R6uNWSo8smD4S2gTZg3NonaJfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJnrk1Z3mPjbBnYRgAgAe9t9R6uNWSo8smD4S2gTZg3NonaJfw@mail.gmail.com>

> This was reported last week as well in [1]. The fix for this is in
> https://lore.kernel.org/linux-fsdevel/20250723230850.2395561-1-joannelkoong@gmail.com/

Thanks Joanne!

