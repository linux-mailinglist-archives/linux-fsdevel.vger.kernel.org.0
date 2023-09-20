Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BBA7A7930
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 12:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbjITKbV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 06:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbjITKbS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:31:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEA3B9;
        Wed, 20 Sep 2023 03:31:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6BEC433C8;
        Wed, 20 Sep 2023 10:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695205872;
        bh=oNOjwO1HWGBEpf3cBBh7axaasl75uB0qI4wAwRxWmjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6K8pKJQEI2XsNKvGrTrUHZ4zNBx1PSzyYqaLhuL0UOA1rjOR0Sx+7Q/i8/z7W2QM
         SYGnkRAETNJ1YNqDE0jn02DsKPLnvT8Dlj7iQnQ1NkXBXxwS3bUvTlfmUmGNpqgnAt
         d9oRMMoNiJkxZxIEdxaattLdKZ+MxAOm6lzE9eOQq2WB04LbxlLCzO0W+i/lJa8N3o
         D3d0gZ8gcOuG4Q3xgoC9uMM7ew2rnaw5/drkoL/cZCwmQy5vWhB2Aze+Bi6z8jD2nY
         hy6BhkvXGhnFluc2A7TLkA6msDJfc0kYbpv59oX9ohVHSRtCeqb94+OWZe5Em0hGQ9
         ZunGxe0rj22wg==
Date:   Wed, 20 Sep 2023 12:30:52 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jeff Layton <jlayton@kernel.org>, Bruno Haible <bruno@clisp.org>,
        Xi Ruoyao <xry111@linuxfromscratch.org>, bug-gnulib@gnu.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bo b Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <l@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
Message-ID: <20230920-kaulquappen-computer-0a4a0e4c3c71@brauner>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
 <20230919110457.7fnmzo4nqsi43yqq@quack3>
 <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
 <4511209.uG2h0Jr0uP@nimes>
 <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
 <20230920-leerung-krokodil-52ec6cb44707@brauner>
 <20230920101731.ym6pahcvkl57guto@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920101731.ym6pahcvkl57guto@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 12:17:31PM +0200, Jan Kara wrote:
> On Wed 20-09-23 10:41:30, Christian Brauner wrote:
> > > > f1 was last written to *after* f2 was last written to. If the timestamp of f1
> > > > is then lower than the timestamp of f2, timestamps are fundamentally broken.
> > > > 
> > > > Many things in user-space depend on timestamps, such as build system
> > > > centered around 'make', but also 'find ... -newer ...'.
> > > > 
> > > 
> > > 
> > > What does breakage with make look like in this situation? The "fuzz"
> > > here is going to be on the order of a jiffy. The typical case for make
> > > timestamp comparisons is comparing source files vs. a build target. If
> > > those are being written nearly simultaneously, then that could be an
> > > issue, but is that a typical behavior? It seems like it would be hard to
> > > rely on that anyway, esp. given filesystems like NFS that can do lazy
> > > writeback.
> > > 
> > > One of the operating principles with this series is that timestamps can
> > > be of varying granularity between different files. Note that Linux
> > > already violates this assumption when you're working across filesystems
> > > of different types.
> > > 
> > > As to potential fixes if this is a real problem:
> > > 
> > > I don't really want to put this behind a mount or mkfs option (a'la
> > > relatime, etc.), but that is one possibility.
> > > 
> > > I wonder if it would be feasible to just advance the coarse-grained
> > > current_time whenever we end up updating a ctime with a fine-grained
> > > timestamp? It might produce some inode write amplification. Files that
> > 
> > Less than ideal imho.
> > 
> > If this risks breaking existing workloads by enabling it unconditionally
> > and there isn't a clear way to detect and handle these situations
> > without risk of regression then we should move this behind a mount
> > option.
> > 
> > So how about the following:
> > 
> > From cb14add421967f6e374eb77c36cc4a0526b10d17 Mon Sep 17 00:00:00 2001
> > From: Christian Brauner <brauner@kernel.org>
> > Date: Wed, 20 Sep 2023 10:00:08 +0200
> > Subject: [PATCH] vfs: move multi-grain timestamps behind a mount option
> > 
> > While we initially thought we can do this unconditionally it turns out
> > that this might break existing workloads that rely on timestamps in very
> > specific ways and we always knew this was a possibility. Move
> > multi-grain timestamps behind a vfs mount option.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Surely this is a safe choice as it moves the responsibility to the sysadmin
> and the cases where finegrained timestamps are required. But I kind of
> wonder how is the sysadmin going to decide whether mgtime is safe for his
> system or not? Because the possible breakage needn't be obvious at the
> first sight... If I were a sysadmin, I'd rather opt for something like

I think you'll basically enable this because you want to export a
filesystem via NFS.

> finegrained timestamps + lazytime (if I needed the finegrained timestamps
> functionality). That should avoid the IO overhead of finegrained timestamps

That would work with this patch, no? Or are you saying it would need
something else?

> as well and I'd know I can have problems with timestamps only after a
> system crash.
> 
> I've just got another idea how we could solve the problem: Couldn't we
> always just report coarsegrained timestamp to userspace and provide access
> to finegrained value only to NFS which should know what it's doing?

What would changes would be involved for that?

If this is invasive work and we decide this is something that we want to
do then we should remove FS_MGTIME from btrfs, xfs, ext4, and tmpfs for
v6.6.
