Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D2B7766A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 19:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjHIRoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 13:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHIRoV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:44:21 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9377810D2;
        Wed,  9 Aug 2023 10:44:19 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id B41832055FA5;
        Thu, 10 Aug 2023 02:44:18 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.17.2/8.17.2/Debian-1) with ESMTPS id 379HiHKW223321
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 02:44:18 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.17.2/8.17.2/Debian-1) with ESMTPS id 379HiHXo222009
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 02:44:17 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.17.2/8.17.2/Submit) id 379HiApg221995;
        Thu, 10 Aug 2023 02:44:10 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
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
In-Reply-To: <2cb998ff14ace352a9dd553e82cfa0aa92ec09ce.camel@kernel.org> (Jeff
        Layton's message of "Wed, 09 Aug 2023 12:30:52 -0400")
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
        <20230807-mgctime-v7-5-d1dec143a704@kernel.org>
        <87msz08vc7.fsf@mail.parknet.co.jp>
        <52bead1d6a33fec89944b96e2ec20d1ea8747a9a.camel@kernel.org>
        <878rak8hia.fsf@mail.parknet.co.jp>
        <20230809150041.452w7gucjmvjnvbg@quack3>
        <87v8do6y8q.fsf@mail.parknet.co.jp>
        <2cb998ff14ace352a9dd553e82cfa0aa92ec09ce.camel@kernel.org>
Date:   Thu, 10 Aug 2023 02:44:10 +0900
Message-ID: <87leek6rh1.fsf@mail.parknet.co.jp>
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

> On Thu, 2023-08-10 at 00:17 +0900, OGAWA Hirofumi wrote:
>> Jan Kara <jack@suse.cz> writes:

[...]

> My mistake re: lazytime vs. relatime, but Jan is correct that this
> shouldn't break anything there.

Actually breaks ("break" means not corrupt fs, means it breaks lazytime
optimization). It is just not always, but it should be always for some
userspaces.

> The logic in the revised generic_update_time is different because FAT is
> is a bit strange. fat_update_time does extra truncation on the timestamp
> that it is handed beyond what timestamp_truncate() does.
> fat_truncate_time is called in many different places too, so I don't
> feel comfortable making big changes to how that works.
>
> In the case of generic_update_time, it calls inode_update_timestamps
> which returns a mask that shows which timestamps got updated. It then
> marks the dirty_flags appropriately for what was actually changed.
>
> generic_update_time is used across many filesystems so we need to ensure
> that it's OK to use even when multigrain timestamps are enabled. Those
> haven't been enabled in FAT though, so I didn't bother, and left it to
> dirtying the inode in the same way it was before, even though it now
> fetches its own timestamps from the clock. Given the way that the mtime
> and ctime are smooshed together in FAT, that seemed reasonable.
>
> Is there a particular case or flag combination you're concerned about
> here?

Yes. Because FAT has strange timestamps that different granularity on
disk . This is why generic time truncation doesn't work for FAT.

Well anyway, my concern is the only following part. In
generic_update_time(), S_[CM]TIME are not the cause of I_DIRTY_SYNC if
lazytime mode.

-	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
+	if ((flags & (S_VERSION|S_CTIME|S_MTIME)) && inode_maybe_inc_iversion(inode, false))
		dirty_flags |= I_DIRTY_SYNC;

If reverted this part to check only S_VERSION, I'm fine.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
