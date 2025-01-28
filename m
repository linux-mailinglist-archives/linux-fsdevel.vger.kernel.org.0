Return-Path: <linux-fsdevel+bounces-40250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F43A21226
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 20:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30591888BEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 19:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE2F1DF96C;
	Tue, 28 Jan 2025 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvGXA/o+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4C41D61B1;
	Tue, 28 Jan 2025 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738092265; cv=none; b=u1M4F1ATvo8BoDVR6EUUaKRZjLNNYUJBvu0BwKvV4f4lC9hVDz17CEh5WAtkKoZ2nL1Of9h+YyCrngT6WTwXVsOEJBRC1GdJ93jkiL7nHwkyp2FNJOSjtg7GCPAdEiL8KmtKVrwv0SW2q+JCjC6/q4nR5SPOyD97j6yMy8Nkn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738092265; c=relaxed/simple;
	bh=y0e8x1RrwiaDgoutUxwmbHseLqlqD6w4O5CBu/olF9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SB9wwjtSzuG6bdLygPd5nQ1eS5V2aVWb1dldJJ14nJqccvNEy/sFjf7BM06HYyFQMWclAT7QDBwmpRl1PwEOLf1EOLPQawdcpWbtWBsZTtEmbgTaEPnEx5rIL8zL/1Q8uW5q0b7+HSDErjSK0ewyEVv6mBMPVN6dCTUnOGpMwiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvGXA/o+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F8BC4CED3;
	Tue, 28 Jan 2025 19:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738092264;
	bh=y0e8x1RrwiaDgoutUxwmbHseLqlqD6w4O5CBu/olF9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvGXA/o+Nkuya9wlftDilJkfCoxLRlj2t8Nkbj+N6H4xUA5A1WVgp2G+MP54VkWF0
	 yQ6WoEtI4vjzYo1c69OzMGD6S2r7lfepSNrSfj26Ns34OAiiH7WbA0U8OU7OOxxdTC
	 kweHJaqLyTWJ/OljM/m/bdKMGUTirmhsb8VlQjXcOP5dEnHSZm2XG3IJQ9mzx4OBXo
	 VcmoFdCInGotfKaMXS/ZQld8CV4YUdAMLoicQkkvBnbZ5VuqwDM89rcIp1ww85UMWJ
	 kjsxHlN0zVEltIMMa8NYgE/pGCX6aewjaK5o6sn3SvUjZlulvTVTgTq9BgoizeGdJ9
	 8OtLbvt2sO8Ew==
Date: Tue, 28 Jan 2025 14:24:22 -0500
From: Sasha Levin <sashal@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Mark Brown <broonie@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernelci@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	lkft@linaro.org
Subject: Re: [git pull] d_revalidate pile
Message-ID: <Z5ku5uVc3WGpo0K1@lappy>
References: <20250127044721.GD1977892@ZenIV>
 <Z5fAOpnFoXMgpCWb@lappy>
 <CAHk-=wh=PVSpnca89fb+G6ZDBefbzbwFs+CG23+WGFpMyOHkiw@mail.gmail.com>
 <804bea31-973e-40b6-974a-0d7c6e16ac29@sirena.org.uk>
 <Z5gJcnAPTXMoKwEr@lappy>
 <6400eae4-1382-450d-a7b8-66f9e9a61021@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6400eae4-1382-450d-a7b8-66f9e9a61021@stanley.mountain>

On Tue, Jan 28, 2025 at 03:33:14PM +0300, Dan Carpenter wrote:
>On Mon, Jan 27, 2025 at 05:32:18PM -0500, Sasha Levin wrote:
>> [ Adding in the LKFT folks ]
>
>Ugh...  The website is pretty difficult to navigate.  I've filed a
>ticket to hopefully avoid this going forward.  It's a bit late for
>the line numbers to be any use but here they are:

Thanks Dan & Mark! I think I've figured out (and scripted) it for next
time :)

-- 
Thanks,
Sasha

