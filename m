Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEC47705E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 18:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjHDQZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 12:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHDQZV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:25:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D123B2D71;
        Fri,  4 Aug 2023 09:24:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DF98620A2;
        Fri,  4 Aug 2023 16:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7BBC433C8;
        Fri,  4 Aug 2023 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691166298;
        bh=2bO4g+/LC6BUQGYzlZrvEMgihTqm2I8P3Wk2jYORC2U=;
        h=Subject:From:To:Cc:Date:From;
        b=GjNHBOgS6v8Y3FLDRUHx0kqJ9idsqCcF8dLWLtApqT8zkdqOlbAqhHohCd3H1Cayt
         iyrZBjZ6rjmgoDIJmobLBsmnNDXETxwRprE5vA6eCJmiiEWTcaCk5mi54mQhsPFpyr
         Lspobg76Lk8TjiUL7zmDYItd2ZDaAyKox3dSE0qCCSykQuXLGSmaHehgUcHUrwgP1v
         hWrCs+EL1lVflTceBxQRD/sBHVCQTLpWQNJQI84jAd9g+8dP/yy+skQ6vZfs4Os8+S
         tc6UMvY/mRWa+NRj8a6kgcXUFXhYmOVbJAZ2QaBeg1LNzpBljGNySDpZWYk1TbRr7r
         JjD6MZPzIGGJg==
Subject: [PATCHSET v2 0/3] xfs: maintainer transition for 6.6
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Chandan Babu R <chandan.babu@oracle.com>, corbet@lwn.net,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, cem@kernel.org, sandeen@sandeen.net,
        chandan.babu@oracle.com, amir73il@gmail.com,
        leah.rumancik@gmail.com, zlang@kernel.org, fstests@vger.kernel.org,
        willy@infradead.org, shirley.ma@oracle.com, konrad.wilk@oracle.com
Date:   Fri, 04 Aug 2023 09:24:58 -0700
Message-ID: <169116629797.3243794.7024231508559123519.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

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

Comments and questions are, as always, welcome.

--D
---
 Documentation/filesystems/index.rst                |    1 
 .../filesystems/xfs-maintainer-entry-profile.rst   |  194 ++++++++++++++++++++
 .../maintainer/maintainer-entry-profile.rst        |    1 
 MAINTAINERS                                        |    4 
 4 files changed, 199 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/filesystems/xfs-maintainer-entry-profile.rst

