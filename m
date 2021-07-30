Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F883DBBEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 17:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbhG3PRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 11:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239509AbhG3PRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:17:54 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14A5C061765;
        Fri, 30 Jul 2021 08:17:49 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 765D96C0C; Fri, 30 Jul 2021 11:17:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 765D96C0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1627658268;
        bh=Li85SDlcyV77joGjmGDEsUglXDaV5Llbu6EqziOjsyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmBdBXPsolGx/6yQJRZFOCw1ozPtQ3p9NLGLQPVTKL8SGFMkIiiHLmQxDrTMcR/w8
         Cm5TAbqvKfh6Kc94qsr0O54PvbB3Vrn38d7tI2h+LumarzcT8OqZEsyTRoo6lDG75L
         Uz8vZbrwqRkgMQKewqArRRbp5TnloKzSZhbYvyKk=
Date:   Fri, 30 Jul 2021 11:17:48 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     NeilBrown <neilb@suse.de>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Neal Gompa <ngompa13@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
Message-ID: <20210730151748.GA21825@fieldses.org>
References: <162745567084.21659.16797059962461187633@noble.neil.brown.name>
 <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>
 <162751265073.21659.11050133384025400064@noble.neil.brown.name>
 <20210729023751.GL10170@hungrycats.org>
 <162752976632.21659.9573422052804077340@noble.neil.brown.name>
 <20210729232017.GE10106@hungrycats.org>
 <162761259105.21659.4838403432058511846@noble.neil.brown.name>
 <341403c0-a7a7-f6c8-5ef6-2d966b1907a8@gmx.com>
 <162762468711.21659.161298577376336564@noble.neil.brown.name>
 <bcde95bc-0bb8-a6e9-f197-590c8a0cba11@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcde95bc-0bb8-a6e9-f197-590c8a0cba11@gmx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 30, 2021 at 02:23:44PM +0800, Qu Wenruo wrote:
> OK, forgot it's an opt-in feature, then it's less an impact.
> 
> But it can still sometimes be problematic.
> 
> E.g. if the user want to put some git code into one subvolume, while
> export another subvolume through NFS.
> 
> Then the user has to opt-in, affecting the git subvolume to lose the
> ability to determine subvolume boundary, right?

Totally naive question: is it be possible to treat different subvolumes
differently, and give the user some choice at subvolume creation time
how this new boundary should behave?

It seems like there are some conflicting priorities that can only be
resolved by someone who knows the intended use case.

--b.
