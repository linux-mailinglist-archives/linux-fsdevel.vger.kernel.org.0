Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32F54D1E52
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 18:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241811AbiCHRRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 12:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbiCHRRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:17:54 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CCB52E0B
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 09:16:56 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so22882601oos.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 09:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2f7qD9PLoq5q8cpTr0xujy9+Yf1CxdB5uWsof1rG7q4=;
        b=c1aRt6g1//yqIYXbnL8KK33XCu2SDizohc97/Ar+wV7e+YJNhXGXWqX0vBevgDrWbq
         Phr/0STZ5GoU5NF8lVAGJRqy4jEHHRJdqMv+D8jRRKEUgeAFVRNkIsYzBEUPEkXxVSTm
         hm/HQPQwv56bLHq33BMS/5CKl2m+Phoe2jAVadGv8uj1cDROLuMeGxsmvALIJt3p/A2S
         K6HZT1TKlJA7bn/gb1GVlDdLDPfuTClo9lHLt2xqFVc8VBS4SrMH5HccauN101Y/hVYt
         tiTttUqpmw4N33aacM47ewI6metWKcqRwfM7icUSv8dttHQEjaXPvwlZVL5qUiRBYer7
         vvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2f7qD9PLoq5q8cpTr0xujy9+Yf1CxdB5uWsof1rG7q4=;
        b=VVhZeS8CJhulu3d/2/lJEicZKOPQ8d4Pe7bK8BoKMbYfn39iql0/u5u0wUW7zrw4st
         DbK+eD2qw9rubXD2mmCx/hAPYAlm7aCEnOdVf9WWJ+bPLVKppXTkngRyb6rVk9erw24o
         cqNng4lnq6Wt0GmHuL6912AJOjZIaEjaxA4LVC06Ac8gOFCL8oM18Y/zTNOD2Oczt1EK
         YbJdEUeo/OkF7oCWdXgrRACdgds73vguXsP3PKmzdcPw2qq+sNZVYqR30TL74pcXDMYi
         gcSlqHNOG+yW6uilkWjK7wwVaILua0zUZaMIke2avmR8G6hy0BIdfbe5S/aMO8+6LxSJ
         bSHQ==
X-Gm-Message-State: AOAM531japwBWNnKOmNW5appsyT9HuZWjFiHUCMtT54ZYBHqi4rGXVz+
        ujqAWU337S2BkSIAvloZ+muwmLQz3IYLxriq6NE=
X-Google-Smtp-Source: ABdhPJzvzVqJdr9Pn7YNA8Uu0yP4yhhyI2N0deT8l/xizHKHsdNsiKocpDeypKhk+0xKHiVsqqahs0U1/NpeHO2RQUw=
X-Received: by 2002:a05:6870:d20b:b0:da:b3f:2b2c with SMTP id
 g11-20020a056870d20b00b000da0b3f2b2cmr2966615oac.203.1646759816020; Tue, 08
 Mar 2022 09:16:56 -0800 (PST)
MIME-Version: 1.0
References: <20190212170012.GF69686@sasha-vm> <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com> <YieG8rZkgnfwygyu@mit.edu>
In-Reply-To: <YieG8rZkgnfwygyu@mit.edu>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 8 Mar 2022 19:16:44 +0200
Message-ID: <CAOQ4uxg_Ldnfp2oAMBxRhvVFcTjda7fjBruBtPmBM8_2h797sw@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
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

On Tue, Mar 8, 2022 at 6:40 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Mar 08, 2022 at 11:08:48AM +0100, Greg KH wrote:
> > > When one looks at xfstest bug reports on the list for xfs on kernels > v4.19
> > > one has to wonder if using xfs on kernels v5.x.y is a wise choice.
> >
> > That's up to the xfs maintainers to discuss.
> >
> > > Which makes me wonder: how do the distro kernel maintainers keep up
> > > with xfs fixes?
> >
> > Who knows, ask the distro maintainers that use xfs.  What do they do?
>
> This is something which is being worked, so I'm not sure we'll need to
> discuss the specifics of the xfs stable backports at LSF/MM.  I'm
> hopeful that by May, we'll have come to some kind of resolution of
> that topic.

Wonderful!

>
> One of my team members has been working with Darrick to set up a set
> of xfs configs[1] recommended by Darrick, and she's stood up an
> automated test spinner using gce-xfstests which can watch a git branch
> and automatically kick off a set of tests whenever it is updated.
> Sasha has also provided her with a copy of his scripts so we can do
> automated cherry picks of commits with Fixes tags.  So the idea is
> that we can, hopefully in a mostly completely automated fashion, do
> the backports and do a full set of regression tests on those stable
> backports of XFS bug fixes.
>
> [1] https://github.com/tytso/xfstests-bld/tree/master/kvm-xfstests/test-appliance/files/root/fs/xfs/cfg
>
> Next steps are to get a first tranche of cherry-picks for 5.10 and
> probably 5.15, and use the test spinner to demonstrate that they don't
> have any test regressions (if there are, we'll drop those commits).
> Once we have a first set of proposed stable backports for XFS, we'll
> present them to the XFS development community for their input.  There
> are a couple of things that could happen at this point, depending on
> what the XFS community is willing to accept.
>
> The first is that we'll send these tested stable patches directly to
> Greg and Sasha for inclusion in the LTS releases, with the linux-xfs
> list cc'ed so they know what's going into the stable trees.
>
> The second is that we send them only to the linux-xfs list, and they
> have to do whatever approval they want before they go into the
> upstream stable trees.
>
> And the third option, if they aren't willing to take our work or they
> choose to require manual approvals and those approvals are taking too
> long, is that we'll feed the commits into Google's Container-Optimized
> OS (COS) kernel, so that our customers can get those fixes and so we
> can support XFS fully.  This isn't our preferred path; we'd prefer to
> take the backports into the COS tree via the stable trees if at all
> possible.  (Note: if requested, we could also publish these
> backported-and-tested commits on a git tree for other distros to
> take.)
>
> There are still some details we'll need to work out; for example, will
> the XFS maintainers let us do minor/obvious patch conflict
> resolutions, or perhaps those commits which don't cherry-pick cleanly
> will need to go through some round of approval by the linux-xfs list,
> if the "we've run a full set of tests and there are no test
> regressions" isn't good enough for them.
>

If you publish the list of fix commits that did not apply cleanly,
individual contributors that have personal interest in those fixes
can help with the backporting work, pass them back to your bot
for testing and then try to get the backport patches acked/reviewed.

Perhaps we can discuss those details in LSF/MM, but even getting
to auto selected, auto tested dumb fix patches will be far better than
the current state of v5.10.y.

Thanks,
Amir.
