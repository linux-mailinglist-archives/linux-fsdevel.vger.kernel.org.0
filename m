Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C29778C78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 12:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjHKKyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 06:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjHKKyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:54:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70003E4D;
        Fri, 11 Aug 2023 03:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4D7866F97;
        Fri, 11 Aug 2023 10:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B77C433C8;
        Fri, 11 Aug 2023 10:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691751288;
        bh=JVHSg+j8T7tjWMLpPjesj2X6nhRSSTJ6onf4iPM0Q0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQlXHtaBRaQD2g+XXZphgN3D3S7rvZBRHLgLrFEqBsZV7v1BSogA5kG6rsqhkPvpu
         XLvMWu+mxvvlbNmW5A8H2ZzXG4kK6U+Eq6sJsxjVPF9c4rJVY1h2dEzypCOiRr1jCN
         cATVvWAPTdmwDWYg3Oc+kfdree70sU2WubeTuEDD/k+8fV1y6DNUJ/O5MSbLzM49th
         R4WFXSVrtyThLKwIauEfyVTB0aV+zGiqkw1Wt132nR7tPOoa4895MgJv2d2Y1tmYkC
         OnrG8NOp9SHIx36yYlnPsEj5e7lanHu6VGDx2qhYJ/fOstvHckCs3cLS0V4r0mHDcj
         AA7/Bc1/Gjelw==
Date:   Fri, 11 Aug 2023 12:54:42 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com, snitzer@kernel.org,
        axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230811-neigt-baufinanzierung-4c9521b036c6@brauner>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I don't want to do that to Christian either, I think highly of the work
> he's been doing and I don't want to be adding to his frustration. So I
> apologize for loosing my cool earlier; a lot of that was frustration
> from other threads spilling over.
> 
> But: if he's going to be raising objections, I need to know what his
> concerns are if we're going to get anywhere. Raising objections without
> saying what the concerns are shuts down discussion; I don't think it's
> unreasonable to ask people not to do that, and to try and stay focused
> on the code.

The technical aspects were made clear off-list and I believe multiple
times on-list by now. Any VFS and block related patches are to be
reviewed and accepted before bcachefs gets merged.

This was also clarified off-list before the pull request was sent. Yet,
it was sent anyway.

On the receiving end this feels disrespectful. To other maintainers this
implies you only accept Linus verdict and expect him to ignore
objections of other maintainers and pull it all in. That would've caused
massive amounts of frustration and conflict should that have happened.
So this whole pull request had massive potential to divide the
community. And in the end you were told the same requirements that we
did have and then you accepted it but that cannot be the only barrier
that you accept.

And it's not just all about code. Especially from a maintainer's
perspective. There's two lengthy mails from Darrick and from you with
detailed excursions about social aspects as well.

Social aspects in fact often come into the center whenever we focus on
code. There will be changes that a sub-maintainer may think are
absolutely required and that infrastructure maintainers will reject for
reasons that the sub-maintainer might fundamentally disagree with and we
need to be confident that a maintainer can handle this gracefully and
respectfully. If there's strong indication to the contrary it's a
problem that can't be ignored.

To address this issue I did request at LSFMM that I want a co-maintainer
for bcachefs that can act as a counterweight and balancing factor. Not
just a reviewer but someone who is designated in making decisions in
addition to you and can step in. That would be may preferred thing.

Timeline wise, my preference would be if we could get the time to finish
the super work that Christoph and Jan are currently doing and have a
cycle to see how badly the world breaks. And then we aim to merge
bcachefs for v6.7 in November. That's really not far away and also gives
everyone the time to calm down a little.
