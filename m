Return-Path: <linux-fsdevel+bounces-62997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DC7BA882A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC053A78F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 09:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8D9278150;
	Mon, 29 Sep 2025 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9Awq9J+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757562032D;
	Mon, 29 Sep 2025 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136624; cv=none; b=lma+EWgK5oHFhbnBi1kZY6LD7es1KZOmNlLEkn01O08SQ7rVWbmC9HRSPgymzLdXguEQEuMFQsh3MsmKT8FVkistpRR7E1wyrLecihX0RzuNZ55h8LxdN7zOkxSnGyHt2LtJ7w9pNBevl+wQKkM2Vf+1ufgTVKJJ/04RwhzbacA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136624; c=relaxed/simple;
	bh=UuN1fPZj2OcFpCHFkOKT8ImFk923bB+EJSHcMe6/tDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7+eYV56sViJjAztGq1cqQwEcq69yCteMK7e8+/lf3IOqNh4RiEQfjTAJjf+QUMmMdad67ZpKaqrUGSY+65hlbnZQTMcgUganzpVI2UCG1P/rF6fuLM01iKB4IxfNc9Eul0cn+9WFy0L/7vDXrmRo66ibZS+LfbM9JfzxVn+lP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9Awq9J+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3CCC4CEF4;
	Mon, 29 Sep 2025 09:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759136624;
	bh=UuN1fPZj2OcFpCHFkOKT8ImFk923bB+EJSHcMe6/tDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g9Awq9J+sOFWSAxc7NoDIqwxgfk/zdl2QOsiaT/5mMkrrWTZyKSjxRVLKXHcmTaco
	 vewYxUwOKTDndErf6ZU3xcU79AT1E1EWW7ichaQwjREWMrT5ehr13Wt+yxWwJg00Ca
	 BgTx7GOOXiwBZ6kiqzXcSAstbnNAlIQo6OWEy3+UwkcKamMt34iljhkTD1DWkmaPl0
	 jppZoDP/2ZlR8AZeqCCiP1jf127hfBywWPlPTzW6YNHSIvu5Vmv7wb151kkfOwgQQM
	 CDXE8/T2Fj1J8slJd6diJPi2+Rh1khqvyjkifYRemVCSIWYTwclvt7A+X7g7r0Ethc
	 0myq5UwwdiVDw==
From: Christian Brauner <brauner@kernel.org>
To: zhouyuhang <zhouyuhang1010@163.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhou Yuhang <zhouyuhang@kylinos.cn>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH] fs: update comment in init_file()
Date: Mon, 29 Sep 2025 11:03:33 +0200
Message-ID: <20250929-baucontainer-nordufer-a243076550a2@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250924122139.698134-1-zhouyuhang1010@163.com>
References: <20250924122139.698134-1-zhouyuhang1010@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=922; i=brauner@kernel.org; h=from:subject:message-id; bh=UuN1fPZj2OcFpCHFkOKT8ImFk923bB+EJSHcMe6/tDE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTc8s4+xeE1w8119rH9y+5v//zvcFFF+MHEFIcL7q8kB R5Z/u5r6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI/rkM/6M8FgkemfM16Jm7 7t2nqQKXwsW1fdY+OvnTvuX69jazhfWMDBuunFowS7h/6mJuy3kbRaQCZu142V2vvfKytdDaZ7N 173EDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 24 Sep 2025 20:21:39 +0800, zhouyuhang wrote:
> The f_count member in struct file has been replaced by f_ref,
> so update f_count to f_ref in the comment.
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

[1/1] fs: update comment in init_file()
      https://git.kernel.org/vfs/vfs/c/2915c7c9229a

