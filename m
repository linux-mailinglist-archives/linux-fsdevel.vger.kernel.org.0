Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB017BA7D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 19:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjJERW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 13:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjJERWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:22:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3467761AD;
        Thu,  5 Oct 2023 10:16:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0947C433C7;
        Thu,  5 Oct 2023 17:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696526205;
        bh=pLHbeWhsfwlJ5/x1swB6Yv/HiN8U84OvZpLA4UH5gL4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=CCKDMscXyGvRBu00YDj4wKqY98iYotFhNfioOSwnrcc4LE37cEg2PaK3Es0U0DWFI
         o3f0fhOseQRv2DfIpo3euVH3JqQXMd44JBquAQiS3OTgzeF9NKcHOsM1H6D/lTwvzp
         SCNlVjk7pnIgAyVDop0UmbCe6TO3MUsFxRa/X1X7vLkhHNZW1ECUaYW+599Hgluu9s
         UMrmOMZmCe4q8jErl6PDGcm3vWSA7WGYo72f6alIxP34i9egLyKlimdeoD6XPK1aFl
         mUHusFziobWms5dLAlYV8Q3DXpQ9r+OOsgs1nNdbZRk3X8y9yX4Z35RcBcxLwN81yE
         9uRxHPxTdmlXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 529E3CE0869; Thu,  5 Oct 2023 10:16:45 -0700 (PDT)
Date:   Thu, 5 Oct 2023 10:16:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH bootconfig 0/3] Expose boot-loader kernel command-line
 arguments
Message-ID: <6ea609a4-12e3-4266-8816-b9fca1f1f21c@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

This series contains bootconfig updates that make the kernel command-line
arguments that came from the bootloader (excluding those from bootconfig)
visible as a comment in the existing /proc/bootconfig file.  It also
updates documentation.

1.	Update /proc/cmdline documentation to include boot config.

2.	fs/proc: Add boot loader arguments as comment to /proc/bootconfig.

3.	Add /proc/bootconfig to proc.rst.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/filesystems/proc.rst   |    5 +++++
 b/Documentation/filesystems/proc.rst |    3 ++-
 b/fs/proc/bootconfig.c               |    6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)
