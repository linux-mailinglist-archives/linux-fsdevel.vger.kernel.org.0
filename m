Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B9C4D5241
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 20:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbiCJSw3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 13:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiCJSw1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:52:27 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD29184B7E
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 10:51:25 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id q4so5143705qki.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 10:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8uGn6LZeYQx4Jf9Lmvkfix6TFy44ZRvuMDkKH34AU3Y=;
        b=opJaMryyYFhxaAmiB1NLOfBF+SpiKFd/e/LFGpZ9m2NXcAwkzyCjIiMDAN6OehKtxy
         1eKJp1ZCTx8BcFsrYoilALTCIA8nQXAxHDwuKuwN7RnrmMhxJ8GMwaPYMGcvtNY4Hk3y
         AH3RWn69LGejCO60wQHQcdMDM2Zt3ALI/176Ov16RMnTVu+M7OZ9am6UpVmjcbDsISuD
         tzIPDaiEQN8H/XJVzUfQj5lK8t9mwIctxD73Nohv9dqebMxHYUkzgnzSsuHDO+CiitzB
         9d3AEjgI8K/wUADK1tNeZcKYDkC39RQjRA+qIn+3GOOinOo99BNDAb2PshaX8EsFRRFP
         GFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8uGn6LZeYQx4Jf9Lmvkfix6TFy44ZRvuMDkKH34AU3Y=;
        b=xaCQYXQVpup3bBsdthMEaAvu1njCnlIiTf/YiCNUUmzl3j4N8bUDGSBjdZGTb9L/pc
         fMJwapemPVwljseA+0GVj3RmQhFrJKRBBniO4A0OL1sT402UZVw/MbXuXrCrg94mWuLz
         wpRh0ooePb3fh61FJnIQzgMQerwQjQ99hjFo2o5zLLTXmS9n8uPWfXd00upbMuxjbaO+
         x9C7clhekp9n5W/EDp3xieih5vMRM7Bimbfyyfxsa1Vuge2cdwDaFRdrZEHOYctRobPq
         OGvhX7/qcejN5WkTe0tq0fDv+bWMjshZNew+RyRkM8wtsqLjk7jhvpdurTc3fxdKHVHA
         QB+A==
X-Gm-Message-State: AOAM533SzG3GENLWHMyYks3LcEZSbxcbczEdA+DX/oICq1unaj7PxGNg
        ERgByJiB+yRh4xsk2yCp/CGhlg==
X-Google-Smtp-Source: ABdhPJwxed7Q7sXywBdsHGjBkUHVy6oTSXu66cDW3jhQc1o8FQihkRU41U8YbqIHYeNRM0bDSdhyXw==
X-Received: by 2002:ae9:e513:0:b0:67d:2bc6:9620 with SMTP id w19-20020ae9e513000000b0067d2bc69620mr4184275qkf.453.1646938284178;
        Thu, 10 Mar 2022 10:51:24 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z203-20020a3765d4000000b0067b48d49c65sm2635141qkb.95.2022.03.10.10.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 10:51:23 -0800 (PST)
Date:   Thu, 10 Mar 2022 13:51:22 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Message-ID: <YipIqqiz91D39nMQ@localhost.localdomain>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <YieG8rZkgnfwygyu@mit.edu>
 <Yij08f7ee4pDZ2AC@bombadil.infradead.org>
 <Yij2rqDn4TiN3kK9@localhost.localdomain>
 <Yij5YTD5+V2qpsSs@bombadil.infradead.org>
 <YikZ2Zy6CtdNQ7WQ@localhost.localdomain>
 <YilUPAGQBPwI0V3n@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YilUPAGQBPwI0V3n@bombadil.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 09, 2022 at 05:28:28PM -0800, Luis Chamberlain wrote:
