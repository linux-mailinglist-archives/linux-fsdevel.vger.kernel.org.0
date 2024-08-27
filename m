Return-Path: <linux-fsdevel+bounces-27329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD1096049B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 10:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69AF1C226C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 08:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07299199229;
	Tue, 27 Aug 2024 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KS5A8yQk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B54194AEA;
	Tue, 27 Aug 2024 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747968; cv=none; b=nCoksjjbKI/3XxeetrFh2rccY0HPoqJ95enCRJqQalCzyaUKbv2u9xhHZ86jkHQKIGsQ6r8S7sowCvFdKYJ3pCHUpzpqtaC21CUDwzIqdGb1xHU3FC1//3xSXV1zHeTgnZAzO3905re8YjC2YQg5xXWCVx9/Sv4e+6zuNURFK+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747968; c=relaxed/simple;
	bh=USPTiv62qJ7IrdJylFLFmyGeey0tx8m9cOTOMX1m65o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3iyBjdXa3FGl5MmkbmFrmXab6cbbPSoShE3mRHvQzhYYUKDD8PGYNlSE8fth6INj4nDfJ66kH7bERZx+3CRI1QrWcLmYCrTzFnDv+J1xS0y90dyFsA7o2Xh53KHYyAr2fvcZ6c16yJ4WDXdLXNegbByl22vN0mzx1CsLDN7bGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KS5A8yQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF336C8B7AA;
	Tue, 27 Aug 2024 08:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724747967;
	bh=USPTiv62qJ7IrdJylFLFmyGeey0tx8m9cOTOMX1m65o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KS5A8yQkF48xLARIfei5DfRbEakuO1Cb2O+Urs8zsGjd3Jl0h8InP8TlGYTgjWMQ9
	 HjcrLWl7ItjnOXxo5W75caV1PBFak1p/GTrHty3TjFwVUTDC9MriOv93U39SCuoII5
	 rjL7QLIWfBP4Boj0HQCWjtU0uxiGQqVa30g04zVjh/Zh7eGFGs4tpQCJT3ZkyHgYun
	 355W955+uaK4+9TOf/ffvkXELBIovwVPj0n1rvxF41H2AaYxw3fHgWG3betoQ50jig
	 bvUq1q3cMrMbdAOfNAmv7nubZ3TkRVZEQHbo3EZ7Rzc6Gnbr0YutIX2WgP6oDxDyq3
	 VUJ39W10pKmag==
Date: Tue, 27 Aug 2024 10:39:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Christian Brauner <christianvanbrauner@gmail.com>, linux-fsdevel@vger.kernel.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [brauner-vfs:work.dio] [fs]  155a115703:  fio.write_iops -2.3%
 regression
Message-ID: <20240827-ansehen-mengenlehre-13e54cc52e38@brauner>
References: <202408271524.6ecfb631-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202408271524.6ecfb631-oliver.sang@intel.com>

On Tue, Aug 27, 2024 at 04:33:55PM GMT, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -2.3% regression of fio.write_iops on:
> 
> 
> commit: 155a11570398943dcb623a2390ac27f9eae3d8b3 ("fs: remove audit dummy context check")
> https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git work.dio

This is a dead branch and the patches in there have gone into other
branches in different versions.

Aside from that it seems extremely unlikely to be related to this.

Thanks!
Christian

