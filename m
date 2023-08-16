Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D1177DB35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242445AbjHPHgZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 03:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242454AbjHPHgO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:36:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0770210C3;
        Wed, 16 Aug 2023 00:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89CD361A7B;
        Wed, 16 Aug 2023 07:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEC9C433C9;
        Wed, 16 Aug 2023 07:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692171372;
        bh=t6r/M93XkSU/T7fdCW3IDojho4eatPXlVGqxqVrRhNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQmmdiXfUIvJZzQOpztfNdFPZGbhGzOOl//SGEp07WWl3ygjTVnA1L6FIZ1JWtc1I
         Zeavh+9jcfedDeeP7tljoniO7KBU5dOq8UICLqzEnQYR4pGNp+uFzI/NqEOlDxY7z3
         Mf0HlQl2yxWf9vsd0mGULNarNQm5us14kp/M1BUvWAPeLKxyjhrVXNOJfTqNWQDtma
         tdS3UXLb6VOlVqm5FvfS0o81v3ijFERO/U1eZr6ZM+1dPnppZS/NRBAGm3MmWU1348
         PbnOKE4OWTlz5VdVyEWiVUFJZCdVhRIC0O42zrpyQIulgOSBIalyRAPTSMafq9g4U0
         H9tnoFQgP6L9A==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wang Lei <wanglei249@huawei.com>,
        gongruiqi1@huawei.com
Subject: Re: [PATCH] doc: idmappings: fix an error and rephrase a paragraph
Date:   Wed, 16 Aug 2023 09:36:07 +0200
Message-Id: <20230816-speisen-fachkenntnis-699757c3961f@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816033210.914262-1-gongruiqi@huaweicloud.com>
References: <20230816033210.914262-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=brauner@kernel.org; h=from:subject:message-id; bh=t6r/M93XkSU/T7fdCW3IDojho4eatPXlVGqxqVrRhNM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTcqUnZ92BHjdFLg7qqwwJh8eKnlV9tmnIvIj5G9Xegk/gm 601xHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZG8HIcLE3PfbSqV3frN7/eRr+9Z xV7hNmz6e2G96yKmwrN7Pc6MvI8Mv5lbX6ehHz12dPnP322XRJ8gTbItdnTy7xT/q517bVihcA
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

On Wed, 16 Aug 2023 11:32:10 +0800, GONG, Ruiqi wrote:
> If the modified paragraph is referring to the idmapping mentioned in the
> previous paragraph (i.e. `u0:k10000:r10000`), then it is `u0` that the
> upper idmapset starts with, not `u1000`.

Yes, correct. Thanks!

> 
> Fix this error and rephrase this paragraph a bit to make this reference
> more explicit.
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

[1/1] doc: idmappings: fix an error and rephrase a paragraph
      https://git.kernel.org/vfs/vfs/c/21238b550dd6
