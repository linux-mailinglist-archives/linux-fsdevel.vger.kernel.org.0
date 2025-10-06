Return-Path: <linux-fsdevel+bounces-63452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5417BBCFE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 04:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B08B3B4224
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 02:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892ED1B0439;
	Mon,  6 Oct 2025 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsLJ1T8c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10DCDDA9
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 02:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759718508; cv=none; b=CSPRxmYAECL/fyCjdnrFoJebbztRO6YjOSxC4JADMjyCHS974Fhm2pUMWDjOwslNqUDMz4q0lJvxZNDXNqQN0HCMYHczxjDqhEXe5YMtZpgMsFKVvBqyfmvC1VTBmAJGGeTR5nkoQCJl8ag8tex8/44ElNEv2JDvWHen+i272wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759718508; c=relaxed/simple;
	bh=IJSpVqrvl5CK2Cs8i1exg8H0kWy0Sk4olWWcTsZCNCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P2kwCE5FfhU9pLsx9XmDDZ+N9m7G4DVuMUvmquFji/BkwiTEAFQN5CsDUNsictA/fKHxEgd5gEUI8v36alTQFY5ml4nDYGCT0va+KZI6ZxyDOJrsNCQ5ohln5YBtp8dwOkD9fzB2+pmRcPBJmiz8FJPCzs7kCJjHkHo+fBbyeN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsLJ1T8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E809CC4CEF4;
	Mon,  6 Oct 2025 02:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759718507;
	bh=IJSpVqrvl5CK2Cs8i1exg8H0kWy0Sk4olWWcTsZCNCA=;
	h=From:To:Cc:Subject:Date:From;
	b=CsLJ1T8cwSRD9Vc1cnzDMRZaof18r9ImqsF+hhbCNuea0k7i3jAqic1ZRtfUgkdb8
	 M0RvtoKqxJu2Wa1JQE2TlChfND62a8zH5xrh3LPdYF0tOCCtztqyzyiHqWaPQPwpD1
	 F/ISnFOmRtxLj286gwDxeaDnonO1V4PFtlt8zntUO0nf2/EnioS+oZBHhapCcqQ3aM
	 tZXMud7fpj0LHU+bINU28JYffxfefu9eyI66DrvxBvmzfd1BY0RvX5AMAb7CTfFw4Q
	 pLTdlSZipctgl9IxQL3QfpnpkvFssoRLQnk9Uh3I/eQabquH1lb1uHYcMDfmxM1fKt
	 FEyF7s2IURumQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs changes for 6.18-rc1
Date: Mon,  6 Oct 2025 11:38:26 +0900
Message-ID: <20251006023826.272105-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.18-rc1

for you to fetch changes up to a42938e80357a13f8b8592111e63f2e33a919863:

  zonefs: correct some spelling mistakes (2025-08-12 11:59:27 +0900)

----------------------------------------------------------------
zonefs changes for 6.18

 - Some comment spelling fixes (Xichao)

----------------------------------------------------------------
Xichao Zhao (1):
      zonefs: correct some spelling mistakes

 fs/zonefs/file.c  | 2 +-
 fs/zonefs/super.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

