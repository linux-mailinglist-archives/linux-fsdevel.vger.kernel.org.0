Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949E15F3BC2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 05:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJDDpS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 23:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJDDpB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 23:45:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0DB11C36;
        Mon,  3 Oct 2022 20:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 989D0B818EA;
        Tue,  4 Oct 2022 03:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5ECE5C433D7;
        Tue,  4 Oct 2022 03:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664855093;
        bh=QXEoLo1dKWbjRA3Zt6TXmiZvUSJjyNbwwOlKDlL1NAs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gWveEPYzx5AH+T1YmlA4iOwhhrea6wFD5bVYGBs1il6oYjkJ4bivt+5qY5sYi8hg6
         8IMzvdujb+Z3atrRc0rjQn8yScBSUXJDYb6VBspkMNns+rurWIEI4aV2KGzRsrzNby
         zNslCoPpfkkvURRdX7x+WaHPZI4CEJxj9kSUBxpXh6pHA8cZFoDjVawUAFfTHajOd3
         8ghbr/pXYQPRRmhLwUYm7igpANf0DG30ZLXZah3FDSx4hJTj6g82UpAIiSXbO5z3B2
         KyQ9BrawmXWNu16KqBBwVkiLF6DRXCwa1sN6KQSdsM71hNEyYE0OLuhDD4lvcXS+Io
         qyZTK0tnCGoJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44292C072E7;
        Tue,  4 Oct 2022 03:44:53 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt updates for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzpQMx1FiZp/PsM3@quark>
References: <YzpQMx1FiZp/PsM3@quark>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzpQMx1FiZp/PsM3@quark>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 0e91fc1e0f5c70ce575451103ec66c2ec21f1a6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 438b2cdd17a6c9df607f574bd13b6b637795a411
Message-Id: <166485509327.18435.1743382934950044503.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 03:44:53 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 2 Oct 2022 20:00:03 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/438b2cdd17a6c9df607f574bd13b6b637795a411

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
