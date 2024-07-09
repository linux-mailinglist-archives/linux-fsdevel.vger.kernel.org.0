Return-Path: <linux-fsdevel+bounces-23415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A03C492C183
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 19:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A09E1F237F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8CC1ACE77;
	Tue,  9 Jul 2024 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ywLRd9ti"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F791AC42B;
	Tue,  9 Jul 2024 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542560; cv=none; b=rcfI/bmrRJzfKxh3ydGZ5KzS6ExklqJpErc9uU2pbWDmPKhk7dBU34IzOBydzMFDxNF/zGQp5vZ1DIz9dDLudTox+YABX7PA5e8u4o0MsZOlZ1wVvFE6ojse24Gbfow7ySiSFYECSYRAdpytprzeuHwjoNElhv51zoGQeip4u7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542560; c=relaxed/simple;
	bh=ao5OgCKTmWGOeQIyqG5Xq2Q5h8oVpW7lbNX6sg3ahiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDtbfLgTVJbss6LpjXnvrYhGEiLhZqWAJQjL+Z8R1y6RzpB8Lfk6DV/8rPOZXW5LnUJJJMghrhb2jPq9i6uGAXpeHvkpyNVNN34dX6T956r8Zcij1xvhe+2ous1EXO+I2ui9ACmIkoD6wl4EBaos6YNEqlkuRcpQpHoFNAUnGWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ywLRd9ti; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WJRJm2fVFz9sZq;
	Tue,  9 Jul 2024 18:29:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1720542552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hMN5EYeTIpPEIty7JnyHmAV09HNDOPhhuiUc4fcA8Kg=;
	b=ywLRd9tisZo5XSSl4UArOgl3V9/+GSA2V7Qm1iabardoueztN4qHS1RNkBAHDtSTCijfWz
	HNOXXh/PSOqAJ/GyZHhf1VtCjsd3KSyV71nNJQv/k1NX980gReU+YRx+X+gXWBQsRugO2x
	fGK1q1NAMxWolVCYJlY9BmkO0C9T4x+fcr2DrkFhkei8a8nsy2h92ICViJbGrWdcy34+eL
	P/LjWTzvBOsBwSwGFx+LfeyU/Ls3CzY9dfyNEdbJY7Zu5AInhjON7kL9rduwrfEnZaxggV
	4mKliB31DWgpZwPzUhdvaHlzfX24RMs0Tb8Kg7Dz+IXo/AYPSsZ82l3GfKaZ4A==
Date: Tue, 9 Jul 2024 16:29:07 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com, willy@infradead.org, ryan.roberts@arm.com,
	djwong@kernel.org
Cc: linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>,
	akpm@linux-foundation.org, chandan.babu@oracle.com
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <20240709162907.gsd5nf33teoss5ir@quentin>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625114420.719014-2-kernel@pankajraghav.com>
X-Rspamd-Queue-Id: 4WJRJm2fVFz9sZq

For now, this is the only patch that is blocking for the next version.

Based on the discussion, is the following logical @ryan, @dave and
@willy?

- We give explicit VM_WARN_ONCE if we try to set folio order range if
  the THP is disabled, min and max is greater than MAX_PAGECACHE_ORDER.

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 14e1415f7dcf4..313c9fad61859 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -394,13 +394,24 @@ static inline void mapping_set_folio_order_range(struct address_space *mapping,
                                                 unsigned int min,
                                                 unsigned int max)
 {
-       if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+       if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+               VM_WARN_ONCE(1, 
+       "THP needs to be enabled to support mapping folio order range");
                return;
+       }
 
-       if (min > MAX_PAGECACHE_ORDER)
+       if (min > MAX_PAGECACHE_ORDER) {
+               VM_WARN_ONCE(1, 
+       "min order > MAX_PAGECACHE_ORDER. Setting min_order to MAX_PAGECACHE_ORDER");
                min = MAX_PAGECACHE_ORDER;
-       if (max > MAX_PAGECACHE_ORDER)
+       }
+
+       if (max > MAX_PAGECACHE_ORDER) {
+               VM_WARN_ONCE(1, 
+       "max order > MAX_PAGECACHE_ORDER. Setting max_order to MAX_PAGECACHE_ORDER");
                max = MAX_PAGECACHE_ORDER;
+       }
+
        if (max < min)
                max = min;

- We make THP an explicit dependency for XFS:

diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
index d41edd30388b7..be2c1c0e9fe8b 100644
--- a/fs/xfs/Kconfig
+++ b/fs/xfs/Kconfig
@@ -5,6 +5,7 @@ config XFS_FS
        select EXPORTFS
        select LIBCRC32C
        select FS_IOMAP
+       select TRANSPARENT_HUGEPAGE
        help
          XFS is a high performance journaling filesystem which originated
          on the SGI IRIX platform.  It is completely multi-threaded, can

OR

We create a helper in page cache that FSs can use to check if a specific
order can be supported at mount time:

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 14e1415f7dcf..9be775ef11a5 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -374,6 +374,14 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 #define MAX_XAS_ORDER          (XA_CHUNK_SHIFT * 2 - 1)
 #define MAX_PAGECACHE_ORDER    min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACHE_ORDER)
 
+
+static inline unsigned int mapping_max_folio_order_supported()
+{
+    if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+      return 0;
+    return MAX_PAGECACHE_ORDER;
+}
+


diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b8a93a8f35cac..e2be8743c2c20 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1647,6 +1647,15 @@ xfs_fs_fill_super(
                        goto out_free_sb;
                }
 
+               if (mp->m_sb.sb_blocklog - PAGE_SHIFT >
+                   mapping_max_folio_order_supported()) {
+                       xfs_warn(mp,
+"Block Size (%d bytes) is not supported. Check MAX_PAGECACHE_ORDER",
+                       mp->m_sb.sb_blocksize);
+                       error = -ENOSYS;
+                       goto out_free_sb;
+               }
+
                xfs_warn(mp,
 "EXPERIMENTAL: V5 Filesystem with Large Block Size (%d bytes) enabled.",
                        mp->m_sb.sb_blocksize);


--
Pankaj

