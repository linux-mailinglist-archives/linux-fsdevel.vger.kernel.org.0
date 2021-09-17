Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A0C4101E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 01:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbhIQXvd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 19:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238808AbhIQXvb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:51:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4865261152;
        Fri, 17 Sep 2021 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631922608;
        bh=gICvNFGmS9Zmzx8nqaB//aApWFZGMN3814vhydFlU5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aVuVm6tDpFqjHHR/4OQ2GPg0H27lr6Rr0NQ3XT5JHKQrJvwDr7g74DrgbgZ7kRa5i
         I3puAf6fULquM0KjmR/ngS/AxvgF6RvkBnxYCeRY7StNnCoIOoDEp6nz4elhzmy4DJ
         MSI0iChlX1JW8pTnDpjSjn0bDo8DoIRsiXU+OIOsxEtFKiBga4JN5/RRnnuRjlt099
         n7a68X7FxvyG7Kcqt1Nw3xmr3C06pog7Mr2V8e7LchYCNFIcDJ+dG00jSdNtjCogH3
         09AR2FYDxeGtLoulVdR9FB1JxSun4febN8YsioMSmt011OvVHcT84zFf7wi5h2cAXH
         cKxkgitY7Vmbg==
Date:   Fri, 17 Sep 2021 16:50:07 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Chandan Babu R <chandan.babu@oracle.com>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] : Shameless plug for the FS Track at LPC next week!
Message-ID: <20210917235007.GC10224@magnolia>
References: <20210916013916.GD34899@magnolia>
 <87ilz0afjt.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20210917221124.GS2361455@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917221124.GS2361455@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 18, 2021 at 08:11:24AM +1000, Dave Chinner wrote:
> On Thu, Sep 16, 2021 at 05:38:38PM +0530, Chandan Babu R wrote:
> > On 16 Sep 2021 at 07:09, Darrick J. Wong wrote:
> > > Hi folks!
> > >
> > > The Linux Plumbers conference is next week!  The filesystems mini
> > > conference is next Tuesday, 21 September, starting at 14:00 UTC:
> > >
> > 
> > <snip>
> > 
> > >
> > > To all the XFS developers: it has been a very long time since I've seen
> > > all your faces!  I would love to have a developer BOF of some kind to
> > > see you all again, and to introduce Catherine Hoang (our newest
> > > addition) to the group.
> > >
> > > If nobody else shows up to the roadmap we could do it there, but I'd
> > > like to have /some/ kind of venue for everyone who don't find the
> > > timeslots convenient (i.e. Dave and Chandan).  This doesn't have to take
> > > a long time -- even a 15 minute meet and greet to help everyone
> > > (re)associate names with faces would go a long way towards feeling
> > > normal(ish) again. ;)
> > 
> > 14:00 UTC maps to 19:30 for me. I am fine with this time slot.
> 
> It maps to 12-4am for me. Not really practical :/

FWIW I'll try to commandeer one of the LPC hack rooms late Tuesday
evening (say around 0200 UTC) if people are interested in XFS office
hours?

(They also don't need to be on LPC's BBB instance; I /can/ host largeish
meetings on Zoom courtesy of $employer...)

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
