Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC537278E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 09:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbjFHHeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 03:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjFHHeT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:34:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32755E6C;
        Thu,  8 Jun 2023 00:34:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC15A64977;
        Thu,  8 Jun 2023 07:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720AFC4339B;
        Thu,  8 Jun 2023 07:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686209657;
        bh=hj7i8hTygB8MxIuZCk3nWi7YtmKA5+Jz5129M0m2SeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HUb4L4RV1pITd/cd8B+A+VOd1i4OmGGE3uzy0jZkmnThBRoaanecwIhgiT7x9BLF+
         NBYu2Kssj1Evx9hGaKZm/akYBRdj4BaM2EhzNppDkm7HQHsYegm54fPtKCnNRYgaRs
         fV9+YKhQfrmM4cjc3JuNfo23IooMymkTkDK9+h7tRppODnZY7CUhUu1gEhIyWKr1de
         qnVav9TYfLTJunqL8qXvMtruMQIjLxteO62owDHP+jMCgDR2q8UuLQ4x7OXgIE3N8i
         TGySpRSe45bro8dU6GiweaNsy2SlVd+QrU2V+yF8bCwAT2Puz0BG9s8TRtr0QAQeAE
         HQYyPrGFv/fyg==
Date:   Thu, 8 Jun 2023 09:34:12 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Karel Zak <kzag@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] fs: avoid empty option when generating legacy mount
 string
Message-ID: <20230608-holprig-deswegen-4c3b31a71fc3@brauner>
References: <20230607-fs-empty-option-v2-1-ffd0cba3bddb@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607-fs-empty-option-v2-1-ffd0cba3bddb@weissschuh.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 07:39:09PM +0200, Thomas Weißschuh wrote:
> As each option string fragment is always prepended with a comma it would
> happen that the whole string always starts with a comma.
> This could be interpreted by filesystem drivers as an empty option and
> may produce errors.
> 
> For example the NTFS driver from ntfs.ko behaves like this and fails when
> mounted via the new API.
> 
> Link: https://github.com/util-linux/util-linux/issues/2298
> Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock creation/configuration context")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---

Applied a fixed up version of v1 to

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: avoid empty option when generating legacy mount string
      https://git.kernel.org/vfs/vfs/c/36851649d3f6

yesterday.
