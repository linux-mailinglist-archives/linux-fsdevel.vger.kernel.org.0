Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AB55F27C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 05:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiJCDCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Oct 2022 23:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJCDCm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Oct 2022 23:02:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75DA3CBE9;
        Sun,  2 Oct 2022 20:02:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CEAF60F27;
        Mon,  3 Oct 2022 03:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D61C433C1;
        Mon,  3 Oct 2022 03:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664766160;
        bh=4oTPdlsFic2JzzzlNV4McuRuTc1WiO0qzEF5F4QHh3Q=;
        h=Date:From:To:Cc:Subject:From;
        b=VIyEKxqZpQXIbZfsIflfPfFRzFMfXKRtGymV3KuzbJXR/xa8climUq/oAZcLv49Zb
         BoroHVsuHe8KMQ3o8ASSWKVUOnKwkJe64wySkBUNfsC3DVZqL2hI6vRhhsRHfmMVol
         Ekc+CWqFYbw8co7E/D0Y2gLohMj1GeOLBb6M/spQUHI3IZVSHtHouWe85snBW2eYCA
         1mYWlWb9kWvI4aoy7zYjeRGsC/WPfi16mzSfKsb4qs4HsqD7LXHfAM5SFKya4esPZ2
         sFIT8hvmLqoKMlpXp8smi41cPtTEbAf+Q4YGjA+qjBZtl0rrMTIPOBVjdMXeOkQ6aS
         uixcimICyeNBg==
Date:   Sun, 2 Oct 2022 20:02:38 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] fsverity updates for 6.1
Message-ID: <YzpQziDjTaZADriK@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

for you to fetch changes up to 8377e8a24bba1ae73b3869bc71ee9df16b6bef61:

  fs-verity: use kmap_local_page() instead of kmap() (2022-08-19 15:19:55 -0700)

----------------------------------------------------------------

Minor changes to convert uses of kmap() to kmap_local_page().

----------------------------------------------------------------
Eric Biggers (2):
      fs-verity: use memcpy_from_page()
      fs-verity: use kmap_local_page() instead of kmap()

 fs/verity/read_metadata.c |  6 +++---
 fs/verity/verify.c        | 14 ++------------
 2 files changed, 5 insertions(+), 15 deletions(-)
