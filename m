Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171CB7787C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 08:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjHKG67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 02:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHKG66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:58:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD1426AE;
        Thu, 10 Aug 2023 23:58:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E616266B5C;
        Fri, 11 Aug 2023 06:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DBEC433C7;
        Fri, 11 Aug 2023 06:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691737137;
        bh=0+nHeOb2wyaH/L+9qJDvLMyfdCJlsIUJxngwWxzj5uI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSIokHQGsxTUQ/b0FW50RjZmCiveeY+qwOozlLPKomC5/uL5bBps5rQiosChUloHq
         GsB83RxKCqBr9dr7Om9PPIlNHJ/Sf72Nc6uOe9FiSBREx5ysUPolyjm6TDVh7etvIr
         JjE73dtq8j/giU82j+rgS0HcbmMe7MOdMTXpnBDGUTgKLVwmpgpl2kA4+s7XCXqkrc
         lFyefvOA10g3snjj271Oxg9ntpo9T5e0TAXfjIDXs0TFpErxHQOeTdghVKJewep+3b
         ziv8uGMTjWsO9g/WxSNOu2AVYr0MzMtvvn+p3y9Dm6Kzg/NKan7LGypDf373UotgDq
         sC1VfKfrm0jjQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH -next] fs: Fix one kernel-doc comment
Date:   Fri, 11 Aug 2023 08:58:51 +0200
Message-Id: <20230811-zufrieden-etatplanung-6413a9f83b62@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811014359.4960-1-yang.lee@linux.alibaba.com>
References: <20230811014359.4960-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=975; i=brauner@kernel.org; h=from:subject:message-id; bh=0+nHeOb2wyaH/L+9qJDvLMyfdCJlsIUJxngwWxzj5uI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRcvSP/QT3L0m/OU7YlLf0B3ZOnZZ8Jsn2T+fvhZSGZtedZ GjyudJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykXJfhf8CNq5WW/j97cy3nhlzNCH m7JnMqw9nk++dPPHK553baL47hN9v8LwxWFk8/dYntW9b7a+HTtTn7lvzdyTA1eM2Z8h8GItwA
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

On Fri, 11 Aug 2023 09:43:59 +0800, Yang Li wrote:
> Fix one kernel-doc comment to silence the warning:
> 
> fs/read_write.c:88: warning: Function parameter or member 'maxsize' not described in 'generic_file_llseek_size'
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

[1/1] fs: Fix one kernel-doc comment
      https://git.kernel.org/vfs/vfs/c/3e797ad1c5df
