Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E31B4A49A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 15:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbiAaOtO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 09:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiAaOtN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:49:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E135C061714;
        Mon, 31 Jan 2022 06:49:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE5D16134A;
        Mon, 31 Jan 2022 14:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC44C340E8;
        Mon, 31 Jan 2022 14:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643640551;
        bh=vgUzz9ZXBYZNz19Jbhq5UaEVDppAVvry9B8L2Q+oIas=;
        h=From:To:Cc:Subject:Date:From;
        b=NDCq4tSFVnwQ0ytczocKWfLMV5a3nPS4d5YDeQ5wVBwY4snA717XUsHI3cL8FQUjj
         eE/xeCRbaERpsi3W5iIEe2ouZQkHRH0ABWRrA+z+CocaO3t1d6SVwwJ1/MsRYO2FLC
         8Xb/YXga4o+eRNG3TZBt0UbH80S8RzXwlrLB9cE+V6Lb6wnxrWR7Vxjmhg5nnaNE5R
         02vW4A405uqMeI3dUU1FNviVDq76KoPYLSBnZCZOfBj7hBIFbmTXykbe1Z74vaaxEx
         AYD5XIvyJjgOe0omWYNomc3MdMZnqaCyNew00NLeshrJ5eF4fvw9OU+UY9rehr7ylq
         Xcii/rTs2bFig==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH] mailmap: update Christian Brauner's email address
Date:   Mon, 31 Jan 2022 15:48:54 +0100
Message-Id: <20220131144854.2771101-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231; h=from:subject; bh=NjgwCcDsABoj/09GZt1opN6dqFRdnLCCIwxdloAdZ3k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR+/9bf6sE49eaT029aDVcua6/+u+6++cwsti0vVzHcWy13 Y/HtyR2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATcSpl+B/7glFH9gMb8x3Jlv3akY c2vU+ZEMzWHxAi7Fic4nrRt4eR4fO+GPHzCi8yQ9KPuJWu3yX3a0IPv1Sywo57IWbtV2b7cAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At least one of the addresses will stop functioning after February.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Hey Linus,

I need to update my mail addresses. A pull-request doesn't seem
warranted for this. Would you please apply this directly? It doesn't
contain any functional changes.

Thanks!
Christian

 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index b76e520809d0..8cd44b0c6579 100644
--- a/.mailmap
+++ b/.mailmap
@@ -80,6 +80,9 @@ Chris Chiu <chris.chiu@canonical.com> <chiu@endlessos.org>
 Christian Borntraeger <borntraeger@linux.ibm.com> <borntraeger@de.ibm.com>
 Christian Borntraeger <borntraeger@linux.ibm.com> <cborntra@de.ibm.com>
 Christian Borntraeger <borntraeger@linux.ibm.com> <borntrae@de.ibm.com>
+Christian Brauner <brauner@kernel.org> <christian@brauner.io>
+Christian Brauner <brauner@kernel.org> <christian.brauner@canonical.com>
+Christian Brauner <brauner@kernel.org> <christian.brauner@ubuntu.com>
 Christophe Ricard <christophe.ricard@gmail.com>
 Christoph Hellwig <hch@lst.de>
 Colin Ian King <colin.king@intel.com> <colin.king@canonical.com>

base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
-- 
2.32.0

