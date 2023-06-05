Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2486072320B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 23:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjFEVPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 17:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjFEVPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:15:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7EE100
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 14:14:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977d0ee1736so286761266b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jun 2023 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685999698; x=1688591698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aY9b2eYrM9qWAWS74IvkUjX1eUU5yy6UtG6476GK6Ok=;
        b=BrdvqDlJMaBrmovXtd18RdeRVDQqCtV+NM5SnjiORMPDX/7Xi7NzVNG/DD8I/kgmDm
         eUIXNN+4p8HMidkn5sCieCbFvITHdcbeb4re8zAUtUCxBVmdOuSrkTo6sCldV6ao2c0K
         UWHAoJHST+mCjb+v8OSXzCeu1h6BCbwlG6K9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685999698; x=1688591698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aY9b2eYrM9qWAWS74IvkUjX1eUU5yy6UtG6476GK6Ok=;
        b=acBpdOGTwLWKJSX6XfPIRa6ucGEzXoINtjUfIyGRjNmwHFbZwZ6QvdnFaebySnYnJs
         VSWl9qID7AnTpFvWayIr9Ky8N2w2X86orGuzmfNlHubYjKvlCddo/gZi3VqBPC34py9s
         8TGLiLDe5U881Ktkh6kGDMMDA4pQJupG49+tweHh/t9CTl/W1LTyXsb/BINiuthLz/w2
         lUhYD6vXirHBT068Q3tztmy/06YEw22xbZfCekwIqdfyILsSoyXwCMMiGEIaxCoCg4L2
         Ayj2Ju1cg0NxtkWU4Yvwtc7ZTLGfdT00bHf7YlaG730WfxjeAX2Sm6v4ukPzrerMxbzI
         o/eA==
X-Gm-Message-State: AC+VfDzvE45mMnFYlv++iOeOvl1UnX9mCU0GMKmaC5yogGrBAOPjJ8rq
        wb6HCaJt2GekPpQdnN4gtT7LBd4g9fRNBDg2T7IL8Q==
X-Google-Smtp-Source: ACHHUZ7murrbOxSSx4GpLx59bPJNo97XmGmVMQ0R4Lh5x3mm34bbhXjsDzAQAQinArp+kzhpjq89U2WTusv8UzpiAUM=
X-Received: by 2002:a17:907:9803:b0:974:56aa:6dce with SMTP id
 ji3-20020a170907980300b0097456aa6dcemr71859ejc.46.1685999697739; Mon, 05 Jun
 2023 14:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <ZG+KoxDMeyogq4J0@bfoster> <ZHB954zGG1ag0E/t@dread.disaster.area>
 <CAJ0trDbspRaDKzTzTjFdPHdB9n0Q9unfu1cEk8giTWoNu3jP8g@mail.gmail.com>
 <ZHFEfngPyUOqlthr@dread.disaster.area> <CAJ0trDZJQwvAzngZLBJ1hB0XkQ1HRHQOdNQNTw9nK-U5i-0bLA@mail.gmail.com>
 <ZHYB/6l5Wi+xwkbQ@redhat.com> <CAJ0trDaUOevfiEpXasOESrLHTCcr=oz28ywJU+s+YOiuh7iWow@mail.gmail.com>
 <ZHYWAGmKhwwmTjW/@redhat.com> <CAG9=OMMnDfN++-bJP3jLmUD6O=Q_ApV5Dr392_5GqsPAi_dDkg@mail.gmail.com>
 <ZHqOvq3ORETQB31m@dread.disaster.area> <ZHti/MLnX5xGw9b7@redhat.com>
In-Reply-To: <ZHti/MLnX5xGw9b7@redhat.com>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Mon, 5 Jun 2023 14:14:44 -0700
Message-ID: <CAG9=OMNv80fOyVixEY01XESnOFzYyfj9j8etHMq_Ap52z4UWNQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Joe Thornber <thornber@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Joe Thornber <ejt@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 3, 2023 at 8:57=E2=80=AFAM Mike Snitzer <snitzer@kernel.org> wr=
ote:
>
> On Fri, Jun 02 2023 at  8:52P -0400,
> Dave Chinner <david@fromorbit.com> wrote:
>
> > On Fri, Jun 02, 2023 at 11:44:27AM -0700, Sarthak Kukreti wrote:
> > > On Tue, May 30, 2023 at 8:28=E2=80=AFAM Mike Snitzer <snitzer@kernel.=
org> wrote:
> > > >
> > > > On Tue, May 30 2023 at 10:55P -0400,
> > > > Joe Thornber <thornber@redhat.com> wrote:
> > > >
> > > > > On Tue, May 30, 2023 at 3:02=E2=80=AFPM Mike Snitzer <snitzer@ker=
nel.org> wrote:
> > > > >
> > > > > >
> > > > > > Also Joe, for you proposed dm-thinp design where you distinquis=
h
> > > > > > between "provision" and "reserve": Would it make sense for REQ_=
META
> > > > > > (e.g. all XFS metadata) with REQ_PROVISION to be treated as an
> > > > > > LBA-specific hard request?  Whereas REQ_PROVISION on its own pr=
ovides
> > > > > > more freedom to just reserve the length of blocks? (e.g. for XF=
S
> > > > > > delalloc where LBA range is unknown, but dm-thinp can be asked =
to
> > > > > > reserve space to accomodate it).
> > > > > >
> > > > >
> > > > > My proposal only involves 'reserve'.  Provisioning will be done a=
s part of
> > > > > the usual io path.
> > > >
> > > > OK, I think we'd do well to pin down the top-level block interfaces=
 in
