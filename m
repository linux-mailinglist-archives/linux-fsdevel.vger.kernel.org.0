Return-Path: <linux-fsdevel+bounces-21252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D358490084F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B1A28627F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11398188CBB;
	Fri,  7 Jun 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Puf+jNN0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5DF10958
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773114; cv=none; b=jUbAFHe3InwEbb/cE8qNy+GZFpATq75RqEM6Hd468pZdKorRuru3wD2ZoPv+d8YfkPZmS036LjLpDf+RSCKw5nPucNujklLu4r+K1iwcJKxD7aF8OoginHdL1ADy8a87JBIqxQKsPXVe1U/ftZiZEtMpYPqJDtnNHr2VGT/gQVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773114; c=relaxed/simple;
	bh=Y1/EVWT2aR0y3s03lFAOFMm2b1VxmNYb6PEASy5ONps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htwFbZML7+aCl+wbHD5J9qJ+9wtPwyCK6nLm/ZQ8+4ohZMZjdEDU5y+FzugCqT2+Sd5SDjC2D5YFohYy7EYPw5MZTdQL4HarfbFTE4osJ6OGY7q4+6OayONce9XuI6v8zvHKlzL5E4I3Av5Iiitik/p5cBqoHBDRzgV9WGhYHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Puf+jNN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A101C2BBFC;
	Fri,  7 Jun 2024 15:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717773114;
	bh=Y1/EVWT2aR0y3s03lFAOFMm2b1VxmNYb6PEASy5ONps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Puf+jNN0WbSrbPeG7TjLjBU/AS+oldDcdaOwBAXG+xVdwYsEcxRc3YgX8USg6XTv7
	 bxFaiPW82bhTGPv/oTaroCu6oDtrYOBf6Rk/fQyTNpqQqt3LIr3SWcwE7cPwpar0cW
	 aq0XvQwKSMePvmW0mP4wtQ3p9qX0EkHl8dgUYRU20EvYtbXu1FVsz29pzgnmQqdUqh
	 3TmDvdqLJs+0q0mbMCFeKygxfIy2oPOfGoNl8dGjDz8fC0UavKJtMheDHaSonDqIse
	 1Fl+MmG8RO9SWxospWaD5WSYR11CP29t/1MebJzBP2jzYbckNq7HJzjyYDVOx/Rnz8
	 v3U5L9K73C3/g==
From: Christian Brauner <brauner@kernel.org>
To: Jemmy <jemmywong512@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	jemmy512@icloud.com,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4] Improve readability of copy_tree
Date: Fri,  7 Jun 2024 17:11:46 +0200
Message-ID: <20240607-gekennzeichnet-kooperativ-8f13b186c73b@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606173912.99442-1-jemmywong512@gmail.com>
References: <20240604134347.9357-1-jemmywong512@gmail.com> <20240606173912.99442-1-jemmywong512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=brauner@kernel.org; h=from:subject:message-id; bh=Y1/EVWT2aR0y3s03lFAOFMm2b1VxmNYb6PEASy5ONps=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQlKxu3HF1V+8c+8Tjz3EX9q7/fU5w0Iz8mcC57/te85 Q2963andJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk5kqGv4JR+opZr3hMpmTt dj/ic6Jq/309XSb7uNKzto/U7CwmzmP4K8fT8v3Gu51X4hU+qSTnHWq85Ce4jz26plRTsi+ydoo QCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 07 Jun 2024 01:39:12 +0800, Jemmy wrote:
> by employing `copy mount tree from src to dst` concept.
> This involves renaming the opaque variables (e.g., p, q, r, s)
> to be more descriptive, aiming to make the code easier to understand.
> 
> Changes:
> mnt     -> src_root (root of the tree to copy)
> r       -> src_root_child (direct child of the root being cloning)
> p       -> src_parent (parent of src_mnt)
> s       -> src_mnt (current mount being copying)
> parent  -> dst_parent (parent of dst_child)
> q       -> dst_mnt (freshly cloned mount)
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] Improve readability of copy_tree
      https://git.kernel.org/vfs/vfs/c/5692e7579306

