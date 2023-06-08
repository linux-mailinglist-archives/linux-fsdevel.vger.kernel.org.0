Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F255E72803D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 14:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbjFHMlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 08:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbjFHMl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:41:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E7D26B3
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 05:41:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57F9364D2E
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 12:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6B9C433D2;
        Thu,  8 Jun 2023 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686228087;
        bh=AwkHgxPMUbRTArk+YHBdqgLbZLLyn5dFTgpA2rfQlo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MW39iB7737DEwP5dkIb8+y1mBXi1/Dr0926JugNbp2Sni4RPSdNXqf8Les8MtqzL5
         8rTvAbaNj0lMPogQqFyXsi5dTExlkjk5tzLWSXtVmliFohZm0SdTHtCwR+x4oJ2/Yo
         DuLQn50R1I5vykonFP8A1/9dN95Mdlnr7NfL3x0XKwAd8N1r2rdJCKnPfT4QP+IXL1
         Oei5QWgaI6tUbLS0HeLFmNxpco0WLhyl9zWWld8ozNNA1gwAf/DP72UytiHm5MK6MK
         xCKkROHycdw915P/BXZn6g9oJkMoQodcFA5p5zGBcPBKvxb4uGBN6EkZEr3u1UAJKd
         wG1gtR6PekFFA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: unexport buffer_check_dirty_writeback
Date:   Thu,  8 Jun 2023 14:41:21 +0200
Message-Id: <20230608-lesung-vollmond-3e9df5cac7e4@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608122958.276954-1-hch@lst.de>
References: <20230608122958.276954-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=766; i=brauner@kernel.org; h=from:subject:message-id; bh=AwkHgxPMUbRTArk+YHBdqgLbZLLyn5dFTgpA2rfQlo4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ0nsl13bAmeMejkE2fDOIZ7opNF/qVyhI3WyX/x8F1/k8r bjxV7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIejDDP/PIXhUBxwdr1Z2admv8mF BaNOcMJ9PFXxV5V3rsNr362sXIMOXHa5Z4wwrdietUkoTyo1+2XX6V1crh/P+Uk93+g/EreAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 08 Jun 2023 14:29:58 +0200, Christoph Hellwig wrote:
> buffer_check_dirty_writeback is only used by the block device aops,
> remove the export.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: unexport buffer_check_dirty_writeback
      https://git.kernel.org/vfs/vfs/c/faf091a85abe
