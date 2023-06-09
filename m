Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7419C728E66
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 05:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbjFIDPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 23:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbjFIDPK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 23:15:10 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA89430E8
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 20:15:06 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3593ElI1024536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 23:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686280489; bh=ZbkQv99SKWdS1oKE/cmlbVEVCgfWmkP7O/305UFGCCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gf9UOpPE3OfousdpIh1t5J7FhOjFpyymp1L2s+YrXEB49Ww2h1wfPjzA+PzvRBxfY
         WDv+WyKgTHLRYaH5hny+lJc4/MqtsU5PcG30/tXtRYel5wKIIOUyIcT7t5d+vJji4M
         qaW8nVE4sqEy5mpxf7RcSy5C6EEMLXqAeLInAGlO1YiZGyk4mYmlpHLhpP96QKmwI3
         gTWP8ZFn69CyZAJ/MWR0HI+uAguAc1aitt5OL4IkhD3uh4b1dkhNNeit8OuLoQ+JHB
         k2NoM4lRg35Hk5TOZstDc+U0MMQ2+368TzSe9Emy7ElPucMumHXKISclNow5DpwxGa
         5gTg6/I/ZA+DQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C9FAE15C02DC; Thu,  8 Jun 2023 23:14:46 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Kemeng Shi <shikemeng@huaweicloud.com>
Subject: Re: [PATCH v2 00/12] multiblock allocator improvements
Date:   Thu,  8 Jun 2023 23:14:43 -0400
Message-Id: <168628045803.1458216.14609598386869495524.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1685449706.git.ojaswin@linux.ibm.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Tue, 30 May 2023 18:03:38 +0530, Ojaswin Mujoo wrote:
> ** Changed since v1 [2] **
> 
>  1. Rebase over Kemeng's recent mballoc patchset [3]
>  2. Picked up Kemeng's RVB on patch 1/12
> 
>  [2] https://lore.kernel.org/all/cover.1685009579.git.ojaswin@linux.ibm.com/
>  [3] https://lore.kernel.org/all/20230417110617.2664129-1-shikemeng@huaweicloud.com/
> 
> [...]

Applied, thanks!

[01/12] Revert "ext4: remove ac->ac_found > sbi->s_mb_min_to_scan dead check in ext4_mb_check_limits"
        commit: 3582e74599d376bc18cae123045cd295360d885b
[02/12] ext4: mballoc: Remove useless setting of ac_criteria
        commit: fb665804fd62e600b5c2350ea69295261ce8374d
[03/12] ext4: Remove unused extern variables declaration
        commit: 3086ed54c0e65c60b0fb142e181e7dd4e3b7b1e0
[04/12] ext4: Convert mballoc cr (criteria) to enum
        commit: eb7d4a8b9510887fb690a6b912d80cb0bce21387
[05/12] ext4: Add per CR extent scanned counter
        commit: 9e97d81a1fa105b80583b5152e4b9cb794734585
[06/12] ext4: Add counter to track successful allocation of goal length
        commit: af97bca67ff63191d44023f895b6033eb7d3423a
[07/12] ext4: Avoid scanning smaller extents in BG during CR1
        commit: caf886aecd608a8ef05ab10957cf4b9fd9564712
[08/12] ext4: Don't skip prefetching BLOCK_UNINIT groups
        commit: bf912c937ed41c4581d77806b003f22625eee0b5
[09/12] ext4: Ensure ext4_mb_prefetch_fini() is called for all prefetched BGs
        commit: 64f6fb876cedc30fc1430b96eb442bd84bc61459
[10/12] ext4: Abstract out logic to search average fragment list
        commit: 1918cdc99d125c275dcdd4527520c78bb1a3c1ef
[11/12] ext4: Add allocation criteria 1.5 (CR1_5)
        commit: 7b748ea2a6ad2bda304553b5cf8745f542af6b34
[12/12] ext4: Give symbolic names to mballoc criterias
        commit: c9f19daa1824a73218526650a9aade17536527c8

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
