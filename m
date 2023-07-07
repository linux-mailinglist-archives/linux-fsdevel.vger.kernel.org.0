Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731E674AD52
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 10:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjGGItE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 04:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjGGItD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:49:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEB01FCE;
        Fri,  7 Jul 2023 01:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B05861886;
        Fri,  7 Jul 2023 08:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E626C433C7;
        Fri,  7 Jul 2023 08:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688719741;
        bh=Bp2gaXLnBG1Um7uLrVB3bxxujt1nzvLgFiFXO/CIaEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rpsPBAogvfSbhngrpmukMVPwKoK7n+8X7JvrClKP6i0saGW36EMdUA5w6QfP5OS6m
         xeL73Q+Kde5MB7YwNzh68pild7+eAGGaNUpA03Jx8zP2lcAGuG4NF+R0M95zhoMiZm
         hd4oB11ck7SeWHlbC7fRdwyTQxn8pp8bTVT8J7JR6oNhEi2d97Wvm882bSqalkgdrr
         ygCpNvs49SeddLushl1skZTkVemYfw6zMFRZ+iezI1DwDiuIfUJnoi5RkRfcGa/6AN
         Nuy9Kt/iCxCoDtQcvuz/rN4UunXXi/P4lkr5KvZg+2gIFYji9Fsm/zQyFD7PESKGyq
         5IFMjd1qotnTQ==
Date:   Fri, 7 Jul 2023 10:48:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Josef Bacik <josef@toxicpanda.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        tytso@mit.edu, bfoster@redhat.com, jack@suse.cz,
        andreas.gruenbacher@gmail.com, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230707-badeverbot-gekettet-19ce3c238dac@brauner>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230706164055.GA2306489@perftesting>
 <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
 <20230706211914.GB11476@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230706211914.GB11476@frogsfrogsfrogs>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> just merge it and let's move on to the next thing."

"and let the block and vfs maintainers and developers deal with the fallout"

is how that reads to others that deal with 65+ filesystems and counting.

The offlist thread that was started by Kent before this pr was sent has
seen people try to outline calmly what problems they currently still
have both maintenance wise and upstreaming wise. And it seems there's
just no way this can go over calmly but instead requires massive amounts
of defensive pushback and grandstanding.

Our main task here is to consider the concerns of people that constantly
review and rework massive amounts of generic code. And I can't in good
conscience see their concerns dismissed with snappy quotes.

I understand the impatience, I understand the excitement, I really do.
But not in this way where core people just drop off because they don't
want to deal with this anymore.

I've spent enough time on this thread.
