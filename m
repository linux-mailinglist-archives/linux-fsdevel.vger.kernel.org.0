Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AEE702ACB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 12:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbjEOKlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 06:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239707AbjEOKld (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 06:41:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30371A4;
        Mon, 15 May 2023 03:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A47561C22;
        Mon, 15 May 2023 10:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7FAC433EF;
        Mon, 15 May 2023 10:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684147291;
        bh=BJ3//YNN86O55AW9O6r4X6/rOjWNLuXo8AwIhYPjZqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRnOxIUvvFwmC5Bu41T2ARxym7dikCKzQjI94nHGGPpfDIAk34moHjrpal4IaeveG
         Lp1vH/DLUfhQLvMOl3GQuQbAau1mF2HRQ54OM2gwdleJrlKUhU2sDIjPBiWIhgNlvr
         zxODzLvZ41pR9XwGMBCGyXatI4AK0d3fNJCRTycW2S0Bb5EF+aZ/MfOS9hn42Nhmvp
         hfBvd8yyZ+nqwQm6E4iEsTClDO/3Lu7ndRF9uP9gruUqkpXxECiLFdt1jzToWQb815
         0XxKGEu+k0HthIx8kvSLp8cYIfoCKbfaonZMJxgk1c3HYHSVlM/JM386gW3UDZ8kiZ
         FIVcFWU7FcO0Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Anuradha Weeraman <anuradha@debian.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/open.c: Fix W=1 kernel doc warnings
Date:   Mon, 15 May 2023 12:41:11 +0200
Message-Id: <20230515-ritzen-abpfiff-4782ae08368e@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230506182928.384105-1-anuradha@debian.org>
References: <20230506182928.384105-1-anuradha@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=brauner@kernel.org; h=from:subject:message-id; bh=BJ3//YNN86O55AW9O6r4X6/rOjWNLuXo8AwIhYPjZqU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQk8Rh+9le5+Khn4jUR3QMsyoqnhNp1BZmXsvvWfZ3Ake98 Tjeio5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgF4CKcjAwPUgPNJk8NkHDYvXSDauWv87 /uXrmkGuwifyZvVr3YlSZXhr9S3bdPTPx2wF7D/riObZTBxdX/fP4mPb+Us/JzUfL8ojoOAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 06 May 2023 23:59:27 +0530, Anuradha Weeraman wrote:
> fs/open.c: In functions 'setattr_vfsuid' and 'setattr_vfsgid':
>  warning: Function parameter or member 'attr' not described
>  - Fix warning by removing kernel-doc for these as they are static
>    inline functions and not required to be exposed via kernel-doc.
> 
> fs/open.c:
>  warning: Excess function parameter 'opened' description in 'finish_open'
>  warning: Excess function parameter 'cred' description in 'vfs_open'
>  - Fix by removing the parameters from the kernel-doc as they are no
>    longer required by the function.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs/open.c: Fix W=1 kernel doc warnings
      https://git.kernel.org/vfs/vfs/c/1c4f10518c3a
