Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEA578C9AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 18:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbjH2QaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 12:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbjH2Q3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:29:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0F319A
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 09:29:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C4F365CBB
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 16:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A34C433C8;
        Tue, 29 Aug 2023 16:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693326578;
        bh=tlN8nBSSDF4hGNNvaH2Lf7tePMhMUTQXHHmQdl1FQ8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kiuXnnEiMw6j8Z+N3/doQUok4CXecQGg/7FmCBus4BRF+fzy+ubJUNJTVBbd/T9Sy
         8/wtviOp3+8+JP7IcWWytP39fDk++bT7eLHMYHy8t1Ge0AOjEaBa0POaGwu8qkAk/u
         BVsp6qOGaNs/ecBZw9IcdLYDlZPoE5vRebxsLpKFjVpPxb5IMVHwrGaDZCQpyzFL6q
         F90OavWkaO3jPJDpfGuzqk9WxoHsm/Cl6u454Fbm+DdPyEGFfxjeGRO8tDjal19x4u
         MRIsTh2Zd+gOEKgKNRxhr2HF6LOHrtz84CKraEp/xHerRftMD67cuuhN4si3LGTjwO
         2tH8OPiFTodYQ==
Date:   Tue, 29 Aug 2023 18:29:34 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: mtd
Message-ID: <20230829-sitzbank-birnen-3f1d57889723@brauner>
References: <20230829-weitab-lauwarm-49c40fc85863@brauner>
 <20230829125118.GA24767@lst.de>
 <20230829-erzeugen-verruf-6c06640844b0@brauner>
 <20230829-abkassieren-pizzen-c34ca3731a5c@brauner>
 <20230829140953.GA31558@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829140953.GA31558@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 29, 2023 at 04:09:53PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 29, 2023 at 03:41:04PM +0200, Christian Brauner wrote:
> > On Tue, Aug 29, 2023 at 02:57:02PM +0200, Christian Brauner wrote:
> > > On Tue, Aug 29, 2023 at 02:51:18PM +0200, Christoph Hellwig wrote:
> > > > On Tue, Aug 29, 2023 at 01:46:20PM +0200, Christian Brauner wrote:
> > > > > Something like the following might already be enough (IT'S A DRAFT, AND
> > > > > UNTESTED, AND PROBABLY BROKEN)?
> > > > 
> > > > It's probably the right thing conceptually, but it will also need
> > > > the SB_I_RETIRED from test_bdev_super_fc or even just reuse
> > > > test_bdev_super_fc after that's been renamed to be more generic.
> > > 
> > > I'll rename it and use it. Let me send a patch.
> > 
> > Hmkay, how does that look? I think this is a fairly acceptable change
> > and looks better than the mtd special-test/set-sauce we currently have:
> 
> Looks sensibe to me, but please run it past the MTD maintainers.

Done.
