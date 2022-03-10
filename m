Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AF14D563C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 01:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbiCKAAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 19:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345093AbiCKAAo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:00:44 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4624DDBD0D
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 15:59:38 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id w12so12224639lfr.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 15:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MocVVrMh3F8v4LYKGaMV51Hsn56CobhowxFuvpnbz/M=;
        b=oNOgi3+MZhbEWIiEQPgy+GQON7LKrd2NBnt21TSCdVeMNGYJwrTXEqBiioy5AF5U0d
         t/p5VuHR18EW0IwsBx7y/kNYI8nExO2QIZlK9a35qWVb+X4RPQ6b/j69071nzzBSBh2M
         KU4n1VH4TJZ39jzbMfOAHc5WdBn8hgiOhoFxeMi248VU1iI8vPS6Pk4U5uSn+ZqIl/7c
         8CuvzPBGyNOiwn1uogrnrXkp2AgxRP8EqUdIrf6JKS4AtJ4wMoakaN+M61n6PzwdaWux
         a/GDb4va+E+j2R6y1IJQDr9nVELiwlpiYJd1/NOZ0zY47JTASQokdE2CB3WLEoWCrs2F
         TB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MocVVrMh3F8v4LYKGaMV51Hsn56CobhowxFuvpnbz/M=;
        b=ugu3M8dtyjDW+mihJVglvHLjuFk2D+zG8IUJNFE+BCizjPUX4YYqVr/JYZa0+uLt2x
         holjQXSp9NJzT6hLFyIInLCE96eAFmPcnYDZwksao4WRywQCy0E687lYRgN2+R3e4rCz
         ig9g4FZhIjNewsGVcvxtXaCnDfZXOm7PsLWGOrhdAvwtC3fxyGaUayPQQf5puqEE4oPX
         5ow2gFDfffqrJwgmmai5mNrDm1IrBBSKDJLZ2+N7ogFoTha6HrpE95AbStCp/PfJzPV5
         T2vmDIfE25N9nFbuh16rqyaQvyijVnbxNKyJPwlXYBabNX8x3Bxa2dnkyoRItzHd8ms2
         RD3Q==
X-Gm-Message-State: AOAM533SD9mRDbyGdwQEMNW4esHj4AEo3JX7EORzdxuIDC77sH0DDzuj
        x31Zwz/+EdW2khQrw4e69eM6JgYCmFlA4RFO9aOi7cuELTQ=
X-Google-Smtp-Source: ABdhPJy8rDO4PMRpSyz0iE2AjomAsUpUJcojQkukk6al20UOpA3SDygCGhCkyLCIsYl8z6vF92FIr5xFlHlqwKwRStM=
X-Received: by 2002:a05:6512:b19:b0:446:f1c6:81bd with SMTP id
 w25-20020a0565120b1900b00446f1c681bdmr4458598lfu.320.1646956776431; Thu, 10
 Mar 2022 15:59:36 -0800 (PST)
MIME-Version: 1.0
References: <20190212170012.GF69686@sasha-vm> <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com> <CAOQ4uxjjdFgdMxEOq7aW-nLZFf-S99CC93Ycg1CcMUBiRAYTQQ@mail.gmail.com>
 <YiepUS/bDKTNA5El@sashalap>
In-Reply-To: <YiepUS/bDKTNA5El@sashalap>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 10 Mar 2022 17:59:24 -0600
Message-ID: <CAH2r5msh55UBczN=DZHx15f7hHrnOpdMUj+jFunR5E4S3sy=wQ@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
To:     Sasha Levin <sashal@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 8, 2022 at 6:16 PM Sasha Levin <sashal@kernel.org> wrote:
>
> On Tue, Mar 08, 2022 at 01:04:05PM +0200, Amir Goldstein wrote:
> >On Tue, Mar 8, 2022 at 12:08 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Tue, Mar 08, 2022 at 11:32:43AM +0200, Amir Goldstein wrote:
> >> > On Tue, Feb 12, 2019 at 7:31 PM Sasha Levin <sashal@kernel.org> wrote:
> >> > >
> >> > > Hi all,
> >> > >
> >> > > I'd like to propose a discussion about the workflow of the stable trees
> >> > > when it comes to fs/ and mm/. In the past year we had some friction with
> >> > > regards to the policies and the procedures around picking patches for
> >> > > stable tree, and I feel it would be very useful to establish better flow
> >> > > with the folks who might be attending LSF/MM.

I would like to participate in this as well - it is very important
that we improve
test automation processes.  We run a series of tests, hosted with VMs in Azure
(mostly xfstests but also the git fs regression tests and various ones
that are fs specific
for testing various scenarios like reconnect and various fs specific
mount options)
regularly (on every pull request sent upstream to mainline) for cifs.ko and
also for the kernel server (ksmbd.ko) as well.

This does leave a big gap for stable although Redhat and SuSE seem to
run a similar set of regression tests so not much risk for the distros.

In theory we could periodically run the cifs/smb3.1.1 automated tests
against stable,
perhaps every few weeks and send results somewhere if there was a process
for this for the various fs - but the tests we run were pretty clearly listed
(and also in the wiki.samba.org) so may be easier ways to do this.  Tests could
be run locally on the same machine to ksmbd from cifs.ko (or to Samba if
preferred) so nothing extra to setup.

Would be worth discussing the best process for automating something like
this - others may have figured out tricks that could help all fs in this
xfstest automation


> >> > > I feel that fs/ and mm/ are in very different places with regards to
> >> > > which patches go in -stable, what tests are expected, and the timeline
> >> > > of patches from the point they are proposed on a mailing list to the
> >> > > point they are released in a stable tree. Therefore, I'd like to propose
> >> > > two different sessions on this (one for fs/ and one for mm/), as a
> >> > > common session might be less conductive to agreeing on a path forward as
> >> > > the starting point for both subsystems are somewhat different.
> >> > >
> >> > > We can go through the existing processes, automation, and testing
> >> > > mechanisms we employ when building stable trees, and see how we can
> >> > > improve these to address the concerns of fs/ and mm/ folks.


> >> > Hi Sasha,
> >> >
> >> > I think it would be interesting to have another discussion on the state of fs/
> >> > in -stable and see if things have changed over the past couple of years.


-- 
Thanks,

Steve
