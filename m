Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FAF64A441
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 16:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiLLPhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 10:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiLLPg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:36:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50211BC88;
        Mon, 12 Dec 2022 07:36:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7EB86112C;
        Mon, 12 Dec 2022 15:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21986C433D2;
        Mon, 12 Dec 2022 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670859416;
        bh=od2TMT/vaFw2wdDOF/gVdOoT/7b4vq6h1uWX9f9jJjg=;
        h=Date:From:To:Cc:Subject:From;
        b=UfYkprtQjRNu1in+fV8pmRLpfkJQn3UPv/+PogRYMpFPEooWNWnisCZsV3Zqn1kny
         ltkF9z6oHyK9sodWH7BgGcfoc/XsQalBX5bdHmY9xXZ/XyfA6h93G2FtDyD7UMGhpi
         NErl81WctQOYFaQrfCFhR+NcvG374uAv0GOOAvR7ZseNau+T+3FaBjrEDdFpaT1a6G
         9WzjQ08We3oGfv9Xj1fwVUwneNmlHGNd/Sf1yUNlegjyNVTovYqam4dYgMOoeGINAM
         UztMTPpzIuf3LbsIO1fV1ZuSdvjTDtA1gL4se0pOhuwt4G4xl5StCApbTx68V+KcLm
         U4C5/C/uIH3cA==
Date:   Mon, 12 Dec 2022 09:36:55 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] enable squashfs idmapped mounts for v6.2
Message-ID: <Y5dKl5Ksx0iyiJSY@do-x1extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

/* Summary */
This is a simple patch to enable idmapped mounts for squashfs. All
functionality squashfs needs to support idmapped mounts is already
implemented in generic VFS code, so all that is needed is to set
FS_ALLOW_IDMAP in fs_flags.

/* Testing */
The patch is based off of 6.1-rc1 and has been sitting in linux-next. No
build failures or warnings were observed and fstests, selftests, and LTP
show no regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next. A test merge with current mainline also showed no conflicts.

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.idmapped.squashfs.v6.2

for you to fetch changes up to 42da66ac7bcb19181385e851094ceedfe7c81984:

  squashfs: enable idmapped mounts (2022-11-07 10:24:22 +0100)

Please consider pulling these changes from the signed
fs.idmapped.squashfs.v6.2 tag.

Thanks!
Seth

----------------------------------------------------------------
fs.idmapped.squashfs.v6.2

----------------------------------------------------------------
Michael Weiß (1):
      squashfs: enable idmapped mounts

 fs/squashfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
