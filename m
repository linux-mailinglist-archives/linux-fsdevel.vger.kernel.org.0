Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07481722160
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 10:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjFEIsx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 04:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFEIsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:48:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B3CCD
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 01:48:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B9D761227
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 08:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1706C433EF;
        Mon,  5 Jun 2023 08:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685954930;
        bh=3d8/Ej18GgMtoXMTLB+soylFaaZolWb2o9v5accb9Jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tnzynUlU0BCNw3ab4A/wlUdTSOa7rs8eHN/x9AqZeqYxCc1xk6XHTFS5+wBkTGXPS
         NEv/LklhS2vrmRiolp4WIP/BrNpV4aPz0s/62KdOXhsYuvZFitPmzn2Mst2XDTE3ct
         rFQMtslwu6ZEYRKxuWGDhmaLsjIglEf8Tuhu2D6nln3lrx080TWtvwdzcE1m22NQIM
         GDlr5DOK7aBYmhGpFSOB0q2bYUoi3JCNAf6NJrT1H2IaoaUkfQA49AQ2mNsyAJfkGa
         XwLnwHG4gTx9cobcE0rgKCojHJKXjSedESakS9J9LqXhtVT1ZJxv7Cc/TZ+4DWsMGe
         khHfp2Mf1MKFw==
From:   Christian Brauner <brauner@kernel.org>
To:     Yihuan Pan <xun794@gmail.com>, hch@lst.de
Cc:     Christian Brauner <brauner@kernel.org>, vgoyal@redhat.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] init: remove unused names parameter in split_fs_names()
Date:   Mon,  5 Jun 2023 10:48:42 +0200
Message-Id: <20230605-reckt-schob-73f835ae0cec@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <4lsiigvaw4lxcs37rlhgepv77xyxym6krkqcpc3xfncnswok3y@b67z3b44orar>
References: <4lsiigvaw4lxcs37rlhgepv77xyxym6krkqcpc3xfncnswok3y@b67z3b44orar>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=brauner@kernel.org; h=from:subject:message-id; bh=AL+b+b8Vj53b3xatoio/CTWlNT4Uv6AldGkF9dFhzF4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTULowKOHR2XvtlvXjPs0/PZ3Tor//61j5RLuio/SbTPMcj 5jcfdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzklyojQ+eG8rZKneCA9/VXnqc2tj Wn7jwSY7azWiBNfseUQp8T/xh+MZVs0JU7yf+sKvoGk6+HJfN0u+vvfoX8Dhbb0FLxe2seGwA=
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

On Sat, 20 May 2023 15:23:32 +0800, Yihuan Pan wrote:
> The split_fs_names() function takes a names parameter, but the function
actually uses the root_fs_names global variable instead. This names parameter
is not used in the function, so it can be safely removed.
> 
> This change does not affect the functionality of split_fs_names() or any
other part of the kernel.
> 
> 

I fixed up the commit message as requested by Christoph.

---
 
Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] init: remove unused names parameter in split_fs_names()
      https://git.kernel.org/vfs/vfs/c/7f1d63536bee
