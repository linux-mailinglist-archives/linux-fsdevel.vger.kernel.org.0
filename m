Return-Path: <linux-fsdevel+bounces-16418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6843589D4EF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 10:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964C71C22B66
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 08:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FCE7E101;
	Tue,  9 Apr 2024 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsuLeeur"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DD31EA90
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652938; cv=none; b=cPTonmmXB7GkzK8PrIGmpw5EyvzkdBmISzA1Vg/doohqg4ud0t5Bjz79MMyj0oQXJDx2HLKuxp7dCT2/cNM0GO/GTiCEfSaRugv5i1jiIAiykzYPPb7ptbqJa/S+VsegwrpHF9Zslh3cuUXVYdoDqdfRTZVfkgaQxtFpP3Wf0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652938; c=relaxed/simple;
	bh=y88eDLYxHlqQNrP/mv1UnOOxxfwRSQXRnNQ17NRMlOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtWQ+IDdjNgZvbRem+KjskQP9EDPTJhYzRLCybWeQq/ZX8Uhzocd3MR0j8UOVtW213vXEoOpiFb8Cxv0W2czwOowCblD3I1UMiSb6rq70dDTtDpecGm4n7xQCOBTwQo0VaBwBCEOhetkyyVQShZUEYTGpCar04IiwvfqNr37gtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsuLeeur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3523EC433F1;
	Tue,  9 Apr 2024 08:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712652937;
	bh=y88eDLYxHlqQNrP/mv1UnOOxxfwRSQXRnNQ17NRMlOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NsuLeeurlonox3OZSAUI1tThnCygLF+M630JeFRnsxNg9+rj7fHlrV76lfflgv8sL
	 h602hBbssCnUZHIAbfCseCZ82qKC7tqh7a3rhDw+bY+edEfEreND1ukIcosJvSYDEP
	 LdRRx3hUbbK97eJXipEd6JlQK1Tn2VZPrZ7U9tbwlTqIZLARq/JxkXylgN8AO6W1WP
	 O6eNKlqsG2eo3kEHewl3p+DXbXV4J4Pm77RSL0WS3RVUY60w9H9+2F/EkHyLgZsC2q
	 ZZcyfoulzsuie2JbmcS1e9cHX0nRqJTteK0osQ98Z2I0qpHPQfzf+17YMl6OeqBICE
	 el9/io+RhaStg==
From: Christian Brauner <brauner@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Add FOP_HUGE_PAGES
Date: Tue,  9 Apr 2024 10:55:21 +0200
Message-ID: <20240409-formt-quast-a4d97d82ddbb@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407201122.3783877-1-willy@infradead.org>
References: <20240407201122.3783877-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1055; i=brauner@kernel.org; h=from:subject:message-id; bh=y88eDLYxHlqQNrP/mv1UnOOxxfwRSQXRnNQ17NRMlOU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSJMlX5qBm+m8Bin791Rz7Dd68PZjMfZYpt0/q11ptB8 s/6uImZHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5HsrI8LNS93VDe/LcBI2u Q8EXE7+1d91hZjtj2h3M/m3q9WcakxkZpuYeL9xqnL9UKEdw3/XHKxkdE/V677BlSb47en9tVr0 YJwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 07 Apr 2024 21:11:20 +0100, Matthew Wilcox (Oracle) wrote:
> Instead of checking for specific file_operations, add a bit to
> file_operations which denotes a file that only contain hugetlb pages.
> This lets us make hugetlbfs_file_operations static, and removes
> is_file_shm_hugepages() completely.
> 
> 

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

[1/1] fs: Add FOP_HUGE_PAGES
      https://git.kernel.org/vfs/vfs/c/886b94d25a8e

