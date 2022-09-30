Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE885F09E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 13:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiI3LTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 07:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiI3LTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:19:07 -0400
X-Greylist: delayed 607 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Sep 2022 04:06:46 PDT
Received: from 2.mo575.mail-out.ovh.net (2.mo575.mail-out.ovh.net [46.105.52.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8573C1EAB
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 04:06:46 -0700 (PDT)
Received: from player157.ha.ovh.net (unknown [10.109.143.3])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 8DDCA23DD9
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 10:30:14 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player157.ha.ovh.net (Postfix) with ESMTPSA id DA51A2F30295C;
        Fri, 30 Sep 2022 10:30:09 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-104R0052101a6af-e51e-47df-a03f-556930440260,
                    C05B2F2BD13FA39C9993548B485976379164E02D) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 0/5] Update the sysctl/fs documentation
Date:   Fri, 30 Sep 2022 12:29:32 +0200
Message-Id: <20220930102937.135841-1-steve@sk2.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14210545676090574470
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehvddgvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepleegteeujeffjeefjeevhfdtudefjefgteelgedtudekleeiledvvdetudevjedtnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrudehjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejhe
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series updates the sysctl/fs in line with similar changes
made previously to sysctl/kernel and sysctl/abi:

* add an automatically-generated table of contents,
* order the entries alphabetically,
* use consistent markup.

In addition, obsolete entries are removed, and the two aio sections
are merged.

Changes since v2:
* added a cover letter
* request review from linux-fsdevel
* fix the link to core_pattern

Stephen Kitt (5):
  docs: sysctl/fs: remove references to inode-max
  docs: sysctl/fs: remove references to dquot-max/-nr
  docs: sysctl/fs: merge the aio sections
  docs: sysctl/fs: remove references to super-max/-nr
  docs: sysctl/fs: re-order, prettify

 Documentation/admin-guide/sysctl/fs.rst     | 240 ++++++++------------
 Documentation/admin-guide/sysctl/kernel.rst |   2 +
 2 files changed, 97 insertions(+), 145 deletions(-)


base-commit: c3e0e1e23c70455916ff3472072437b3605c6cfe
-- 
2.31.1

