Return-Path: <linux-fsdevel+bounces-15883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35715895677
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 16:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29BE282FCF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 14:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F89186252;
	Tue,  2 Apr 2024 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGYp88ID"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9CD85645;
	Tue,  2 Apr 2024 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067502; cv=none; b=qBxzqUuEyAxUHy0mexgZEHkSaaUsMWLu3Nm/W1A3LHs6x2Um5zEBvhNoWCl2iwICOHCOSyj0gttaHW2jwUQq+heUvXI1WlxgdDENgV3HHokvsuq05XWpXAH8nqExVC4N9AkvhdDkvADw14xnPzq9Z0Dy30NXc1SAgFfVNj/LGhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067502; c=relaxed/simple;
	bh=IKwOzi4XPnp6NLIGpRnX0tc9DQM+jGCSNsnAqQxjKIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b6kag6gI+zOeTnCevi/Z3u5VWLwxMT9UDcD9kKSlDJZuPI3n1OHgMCWxW3wXmtHjrUlSscL8ITL/wT7NkZsie+1LhbEy9WUE7jgHLFS6v915T4iorux4WrF/o4oIyBshTWWL7ZbN0HWG5zlYsDudedhktX6TB6UIrFrDe3s84uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGYp88ID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FD1C43390;
	Tue,  2 Apr 2024 14:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712067502;
	bh=IKwOzi4XPnp6NLIGpRnX0tc9DQM+jGCSNsnAqQxjKIs=;
	h=From:To:Cc:Subject:Date:From;
	b=pGYp88ID55Z1329wk+UJPfqm3vr/GbyjVESqsiM3YpZ54aqNTcmWf7oQQPALT2pS6
	 pGaZHijFFuTu7LLSyNLZK2ZDI55QSbsijb7sc9nKTKk6r5bTZk2ZKNbDSGZlnBmeYS
	 Gy3TEPP02GRobYK9HoXJgRoaFZLXcy/Flok+E3Q2UJL2ThpEp1SyjrglXtg7584xdN
	 jDkreQcGdFOpm1bIpdunAYPmDudfVfKXiJOEZtdSZnz7yLQnyf0xixfaEmD9NUiHQo
	 iyLHnnu+RWTcSFXHA89oX5AGKOGREuWHWkObp8RffuDD7vl/o206PfTdxwGm5YIKBK
	 goOlk0stmL7lQ==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: aalbersh@redhat.com,djwong@kernel.org,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to e23d7e82b707
Date: Tue, 02 Apr 2024 19:47:19 +0530
Message-ID: <87o7arzw44.fsf@debian-BULLSEYE-live-builder-AMD64>
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

e23d7e82b707 xfs: allow cross-linking special files without project quota

1 new commit:

Andrey Albershteyn (1):
      [e23d7e82b707] xfs: allow cross-linking special files without project quota

Code Diffstat:

 fs/xfs/xfs_inode.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

-- 
Chandan

