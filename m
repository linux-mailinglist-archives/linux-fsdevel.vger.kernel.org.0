Return-Path: <linux-fsdevel+bounces-30228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E1D988004
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 10:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BEF4282B10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 08:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B7A189B9F;
	Fri, 27 Sep 2024 08:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6oFnRXx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B606188CB7;
	Fri, 27 Sep 2024 08:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424445; cv=none; b=UvXGxhOmJwcnd2AttRXsaSRqYeBfL3W8/ddI2HzYDa8lwenF07YoorzBeCods0WS5NyST7ktOXVG8b1w76tr+sZ3H6CCYQyGWJ6KlhbR5EKlrNEC0dOyc0l3PsKB853wJ/Un0LHh6KKJjpcRKvD0Fcx5mbZYMT36RId9bStSCqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424445; c=relaxed/simple;
	bh=w/r4IrDMdsbnNrUJdiGTxDc3Vc0EH27o2LrhEKew1Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDNaZ6FiaP09XkgU3R7lWOHLNSjpVXPrjYnb+Mn4/htk0NYa2H96nw4QRsa7CZqVNdgulp+Vu6l5zAmhhDjP5JQzk2N0VFHg58hvwLeWxVINS8Y1FSibrqM8Q9snxYpm1PTY6/w4K6N2OQOsMmD7ngEU5HkqFuZQXoFkQEFTnC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6oFnRXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9461C4CEC4;
	Fri, 27 Sep 2024 08:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727424444;
	bh=w/r4IrDMdsbnNrUJdiGTxDc3Vc0EH27o2LrhEKew1Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B6oFnRXxQkgl22gfgRImZiiCHxUgyVhhbFzoqKCjHidXalW6C1b0p5OEC7RzXwDuD
	 QbGKtx++eoj6dk31xc3dHn0ZayosgCj7HmDRdGpvqXrIP3dJNIypsrPtOtJXxd7+Hi
	 Kl5qVXPOp2lT66ee6SrJEaIFddPSnZi+bDKdC/iDjyGfIE201CPHRqBzmh1X6WoAYm
	 N3VrUm0NWY2K0RUe0gDori9yX2Qz4COEzDUKJT+ZX4Zcn6+hh10OnntWjipQlwNU98
	 MbvA9XHSrLr8Bp9gcPbQUOp5MC6LSLH785IcxOyAV6Zsg5EVLLiDd55dUY7jG6EaBk
	 FptumCalarihQ==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>
Subject: Re: (subset) [PATCH 4/8] afs: Remove unused struct and function prototype
Date: Fri, 27 Sep 2024 10:07:10 +0200
Message-ID: <20240927-beide-aktienhandel-de829a6cac5e@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923150756.902363-5-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com> <20240923150756.902363-5-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=970; i=brauner@kernel.org; h=from:subject:message-id; bh=w/r4IrDMdsbnNrUJdiGTxDc3Vc0EH27o2LrhEKew1Ys=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR9S9/Cmv1nio7inM2hPx4Gqx7MOXeN7/ecBw9sbsrrW Rh1//P93FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRU+WMDBv2R79Oloz9sKxY ZOUMHwnHSWzSqcn6ly5MaO8/mmIukczwV8rkYKuOZ5HcqZ9O/I0fzzdkhnybeC6Tk2WCjH1JeNd TJgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 23 Sep 2024 16:07:48 +0100, David Howells wrote:
> The struct afs_address_list and the function prototype
> afs_put_address_list() are not used anymore and can be removed. Remove
> them.
> 
> 

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[4/8] afs: Remove unused struct and function prototype
      https://git.kernel.org/vfs/vfs/c/45635ccabac2

