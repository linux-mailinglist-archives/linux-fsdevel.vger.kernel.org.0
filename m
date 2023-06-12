Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789FF72B827
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 08:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjFLGjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 02:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFLGjP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:39:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479DA10F3;
        Sun, 11 Jun 2023 23:34:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6D7161F82;
        Mon, 12 Jun 2023 06:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E01C433D2;
        Mon, 12 Jun 2023 06:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686551471;
        bh=oOcBJJUtHggjOcuTtHHaLags9ZNQ21iMCFYD/0ziiGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXiyBMDAmU59O31Yt9dbrcmADfwC8D+6yIsBdjNjsFdbEh2dAFjeU1EhqbKmhMQtU
         WWxk+Ni2LQs6tdAZOLjegcriPCV/k3KjcQEYZFnZZYTIuU+U8rTc59ga9Qw851j4Lt
         3LNdbYkw5fN6ib5H56SnPeygfvnpHdW1aSHerCxK2PmsGf8ZjNYD4cxKuOC5zg6O+A
         sLiW9NE/5QnTIqK21+Ji6goYtAT6QDzadDD78AjWpWDfV3a/8pfLLFJzkWqytjaqCh
         q2SroimRbapbvNiDwQDVmfLa+y/rwbi9GZBnNJnyAN3cXzVA/g/0mFJlLeJn2Msfan
         rOhNBivM5r2Wg==
From:   Christian Brauner <brauner@kernel.org>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mao Zhu <zhumao001@208suo.com>, viro@zeniv.linux.org.uk,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fs: Fix comment typo
Date:   Mon, 12 Jun 2023 08:31:00 +0200
Message-Id: <20230612-asphalt-gemalt-f3f0be8a21f3@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611123314.5282-1-dengshaomin@cdjrlc.com>
References: <20230611123314.5282-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=720; i=brauner@kernel.org; h=from:subject:message-id; bh=oOcBJJUtHggjOcuTtHHaLags9ZNQ21iMCFYD/0ziiGE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS07V6gExSY5/ondaXoxslHDM36F9xfwMX+4MXi4P3emcLC Lha/OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyajYjw8NJ3ubTTdsXvmyzbGJlmd miHXTi+nexmY8Mtx9Z/dCPS5fhr5TNHMX7UQXyf22W35yyTbA6Sr1u+7OOqsmf1zy2mx5UwAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 11 Jun 2023 08:33:14 -0400, Shaomin Deng wrote:
> Delete duplicated word in comment.
> 
>

Missing sender SOB added.

---

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: Fix comment typo
      https://git.kernel.org/vfs/vfs/c/dce5a4da3cf5
