Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2EB4CC0EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 16:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbiCCPPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 10:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbiCCPPK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:15:10 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132C8434B5;
        Thu,  3 Mar 2022 07:14:24 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 223FEGWJ016304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Mar 2022 10:14:16 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0BD5115C33A4; Thu,  3 Mar 2022 10:14:16 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHv2 0/1] ext4: Performance scalability improvement with fast_commit
Date:   Thu,  3 Mar 2022 10:14:10 -0500
Message-Id: <164632037181.689479.4209078980224071211.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1645426817.git.riteshh@linux.ibm.com>
References: <cover.1645426817.git.riteshh@linux.ibm.com>
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

On Mon, 21 Feb 2022 13:26:14 +0530, Ritesh Harjani wrote:
> Please find the v2 of this patchset after addressing review comments from
> Harshad.
> 
> [RFC/v1]: https://lore.kernel.org/all/cover.1644809996.git.riteshh@linux.ibm.com/
> 
> xfstests results(v2)
> =====================
> This has survived my fstests testing with -g 'auto' group for ext4_4k_fc & ext4_4k
> configs with CONFIG_KASAN enabled. I haven't found any regression due to this
> patch in my testing.
> 
> [...]

Applied, thanks!

[1/1] ext4: Improve fast_commit performance and scalability
      commit: b3998b3bc658017dc36c69a8224fb11a3d1b1382

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
