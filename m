Return-Path: <linux-fsdevel+bounces-46882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE15A95CCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 06:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794991774E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 04:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB05149C53;
	Tue, 22 Apr 2025 04:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUHVTPIH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4E196
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 04:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745295418; cv=none; b=s/aXiISpqd3LY1sZ6MKSLTOsTXky80P3iwq0hX6HZlhoMcNIMjhZkQF25lnHFqHsSs7vp5t1KAEuD3viLVGUJAOL0I37g3HclN88Znal/e1AHFU0GFGC++bvHrz6b1UjQZdARAYBqLp14Tvh3c0wio/QnbUM2+WmLT5EzYBEVc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745295418; c=relaxed/simple;
	bh=QWkWBlvfI1V+C+J7VwI2Ihskc4blTd1JexTecrAUSxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLaPJwJmgCvgw4sAlFdu1Xc/nGE0n9q/gUymhGt2FoXlNIhuhnoVZ32jBMWtfpirP4qvXERUOREXFM4fMoGZMdeAokYzt8GqDSPnYOViw7bTvIbhJcROqNivK0wGiB+CI+QCHtRQLQe8g0/mymcJoM/2otQnF+DgOpcgaTQ/Adk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUHVTPIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8C7C4CEE9;
	Tue, 22 Apr 2025 04:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745295417;
	bh=QWkWBlvfI1V+C+J7VwI2Ihskc4blTd1JexTecrAUSxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GUHVTPIHLDBvR/yeADXRMage79PUJhoiTBe1hHdYZJHpIcOCZ+q59V+AsXnvILYwW
	 4V3Uy6BXlU99zOElzqDaA/62TBymdc4pUPqfdYvj0qse9GFlojSHJNpqr3N/wLgkXv
	 f6zGDFXZAULpK4ZNoyxvHB0BqvRVYMolqJy2Nesp2twt8y5vjXNCDUBTvvyuysWbhP
	 kBur7oyLSqp4f093TyczjRWpi8J0JKXvNuAjc74YYEXN766AN2p0ZKMWwZWni2OyHh
	 g9NnG3eFQ5yo01/GsiA+QpnTrJG7OZk6nj1LIFlI2MhyB9I7x5hUfHlI7GuZzsFUDG
	 3oPjehzf1ui/A==
Date: Mon, 21 Apr 2025 21:16:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"slava@dubeyko.com" <slava@dubeyko.com>
Subject: Re: HFS/HFS+ maintainership action items
Message-ID: <20250422041655.GN25659@frogsfrogsfrogs>
References: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
 <20250422024333.GD569616@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422024333.GD569616@mit.edu>

On Mon, Apr 21, 2025 at 09:43:33PM -0500, Theodore Ts'o wrote:
> On Mon, Apr 21, 2025 at 09:52:14PM +0000, Viacheslav Dubeyko wrote:
> > Hi Adrian,
> > 
> > I am trying to elaborate the HFS/HFS+ maintainership action items:
> > (1) We need to prepare a Linux kernel tree fork to collect patches.
> > (2) I think it needs to prepare the list of current known issues (TODO list).
> > (3) Let me prepare environment and start to run xfstests for HFS/HFS+ (to check
> 
> One potential problem is that the userspace utilities to format,
> check, repair HFS/HFS+ utilities don't really exist.  There is the HFS
> Utilities[1] which is packaged in Debian as hfsutils, but it only
> supports HFS, not HFS+, and it can only format an HFS file system; it
> doesn't have a fsck analog.  This is going to very limit the ability
> to run xfstests for HFS or HFS+.
> 
> [1] https://www.mars.org/home/rob/proj/hfs/

How about hfsprogs, it has mkfs and fsck tools.  Though it /is/ APSL
licensed...

--D

> 						- Ted
> 

