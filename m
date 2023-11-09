Return-Path: <linux-fsdevel+bounces-2505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE117E6ADE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 13:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690932816F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 12:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C86418E0A;
	Thu,  9 Nov 2023 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9L+jL/4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2799111AA;
	Thu,  9 Nov 2023 12:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D49C433C8;
	Thu,  9 Nov 2023 12:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699534560;
	bh=ZIZpYB4NZuMBju2aLNCrseI0ckNZt8J3X8qbCNJIgBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K9L+jL/4Sz5qCcfq/ZWdd4jusVt/qmqMi8SRCXAFjTZ+Ethnxzr7f0c5uD2VKjLrB
	 gsRK761WpstOmv5rX62ISsvXhYjLz0GtQEom4bkdGhGsBOqfmpnVFnS3x0gTQk5bvI
	 i0GJ13Xbny3IL46li0ENRtJHoY+37xgq+RjqsEbuXXptnXjUOxQs03ErNUh9T2OBZH
	 BUka1myoZ/9y3Kyekc86/QagucchE6d9ktXKtf0Y8qDhTP1j0ZAB/97Rjw5XIicAVg
	 6ZmMh89qY3UAUGdNod9SiIOI/bvdGOsx7+G4uddqMR+5IUrwmbxJlqWdqvLxojcRil
	 XLF2q/JJhLizQ==
Date: Thu, 9 Nov 2023 13:55:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] btrfs: convert to the new mount API
Message-ID: <20231109-updaten-anhieb-ec1245bc7b88@brauner>
References: <cover.1699470345.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1699470345.git.josef@toxicpanda.com>

On Wed, Nov 08, 2023 at 02:08:35PM -0500, Josef Bacik wrote:
> v1->v2:
> - Fixed up some nits and paste errors.
> - Fixed build failure with !ZONED.
> - Fixed accidentally dropping BINARY_MOUNTDATA flag.
> - Added Reviewed-by's collected up to this point.
> 
> These have run through our CI a few times, they haven't introduced any
> regressions.
> 
> --- Original email ---
> Hello,
> 
> These patches convert us to use the new mount API.  Christian tried to do this a
> few months ago, but ran afoul of our preference to have a bunch of small
> changes.  I started this series before I knew he had tried to convert us, so
> there's a fair bit that's different, but I did copy his approach for the remount
> bit.  I've linked to the original patch where I took inspiration, Christian let
> me know if you want some other annotation for credit, I wasn't really sure the
> best way to do that.

Thank you for pointing out the work that I did and for building on the
bits of it that you could reuse. That's enough credit for me.

Thanks for converting btrfs and I hope we can get this merged soon. This
was the last really major filesystems that hadn't been converted yet so
I'm very glad to see this done.

Acked-by: Christian Brauner <brauner@kernel.org>

