Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8BC485DDE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 02:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344128AbiAFBMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 20:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344096AbiAFBMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 20:12:15 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6BDC061201;
        Wed,  5 Jan 2022 17:12:14 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id CC801248F; Wed,  5 Jan 2022 20:12:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CC801248F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641431533;
        bh=TSlykzUMYWv2QCxvNxSGxUgIECE7tfhTqGvl3R+8WFk=;
        h=Date:To:Cc:Subject:From:From;
        b=tXesJvWoggr1LpZrgJDy1bkKtsd4vD8D46oHY9D+/chS3EvbfHl990qa5F6n5HjwC
         r1zJ7w5/6zjQbMxct9QmvkkfbJCUlOZKLDdMwqKmC3noMSEBRtYKEDXyc3bpVADEuk
         QB1gcS/m4IVUVxFUsuzSKjpSwPrQD+lCNCftvDjA=
Date:   Wed, 5 Jan 2022 20:12:13 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: remove bfields
Message-ID: <20220106011213.GB30947@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

I'm cutting back on my responsibilities.  The NFS server and file
locking code are in good hands.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

I'm leaving Red Hat at the end of the month, and expecting to cut back
on upstream efforts as well.

I don't expect to disappear completely, though, and will still be
reachable at bfields@fieldses.org.

Thanks to everyone for an interesting twenty years!

diff --git a/MAINTAINERS b/MAINTAINERS
index fb18ce7168aa..8ee4e623b6f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7334,7 +7334,6 @@ F:	include/uapi/scsi/fc/
 
 FILE LOCKING (flock() and fcntl()/lockf())
 M:	Jeff Layton <jlayton@kernel.org>
-M:	"J. Bruce Fields" <bfields@fieldses.org>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	fs/fcntl.c
@@ -10330,12 +10329,11 @@ S:	Odd Fixes
 W:	http://kernelnewbies.org/KernelJanitors
 
 KERNEL NFSD, SUNRPC, AND LOCKD SERVERS
-M:	"J. Bruce Fields" <bfields@fieldses.org>
 M:	Chuck Lever <chuck.lever@oracle.com>
 L:	linux-nfs@vger.kernel.org
 S:	Supported
 W:	http://nfs.sourceforge.net/
-T:	git git://linux-nfs.org/~bfields/linux.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
 F:	fs/lockd/
 F:	fs/nfs_common/
 F:	fs/nfsd/
-- 
2.33.1

