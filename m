Return-Path: <linux-fsdevel+bounces-8437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 041E08365BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 15:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995F41F22AE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C01E3D577;
	Mon, 22 Jan 2024 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbCYmBLt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A850F3D556;
	Mon, 22 Jan 2024 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934638; cv=none; b=HjFuI3XVSb7fzrIBupbQYLulL8HZnIhBGLXGc9g6ctggHyWyJCEfx11ADVGt57ljabZTU4mr/zd9rbrf5DQfEOeT+QBqp6eRbQHz418Z7Ta5/FzJPgANmDEMvt8Snoxa5w7Rdv2vJmLCwuVDbjdfy39V0LkZ22WZgPQrdX0gdR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934638; c=relaxed/simple;
	bh=okSe00Plf0urDpy7xMnzOmvyVyrPmVJSvxNEVIQ9gyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szIccTCUXesdUSpEeTsfNv+EYaju/radVDsya1GsFP1NkLu+rBxDlt0bJIAbo8XeVo3YV9E7+57VVWp7JyqZM5fQIoU3OUqGMSgPmf73ArcAykdlRMFvannfcAkrpm90E0x3BkraXKMxOma18S/x0MC0px4E5+chiD0GMt+GgMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbCYmBLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DB0C433C7;
	Mon, 22 Jan 2024 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705934638;
	bh=okSe00Plf0urDpy7xMnzOmvyVyrPmVJSvxNEVIQ9gyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rbCYmBLtGU7jcVEHLqY8mJViCCeFdbnSkSezt6XhBxQd/01t73Mz7+YDNj/JVZ90U
	 h8yfCER0idrxElrXoY754rURY4Cwj8gCFWocsxQRhd4JnNzkPGjN5UhivZz3fLCfpJ
	 J25Y7IgJI7fZ23D71v7P0htUUIrDZcEXSp7ujveSupdBO3l73RWrifGBJJX/wVtetI
	 4c5cdYWRJI5qMfMHrFBX7hbxtTaEpEZS30sFegdRHddze+871iZ4hcQ0DNVJM2LP3X
	 HbsCVa26Db2yy48nWIhZHASl8uU/Y3niK/h5wZR+n2iUqW9KKDbxuGMH1r+1Bmzg/9
	 dZ5ltFqAFHpyQ==
From: Christian Brauner <brauner@kernel.org>
To: netfs@lists.linux.dev,
	David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] netfs, cachefiles: Update MAINTAINERS records
Date: Mon, 22 Jan 2024 15:43:17 +0100
Message-ID: <20240122-benennen-lastzug-8560ff9a85aa@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122115007.3820330-1-dhowells@redhat.com>
References: <20240122115007.3820330-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=brauner@kernel.org; h=from:subject:message-id; bh=5wiNsvaXup0M7lS0bpBvZ1QaDid4vN5t5fSW7E6j0v4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSuqxd8sTntwGK1+pv1Wqdvf1h0sHr63/XfiqbHZSbUn Z7nFxbk0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRVA1Ghm6bneUf3F9MUHl+ VXbbTrG/+TlnZa7w9O47pZzuLXU3dTXD/4Dva27OE3jinqMqVpaoZeks2rBD87Cfq0CYx7lNwat X8wIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 22 Jan 2024 11:49:59 +0000, David Howells wrote:
> Update the MAINTAINERS records for netfs and cachefiles to reflect a change of
> mailing list for both as Red Hat no longer archives the mailing list in a
> publicly accessible place.
> 
> Also add Jeff Layton as a reviewer.

Yay!

> 
> The patches are here:
> 
> [...]

Applied to the vfs.netfs branch of the vfs/vfs.git tree.
Patches in the vfs.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.netfs

[1/2] netfs, cachefiles: Change mailing list
      https://git.kernel.org/vfs/vfs/c/3c18703079b6
[2/2] netfs: Add Jeff Layton as reviewer
      https://git.kernel.org/vfs/vfs/c/d59da02d1ab6

