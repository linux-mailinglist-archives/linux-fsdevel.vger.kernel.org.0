Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A694FCD55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 05:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345567AbiDLDxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 23:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345657AbiDLDxX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 23:53:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A39933343;
        Mon, 11 Apr 2022 20:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CCF561735;
        Tue, 12 Apr 2022 03:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A21C385A6;
        Tue, 12 Apr 2022 03:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649735443;
        bh=dbjm/Ip6Jo5BhNungtA0HT0445pR5PAm6Wft+hCHZhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n7dsbpVeo2ApX3NdtVkElk6OCKqgz2VZUtQS9PXgZgP4ENjMFL/OJtOjeKdDRW6bT
         H2azFbYRr92mwG+VMwINMzmLQaoreAnPvgilDaJRNFLIsaVWUZSHNqYwtI8igTtmzL
         AbGzFIuNhBbPbuvYjTz1uIzfdxEBYkdtUt+HnJcot44pp7dFMYOacvwkqyPijYJVKE
         quW1qXfIlNDsXMkPnE3jOK6lcdlafCree/FJPeqGhvOBrDyn3N3h+HZ6U7wydhlmzN
         3f/V1LTfZllZE7na2RGiel26+1Hkn1ezyHivhvEH+z8Kdbv5v+DFuK+tBN0ZPvcqU3
         BZmQxq61lKlNA==
Date:   Mon, 11 Apr 2022 20:50:42 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update IOMAP FILESYSTEM LIBRARY and XFS
 FILESYSTEM
Message-ID: <20220412035042.GC16799@magnolia>
References: <1649733686-6128-1-git-send-email-yangtiezhu@loongson.cn>
 <20220412033917.GB16799@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220412033917.GB16799@magnolia>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 11, 2022 at 08:39:17PM -0700, Darrick J. Wong wrote:
> On Tue, Apr 12, 2022 at 11:21:26AM +0800, Tiezhu Yang wrote:
> > Remove the following section entries of IOMAP FILESYSTEM LIBRARY:
> > 
> > M:	linux-xfs@vger.kernel.org
> > M:	linux-fsdevel@vger.kernel.org
> > 
> > Remove the following section entry of XFS FILESYSTEM:
> > 
> > M:	linux-xfs@vger.kernel.org
> > 
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> WTF?
> 
>  ▄▄   ▄   ▄▄   ▄    ▄
>  █▀▄  █   ██   █  ▄▀
>  █ █▄ █  █  █  █▄█
>  █  █ █  █▄▄█  █  █▄
>  █   ██ █    █ █   ▀▄

*OH*, I see, you're getting rid of the M(ail): entry, probably because
it's redundant with L(ist): or something??  Still... why does it matter?

Seriously, changelogs need to say /why/ they're changing something, not
simply restate what's already in the diff.

--D

> 
> --D
> 
> > ---
> >  MAINTAINERS | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 61d9f11..726608f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10238,8 +10238,6 @@ F:	drivers/net/ethernet/sgi/ioc3-eth.c
> >  IOMAP FILESYSTEM LIBRARY
> >  M:	Christoph Hellwig <hch@infradead.org>
> >  M:	Darrick J. Wong <djwong@kernel.org>
> > -M:	linux-xfs@vger.kernel.org
> > -M:	linux-fsdevel@vger.kernel.org
> >  L:	linux-xfs@vger.kernel.org
> >  L:	linux-fsdevel@vger.kernel.org
> >  S:	Supported
> > @@ -21596,7 +21594,6 @@ F:	drivers/xen/*swiotlb*
> >  XFS FILESYSTEM
> >  C:	irc://irc.oftc.net/xfs
> >  M:	Darrick J. Wong <djwong@kernel.org>
> > -M:	linux-xfs@vger.kernel.org
> >  L:	linux-xfs@vger.kernel.org
> >  S:	Supported
> >  W:	http://xfs.org/
> > -- 
> > 2.1.0
> > 
