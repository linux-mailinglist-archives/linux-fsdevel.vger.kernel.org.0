Return-Path: <linux-fsdevel+bounces-57566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664D3B23917
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 21:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20DA16693A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EE42FE582;
	Tue, 12 Aug 2025 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaOH/GFU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E0527D780;
	Tue, 12 Aug 2025 19:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755027359; cv=none; b=Xco5tYv0kdIw+AiQE1ucukOzVP8CG8/DP8c9ZLUp/BkFsoxEa//aKfzKN5cAG6Co8BRFncerRpbGUmHYblmY7JaQSm5vHdkoMboVzKqNITdWA3PpQROJRryo0d5pEg4VcwCscQCJPCx2t/aPyw1AQr7eHt48vzMFXUAwcdYlteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755027359; c=relaxed/simple;
	bh=oOtLrOFSkCrfHUZ803LY2MKSsmRSCmBmVCEWP5AF4tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l197fDfnzv1N/uXmDzLGH5A+SS9jsDfhaVcMvpdFonhGCj15TsFHwB5u7YFAsxZTRo9tz2Jkr13m8Zm7zf3kwZzoFGZHq60gFGOSKi/QnzoB6rB4P4X4GupA9GhA6lGqDHo9Sc5T5NgTuzMnS+eu/s5IckPreqaR8N8NL5LcMhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaOH/GFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E085C4CEF0;
	Tue, 12 Aug 2025 19:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755027358;
	bh=oOtLrOFSkCrfHUZ803LY2MKSsmRSCmBmVCEWP5AF4tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qaOH/GFUpVapclspVWFkrtEAzBBo4k4WfCxOEgGwGECC4RNYYckgwLJMO0jXzQYJf
	 3rEyy/vrJvP+kbogHMdSfpxMtJJV3imM6OmxzpYeUWlUjwUwTaCYiuHaNPa4IMITvT
	 7ulKmhCUDmQgI0Ono/6kGS/AHc+fbhtp2m1jX0RJ/l6t6VTVY9Vp6IwAB7FLUkpLAp
	 laZb2zGmzLA8ozfxjJDNILFeGXkLda0f9zttGUL3ETxVovY/BEl1SGBSR/1of1O/No
	 2BpnAPyIgijkNsN+h9EpngYTqsl+gpJELzSJJrS7bKGIEV7uUUFVo2qnIg77JZs5wH
	 BK4N9GLa37kqg==
Date: Tue, 12 Aug 2025 13:35:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Konstantin Shelekhin <k.shelekhin@ftml.net>, admin@aquinas.su,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, list-bcachefs@carlthompson.net,
	malte.schroeder@tnxip.de, torvalds@linux-foundation.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <aJuXnOmDgnb_9ZPc@kbusch-mbp>
References: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
 <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>

On Mon, Aug 11, 2025 at 10:26:03AM -0400, Kent Overstreet wrote:
> On the other hand, for the only incidences I can remotely refer to in
> the past year and a half, there has been:
...

> - the block layer developer who went on a four email rant where he,
>   charitably, misread the spec or the patchset or both; all this over a
>   patch to simply bring a warning in line with the actual NVME and SCSI
>   specs.

Are you talking about this thread?

  https://lore.kernel.org/linux-block/20250311201518.3573009-14-kent.overstreet@linux.dev/

I try to closely follow those lists, and that's the only thread I recall
that even slightly rings a bell from your description, however it's not
an accurate description (you were the one who misread the specs there; I
tried to help bridge the gap). I recall the interaction was pretty tame
though, so maybe you're talking about something else. Perhaps a link for
context if I got it wrong?

