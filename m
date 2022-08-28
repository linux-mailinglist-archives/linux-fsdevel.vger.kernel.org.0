Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D5F5A3EAB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 18:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiH1QyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 12:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiH1QyC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 12:54:02 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE9CAE72;
        Sun, 28 Aug 2022 09:54:00 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id q14so2798302vke.9;
        Sun, 28 Aug 2022 09:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=QIPsWpOp2sUg1rak0/1360ciZoUJZYe/LdlNqUMAK/M=;
        b=hUUtdqhA7jUl/3Jfwp7dcuMMtfIQSTUzZx5lRzE2Wt2/KGADtk8kg2FtZ1bsCkspx7
         D8ZA6kBwv4rvk7FFJhl4yDQU1pxxDokhCrRm7cIhum087ZDF0DbMdW0g3riFoCW4DHGQ
         BwV9B/AgfpE4mtK0Bwr0K//vK/zVfn2ph98/PFebwGSyyf0OqWjCGmzvznvmhWp8N8+F
         2NCZk9Dw6lcYFb1KhJkMb8DR6UcNOcd7xzbAixZfBcn/jxHtG90ilHTUTU9JkCUv54L6
         NqmEArshQxmuxe2gR0jzs9lEPlfRE05V0JJ+5mgn7yjS6Vz8bDVigxXQemk9dFcKsnTx
         hCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QIPsWpOp2sUg1rak0/1360ciZoUJZYe/LdlNqUMAK/M=;
        b=Nq929LClUm5kYwvbjREv8hRkdRFm2e8h/OP0FWlRj6p9o+h/IBZp9yi63ix3BPv2BE
         7uuaLskm8fai2/hKJRBFe7FzmrllOBv8kjpCyU2mNED0utAw5awUOD90JA0teE9BSEiU
         DZpaX6ZMEylbXBgjMDr1H47snfD+r4n5fMJ5YQdDeo5baI34Q41ylVylYpHXJbOAv2gL
         NSMhBbXqiCl/WIi3MVpyKMWxj+EmqWeJRObHGvwbDXPRJmB1EleRkSiJ1megx3I3IpwI
         I+XgGdX6JDMIs6nXhY+ukRJBTI5DLptmCDB0sB/dfmmulDBeLv0cq9/3+DE0YKcRneRm
         v0Og==
X-Gm-Message-State: ACgBeo3tGSdQZOFT5qiTkccb+cyyMiI80Gb70/LHcVrethVEAfs9Uswn
        +1gJUOXFJKZ+1XGiTsmfn3Haa2rzb7G1p6busuQ=
X-Google-Smtp-Source: AA6agR4KD+Wci1d0v5pFWycd0iCcP7FzMv3CE521MrPsfXOQJOjRQIemRpR5vq/p4rGIVlFqIhrnyYp3ygMt2tAl3d4=
X-Received: by 2002:a05:6122:a0e:b0:38d:9cd0:f00f with SMTP id
 14-20020a0561220a0e00b0038d9cd0f00fmr2147810vkn.25.1661705639978; Sun, 28 Aug
 2022 09:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220826214703.134870-1-jlayton@kernel.org> <20220826214703.134870-5-jlayton@kernel.org>
 <CAOQ4uxjzE_B_EQktLr8z8gXOhFDNm-_YpUTycfZCdaZNp-i0hQ@mail.gmail.com>
 <CAOQ4uxge86g=+HPnds-wRXkFHg67G=m9rGK7V_T8yS+2=w9tmg@mail.gmail.com>
 <35d31d0a5c6c9a20c58f55ef62355ff39a3f18c6.camel@kernel.org>
 <Ywo8cWRcJUpLFMxJ@magnolia> <079df2134120f847e8237675a8cc227d6354a153.camel@hammerspace.com>
 <b13812a68310e49cc6fb649c2b1c25287712a8af.camel@kernel.org>
 <CAOQ4uxgThXDEO3mxR_PtPgcPsF7ueqFUxHO3F3KE9sVqi8sLJQ@mail.gmail.com> <732164ffb95468992035a6f597dc26e3ce39316d.camel@kernel.org>
