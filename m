Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7CA18C268
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 22:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgCSVkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 17:40:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51888 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbgCSVkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 17:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584654050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pD2QLHhMMC0hMij2LitoFlwgBXHTclhOvCrWdxE1e4s=;
        b=Lrtb60We9ToI3CPEt1qUuJAzIx8YxV4vD2xp/Xz0qZoirbgFua7dx6jDnw+qti+mfYGJhi
        ru9krS1Hbh1LJsagp8uTK4xrLgMENsl1cXJnTYhVD7LVySDsWezW+sJk9Dvoh6IRbw+HWZ
        iyRUpxkifFDAkB48pzjIxhKRooqDcFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-d-B74DyfOYu7Nq3RZue8rA-1; Thu, 19 Mar 2020 17:40:46 -0400
X-MC-Unique: d-B74DyfOYu7Nq3RZue8rA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD21918B5F69;
        Thu, 19 Mar 2020 21:40:45 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-200.rdu2.redhat.com [10.10.116.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CEE5BBBC0;
        Thu, 19 Mar 2020 21:40:45 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id CB986220001; Thu, 19 Mar 2020 17:40:44 -0400 (EDT)
Date:   Thu, 19 Mar 2020 17:40:44 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: unionmount testsuite with upper virtiofs
Message-ID: <20200319214044.GB83565@redhat.com>
References: <20200131115004.17410-5-mszeredi@redhat.com>
 <20200204145951.GC11631@redhat.com>
 <CAJfpegtq4A-m9vOPwUftiotC_Xv6w-dnhCi9=E0t-b1ZPJXPGw@mail.gmail.com>
 <CAOQ4uxj_pVp9-EN2Gmq9j6G3xozzpK_zQiRO-brx6PZ9VpgD0Q@mail.gmail.com>
 <CAOQ4uxjFYO28r+0pY+pKxK-dDJcQF2nf2EivnOUBgrgkYTFjPQ@mail.gmail.com>
 <CAOQ4uxhZ8a2ObfB9sUtrc=95mM70qurLtXkaNyHOXYxGEKvxFw@mail.gmail.com>
 <CAOQ4uxhkd5FkN5ynpQxQ0m1MR9MgzTBbvzjkoHfSRA2umb-JTA@mail.gmail.com>
 <20200316175453.GB4013@redhat.com>
 <CAOQ4uxgfTJwE2O1GGt-TY+6ijjKE13+ATTarijFGLiM69jk8HA@mail.gmail.com>
 <CAOQ4uxhWLjsxy21MMKUOvMsWmWTWhKP0hwLQoD99xVcWbbmFmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhWLjsxy21MMKUOvMsWmWTWhKP0hwLQoD99xVcWbbmFmA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 18, 2020 at 03:36:44PM +0200, Amir Goldstein wrote:
> > > I also wanted to run either overlay xfstests or unionmount-testsuite. But
> > > none of these seem to give me enough flexibility where I can specify
> > > that overlayfs needs to be mounted on top of virtiofs.
> > >
> > > I feel that atleast for unionmount-testsuite, there should be an
> > > option where we can simply give a target directory and tests run
> > > on that directory and user mounts that directory as needed.
> > >
> >
> > Need to see how patches look.
> > Don't want too much configuration complexity, but I agree that some
> > flexibly is needed.
> > Maybe the provided target directory should be the upper/work basedir?
> >
> 
> Vivek,
> 
> I was going to see what's the best way to add the needed flexibility,
> but then I realized I had already implemented this undocumented
> feature.
> 
> I have been using this to test overlay over XFS as documented here:
> https://github.com/amir73il/overlayfs/wiki/Overlayfs-testing#Setup_overlayfs_mount_over_XFS_with_reflink_support
> 
> That's an example of how to configure a custom /base mount for
> --samefs to be xfs.

Hi Amir,

This seems to work for me. Thanks for the idea.

I put following entries in /etc/fstab.

myfs	/mnt/virtiofs-lower_layer	virtiofs	defaults 0 0
/mnt/virtiofs-lower_layer	/base	none	bind 0 0

After that tests seem to start but soon I hit failures. Now its time
to debug the failures one at a time.

Vivek

