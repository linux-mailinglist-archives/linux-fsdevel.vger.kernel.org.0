Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7BE79B6D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbjIKU4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237690AbjIKNJY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:09:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ED2E5
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 06:09:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1263C433C7;
        Mon, 11 Sep 2023 13:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694437759;
        bh=o2ZKqdFAsh/45+9d1aPhwz7zyijMCz7e88gIz/GOqAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gff8ZdLxuyoFt865fcIjFfj+vrx6FvLaAkNpHc67lX2QyoVY3OLawNwZ6B7Bb7z0J
         u/POoqjX9+tY0sLIPOB7NAgiA6ioTX3f68KEBPvgJJT5aerheOeq5SGWf7GisJ7Ern
         /h+DizYmmwSKm2PoDtpW4Z0PW7V3g9bFLppgXWQEuVsjPW6NH5GIfdARxJ2Bb5R9Wj
         ybuOg9GEOL6w9j/5Dh3/83W3sry2hjFhx6bxwnVDuL5yhn1J3VVTAxcTfMD2vH1vjS
         9y9D8Kb3dcJY+Xhzeo/leK4LCfZqTGFGqQ3D5AQSQYUc2yeuLIiV6AdE3yjuLL/dpY
         Am7n8kwlXt7Lg==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] Rename and export some vfs helpers
Date:   Mon, 11 Sep 2023 15:09:01 +0200
Message-Id: <20230911-unrealistisch-stilisieren-a06591402375@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908132900.2983519-1-amir73il@gmail.com>
References: <20230908132900.2983519-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=brauner@kernel.org; h=from:subject:message-id; bh=o2ZKqdFAsh/45+9d1aPhwz7zyijMCz7e88gIz/GOqAo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT8Fwx/uUtqtboae0RdnQtn8Oz58w4mXHE9bz3jT+iLRLfv 0z/6dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE/jYjw+6tE74aS0Y/aLJcYxx4Rn TxqWwDgfCrP//Nffq6+l2aXhwjw5pTzJNmHFlb+9PEkmuj/+wcsaCZTevqvzLHbLkZ/u2PDQcA
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

On Fri, 08 Sep 2023 16:28:58 +0300, Amir Goldstein wrote:
> Christian,
> 
> This is the rename that you proposed, for the helpers needed by
> overlayfs.
> 
> I could stage this in the overlayfs tree for 6.7, but it has a bit
> of conflict potential, so maybe best if you stage this in vfs tree.
> 
> [...]

Applied to a branch that's expected to stay stable on v6.6-rc1. I have
no strong feelings about these exports so if someone does, please yell.

---

Applied to the vfs.mount.write branch of the vfs/vfs.git tree.
Patches in the vfs.mount.write branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mount.write

[1/2] fs: rename __mnt_{want,drop}_write*() helpers
      https://git.kernel.org/vfs/vfs/c/3e15dcf77b23
[2/2] fs: export mnt_{get,put}_write_access() to modules
      https://git.kernel.org/vfs/vfs/c/ddf9e2ff67a9
