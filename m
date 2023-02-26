Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3206A6A32CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 17:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBZQ0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 11:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBZQ0u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:26:50 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455961ADC8;
        Sun, 26 Feb 2023 08:26:49 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id 32A648319D;
        Sun, 26 Feb 2023 16:26:44 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677428808;
        bh=2tAMc5XB0hWVuuqg9WjRz7X1K6iS0MIWn8D6zRgfNrc=;
        h=From:To:Cc:Subject:Date:From;
        b=E7+12JpnSYs87yBFIYYdLRvAGvtJO6r1wW9/e+t1QX275pgzdIFuLn7k0bObGvY5X
         VQTDNS0IWP+5NdALfr7xrqGf3HH8IUoM3it4XpPp2x86MZ9jMwCMjIqg/0roAwJwcb
         iclHrcrDA/9sUfF73pPMYj4iTeCVbEaAcCr+pnCrZaoWnREF9br6Q0f0Ds31XI02oL
         xXj069igc8lIN0mpELku1qYpnNJ2szLcgfS9ZwkRavigbOqwJmhavgVRxCyon86Lm3
         pvZ85zsdn1QE+zc9PRDDAuCsCocv4k7A/tqxkJvhuseFTf+ac77PIydc5WZXZxm10q
         dBWnyN6+yV8eg==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [RFC PATCH v1 0/2] Documentation: Introducing `wq_cpu_set` mount option for btrfs
Date:   Sun, 26 Feb 2023 23:26:37 +0700
Message-Id: <20230226162639.20559-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a follow up RFC of this series:
https://lore.kernel.org/linux-btrfs/20230226160259.18354-1-ammarfaizi2@gnuweeb.org

It contains the documentation for the `wq_cpu_set` mount option.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Ammar Faizi (2):
  Documentation: btrfs: Document wq_cpu_set mount option
  Documentation: btrfs: Document the influence of wq_cpu_set to thread_pool option

 Documentation/ch-mount-options.rst | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)


base-commit: 908b4b4450320e30fdef693f09b42f4eb93702c3
-- 
Ammar Faizi

