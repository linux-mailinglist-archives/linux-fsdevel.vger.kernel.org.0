Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878857762CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 16:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjHIOoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 10:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjHIOof (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:44:35 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F5561FCC;
        Wed,  9 Aug 2023 07:44:34 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 593222055FA0;
        Wed,  9 Aug 2023 23:44:33 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.17.2/8.17.2/Debian-1) with ESMTPS id 379EiWdd218003
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 23:44:33 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.17.2/8.17.2/Debian-1) with ESMTPS id 379EiV6k197737
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 23:44:31 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.17.2/8.17.2/Submit) id 379EiQ5o197730;
        Wed, 9 Aug 2023 23:44:26 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
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
        Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@gl0jj8bn.sched.sma.tdnsstic1.cn>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
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
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@telemann.coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 05/13] fat: make fat_update_time get its own timestamp
In-Reply-To: <7edc9239f73022b9c2a1d3f4f946153f85f94739.camel@kernel.org> (Jeff
        Layton's message of "Wed, 09 Aug 2023 10:22:54 -0400")
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
        <20230807-mgctime-v7-5-d1dec143a704@kernel.org>
        <87msz08vc7.fsf@mail.parknet.co.jp>
        <52bead1d6a33fec89944b96e2ec20d1ea8747a9a.camel@kernel.org>
        <878rak8hia.fsf@mail.parknet.co.jp>
        <7edc9239f73022b9c2a1d3f4f946153f85f94739.camel@kernel.org>
Date:   Wed, 09 Aug 2023 23:44:26 +0900
Message-ID: <874jl88ed1.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> I'm a little confused too. Why do you believe this will break
> -o relatime handling? This patch changes two things:
>
> 1/ it has fat_update_time fetch its own timestamp (and ignore the "now"
> parameter). This is in line with the changes in patch #3 of this series,
> which explains the rationale for this in more detail.
>
> 2/ it changes fat_update_time to also update the i_version if any of
> S_CTIME|S_MTIME|S_VERSION are set. relatime is all about the S_ATIME,
> and it is specifically excluded from that set.
>
> The rationale for the second change is is also in patch #3, but
> basically, we can't guarantee that current_time hasn't changed since we
> last checked for inode_needs_update_time, so if any of
> S_CTIME/S_MTIME/S_VERSION have changed, then we need to assume that any
> of them may need to be changed and attempt to update all 3.
>
> That said, I think the logic in fat_update_time isn't quite right. I
> think want something like this on top of this patch to ensure that the
> S_CTIME and S_MTIME get updated, even if the flags only have S_VERSION
> set.
>
> Thoughts?

I'm not talking about "relatime" at all, I'm always talking about
"lazytime".

I_DIRTY_TIME delays to update on disk inode only if changed
timestamp. But you changed it to I_DIRTY_SYNC, i.e. always update on
disk inode by timestamp.

Thanks.

> ---------------------8<-----------------------
>
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index 080a5035483f..313eef02f45c 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -346,15 +346,21 @@ int fat_update_time(struct inode *inode, int flags)
>         if (inode->i_ino == MSDOS_ROOT_INO)
>                 return 0;
>  
> -       if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
> -               fat_truncate_time(inode, NULL, flags);
> -               if (inode->i_sb->s_flags & SB_LAZYTIME)
> -                       dirty_flags |= I_DIRTY_TIME;
> -               else
> -                       dirty_flags |= I_DIRTY_SYNC;
> -       }
> +       /*
> +        * If any of the flags indicate an expicit change to the file, then we
> +        * need to ensure that we attempt to update all of 3. We do not do
> +        * this in the case of an S_ATIME-only update.
> +        */
> +       if (flags & (S_CTIME | S_MTIME | S_VERSION))
> +               flags |= S_CTIME | S_MTIME | S_VERSION;
> +
> +       fat_truncate_time(inode, NULL, flags);
> +       if (inode->i_sb->s_flags & SB_LAZYTIME)
> +               dirty_flags |= I_DIRTY_TIME;
> +       else
> +               dirty_flags |= I_DIRTY_SYNC;
>  
> -       if ((flags & (S_VERSION|S_CTIME|S_MTIME)) && inode_maybe_inc_iversion(inode, false))
> +       if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
>                 dirty_flags |= I_DIRTY_SYNC;
>

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
