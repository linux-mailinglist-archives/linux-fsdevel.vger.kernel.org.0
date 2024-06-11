Return-Path: <linux-fsdevel+bounces-21408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B209038E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69017286D27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8440917838E;
	Tue, 11 Jun 2024 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhT9goIF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE77B7407C;
	Tue, 11 Jun 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718101985; cv=none; b=H/MUFWfbfzgveHidbRo5LC8NkJV8U154F5wn/zorC6uk13xn5ItbOQ2oz7mAllWIVyrGEInIFJCI6bSlmw/m3zu57zK+6+WxRPPyIrxJj8yx5pM0GUno28klssl/qjhhg7lx5ZjRMdRCj6MACQdZD9XlmvnHQKxwmIEVVFh2D5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718101985; c=relaxed/simple;
	bh=lrvfIKniuwt3s1ADywu4FCnRzfhRJiawfSEvsfYoqNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FUEtKu/JS6sdblfxXdIfg3k/iqOXCAmzKM6XaFO3bfOr5SMi1Vru+FzQV3iP+5X5++jCYZQwRxEO4MBiLnBxPz8e0F4YC3HEbUef8iArNFS+AYgIOf9DvVnVtVgy6STlPqBdi1I6tmw3BNEov//zQihuSbec+JCh/kcY9OixEl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhT9goIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F1BC2BD10;
	Tue, 11 Jun 2024 10:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718101984;
	bh=lrvfIKniuwt3s1ADywu4FCnRzfhRJiawfSEvsfYoqNo=;
	h=From:To:Cc:Subject:Date:From;
	b=qhT9goIFLHdlmk39v23dRoeA4PxEnVYPzLGKZ+S39jtJoQZAyEa3roOBS+ncAZRX6
	 2D7hDirB2zj6PQYsuyp6HK//PBy2LZVvu9bOgWudKZ+ozqyzQaBHyv/EQLSqYaeu+V
	 3DwmgC8JGkiBUJpDcLV7KrVgMibxAUs1AU30IqsjPm07RlPi5o097ngq2cyXvzyARq
	 /WJPM6mm8acHMYommEnHMUSMEUjMNeM+hdg5ZCeCsPed1JIPxG6P09qnHyjOrHTZ3C
	 IU/eTH7vOUvi+QkRUQTDyN3Rk7ugGkpo2PJ4KN/avgTGNAfedmkQaUhCkxmQRF+xuO
	 hfVP6fpx9AiJA==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: djwong@kernel.org,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,wen.gang.wang@oracle.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to 58f880711f2b
Date: Tue, 11 Jun 2024 16:01:25 +0530
Message-ID: <87h6dzhiqq.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi folks,

The for-next branch of the xfs-linux repository at:

	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the for-next branch is commit:

58f880711f2b xfs: make sure sb_fdblocks is non-negative

1 new commit:

Wengang Wang (1):
      [58f880711f2b] xfs: make sure sb_fdblocks is non-negative

Code Diffstat:

 fs/xfs/libxfs/xfs_sb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

