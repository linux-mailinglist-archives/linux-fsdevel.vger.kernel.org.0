Return-Path: <linux-fsdevel+bounces-40157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23229A1DD94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 21:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A26416524C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 20:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D45198A06;
	Mon, 27 Jan 2025 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbTA9yoM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F23818E756;
	Mon, 27 Jan 2025 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738011138; cv=none; b=rmv4lRlWUdIesv7LV81/TlhTZxN1d1DkU4p1/GRNwN1DdKUTkgyHOPHOeFEz0F6M9h0rgHu0FxtrH8p+EwTlvvr849vgKB2I0oC4xTfHjw12orHp+asRQY5vOlrGyPe16P6/cbiARdWn+9RlzoG4bC1cvcJF3hIGCNtqz4c7DPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738011138; c=relaxed/simple;
	bh=isi+B0vK8TlxCYM4m95FCbzbsSYWCYCpQOmcuOb6LgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwF/u943drkizzoWSiunCRS1Dz6BdDq35he1at0nXBvnVA9MdgQ28tp2s4lPkd6bwNaa0mYXpBVGlPwiiiYAS9gqt0LT4rkO4ebxWm1L2LQawDEMzW87vezbDOl14K1rWiRG453UYgH4JbaRNLl7JC36Jn3StZnSb48LoCe82zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbTA9yoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4E8C4CED2;
	Mon, 27 Jan 2025 20:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738011138;
	bh=isi+B0vK8TlxCYM4m95FCbzbsSYWCYCpQOmcuOb6LgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbTA9yoMOXUDbq/N1BNKsSzZ9odjIEEnItpjYqOVArb6e8QtVDsPsC95ttIx2/mx7
	 lv1GUl/quNQVn/dF6Vbyu/Cf1V+ssEaQ2x1+i+chTS2IO5bJQlMbwWhrk6G+Vd6atk
	 9uCVmYiJFFzZnjfErmyXUeuR0lM2IIqInKsx2HzidobVqxZltLjMPTARqPHAAhU2AT
	 QwINA/5Ch9FrFDAnLsKGfSgblScnu9im98WLDso0jNpb6i7IXj9WkkxCpK6G1XZxq+
	 yEDuYDEMCs9Y4eNFY8UkQel/Wf1nMCDe0Kq7eicwv5SkigZfIAWELuQfFIg0ShPskU
	 fz7mI6WUrkm5w==
Date: Mon, 27 Jan 2025 15:52:16 -0500
From: Sasha Levin <sashal@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] d_revalidate pile
Message-ID: <Z5fyAPnvtNPPF5L3@lappy>
References: <20250127044721.GD1977892@ZenIV>
 <Z5fAOpnFoXMgpCWb@lappy>
 <20250127173634.GF1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250127173634.GF1977892@ZenIV>

On Mon, Jan 27, 2025 at 05:36:34PM +0000, Al Viro wrote:
>On Mon, Jan 27, 2025 at 12:19:54PM -0500, Sasha Levin wrote:
>
>> The full log is at: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.13-rc7-8584-gd4639f3659ae/testrun/27028572/suite/log-parser-test/test/kfence-bug-kfence-out-of-bounds-read-in-d_same_name/log
>>
>> LMK if I should attempt a bisection.
>
>Could you try your setup on 58cf9c383c5c "dcache: back inline names
>with a struct-wrapped array of unsigned long"?

It looks like we didn't trigger a warnings on that commit, but I'm not
sure if the issue reproduces easily.

I'll start a bisection and see where it takes me...

-- 
Thanks,
Sasha

