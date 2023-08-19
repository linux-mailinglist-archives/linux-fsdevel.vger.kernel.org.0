Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73EE7818FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Aug 2023 12:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjHSKmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Aug 2023 06:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjHSKl6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:41:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD17121E65;
        Sat, 19 Aug 2023 03:11:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9710F60ED4;
        Sat, 19 Aug 2023 10:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E0DC433C8;
        Sat, 19 Aug 2023 10:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692439909;
        bh=zdyZgfmroReQJUMTevSEdZXR79ZYt32H+xnRtodQKoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NJEkREoGfi65cH8t40+GNe86IyDFOW9RPPOJLfwvtOF2LZxSGkTDnUz7JW0q1EQgW
         6wkAMSzPxBvk3ZrFw9gF3j+1cRaxTj3Y4lIQBwQAnWS3IpptVsY1HN3KZ8XiLpjEoA
         87ulxIphxi5ov9QJnXUSOklT+zphcEHN6dMp/2IHQR2NB5cNWiDO/M2uLyB/gFHSuR
         SggmW43C67QzOkWPZfumiP1Iry9545LPlYk+rV9mCQv8LWromYGlFZFI5UX4N/Nrxy
         I/80MhjZc3zeJHkA4Mjy88YVIovNgOwahK2OzuSDaerZ3WuoZj47VIXhJzMVLDM5yW
         RiMQX4mDyfcag==
From:   Christian Brauner <brauner@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-docs@vger.kernel.org
Subject: Re: [PATCH] devpts: Fix kernel-doc warnings
Date:   Sat, 19 Aug 2023 12:11:43 +0200
Message-Id: <20230819-affen-hausordnung-d50e2d708e5a@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818201003.2720257-1-willy@infradead.org>
References: <20230818201003.2720257-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=867; i=brauner@kernel.org; h=from:subject:message-id; bh=wxRTSY+wyL+LFW0/X6NZG8ePhTmqpYu7N8PT1GboW7c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ8mBp258yF36Z737R2de3Ij2UX9+2Yz7DB6r9ZxE3nl5Pj Ze4GdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEO4SRofV7nHfTl+9LdDZdXaJtp3 dN8oXE/x/L5AM3WBh8vFz0NIfhf1ljBXvT9+5I8f2x6y9+0hO3m3fN2+dZ7SuNuTu6DoZcYgUA
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

On Fri, 18 Aug 2023 21:10:03 +0100, Matthew Wilcox (Oracle) wrote:
> This documentation has bit-rotted over time.
> 
> 

Thanks!

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

[1/1] devpts: Fix kernel-doc warnings
      https://git.kernel.org/vfs/vfs/c/89ac8b112589
