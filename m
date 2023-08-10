Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98F37779C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 15:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjHJNkw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 09:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjHJNkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:40:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD7990;
        Thu, 10 Aug 2023 06:40:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EA836448D;
        Thu, 10 Aug 2023 13:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C223BC433C8;
        Thu, 10 Aug 2023 13:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691674850;
        bh=JJiCaEH6Wkiz8NRjOcwkAnvbX7TRvg/YjjbRO9YjaIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d75IAd66WqMxRGnKM6Z8LXBYeKAJ4DEhsdWkuVXHyA9JtEnv2u2QIFG2ScAnJExHF
         mp2TvSYScljwy0wmIdA/4YlzihHaNzTszAHW62IBJHKmOSdTvQr2AOT3tkYPQrHtcK
         jwwgV7lkPPSnwXT+fryN9mhrHApt/w/s29yQGNtslXdk1xNhnkbRmGLjw9QJmow/3o
         /zUez8acwS8rAzRC7HDzTV1IA+bdR7VAXOa3iHVG3I8ZKYpxJc2FanucbOJUioxGy/
         T7RfPiUNQJLBQIqAiprfCv+Ol+NmHBnQ+uvS2FdqE/ZUs2RMq6lYxL3KdB4buhqPZZ
         +74VvP/3Xj1Dg==
From:   Christian Brauner <brauner@kernel.org>
To:     Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: filesystems: idmappings: clarify from where idmappings are taken
Date:   Thu, 10 Aug 2023 15:40:45 +0200
Message-Id: <20230810-leiht-aufnimmt-21ab1cced78d@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625182047.26854-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230625182047.26854-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=955; i=brauner@kernel.org; h=from:subject:message-id; bh=JJiCaEH6Wkiz8NRjOcwkAnvbX7TRvg/YjjbRO9YjaIg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRceXEr+V2vxfEj2beLpj1iD53Xys4mvfjR6uwnGx+J6ew9 L6vk3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRcx0M/5PmCrBMuF979lBp155UG5 +wpI13y67FtS8o0lsq+ZjD4hfD/5CeeaceCGkVHXjadp/FL8T28SMfzszJHk+f3eMo9Tm3lQEA
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

On Sun, 25 Jun 2023 20:20:47 +0200, Alexander Mikhalitsyn wrote:
> Let's clarify from where we take idmapping of each type:
> - caller
> - filesystem
> - mount
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

[1/1] docs: filesystems: idmappings: clarify from where idmappings are taken
      https://git.kernel.org/vfs/vfs/c/b4704cb65f47
