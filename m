Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9782526A86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 21:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383894AbiEMTiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 15:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383871AbiEMTim (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 15:38:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815F9712ED;
        Fri, 13 May 2022 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=7AQ1tnmhdj6GIYIC2jyaasQB2WbOtM0epCQajREwxjk=; b=SCCmofz3S3HUQcBWMURDzrOQWY
        GByb02Xi3RCgjqfZC/HDw6IJuRFVfxzvoLe2RTYOI9S6uknoOv/r8y5/nCeDTV/jDFdYo4ieAOxGn
        ikha2qhXoeDeMmlI0DvnatYzcang7YQcyWbeVWIDfDv6iiyFXZrmP0UzLYgPbBh9QM2Z4TOoIJYXK
        /cShfIxHCHcsjreGCVX0yJM/tpEowzBD3ifmSg7pL4FDPCBj4c0MINTOTXl3ees1VngzhXWlBrOan
        uHFZrzAL7/hZYI0W4PjY6QjsMwK+BdEIEfMOLBIU4GLQQM3XGuvf+fkH5z2vSleSb539JAy7Sbqyu
        VXXoX4+w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npb7T-00HM1v-Cn; Fri, 13 May 2022 19:38:35 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     patches@lists.linux.dev, amir73il@gmail.com, pankydev8@gmail.com,
        tytso@mit.edu, josef@toxicpanda.com, jmeneghi@redhat.com,
        jake@lwn.net, mcgrof@kernel.org
Subject: [PATCH 0/4] kdevops: use linux-kdevops for the main tree
Date:   Fri, 13 May 2022 12:38:27 -0700
Message-Id: <20220513193831.4136212-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

More just like a heads up as to the next steps from discussions at
LSFMM with regards to kdevops. Those using kdevops in some environemnts
will want to read the last commit.

This work starts off by making the linux-kdevops organization the default
for the source of commits for the kdevops projects. We can now share
efforts, and commits. The last commit will contain more details as
to the motivation for this.

Luis Chamberlain (4):
  workflows/Kconfig: be consistent when enabling fstests or blktests
  kdevops: move generic kdevops variables to its own file
  playbooks: add a common playbook a git reset task for kdevops
  kdevops: make linux-kdevops the default tree

 kconfigs/workflows/Kconfig               |  6 ++++
 kconfigs/workflows/Kconfig.shared        |  2 +-
 playbooks/common.yml                     |  4 +++
 playbooks/roles/common/README.md         | 38 ++++++++++++++++++++
 playbooks/roles/common/defaults/main.yml |  7 ++++
 playbooks/roles/common/tasks/main.yml    | 23 ++++++++++++
 workflows/Makefile                       | 33 +----------------
 workflows/common/Makefile                | 46 ++++++++++++++++++++++++
 8 files changed, 126 insertions(+), 33 deletions(-)
 create mode 100644 playbooks/common.yml
 create mode 100644 playbooks/roles/common/README.md
 create mode 100644 playbooks/roles/common/defaults/main.yml
 create mode 100644 playbooks/roles/common/tasks/main.yml
 create mode 100644 workflows/common/Makefile

-- 
2.35.1

