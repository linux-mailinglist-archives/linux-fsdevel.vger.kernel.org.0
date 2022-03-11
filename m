Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1360C4D6A6A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 00:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiCKWrH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 17:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiCKWqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:46:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41742DBB92
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Mar 2022 14:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZPzgNgyOXSQq4j6/3Cp7uIUJ1RdwvKUGK420JwTB39U=; b=l0x/l7CcpCAa7cB19xquK8/ey/
        EQ6QKJAqeVveG0yGkWGtNEHRPYUoQixmmDGWWmsYLhQ5rK15vjNaBa565MH9005la5qyPw5UoVOyZ
        hNi81XMzKPmP33nbfa/cBAQYELS8vQckr+3uc0kH0V0fQv3pIKcoGljaYgHBK54q7geZDdHfbx/N2
        M1zI4fo9SOkPS/c7fD54B9Pg+wM0lV8E0r8RjqwEeEQEvrrGlZvgNbKye0vDUDcD2YUU3jW1/yEK/
        +8ezBatYDnwuyIBzr6F4+QguUbDG8s/4rROhm5pMFmTcFfL/ue6pbpH49HDLRqj/SE9WJ1qYoYugy
        6iVzk8Zg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSnsW-000P5U-Tf; Fri, 11 Mar 2022 22:36:56 +0000
Date:   Fri, 11 Mar 2022 14:36:56 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Sasha Levin <sashal@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <YivPCOr85bmqAPcu@bombadil.infradead.org>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <CAOQ4uxjjdFgdMxEOq7aW-nLZFf-S99CC93Ycg1CcMUBiRAYTQQ@mail.gmail.com>
 <YiepUS/bDKTNA5El@sashalap>
 <Yij4lD19KGloWPJw@bombadil.infradead.org>
 <Yirc69JyH5N/pXKJ@mit.edu>
 <Yiu2mRwguHhbVpLJ@bombadil.infradead.org>
 <YivHdetTMVW260df@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YivHdetTMVW260df@mit.edu>
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

