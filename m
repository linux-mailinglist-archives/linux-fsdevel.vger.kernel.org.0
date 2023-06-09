Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B36728E65
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 05:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbjFIDPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 23:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbjFIDPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 23:15:07 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2A63584
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 20:15:06 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3593Ell7024529
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 23:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686280489; bh=eo2h/+7FrLj+iah4+fevq6IpoeMhN5aGJnWzkhXmtp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bkSuwuay2JCjfqnAzgCKCtTSQTsn5YGp4XT2q68E/+KPpb9FLmMbctfK02W6sl7dW
         mySUcPq3mgOjr4Ed3VfDrzKqWwJ8p3XXlJnaWyvD+uOtNOwc8tqa7ID4jC0CT84NnD
         zPZN94wkWO2jv67SDzrmICoUB26l3XcBut5ts0pEOAKoD0YaazZIdoQ2ibtD6fcLGU
         ZPugb+4MULQkakSConX1B2H/mAj7WXyTtnX0GHaYvO2UIpkSY/mexHpnw21CeuAqvs
         zvkBF7e8i+EebVM8UMZh1Ual39goU2+/Vv88nyoWbxfZssUk0BWhr/caN7hjD/jBk4
         ZwGOHAbb4wxLw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CBB5615C02DD; Thu,  8 Jun 2023 23:14:46 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv2 0/5] ext4: misc left over folio changes
Date:   Thu,  8 Jun 2023 23:14:44 -0400
Message-Id: <168628045802.1458216.9443792235653947442.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1684122756.git.ritesh.list@gmail.com>
References: <cover.1684122756.git.ritesh.list@gmail.com>
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


On Mon, 15 May 2023 16:10:39 +0530, Ritesh Harjani (IBM) wrote:
> Please find v2 of the left over folio conversion changes.
> It would be nice if you could also review Patch-2 and Patch-4.
> 
> v1 -> v2
> =========
> 1. Added Patch-2 which removes PAGE_SIZE assumption from mpage_submit_folio.
>    (IMO, this was a missed left over from previous conversion).
> 2. Addressed a small review comment from Matthew in the tracepoint patch to take
>    (inode, folio).
> 3. Added Reviewed-by from Matthew.
> 
> [...]

Applied, thanks!

[1/5] ext4: kill unused function ext4_journalled_write_inline_data
      commit: 40fa8be3852ff7a7b3708c6a69c9eacf98da6612
[2/5] ext4: Remove PAGE_SIZE assumption of folio from mpage_submit_folio
      commit: 732572e95427fe9f68197c60074b750242b84944
[3/5] ext4: Change remaining tracepoints to use folio
      commit: 263619455efcd0deb1f8c24f2895f48751a1d679
[4/5] ext4: Make mpage_journal_page_buffers use folio
      commit: 13004fbc85f58b05cfeb72372b418b6aa1caddc5
[5/5] ext4: Make ext4_write_inline_data_end() use folio
      commit: 04a8b77b66c5bea74b60cc2f5230a851b4ade096
[6/6] ext4: Call fsverity_verify_folio()
      commit: 60469ab9340529a607574a7b6ab6483217607a75

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
