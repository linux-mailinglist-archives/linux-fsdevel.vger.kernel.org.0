Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0A8791C8C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 20:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353462AbjIDSL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 14:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353418AbjIDSLP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:11:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F9613E;
        Mon,  4 Sep 2023 11:11:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87420B80EF3;
        Mon,  4 Sep 2023 18:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22283C433B8;
        Mon,  4 Sep 2023 18:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693851069;
        bh=XLoa47KxRcps38wwidPhLGQHNoTClCg5nlSU2UvnxSI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XZUD/xT7QAeS9CwkDxlRqT/gRWQx0TmxhnpK0eSpl5TdmWje1tq2yvGH+3vZ2+BCT
         jCeZ3PliMwtj4PI/YG14pbxznaZzZiLpm9dwOITxs9QimCVLsdgcY+tXdL8VHHo6Xo
         yN1Gfw9YZmIyD8m43UuRL17+XTyHWk7a5WXn6oF5ggWXw6RS9S101xrDjQsPd+ZkCx
         1CnWWAtQSCxTFtksNwHsJ+bzmvgeWVNV2ZHBFMah4WlUviOzbSHDkb9JT06sfaty1l
         sU4YI09Bt9xI2xASG0RHXL6Mglihp9xk051QekITKNbwSi+f4qbVFzWkXoKrsHAJfp
         TL/wsjYXrOQBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C90EDC2BBD7;
        Mon,  4 Sep 2023 18:11:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 00/89] fs: new accessors for inode->i_ctime
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169385106881.19669.3510550425397118597.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Sep 2023 18:11:08 +0000
References: <20230705185812.579118-1-jlayton@kernel.org>
In-Reply-To: <20230705185812.579118-1-jlayton@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     jk@ozlabs.org, arnd@arndb.de, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        cmllamas@google.com, surenb@google.com,
        dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org, bwarrum@linux.ibm.com, rituagar@linux.ibm.com,
        ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com, dsterba@suse.com, dhowells@redhat.com,
        marc.dionne@auristor.com, viro@zeniv.linux.org.uk,
        raven@themaw.net, luisbg@kernel.org, salah.triki@gmail.com,
        aivazian.tigran@gmail.com, ebiederm@xmission.com,
        keescook@chromium.org, clm@fb.com, josef@toxicpanda.com,
        xiubli@redhat.com, idryomov@gmail.com, jaharkes@cs.cmu.edu,
        coda@cs.cmu.edu, jlbec@evilplan.org, hch@lst.de, nico@fluxnic.net,
        rafael@kernel.org, code@tyhicks.com, ardb@kernel.org,
        xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, linkinjeon@kernel.org,
        sj1557.seo@samsung.com, jack@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        hirofumi@mail.parknet.co.jp, miklos@szeredi.hu,
        rpeterso@redhat.com, agruenba@redhat.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        mikulas@artax.karlin.mff.cuni.cz, mike.kravetz@oracle.com,
        muchun.song@linux.dev, dwmw2@infradead.org, shaggy@kernel.org,
        tj@kernel.org, trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, konishi.ryusuke@gmail.com,
        anton@tuxera.com, almaz.alexandrovich@paragon-software.com,
        mark@fasheh.com, joseph.qi@linux.alibaba.com, me@bobcopeland.com,
        hubcap@omnibond.com, martin@omnibond.com, amir73il@gmail.com,
        mcgrof@kernel.org, yzaikin@google.com, tony.luck@intel.com,
        gpiccoli@igalia.com, al@alarsen.net, sfrench@samba.org,
        pc@manguebit.com, lsahlber@redhat.com, sprasad@microsoft.com,
        senozhatsky@chromium.org, phillip@squashfs.org.uk,
        rostedt@goodmis.org, mhiramat@kernel.org, dushistov@mail.ru,
        hdegoede@redhat.com, djwong@kernel.org, dlemoal@kernel.org,
        naohiro.aota@wdc.com, jth@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, hughd@google.com, akpm@linux-foundation.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, john.johansen@canonical.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        jgross@suse.com, stern@rowland.harvard.edu, lrh2000@pku.edu.cn,
        sebastian.reichel@collabora.com, wsa+renesas@sang-engineering.com,
        quic_ugoswami@quicinc.com, quic_linyyuan@quicinc.com,
        john@keeping.me.uk, error27@gmail.com, quic_uaggarwa@quicinc.com,
        hayama@lineo.co.jp, jomajm@gmail.com, axboe@kernel.dk,
        dhavale@google.com, dchinner@redhat.com, hannes@cmpxchg.org,
        zhangpeng362@huawei.com, slava@dubeyko.com, gargaditya08@live.com,
        penguin-kernel@I-love.SAKURA.ne.jp, yifeliu@cs.stonybrook.edu,
        madkar@cs.stonybrook.edu, ezk@cs.stonybrook.edu,
        yuzhe@nfschina.com, willy@infradead.org, okanatov@gmail.com,
        jeffxu@chromium.org, linux@treblig.org, mirimmad17@gmail.com,
        yijiangshan@kylinos.cn, yang.yang29@zte.com.cn,
        xu.xin16@zte.com.cn, chengzhihao1@huawei.com, shr@devkernel.io,
        Liam.Howlett@Oracle.com, adobriyan@gmail.com,
        chi.minghao@zte.com.cn, roberto.sassu@huawei.com,
        linuszeng@tencent.com, bvanassche@acm.org, zohar@linux.ibm.com,
        yi.zhang@huawei.com, trix@redhat.com, fmdefrancesco@gmail.com,
        ebiggers@google.com, princekumarmaurya06@gmail.com,
        chenzhongjin@huawei.com, riel@surriel.com,
        shaozhengchao@huawei.com, jingyuwang_vip@163.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-usb@vger.kernel.org, v9fs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        autofs@vger.kernel.org, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org,
        linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Wed,  5 Jul 2023 14:58:09 -0400 you wrote:
> v2:
> - prepend patches to add missing ctime updates
> - add simple_rename_timestamp helper function
> - rename ctime accessor functions as inode_get_ctime/inode_set_ctime_*
> - drop individual inode_ctime_set_{sec,nsec} helpers
> 
> I've been working on a patchset to change how the inode->i_ctime is
> accessed in order to give us conditional, high-res timestamps for the
> ctime and mtime. struct timespec64 has unused bits in it that we can use
> to implement this. In order to do that however, we need to wrap all
> accesses of inode->i_ctime to ensure that bits used as flags are
> appropriately handled.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,07/92] fs: add ctime accessors infrastructure
    https://git.kernel.org/jaegeuk/f2fs/c/9b6304c1d537
  - [f2fs-dev,v2,08/92] fs: new helper: simple_rename_timestamp
    https://git.kernel.org/jaegeuk/f2fs/c/0c4767923ed6
  - [f2fs-dev,v2,92/92] fs: rename i_ctime field to __i_ctime
    https://git.kernel.org/jaegeuk/f2fs/c/13bc24457850

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


