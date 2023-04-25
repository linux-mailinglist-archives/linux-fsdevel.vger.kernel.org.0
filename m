Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035366EDA51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 04:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjDYCtz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 22:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjDYCtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 22:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112C2AD2A;
        Mon, 24 Apr 2023 19:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A023962B08;
        Tue, 25 Apr 2023 02:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 162E8C433EF;
        Tue, 25 Apr 2023 02:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682390974;
        bh=+F/hHmZI68KWC0nBJbpb8/D0r7bUZPrIZ6MipNMLAhY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dmmtRC0bB6F6KbVAPnGEjDRE/HtAtGNlKm647bPB/kHISFgi9TkcKNBf7sfFGyW+T
         6lMH7WiTcE13Sv883ivPCb71ehWCejO8kdRvt9VdFAqJ64RdnaKzYw4swvjwH4vOxv
         PhNZ4NOOS0BIJ3tnS5Jr/OeZxGdHQAlnU/F+kjBDscULkmFTKimWsdMr/cjNgKBOBC
         eA0ug+EXqgZcmHL7Plv1AE2ggAUliPGBUEcPCaHE4E07F8kZKQxxQHzGZQvU+N7ISB
         gsfucDYL0Ppx7TZeFXFau6RXufjndPeX9pn8b0v21bf9Z1RwBArJAgnppfLdiDkVLK
         HFP3O4kEpLo1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0000DE5FFC9;
        Tue, 25 Apr 2023 02:49:33 +0000 (UTC)
Subject: Re: [git pull] the rest of write_one_page() series
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424042638.GJ3390869@ZenIV>
References: <20230424042638.GJ3390869@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424042638.GJ3390869@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-write-one-page
X-PR-Tracked-Commit-Id: 2d683175827171c982f91996fdbef4f3fd8b1b01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e497ad5255069b2d394168568790d26bbc8d365
Message-Id: <168239097399.20647.11578576352902189759.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 02:49:33 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 05:26:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-write-one-page

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e497ad5255069b2d394168568790d26bbc8d365

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