> > > > question. Because this patchset's block interface patch (2/5) heade=
r
> > > > says:
> > > >
> > > > "This patch also adds the capability to call fallocate() in mode 0
> > > > on block devices, which will send REQ_OP_PROVISION to the block
> > > > device for the specified range,"
> > > >
> > > > So it wires up blkdev_fallocate() to call blkdev_issue_provision().=
 A
> > > > user of XFS could then use fallocate() for user data -- which would
> > > > cause thinp's reserve to _not_ be used for critical metadata.
> >
> > Mike, I think you might have misunderstood what I have been proposing.
> > Possibly unintentionally, I didn't call it REQ_OP_PROVISION but
> > that's what I intended - the operation does not contain data at all.
> > It's an operation like REQ_OP_DISCARD or REQ_OP_WRITE_ZEROS - it
> > contains a range of sectors that need to be provisioned (or
> > discarded), and nothing else.
>
> No, I understood that.
>
> > The write IOs themselves are not tagged with anything special at all.
>
> I know, but I've been looking at how to also handle the delalloc
> usecase (and yes I know you feel it doesn't need handling, the issue
> is XFS does deal nicely with ensuring it has space when it tracks its
> allocations on "thick" storage -- so adding coordination between XFS
> and dm-thin layers provides comparable safety.. that safety is an
> expected norm).
>
> But rather than discuss in terms of data vs metadata, the distinction
> is:
> 1) LBA range reservation (normal case, your proposal)
> 2) non-LBA reservation (absolute value, LBA range is known at later stage=
)
>
> But I'm clearly going off script for dwelling on wanting to handle
> both.
>
> My looking at (ab)using REQ_META being set (use 1) vs not (use 2) was
> a crude simplification for branching between the 2 approaches.
>
> And I understand I made you nervous by expanding the scope to a much
> more muddled/shitty interface. ;)
>
> We all just need to focus on your proposal and Joe's dm-thin
> reservation design...
>
> [Sarthak: FYI, this implies that it doesn't really make sense to add
> dm-thinp support before Joe's design is implemented.  Otherwise we'll
> have 2 different responses to REQ_OP_PROVISION.  The one that is
> captured in your patchset isn't adequate to properly handle ensuring
> upper layer (like XFS) can depend on the space being available across
> snapshot boundaries.]
>
Ack. Would it be premature for the rest of the series to go through
(REQ_OP_PROVISION + support for loop and non-dm-thinp device-mapper
targets)? I'd like to start using this as a reference to suggest
additions to the virtio-spec for virtio-blk support and start looking
at what an ext4 implementation would look like.

> > i.e. The proposal I made does not use REQ_PROVISION anywhere in the
> > metadata/data IO path; provisioned regions are created by separate
> > operations and must be tracked by the underlying block device, then
> > treat any write IO to those regions as "must not fail w/ ENOSPC"
> > IOs.
> >
> > There seems to be a lot of fear about user data requiring
> > provisioning. This is unfounded - provisioning is only needed for
> > explicitly provisioned space via fallocate(), not every byte of
> > user data written to the filesystem (the model Brian is proposing).
>
> As I mentioned above, I was just trying to get XFS-on-thinp to
> maintain parity with how XFS's delalloc accounting works on "thick"
> storage.
>
> But happy to put that to one side.  Maintain focus like I mentioned
> above.  I'm happy we have momentum and agreement on this design now.
> Rather than be content with that, I was mistakenly looking at other
> aspects and in doing so introduced "noise" before we've implemented
> what we all completely agree on: your and joe's designs.
>
> > Excessive use of fallocate() is self correcting - if users and/or
> > their applications provision too much, they are going to get ENOSPC
> > or have to pay more to expand the backing pool reserves they need.
> > But that's not a problem the block device should be trying to solve;
> > that's a problem for the sysadmin and/or bean counters to address.
> >
> > > >
> > > > The only way to distinquish the caller (between on-behalf of user d=
ata
> > > > vs XFS metadata) would be REQ_META?
> > > >
> > > > So should dm-thinp have a REQ_META-based distinction? Or just treat
> > > > all REQ_OP_PROVISION the same?
> > > >
> > > I'm in favor of a REQ_META-based distinction.
> >
> > Why? What *requirement* is driving the need for this distinction?
>
> Think I answered that above, XFS delalloc accounting parity on thinp.
>
I actually had a few different use-cases in mind (apart from the user
data provisioning 'fear' that you pointed out): in essence, there are
cases where userspace would benefit from having more control over how
much space a snapshot takes:

