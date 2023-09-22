Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1448E7AB1EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 14:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbjIVMNa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 08:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjIVMN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:13:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E5A92;
        Fri, 22 Sep 2023 05:13:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5D3C433C8;
        Fri, 22 Sep 2023 12:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695384803;
        bh=X0ckH1uMhzVew8rdJB1QtaZb/LOJh4Jl5v+9Kf3dRDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JBwRrE78uA8RQbQfRMa+35uiC4QjM9urZKGRDdpohYAWUh4OGBf1kSr6p3BeNGGwu
         pYWJzuuwdcJ3fNVslQKb53ZxdOVHrXTYghrYGrZmuUJrTaJnTAIDNx9IzVkdYroUXJ
         X13pprrSpkewOp7blgroQunq0lxZOnEKk5lF3PGbo3YmZM5RICQubYlDuek/fbyVhn
         Ecgi4yNsNpVETf1zpQiFV5w9L7NcvEbYRAA6DplaPLcwda8+Ak2CggEGPQ4fn5Wmz7
         8t3v3YlAaS143H2SCuz4Ct2XcMocgaB+C6ahxlzjmiTDfErwlMFJNHiWu+G8q6vOHb
         9YlXuEAD/HazA==
From:   Christian Brauner <brauner@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Christian Brauner <brauner@kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill O'Donnell <billodo@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 0/8] autofs - convert to to use mount api
Date:   Fri, 22 Sep 2023 14:11:04 +0200
Message-Id: <20230922-fixieren-antworten-dbae8fccfeeb@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922041215.13675-1-raven@themaw.net>
References: <20230922041215.13675-1-raven@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786; i=brauner@kernel.org; h=from:subject:message-id; bh=X0ckH1uMhzVew8rdJB1QtaZb/LOJh4Jl5v+9Kf3dRDA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTytpin5a/9tb2nI6XRStBr4lSJeRvK6q+JcqrYr566Yx9T 4APDjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl8n8bwz/BkUkexclAIc8iyRYmCEy MiD9XtVf73uyHF2isvP8l0JiPD4wcfczYnengxR3Vr9YvP91+62zr5dsPnzm2KdYoVzpwcAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 22 Sep 2023 12:12:07 +0800, Ian Kent wrote:
> There was a patch from David Howells to convert autofs to use the mount
> api but it was never merged.
> 
> I have taken David's patch and refactored it to make the change easier
> to review in the hope of having it merged.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> 
> [...]

Applied to the vfs.autofs branch of the vfs/vfs.git tree.
Patches in the vfs.autofs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.autofs

[1/8] autofs: refactor autofs_prepare_pipe()
      https://git.kernel.org/vfs/vfs/c/a1388470620f
[2/8] autofs: add autofs_parse_fd()
      https://git.kernel.org/vfs/vfs/c/917c4dd6e625
[3/8] autofs: refactor super block info init
      https://git.kernel.org/vfs/vfs/c/81a57bf0af7c
[4/8] autofs: reformat 0pt enum declaration
      https://git.kernel.org/vfs/vfs/c/34539aa9def8
[5/8] autofs: refactor parse_options()
      https://git.kernel.org/vfs/vfs/c/805b2411ca1c
[6/8] autofs: validate protocol version
      https://git.kernel.org/vfs/vfs/c/89405b46e168
[7/8] autofs: convert autofs to use the new mount api
      https://git.kernel.org/vfs/vfs/c/7bf383b78c56
[8/8] autofs: fix protocol sub version setting
      https://git.kernel.org/vfs/vfs/c/10afd722e290
