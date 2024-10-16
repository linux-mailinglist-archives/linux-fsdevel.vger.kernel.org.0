Return-Path: <linux-fsdevel+bounces-32060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D10F99FECC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 04:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31817286E78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 02:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C8015B10E;
	Wed, 16 Oct 2024 02:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4z5s/QI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EAA1859;
	Wed, 16 Oct 2024 02:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729045535; cv=none; b=mi+xOg5qyE104gJ7OMkoTqSe0W/6lalIZlRoVvGfBaQt6W/sQir7OW9R6HBmc0bEKqZ+r0VGZTauvUtauVbdvL91fDpMxnBR0yv/l3k1Kldba5wF2kguGgP+fcms15zWfEW9Os9KL9QkbrV/eR+0m+xL/SEanSYotNkn8wBSFPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729045535; c=relaxed/simple;
	bh=Jdptx5u4v/6E5gp57CYDnSwOan85kAY5Yrrs9yzpD4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLEnAvh91LXNwC4q3C+NfzvJJNNCYZncjqVPrZHoMOav0aHWeRx+WzoY3jhM27qcHWcgloHHJBnGCO/KDnatdsNwBok9cZifUCSC/J3b3pwhwnjej0Dxilf5IAhynWiuxP9SK2fcFmxhyTmrnPD9+VX60TykYXnRxVpB69Vg4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4z5s/QI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28189C4CEC6;
	Wed, 16 Oct 2024 02:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729045534;
	bh=Jdptx5u4v/6E5gp57CYDnSwOan85kAY5Yrrs9yzpD4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4z5s/QIbi4scSq1/pFzjwCxhTENqAU9wNPNPZpWCHzS5yFKT4n8SBn2aWiPvJ2mF
	 K0EsQ+KSQd/4eudF++qNxhI5ebGeGjOFvXqYuZoHt3J1MmhThPxJTLX34UNSmCWj0b
	 kY6p1luRxUgDrgfWWYadT5kwu1dX2/O8XyQo5IXiKh7hSXFyqo2aXf00izrInqlKys
	 CciCGTPMC0rjsEz1tLNQSFvi619GwtJlVTKA0zVlZUsPJhoD1z1t7bJ08QIMsLi9OT
	 ktFu4XOAr1CxQCkWz0KvIjAXnX4mt09iqoPAZJDm8OMuyQ1w5Sga2UYVP+hhuS4sWu
	 K0hMCuJF1zWAQ==
Date: Tue, 15 Oct 2024 19:25:32 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Christian Brauner <brauner@kernel.org>, oe-lkp@lists.linux.dev,
	lkp@intel.com, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [fs]  d91ea8195e:
 stress-ng.ring-pipe.ops_per_sec -5.1% regression
 (stress-ng.ring-pipe.pipe_read+write_calls_per_sec 7.3% improvement)
Message-ID: <20241016022532.GC1138@sol.localdomain>
References: <202410151611.f4cd71f2-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410151611.f4cd71f2-oliver.sang@intel.com>

On Wed, Oct 16, 2024 at 10:19:25AM +0800, kernel test robot wrote:
> kernel test robot noticed a -5.1% regression of stress-ng.ring-pipe.ops_per_sec

These emails that talk about negative regressions keep confusing me.  A negative
regression would be an improvement.  But that is not actually what is meant.

Wondering if the wording can be fixed to remove the minus sign.

- Eric

