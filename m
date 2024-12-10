Return-Path: <linux-fsdevel+bounces-36909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7422B9EADCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 11:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D1E2872BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 10:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196991DC982;
	Tue, 10 Dec 2024 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsD9LlLv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7751C23DE8D;
	Tue, 10 Dec 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825922; cv=none; b=QI41yvE4SYBQFAjQSRT9M4xdmCRptxI84upz51ehoD97uUPubEjBO1lPKZLdboVPE/uvVLEH2rCKexkWls7fEXfL/mSf4gl2vNqKq75MlRkwATSLtSTvn/BThm3WEHUqHd9mMzZpL8FntlgW7GB2l3f6lL7vehkSQEfOeTFVqQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825922; c=relaxed/simple;
	bh=8j8zkeodPX6EgE01SCpiWECdYqsRnde7/yNY9BXcN6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0JozkfvEYQfNvrA0u8dm8jerUn7tdLyvvr3JVCThZb7kSF9LT0jEk3Aczmtvi8vsQeJzy1M3LO6keTc1UV/3FFZ2u2OJwqS86Qy2TYQI7d/ymh2OAbzW/1qMu5+JaPndBjh0I/ZIf59D6k+b1YfjWM2Sm2dCK/v96NSi2LIciY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsD9LlLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60FBC4CED6;
	Tue, 10 Dec 2024 10:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733825922;
	bh=8j8zkeodPX6EgE01SCpiWECdYqsRnde7/yNY9BXcN6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TsD9LlLvRhM5n+tnHoM5wV6okMZX+Gc3OSWbEEQc71eD3C7UtdC4PF3ixUnVfZWAl
	 sfFBH5jFPX9nXPng4T2BeGKhWM4Gj/7P20VnuXidCBjl8Cin5+KZpXqIgZ5CO2v06p
	 65aL7Ahc9U4ap2H8cMVKw0SsFzZemw3zf5aBJE2Ozw7rxUA71herCmLMef0QBBoC4E
	 2V3Q8nJRJWZpcN/FqAQlr7MJotPuJrkx/jilseAEJ96XvNFVlOFdgj36B/1UhzOky3
	 q1JzulGS3XmwkqLidjnu5cTTyhPs/m5ovsLxJU8/RcaySQ4Y0UiJx22P15svmQ/JiK
	 cqaDVjCHqGfhA==
Date: Tue, 10 Dec 2024 11:18:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [MEH PATCH] fs: sort out a stale comment about races between fd
 alloc and dup2
Message-ID: <20241210-bringen-tischbein-612cd32e69e2@brauner>
References: <20241205154743.1586584-1-mjguzik@gmail.com>
 <20241206-inszenieren-anpflanzen-317317fd0e6d@brauner>
 <20241209195637.GY3387508@ZenIV>
 <CAGudoHH76NYH2O-TQw6ZPjZF5ht76HgiKtsG=owYdLZarGRwcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHH76NYH2O-TQw6ZPjZF5ht76HgiKtsG=owYdLZarGRwcA@mail.gmail.com>

> Christian, would you mind massaging the OS entries in the commit
> message (or should i send a v2?):

No need, updated the commit message. Thanks!

