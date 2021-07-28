Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F5F3D95E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 21:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhG1TOe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 15:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG1TOe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 15:14:34 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBB5C061757;
        Wed, 28 Jul 2021 12:14:32 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7D8237C6F; Wed, 28 Jul 2021 15:14:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7D8237C6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1627499671;
        bh=eLHyd9f1nxMzdFMQUYsbq1YAVKzyuU/thj/3IlS+rN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GI/8MLOOvbWzAw3TGd39dplxrahRkVMDJve9j0rIzSxMgxbkYgIPJU2RNA+20tvV6
         +DbMjnPmh5Fezu+2M1UBC6L1yzcCBJNU1HbTceFM/t6ha5GZmx1lrLbnfXdoCyKHIy
         22WjvHwX9xsQc7ezqpGMeDw/SXBu6Yti3hc+XT14=
Date:   Wed, 28 Jul 2021 15:14:31 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     NeilBrown <neilb@suse.de>, Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
Message-ID: <20210728191431.GA3152@fieldses.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <20210728125819.6E52.409509F4@e16-tech.com>
 <20210728140431.D704.409509F4@e16-tech.com>
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>
 <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 28, 2021 at 08:26:12AM -0400, Neal Gompa wrote:
> I think this is behavior people generally expect, but I wonder what
> the consequences of this would be with huge numbers of subvolumes. If
> there are hundreds or thousands of them (which is quite possible on
> SUSE systems, for example, with its auto-snapshotting regime), this
> would be a mess, wouldn't it?

I'm surprised that btrfs is special here.  Doesn't anyone have thousands
of lvm snapshots?  Or is it that they do but they're not normally
mounted?

--b.
