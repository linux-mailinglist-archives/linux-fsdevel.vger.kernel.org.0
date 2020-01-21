Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6A0B1434FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 01:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAUA4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 19:56:35 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:38220 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgAUA4f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 19:56:35 -0500
Received: by mail-il1-f196.google.com with SMTP id f5so996284ilq.5;
        Mon, 20 Jan 2020 16:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DSU92DS/yk36ylsfrVTivyXxIB5DGgZzKoQw5FMazZY=;
        b=lq3pSIbPrnnnlke+/4iOv3idDrtKaxngImB5W4zXOYg1EKO6Pp/w7whzo54rLNLeXD
         +upd7lCyLeHSvzSyTGOEZ71HRLKodR6Vq6Y+YZDRrqxQY6FpB2JSqglWu3jYaue8ENEF
         KVlRJxNOLvZvEVdMFQyQsqQsNkHhSowq+YUp9GmtW99GGM6pTonzZVhMoIzr0+I9PgT1
         LHLkw3uXhT5pCCltzzyFk9YEGZuHNt0PgobNHpEXDqdkB9j9GIx1MFBmPfzi7lEZusgc
         trp5oxFAdOiZz4/VNfWdeu6+/xXPge3HxZ120zDU1x/Tc0n5mhiGTxLpvL7KElejcARN
         q7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DSU92DS/yk36ylsfrVTivyXxIB5DGgZzKoQw5FMazZY=;
        b=K/+h40DHTBmtVNg5FwebVBscKsXm8M3odUGi2HZUge8mxVsP6UmMaYiqC6Y9xVARgB
         uoHpmO4FV2GjYGlZTgT+LUmEHWxYT9nlIjTDrv24MFOB7sMwzjCXLLHLLeFWRVjuRy5Q
         NSJi6L/i9ljgF9D3epIScf8BZIe5s/dzKMeueLK4PlXO+8BH+i+ylkgqq2hJfaJ3F4yb
         2JrNIqvzBFYKW8UeHj7btk3HWTx1mgVTXDqEkE29kZLBinY8waNc2Cqi7REgD4fZ+m8M
         PjrLMAqMRmyTbULOHi6u8CLOEAHIm3UmuJk0Kqo6S1M6z1YYiGzyrN38QtxoP4FR5X0M
         9wGw==
X-Gm-Message-State: APjAAAXoen+CAgju1+EWWCUjRxJXEJllfVj3oBumGzTNoxRFtRmHq0xA
        C0mY9fSE7tUor13fS9OP5Zk7wKedRyK93wbcn1A=
X-Google-Smtp-Source: APXvYqw9x3JAIzpZdG5I877D51seRujGg/PdSB1zVxtbiLT765Kfy8muncBvKsCU7feAIIHxlvYj1DUTZ+EL8c5IAF4=
X-Received: by 2002:a92:d642:: with SMTP id x2mr1533285ilp.169.1579568194666;
 Mon, 20 Jan 2020 16:56:34 -0800 (PST)
MIME-Version: 1.0
References: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
 <5d5a93637934867e1b3352763da8e3d9f9e6d683.camel@kernel.org>
 <20191001181659.GA5500@iweiny-DESK2.sc.intel.com> <2b42cf4ae669cedd061c937103674babad758712.camel@kernel.org>
 <20191002192711.GA21386@fieldses.org> <df9022f0f5d18d71f37ed494a05eaa4509cf0a68.camel@kernel.org>
 <20191003153743.GA24657@fieldses.org>
In-Reply-To: <20191003153743.GA24657@fieldses.org>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 20 Jan 2020 18:56:24 -0600
Message-ID: <CAH2r5msqzPnL=-Vm5F_MCc64pfCdMg0UXw8qkmp6zK1cph-_ZQ@mail.gmail.com>
Subject: Re: Lease semantic proposal
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-nvdimm@lists.01.org,
        linux-mm <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Two common complaints about the current lease API is that for some of the
common protocols like SMB3 there is the need to be able to pass in
the lease request on open itself, and also to
upgrade and downgrade leases (in SMB3 lease keys can be
passed over the wire) and of course it would be helpful if
information about whether a lease was aquired were returned on open
(and create) to minimize syscalls.

On Thu, Oct 3, 2019 at 11:00 AM J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>
> On Wed, Oct 02, 2019 at 04:35:55PM -0400, Jeff Layton wrote:
> > On Wed, 2019-10-02 at 15:27 -0400, J. Bruce Fields wrote:
> > > On Wed, Oct 02, 2019 at 08:28:40AM -0400, Jeff Layton wrote:
> > > > For the byte ranges, the catch there is that extending the userland
> > > > interface for that later will be difficult.
> > >
> > > Why would it be difficult?
> >
> > Legacy userland code that wanted to use byte range enabled layouts woul=
d
> > have to be rebuilt to take advantage of them. If we require a range fro=
m
> > the get-go, then they will get the benefit of them once they're
> > available.
>
> I can't see writing byte-range code for a kernel that doesn't support
> that yet.  How would I test it?
>
> > > > What I'd probably suggest
> > > > (and what would jive with the way pNFS works) would be to go ahead =
and
> > > > add an offset and length to the arguments and result (maybe also
> > > > whence?).
> > >
> > > Why not add new commands with range arguments later if it turns out t=
o
> > > be necessary?
> >
> > We could do that. It'd be a little ugly, IMO, simply because then we'd
> > end up with two interfaces that do almost the exact same thing.
> >
> > Should byte-range layouts at that point conflict with non-byte range
> > layouts, or should they be in different "spaces" (a'la POSIX and flock
> > locks)? When it's all one interface, those sorts of questions sort of
> > answer themselves. When they aren't we'll have to document them clearly
> > and I think the result will be more confusing for userland programmers.
> I was hoping they'd be in the same space, with the old interface just
> defined to deal in locks with range [0,=E2=88=9E).
>
> I'm just worried about getting the interface wrong if it's specified
> without being implemented.  Maybe this is straightforward enough that
> there's not a risk, I don't know.

Yes


--=20
Thanks,

Steve
