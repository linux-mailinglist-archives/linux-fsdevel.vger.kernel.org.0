Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF6A7BE614
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 18:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377162AbjJIQPC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 12:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377121AbjJIQPB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:15:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE08D92;
        Mon,  9 Oct 2023 09:14:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C36C433C9;
        Mon,  9 Oct 2023 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696868099;
        bh=xKFun3wpqKI15zrVSb9Vi77QMWDHT1VEu3Sfx4AXxh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/tWxx2ek0jb9ImawAOOuGclWy99k0A5kNl95bJF6F0H/VlJ2C25kVR9+SYQz4gvE
         0//F8jjUtMTqiyhSSSZdxjyiyCJjF9l5AFxfpVTa/tKIq/mJTnncP3r/8NwYuXIKDm
         HYp2lMB4T/kpwTtcaFJZtnyVxDVMBlcQwB+fSbMu7n0OW06oJvqmMuWOL/WsuEoG1c
         29L4pvYQYKVCFXyGoHvwE3EgEb0APRFCX3bh88BDiU+zxKKq7AWqfOmRrRnk179D/0
         mNlHRyOza0id9ez7/alMlpABXbJepPRYePJQrhi1hMnXVXvKJ7MIibsxQeO6YpevCy
         JZikoRdQWABwA==
From:   Christian Brauner <brauner@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] 2 cosmetic changes
Date:   Mon,  9 Oct 2023 18:14:54 +0200
Message-Id: <20231009-jungpflanze-legislative-dc84b2c252d0@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004111916.728135-1-mjguzik@gmail.com>
References: <20231004111916.728135-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; i=brauner@kernel.org; h=from:subject:message-id; bh=xKFun3wpqKI15zrVSb9Vi77QMWDHT1VEu3Sfx4AXxh0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSqqP1Yr28RrFw5N5Ivwv+Uftq7jaJRRzc5bGGa9cz1s7RE t6BeRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERyEhl+s+YmdouV7J7QNe2T7bMFVf xWPAx7I7/tezIrh7HMh7nyLCPDn+Ab9yQ3yrHKye+8z+R4PrYrI1zK91nE9I3H6vmt1vuzAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

On Wed, 04 Oct 2023 13:19:14 +0200, Mateusz Guzik wrote:
> both were annoying me for some time, so I'm pushing them out
> 
> These patches don't warrant arguing nor pinging in case of no response,
> so if you don't like them that's it for the patchset. :)
> 
> cheers
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/2] vfs: predict the error in retry_estale as unlikely
      https://git.kernel.org/vfs/vfs/c/c9f39d6a1486
[2/2] vfs: stop counting on gcc not messing with mnt_expiry_mark if not asked
      https://git.kernel.org/vfs/vfs/c/5cafd8fed85c
