Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54F29BAFFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 10:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbfIWIw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 04:52:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36840 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731935AbfIWIw4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569228774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqq9vJEEH5ZtZvYptXpH3lbdAqyZ33kdXmGc7P537mY=;
        b=dlhWJxhNrVMKgu1Xi3cPmaPqP/xusTMbVdd4vBJ9vV9oYOqc4avmi3msitKu+8MwT32+JI
        cAsPBBcO1B3LMhd+hEfC1Z5Zaw7poLhjTcjZW+2hoIE/NVrgud9JC7+bB6Yw7x+oytjK2S
        aytrPaRJ94fsa5cDM6SdJIsvXI647rA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-73wEd3TwP6qO4sxuiUOv8A-1; Mon, 23 Sep 2019 04:52:53 -0400
Received: by mail-wm1-f72.google.com with SMTP id t185so4679723wmg.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2019 01:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2gI69lMtL/2no0QJ3lJh07zz8j9jkBVeK6wIFi3kZIo=;
        b=ufB33l2zDOj+2DyqD3AoEw21dLJWcluMetk84hs6RQUcS/57oi/uw62b3o8rPnqz/A
         /TlH+quj8lcf3g5EP3wlUX+uFi1v0ki1zXHk/MGDKMtoRwSd2jl7Yv3k/E/L75I6rrWY
         du5uUrSWSQx/Yyvuq6S5u8tx05RvArEE2mWRifD2ZRDynhriVEKEMG9f//jZaxtIIr62
         gjd8TONKoMG/PH5qyfGRb8VKitg00/TqLsBOfI+TdM2512g6tj6GRKK2YbsoxRAch73Z
         yOWz/lkovJkUpLmy6Y1qxuhTNGtdpL4hLJkydOXXU5AaEKJP1tXrX0BJ71BB6FawIxwm
         RhZA==
X-Gm-Message-State: APjAAAUrTX8ytSZRr8A8iW2mUBxCkVbkUHaDT/Fpr+Uzic5qVWZKZwGd
        bM3/Gux8SBBRyE1Yj0uzbZSB9wMXb5dipQMjYEsFvsd313vMptD5Kwx5aHQtSEeboS6HFJ+d4aC
        11tOy9nIvpjIdE6ymJEM9/4wDXg==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr13117618wmk.49.1569228772219;
        Mon, 23 Sep 2019 01:52:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyz9NML1xJ3uyrlFpeNL9Jb8EVjDqkdHiFdVWa1MogHvYTT7RqGQEDfFyMEPT9mDa/1pQyETw==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr13117607wmk.49.1569228772028;
        Mon, 23 Sep 2019 01:52:52 -0700 (PDT)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id b144sm15576381wmb.3.2019.09.23.01.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 01:52:51 -0700 (PDT)
Date:   Mon, 23 Sep 2019 10:52:49 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        adilger@dilger.ca, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 9/9] xfs: Get rid of ->bmap
Message-ID: <20190923085248.ttf6ruum7dp3qqjd@pegasus.maiolino.io>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        adilger@dilger.ca, linux-xfs@vger.kernel.org
References: <20190911134315.27380-1-cmaiolino@redhat.com>
 <20190911134315.27380-10-cmaiolino@redhat.com>
 <20190916175049.GD2229799@magnolia>
 <20190918081303.zwnxr7pvtotr7cnt@pegasus.maiolino.io>
 <20190918132436.GA16210@lst.de>
 <20190918161241.GW2229799@magnolia>
MIME-Version: 1.0
In-Reply-To: <20190918161241.GW2229799@magnolia>
User-Agent: NeoMutt/20180716
X-MC-Unique: 73wEd3TwP6qO4sxuiUOv8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 09:12:41AM -0700, Darrick J. Wong wrote:
> On Wed, Sep 18, 2019 at 03:24:36PM +0200, Christoph Hellwig wrote:
> > On Wed, Sep 18, 2019 at 10:13:04AM +0200, Carlos Maiolino wrote:
> > > All checks are now made in the caller, bmap_fiemap() based on the fil=
esystem's
> > > returned flags in the fiemap structure. So, it will decide to pass th=
e result
> > > back, or just return -EINVAL.
> > >=20
> > > Well, there is no way for iomap (or bmap_fiemap now) detect the block=
 is in a
> > > realtime device, since we have no flags for that.
> > >=20
> > > Following Christoph's line of thought here, maybe we can add a new IO=
MAP_F_* so
> > > the filesystem can notify iomap the extent is in a different device? =
I don't
> > > know, just a thought.
> > >=20
> > > This would still keep the consistency of leaving bmap_fiemap() with t=
he decision
> > > of passing or not.
> >=20
> > I think this actually is a problem with FIEMAP as well, as it
> > doesn't report that things are on a different device.  So I guess for
> > now we should fail FIEMAP on the RT device as well.
>=20
> Or enhance FIEMAP to report some kind of device id like I suggested a
> while back...

Yes, this is in my todo list Darrick, but as agreed previously, this will b=
e in
a different patchset. It simply does not belong here and will make this pat=
chset
much more complex than it should be.

About this patch itself, there isn't much I can do here, and I think a XFS =
fix
to make it reject FIEMAP for RT devices as Christoph suggested, belongs to =
a
xfs-only patch, not to this one.

I can do that too, but on a different patch, changing FS semantics simply d=
oes
not belong in this patchset.

Cheers.

>=20
> --D

--=20
Carlos

