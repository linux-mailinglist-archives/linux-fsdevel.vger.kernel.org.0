Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06E64D54B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 23:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344366AbiCJWmo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 17:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiCJWmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:42:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891CC182BF0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 14:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+3L7jodFoIUQYj4yIhb5tUpkok/HttGAxp6gleQgQT0=; b=hFNliu0Rfj5bF3Z2SKSdroSPw0
        fLiSunaK6E6tSECeu8Cndvkt4kZhX8g7zZKpnj5uyB5wkPWoCo1zyWcly9XfNp9sb+ujQAVArD138
        +qMRK4TVS2ciKq2o0Vg+iraPJMwowuv2ZCKDY/YCWBnLgtFEdi4ziHhSTWTbfZ8g2CW1WVC4Q42La
        FW47VWbNXz8J7IKXqSxB9EFgcAcgKY0/psOznVgpHXo8Kr0zEIs3NiXYBCxPd3t/WQflS7idK/L5z
        zpzEntowZHMCxaLEiOjoObCoiy929Zyyeoc3PpyMLQq3yQGC2Yly899pEJA2DDNLanKc2FtKzOyfB
        l/p9wKXw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSRTO-00EDul-5z; Thu, 10 Mar 2022 22:41:30 +0000
Date:   Thu, 10 Mar 2022 14:41:30 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <Yip+mh0TY77XfPlc@bombadil.infradead.org>
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
> On Wed, Mar 09, 2022 at 05:28:28PM -0800, Luis Chamberlain wrote:
> > On Wed, Mar 09, 2022 at 04:19:21PM -0500, Josef Bacik wrote:
> > > On Wed, Mar 09, 2022 at 11:00:49AM -0800, Luis Chamberlain wrote:
> > 
> > That's great!
> > 
> > But although this runs nightly, it seems this runs fstest *once* to
> > ensure if there are no regressions. Is that right?
> > 
> 
> Yup once per config, so 8 full fstest runs.

From my experience that is not enough to capture all failures given
lower failure rates on tests other than 1/1, like 1/42 or
1/300. So minimum I'd go for 500 loops of fstests per config.
This does mean this is not possible nightly though, yes. 5 days
on average. And so much more work is needed to bring this down
further.

