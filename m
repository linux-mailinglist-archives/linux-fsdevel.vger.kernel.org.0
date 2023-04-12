Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BD96DFEA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 21:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjDLTVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 15:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDLTVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:21:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465E3210A;
        Wed, 12 Apr 2023 12:21:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D555963068;
        Wed, 12 Apr 2023 19:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1024C433EF;
        Wed, 12 Apr 2023 19:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681327282;
        bh=BeZILXjHDRixILpLBlvRCOUKElvCMnHklhMZCB6j8oI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vPxhT9kVFl+JLh0LcfBcfVoeYN493eH2ZjsRFSADdwQunMwv+gAIKNY1dILo3PMJE
         iA/XszQ58PafK5/USWMVLnAGN/S89tWf7bZeYD4rc0anyDK6LROyZ9GsCM2J4wEfv+
         btvPddaVXjgdEpjXFaxKXMc3YYPGgeBNt82hwKm8=
Date:   Wed, 12 Apr 2023 12:21:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Glenn Washburn <development@efficientek.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] scripts/gdb: Create linux/vfs.py for VFS related
 GDB helpers
Message-Id: <20230412122121.79722bca514c454574d11b1b@linux-foundation.org>
In-Reply-To: <7bba4c065a8c2c47f1fc5b03a7278005b04db251.1677631565.git.development@efficientek.com>
References: <cover.1677631565.git.development@efficientek.com>
        <7bba4c065a8c2c47f1fc5b03a7278005b04db251.1677631565.git.development@efficientek.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 28 Feb 2023 18:53:34 -0600 Glenn Washburn <development@efficientek.com> wrote:

> This will allow for more VFS specific GDB helpers to be collected in
> one place. Move utils.dentry_name into the vfs modules. Also a local
> variable in proc.py was changed from vfs to mnt to prevent a naming
> collision with the new vfs module.

checkpatch gets unhappy.   Please add this addition?

--- a/scripts/gdb/linux/proc.py~scripts-gdb-create-linux-vfspy-for-vfs-related-gdb-helpers-fix
+++ a/scripts/gdb/linux/proc.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # gdb helper commands and functions for Linux kernel debugging
 #
_

