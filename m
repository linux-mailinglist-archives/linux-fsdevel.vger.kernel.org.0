Return-Path: <linux-fsdevel+bounces-55829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79428B0F386
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 15:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5E6580BAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 13:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8362EAB69;
	Wed, 23 Jul 2025 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyhBhbEc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460B2EA494;
	Wed, 23 Jul 2025 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276182; cv=none; b=sczLw3cVmYQvYmfTE+cWoq4LF6XcznzlFtSa38KbTHBAnU3meLm90Pq1MnZ0Q277CpYXrZmUyc7gabxfTIrni95ioRnNuwtgkmpV0yuGeFMgNr4fl9rDLcEQvw1Tt7wrQ2YY6XAQTayHwBnsZfhZHXLDT2DRb399u43SdTR7l5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276182; c=relaxed/simple;
	bh=kQr0L3MtwaWm+H8lvaxCeljFh4mQXtQXo0lPIFY8gUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0J5CkIguB0bI4PXLo9VIofEQfUTEHxh0vh8xxTjEdAC3zO3Krl0jYeMtvW70AJIOV1dJA12a+9RB+569Q1MDY46UGodJjllvq8qmPwslzI52Xdtv9Ow34PsGFsRHLhl03892qrnEBYS+ku0TSW6sQFNq9oEVKz639nB/AvAXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyhBhbEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76671C4CEE7;
	Wed, 23 Jul 2025 13:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753276181;
	bh=kQr0L3MtwaWm+H8lvaxCeljFh4mQXtQXo0lPIFY8gUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyhBhbEcjEzDgWoBWybf0Ek2hF9Lq+/12qnqmLj3A+DqdDMdX0SMzkmCzC1eJ87YT
	 aIiURxFeKMe1oPnfBoVqAnSl7q0lvcGiQyeVYdOz3Px4GkHlDa3fJkCWSqwNz0piwq
	 4HYeG2HBGLw6ObuhFiXbQxRjZhGTHlWOY27ZlbfIUs5tb6cxUm5klyWI7HG6dlIiVg
	 FVskX+DsbmOO1tWMa6ONnNATzggde4zI7JEW1LiLqV4A7Zvq4ATwJxaorWQolHMOTZ
	 WV0jPEV3PaJof3oOWO9bBPRHDP/U4CXNol+fS6EifEs4FxI9ZzGR/zhZn1pQ1FkKHr
	 z1+tpM1LAjwQg==
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH RESEND] doc: update porting, vfs documentation to describe mmap_prepare()
Date: Wed, 23 Jul 2025 15:09:26 +0200
Message-ID: <20250723-formfrage-brokkoli-62228a77f3cb@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250723123036.35472-1-lorenzo.stoakes@oracle.com>
References: <20250723123036.35472-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=brauner@kernel.org; h=from:subject:message-id; bh=kQr0L3MtwaWm+H8lvaxCeljFh4mQXtQXo0lPIFY8gUI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ03BdY2rX6nNJ9m1sZ02SSzf27kiYYlnJE1GXbxDiYS T2d9C+io5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIx5xl+swW9edZ5Xk4pe2dd 3fNHqiWfNkkmvfQ5eUP2UtrMxamzZjAyrDrBtUxlkZJDkucny3ld59lfHa1/v8/pBJcPv0a2vGE eFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 23 Jul 2025 13:30:36 +0100, Lorenzo Stoakes wrote:
> Now that we have established .mmap_prepare() as the preferred means by
> which filesystems establish state upon memory mapping of a file, update the
> VFS and porting documentation to reflect this.
> 
> As part of this change, additionally update the VFS documentation to
> contain the current state of the file_operations struct.
> 
> [...]

Applied to the vfs-6.17.mmap_prepare branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.mmap_prepare branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.mmap_prepare

[1/1] doc: update porting, vfs documentation to describe mmap_prepare()
      https://git.kernel.org/vfs/vfs/c/425c8bb39b03

