Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85582775265
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 07:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjHIFyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 01:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHIFyj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 01:54:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0D61728
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 22:54:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51D6D62F42
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 05:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8734EC433C8;
        Wed,  9 Aug 2023 05:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691560477;
        bh=mzujPaMACDBKGnvmLjoKGOWafUIYMcHSB+T95hdyZAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o2PzNGiwqMB4Srv15fBGpKvsrdGBcaEUqol/l7kk3/wUced/sGOUvTNNr4gZNZWis
         NL8j6TVcctYwR/1LDYj0IOHyerUdyxMaVyJEQGKk47aDnEx5KJHyYI+yxtoECMEPh6
         ulo23wRdspo7Wz9SijVyV+SZP7zmYReKKqb6Bh5uj5tqRf0FuwLYinFJuzvvX096ej
         1FUbi6M7AJlqfk8yEuW6LMEmtfUtQxCdUdyvf8QVoSchARWj7NswLwmWCcVnsihIob
         BEjkd6xkLkhMoDz52xXSSexKdxDBH43yH+TM9forATTesgWf9xiwEfaVFZhADDM7BS
         f8FXgAgERBrXQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: unexport d_genocide
Date:   Wed,  9 Aug 2023 07:54:31 +0200
Message-Id: <20230809-ratsuchende-ovale-f46938fa1b0f@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808161704.1099680-1-hch@lst.de>
References: <20230808161704.1099680-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=850; i=brauner@kernel.org; h=from:subject:message-id; bh=mzujPaMACDBKGnvmLjoKGOWafUIYMcHSB+T95hdyZAU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRc1hK5HLMj4rvkER9/766Pk/LPZ0a98e/g8NTR1/r/+yTr qQ2VHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZXszI8PxP38/pz8znXvx83F8//8 fRv8tFxJa33Qtg2M0e0Pl9lg7D/3D/nbbr9dmOZ87YsGI/p7LQ6TAjpbl3Jni+mL7r5RnJtwwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 08 Aug 2023 09:17:04 -0700, Christoph Hellwig wrote:
> d_genocide is only used by built-in code.
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

[1/1] fs: unexport d_genocide
      https://git.kernel.org/vfs/vfs/c/7b3f28d32ef2
