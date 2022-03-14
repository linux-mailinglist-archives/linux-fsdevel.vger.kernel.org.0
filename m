Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827D44D8FD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 23:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbiCNWqu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 18:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbiCNWqt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:46:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE08136173;
        Mon, 14 Mar 2022 15:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D0Z22KQQxwYjzOvYM7WsI37q+7g8YdO5f8f+qk77u9s=; b=YDPvVSxFNmcud3pBJlvRspp2M+
        rWXmXzqkrL49o7PQgu54oOGl98Xix6CVniW69ad+dbMBNXVqn2UayF9Y+tjJ+avNj0kpIHCSBJVnY
        AKG2jYpcMJa7dlmkF3t1amQtR54wLVyqwbB9o+Ra0gninfKuN+n+h8l9hvWmAPruhtPInnn4XpUxJ
        tpU0y66+L3go9pUqPZCWUNJZfoNu05fKFmtgwKTmOAOT3aQHSar2wHUMCeqhxc1yKNK8Kxpezrykf
        d5T1trEjQqWMR+sCaNQCFjgmNrShl19hJvHzq0FbWPrAv5Du3TWwlvk2Z7rX66rqN4dXnllCL1Tqp
        /R55kkOw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTtRQ-0074q7-W3; Mon, 14 Mar 2022 22:45:28 +0000
Date:   Mon, 14 Mar 2022 15:45:28 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.cz>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-btrfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>
Subject: btrfs profiles to test was: (Re: [LSF/MM TOPIC] FS, MM, and stable
 trees)
Message-ID: <Yi/FiHhw01zW2NXc@bombadil.infradead.org>
References: <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <YieG8rZkgnfwygyu@mit.edu>
 <Yij08f7ee4pDZ2AC@bombadil.infradead.org>
 <Yij2rqDn4TiN3kK9@localhost.localdomain>
 <Yij5YTD5+V2qpsSs@bombadil.infradead.org>
 <YikZ2Zy6CtdNQ7WQ@localhost.localdomain>
 <YilUPAGQBPwI0V3n@bombadil.infradead.org>
 <YipIqqiz91D39nMQ@localhost.localdomain>
 <YiwAWRRS8AmurVm6@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiwAWRRS8AmurVm6@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 06:07:21PM -0800, Luis Chamberlain wrote:
> On Thu, Mar 10, 2022 at 01:51:22PM -0500, Josef Bacik wrote:
> > [root@fedora-rawhide ~]# cat /xfstests-dev/local.config
> > [btrfs_normal_freespacetree]
> > [btrfs_compress_freespacetree]
> > [btrfs_normal]
> > [btrfs_compression]
> > [kdave]
> > [btrfs_normal_noholes]
> > [btrfs_compress_noholes]
> > [btrfs_noholes_freespacetree]
> 
> + linux-btrfs and zone folks.
> 
> The name needs to be: $FS_$FANCY_SINGLE_SPACED_NAME

Actually using_underscores_is_fine for the hostnames so we can keep
your original except kdave :) and that just gets mapped to btrfs_kdave
for now until you guys figure out what to call it.

Likewise it would be useful if someone goees through these and gives me
hints as to the kernel revision that supports such config, so that if
testing on stable for instance or an older kernel, then the kconfig
option for them does not appear.

> I see nothing for NVMe ZNS.. so how about 
> 
> [btrfs_zns]
> MKFS_OPTIONS="-f -d single -m single"
> TEST_DEV=@FSTESTSTESTZNSDEV@
> SCRATCH_DEV_POOL="@FSTESTSSCRATCHDEVZNSPOOL@"
> 
> [btrfs_simple]
> TEST_DEV=@FSTESTSTESTSDEV@
> MKFS_OPTIONS="-f -d single -m single"
> SCRATCH_DEV_POOL="@FSTESTSSCRATCHDEVPOOL@"
> 
> The idea being btrfs_simple will not use zns drives behind the scenes
> but btrfs_zns will.

I went with:

[btrfs_simple]
[btrfs_simple_zns]

If there are other ZNS profiles we can use / should test please let me know.

Thanks,

  Luis
