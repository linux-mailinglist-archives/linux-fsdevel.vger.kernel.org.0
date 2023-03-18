Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16496BF93C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Mar 2023 10:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCRJb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 05:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCRJb0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 05:31:26 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF55497FC;
        Sat, 18 Mar 2023 02:31:24 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id p2so4871110uap.1;
        Sat, 18 Mar 2023 02:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679131884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/njdtvI7IlGVs0QAnOWrmN+l8Oq4hWVaKlgRxI6bCQ=;
        b=jmxZXl7h2VqrTO4Hc0nYE17zKOr0OckVtsdGIQMfcU7CqopnxOEonkmI1RA/Y2/Vr7
         P+QXEQn9h7lSf7cwGNMk7CUZHWAEXKuIbwAgZLldigO+DiXd4alB01c/3rhlyfnSWiOL
         tuNvnoqNNJEXO1jlmiM6zAVEp9ZPAaleRcnf5m5PYwKOu0Qsal0PIqxIXgmKp2/UksJW
         4DCw+TFGDFFIeeIeaVK1/PqThpuq9TVbIbDsPidxoPPgP5NN9x5hs/Ws3Jzlw1+P0q1F
         7K5ZYfaN+U5xca8lB5W4SBLV5d4UTBqNqnknvZ0S7e4eHjRmJK/CwKhPq2qi/aX8NsK3
         JDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679131884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/njdtvI7IlGVs0QAnOWrmN+l8Oq4hWVaKlgRxI6bCQ=;
        b=xhQ6Eg3hRU52hpXdmSWv19DNcH24eJBR0x4Zptrdr+Fjtoxv62aWuc3z85dxUiHZew
         LO2DZeaEYXK2aYxUcNWY/UQAADKLzkgTYz68w/2Nw6hcRhsJXTFkKyRBcxxWHbwjwVev
         0d4sGY9uqY4Btw83FPmST3HbXj14hFrjTxIl1unDTjIJm/6vNb70UkJ4QNa3twC9syyF
         RBn87rMOnnsK5ngKSkhuH38mVii7sdAlBKH+6CR7dGFj/5ikM0GmsTRWLAkBcp2k7CGp
         pPSY/AJVIIU+66j0tOYSIOYdGl15mEgna8pranDYxrrF4BauVTRc4N0p0urBu/nf851V
         sdgA==
X-Gm-Message-State: AO0yUKUiT2s7NvNrdovKPUQBcnTZnkgrFac1X9LvbE0Vefe3PIUf+cEO
        vwD0XlXe9CvEyeOnSDURQkrn0KNajNgAzDE9OA0=
X-Google-Smtp-Source: AK7set92/hm+b2+kV51D7e5nVbVpI5Mgxs7ypndEm/is2YQ7jxcYQ6qP9tdTjyTIsriq20Iy2IgOISWshuc0yn1VJh8=
X-Received: by 2002:a1f:ab01:0:b0:435:b6ce:23e7 with SMTP id
 u1-20020a1fab01000000b00435b6ce23e7mr751698vke.0.1679131883847; Sat, 18 Mar
 2023 02:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230314042109.82161-1-catherine.hoang@oracle.com>
 <20230314042109.82161-4-catherine.hoang@oracle.com> <CAOQ4uxiYVpF9gjt-kTVpnoVYboOFG-Fpfw=KMrM=-aEHod4vXw@mail.gmail.com>
 <FC1BD250-7179-470B-854E-649E52147219@oracle.com> <CAOQ4uxg6hR8R9XC8qSkxQG8=tkwKZi=2Ofq_-LgZEwwPqbFQjA@mail.gmail.com>
 <20230318003909.GT11376@frogsfrogsfrogs>