1) In the original RFC patchset [1], I alluded to this being a
mechanism for pre-allocating space for preserving space for thin
logical volumes. The use-case I'd like to explore is delta updatable
read-only filesystems similar to systemd system extensions [2]: In
essence:
a) Preserve space for a 'base' thin logical volume that will contain a
read-only filesystem on over-the-air installation: for filesystems
like squashfs and erofs, pretty much the entire image is a compressed
file that I'd like to reserve space for before installation.
b) Before update, create a thin snapshot and preserve enough space to
ensure that a delta update will succeed (eg. block level diff of the
base image). Then, the update is guaranteed to have disk space to
succeed (similar to the A-B update guarantees on ChromeOS). On
success, we merge the snapshot and reserve an update snapshot for the
next possible update. On failure, we drop the snapshot.

2) The other idea I wanted to explore was rollback protection for
stateful filesystem features: in essence, if an update from kernel 4.x
to 5.y failed very quickly (due to unrelated reasons) and we enabled
some stateful filesystem features that are only supported on 5.y, we'd
be able to rollback to 4.x if we used short-lived snapshots (in the
ChromiumOS world, the lifetime of these snapshots would be < 10s per
boot).

On reflection, the metadata vs user data distinction was a means to an
end for me: I'd like to retain the capability to create thin
short-lived snapshots from userspace _regardless_ of the provisioned
ranges of a thin volume and the flexibility to manipulate the space
requirements on these snapshot volumes from userspace. This might
appear as "bean-counting" but if I have eg. a 4GB read-only compressed
filesystem and I know, a priori, an update will take at most 400M, I
shouldn't need to (momentarily) reserve another 4GB or add more disks
to complete the update.

[1] https://lkml.org/lkml/2022/9/15/785
[2] https://www.freedesktop.org/software/systemd/man/systemd-sysext.html

