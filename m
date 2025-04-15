Return-Path: <linux-fsdevel+bounces-46439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37195A896C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 10:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6531895F95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 08:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FD928B4E1;
	Tue, 15 Apr 2025 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qsz+YZ7S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E751EEC3;
	Tue, 15 Apr 2025 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705907; cv=none; b=FesRg1pfni/Sp/Kb2SVQUwdaieJO6XiPrF/8xGhoJ2fmGtY1Ltx9nNv9wXI/IlAya+wZBP1IS0Bga5KLANnF7KIggJz4DAtKJP+zizOgbDj8wz77M6syYbjIIQvaIh5xhOcIa/7WhIrnxIXYJYU3gR7hWqCwx7kYszpPrm3UOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705907; c=relaxed/simple;
	bh=oU93N5reheIKkW5VKi9abj/S7BhpxsAnf/qQko/2IDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4Kx5ew4ZJuUCz2JhtXT2aS8ju/4gNVlsGdYQ/qdIZdO8MVuwg+b6I71cpRkf0JBGMIx4fFSofejwdaLAk56YzE6Hr6z7CLp9ASr1900E2vbWpkxC2g0M9RQOMZ2eVKget5qby9x1PhiorZwjNPIxCBOSRosQo4pN1FVQqvUj3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qsz+YZ7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BB8C4CEDD;
	Tue, 15 Apr 2025 08:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744705907;
	bh=oU93N5reheIKkW5VKi9abj/S7BhpxsAnf/qQko/2IDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qsz+YZ7SRLPISzBY3uNp0wjYQ6PYZK0sJsGsQQmZNhEo3Op0hICR6Dr/4Ay94+LgI
	 cU78VKIuO7Z3iMqYGnQ79+8q8bdmGMX0UpQWL0KGOItc8SZrQaZXlKjUmZWslwNhft
	 e0ukssC3hslKyamoMOy6Q8jayNaFb7mtdIYsReJ42+P0jbOs6I/dfdPB1L8CfIvprT
	 vMqTH/nx4/j83D0GR+ifDsF3u670zVIKPdbDiOH60zhJdUCNM4xsp/gmwE+rXW+2Gb
	 xBK7kgjHb4XOMqitOG8/jPinviSjPcjfLpfeR/F+H1jLcjdOl5fDDKGtlL2mB5zh5i
	 wYKq4619vZXcQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-xfs@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	ojaswin@linux.ibm.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Documentation: iomap: Add missing flags description
Date: Tue, 15 Apr 2025 10:31:40 +0200
Message-ID: <20250415-busspur-stemmen-befa0e140e09@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <8d8534a704c4f162f347a84830710db32a927b2e.1744432270.git.ritesh.list@gmail.com>
References: <8d8534a704c4f162f347a84830710db32a927b2e.1744432270.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387; i=brauner@kernel.org; h=from:subject:message-id; bh=oU93N5reheIKkW5VKi9abj/S7BhpxsAnf/qQko/2IDs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/k8wzvjOXOfnQAt31HEWPNOc/bC3xm3ov36Drk83ib /+elUUv6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI32uGf+qH3jzg/bzhmPqs 1JrjBcI+U6WjcpRmvJJyy5J9fE/39kFGht96ajsr439z//5a5c8aFG6eyP/OJvQNc8eL4EtTZE9 c5QQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 12 Apr 2025 10:06:34 +0530, Ritesh Harjani (IBM) wrote:
> Let's document the use of these flags in iomap design doc where other
> flags are defined too -
> 
> - IOMAP_F_BOUNDARY was added by XFS to prevent merging of I/O and I/O
>   completions across RTG boundaries.
> - IOMAP_F_ATOMIC_BIO was added for supporting atomic I/O operations
>   for filesystems to inform the iomap that it needs HW-offload based
>   mechanism for torn-write protection.
> 
> [...]

Applied to the vfs-6.16.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.iomap

[1/2] Documentation: iomap: Add missing flags description
      https://git.kernel.org/vfs/vfs/c/336bac5e0892
[2/2] iomap: trace: Add missing flags to [IOMAP_|IOMAP_F_]FLAGS_STRINGS
      https://git.kernel.org/vfs/vfs/c/d1253c677b8f

