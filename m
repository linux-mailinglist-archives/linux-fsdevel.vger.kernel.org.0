Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5F06A32D3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 17:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjBZQ1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 11:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBZQ1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:27:00 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C9D1ADDC;
        Sun, 26 Feb 2023 08:26:57 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id D8F7F8319D;
        Sun, 26 Feb 2023 16:26:53 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677428817;
        bh=a4DJSHEBNpCHZMkW0VGKhaz/c5vRBlHibuGW/RG0Z0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UObI9LD2OmfFvyNxz1ZD3hoPDd+2RTOTgHbcsum87bh86LeOxf6LGw0lDV4USONap
         TlWHethmu0+KoGBntSf8f6FSPMJVcuvjPsYfYiOuBNMODN+0oT4TFsWwjngixkMni4
         T7fWKLmsUmXsRm5zTgwaZymYVCYQoXGp1AkwwRz4vKdwhhWwWfn96Yv+cwSodqsxZQ
         8RbWfvp4Pb7QdpEVa2REXi2qc2EaZ+7ThwB3QowsBQVeyebxQ5gFwX3wXz0nWRVVtd
         Zq9CRo4g5MCiZ3Tu2k175wyNwmxx5lnyJpg4eV6zF6N4Hcvoobx0zevPeMMuAluPa8
         bEYqZlIQejVqQ==
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
Subject: [RFC PATCH v1 2/2] Documentation: btrfs: Document the influence of wq_cpu_set to thread_pool option
Date:   Sun, 26 Feb 2023 23:26:39 +0700
Message-Id: <20230226162639.20559-3-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226162639.20559-1-ammarfaizi2@gnuweeb.org>
References: <20230226162639.20559-1-ammarfaizi2@gnuweeb.org>
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

If wq_cpu_set option is set, the default thread_pool value will be
adjusted accordingly.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 Documentation/ch-mount-options.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/ch-mount-options.rst b/Documentation/ch-mount-options.rst
index 48fe63ee5e95c297..c38caf5e5fd0b719 100644
--- a/Documentation/ch-mount-options.rst
+++ b/Documentation/ch-mount-options.rst
@@ -411,6 +411,9 @@ thread_pool=<number>
         due to increased locking contention, process scheduling, cache-line bouncing or
         costly data transfers between local CPU memories.
 
+        Since 6.5, if *wq_cpu_set* is set, the default value will be the number of
+        online CPUs in the CPU wq_cpu_set plus 2.
+
 treelog, notreelog
         (default: on)
 
-- 
Ammar Faizi

