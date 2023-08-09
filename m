Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6DA776780
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 20:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjHISiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 14:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjHISiV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:38:21 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B63F2127
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 11:38:19 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40398ccdaeeso209891cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Aug 2023 11:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20221208.gappssmtp.com; s=20221208; t=1691606298; x=1692211098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EcmI8Rpl1R+tuyjPLJAOGmabIt197aKHT+nbD52Q1I=;
        b=BfdYdGlaV7wDLoLR9yjOQKYaMVK5G+sZo2gR8ietMzxK6/hhzrKBhXntyWFMe+Yo8W
         pXAEKi27jKY+o1GSIwlWHKByFh7VJx8vdxyzXfnpCla9dyz3P+vZbtPjJCJ8F75v4t++
         cENDUCMzciHiNczMnx810YrXJp7LJHfpO0BqiOVkILP4ZM1XP/NHiA5CqbEHPLNAnApb
         4blc5R+dkjgksSq2+K5JK9IBlHetg1olYAUJU7H7u688LciEb+01exSGkI+DT+Of4VXY
         kkHfq0UcUl8GdzevovO/osm+1AaLFSn4iK2zXa30egAa3a76m/vMuRq9Hke6KAEMMcTX
         y7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691606298; x=1692211098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EcmI8Rpl1R+tuyjPLJAOGmabIt197aKHT+nbD52Q1I=;
        b=YDUGCreJxTTc54etcBixFnqmsKZMooMbgwoAQBK19+RdL8MIO7Dv1rM7L+saOldrz1
         rXoXA3T21jEqaHeWbAvNfjeASN7NyJj49vwGg4DLkyog7siyaHrPEelXTKXG5cV8ioP6
         GRedw2FzFz4JVCRP2D0pzV4ICbrny4Jz2anoVZZONLyR5d/kGKrPOrAz6oY65Jk0eZrR
         yPW7EGiY9OMlRkZBvnpVlfYBPPr1K3qkBG7rSpaIR8yeS+8HkoXMyQh1QdCMuDyqVqNp
         lED5x6yZYg6NEMsTm+DQDuw4cI8tSow9vKdTgmo0NyAKSA86vaoX/nyx2bQvKkE52EQK
         g9rQ==
X-Gm-Message-State: AOJu0Yz5HV9WPL988tknzxUmga8990slmKSkDel6qRS0cgiTj0aHksZj
        53M1jXNgYcDe/4tCNbGMXC8jaRTzdMjtCQ20loq+SQ==
X-Google-Smtp-Source: AGHT+IH2sTR1ARtIFCpkS6vqthNwZFelmGu0RmLRp1wcx6mBBfZ3SQAFevZE8DnhGTo57OILWEQYl9skWtT3uKB51ZE=
X-Received: by 2002:ac8:4e47:0:b0:3f9:c207:3123 with SMTP id
 e7-20020ac84e47000000b003f9c2073123mr166690qtw.45.1691606297822; Wed, 09 Aug
 2023 11:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
 <20230807-mgctime-v7-8-d1dec143a704@kernel.org> <20230809-segeln-pflaumen-460b81bd2d3a@brauner>
In-Reply-To: <20230809-segeln-pflaumen-460b81bd2d3a@brauner>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Wed, 9 Aug 2023 14:38:07 -0400
Message-ID: <CAOg9mST=WFAjEwS9eNi_huoUpBvPy3R3fbFVTLUeFZAv6BJEEQ@mail.gmail.com>
Subject: Re: [PATCH v7 08/13] fs: drop the timespec64 argument from update_time
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
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
        Jan Kara <jack@suse.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
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
        Amir Goldstein <amir73il@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've been following this patch on fsdevel... is there a
remote I could fetch with a branch that has this in it?

-Mike

On Wed, Aug 9, 2023 at 8:32=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Mon, Aug 07, 2023 at 03:38:39PM -0400, Jeff Layton wrote:
> > Now that all of the update_time operations are prepared for it, we can
> > drop the timespec64 argument from the update_time operation. Do that an=
d
> > remove it from some associated functions like inode_update_time and
> > inode_needs_update_time.
> >
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/bad_inode.c           |  3 +--
> >  fs/btrfs/inode.c         |  3 +--
> >  fs/btrfs/volumes.c       |  4 +---
> >  fs/fat/fat.h             |  3 +--
> >  fs/fat/misc.c            |  2 +-
> >  fs/gfs2/inode.c          |  3 +--
> >  fs/inode.c               | 30 +++++++++++++-----------------
> >  fs/overlayfs/inode.c     |  2 +-
> >  fs/overlayfs/overlayfs.h |  2 +-
> >  fs/ubifs/file.c          |  3 +--
> >  fs/ubifs/ubifs.h         |  2 +-
> >  fs/xfs/xfs_iops.c        |  1 -
> >  include/linux/fs.h       |  4 ++--
>
> This was missing the conversion of fs/orangefs orangefs_update_time()
> causing the build to fail. So at some point kbuild will yell here.
> Fwiw, I've fixed that up in-tree.
