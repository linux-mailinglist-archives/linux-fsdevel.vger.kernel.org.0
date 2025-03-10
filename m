Return-Path: <linux-fsdevel+bounces-43570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C68A58D95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 09:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07283A90EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 08:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366B7222578;
	Mon, 10 Mar 2025 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHMIEM+O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FAE84E1C
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593854; cv=none; b=oqZeuJrsHjI71/IC2uU2jJJXwyROoVrvKHUa8DAueOn497baWpqiG6/gWwaVibUmSg+UNglNtCG7zj2/Q4RtoPIeG14uvuAt1jO9XtmBGhXNEHC9v76c2l+/eQtdWF6h3zqfCH49odz2SjgBz5k3LBI6XHq1JxFCU3gZtSCyklM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593854; c=relaxed/simple;
	bh=I6zu3KaiR3QNZRukUIhVT+gsq+uHSLDShsoTmrMkHOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZCuMK0wxYFHFiICuOgBchmQW1eAdbuV94C+u2m/pJS/YG+fFtyG783BGR0ExIftg8mle40A6hUljh4NyoOdRGukoWiiGoKyEiTkxrzP90X9NMbP9Vt1660IMm58toQC8JmInlrzyPBNOg7juc7pkq4qIQIxnmXFwpWbC/yORB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHMIEM+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE0BC4CEE5;
	Mon, 10 Mar 2025 08:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741593854;
	bh=I6zu3KaiR3QNZRukUIhVT+gsq+uHSLDShsoTmrMkHOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHMIEM+OQkatVLTvk8g76M6Ac2XP/btznby7fKNx26AUEFeDQrj4JGMJArH1NB8Fj
	 0XbQUZxnp/WaQVC29OWT8xfEnwzbZHUD+JzzqAg3ZtagWkaoFtz3oXSr5WVc9g03D8
	 36TBxgLN6N0ya5+BQgLwbOQ0nJqa+y3nzXTb+VaFcCll3uGIvx6bySu/f4kBC7yoOz
	 pyromvVur1l5ZL5w0nFFCdWj+Vg4fdtJ9muRvOSDNXhnFXZPBa/qxT3woS+bPLF7CC
	 UbDyMRfhwu7tBoX1rAO9qzFnWz6ilArzgt1vk5IP2p16RXzTs7VSdfBtZxzPfKUdBe
	 vZMNvLz0Zmmqw==
Date: Mon, 10 Mar 2025 09:04:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: tzsz <writing.segfaults@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: Swapping fs root inode without unmounting
Message-ID: <20250310-addition-bedeuten-f24650be5c36@brauner>
References: <51d24177-482e-4355-8e14-689752dfa36e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51d24177-482e-4355-8e14-689752dfa36e@gmail.com>

On Fri, Mar 07, 2025 at 04:39:21PM +0100, tzsz wrote:
> Hello!
> 
> We are currently developing a snapshot feature for a small university
> project. And for this reason we are looking for a way to swap out the root
> inode of our (mounted) fs.
> Internally we have a set of root inodes and we'd like to swap them out at
> will without unmounting the entire filesystem.
> 
> Is there any function/way how to do this properly?

See btrfs_get_tree(), mount_subvol(), and mount_subtree() in
fs/btrfs/super.c

