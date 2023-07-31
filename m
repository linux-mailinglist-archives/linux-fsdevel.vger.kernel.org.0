Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4FE769629
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 14:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjGaMYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 08:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjGaMX6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:23:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FDF1999;
        Mon, 31 Jul 2023 05:23:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9964D610A5;
        Mon, 31 Jul 2023 12:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878CAC433C9;
        Mon, 31 Jul 2023 12:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690806166;
        bh=3r+Ls/gVtZTluVbbyjL7NWr763MsqurWoQRfwvHnGGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u6aUq8ZLfcRtAIAHs3vF9XEhwPFh1u+IT3j/w6MRkJUtIG2XwT+T8hB6QXs5/amk9
         b2P/KqiKeGONgD+sK+hUFubQnN4JKfdxDSln/NZeGVsErWab2k80BrXoVppSxjPgKm
         PgeMKRtgqd5tB9mMrxjnRN5QZkuWfxJtMfen0NyUbmWUwXbDDensKG+l/lQzBjuL1p
         tAMVjhiPkvi0gwH6Ue7RaXpB5JGZDGRs76p4whhUzL01Y2e819iKSaxiKn/NC1FCl4
         SiS5Ixk+dqDmOn06iQ+vAbZ1FxOtV2m13TjLoaoP1QDj5vl2/fhpR1bSmwlIcDvcZZ
         8WCIs8/68VsWw==
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: fix request_mask variable in generic_fillattr kerneldoc comment
Date:   Mon, 31 Jul 2023 14:22:39 +0200
Message-Id: <20230731-lasst-schnorren-54882e1416ec@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731-mgctime-v1-1-1aa1177841ed@kernel.org>
References: <20230731-mgctime-v1-1-1aa1177841ed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=brauner@kernel.org; h=from:subject:message-id; bh=3r+Ls/gVtZTluVbbyjL7NWr763MsqurWoQRfwvHnGGI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQcX948Q+rqm3CJ72b2+y+8Fba64zrVMKxZbMrKHb6Os9/b Wft86ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIc1aGv0L7O/eanJAQvrfn2uyN2Z 31D7n2pslMu+G/SGKre/PBkk2MDKuT3NTmcs96duDGT8dWlqe5Z2yZ2DnnZE73kpkz8au1JzMA
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

On Mon, 31 Jul 2023 06:37:10 -0400, Jeff Layton wrote:
> req_mask -> request_mask
> 
> 

Applied to the vfs.ctime branch of the vfs/vfs.git tree.
Patches in the vfs.ctime branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.ctime

[1/1 FOLDED] fs: pass the request_mask to generic_fillattr
      https://git.kernel.org/vfs/vfs/c/0f64b6ec05db