> On Wed, Mar 09, 2022 at 04:19:21PM -0500, Josef Bacik wrote:
> > On Wed, Mar 09, 2022 at 11:00:49AM -0800, Luis Chamberlain wrote:
> > > On Wed, Mar 09, 2022 at 01:49:18PM -0500, Josef Bacik wrote:
> > > > On Wed, Mar 09, 2022 at 10:41:53AM -0800, Luis Chamberlain wrote:
> > > > > On Tue, Mar 08, 2022 at 11:40:18AM -0500, Theodore Ts'o wrote:
> > > > > > One of my team members has been working with Darrick to set up a set
> > > > > > of xfs configs[1] recommended by Darrick, and she's stood up an
> > > > > > automated test spinner using gce-xfstests which can watch a git branch
> > > > > > and automatically kick off a set of tests whenever it is updated.
> > > > > 
> > > > > I think its important to note, as we would all know, that contrary to
> > > > > most other subsystems, in so far as blktests and fstests is concerned,
> > > > > simply passing a test once does not mean there is no issue given that
> > > > > some test can fail with a failure rate of 1/1,000 for instance.
> > > > > 
> > > > 
> > > > FWIW we (the btrfs team) have been running nightly runs of fstests against our
> > > > devel branch for over a year and tracking the results.
> > > 
> > > That's wonderful, what is your steady state goal? And do you have your
> > > configurations used public and also your baseline somehwere? I think
> > > this later aspect could be very useful to everyone.
> > > 
> > 
> > Yeah I post the results to http://toxicpanda.com, you can see the results from
> > the runs, and http://toxicpanda.com/performance/ has the nightly performance
> > numbers and graphs as well.
> 
> That's great!
> 
> But although this runs nightly, it seems this runs fstest *once* to
> ensure if there are no regressions. Is that right?
> 

Yup once per config, so 8 full fstest runs.

> > This was all put together to build into something a little more polished, but
> > clearly priorities being what they are this is as far as we've taken it.  For
> > configuration you can see my virt-scripts here
> > https://github.com/josefbacik/virt-scripts which are what I use to generate the
> > VM's to run xfstests in.
> > 
> > The kernel config I use is in there, I use a variety of btrfs mount options and
> > mkfs options, not sure how interesting those are for people outside of btrfs.
> 
> Extremely useful.
> 

[root@fedora-rawhide ~]# cat /xfstests-dev/local.config
[btrfs_normal_freespacetree]
TEST_DIR=/mnt/test
TEST_DEV=/dev/mapper/vg0-lv0
SCRATCH_DEV_POOL="/dev/mapper/vg0-lv7 /dev/mapper/vg0-lv6 /dev/mapper/vg0-lv5 /dev/mapper/vg0-lv4 /dev/mapper/vg0-lv3 /dev/mapper/vg0-lv2 /dev/mapper/vg0-lv1 "
SCRATCH_MNT=/mnt/scratch
LOGWRITES_DEV=/dev/mapper/vg0-lv8
PERF_CONFIGNAME=jbacik
MKFS_OPTIONS="-K -f -O ^no-holes"
MOUNT_OPTIONS="-o space_cache=v2"
FSTYP=btrfs

[btrfs_compress_freespacetree]
MOUNT_OPTIONS="-o compress=zlib,space_cache=v2"
MKFS_OPTIONS="-K -f -O ^no-holes"

[btrfs_normal]
TEST_DIR=/mnt/test
TEST_DEV=/dev/mapper/vg0-lv0
SCRATCH_DEV_POOL="/dev/mapper/vg0-lv9 /dev/mapper/vg0-lv8 /dev/mapper/vg0-lv7 /dev/mapper/vg0-lv6 /dev/mapper/vg0-lv5 /dev/mapper/vg0-lv4 /dev/mapper/vg0-lv3 /dev/mapper/vg0-lv2 /dev/mapper/vg0-lv1 "
SCRATCH_MNT=/mnt/scratch
LOGWRITES_DEV=/dev/mapper/vg0-lv10
PERF_CONFIGNAME=jbacik
MKFS_OPTIONS="-K -O ^no-holes -R ^free-space-tree"
MOUNT_OPTIONS="-o discard=async"

[btrfs_compression]
MOUNT_OPTIONS="-o compress=zstd,discard=async"
MKFS_OPTIONS="-K -O ^no-holes -R ^free-space-tree"

[kdave]
MKFS_OPTIONS="-K -O no-holes -R ^free-space-tree"
MOUNT_OPTIONS="-o discard,space_cache=v2"

