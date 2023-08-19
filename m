Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858C87818FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Aug 2023 12:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjHSKmY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Aug 2023 06:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjHSKmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:42:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253F6121288;
        Sat, 19 Aug 2023 03:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B77046139D;
        Sat, 19 Aug 2023 10:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F27C433C8;
        Sat, 19 Aug 2023 10:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692440008;
        bh=FH76A6sGH9vDCNCy05tNP5wNNbrZepEEn+rn38OgN48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dl/dD3tQWiIorvI6IzCsiUAeM0uZwA8ny5bYiqhy9ovrkY7TAhpye6NxsFMDnfCoh
         CGwTJriVdTB3c2tNgkVPrXPr4+04Oug6v0/XPhj7q+VW7FXOkYadRdcy+CQAMIRRFN
         YdN81/LzpUIBOW07ptngRL9bSNCBlEbx/DZNahMvHJR8GFm0kXnKdcv3t/QVLNX2iA
         g8o1ccF0dmWEzU22Ku8IGyU8S4PuF204CfObFj4+w8fnfEwTXRIjYKkLiWcu+h0ONQ
         s4ir7cgObek0iuWOv9EN17ktLgzqwMsiC9bZZySAFGSDd4317JE76ccjrHN4iXc+UO
         81+3j95S9vCUQ==
From:   Christian Brauner <brauner@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-docs@vger.kernel.org
Subject: Re: [PATCH] fs: Fix kernel-doc warnings
Date:   Sat, 19 Aug 2023 12:13:23 +0200
Message-Id: <20230819-nominieren-egalisieren-400fdee813c0@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818200824.2720007-1-willy@infradead.org>
References: <20230818200824.2720007-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=brauner@kernel.org; h=from:subject:message-id; bh=mDb9FI9PKKtjgnckwOXQZvkj66LYQy0OX176uRhMKqE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ8mLri3btQ/txyB8M6x+VeqX4ua+zuetrmnJwl6PPk3L0/ fbvZOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCuYSR4cX9HduPNlQtZd2W1XWx+s mJ9pvn2d7XeFrsCTr77DJ7XQYjQxtPjtTro/uePr+ULWav+kw3K9N61l5xcb4P4rdcHQ5M4QIA
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

On Fri, 18 Aug 2023 21:08:24 +0100, Matthew Wilcox (Oracle) wrote:
> These have a variety of causes and a corresponding variety of solutions.
> 
> 

Excellent, thank you!

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

[1/1] fs: Fix kernel-doc warnings
      https://git.kernel.org/vfs/vfs/c/fdf482b665be
