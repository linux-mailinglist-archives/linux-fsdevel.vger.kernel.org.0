Return-Path: <linux-fsdevel+bounces-8697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8D683A789
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D6E288A50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504C41AAD7;
	Wed, 24 Jan 2024 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7kXGFFC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620B1AAB1;
	Wed, 24 Jan 2024 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706094744; cv=none; b=iH2twWOUzbwNMiDSVHvlb/mR+o/HxdLmZiPIOW12J/4iLvqWz9nyei5OpsUsS+63qv1InHIahfh4iM9BZ2M/yPdX1Teh94W4bGOyV0izzw6t8as2U4EcmNl9s1aNk7RbYqSDslYg8vZ/iz4KLcoVItMzRDI7MdGJnU+li4WozQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706094744; c=relaxed/simple;
	bh=iLT/bR6Zsyw1fYzc/w5vCqhnKqDhBtU6rUjRHGojV5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJekrEcRVn/8sjM/JiGw/TpQZJqhhI6Gad5FxkT/GE0lLyaeVF4QoSXdU9yF4sUrOaZqL5dYX4CZWWE+PM6YHrYlMuiin1Ui7hU6OqnOrlcqtoyTZ7rcjo8u1DAJ54kJ67EkR5vftryk8Vkozs4qwwjqrlJsdradHsrXVKrEOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7kXGFFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AFCC433F1;
	Wed, 24 Jan 2024 11:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706094744;
	bh=iLT/bR6Zsyw1fYzc/w5vCqhnKqDhBtU6rUjRHGojV5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d7kXGFFCE/exwAXRKyRjBRRsD9xKANci0LbmeCPUbUb42faK2WeOpPl9v63Cx9+gC
	 9oSW4W3gcJovefLd1dtoReKYuMdTwkERLOXOS+GeSCx3ksaR7R45g069oB0YPdI0gr
	 1CBO38Z0m2R9qeDZ9kuV9DDuCgyDgChpIt01UG/ldhgi32YAyBLw7pUF6hbjCZx/tm
	 AV/IAZ1ZDvh/pXz9TKI4qXqRzp3x08JyNgZvWC/o7OzWHf9aT1bc9vxvov0+yyAui7
	 VpQ1rosyYtqeaTYUEhFzBbBzN7xKlqQ4T2igTJdmPs09ZRxI4xxf2OOkBmVfujpTxr
	 n4G8zl16pggeA==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Anton Altaparmakov <anton@tuxera.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH -next] fs: remove NTFS classic from docum. index
Date: Wed, 24 Jan 2024 12:12:09 +0100
Message-ID: <20240124-jemals-bauarbeiten-01fad2b4e889@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124011424.731-1-rdunlap@infradead.org>
References: <20240124011424.731-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=brauner@kernel.org; h=from:subject:message-id; bh=iLT/bR6Zsyw1fYzc/w5vCqhnKqDhBtU6rUjRHGojV5I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRu+NBnFDw9z/f49zWTBWVqFT418t1nkk9/9HXCHYtb2 Y+YOxL3dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEfBHDf7/7zbNOTrkUz7/Y TD9G6MzfEs8FEzk/p35srGV1li3SdmL4p+h+K3JaMrtK7CWWZWl+HdZmUwvXHuaZkXQqTv9j96O rHAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 23 Jan 2024 17:14:24 -0800, Randy Dunlap wrote:
> With the remove of the NTFS classic filesystem, also remove its
> documentation entry from the filesystems index to prevent a
> kernel-doc warning:
> 
> Documentation/filesystems/index.rst:63: WARNING: toctree contains reference to nonexisting document 'filesystems/ntfs'
> 
> 
> [...]

Applied to the vfs.fs branch of the vfs/vfs.git tree.
Patches in the vfs.fs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fs

[1/1] fs: remove NTFS classic from docum. index
      https://git.kernel.org/vfs/vfs/c/06b8db3a7dde

