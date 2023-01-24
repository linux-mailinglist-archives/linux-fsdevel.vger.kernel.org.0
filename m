Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F09C67A58B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 23:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjAXWTJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 17:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjAXWTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:19:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C960FB47A;
        Tue, 24 Jan 2023 14:19:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60A186134E;
        Tue, 24 Jan 2023 22:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885CEC433EF;
        Tue, 24 Jan 2023 22:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674598745;
        bh=U85zQgZaGptirm1FMFBd9riQ9xroftiQcp0//6ql7pM=;
        h=Date:From:To:Cc:Subject:From;
        b=RJLaBl7HvSbm+MpCR+0mN3BK9lHqfNpQTw8LhfL1+E/zYND/9VH6iOA02F+whWIYT
         MBO+1bzKu/HqapvdzmN/o/Ln0c61wWzjMwcs0hBCjpYZVFEdi0RCglOICthtf56fvx
         gsGAdIaYeglG//fL6OR9ZLiP+CRRvY23GEKvp5OVlQ9K4MpT4du9fNVJSvKLb9QzJT
         xZIO9mbNqRoSwh0ptq2Vu2xwAeb/qC4XIhZca9hDKFGq6g0AcyZ7pM2OuUoZ12ogTt
         ihOYq7FR+sb7apou6uuKQ0aD6B+cxZmj5t7gxDR/cc1Y+8KeT2K3oJUYJe+FG0Q+Gt
         YIyg4+k6E/iwQ==
Date:   Tue, 24 Jan 2023 14:19:03 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     fsverity@lists.linux.dev
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [ANNOUNCE] New mailing list for fsverity development
Message-ID: <Y9BZVw01GbP6T3XY@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

fsverity development (both the kernel part and fsverity-utils) is now using the
mailing list fsverity@lists.linux.dev instead of linux-fscrypt@vger.kernel.org.
linux-fscrypt@vger.kernel.org is now for fscrypt only.

When sending any fsverity-related patches, please always include the new list.

If you're interested, please also subscribe to the new list by sending an email
to fsverity+subscribe@lists.linux.dev.

The new list is being archived at https://lore.kernel.org/fsverity/.

- Eric
