Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1A168750F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 06:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjBBFZZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 00:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBBFZY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 00:25:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD2C7961E;
        Wed,  1 Feb 2023 21:25:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74536B82410;
        Thu,  2 Feb 2023 05:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD492C433D2;
        Thu,  2 Feb 2023 05:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675315520;
        bh=4Xa7NWVC4d/FR7xFutm0ke8+n8wpmUB+wAFRyD4NjCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y01TkEHOkuhrDXEjlssKXQb8kJGZnMZd21gw0XJxOQz6NGQiqNpkiya1ishRzr+TQ
         MQdv+SfY1lbGW87HJ+mybvlIuPT0U24rV7IErZw+CIY4/SjdTi54jqirGTEciBQS2f
         G+bRDA3XcTJDLOV/IahUn45j9lk2OIoDa877Pkdnsjn+1iR9fDZR+pEBrrhsj+/Huf
         DQyOymM3XOuB40eqKp3sT/8ELO90jcuQbnaHJoDqrnGv3yNKmHHNsvF1OcIbkzfxmO
         k/u8QB/+pntNtehoIKcLHFbgXVgCb9vvqpmcQGtitXBh37JpFufwVqGL4qF1mtmZbJ
         ADXmzFRxyDHKQ==
Date:   Wed, 1 Feb 2023 21:25:18 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: filesystems: vfs: actualize struct
 super_operations description
Message-ID: <Y9tJPn0a/O27SBuJ@sol.localdomain>
References: <20230131121608.177250-1-aleksandr.mikhalitsyn@canonical.com>
 <87bkme4gwu.fsf@meer.lwn.net>
 <CAEivzxfxkWtYP4bqFrmD__3M9WpJNZjTJNx9wp4WQ0_LoGKT6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEivzxfxkWtYP4bqFrmD__3M9WpJNZjTJNx9wp4WQ0_LoGKT6g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 31, 2023 at 10:12:42PM +0100, Aleksandr Mikhalitsyn wrote:
> On Tue, Jan 31, 2023 at 8:56 PM Jonathan Corbet <corbet@lwn.net> wrote:
> >
> > Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com> writes:
> >
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Cc: linux-doc@vger.kernel.org
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > > ---
> > >  Documentation/filesystems/vfs.rst | 74 ++++++++++++++++++++++++-------
> > >  1 file changed, 59 insertions(+), 15 deletions(-)
> >
> > Thanks for updating this document!  That said, could I ask you, please,
> > to resubmit these with a proper changelog?  I'd also suggest copying Al
> > Viro, who will surely have comments on the changes you have made.
> 
> Hi, Jonathan!
> 
> Sure. Have done and of course I've to add Al Viro to CC, but forgot to do that,
> cause scripts/get_maintainer.pl have didn't remind me (-:
> 
> >
> > > diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> > > index fab3bd702250..8671eafa745a 100644
> > > --- a/Documentation/filesystems/vfs.rst
> > > +++ b/Documentation/filesystems/vfs.rst
> > > @@ -242,33 +242,42 @@ struct super_operations
> > >  -----------------------
> > >
> > >  This describes how the VFS can manipulate the superblock of your
> > > -filesystem.  As of kernel 2.6.22, the following members are defined:
> > > +filesystem.  As of kernel 6.1, the following members are defined:
> >
> > Why not 6.2 while you're at it?  We might as well be as current as we
> > can while we're updating things.
> 
> I'm on 6.2, but for some reason decided to put 6.1. Will fix it :)
> 

It would be better to just remove the version number.  Whenever documentation
says something like "as of vX.Y.Z", people usually forget to update the version
number when updating the documentation.  So then we end up in the situation
where the documentation actually describes the latest kernel version, but it
claims to be describing an extremely old kernel version.

- Eric