On Fri, Mar 11, 2022 at 05:04:37PM -0500, Theodore Ts'o wrote:
> On Fri, Mar 11, 2022 at 12:52:41PM -0800, Luis Chamberlain wrote:
> > 
> > The only way to move forward with enabling more automation for kernel
> > code integration is through better and improved kernel test automation.
> > And it is *exactly* why I've been working so hard on that problem.
> 
> I think we're on the same page here.
> 
> > Also let's recall that just because you have your own test framework
> > it does not mean we could not benefit from others testing our
> > filesystems on their own silly hardware at home as well. Yes tons
> > of projects can be used which wrap fstests...
> 
> No argument from me!  I'm strongly in favor of diversity in test
> framework automation as well as test environments.
> 
> In particular, I think there are some valuable things we can learn
> from each other, in terms of cross polination in terms of features and
> as well as feedback about how easy it is to use a particular test
> framework.
> 
> For example: README.md doesn't say anything about running make as root
> when running "make" as kdevops.  At least, I *think* this is why
> running make as kdevops failed:
> 
> fatal: [localhost]: FAILED! => {"changed": true, "cmd": ["/usr/sbin/apparmor_status", "--enabled"], "delta": "0:00:00.001426", "end": "2022-03-11 16:23:11.769658", "failed_when_result": true, "rc": 0, "start": "2022-03-11 16:23:11.768232", "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}

Ah a check for sudo without privs is in order. I'll add a check.

> (I do have apparmor installed, but it's currently not enabled.  I
> haven't done more experimentation since I'm a bit scared of running
> "make XXX" as root for any package I randomly download from the net,
> so I haven't explored trying to use kdevops, at least not until I set
> up a sandboxed VM.  :-)

Sure. A lot of that setup stuff on the host was added to make it
even easier to use. It however is optional, as otherwise it just
runs sanity checks.

> Including the Debian package names that should be installed would also
> be helpful in kdevops/doc/requirements.md.  That's not a problem for
> the experienced Debian developer, but one of my personal goals for
> kvm-xfstests and gce-xfstests is to allow a random graduate student
> who has presented some research file system like Betrfs at the Usenix
> FAST conference to be able to easily run fstests.  And it sounds like
> you have similar goals of "enabling the average user to also easily
> run tests".

Yup.

Did this requirements doc not suffice?

https://github.com/mcgrof/kdevops/blob/master/docs/requirements.md

> > but I never found one
> > as easy to use as compiling the kernel and running a few make commands.
> 
> I've actually done a lot of work to optimize developer velocity using
> my test framework.  So for example:
> 
> kvm-xfstests install-kconfig    # set up a kernel Kconfig suitable for kvm-xfstests and gce-xfstests
> make
> kvm-xfstests smoke     # boot the test appliance VM, using the kernel that was just built
> 
> And a user can test a particular stable kernel using a single command
> line (this will checkout a particular kernel, and build it on a build
> VM, and then launch tests in parallel on a dozen or so VM's):
> 
> gce-xfstests ltm -c ext4/all -g auto --repo stable.git --commit v5.15.28

Neat we have parity.

> ... or if we want to bisect a particular test failure, we might do
> something like this:
> 
> gce-xfstests ltm -c ext4 generic/361 --bisect-good v5.15 --bisect-bad v5.16

I don't have that.

> ... or I can establish a watcher that will automatically build a git
> tree when a branch on a git tree changes:
> 
> gce-xfstests ltm -c ext4/4k -g auto --repo next.git --watch master

Nor this, neat.

> Granted, this only works on GCE --- but feel free to take these ideas
> and integrate them into kdevops if you feel inspired to do so.  :-)

Thanks, will do. As you probably know by now each of these definitely
takes a lot of time. Right now I a few other objectives on my goal list
but I will gladly welcome patches to enable such a thing!

> > There is the concept of results too and a possible way to share things..
> > but this is getting a bit off topic and I don't want to bore people more.
> 
> This would be worth chatting about, perhaps at LSF/MM.  xfstests

I'd like to just ask that to help folks who are not used to accepting
the fact that xfstests is actually used for *all filesystems* that we
just call it fstests. Calling it just xfstests confuses people. I recall
people realizing even at LSFMM that xfstests is used *widely* by
everyone to test other filesystems, and the issue I think is the name.

If we just refer to it as fstests folks will get it.

> already supports junit results files; we could convert it to TAP
> format,

Kunit went TAP.

I don't care what format we choose, so long as we all strive for one
thing. I'd be happy with TAP too

> but junit has more functionality, so perhaps the right
> approach is to have tools that can support both TAP and junit? 

Sure.. another lesson I learned:

if you just look for the test failure files *.bad... that will not
tell you all tests that fail. Likewise if you just look at junit it
also will not always tell you all the tests that fail. So kdevops looks
at both...

> What
> about some way to establish interchange of test artifacts?  i.e.,
> saving the kernel logs, and the generic/NNN.full and
> generic/NNN.out.bad files?

Yup, all great topics.

Then .. the expunge files, so to help us express a baseline and also
allows us to easily specify failures and bug URLs.  For instance I have:

https://github.com/mcgrof/kdevops/blob/master/workflows/fstests/expunges/opensuse-leap/15.3/xfs/unassigned/all.txt

And they look like:

generic/047 # bsc#1178756
generic/048 # bsc#1178756
generic/068 # bsc#1178756

And kernel.org bugzilla entries are with korg#1234 where 1234 would be
the bug ID.

> I have a large library of these test results and test artifacts, and
> perhaps others would find it useful if we had a way sharing test
> results between developers, especially we have multiple test
> infrastructures that might be running ext4, f2fs, and xfs tests?

Yes yes and yes. I've been dreaming up of perhaps a ledger.

  Luis
