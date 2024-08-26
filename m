Return-Path: <linux-fsdevel+bounces-27136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553E495EE7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7039B1C21AF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9FD149E16;
	Mon, 26 Aug 2024 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2vP3Vg/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A5149018;
	Mon, 26 Aug 2024 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668342; cv=none; b=QMyVPF4e9JBDuxA0IkxWv/dBTip2QM0QJsUpPBLs9KdeutL6PS5nnqnndKOQ2pV5NuE5JcN4dSTib4Ygq/Kfzl2XBPpUjfIwTZUrvJBTIugDVa6Gd1Rl0Hif/nPQmeTrKatJM5dXe9oPB6PgDnk960wT0IjpAYOMyfGv+er4E6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668342; c=relaxed/simple;
	bh=Y1cnD9STJhkr0k/+sXYYFc+IhgrFb5H9XTB3O1sCqaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qddeGNcIPKg0EtPmR6cRs/u0dni5eRGT6EELIQkPCmTS7FjcV9KiQEGwCEpKLoMebtiWSXioMamnpB6El4Qm8+2wiEO1aOtb8gBSuqwQJ53KBIk8RQi8MFYjdzJQT3NpyJPZRbWacbBdCJszLjJPsacwVq6zHeUzh9pGdfwDATo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2vP3Vg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E134EC51404;
	Mon, 26 Aug 2024 10:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724668342;
	bh=Y1cnD9STJhkr0k/+sXYYFc+IhgrFb5H9XTB3O1sCqaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2vP3Vg/9xKzev4sJ1LcAxGZz3jG7fPg90AxXFpfnbOZoFs8eRFkCHAggBtJtJL8l
	 UtFoLZUniGA7bSbjdd0iGLzAphovK+9ct88uDW2e4cS9lwFeAi0OyU+weRJ1HGknkB
	 OUK50OEqmnn92GxNCjIwRb48va6A3nHfbE1D21aL78qcuB3iZmgibmUYUokC71E+xp
	 RQtKiY4hTvEj28AaQyz3ODw7rtQSilJ33LKghh2G1/pbconU6DNi1EGIO4bDWDloLD
	 +2eLlfd6M0zK1Zz+GiVbgGQz1ZpUEdGdUvQDde/6M4ztKyQKs5FCegF8WnTe7/eOQm
	 27GLHYXYYbdEw==
Date: Mon, 26 Aug 2024 12:32:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: kent.overstreet@linux.dev, sforshee@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2] bcachefs: support idmap mounts
Message-ID: <20240826-mitnichten-zerfallen-f9a348cecb46@brauner>
References: <20240824012724.1256722-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240824012724.1256722-1-lihongbo22@huawei.com>

On Sat, Aug 24, 2024 at 09:27:24AM GMT, Hongbo Li wrote:
> We enable idmapped mounts for bcachefs. Here, we just pass down
> the user_namespace argument from the VFS methods to the relevant

Fwiw, you're not passing a user namespace, you're passing an idmapping.

> helpers.
> 
> The idmap test in bcachefs is as following:

I saw that you tested this with xfstests because that has all the
important testing. Below is just really a "ok, that _looks_ like what
we'd expect" kind of test.

> 
> ```
> 1. losetup /dev/loop1 bcachefs.img
> 2. ./bcachefs format /dev/loop1
> 3. mount -t bcachefs /dev/loop1 /mnt/bcachefs/
> 4. ./mount-idmapped --map-mount b:0:1000:1 /mnt/bcachefs /mnt/idmapped1/
> 
> ll /mnt/bcachefs
> total 2
> drwx------. 2 root root    0 Jun 14 14:10 lost+found
> -rw-r--r--. 1 root root 1945 Jun 14 14:12 profile
> 
> ll /mnt/idmapped1/
> 
> total 2
> drwx------. 2 1000 1000    0 Jun 14 14:10 lost+found
> -rw-r--r--. 1 1000 1000 1945 Jun 14 14:12 profile
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> ---

Seems good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

