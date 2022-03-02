Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B194B4CB2EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 00:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiCBXq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 18:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiCBXq4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 18:46:56 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414A316BFA8
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 15:45:15 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id r2so1669543qvr.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Mar 2022 15:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=POl3X+MS9z4/zg0I0s5Rak0q2bpB1oIsfa0s17HoEe8=;
        b=lFxVCw6Let3F2eB0bYPug8Sd6DtB6tpBrMCEeAwe5g+R1MrjJ6bNaCrwyI3aD9Iamr
         Wdv0tfc2tGbRxjA7S0yvHtX41CoevxbA7faNMRdPXsHHxse3nSgm+y0sfdcz2F+u4yVP
         OfsYn21LBmJIhrDyVOhr0E+IfzkTLcq+PMqn9N01ZFxYUpqXLKDN1Tm92X+ZBlZrV3Cr
         leb5ps880wtbKvThVdeZxVgQYbCQlcEzEORlur+Wv5DqQJEBVFmi1pFE2dcrVIc8gRTg
         ZMZrSjoEqjSIbFTeCKQ5KKELXEBeYLQRZJAtjCUnkFqpHWODkNcYhyCgneFMEfM4NdiN
         yqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=POl3X+MS9z4/zg0I0s5Rak0q2bpB1oIsfa0s17HoEe8=;
        b=ypRsQ947trBUIThQp14f/ryAcH5/Oyj0FzFFJdrIX/HOEARU9tPpJc/xM6B8EOzTuB
         o38urRfq85U0urDLTk+driMLeS7V91FH8xVPZMnNimrjPUWhDLjkr7oKiEbTOIQPcqiL
         8SK7YhGDvOgLapjxY3GSTc+k6qrVT9EvKSZtNiv0m6uDUdovoqpY8a2ISDDB1hE8ks/Q
         61P4I3Nu4LjwR/zpF7XXRqFv9uqanMRzU2TgwOEP1lLDTjgjajfwm3zrmYEUM+t3QAaI
         l3zoq7KhtLYC0FmKn+xFoDSN+FnGMrillAMkaSLTfgpNmLfdfToc8dzS+pEQCdeTLGOZ
         r2dg==
X-Gm-Message-State: AOAM532d2wx8X0IwDPsVHSq43/UCdKvP/NpEAVsPCvqND0GZelRGtsc0
        Zn+WgUCXhHxyzqBbKBJ8Bwfo6A==
X-Google-Smtp-Source: ABdhPJzUckeIi4V4oQ4UMs+AuijzvU07YtbQUIv3tAamK5Zf5JDiokn85bM7Lxr0T9xgiDPVYM5y7g==
X-Received: by 2002:a05:6214:8cf:b0:432:4007:b7dd with SMTP id da15-20020a05621408cf00b004324007b7ddmr21952866qvb.37.1646264714212;
        Wed, 02 Mar 2022 15:45:14 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c8-20020ae9e208000000b0064930bb4bc9sm256291qkc.71.2022.03.02.15.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 15:45:13 -0800 (PST)
Date:   Wed, 2 Mar 2022 18:45:12 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: nfs generic/373 failure after "fs: allow cross-vfsmount
 reflink/dedupe"
Message-ID: <YiABiLtH/4nMJE+u@localhost.localdomain>
References: <20220301184221.371853-1-amir73il@gmail.com>
 <20220302065952.GE3927073@dread.disaster.area>
 <CAOQ4uxgU7cYAO+KMd=Yb8Fo4AwScQ2J0eqkYn3xWjzBWKtUziQ@mail.gmail.com>
 <20220302082658.GF3927073@dread.disaster.area>
 <CAOQ4uxgiL2eqx-kad+dddXvXPREKT-w3_BnLzdoJaJqGm=H=vA@mail.gmail.com>
 <20220302211226.GG3927073@dread.disaster.area>
 <20220302220450.GD10757@fieldses.org>
 <Yh/vADRGuPFGIEc+@localhost.localdomain>
 <20220302224250.GF10757@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302224250.GF10757@fieldses.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 02, 2022 at 05:42:50PM -0500, J. Bruce Fields wrote:
> On Wed, Mar 02, 2022 at 05:26:08PM -0500, Josef Bacik wrote:
> > On Wed, Mar 02, 2022 at 05:04:50PM -0500, J. Bruce Fields wrote:
> > > I started seeing generic/373 fail on recent linux-next in NFS testing.
> > > 
> > > Bisect lands it on aaf40970b1d0 "fs: allow cross-vfsmount
> > > reflink/dedupe".
> > > 
> > > The test fails because a clone between two mounts is expected to fail,
> > > and no longer does.
> > > 
> > > In my setup both mounts are nfs mounts.  They are mounts of different
> > > exports, and the exports are exports of different filesystems.  So it
> > > does make sense that the clone should fail.
> > > 
> > > I see the NFS client send a CLONE rpc to the server, and the server
> > > return success.  That seems wrong.
> > > 
> > > Both exported filesystems are xfs, and from the code it looks like the
> > > server calls vfs_clone_file_range(), which ends up calling
> > > xfs_file_remap_range().
> > > 
> > > Are we missing a check now in that xfs case?
> > > 
> > > I haven't looked any more closely at what's going on, so I could be
> > > missing something.
> > > 
> > 
> > Yeah there's a few fstests that test this functionality that need to be removed,
> > I have patches pending for this in our fstests staging tree (since we run
> > fstests nightly on our tree)
> > 
> > https://github.com/btrfs/fstests/tree/staging
> > 
> > Right now the patches just remove the tests from auto since that's what we run,
> > I'll remove them properly once the patch lands in linus.  Thanks,
> 
> So, out of curiosity, what is xfs doing in this case?  These are two
> filesystems on separate partitions, is it falling back on a read/write
> loop or something?

I don't think so?  I'm actually kind of confused, because nfsd does
vfs_clone_file_range, and the only place I messed with for CLONE was
ioctl_clone_file, so the patch changed literally nothing, unless you aren't
using nfsd for the server?

And if they are in fact two different file systems the i_sb != i_sb of the
files, so there's something pretty strange going on here, my patch shouldn't
affect your setup.  Thanks,

Josef
