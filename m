Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C924DE68F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Mar 2022 07:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241204AbiCSGlv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Mar 2022 02:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242038AbiCSGls (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Mar 2022 02:41:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD7E2EDC2D;
        Fri, 18 Mar 2022 23:40:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CA6060EB6;
        Sat, 19 Mar 2022 06:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05816C340EC;
        Sat, 19 Mar 2022 06:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647672027;
        bh=viYE02J1bim8nBHAWboDp5DYEfpRJ17BEMz4UNNOdnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zr4CKErzIVDSB4FnIo5cEgLuMrJd7u7+gyy8RoNiVGSwzE2x6NaT95/DuagddRLZU
         G1P8Arj1cSUivwmHOZ5s9seZV2TrFnhKXcNSn32hCLwBuuzIf4h4qw2aftrvZlI2IH
         40Gnp0KKSpSUvo7SqOZ9JUOMBSR8DjdIwyRHGvP4=
Date:   Sat, 19 Mar 2022 07:40:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Alessio Balsini <balsini@android.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: fix integer type usage in uapi header
Message-ID: <YjV60vyVkMXrkla/@kroah.com>
References: <20220318171405.2728855-1-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318171405.2728855-1-cmllamas@google.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 18, 2022 at 05:14:05PM +0000, Carlos Llamas wrote:
> Kernel uapi headers are supposed to use __[us]{8,16,32,64} defined by
> <linux/types.h> instead of 'uint32_t' and similar. This patch changes
> all the definitions in this header to use the correct type. Previous
> discussion of this topic can be found here:
> 
>   https://lkml.org/lkml/2019/6/5/18
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  include/uapi/linux/fuse.h | 509 +++++++++++++++++++-------------------
>  1 file changed, 253 insertions(+), 256 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
