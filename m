Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316E52546B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 16:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgH0OYi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 10:24:38 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:49655 "EHLO
        lizzy.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgH0OX5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=zq/QXOVptfn1AdVTcpOxxxE5X/Y530U8/53Apu8J6a0=; b=LuGUTydR7gZt9Z+cA34MW6L0eU
        C5xrrkmz8ppAuw+7kWtgraLe5YZ4iS/nyOXQLPhesUKvBel2hIRLXDf3miadDAhbxUrPe9JlU+93Y
        TvZL4M/0B1a9xYywLUBKiMuc43E2u0SjZq0T+ye/Jr9wdIl4Kbv984xwrf8Puw27yy65SkTyD19MT
        mXFsJFi+1xywMZWEB6iu3FPmlB1Md815MR/XONmRIeOBzK5vay8nDzZUL8TMVyLDxoQSDSSzqlWx2
        Uwxokp2WzNNMeWR8cXLEyxFIc1gFa9Q8KguQE/HknhLs72MDAmeE+DowOgqMcBjAwFvUoFvAHASQG
        tPEjjNcA==;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Frank van der Linden <fllinden@amazon.com>,
        Dave Chinner <david@fromorbit.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: file forks vs. xattr (was: xattr names for unprivileged stacking?)
Date:   Thu, 27 Aug 2020 16:23:24 +0200
Message-ID: <159855515.fZZa9nWDzX@silver>
In-Reply-To: <20200827140107.GH14765@casper.infradead.org>
References: <20200824222924.GF199705@mit.edu> <3331978.UQhOATu6MC@silver> <20200827140107.GH14765@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Donnerstag, 27. August 2020 16:01:07 CEST Matthew Wilcox wrote:
> On Thu, Aug 27, 2020 at 03:48:57PM +0200, Christian Schoenebeck wrote:
> > On Donnerstag, 27. August 2020 14:25:55 CEST Matthew Wilcox wrote:
> > > On Thu, Aug 27, 2020 at 02:02:42PM +0200, Christian Schoenebeck wrote:
> > > > What I could imagine as delimiter instead; slash-caret:
> > > >     /var/foo.pdf/^/forkname
> > >=20
> > > Any ascii character is going to be used in some actual customer
> > > workload.
> >=20
> > Not exactly. "/foo/^/bar" is already a valid path today. So every Linux
> > system (incl. all libs/apps) must be capable to deal with that path
> > already, so it would not introduce a tokenization problem.
>=20
> That's exactly the point.  I can guarantee you that some customer is
> already using a file named exactly '^'.

You are contradicting yourself. Ditching the idea because a file "^" might=
=20
exist, implies ditching your idea of "=F0=9F=92=A9" as it might already exi=
st as well.

> > > I suggest we use a unicode character instead.
> > >=20
> > > /var/foo.pdf/=F0=9F=92=A9/badidea
> >=20
> > Like I mentioned before, if you'd pick a unicode character (or binary),
> > then each shell will map their own ASCII-sequence on top of that. Becau=
se
> > shell users want ASCII. Which would defeat the primary purpose: a unifi=
ed
> > path resolution.
>=20
> You misunderstood.  This was my way of telling you that your idea is shit.

Be invited for making better suggestions. But one thing please: don't start=
=20
getting offending.

No matter which delimiter you'd choose, something will break. It is just ab=
out=20
how much will it break und how likely it'll be in practice, not if.

If you are concerned about not breaking anything: keep forks disabled.

Best regards,
Christian Schoenebeck


