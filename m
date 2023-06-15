Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D7F73194F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 14:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbjFOM4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 08:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbjFOM4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:56:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E331BC9;
        Thu, 15 Jun 2023 05:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD25462C0F;
        Thu, 15 Jun 2023 12:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A4BC433C9;
        Thu, 15 Jun 2023 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686833810;
        bh=WdxuvrA1XPiuVFvFqhmfdWqDsUHJWdCtQE7+XLc8lF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pCLSVk1PO72n9bExzFoJR88YrFa+UT8nfSv/Rm+zNe02qKDNgaAJ+JwJZXhc2OOmH
         EqBrPiOkndf6YPwzmIxbI2stD/kZzGA0eQQlgtEp0/K0S/xPL6H7Kf3jEX9UXYwhGR
         VpIuK1R3YXLgXRYYQA3nOQdJg4zrMrH6uDy/f+pO2fdgnzKyhCrIapvs2//8OVtz2p
         iyBhBFrJRBhgd7ack2/L515fbrVr3t2q7bUIpiQoPr5N9tis5FpXWc7jHLXX+J5jzN
         rqHpXAQBRcBF90O8zfQ6tdQWlgqPdFBmIN7DZ93yMcZcxV9ba6p9Fhuw+KO9AiuH6t
         sDDGXC2NxE1uA==
From:   Christian Brauner <brauner@kernel.org>
To:     wenyang.linux@foxmail.com
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] eventfd: add a uapi header for eventfd userspace APIs
Date:   Thu, 15 Jun 2023 14:56:34 +0200
Message-Id: <20230615-insbesondere-kochen-eee1a4b2581d@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_2B6A999A23E86E522D5D9859D54FFCF9AA05@qq.com>
References: <tencent_2B6A999A23E86E522D5D9859D54FFCF9AA05@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; i=brauner@kernel.org; h=from:subject:message-id; bh=WdxuvrA1XPiuVFvFqhmfdWqDsUHJWdCtQE7+XLc8lF0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR0c5ULM3ZFlR5fYGfF3XDV1cew9sndOzv8fqUaHv11KKUv 68fcjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImET2T4K9QdoLjcWbtpb3rXnci2Hx un3bc/55E3+6lCfoDaykX3uhgZZlS9Yvy+cJm5ecn+n/LJ0fIc9/f6Cwuwce+/2jrZZo8kJwA=
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

On Thu, 15 Jun 2023 02:40:28 +0800, wenyang.linux@foxmail.com wrote:
> Create a uapi header include/uapi/linux/eventfd.h, move the associated
> flags to the uapi header, and include it from linux/eventfd.h.
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

[1/1] eventfd: add a uapi header for eventfd userspace APIs
      https://git.kernel.org/vfs/vfs/c/3e3a566392e2
