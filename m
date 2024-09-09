Return-Path: <linux-fsdevel+bounces-28923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2648D971055
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 09:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60D11F22D86
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 07:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13661B1424;
	Mon,  9 Sep 2024 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThRjNgdf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0875A1AF4DC;
	Mon,  9 Sep 2024 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868368; cv=none; b=baHKIOYopIogjQASMFZSJA5q3bfdiRt5/qmN9FLifDgNi0H5NIvOPZGX150r4LwLZtHbGjWJJocePPG24J6coyTLsNEfrPEQxq8TP9oiR/Dnqc09UBXWSjbKa3vJyQPyxqQKxffZ6XJY+WFRKlhD10SoRl9HweA3wCbKZ0nGdG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868368; c=relaxed/simple;
	bh=qOaesh/TAKQrrzKDplHaxB6/8unPc3QHMjB/XOYRlec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBUOj1c2Vp1qmzxHoLe3N58p9Ir4WBt0M1wjaR9y7scQYZQx+J3Citmq0DGoTdVDdgI8zm0npaUAqYUpAKiW3Uu3WGC00ZTWsAYmdZJjOHqllBxot3QirBE/ifEyIHHEmm8EaO4erm5kbpJYkyWLsUDrI4ODhjAjKDekFtQWN+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThRjNgdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9F2C4CEC5;
	Mon,  9 Sep 2024 07:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725868367;
	bh=qOaesh/TAKQrrzKDplHaxB6/8unPc3QHMjB/XOYRlec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ThRjNgdfZsk/SqlPY4+gtwcBYkOWhvLjzicDqHP+hacZRi3wO6DkW1Bd5bCMwEfCz
	 zl0Ukc4YGvII7kh871XU8j2OBKF6oPzYacXr23mXrp6g60PoYisGsmcd3dcx9QlTxy
	 qZO7BFhr7p+ExjOOh/6xRBHT7eYbN6sFKow+Kcdbo4xqW3xu1VMiciWFZg2bwgIBjw
	 8IkJ6c7mosalkDKHmdZGQ3ox2w3yWseHaN+2jf5bxysoyYJUUgpYh6i8aBKOLss7kJ
	 Afpm61Z65OGWvb5WUF9Bn6RzE91tDcnvWJIeQzl5kK2eC0sncyoSWq50NBxkcBkJmk
	 0PjoqB/TRx4nQ==
From: Christian Brauner <brauner@kernel.org>
To: Dennis Lam <dennis.lamerice@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dhowells@redhat.com,
	jlayton@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH] docs:filesystems: fix spelling and grammar mistakes on netfs library page
Date: Mon,  9 Sep 2024 09:52:33 +0200
Message-ID: <20240909-bebte-sonst-e4939ee628df@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240908192307.20733-3-dennis.lamerice@gmail.com>
References: <20240908192307.20733-3-dennis.lamerice@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=849; i=brauner@kernel.org; h=from:subject:message-id; bh=qOaesh/TAKQrrzKDplHaxB6/8unPc3QHMjB/XOYRlec=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdW+m+9s36Gd5hDvM32Ezes1pbk/Py1yi3vgMWWiu4Q 2f0b7Ob2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRWdMY/oc1yvLvr4lOYjDk 0jd9kXDl6Tvu1qvuqT7TJv8VPFy6IJnhr9Brx93r6s/HFLcuCDu/re9nhErV3OPmMu9fefxOcdD s5gcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 08 Sep 2024 15:23:09 -0400, Dennis Lam wrote:
> 


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

[1/1] docs:filesystems: fix spelling and grammar mistakes on netfs library page
      https://git.kernel.org/vfs/vfs/c/8bec52672c67

