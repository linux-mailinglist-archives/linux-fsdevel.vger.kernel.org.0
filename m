Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73023312887
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 01:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBHARg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 19:17:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:40750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhBHARg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 19:17:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52512AD8C;
        Mon,  8 Feb 2021 00:16:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A28D2DA80F; Mon,  8 Feb 2021 01:15:01 +0100 (CET)
Date:   Mon, 8 Feb 2021 01:15:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Amy Parker <enbyamy@gmail.com>, dsterba@suse.cz,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] fs/efs: Follow kernel style guide
Message-ID: <20210208001501.GO1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Amy Parker <enbyamy@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210205045217.552927-1-enbyamy@gmail.com>
 <20210205131910.GJ1993@twin.jikos.cz>
 <CAE1WUT4az3ZZ8OU2AS2xxi9h1TbW958ivNXr53jinqHK5vuzMg@mail.gmail.com>
 <CAFLxGvz0ZnTs1B7v3R+Zefd5BhE9ximFpgKL8zRmGfOdBrsVfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvz0ZnTs1B7v3R+Zefd5BhE9ximFpgKL8zRmGfOdBrsVfw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 05, 2021 at 11:37:46PM +0100, Richard Weinberger wrote:
> On Fri, Feb 5, 2021 at 11:26 PM Amy Parker <enbyamy@gmail.com> wrote:
> >
> > On Fri, Feb 5, 2021 at 5:1 AM David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Thu, Feb 04, 2021 at 08:52:14PM -0800, Amy Parker wrote:
> > > > As the EFS driver is old and non-maintained,
> > >
> > > Is anybody using EFS on current kernels? There's not much point updating
> > > it to current coding style, deleting fs/efs is probably the best option.
> > >
> >
> > Wouldn't be surprised if there's a few systems out there that haven't
> > migrated at all.
> 
> Before ripping it from the kernel source you could do a FUSE port of EFS.
> That way old filesystems can still get used on Linux.

Agreed, replacing the obsolete filesystems by FUSE implementations would
be great. Regarding EFS I got pointed to
https://github.com/sophaskins/efs2tar that allows to access the old IRIX
CDs (can be found on archive.org), so there's something.
