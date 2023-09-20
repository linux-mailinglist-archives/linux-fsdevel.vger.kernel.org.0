Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E9E7A87A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 16:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbjITOxx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 10:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbjITOxu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:53:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78473A9;
        Wed, 20 Sep 2023 07:53:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10CFC433C7;
        Wed, 20 Sep 2023 14:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695221624;
        bh=pv/mshlnOGkJ5ebR+d6AqRiPt7G4UklH+5Y/YwatjVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hUm3CDqBbqdWl1gTcXLfMGrJ4YfO3wokaDGaQDO3xOEWDbllQ4Mfpj/KueremMgA5
         pBL/JzWz4+0hsTX69O5jnf1yRuwKeufAxYGRi9hiZ4ho9usSCqwyLkEScujErQvTLd
         pH8R4MxKr1CGxSHyPru+0iqA3gh7pydF57H5YT0p+7Rd0zhQBTnYL0en9hUyWFooe+
         Mdfj3r0q5YN+5TWuL0JXteBwUKeABbsXdunQnhbthSc1EwQj0hbuY8ac5vX7VekjTf
         fGOHz5omQ2+B/RCVrXr9woAH7FyctwMygMiv3giawQBEFR5HdvJ9UunmoJQb2brq0N
         41leRmH4Vm1Jg==
Date:   Wed, 20 Sep 2023 16:53:26 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     Bruno Haible <bruno@clisp.org>,
        Xi Ruoyao <xry111@linuxfromscratch.org>,
        "bug-gnulib@gnu.org" <bug-gnulib@gnu.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        "coda@cs.cmu.edu" <coda@cs.cmu.edu>,
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
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "codalist@coda.cs.cmu.edu" <codalist@coda.cs.cmu.edu>,
        "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>,
        "devel@lists.orangefs.org" <devel@lists.orangefs.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
Message-ID: <20230920-keine-eile-c9755b5825db@brauner>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
 <20230919110457.7fnmzo4nqsi43yqq@quack3>
 <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
 <4511209.uG2h0Jr0uP@nimes>
 <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
 <20230920-leerung-krokodil-52ec6cb44707@brauner>
 <20230920101731.ym6pahcvkl57guto@quack3>
 <317d84b1b909b6c6519a2406fcb302ce22dafa41.camel@kernel.org>
 <20230920-raser-teehaus-029cafd5a6e4@brauner>
 <57C103E1-1AD2-4D86-926C-481BC6BDB191@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57C103E1-1AD2-4D86-926C-481BC6BDB191@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> You could put it behind an EXPERIMENTAL Kconfig option so that the
> code stays in and can be used by the brave or foolish while it is
> still being refined.

Given that the discussion has now fully gone back to the drawing board
and this is a regression the honest thing to do is to revert the five
patches that introduce the infrastructure:

ffb6cf19e063 ("fs: add infrastructure for multigrain timestamps")
d48c33972916 ("tmpfs: add support for multigrain timestamps")
e44df2664746 ("xfs: switch to multigrain timestamps")
0269b585868e ("ext4: switch to multigrain timestamps")
50e9ceef1d4f ("btrfs: convert to multigrain timestamps")

The conversion to helpers and cleanups are sane and should stay and can
be used for any solution that gets built on top of it.

I'd appreciate a look at the branch here:
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.ctime.revert

survives xfstests.
