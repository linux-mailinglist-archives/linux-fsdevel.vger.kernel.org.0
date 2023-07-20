Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5952E75B5EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 19:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjGTRzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 13:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjGTRzy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FEEAA;
        Thu, 20 Jul 2023 10:55:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3F8F61BB8;
        Thu, 20 Jul 2023 17:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE7FC433C9;
        Thu, 20 Jul 2023 17:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689875753;
        bh=8ExOoz90a98hu/tVFV7YMCWDB9bUKvorprZfF6xc8eI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oLYqVKOc5qXZwtl+6KDbhLtEleHUYHCv36ksWkOS0D0HrwtaiL/Th/70gwjBlZjya
         QPCRZsnDJ2DR57sY+Nb68/uo4oR2A33ol8vCgxvfX91pUh29Pr6xlZ/2W8jcB9w1j/
         EoFWjv1w5lg/muYENBtdYyKOKdUSrBkuECBNv1H0=
Date:   Thu, 20 Jul 2023 19:55:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     almaz.alexandrovich@paragon-software.com, stable@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        van fantasy <g1042620637@gmail.com>
Subject: Re: [PATCH 1/1] fs/ntfs3: Check fields while reading
Message-ID: <2023072022-yahoo-pushy-2b86@gregkh>
References: <20230717125013.1246975-1-lee@kernel.org>
 <2023071733-basically-snub-5570@gregkh>
 <20230717174020.GE1082701@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717174020.GE1082701@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 17, 2023 at 06:40:20PM +0100, Lee Jones wrote:
> On Mon, 17 Jul 2023, Greg KH wrote:
> 
> > On Mon, Jul 17, 2023 at 01:50:13PM +0100, Lee Jones wrote:
> > > commit 0e8235d28f3a0e9eda9f02ff67ee566d5f42b66b upstream.
> > > 
> > > Added new functions index_hdr_check and index_buf_check.
> > > Now we check all stuff for correctness while reading from disk.
> > > Also fixed bug with stale nfs data.
> > > 
> > > Reported-by: van fantasy <g1042620637@gmail.com>
> > > Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > > Fixes: 82cae269cfa95 ("fs/ntfs3: Add initialization of super block")
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > ---
> > 
> > What stable tree(s) is this for?
> 
> I thought you had tooling that used the Fixes: tag for this?

Yes, but that tells me how far back to take a patch, but not what a
hand-crafted backport should be applied to :)

Now queued up, thanks.

greg k-h