In-Reply-To: <20230318003909.GT11376@frogsfrogsfrogs>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 18 Mar 2023 11:31:12 +0200
Message-ID: <CAOQ4uxicWciaHGkk-y7zB4pBi-6tuNeR6nppDo0gS+KwhdtaVA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] xfs: add XFS_IOC_SETFSUUID ioctl
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 18, 2023 at 2:39=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Mar 16, 2023 at 10:09:56AM +0200, Amir Goldstein wrote:
> > On Thu, Mar 16, 2023 at 1:13=E2=80=AFAM Catherine Hoang
> > <catherine.hoang@oracle.com> wrote:
> > >
> > > > On Mar 13, 2023, at 10:50 PM, Amir Goldstein <amir73il@gmail.com> w=
rote:
> > > >
> > > > On Tue, Mar 14, 2023 at 6:27=E2=80=AFAM Catherine Hoang
> > > > <catherine.hoang@oracle.com> wrote:
> > > >>
> > > >> Add a new ioctl to set the uuid of a mounted filesystem.
> > > >>
> > > >> Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
> > > >> ---
> > > >> fs/xfs/libxfs/xfs_fs.h |   1 +
> > > >> fs/xfs/xfs_ioctl.c     | 107 +++++++++++++++++++++++++++++++++++++=
++++
> > > >> fs/xfs/xfs_log.c       |  19 ++++++++
> > > >> fs/xfs/xfs_log.h       |   2 +
> > > >> 4 files changed, 129 insertions(+)
> > > >>
> > > >> diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
> > > >> index 1cfd5bc6520a..a350966cce99 100644
> > > >> --- a/fs/xfs/libxfs/xfs_fs.h
> > > >> +++ b/fs/xfs/libxfs/xfs_fs.h
> > > >> @@ -831,6 +831,7 @@ struct xfs_scrub_metadata {
> > > >> #define XFS_IOC_FSGEOMETRY          _IOR ('X', 126, struct xfs_fso=
p_geom)
> > > >> #define XFS_IOC_BULKSTAT            _IOR ('X', 127, struct xfs_bul=
kstat_req)
> > > >> #define XFS_IOC_INUMBERS            _IOR ('X', 128, struct xfs_inu=
mbers_req)
> > > >> +#define XFS_IOC_SETFSUUID           _IOR ('X', 129, uuid_t)
> > > >
> > > > Should be _IOW.
> > >
> > > Ok, will fix that.
> > > >
> > > > Would you consider defining that as FS_IOC_SETFSUUID in fs.h,
> > > > so that other fs could implement it later on, instead of hoisting i=
t later?
> > > >
> > > > It would be easy to add support for FS_IOC_SETFSUUID to ext4
> > > > by generalizing ext4_ioctl_setuuid().
> > > >
> > > > Alternatively, we could hoist EXT4_IOC_SETFSUUID and struct fsuuid
> > > > to fs.h and use that ioctl also for xfs.
> > >
> > > I actually did try to hoist the ext4 ioctls previously, but we weren=
=E2=80=99t able to come
> > > to a consensus on the implementation.
> > >
> > > https://lore.kernel.org/linux-xfs/20221118211408.72796-2-catherine.ho=
ang@oracle.com/
> > >
> > > I would prefer to keep this defined as an xfs specific ioctl to avoid=
 all of the
> > > fsdevel bikeshedding.
> >
> > For the greater good, please do try to have this bikeshedding, before g=
iving up.
> > The discussion you pointed to wasn't so far from consensus IMO except
> > fsdevel was not CCed.
>
> Why?  fsdevel bikeshedding is a pointless waste of time.  Jeremy ran

[+ linux-api]

I do not think that it was a waste of time at all...

> four rounds of proposing the new api on linux-api, linux-fsdevel, and
> linux-ext4.  Matthew Wilcox and I sent in our comments, including adding
> some flexibility for shorter or longer uuids, so he updated the proposal
> and it got merged:
>
> https://lore.kernel.org/linux-api/?q=3DBongio
>
> The instant Catherine started talking about using this new API, Dave
> came in and said no, flex arrays for uuids are stupid, and told
> Catherine she ought to "fix" the landmines by changing the structure
> definition:
>
> https://lore.kernel.org/linux-xfs/20221121211437.GK3600936@dread.disaster=
.area/
>
> Never mind that changing the struct size causes the output of _IOR to
> change, which means a new ioctl command number, which is effectively a
> new interface.  I think we'll just put new ioctls in xfs_fs_staging.h,
> merge the code, let people kick the tires for a few months, and only
> then make it permanent.
>

What you perceive as a waste of time, I perceive as a healthy process.
This is what I see when reading the threads:

- Serious and responsible API discussion with several important review
  inputs incorporated.
- New API was added as "staging" in ext4 only
- Less than 1 year later, another fs wants to use the new API
- Dave (who may have missed the original API discussion?) points out a prob=
lem
- In my understanding, in the original discussion there was a consensus
  that uuid size is limited to 16 bytes [1] so the fact that fsu_uuid[]
  ended up as a variable array is just a human mistake?

[1] https://lore.kernel.org/linux-api/YthI9qp+VeNbFQP3@casper.infradead.org=
/

So we had a design discussion, we had a staging API and we found a problem
in the staging API. This is what I call a healthy process.

When that happens it is not too late to fix the API problem.
and the fix is simple - increase the size of the struct to maximal uuid siz=
e
and change the ioctl numbers.

Yes, ext4 tools and kernel driver have to pay the penalty of backward compa=
t
support for the V1 API, but as I showed in the sketch patch, that will be
quite easy to do and that is the price that one has to pay for being a
pioneer ;)

So for a workplan, Catherine can use the extended fsuuid struct and add it =
to
staging in xfs as you proposed, with the intention of hoisting it to
fs.h later on.
And that plan should be published to linux-api and linux-fsdevel.

Assuming that ext4 developers are fine with this plan, they could already
adjust ext4 and e2fsprogs to the V2 API before being hoisted, because the
adjustments are pretty simple.

Thanks,
Amir.
