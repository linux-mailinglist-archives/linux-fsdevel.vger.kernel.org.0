Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594F375EE22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 10:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjGXIpT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 04:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjGXIpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:45:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4403E42;
        Mon, 24 Jul 2023 01:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32AC760F13;
        Mon, 24 Jul 2023 08:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E764BC433C8;
        Mon, 24 Jul 2023 08:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690188303;
        bh=hP4ovmU6B3WVf/5esttvkylIjaVnP6CtrBNzRRpBJBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fYl/LUcPg1lG8hkErJs5cFhFlKu4a1xAlRl7JP2D1bNw5Zlj2Nh+NYVwZbeBwe1Gn
         Ixi56pOe+6gqTmm282kgsxmdh0pY2pH5huTomtimQvC+wzasWZSEDUxZum6KMw+yQ9
         aa/AN+eNwxux8B+UVdOP8S6hQGH/Oba2cTxQKGYmkLrHx4R7dVvv6Z/1VuB3Q+Udzv
         53TjIGVZBspMPgmIlGPzToP7jJdSwttqPlU7aaC1M+KWqmxd4PmM8tNJbjrsKc/0LZ
         g83gr3xga/vwX4HGMI+GwvCHFrCW6Bs33yTGusWeN+B2p7OxvAoJvHOfKoq/wbt6sT
         pslJp8jwU6v3A==
Date:   Mon, 24 Jul 2023 10:44:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Winston Wen <wentao@uniontech.com>
Cc:     Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Paulo Alcantara <pc@manguebit.com>
Subject: Re: [PATCH 1/2] fs/nls: make load_nls() take a const parameter
Message-ID: <20230724-modifikation-geldinstitut-4122e1262c40@brauner>
References: <20230724021057.2958991-1-wentao@uniontech.com>
 <20230724021057.2958991-2-wentao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230724021057.2958991-2-wentao@uniontech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 10:10:56AM +0800, Winston Wen wrote:
> load_nls() take a char * parameter, use it to find nls module in list or
> construct the module name to load it.
> 
> This change make load_nls() take a const parameter, so we don't need do
> some cast like this:
> 
>         ses->local_nls = load_nls((char *)ctx->local_nls->charset);
> 
> Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Winston Wen <wentao@uniontech.com>
> Reviewed-by: Paulo Alcantara <pc@manguebit.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