> > > This was all put together to build into something a little more polished, but
> > > clearly priorities being what they are this is as far as we've taken it.  For
> > > configuration you can see my virt-scripts here
> > > https://github.com/josefbacik/virt-scripts which are what I use to generate the
> > > VM's to run xfstests in.
> > > 
> > > The kernel config I use is in there, I use a variety of btrfs mount options and
> > > mkfs options, not sure how interesting those are for people outside of btrfs.
> > 
> > Extremely useful.
> > 
> 
> [root@fedora-rawhide ~]# cat /xfstests-dev/local.config
> [btrfs_normal_freespacetree]
> TEST_DIR=/mnt/test
> TEST_DEV=/dev/mapper/vg0-lv0
> SCRATCH_DEV_POOL="/dev/mapper/vg0-lv7 /dev/mapper/vg0-lv6 /dev/mapper/vg0-lv5 /dev/mapper/vg0-lv4 /dev/mapper/vg0-lv3 /dev/mapper/vg0-lv2 /dev/mapper/vg0-lv1 "
> SCRATCH_MNT=/mnt/scratch
> LOGWRITES_DEV=/dev/mapper/vg0-lv8
> PERF_CONFIGNAME=jbacik
> MKFS_OPTIONS="-K -f -O ^no-holes"
> MOUNT_OPTIONS="-o space_cache=v2"
> FSTYP=btrfs
> 
> [btrfs_compress_freespacetree]
> MOUNT_OPTIONS="-o compress=zlib,space_cache=v2"
> MKFS_OPTIONS="-K -f -O ^no-holes"
> 
> [btrfs_normal]
> TEST_DIR=/mnt/test
> TEST_DEV=/dev/mapper/vg0-lv0
> SCRATCH_DEV_POOL="/dev/mapper/vg0-lv9 /dev/mapper/vg0-lv8 /dev/mapper/vg0-lv7 /dev/mapper/vg0-lv6 /dev/mapper/vg0-lv5 /dev/mapper/vg0-lv4 /dev/mapper/vg0-lv3 /dev/mapper/vg0-lv2 /dev/mapper/vg0-lv1 "
> SCRATCH_MNT=/mnt/scratch
> LOGWRITES_DEV=/dev/mapper/vg0-lv10
> PERF_CONFIGNAME=jbacik
> MKFS_OPTIONS="-K -O ^no-holes -R ^free-space-tree"
> MOUNT_OPTIONS="-o discard=async"
> 
> [btrfs_compression]
> MOUNT_OPTIONS="-o compress=zstd,discard=async"
> MKFS_OPTIONS="-K -O ^no-holes -R ^free-space-tree"
> 
> [kdave]
> MKFS_OPTIONS="-K -O no-holes -R ^free-space-tree"
> MOUNT_OPTIONS="-o discard,space_cache=v2"
> 
> [root@xfstests3 ~]# cat /xfstests-dev/local.config
> [btrfs_normal_noholes]
> TEST_DIR=/mnt/test
> TEST_DEV=/dev/mapper/vg0-lv0
> SCRATCH_DEV_POOL="/dev/mapper/vg0-lv9 /dev/mapper/vg0-lv8 /dev/mapper/vg0-lv7 /dev/mapper/vg0-lv6 /dev/mapper/vg0-lv5 /dev/mapper/vg0-lv4 /dev/mapper/vg0-lv3 /dev/mapper/vg0-lv2 /dev/mapper/vg0-lv1 "
> SCRATCH_MNT=/mnt/scratch
> LOGWRITES_DEV=/dev/mapper/vg0-lv10
> PERF_CONFIGNAME=jbacik
> MKFS_OPTIONS="-K -O no-holes -f -R ^free-space-tree"
> 
> [btrfs_compress_noholes]
> MKFS_OPTIONS="-K -O no-holes -f -R ^free-space-tree"
> MOUNT_OPTIONS="-o compress=lzo"
> 
> [btrfs_noholes_freespacetree]
> MKFS_OPTIONS="-K -O no-holes -f"
> MOUNT_OPTIONS="-o space_cache=v2"

Thanks I can eventually cake these in to kdevops (or patches welcmeD)
modulo I use loopback/truncated filews. It is possible to add an option
to use dm linear too if that is really desirable.

> > > Right now I have a box with ZNS drives waiting for me to set this up on so that
> > > we can also be testing btrfs zoned support nightly, as well as my 3rd
> > > RaspberryPi that I'm hoping doesn't blow up this time.
> > 
> > Great to hear you will be covering ZNS as well.
> > 
> > > I have another virt setup that uses btrfs snapshots to create a one off chroot
> > > to run smoke tests for my development using virtme-run.  I want to replace the
> > > libvirtd vms with virtme-run, however I've got about a 2x performance difference
> > > between virtme-run and libvirtd that I'm trying to figure out, so right now all
> > > the nightly test VM's are using libvirtd.
> > > 
> > > Long, long term the plan is to replace my janky home setup with AWS VM's that
> > > can be fired from GitHub actions whenever we push branches, that way individual
> > > developers can get results for their patches before they're merged, and we don't
> > > have to rely on my terrible python+html for test results.
> > 
> > If you do move to AWS just keep in mind using loopback drives +
> > truncated files *finds* more issues than not. So when I used AWS
> > I got two spare nvme drives and used one to stuff the truncated
> > files there.
> > 
> 
> My plan was to get ones with attached storage and do the LVM thing I do for my
> vms.

The default for AWS for kdevops is to use m5ad.4xlarge (~$0.824 per
Hour) that comes with 61 GiB RAM, 16 vcpus, 1 8 GiB main drive, and two
additional 300 GiB nvme drives. The nvme drives are used so to also
mimic the KVM setup when kdevops uses local virtualization.

FWIW, the kdevops AWS kconfig is at terraform/aws/Kconfig

  Luis
