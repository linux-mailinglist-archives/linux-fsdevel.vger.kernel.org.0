Return-Path: <linux-fsdevel+bounces-5977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 788DE811907
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 17:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968A2281CDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2398633CC8;
	Wed, 13 Dec 2023 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="V19QhVTb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ED51A6;
	Wed, 13 Dec 2023 08:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=7rWy5XWiTjoPkItro/VsBDG3wudUvVA8NmkBjomTzUo=; b=V19QhVTb4gkpH0c2lEIwOexRUj
	xhX+kvCWGy0PXcN4Dwth1YJLz7RI8Qi8p7/JI8TK86K4RI9Oh4eJOh9B6yCzGyjlWvTKOWoWROejm
	AxxnRSmxRYzczuK9w5lzQDvetEAou5Z8g9h98/S+9DiyPkdxITE4wmY5tvZ7uOtB/8Jx5v6NNXOBk
	hzgawRnGXb2yO78IMF7JLh+b4KJw2DSy4CtGpzzp7abt3E2UkpOHe9S5YSyaXgfEAcIaPDUPDYoN1
	FSEb020DrmfIO14SxJZosxzwmJY4shaWkNHSKSjXweRryxKJOHakOJ60vdvJ+zckZlBCU+z7Y224C
	NkIiXEeg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDRwn-00Bpq0-0A;
	Wed, 13 Dec 2023 16:18:57 +0000
Date: Wed, 13 Dec 2023 16:18:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] ufs fix
Message-ID: <20231213161857.GN1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 485053bb81c81a122edd982b263277e65d7485c5:

  fix ufs_get_locked_folio() breakage (2023-12-13 11:14:09 -0500)

----------------------------------------------------------------
ufs got broken this merge window on folio conversion - calling
conventions for filemap_lock_folio() are not the same as for
find_lock_page()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      fix ufs_get_locked_folio() breakage

 fs/ufs/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

