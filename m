Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF36754F2A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 17:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjGPPBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jul 2023 11:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjGPPBe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jul 2023 11:01:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00EC1B7;
        Sun, 16 Jul 2023 08:01:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BC8B60D27;
        Sun, 16 Jul 2023 15:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD40C433C8;
        Sun, 16 Jul 2023 15:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689519692;
        bh=uGoGoX8j+eY4PnfSBrW9VCXSwpRB1DGQCVgEl5+Wkso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBP+ogCCaVKfPUAmNUbV19Xwv+XrS1z/GdQZApUa1WTG4Nfa3huL+cERtuoB/OuZP
         Glrtg0dY3wckYHb08lJdU0YG0iafLiV6i+fbZEkoeyyOKnxP4/F+1L4fbly7cnvD4q
         qPZDHAfQDstX+sUbyr8JZGqrx0T0+nDSeZ9+cir0=
Date:   Sun, 16 Jul 2023 17:01:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6.1 0/4] xfs inodegc fixes for 6.1.y (from v6.4)
Message-ID: <2023071658-crowbar-frugally-7a39@gregkh>
References: <20230715063114.1485841-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230715063114.1485841-1-amir73il@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 15, 2023 at 09:31:10AM +0300, Amir Goldstein wrote:
> Greg,
> 
> This is a fine selected set of backports from 6.4.
> Patch 4 fixes a fix that was already backported to 5.15.y.
> Patch 1 fixes a fix that is wanted in 5.15.y and this was the trigger
> for creating this 6.1 backport series.
> 
> Leah will take care for the 5.15.y backports, but it may take some time.
> None of these are relevant before 5.15.
> 
> These backpors have gone through the usual xfs review and testing.

All now queued up, thanks.

greg k-h
