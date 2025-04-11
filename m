Return-Path: <linux-fsdevel+bounces-46272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36424A8607A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CAE27B44D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CE91DF27D;
	Fri, 11 Apr 2025 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG2XSX0f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3862AF11;
	Fri, 11 Apr 2025 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381271; cv=none; b=V+nLTTjpaOuWJAm9+k8T/Y7EFbhi2d9LPforJxpD54rXY/zuiSHJYzr62Wk7Ivl+nvEQ5Zm4sCWEl+QpBqPvPPRalZXnN0omuODNVAyQuzHDXhDYvvH9W9Eix3V0zbEoRQu4rqaLsNs6uVUWRQj8+WrxfRvvm6uyc0uM9N58tDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381271; c=relaxed/simple;
	bh=R47KmscxgQp8l9bKGgmTbbSqU0yi0fHEDgacMiINS18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNsEincf7OCvZxQJ15r2y9r1NwxP+3dR0cNfY98WczRoA/55paju0f2JjPtxsKb2t+Pn29b/MQNzUt7o5YvW67Rf2PJKVsHTL6w0hjBBWetchNSZNySbshfFhV0dWlEPY3X9HOBDXepyv0tJ7ElE6cqp6D8YMEAADG9lwcF7WQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kG2XSX0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947E9C4CEE2;
	Fri, 11 Apr 2025 14:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744381270;
	bh=R47KmscxgQp8l9bKGgmTbbSqU0yi0fHEDgacMiINS18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kG2XSX0f7eS8a3BzpXp+vHqiXpwNhmnthK5JCudmNbcigM3QiK9/61UKGFoJtryVF
	 VCnMe1z234piD4fDi/7yjR0Q4xSfCq6OyDEXF9yrkUL2/JMCRLS1Gi4pziCt5RvTQg
	 lIU4AK5bJCm1Qd6oNT0L8HZi47yw6EyfzTLhaHueP2vHH0RI9FrMJ80St6DcIU0sWC
	 hKE+xMQRocMGe3o5m8Ex+ymerrI/z+1SARbIA7xIel9HzjOa0HSinsvY8Bz3Ye9N1+
	 T4REnRZTotPIL2/E3uYmqXqJwcbQg9/EYp1+pDoUOhGhjXpBcGKVeGb7QAHHr2XPgi
	 w0YV6/fuejIdw==
From: Christian Brauner <brauner@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>
Subject: Re: (subset) [PATCH 4/5] fs/fs_parse: Correct comments of fs_validate_description()
Date: Fri, 11 Apr 2025 16:20:49 +0200
Message-ID: <20250411-rennrad-plural-1fe72c1e43f3@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250410-fix_fs-v1-4-7c14ccc8ebaa@quicinc.com>
References: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com> <20250410-fix_fs-v1-4-7c14ccc8ebaa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=brauner@kernel.org; h=from:subject:message-id; bh=R47KmscxgQp8l9bKGgmTbbSqU0yi0fHEDgacMiINS18=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/VA3cYyqUEnJxMpfJG6mnvJNVKpf5sLC9upizdePcU 7NyVph7dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkmwgjw1HR68dYC/7t2Hox kS95sueTr+usA12/vHJf/fzgxHvl07YxMmxXuPN7m1IVg9+Be/sE1vFszWi/0/PT+okO47t9ovu 9vvIDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 10 Apr 2025 19:45:30 +0800, Zijun Hu wrote:
> For fs_validate_description(), its comments easily mislead reader that
> the function will search array @desc for duplicated entries with name
> specified by parameter @name, but @name is not used for search actually.
> 
> Fix by marking name as owner's name of these parameter specifications.
> 
> 
> [...]

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[4/5] fs/fs_parse: Correct comments of fs_validate_description()
      https://git.kernel.org/vfs/vfs/c/a8fca9b51158

