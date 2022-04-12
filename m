Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CC94FEB92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 01:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiDLXYI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 19:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiDLXXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:23:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C0C193DE;
        Tue, 12 Apr 2022 15:47:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87232B8204F;
        Tue, 12 Apr 2022 22:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F32C385A1;
        Tue, 12 Apr 2022 22:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649803641;
        bh=Ae+iojHYHmdr5tmp4CX6EUSC7PeTzEe8T4yc0/CtlxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TkIVeeuzrMLEURfqjQ0UxZuhVtH0h4R+aovTIdMCG1M+Ur0TOUiRqzrODXmeTVaCc
         7NxP1DHeJsvwYiMRl/3rMdhrdN/ypMtJCeg1WzRHfWjJEDD4WxsEO8BfxL7OgXgHe3
         yiI69Gre9nmK4MZZzo9na9McSewKQrvKB4gdAT6pJgHnCeYjrG39jFueU5NBwPXdhL
         kXqcb5hhey4EWPkdhtL8PE6StgPozAx/faj2u3Vpg+wTZR+LAoUwyIWQFId919BLlc
         FDVAg/j4h2ew2en1x9QTaED4vNO6tnXuiGRaWatbAJgNz5Wrjk1/AzMg6O7hfPwyhL
         z+7C+QZma+LHg==
Date:   Tue, 12 Apr 2022 15:47:20 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update IOMAP FILESYSTEM LIBRARY and XFS
 FILESYSTEM
Message-ID: <20220412224720.GJ16799@magnolia>
References: <1649733686-6128-1-git-send-email-yangtiezhu@loongson.cn>
 <20220412033917.GB16799@magnolia>
 <20220412035042.GC16799@magnolia>
 <0d629b54-a29c-aeed-1330-840b1b98a8a3@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d629b54-a29c-aeed-1330-840b1b98a8a3@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 12, 2022 at 12:55:39PM +0800, Tiezhu Yang wrote:
> 
> 
> On 04/12/2022 11:50 AM, Darrick J. Wong wrote:
> > On Mon, Apr 11, 2022 at 08:39:17PM -0700, Darrick J. Wong wrote:
> > > On Tue, Apr 12, 2022 at 11:21:26AM +0800, Tiezhu Yang wrote:
> > > > Remove the following section entries of IOMAP FILESYSTEM LIBRARY:
> > > > 
> > > > M:	linux-xfs@vger.kernel.org
> > > > M:	linux-fsdevel@vger.kernel.org
> > > > 
> > > > Remove the following section entry of XFS FILESYSTEM:
> > > > 
> > > > M:	linux-xfs@vger.kernel.org
> > > > 
> > > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > > 
> > > WTF?
> > > 
> > >  ▄▄   ▄   ▄▄   ▄    ▄
> > >  █▀▄  █   ██   █  ▄▀
> > >  █ █▄ █  █  █  █▄█
> > >  █  █ █  █▄▄█  █  █▄
> > >  █   ██ █    █ █   ▀▄
> > 
> > *OH*, I see, you're getting rid of the M(ail): entry, probably because
> > it's redundant with L(ist): or something??  Still... why does it matter?
> 
> Yes, the section entries are redundant. Sorry for the unclear description.
> 
> The intention of this patch is to clean up the redundant section entries.
> 
> > 
> > Seriously, changelogs need to say /why/ they're changing something, not
> > simply restate what's already in the diff.
> 
> OK, thank you. Should I send a v2 patch to update the commit message
> or just ignore this patch?

Yes, please send a v2 patch with an improved commit message.  NAK
withdrawn.

--D

> Thanks,
> Tiezhu
> 