> > As the person who proposed this new REQ_OP_PROVISION architecture,
> > I'm dead set against it.  Allowing the block device provide a set of
> > poorly defined "conditional guarantees" policies instead of a
> > mechanism with a single ironclad guarantee defeats the entire
> > purpose of the proposal.
> >
> > We have a requirement from the *kernel ABI* that *user data writes*
> > must not fail with ENOSPC after an fallocate() operation.  That's
> > one of the high level policies we need to implement. The filesystem
> > is already capable of guaranteeing it won't give the user ENOSPC
> > after fallocate, we now need a guarantee from the filesystem's
> > backing store that it won't give ENOSPC, too.
>
> Yes, I was trying to navigate Joe's reluctance to even support
> fallocate() for arbitrary user data.  That's where the REQ_META vs
> data distinction crept in for me.  But as you say: using fallocate()
> excessively is self-correcting.
>
> > The _other thing_ we need to implement is a method of guaranteeing
> > the filesystem won't shut down when the backing device goes ENOSPC
> > unexpected during metadata writeback.  So we also need the backing
> > device to guarantee the regions we write metadata to won't give
> > ENOSPC.
>
> Yeap.
>
> > That's the whole point of REQ_OP_PROVISION: from the layers above
> > the block device, there is -zero- difference between the guarantee
> > we need for user data writes to avoid ENOSPC and for metadata writes
> > to avoid ENOSPC. They are one and the same.
>
> I know.  The difference comes from delalloc initially needing an
> absolute value of reserve rather than a specific LBA range.
>
> > Hence if the block device is going to say "I support provisioning"
> > but then give different conditional guarantees according to the
> > *type of data* in the IO request, then it does not provide the
> > functionality the higher layers actually require from it.
>
> I was going for relaxing the "dynamic" approach (Brian's) to be
> best-effort -- and really only for XFS delalloc usecase.  Every other
> usecase would respect your and Joe's vision.
>
> > Indeed, what type of data the IO contains is *context dependent*.
> > For example, sometimes we write metadata with user data IO and but
> > we still need provisioning guarantees as if it was issued as
> > metadata IO. This is the case for mkfs initialising the file system
> > by writing directly to the block device.
>
> I'm aware.
>
> > IOWs, filesystem metadata IO issued from kernel context would be
> > considered metadata IO, but from userspace it would be considered
> > normal user data IO and hence treated differently. But the reality
> > is that they both need the same provisioning guarantees to be
> > provided by the block device.
>
> What I was looking at is making the fallocate interface able to
> express: I need dave's requirements (bog-standard actually) vs I need
> non-LBA best effort.
>
> > So how do userspace tools deal with this if the block device
> > requires REQ_META on user data IOs to do the right thing here? And
> > if we provide a mechanism to allow this, how do we prevent userspace
> > for always using it on writes to fallocate() provisioned space?
> >
> > It's just not practical for the block device to add arbitrary
> > constraints based on the type of IO because we then have to add
> > mechanisms to userspace APIs to allow them to control the IO context
> > so the block device will do the right thing. Especially considering
> > we really only need one type of guarantee regardless of where the IO
> > originates from or what type of data the IO contains....
>
> If anything my disposition on the conditional to require a REQ_META
> (or some fallocate generated REQ_UNSHARE ditto to reflect the same) to
> perform your approach to REQ_OP_PROVISION and honor fallocate()
> requirements is a big problem.  Would be much better to have a flag to
> express "this reservation does not have an LBA range _yet_,
> nevertheless try to be mindful of this expected near-term block
> allocation".
>
> But I'll stop inlining repetitive (similar but different) answers to
> your concern now ;)
>
> > > Does that imply that
> > > REQ_META also needs to be passed through the block/filesystem stack
> > > (eg. REQ_OP_PROVION + REQ_META on a loop device translates to a
> > > fallocate(<insert meta flag name>) to the underlying file)?
> >
> > This is exactly the same case as above: the loopback device does
> > user data IO to the backing file. Hence we have another situation
> > where metadata IO is issued to fallocate()d user data ranges as user
> > data ranges and so would be given a lesser guarantee that would lead
> > to upper filesystem failure. BOth upper and lower filesystem data
> > and metadata need to be provided the same ENOSPC guarantees by their
> > backing stores....
> >
> > The whole point of the REQ_OP_PROVISION proposal I made is that it
> > doesn't require any special handling in corner cases like this.
> > There are no cross-layer interactions needed to make everything work
> > correctly because the provisioning guarantee is not -data type
> > dependent*. The entire user IO path code remains untouched and
> > blissfully unaware of provisioned regions.
> >
> > And, realistically, if we have to start handling complex corner
> > cases in the filesystem and IO path layers to make REQ_OP_PROVISION
> > work correctly because of arbitary constraints imposed by the block
> > layer implementations, then we've failed miserably at the design and
> > architecture stage.
> >
> > Keep in mind that every attempt made so far to address the problems
> > with block device ENOSPC errors has failed because of the complexity
> > of the corner cases that have arisen during design and/or
> > implementation. It's pretty ironic that now we have a proposal that
> > is remarkably simple, free of corner cases and has virtually no
> > cross-layer coupling at all, the first thing that people want to do
> > is add arbitrary implementation constraints that result in complex
> > cross-layer corner cases that now need to be handled....
> >
> > Put simply: if we restrict REQ_OP_PROVISION guarantees to just
> > REQ_META writes (or any other specific type of write operation) then
> > it's simply not worth persuing at the filesystem level because the
> > guarantees we actually need just aren't there and the complexity of
> > discovering and handling those corner cases just isn't worth the
> > effort.

Fair points, I certainly don't want to derail this conversation; I'd
be happy to see this work merged sooner rather than later. For
posterity, I'll distill what I said above into the following: I'd like
a capability for userspace to create thin snapshots that ignore the
thin volume's provisioned areas. IOW, an opt-in flag which makes
snapshots fallback to what they do today to provide flexibility to
userspace to decide the space requirements for the above mentioned
scenarios, and at the same time, not adding separate corner case
handling for filesystems. But to reiterate, my intent isn't to pile
this onto the work you, Mike and Joe have planned; just some insight
into why I'm in favor of ideas that reduce the snapshot size.

Best
Sarthak

>
> Here is where I get to say: I think you misunderstood me (but it was
> my fault for not being absolutely clear: I'm very much on the same
> page as you and Joe; and your visions need to just be implemented
> ASAP).
>
> I was taking your designs as a given, but looking further at: how do
> we also handle the non-LBA (delalloc) usecase _before_ we include
> REQ_OP_PROVISION in kernel.
>
> But I'm happy to let the delalloc case go (we can revisit addressing
> it if/when needed).
>
> Mike
