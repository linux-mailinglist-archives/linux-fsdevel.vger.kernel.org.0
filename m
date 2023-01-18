Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3759671FA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 15:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjAROeW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 09:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjAROdv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:33:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587A947EC4;
        Wed, 18 Jan 2023 06:22:28 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3CCB35BF6C;
        Wed, 18 Jan 2023 14:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674051747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Jcvj5AuIWP9Pb77zhjsuy7TzYwBrXQiPoMee0HPJxts=;
        b=CsrbCjbTet6gaNQrGpoaGz/IEtIro4VUp3Tm0t/1pnCljnZcHFfpKeHMof9r4HGbDzZqmY
        YFUBW3geSLzV9SRvpmlGjf+4M4NXV5Q2LhmxHOUv7/b5vpPo7OmZm0MCaWG38S/VJso7Jk
        tfVX2DFFeNza6/S0Sn06q/z+fS3slhk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 336D52C141;
        Wed, 18 Jan 2023 14:22:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D4828DA7FB; Wed, 18 Jan 2023 15:16:49 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] AFFS fix for 6.2
Date:   Wed, 18 Jan 2023 15:16:49 +0100
Message-Id: <cover.1674051240.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

there's one minor fix for a KCSAN report. Please pull, thanks.

----------------------------------------------------------------
The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git affs-for-6.2-tag

for you to fetch changes up to eef034ac6690118c88f357b00e2b3239c9d8575d:

  affs: initialize fsdata in affs_truncate() (2023-01-10 14:55:20 +0100)

----------------------------------------------------------------
Alexander Potapenko (1):
      affs: initialize fsdata in affs_truncate()

 fs/affs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