[root@xfstests3 ~]# cat /xfstests-dev/local.config
[btrfs_normal_noholes]
TEST_DIR=/mnt/test
TEST_DEV=/dev/mapper/vg0-lv0
SCRATCH_DEV_POOL="/dev/mapper/vg0-lv9 /dev/mapper/vg0-lv8 /dev/mapper/vg0-lv7 /dev/mapper/vg0-lv6 /dev/mapper/vg0-lv5 /dev/mapper/vg0-lv4 /dev/mapper/vg0-lv3 /dev/mapper/vg0-lv2 /dev/mapper/vg0-lv1 "
SCRATCH_MNT=/mnt/scratch
LOGWRITES_DEV=/dev/mapper/vg0-lv10
PERF_CONFIGNAME=jbacik
MKFS_OPTIONS="-K -O no-holes -f -R ^free-space-tree"

[btrfs_compress_noholes]
MKFS_OPTIONS="-K -O no-holes -f -R ^free-space-tree"
MOUNT_OPTIONS="-o compress=lzo"

[btrfs_noholes_freespacetree]
MKFS_OPTIONS="-K -O no-holes -f"
MOUNT_OPTIONS="-o space_cache=v2"


> > Right now I have a box with ZNS drives waiting for me to set this up on so that
> > we can also be testing btrfs zoned support nightly, as well as my 3rd
> > RaspberryPi that I'm hoping doesn't blow up this time.
> 
> Great to hear you will be covering ZNS as well.
> 
> > I have another virt setup that uses btrfs snapshots to create a one off chroot
> > to run smoke tests for my development using virtme-run.  I want to replace the
> > libvirtd vms with virtme-run, however I've got about a 2x performance difference
> > between virtme-run and libvirtd that I'm trying to figure out, so right now all
> > the nightly test VM's are using libvirtd.
> > 
> > Long, long term the plan is to replace my janky home setup with AWS VM's that
> > can be fired from GitHub actions whenever we push branches, that way individual
> > developers can get results for their patches before they're merged, and we don't
> > have to rely on my terrible python+html for test results.
> 
> If you do move to AWS just keep in mind using loopback drives +
> truncated files *finds* more issues than not. So when I used AWS
> I got two spare nvme drives and used one to stuff the truncated
> files there.
> 

My plan was to get ones with attached storage and do the LVM thing I do for my
vms.

> > > Yes, everyone's test setup can be different, but this is why I went with
> > > a loopback/truncated file setup, it does find more issues and so far
> > > these have all been real.
> > > 
> > > It kind of begs the question if we should adopt something like kconfig
> > > on fstests to help enable a few test configs we can agree on. Thoughts?
> > > 
> > 
> > For us (and I imagine other fs'es) the kconfigs are not interesting, it's the
> > combo of different file system features that can be toggled on and off via mkfs
> > as well as different mount options.  For example I run all the different mkfs
> > features through normal mount options, and then again with compression turned
> > on.  Thanks,
> 
> So what I mean by kconfig is not the Linux kernel kconfig, but rather
> the kdevops kconfig options. kdevops essentially has a kconfig symbol
> per mkfs-param-mount config we test. And it runs *ones* guest per each
> of these. For example:
> 
> config FSTESTS_XFS_SECTION_REFLINK_1024
> 	bool "Enable testing section: xfs_reflink_1024"
> 	default y
> 	help
> 	  This will create a host to test the baseline of fstests using the
> 	  following configuration which enables reflink using 1024 byte block
> 	  size.
> 
> 	[xfs_reflink]
> 	MKFS_OPTIONS='-f -m reflink=1,rmapbt=1, -i sparse=1,'
> 	FSTYP=xfs
> 
> The other ones can be found here for XFS:
> 
> https://github.com/mcgrof/kdevops/blob/master/workflows/fstests/xfs/Kconfig
> 
> So indeed, exactly what you mean. What I'm getting at is that it would
> be good to construct these with the community. So it would beg the
> question if we should embrace for instance kconfig language to be
> able to configure fstests (yes I know it is xfstests but I think loose
> new people who tend to assume that xfstest is only for XFS, so I only
> always call it fstests).
> 

Got it, that's pretty cool, I pasted my configs above.  Once I figure out why
virtme is so much slower than libvirtd I'll give kdevops a try and see if I can
make it work for my setup.  Thanks,

Josef
