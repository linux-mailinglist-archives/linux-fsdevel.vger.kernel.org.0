Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AB774C64A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jul 2023 17:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjGIPoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 11:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjGIPoN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:44:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019C091;
        Sun,  9 Jul 2023 08:44:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8084B60BA4;
        Sun,  9 Jul 2023 15:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD22BC433C8;
        Sun,  9 Jul 2023 15:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688917451;
        bh=4h80vCBurAiKJXTF3TYJdODLah3UvovPi2KN9nRuC2Q=;
        h=Date:From:To:Cc:Subject:From;
        b=YZxjhApdJlb1srdswwhBtJSJJf7LKE/NBW+ewZ174dqMssqbUa3uomY/z2EZ4jTrl
         xSoWrj69A4nLD6HLg8v4Yla18QPYiDL/U6kWGyNZuLtKe0F47amnCwrMQsYAGu7bhp
         OQLdm0HuKb1z9IumH0kwDxO86Vp3GQ1YVwpKxbhk/Znn4gPBvJLksEp1NTevFrhiaX
         Y5Frc1XDuFptXCoD5p3Pnk2+N5wmD2bNQ3jwRMBE0Hu9RyFG84aMhVgBg+pN03jXrq
         xo2zdz9CH87CTJDzxYQEBLTBaAiBsZizKnvfVtpsC3j4JOFq0RUpcYAR5ZyUedaLG7
         5E8n3D+mDiGeg==
Date:   Sun, 9 Jul 2023 08:44:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, torvalds@linux-foundation.org
Cc:     dchinner@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: more new code for 6.5
Message-ID: <168891728293.3329585.14912305268240705363.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch with one last change for xfs for 6.5-rc1.
Nothing exciting here, just getting rid of a gcc warning that I got
tired of seeing when I turn on gcov.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit 34acceaa8818a0ff4943ec5f2f8831cfa9d3fe7e:

xfs: Remove unneeded semicolon (2023-07-03 09:48:18 -0700)

are available in the Git repository at:

git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.5-merge-6

for you to fetch changes up to ed04a91f718e6e1ab82d47a22b26e4b50c1666f6:

xfs: fix uninit warning in xfs_growfs_data (2023-07-07 20:13:41 -0700)

----------------------------------------------------------------
Minor cleanups for 6.5:

* Fix an uninitialized variable warning.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (1):
xfs: fix uninit warning in xfs_growfs_data

fs/xfs/xfs_fsops.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)
