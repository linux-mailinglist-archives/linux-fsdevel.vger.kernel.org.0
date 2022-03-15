Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA204DA17A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 18:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350222AbiCORn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 13:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346789AbiCORny (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:43:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990DA58E76;
        Tue, 15 Mar 2022 10:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rHAQfd7cRwkz10qwPdHw3mB9SrDXxAH5OuCmqTG1YJQ=; b=vZfoOUjhy/Q0fRDq/RQsU4hKsv
        oBPwho0CUYG49MBJKmH9/2sTilldZWScG9j4DqSmU009OxGpZYAfR3Ci8Hz/j6zF2D+UFnfg+SN/3
        RngOEJ/IIvRjMlSG9PMtvnYlpJ+2JUqiCgxSz7F6v2pzUgTSVGeAFK252AfwYer3ymPYds1yyRSKc
        Y/lnu+BT3sueW7ICWhUGS86aTSVfsI5QM0HOMPm8vUswt6P4ROP9MzqR9IatlfOWrJQf4cdppWj6R
        mH1q0t1ExXpmqG4W92sI7RfWDqMhACbuzqRLKaEjd1VaCFK2v8jTCwelTNRzrinUVJAeHj2I5ArTM
        2pR51xQg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUBBq-00A5z6-3B; Tue, 15 Mar 2022 17:42:34 +0000
Date:   Tue, 15 Mar 2022 10:42:34 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
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
Subject: Re: btrfs profiles to test was: (Re: [LSF/MM TOPIC] FS, MM, and
 stable trees)
Message-ID: <YjDQCgYeD1otOShE@bombadil.infradead.org>
References: <YieG8rZkgnfwygyu@mit.edu>
 <Yij08f7ee4pDZ2AC@bombadil.infradead.org>
 <Yij2rqDn4TiN3kK9@localhost.localdomain>
 <Yij5YTD5+V2qpsSs@bombadil.infradead.org>
 <YikZ2Zy6CtdNQ7WQ@localhost.localdomain>
 <YilUPAGQBPwI0V3n@bombadil.infradead.org>
 <YipIqqiz91D39nMQ@localhost.localdomain>
 <YiwAWRRS8AmurVm6@bombadil.infradead.org>
 <Yi/FiHhw01zW2NXc@bombadil.infradead.org>
 <YjCheepcDh/oRp9M@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjCheepcDh/oRp9M@localhost.localdomain>
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

On Tue, Mar 15, 2022 at 10:23:53AM -0400, Josef Bacik wrote:
> On Mon, Mar 14, 2022 at 03:45:28PM -0700, Luis Chamberlain wrote:
> > On Fri, Mar 11, 2022 at 06:07:21PM -0800, Luis Chamberlain wrote:
> > > On Thu, Mar 10, 2022 at 01:51:22PM -0500, Josef Bacik wrote:
> > > > [root@fedora-rawhide ~]# cat /xfstests-dev/local.config
> > > > [btrfs_normal_freespacetree]
> > > > [btrfs_compress_freespacetree]
> > > > [btrfs_normal]
> > > > [btrfs_compression]
> > > > [kdave]
> > > > [btrfs_normal_noholes]
> > > > [btrfs_compress_noholes]
> > > > [btrfs_noholes_freespacetree]
> > > 
> > > + linux-btrfs and zone folks.
> > > 
> > > The name needs to be: $FS_$FANCY_SINGLE_SPACED_NAME
> > 
> > Actually using_underscores_is_fine for the hostnames so we can keep
> > your original except kdave :) and that just gets mapped to btrfs_kdave
> > for now until you guys figure out what to call it.
> > 
> 
> Lol you didn't need to save the name, I just threw that in there because Sterba
> wanted me to test something specific for some patch and I just never deleted it.

Heh, I figured, I just didn't know what the hell to name that.

> > Likewise it would be useful if someone goees through these and gives me
> > hints as to the kernel revision that supports such config, so that if
> > testing on stable for instance or an older kernel, then the kconfig
> > option for them does not appear.
> > 
> 
> I'm cloning this stuff and doing it now, I got fed up trying to find the
> performance difference between virtme and libvirt.  If your shit gives me the
> right performance and makes it so I don't have to think then I'll be happy
> enough to use it.  Thanks,

Groovy.

  Luis
