Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760CD777C2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 17:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbjHJP2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 11:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjHJP2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:28:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5CE212B;
        Thu, 10 Aug 2023 08:28:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A483866022;
        Thu, 10 Aug 2023 15:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCD4C433C8;
        Thu, 10 Aug 2023 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691681309;
        bh=kTbq/0/6yOK0gnFzVi50l4An8RgulDpk4leGz1t6WIU=;
        h=Date:From:To:Cc:Subject:From;
        b=uFZIysE9ys6mAR/q21+X8cpBHSqICG9uIJ/cO0aHW4gVVdrE6niuL+MVser2dGLT3
         sURHdctnQFq8YW4K7+SNLKNvDjvhhVtf9lszwtZwfQCV+tQ+7IAGcdUXe2vGgjznk5
         8z7qGXgJGFx/fcTajeBc2HhfCkj0HT7kxTUsm4jc4Hn0+nNzDsJBwWyx/w8Zui/hSK
         kxv37z9+veY8gpaTBL7aj59TQ1pyUWrJr0AbXIxOj8wstdGH1QhrFJ3IbmlXBsypIP
         XMUXDevMC+y+VTHJDWhE7uNNyR+a+IB4tKO+sWixn14NwjO3TroVtewbfG30cxF2JQ
         mAcpg8CXiXW0Q==
Date:   Thu, 10 Aug 2023 08:28:28 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     chandan.babu@oracle.com, djwong@kernel.org
Cc:     amir73il@gmail.com, cem@kernel.org, corbet@lwn.net,
        david@fromorbit.com, fstests@vger.kernel.org,
        konrad.wilk@oracle.com, leah.rumancik@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        sandeen@sandeen.net, shirley.ma@oracle.com, willy@infradead.org,
        zlang@kernel.org
Subject: [GIT PULL 1/9] xfs: maintainer transition for 6.6
Message-ID: <169168055240.1060601.8588880532893202137.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chandan,

Please pull this branch with changes for xfs for 6.6-rc1.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit 52a93d39b17dc7eb98b6aa3edb93943248e03b2f:

Linux 6.5-rc5 (2023-08-06 15:07:51 -0700)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git tags/maintainer-transition-6.6_2023-08-10

for you to fetch changes up to d6532904a10290b94d2375ff438313e0fb9fc9f8:

MAINTAINERS: add Chandan Babu as XFS release manager (2023-08-10 07:47:54 -0700)

----------------------------------------------------------------
xfs: maintainer transition for 6.6 [v3]

I do not choose to continue as maintainer.

My final act as maintainer is to write down every thing that I've been
doing as maintainer for the past six years.  There are too many demands
placed on the maintainer, and the only way to fix this is to delegate
the responsibilities.  I also wrote down my impressions of the unwritten
rules about how to contribute to XFS.

The patchset concludes with my nomination for a new release manager to
keep things running in the interim.  Testing and triage; community
management; and LTS maintenance are all open positions.

I'm /continuing/ as a senior developer and reviewer for XFS.  I expect
to continue participating in interlock calls, LSFMM, etc.

v2: clarify release manager role, amend some factual errors, add some
acks and reviews.
v3: add more review tags.

With a bit of luck, this should all go splendidly.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (3):
docs: add maintainer entry profile for XFS
MAINTAINERS: drop me as XFS maintainer
MAINTAINERS: add Chandan Babu as XFS release manager

Documentation/filesystems/index.rst                |   1 +
.../filesystems/xfs-maintainer-entry-profile.rst   | 194 +++++++++++++++++++++
.../maintainer/maintainer-entry-profile.rst        |   1 +
MAINTAINERS                                        |   4 +-
4 files changed, 199 insertions(+), 1 deletion(-)
create mode 100644 Documentation/filesystems/xfs-maintainer-entry-profile.rst
