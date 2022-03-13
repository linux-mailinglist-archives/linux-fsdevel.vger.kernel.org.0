Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9E54D7279
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Mar 2022 05:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiCMErA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 23:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbiCMEq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 23:46:59 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1814B60AAA;
        Sat, 12 Mar 2022 20:45:53 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22D4jkTd009268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 23:45:46 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0658415C3E9A; Sat, 12 Mar 2022 23:45:46 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH 1/2] ext4: Make mb_optimize_scan option work with set/unset mount cmd
Date:   Sat, 12 Mar 2022 23:45:40 -0500
Message-Id: <164714672856.1260831.15800873658441936379.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <c98970fe99f26718586d02e942f293300fb48ef3.1646732698.git.ojaswin@linux.ibm.com>
References: <c98970fe99f26718586d02e942f293300fb48ef3.1646732698.git.ojaswin@linux.ibm.com>
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

On Tue, 8 Mar 2022 15:22:00 +0530, Ojaswin Mujoo wrote:
> After moving to the new mount API, mb_optimize_scan mount option
> handling was not working as expected due to the parsed value always
> being overwritten by default. Refactor and fix this to the expected
> behavior described below:
> 
> *  mb_optimize_scan=1 - On
> *  mb_optimize_scan=0 - Off
> *  mb_optimize_scan not passed - On if no. of BGs > threshold else off
> *  Remounts retain previous value unless we explicitly pass the option
>    with a new value
> 
> [...]

Applied, thanks!

[1/2] ext4: Make mb_optimize_scan option work with set/unset mount cmd
      commit: 27b38686a3bb601db48901dbc4e2fc5d77ffa2c1
[2/2] ext4: Make mb_optimize_scan performance mount option work with extents
      commit: 077d0c2c78df6f7260cdd015a991327efa44d8ad

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
