Return-Path: <linux-fsdevel+bounces-20112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3A08CE5CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 15:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF6F7B21587
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 13:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E3D86AE9;
	Fri, 24 May 2024 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkoCgBf6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71EBEC7;
	Fri, 24 May 2024 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716556427; cv=none; b=Tv6JeTmRzahyG/AAUWj+O3AitTuE9YULZ2+o1NXqOH7GDiHCOb+7BM9N/J2+mv0GtmWpls3YvvD7vWvJodOsYHJtbHCnLCbPWzZSGF46eiuNO0u6X6z3u2ZBlG0POo8qQiyOenvOVtylhWYZwYho3DFIFNEJG7gUxyRqV16tKjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716556427; c=relaxed/simple;
	bh=EgJoULYOyxzhhdtzFidW6m36/bKB1NZw7wt9pFBAf9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFDztdmIzC4e7QXT29XYluDiF/9APpr3FVLkuKu6XSNNS48MobcayFGsusK+TYab52Y1XE6vIg4XtCMySRCOAz9aZapLqXKBI51XgEo2a08CFk7uWo8+89xIOdWt7GNsjMdmbwgEcXZU2PaJkt0RkzHpxyMFL6uyPHy5ujQXzNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkoCgBf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C17C2BBFC;
	Fri, 24 May 2024 13:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716556426;
	bh=EgJoULYOyxzhhdtzFidW6m36/bKB1NZw7wt9pFBAf9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nkoCgBf6E/Ff8JWaB3ZzIIIaubhrG96JCTpJpGS3zIHbNt5hEXnSff9hZJsOZ9qla
	 4cJHkwDNOcnJkbqXzHORHsoyNpgneiFDt2nbZuCRBEx2TZKj0Vd7Er3Azv4UrpXL+U
	 ch/pO/B2jeoWQCkrpeZw30nJxYcM1+H7LB4Nq9bLBlDszXnhEFUCSRz5cEo4kbXhcb
	 ShOPmjwmZrzccrS/1KPuaEhQM1fum5Dmy7nb6rEWFJXLyjP+BSDZoffbYapnWuslKh
	 2vmGfwnwQpXdi/97Bih1cor8LRlatmrgtMEZgQTkXopLdhYr2RRZ3IDPlqeJUyc9As
	 fCFy7XURF7ujg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs/adfs: add MODULE_DESCRIPTION
Date: Fri, 24 May 2024 15:13:04 +0200
Message-ID: <20240524-zumal-butterbrot-015b2a21efd5@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523-md-adfs-v1-1-364268e38370@quicinc.com>
References: <20240523-md-adfs-v1-1-364268e38370@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=930; i=brauner@kernel.org; h=from:subject:message-id; bh=EgJoULYOyxzhhdtzFidW6m36/bKB1NZw7wt9pFBAf9s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQFTGqR+3zgZMO3qL7Ow/7WDrGBp3/6tVxIu/HRXaBcz mDvIXWGjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImc9WNkeBx6yksj/4XXf55b x3gLkw2zXFvMsxn2MB1rvjFLJHpHPcM/gxdz+nIfPOlPanoRxir1bWFxxtpiy4+304JavtVmBL5 kAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 23 May 2024 06:58:01 -0700, Jeff Johnson wrote:
> Fix the 'make W=1' issue:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/adfs/adfs.o
> 
> 

Sure, why not.

---

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

[1/1] fs/adfs: add MODULE_DESCRIPTION
      https://git.kernel.org/vfs/vfs/c/5b50aef089d0

