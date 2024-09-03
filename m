Return-Path: <linux-fsdevel+bounces-28383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F8D969FA2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999CF1C23B97
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFEF45003;
	Tue,  3 Sep 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZsM5/YX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F964F20E;
	Tue,  3 Sep 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371964; cv=none; b=d+VmHTMNZ3F7d48OI6YaXt4bHICONk+6VF6VfzLgG3WkiSUBgwv8ry87Yp0Db4B3uvkDbzu5aRBTvf3R3iDPTocDgRFOV15pVcw1mIIaf7vJgfxwH9YofwLEqyPunJ6bd6eq+bcCva9T3GRHr2ZeK9mg7CwkLe8MQCGE/COqKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371964; c=relaxed/simple;
	bh=rqOGhsMdMGrV5HJZRvHOtwkBtQNWY9ELDZYn9vJAdPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPrTrthg1C2gZRzOqJhFkHckmJxBQ3n6br131IvNkIUsLIUBNEsX/vRLLAU1Gt/BjtnqmnVeW4jatHmt2J1s6MhhEksleL2ZNQjXxRKMZhs/ZHFxJXr4TSuzJPwtBDP71FBBdyLZbZNkw0dVKkHBacF5qy77wtW1cW3Bxyuow24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZsM5/YX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E48CC4CEC4;
	Tue,  3 Sep 2024 13:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725371964;
	bh=rqOGhsMdMGrV5HJZRvHOtwkBtQNWY9ELDZYn9vJAdPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZsM5/YXPYUMG0bRFaJNEDz00J1OJx7WnK3+UdDJzuk9xqggDH1olKgewst4FCPkE
	 dglBPYtB8RFo8ZDzPz5obdnl3WSnFwrcvhWwAVXkubaVhCtddIWoy8xnNe5kCvuuoi
	 fC3vx90s5cAqUafb+D/Z9S9fqL58peAKvBnRL10No9HfarVlJtuTGEqjoQvJxvPXfY
	 SPu1EMmbaogV1wbBR24wrbBFH7NkDi6m8VpaywT8kNYZtCY6vqMI++RNrARUoRjx44
	 SlcYkgx+Tk6WoJ6wXzh9qK6ym87clD+WOuXrhoOLple31ijGtIuw5RjQxMd03Amsgk
	 xrVqLiO51h6Eg==
Date: Tue, 3 Sep 2024 15:59:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Christian Brauner <christianvanbrauner@gmail.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [brauner-vfs:work.f_version.wip.v1] [proc] e85c0d9e72:
 WARNING:lock_held_when_returning_to_user_space
Message-ID: <20240903-lehrgang-gepfercht-7fe83a53f87d@brauner>
References: <202409032134.c262dced-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202409032134.c262dced-lkp@intel.com>

On Tue, Sep 03, 2024 at 09:53:05PM GMT, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:lock_held_when_returning_to_user_space" on:
> 
> commit: e85c0d9e725529a5ed68ad0b6abc62b332654156 ("proc: wean of off f_version")
> https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git work.f_version.wip.v1

This is once again an old branch that's dead and was never sent.
Can you please exclude anything that has a *.v<nr> suffix? I thought I
already added a commit to this effect to the repository.

