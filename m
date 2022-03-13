Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1664D7274
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Mar 2022 05:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiCMErA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 23:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiCMEq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 23:46:59 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0623A606F0;
        Sat, 12 Mar 2022 20:45:52 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22D4jkP7009262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 23:45:46 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0829A15C3E9B; Sat, 12 Mar 2022 23:45:46 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHv3 00/10] ext4: Improve FC trace events
Date:   Sat, 12 Mar 2022 23:45:41 -0500
Message-Id: <164714672856.1260831.16671323737369796834.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1647057583.git.riteshh@linux.ibm.com>
References: <cover.1647057583.git.riteshh@linux.ibm.com>
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

On Sat, 12 Mar 2022 11:09:45 +0530, Ritesh Harjani wrote:
> Please find the v3 of this patch series. I have included Reviewed-by tag
> on all patches, except in [5-7] which were later added to address review
> comments from Jan [1].
> 
> Changes since v2
> ================
> v2 -> v3
> 1. Defined TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX) in [Patch 02/10]
> 
> [...]

Applied, thanks!

[01/10] ext4: Remove unused enum EXT4_FC_COMMIT_FAILED
        commit: c864ccd182d6ff2730a0f5b636c6b7c48f6f4f7f
[02/10] ext4: Fix ext4_fc_stats trace point
        commit: 7af1974af0a9ba8a8ed2e3e947d87dd4d9a78d27
[03/10] ext4: Convert ext4_fc_track_dentry type events to use event class
        commit: 8cb5a30372ef5cf2b1d258fce1711d80f834740a
[04/10] ext4: Do not call FC trace event in ext4_fc_commit() if FS does not support FC
        commit: 7f142440847480838e0c4b3092f24455cec111a7
[05/10] ext4: Return early for non-eligible fast_commit track events
        commit: 9d5623d7ef8765f21f629e4ac636c19ec245e254
[06/10] ext4: Add new trace event in ext4_fc_cleanup
        commit: 810e6a2b0cc2394947aa72c5bd47b4ba3cc538d1
[07/10] ext4: Add transaction tid info in fc_track events
        commit: 9f7165eeb47e71e539f258cc8105f909074a2b87
[08/10] ext4: Add commit_tid info in jbd debug log
        commit: 20bc9c03722db8bfa82506056b1b54b481beea72
[09/10] ext4: Add commit tid info in ext4_fc_commit_start/stop trace events
        commit: d0852d55b0ca3dc1573df46874b847b72dfbe70a
[10/10] ext4: Fix remaining two trace events to use same printk convention
        commit: 6a5fb2ca06cfec5159457283cdd92ce42d68137d

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
