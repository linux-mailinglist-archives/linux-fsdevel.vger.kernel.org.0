Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D585A6C3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 20:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiH3Scs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 14:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiH3Scq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:32:46 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331B46C768;
        Tue, 30 Aug 2022 11:32:45 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 74CEF61B2; Tue, 30 Aug 2022 14:32:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 74CEF61B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1661884364;
        bh=t6A49DAKcUjYnrJBqtDT4iG90zCiYbqrgUVgWSnHASc=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=Od1O16flgP0Xp/wDCethqQnKUDrZ/sWnO/vOOWYf37FPP5PkOCwcJa40y5RAbAirz
         JnR6g9bJ10IVnbL21iyJz9nAZIDFZp7aoMH6NlbE5+7FAF6klH1QMd19Cw6jU5N0il
         1yC+/0/77oqMetI0uoA7CU1QDEGDRrplh24MXNb0=
Date:   Tue, 30 Aug 2022 14:32:44 -0400
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-ceph@vger.kernel.org" <linux-ceph@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "walters@verbum.org" <walters@verbum.org>
Subject: Re: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
Message-ID: <20220830183244.GG26330@fieldses.org>
References: <549776abfaddcc936c6de7800b6d8249d97d9f28.camel@kernel.org>
 <166181389550.27490.8200873228292034867@noble.neil.brown.name>
 <f5c42c0d87dfa45188c2109ccf9baeb7a42aa27e.camel@kernel.org>
 <20220830132443.GA26330@fieldses.org>
 <a07686e7e1d1ef15720194be2abe5681f6a6c78e.camel@kernel.org>
 <20220830144430.GD26330@fieldses.org>
 <e4815337177c74a9928098940dfdcb371017a40c.camel@hammerspace.com>
 <20220830151715.GE26330@fieldses.org>
 <3e8c7af5d39870c5b0dc61736a79bd134be5a9b3.camel@hammerspace.com>
 <4adb2abd1890b147dbc61a06413f35d2f147c43a.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4adb2abd1890b147dbc61a06413f35d2f147c43a.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 30, 2022 at 01:02:50PM -0400, Jeff Layton wrote:
> The fact that NFS kept this more loosely-defined is what allowed us to
> elide some of the i_version bumps and regain a fair bit of performance
> for local filesystems [1]. If the change attribute had been more
> strictly defined like you mention, then that particular optimization
> would not have been possible.
> 
> This sort of thing is why I'm a fan of not defining this any more
> strictly than we require. Later on, maybe we'll come up with a way for
> filesystems to advertise that they can offer stronger guarantees.

Yeah, the afs change-attribute-as-counter thing seems ambitious--I
wouldn't even know how to define what exactly you're counting.

My one question is whether it'd be worth just defining the thing as
*increasing*.  That's a lower bar.

(Though admittedly we don't quite manage it now--see again 1631087ba872
"Revert "nfsd4: support change_attr_type attribute"".)

--b.
