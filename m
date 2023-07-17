Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C89B756ADA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 19:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjGQRk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 13:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjGQRk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:40:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53603FB;
        Mon, 17 Jul 2023 10:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA84461184;
        Mon, 17 Jul 2023 17:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC37C433C8;
        Mon, 17 Jul 2023 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689615625;
        bh=on7BUmcynWl5cl+hfeGAQDpz9N7KgjUlPCzBquHie8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OmjSRpPIdod0D31pWyyKYDIiCKrfPSK+2/X2HxB8JZd1WrRi4qPPgofSOlkvHvHWc
         sf++o7S0qRxLzUJ7NqnFIOL2BuOn/NEEMzb7a0CfS12kO9BOh71a/RRRpNwQn/EZl7
         o+mDXbegzCrqqg491PBGG91ql2rgeolGBrsc/7fcl5nWjRXO9mGehd8c14d2IQgVIL
         Vs+DFoUu5YJd2FnGQhOas37BZ36bFbQIlk8zeHs0GQItXiI6AqE432O5NeZljoE0c2
         SG+zphRmoTjsJanaUTTmRCqATlYZA31WwVPyauJIaUnsd5Ddr5I/haZi2mXlso3wV1
         UkeD4J8KZG5BA==
Date:   Mon, 17 Jul 2023 18:40:20 +0100
From:   Lee Jones <lee@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     almaz.alexandrovich@paragon-software.com, stable@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        van fantasy <g1042620637@gmail.com>
Subject: Re: [PATCH 1/1] fs/ntfs3: Check fields while reading
Message-ID: <20230717174020.GE1082701@google.com>
References: <20230717125013.1246975-1-lee@kernel.org>
 <2023071733-basically-snub-5570@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023071733-basically-snub-5570@gregkh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 17 Jul 2023, Greg KH wrote:

> On Mon, Jul 17, 2023 at 01:50:13PM +0100, Lee Jones wrote:
> > commit 0e8235d28f3a0e9eda9f02ff67ee566d5f42b66b upstream.
> > 
> > Added new functions index_hdr_check and index_buf_check.
> > Now we check all stuff for correctness while reading from disk.
> > Also fixed bug with stale nfs data.
> > 
> > Reported-by: van fantasy <g1042620637@gmail.com>
> > Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > Fixes: 82cae269cfa95 ("fs/ntfs3: Add initialization of super block")
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> 
> What stable tree(s) is this for?

I thought you had tooling that used the Fixes: tag for this?

v6.1 and v5.15 please.

-- 
Lee Jones [李琼斯]
