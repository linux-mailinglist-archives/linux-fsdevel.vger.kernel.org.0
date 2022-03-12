Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA884D6BCD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 03:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiCLCIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 21:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCLCIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:08:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC70B2A6D35;
        Fri, 11 Mar 2022 18:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=n8AgEWKp9LFRshxYuEwas2r7rF8fdkoMavI6bguLHYM=; b=uKQg5DPbamAXK2FBue7Sc5goqu
        XZk4+n7PKsHGOZRRefQsGUvV4JgleA1MsYZnzMIgebOAczaSBBNWjGpCmSnnP28gnne1hwWtPD7lv
        JK8aPobIN+Nmy/jt6j4ZHQ/1JqxtHRl++6rb1/PKSKUL/MNsmbUmj54OMiZQE1iC+jxHDe2FuS3TS
        KPzKUA1fz6P0vCVmDpYhSNjmrAERaM71j1Cg0Wqqb9aRhm6RLPfBWlvIsbZE83pDsCDzt8T7RUQ42
        A2BHjfmsE93BplkYybzotaH9tlkZWyokZqaoLCWodaEL3DFAYz7q2O0v5WU9Cf/l1ZPMyXAgWUMsb
        9S6WTd9g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSrA9-000ZN5-9H; Sat, 12 Mar 2022 02:07:21 +0000
Date:   Fri, 11 Mar 2022 18:07:21 -0800
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
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <YiwAWRRS8AmurVm6@bombadil.infradead.org>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <YieG8rZkgnfwygyu@mit.edu>
 <Yij08f7ee4pDZ2AC@bombadil.infradead.org>
 <Yij2rqDn4TiN3kK9@localhost.localdomain>
 <Yij5YTD5+V2qpsSs@bombadil.infradead.org>
 <YikZ2Zy6CtdNQ7WQ@localhost.localdomain>
 <YilUPAGQBPwI0V3n@bombadil.infradead.org>
 <YipIqqiz91D39nMQ@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YipIqqiz91D39nMQ@localhost.localdomain>
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

On Thu, Mar 10, 2022 at 01:51:22PM -0500, Josef Bacik wrote:
> [root@fedora-rawhide ~]# cat /xfstests-dev/local.config
> [btrfs_normal_freespacetree]
> [btrfs_compress_freespacetree]
> [btrfs_normal]
> [btrfs_compression]
> [kdave]
> [btrfs_normal_noholes]
> [btrfs_compress_noholes]
> [btrfs_noholes_freespacetree]

+ linux-btrfs and zone folks.

I simplified these as follows, please let me know if the names are
alright. I think we may be able to come up with something more
clever than btrfs_dave. The raid56/noraid56 exist just for the
defaults of the distro/btrfs-progs. The expunge list is used
to determine if something is raid56 or not sadly given we
have no groups for putting tests into the raid56 group. The idea
is some distros don't support raid56 so that is the goal with
the noraid56 config.

The name needs to be: $FS_$FANCY_SINGLE_SPACED_NAME

Each guest spawned will have that same hostname. And likewise
the expunges are collected for each guest hostname. The hostname
is used to pick the expunge directory so to ensure it reflects
the baseline.

You may want to look at this expunge file:

https://github.com/mcgrof/kdevops/blob/master/workflows/fstests/expunges/op=
ensuse-leap/15.3/btrfs/unassigned/btrfs_noraid56.txt=02

[default]
TEST_DEV=3D@FSTESTSTESTDEV@
TEST_DIR=3D@FSTESTSDIR@
SCRATCH_DEV_POOL=3D"@FSTESTSSCRATCHDEVPOOL@"

SCRATCH_MNT=3D@FSTESTSSCRATCHMNT@
RESULT_BASE=3D$PWD/results/$HOST/$(uname -r)

[btrfs_raid56]
MKFS_OPTIONS=3D'-f'
FSTYP=3Dbtrfs

[btrfs_noraid56]
MKFS_OPTIONS=3D'-f'
FSTYP=3Dbtrfs

[btrfs_normalfreespacetree]
LOGWRITES_DEV=3D@FSTESTSLOGWRITESDEV@
MKFS_OPTIONS=3D"-K -f -O ^no-holes"
MOUNT_OPTIONS=3D"-o space_cache=3Dv2"
FSTYP=3Dbtrfs

[btrfs_compressfreespacetree]
MOUNT_OPTIONS=3D"-o compress=3Dzlib,space_cache=3Dv2"
MKFS_OPTIONS=3D"-K -f -O ^no-holes"

[btrfs_normal]
LOGWRITES_DEV=3D@FSTESTSLOGWRITESDEV@
MKFS_OPTIONS=3D"-K -O ^no-holes -R ^free-space-tree"
MOUNT_OPTIONS=3D"-o discard=3Dasync"

[btrfs_compression]
MOUNT_OPTIONS=3D"-o compress=3Dzstd,discard=3Dasync"
MKFS_OPTIONS=3D"-K -O ^no-holes -R ^free-space-tree"

[btrfs_kdave]
MKFS_OPTIONS=3D"-K -O no-holes -R ^free-space-tree"
MOUNT_OPTIONS=3D"-o discard,space_cache=3Dv2"

[btrfs_normalnoholes]
LOGWRITES_DEV=3D@FSTESTSLOGWRITESDEV@
MKFS_OPTIONS=3D"-K -O no-holes -f -R ^free-space-tree"

[btrfs_compressnoholes]
MKFS_OPTIONS=3D"-K -O no-holes -f -R ^free-space-tree"
MOUNT_OPTIONS=3D"-o compress=3Dlzo"

[btrfs_noholesfreespacetree]
MKFS_OPTIONS=3D"-K -O no-holes -f"
MOUNT_OPTIONS=3D"-o space_cache=3Dv2"

I see nothing for NVMe ZNS.. so how about=20

[btrfs_zns]
MKFS_OPTIONS=3D"-f -d single -m single"
TEST_DEV=3D@FSTESTSTESTZNSDEV@
SCRATCH_DEV_POOL=3D"@FSTESTSSCRATCHDEVZNSPOOL@"

[btrfs_simple]
TEST_DEV=3D@FSTESTSTESTSDEV@
MKFS_OPTIONS=3D"-f -d single -m single"
SCRATCH_DEV_POOL=3D"@FSTESTSSCRATCHDEVPOOL@"

The idea being btrfs_simple will not use zns drives behind the scenes
but btrfs_zns will.

  Luis
