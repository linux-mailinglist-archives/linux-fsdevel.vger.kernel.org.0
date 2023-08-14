Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F238977B245
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 09:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjHNHVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 03:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjHNHVa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:21:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDA5E75;
        Mon, 14 Aug 2023 00:21:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD43261178;
        Mon, 14 Aug 2023 07:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE65C433C7;
        Mon, 14 Aug 2023 07:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691997689;
        bh=IPfVHIU3EHRxOeB4Potpwr18tukfqicP2aJAZxi9gwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KlCibmQ2SiL40RdGbitFweTr6+EiTRcc3tyvaC5oCaqY79IeUgdzzHQ6t4BLdcLiY
         LjUF0Z3d4h5U+Ga/RK+3YdDbSECOXj4/V/XBa0HbvMAsn5E/CkvoSbAmuKDlGthrfX
         35jvGkmeKi7xlokdZ/65ju1EvS93xZiyCPAuYaEXxMbR+A57mpkRRUwrsL9Ycd3cBA
         GeNQ8eVVpAJ0laNFJP3iQuvGPtwryWePw9i6cyoVoWIIH/Z44ljJuQ7PND0QaHMRg4
         7t8Owowf9KziNKrSkGBiHE8Cp9Q7qBYjLxFoe1piN1vkrjWlMyVKzN+MIWLcckmoyA
         HnYMgKfN1Tirg==
Date:   Mon, 14 Aug 2023 09:21:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com, snitzer@kernel.org,
        axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230814-sekte-asche-5dcf68ec21ba@brauner>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
 <20230811-neigt-baufinanzierung-4c9521b036c6@brauner>
 <20230811132141.qxppoculzs5amawn@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811132141.qxppoculzs5amawn@moria.home.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 09:21:41AM -0400, Kent Overstreet wrote:
> On Fri, Aug 11, 2023 at 12:54:42PM +0200, Christian Brauner wrote:
> > > I don't want to do that to Christian either, I think highly of the work
> > > he's been doing and I don't want to be adding to his frustration. So I
> > > apologize for loosing my cool earlier; a lot of that was frustration
> > > from other threads spilling over.
> > > 
> > > But: if he's going to be raising objections, I need to know what his
> > > concerns are if we're going to get anywhere. Raising objections without
> > > saying what the concerns are shuts down discussion; I don't think it's
> > > unreasonable to ask people not to do that, and to try and stay focused
> > > on the code.
> > 
> > The technical aspects were made clear off-list and I believe multiple
> > times on-list by now. Any VFS and block related patches are to be
> > reviewed and accepted before bcachefs gets merged.
> 
> Here's the one VFS patch in the series - could we at least get an ack
> for this? It's a new helper, just breaks the existing d_tmpfile() up
> into two functions - I hope we can at least agree that this patch
> shouldn't be controversial?
> 
> -->--
> Subject: [PATCH] fs: factor out d_mark_tmpfile()
> 
> New helper for bcachefs - bcachefs doesn't want the
> inode_dec_link_count() call that d_tmpfile does, it handles i_nlink on
> its own atomically with other btree updates
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org

Yep, that looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
