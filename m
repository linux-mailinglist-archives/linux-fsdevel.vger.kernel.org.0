Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF574CB419
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 02:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiCCAm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 19:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiCCAmW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:42:22 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB6B33EBB;
        Wed,  2 Mar 2022 16:41:38 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2230fT8a019240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Mar 2022 19:41:30 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A35AA15C3448; Wed,  2 Mar 2022 19:41:29 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCHv2 REBASED 0/2] jbd2: Kill t_handle_lock transaction spinlock
Date:   Wed,  2 Mar 2022 19:41:26 -0500
Message-Id: <164626805478.621144.16176363008693188429.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1644992076.git.riteshh@linux.ibm.com>
References: <cover.1644992076.git.riteshh@linux.ibm.com>
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

On Wed, 16 Feb 2022 12:30:34 +0530, Ritesh Harjani wrote:
> This is mainly just rebasing the patch series on top of recent use-after-free
> fix submitted [4], due to conflict in function jbd2_journal_wait_updates().
> No other changes apart from that.
> 
> 
> Testing
> ========
> I have again tested xfstests with -g log,metadata,auto group with 4k bs
> config (COFIG_KASAN disabled). I haven't found any regression due to these
> patches in my testing.
> 
> [...]

Applied, thanks!

[1/2] jbd2: Kill t_handle_lock transaction spinlock
      commit: f7f497cb702462e8505ff3d8d4e7722ad95626a1
[2/2] jbd2: Remove CONFIG_JBD2_DEBUG to update t_max_wait
      commit: 2d4429205882817100e5e88870ce0663d30c77af

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
