Return-Path: <linux-fsdevel+bounces-16459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D82E89E000
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 18:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D091F21921
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 16:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBD013D88A;
	Tue,  9 Apr 2024 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0Al1BHh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7629136E1C;
	Tue,  9 Apr 2024 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678834; cv=none; b=SRwHKqAKlO8p8F/+JxS6fJEdFRI9Za63kbUCeQ0LNPkEpqUKlDhAwdcuLGbbahOwt2Gp1Atrtu8YTR98XcwWgJWUX7bYMUA5nTTDEQTQlJruVRFoVQ60X3YkcW/tqe37VL9KyjeJ+us1oM3Sx0+72Bi6C6kXZrffteU0O3VjaXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678834; c=relaxed/simple;
	bh=qmLu+B39nGxcOsPcrCbOMGpwlK3WNzAr6MKX4sjNhf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POMgIBkEwLxZK1p34DvdC+hsoA71FL/tFV1YoVi19IaiEQunKSpyCiZn7ht1gkpnXtUDdQ7tK5Piwbd6BAx0aBAVJjNsrEmkvQhf0+Q5EDMWVBSo17hhTACAshchh9DSiCBtZgU9ori0QzTwfc2qIiuB7d3MZsYAGOwK6ajlaOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0Al1BHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500B2C433F1;
	Tue,  9 Apr 2024 16:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712678834;
	bh=qmLu+B39nGxcOsPcrCbOMGpwlK3WNzAr6MKX4sjNhf8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=e0Al1BHhQp+hzFUfox1gnuvlWYu0zDeVi7ZTyupNDNSXtGrHWy6Tfqz5iAyAcK5T3
	 LQRo/g8GPzipVOEfrkkO6z+KdWXPwqJ4NpiVCO0H16qwgS/wrrlNVXMip31UqH/1rI
	 n7Q0GfF+JAV+504L7jJ6q+aRv2WksRx9t2xNZ5oNU823STgipWokR/eTYlXZr8Vojt
	 NQ69ES51HtcW6TkaDbNTqmS3wIqFRudOcKzaZrQyAPik49gbKK1sWTzvNRbWgYq8or
	 gv/YaK4z9RhY99TPV+UzKnWB/qJnUEvkxFed5im9q+LSVzi6+T0Et0VyRnz6xX5JEu
	 9wmac3e3cGd1w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E1D16CE2D22; Tue,  9 Apr 2024 09:07:13 -0700 (PDT)
Date: Tue, 9 Apr 2024 09:07:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH v2 fs/proc/bootconfig 0/2] remove redundant comments from
 /proc/bootconfig
Message-ID: <632948a8-6779-49d5-b90f-f1c5963d36eb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f036c5b0-20cc-40c1-85f9-69fa9edd0c95@paulmck-laptop>
 <b1ab4893-46cb-4611-80d8-e05f32305d61@paulmck-laptop>
 <20240409233248.ca2e8ba75f125f4dd01b273d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409233248.ca2e8ba75f125f4dd01b273d@kernel.org>

On Tue, Apr 09, 2024 at 11:32:48PM +0900, Masami Hiramatsu wrote:
> Hi Paul,
> 
> Thanks, both looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Let me update bootconfig/fixes.

Thank you very much!  As soon as I see them in -next from you, I will
drop them from -rcu.

							Thanx, Paul

> On Mon, 8 Apr 2024 21:42:49 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Hello!
> > 
> > This series removes redundant comments from /proc/bootconfig:
> > 
> > 1.	fs/proc: remove redundant comments from /proc/bootconfig,
> > 	courtesy of Zhenhua Huang.
> > 
> > 2.	fs/proc: Skip bootloader comment if no embedded kernel parameters,
> > 	courtesy of Masami Hiramatsu.
> > 
> > 						Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> >  b/fs/proc/bootconfig.c       |   12 ++++++------
> >  b/include/linux/bootconfig.h |    1 +
> >  b/init/main.c                |    5 +++++
> >  fs/proc/bootconfig.c         |    2 +-
> >  4 files changed, 13 insertions(+), 7 deletions(-)
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

