Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0AF3C8657
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 16:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhGNOyL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 10:54:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231797AbhGNOyK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:54:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9374A613B2;
        Wed, 14 Jul 2021 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626274279;
        bh=8a56edqbL7wFXbEbH0kikC1Gb/ARmN3rMsit7qdIQ/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zVNF8elUynZuna7aD0fb5VJZuBEgms8ElCz1x0l0F6cApBMXiacarid8dwBUdOds1
         rHbvRGntvDUGQm3xRU99htK0jsT4x8Ea8IbbdxzbQbQ2mFcaiX1voCIFvJ07Ly7AHI
         MAJd7KVx7kEHxmdukYZb4v/BQDMVgzMFRDuCRJo4=
Date:   Wed, 14 Jul 2021 16:51:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Message-ID: <YO755O8JnxG44YaT@kroah.com>
References: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
 <CAHk-=wjW7Up3KD-2EqVg7+ca8Av0-rC5Kd7yK+=m6Dwk3D4Q+A@mail.gmail.com>
 <YO30DKw5FKLz4QuF@zeniv-ca.linux.org.uk>
 <bea2bcf2-02f6-f247-9e06-7b9ec154377a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bea2bcf2-02f6-f247-9e06-7b9ec154377a@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 12:50:08PM +0200, Rafał Miłecki wrote:
> Hi Alexander,
> 
> On 13.07.2021 22:14, Al Viro wrote:
> > To elaborate a bit - there's one case when I want it to go through
> > vfs.git, and that's when there's an interference between something
> > going on in vfs.git and the work done in filesystem.  Other than
> > that, I'm perfectly fine with maintainer sending pull request directly
> > to Linus (provided that I hadn't spotted something obviously wrong
> > in the series, of course, but that's not "I want it to go through
> > vfs.git" - that's "I don't want it in mainline until such and such
> > bug is resolved").
> 
> let me take this opportunity to ask about another filesystem.
> 
> Would you advise to send pull req for the fs/ntfs3 directly to Linus?
> 
> That is a pending filesystem that happens to be highly expected by many
> Linux focused communities.
> 
> 
> Paragon Software GmbH proved it's commitment by sending as many as 26
> versions on it's patchset. The last set was send early April:
> 
> [PATCH v26 00/10] NTFS read-write driver GPL implementation by Paragon Software
> https://marc.info/?l=linux-fsdevel&m=161738417018673&q=mbox
> https://patchwork.kernel.org/project/linux-fsdevel/list/?series=460291
> 
> 
> I'd say there weren't any serious issues raised since then.
> 
> One Tested-by, one maintenance question, one remainder, one clang-12
> issue [0] [1].
> 
> It seems this filesystem only needs:
> 1. [Requirement] Adjusting to the meanwhile changed iov API [2]
> 2. [Clean up] Using fs/iomap/ helpers [3]

Why haven't those things been done and the patches resubmitted for
review?  Nothing we can do from our side when the developers don't want
to submit a new series, right?

thanks,

greg k-h
