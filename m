Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AC04CB3EE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 02:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiCCAmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 19:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiCCAmW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:42:22 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21DC2018A;
        Wed,  2 Mar 2022 16:41:37 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2230fTBg019238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Mar 2022 19:41:30 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A194615C3444; Wed,  2 Mar 2022 19:41:29 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCHv2 0/9] ext4: fast_commit fixes, stricter block checking & cleanups
Date:   Wed,  2 Mar 2022 19:41:25 -0500
Message-Id: <164626805478.621144.4983790124922912795.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1644992609.git.riteshh@linux.ibm.com>
References: <cover.1644992609.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 16 Feb 2022 12:32:42 +0530, Ritesh Harjani wrote:
> Please find the v2 of this patch series which addresses the review comments from
> Jan on PATCH-2 & PATCH-7. No changes other than that.
> 
> Summary
> ========
> This patch series aimes at fixing some of the issues identified in fast_commit
> with flex_bg. This also adds some stricter checking of blocks to be freed in
> ext4_mb_clear_bb(), ext4_group_add_blocks() & ext4_mb_mark_bb()
> 
> [...]

Applied, thanks!

[1/9] ext4: Correct cluster len and clusters changed accounting in ext4_mb_mark_bb
      commit: a5c0e2fdf7cea535ba03259894dc184e5a4c2800
[2/9] ext4: Fixes ext4_mb_mark_bb() with flex_bg with fast_commit
      commit: bfdc502a4a4c058bf4cbb1df0c297761d528f54d
[3/9] ext4: Refactor ext4_free_blocks() to pull out ext4_mb_clear_bb()
      commit: 8ac3939db99f99667b8eb670cf4baf292896e72d
[4/9] ext4: Use in_range() for range checking in ext4_fc_replay_check_excluded
      commit: dbaafbadc5c3dad4010099d0ff135204a8dbff49
[5/9] ext4: Rename ext4_set_bits to mb_set_bits
      commit: 123e3016ee9b3674a819537bc4c3174e25cd48fc
[6/9] ext4: No need to test for block bitmap bits in ext4_mb_mark_bb()
      commit: bd8247eee1a2b22e2270b3933ab8dca9316b3718
[7/9] ext4: Add ext4_sb_block_valid() refactored out of ext4_inode_block_valid()
      commit: 6bc6c2bdf1baca6522b8d9ba976257d722423085
[8/9] ext4: Add strict range checks while freeing blocks
      commit: a00b482b82fb098956a5bed22bd7873e56f152f1
[9/9] ext4: Add extra check in ext4_mb_mark_bb() to prevent against possible corruption
      commit: 8c91c57907d3ad8f88a12097213bb0920eb453b8

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
