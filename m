Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E336C7A65FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjISN62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjISN6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:58:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD28186;
        Tue, 19 Sep 2023 06:58:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754A1C433C8;
        Tue, 19 Sep 2023 13:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695131881;
        bh=1hnmtLmSPESlL3J6WZJjA7gdaFcvCrqnG9auuGtZMCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OpcQU2f/13xk6X8X4A8tmv4hsesR9ihUOli01LZCJFvAHL74zTzIVlb4mrK7jYtat
         sd45GHSHkrNcQ1BT7go+f/pm4y1wC5mM/6D2SfHBPtvUwq/qALYHIuT9cyD03WZAUF
         6YWRCD+nXK2Q8ANW11ywTOQma9UOkT33egiCz78H7xhTaPqIvAqyZFt9TSwtt0GGxM
         RLP1L9J9w6NS0YsIJxGXSVR/cyIhe+HxvgkSSiWSJmAmgdAH9vxuz/mDWpwTDJt000
         sa7TvgDYTuFUGOk5iWuy8SyUYsBQ9wa0HN8Sex7l97UbX8z2S07d1Z6YpzCZtB2deV
         aBXpn0JMCJzDw==
From:   Christian Brauner <brauner@kernel.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs/pipe: remove duplicate "offset" initializer
Date:   Tue, 19 Sep 2023 15:57:51 +0200
Message-Id: <20230919-valide-filmverleih-17f6648943e5@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919074045.1066796-1-max.kellermann@ionos.com>
References: <20230919074045.1066796-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045; i=brauner@kernel.org; h=from:subject:message-id; bh=1hnmtLmSPESlL3J6WZJjA7gdaFcvCrqnG9auuGtZMCw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRyrrj2YXqOxlP+Q5dPtDa9Lgu3nvHxsyu/eH3ZxQPX9xuX VOr87ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIrywjw7ryGfVv9R6/S7D3XznlYN HftJdbxU36WjSi5C98rNs/ZxIjwzJr43mTrDjqc77/C1G9+m6LiWDLsrj/Jxmzg3dxJnNNZQMA
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

On Tue, 19 Sep 2023 09:40:44 +0200, Max Kellermann wrote:
> This code duplication was introduced by commit a194dfe6e6f6 ("pipe:
> Rearrange sequence in pipe_write() to preallocate slot"), but since
> the pipe's mutex is locked, nobody else can modify the value
> meanwhile.
> 
> 

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

[1/1] fs/pipe: remove duplicate "offset" initializer
      https://git.kernel.org/vfs/vfs/c/adbb6dc7bfbd
