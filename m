Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5313CAF07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 00:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhGOWRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 18:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231547AbhGOWRq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:17:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3BDD61278;
        Thu, 15 Jul 2021 22:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626387292;
        bh=SgJELlTSAdq220KSsy6qE+TbsJwWUUb96DSopClSFYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vnk5/oYWXUI/6cpJAgYt98kt4SzyXbJMneQjY2ew/BfFVdkPChfq84AFBxhUxztLa
         LmnXMGZuEGWvOv01yIXMoquwTWXbZDFFNgRvHj95kM33/Hp39hHzAtxDSCmCY/m9vx
         1Y9YslFNvIRzyBUgGlEziqb4mjcsck7HgPDO3GUr/inpugLYG6yA4vhHskDytv2BCL
         N5gMO/1m98G79oyynsT9xNb8BuhO3Gb8qj3RxV5DKwgdCKhNX4PhezbxzAEgG6tPpv
         Dppsi59MqDp8PGiR1JO9uBSWaqWApKfwDWh4XBZHvPDVlLr0NBb1h65PPoFZZgMo7E
         /itUmX6ILFy/A==
Date:   Thu, 15 Jul 2021 15:14:52 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Rafa?? Mi??ecki <zajec5@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Message-ID: <20210715221452.GV22357@magnolia>
References: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
 <CAHk-=wjW7Up3KD-2EqVg7+ca8Av0-rC5Kd7yK+=m6Dwk3D4Q+A@mail.gmail.com>
 <YO30DKw5FKLz4QuF@zeniv-ca.linux.org.uk>
 <bea2bcf2-02f6-f247-9e06-7b9ec154377a@gmail.com>
 <YO755O8JnxG44YaT@kroah.com>
 <7f4a96bc-3912-dfb6-4a32-f0c6487d977b@gmail.com>
 <20210714161352.GA22357@magnolia>
 <YO8OP7vzHIuKvO6X@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO8OP7vzHIuKvO6X@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 05:18:07PM +0100, Christoph Hellwig wrote:
> On Wed, Jul 14, 2021 at 09:13:52AM -0700, Darrick J. Wong wrote:
> > Porting to fs/iomap can be done after merge, so long as the ntfs3
> > driver doesn't depend on crazy reworking of buffer heads or whatever.
> > AFAICT it didn't, so ... yes, my earlier statements still apply: "later
> > as a clean up".
> 
> I on the other hand hate piling up mor of this legacy stuff, as it tends
> to not be cleaned up by the submitted.  Example: erofs still hasn't
> switched to iomap despite broad claims,

<shrug> I was letting that one go while willy tries to land all the
folio surgery on the iomap code.

> also we still have a huge backlog in the switch to the new mount API.

That's true, though having /read/ the xfs conversion series, I'm not
surprised that most maintainers don't want to do the heavy lift
themselves.

--D
