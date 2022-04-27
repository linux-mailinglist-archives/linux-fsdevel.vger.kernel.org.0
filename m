Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3CC512225
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 21:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiD0TKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 15:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiD0TKY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:10:24 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04152783AF
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 11:59:05 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id b17so1699415qvf.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wHOyhzQktuJeCmvwWjftPQsSsOlt4BXlADA5QK6cyn4=;
        b=k1qML+sxrm95156WSt9WSBOpx6+mTKFtOQi4nGVQI4QRw40UCsnptGGy/M6SI7rz29
         U79bHm6mcA4AhTnC5WHZRx7hIacLjQiTeMxoiPj8jLBBso7yxJfh45xUHjn8FbsGzhyn
         ijroBL2eVTw3EX9w/lfHC77jM8etbh4lSEy3iZ8oBs9ac8qx+Eg37LEkvzTG8Zq+d9ka
         p22lZZ6WET0UVys9n62RmF7Vyatvn/lUJ2vn0Lyi/Hc7RJFPeDAS+qM7k2uGi36fWS43
         n3im94JWaaOFr96F245s3oFs+uWq/WeBxqcqIS3/nidiwteN5UqGta7dgCjtUOvs/W4O
         dwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wHOyhzQktuJeCmvwWjftPQsSsOlt4BXlADA5QK6cyn4=;
        b=uVOrM2TG8PHdKHl6+MXHOjhV/oCkBpDqywC3O+a5Y60mgbVM87d1XmTZoT1tUV0DlW
         HK3c5Pff7hzhykkwpBg8hIVlemsCDBvifYome8tWfFVh8xhE3kxBkBRNqP3elyjmd4yj
         /FyDRUTWUjL8jNqxcXUUo4lMsX4swFHUxuCJrT9N+joYC+R9ipGUI2xC18MTPcpYSBB6
         3PnmrCfoKEpMsfvK8CcW7PmDhIJFWYey/Ux1il8HRdkKVV5nvtOyK3R1ZRD39auEsVZG
         W7g+r06RDBCr4Ej9dRENqpauvz1lvRy/w068Xw5xvJPQvKPwWczLcx6VwHJwrB8YpQ/4
         DNiw==
X-Gm-Message-State: AOAM5338s801TGjwimgu2rSvXiCtVMUBeukXPfsV+gAxGO2l50ENXV6p
        I4y5rDwRh/xzBg3vWduNvGuewwnyDkQMFytzh14=
X-Google-Smtp-Source: ABdhPJyheLar29wCuvcMCic6aOE76qkhw1mAsLCB/DQStwgAIYnaHBHUcWkKUk/j4MeqT4z91XbjHO63wkEmdazjnsQ=
X-Received: by 2002:a05:6214:e4b:b0:456:5325:5b06 with SMTP id
 o11-20020a0562140e4b00b0045653255b06mr2239632qvc.77.1651085944826; Wed, 27
 Apr 2022 11:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190212170012.GF69686@sasha-vm> <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com> <CAOQ4uxjjdFgdMxEOq7aW-nLZFf-S99CC93Ycg1CcMUBiRAYTQQ@mail.gmail.com>
 <YiepUS/bDKTNA5El@sashalap> <Yij4lD19KGloWPJw@bombadil.infradead.org>
 <Yirc69JyH5N/pXKJ@mit.edu> <Yiu2mRwguHhbVpLJ@bombadil.infradead.org> <YivHdetTMVW260df@mit.edu>
In-Reply-To: <YivHdetTMVW260df@mit.edu>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Apr 2022 21:58:53 +0300
Message-ID: <CAOQ4uxg+5XUxD19Zh_WoTjVc+yU-mjjCrgWN+85=oZe=pSKO2Q@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 12, 2022 at 12:04 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
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
> fatal: [localhost]: FAILED! =3D> {"changed": true, "cmd": ["/usr/sbin/app=
armor_status", "--enabled"], "delta": "0:00:00.001426", "end": "2022-03-11 =
16:23:11.769658", "failed_when_result": true, "rc": 0, "start": "2022-03-11=
 16:23:11.768232", "stderr": "", "stderr_lines": [], "stdout": "", "stdout_=
lines": []}
>
> (I do have apparmor installed, but it's currently not enabled.  I
> haven't done more experimentation since I'm a bit scared of running
> "make XXX" as root for any package I randomly download from the net,
> so I haven't explored trying to use kdevops, at least not until I set
> up a sandboxed VM.  :-)
>
> Including the Debian package names that should be installed would also
> be helpful in kdevops/doc/requirements.md.  That's not a problem for
> the experienced Debian developer, but one of my personal goals for
> kvm-xfstests and gce-xfstests is to allow a random graduate student
> who has presented some research file system like Betrfs at the Usenix
> FAST conference to be able to easily run fstests.  And it sounds like
> you have similar goals of "enabling the average user to also easily
> run tests".
>
>
> > but I never found one
> > as easy to use as compiling the kernel and running a few make commands.
>
> I've actually done a lot of work to optimize developer velocity using
> my test framework.  So for example:
>
> kvm-xfstests install-kconfig    # set up a kernel Kconfig suitable for kv=
m-xfstests and gce-xfstests
> make
> kvm-xfstests smoke     # boot the test appliance VM, using the kernel tha=
t was just built
>
> And a user can test a particular stable kernel using a single command
> line (this will checkout a particular kernel, and build it on a build
> VM, and then launch tests in parallel on a dozen or so VM's):
>
> gce-xfstests ltm -c ext4/all -g auto --repo stable.git --commit v5.15.28
>
> ... or if we want to bisect a particular test failure, we might do
> something like this:
>
> gce-xfstests ltm -c ext4 generic/361 --bisect-good v5.15 --bisect-bad v5.=
16
>
> ... or I can establish a watcher that will automatically build a git
> tree when a branch on a git tree changes:
>
> gce-xfstests ltm -c ext4/4k -g auto --repo next.git --watch master
>
> Granted, this only works on GCE --- but feel free to take these ideas
> and integrate them into kdevops if you feel inspired to do so.  :-)
>
> > There is the concept of results too and a possible way to share things.=
.
> > but this is getting a bit off topic and I don't want to bore people mor=
e.
>
> This would be worth chatting about, perhaps at LSF/MM.  xfstests
> already supports junit results files; we could convert it to TAP
> format, but junit has more functionality, so perhaps the right
> approach is to have tools that can support both TAP and junit?  What
> about some way to establish interchange of test artifacts?  i.e.,
> saving the kernel logs, and the generic/NNN.full and
> generic/NNN.out.bad files?
>
> I have a large library of these test results and test artifacts, and
> perhaps others would find it useful if we had a way sharing test
> results between developers, especially we have multiple test
> infrastructures that might be running ext4, f2fs, and xfs tests?
>

Hi Ted,

I penciled a session on "Challenges with running fstests" in the
agenda.

I was hoping that you and Luis could co-lead this session and
present the progress both of you made with your test frameworks.

Thanks,
Amir.
