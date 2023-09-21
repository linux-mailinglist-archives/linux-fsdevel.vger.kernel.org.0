Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C97D7A974C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 19:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjIURW0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 13:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIURWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:22:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E587044F54;
        Thu, 21 Sep 2023 10:13:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0250CC433C8;
        Thu, 21 Sep 2023 05:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695273992;
        bh=oQgXqRH4TbGWpJlUvoHBdjoOwt4zOqrdiEDUsYfuq1w=;
        h=Date:From:To:Cc:Subject:From;
        b=P9StZuXWWGikAH2n3LYkf2kpB7puiZHevN4RXgHSDWRyPTcbIrZ5d2DR7S/8a6ITb
         wtv7Vz96XoiuYQQqeJoc1/YtUu4346DAy6UubmLxiYTG4AYkcxV7mTMFsCPDu42f8X
         o7zJAJKehS+AgLxwfcks70JskoulkHIPihWjAkXkLBdQUh+El5/kA56IJZqKHuFIl4
         WQu5jDGporNJyIuO2yTrBTDlMMPAhjbRox8SUfK0EH9NOvIf4o64qECcWLJqniFFNI
         xHDbxcE7K5xG00JgAo/gFrp7EKKCBUEVUPCak+nFALPZWm3bW0W5vMp0iQIit9/v5R
         1Z4aQTjsFYoOA==
Date:   Thu, 21 Sep 2023 13:26:25 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] erofs-utils: release 1.7
Message-ID: <ZQvUAd8r50cTK+s5@hsiangkao-PC>
Mail-Followup-To: linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

After almost another 6 months, a new version of erofs-utils 1.7 is
available at:
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git tags/v1.7

It mainly includes the following changes:
  - support arbitrary valid block sizes in addition to page size;
  - (mkfs.erofs) arrange on-disk meta with Breadth-First Traversal instead;
  - support long xattr name prefixes (Jingbo Xu);
  - support UUID functionality without libuuid (Norbert Lange);
  - (mkfs.erofs, experimental) add DEFLATE algorithm support;
  - (mkfs.erofs, experimental) support building images directly from tarballs;
  - (dump.erofs) print more superblock fields (Guo Xuenan);
  - (mkfs.erofs, experimental) introduce preliminary rebuild mode (Jingbo Xu);
  - various bugfixes and cleanups (Sandeep Dhavale, Guo Xuenan, Yue Hu,
          Weizhao Ouyang, Kelvin Zhang, Noboru Asai, Yifan Zhao and Li Yiyan);

In brief, this version supports tarerofs, DEFLATE algorithm, and new
on-disk features to help the Composefs model.

In the next erofs-utils versions, we are going to improve mkfs
performance by supporting multi-threaded reproducible builds and
optimizing data deduplication & metadata flushing speed.  In addition,
other enhancements like erofsfuse improvements [1], hardware accelerator
and preliminary Zstd algorithm support are on the way too.

Comments, questions are welcome as always, yet time is still needed for
them to be landed (EROFS upstream development is a little part of our
kernel jobs).  It's always worth trying, and any contribution is much
appreciated.

Thanks,
Gao Xiang

[1] https://lore.kernel.org/r/20230918090306.2524624-1-lyy0627@sjtu.edu.cn