In-Reply-To: <732164ffb95468992035a6f597dc26e3ce39316d.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 28 Aug 2022 19:53:48 +0300
Message-ID: <CAOQ4uxgV78or9+7Bc7=d2-ca81mbsj3PqTHnJUTGNesCS1w-Pg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] xfs: don't bump the i_version on an atime update
 in xfs_vn_update_time
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 28, 2022 at 5:37 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Sun, 2022-08-28 at 16:25 +0300, Amir Goldstein wrote:
> > On Sat, Aug 27, 2022 at 7:10 PM Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > On Sat, 2022-08-27 at 16:03 +0000, Trond Myklebust wrote:
> > > > On Sat, 2022-08-27 at 08:46 -0700, Darrick J. Wong wrote:
> > > > > On Sat, Aug 27, 2022 at 09:14:30AM -0400, Jeff Layton wrote:
> > > > > > On Sat, 2022-08-27 at 11:01 +0300, Amir Goldstein wrote:
> > > > > > > On Sat, Aug 27, 2022 at 10:26 AM Amir Goldstein
> > > > > > > <amir73il@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Sat, Aug 27, 2022 at 12:49 AM Jeff Layton
> > > > > > > > <jlayton@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > xfs will update the i_version when updating only the atime
> > > > > > > > > value, which
> > > > > > > > > is not desirable for any of the current consumers of
> > > > > > > > > i_version. Doing so
> > > > > > > > > leads to unnecessary cache invalidations on NFS and extra
> > > > > > > > > measurement
> > > > > > > > > activity in IMA.
> > > > > > > > >
> > > > > > > > > Add a new XFS_ILOG_NOIVER flag, and use that to indicate that
> > > > > > > > > the
> > > > > > > > > transaction should not update the i_version. Set that value
> > > > > > > > > in
> > > > > > > > > xfs_vn_update_time if we're only updating the atime.
> > > > > > > > >
> > > > > > > > > Cc: Dave Chinner <david@fromorbit.com>
> > > > > > > > > Cc: NeilBrown <neilb@suse.de>
> > > > > > > > > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > > > > > > > > Cc: David Wysochanski <dwysocha@redhat.com>
> > > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > > ---
> > > > > > > > >  fs/xfs/libxfs/xfs_log_format.h  |  2 +-
> > > > > > > > >  fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
> > > > > > > > >  fs/xfs/xfs_iops.c               | 11 +++++++++--
> > > > > > > > >  3 files changed, 11 insertions(+), 4 deletions(-)
> > > > > > > > >
> > > > > > > > > Dave has NACK'ed this patch, but I'm sending it as a way to
> > > > > > > > > illustrate
> > > > > > > > > the problem. I still think this approach should at least fix
> > > > > > > > > the worst
> > > > > > > > > problems with atime updates being counted. We can look to
> > > > > > > > > carve out
> > > > > > > > > other "spurious" i_version updates as we identify them.
> > > > > > > > >
> > > > > > > >
> > > > > > > > AFAIK, "spurious" is only inode blocks map changes due to
> > > > > > > > writeback
> > > > > > > > of dirty pages. Anybody know about other cases?
> > > > > > > >
> > > > > > > > Regarding inode blocks map changes, first of all, I don't think
> > > > > > > > that there is
> > > > > > > > any practical loss from invalidating NFS client cache on dirty
> > > > > > > > data writeback,
> > > > > > > > because NFS server should be serving cold data most of the
> > > > > > > > time.
> > > > > > > > If there are a few unneeded cache invalidations they would only
> > > > > > > > be temporary.
> > > > > > > >
> > > > > > >
> > > > > > > Unless there is an issue with a writer NFS client that
> > > > > > > invalidates its
> > > > > > > own attribute
> > > > > > > caches on server data writeback?
> > > > > > >
> > > > > >
> > > > > > The client just looks at the file attributes (of which i_version is
> > > > > > but
> > > > > > one), and if certain attributes have changed (mtime, ctime,
> > > > > > i_version,
> > > > > > etc...) then it invalidates its cache.
> > > > > >
> > > > > > In the case of blocks map changes, could that mean a difference in
> > > > > > the
> > > > > > observable sparse regions of the file? If so, then a READ_PLUS
> > > > > > before
> > > > > > the change and a READ_PLUS after could give different results.
> > > > > > Since
> > > > > > that difference is observable by the client, I'd think we'd want to
> > > > > > bump
> > > > > > i_version for that anyway.
> > > > >
> > > > > How /is/ READ_PLUS supposed to detect sparse regions, anyway?  I know
> > > > > that's been the subject of recent debate.  At least as far as XFS is
> > > > > concerned, a file range can go from hole -> delayed allocation
> > > > > reservation -> unwritten extent -> (actual writeback) -> written
> > > > > extent.
> > > > > The dance became rather more complex when we added COW.  If any of
> > > > > that
> > > > > will make a difference for READ_PLUS, then yes, I think you'd want
> > > > > file
> > > > > writeback activities to bump iversion to cause client invalidations,
> > > > > like (I think) Dave said.
> > > > >
> > > > > The fs/iomap/ implementation of SEEK_DATA/SEEK_HOLE reports data for
> > > > > written and delalloc extents; and an unwritten extent will report
> > > > > data
> > > > > for any pagecache it finds.
> > > > >
> > > >
> > > > READ_PLUS should never return anything different than a read() system
> > > > call would return for any given area. The way it reports sparse regions
> > > > vs. data regions is purely an RPC formatting convenience.
> > > >
> > > > The only point to note about NFS READ and READ_PLUS is that because the
> > > > client is forced to send multiple RPC calls if the user is trying to
> > > > read a region that is larger than the 'rsize' value, it is possible
> > > > that these READ/READ_PLUS calls may be processed out of order, and so
> > > > the result may end up looking different than if you had executed a
> > > > read() call for the full region directly on the server.
> > > > However each individual READ / READ_PLUS reply should look as if the
> > > > user had called read() on that rsize-sized section of the file.
> > > > > >
> > >
> > > Yeah, thinking about it some more, simply changing the block allocation
> > > is not something that should affect the ctime, so we probably don't want
> > > to bump i_version on it. It's an implicit change, IOW, not an explicit
> > > one.
> > >
> > > The fact that xfs might do that is unfortunate, but it's not the end of
> > > the world and it still would conform to the proposed definition for
> > > i_version. In practice, this sort of allocation change should come soon
> > > after the file was written, so one would hope that any damage due to the
> > > false i_version bump would be minimized.
> > >
> >
> > That was exactly my point.
> >
> > > It would be nice to teach it not to do that however. Maybe we can insert
> > > the NOIVER flag at a strategic place to avoid it?
> >
> > Why would that be nice to avoid?
> > You did not specify any use case where incrementing i_version
> > on block mapping change matters in practice.
> > On the contrary, you said that NFS client writer sends COMMIT on close,
> > which should stabilize i_version for the next readers.
> >
> > Given that we already have an xfs implementation that does increment
> > i_version on block mapping changes and it would be a pain to change
> > that or add a new user options, I don't see the point in discussing it further
> > unless there is a good incentive for avoiding i_version updates in those cases.
> >
>
> Because the change to the block allocation doesn't represent an
> "explicit" change to the inode. We will have bumped the ctime on the
> original write (in update_time), but the follow-on changes that occur
> due to that write needn't be counted as they aren't visible to the
> client.
>
> It's possible for a client to issue a read between the write and the
> flush and get the interim value for i_version. Then, once the write
> happens and the i_version gets bumped again, the client invalidates its
> cache even though it needn't do so.
>
> The race window ought to be relatively small, and this wouldn't result
> in incorrect behavior that you'd notice (other than loss of
> performance), but it's not ideal. We're doing more on-the-wire reads
> than are necessary in this case.
>
> It would be nice to have it not do that. If we end up taking this patch
> to make it elide the i_version bumps on atime updates, we may be able to
> set the the NOIVER flag in other cases as well, and avoid some of these
> extra bumps.

Ok. The use case is that a client's writes on an open file can end up
invalidating the same client's read cache on the same file.
Sounds like implementing write delegations would have been better
in this case than relying on i_version, but I do not know how hard that is
and how many clients would request write delegations.

Anyway, if you ever send a proposal to change the semantics of
xfs i_version bumping on writeback, please specify the target use case
and how likely it is for real workloads to suffer from it.

Another question to the NFS experts - what happens when the
server crashes before dirty data hits persistent storage but the client
has already cached the dirty data.

After the crash, the filesystem can come up with the same i_version
that the NFS client has cached, but without the dirty data.
Does the spec address this scenario?

Thanks,
Amir.
