Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FF2759FF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 22:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjGSUiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 16:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGSUiJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:38:09 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1432684
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 13:37:45 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1b05d63080cso45707fac.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 13:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689799065; x=1692391065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yalhP6R+1z0UDsb9+7HJFdN5dchw61s0+06SJ8cM6k=;
        b=KuRKkiicFarGSCBqnr3LP7ne8/CcZXp61/wOUdOrRxindvG65FMP54jxAQljSUmMRu
         0ImZCsR+QPc+umybUE+Ax3vYzbRHxuZ4QhZLWo1MjdmFKXWanAOl3Foy+M/ZSaMSlJ8C
         sXf0djcu0QzTJcW9L78VBSTXlbebdDb3RiQqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689799065; x=1692391065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yalhP6R+1z0UDsb9+7HJFdN5dchw61s0+06SJ8cM6k=;
        b=hNUebrjDGWLzgNPmiuhI5/T+iPXSb3UG1Cz2rpG6/HDgYLBJdM+rkZ8QJIE3x2Z2fp
         yOdg7wud9jw0ZSFBDpPsqro9AebIuWIeWzEnYJBMUsqOFs0Lg+ihWetmoIuJ2+5GmNmy
         AgAs0R2xnudWEHChyqN4+tlJyfIxPccLYT+RRq9RsPzIjIPDYBAcjkuQbil39HKea5Uk
         6xadH5lAnenad5cc5lCI3We5l9YYw8wb4kqXkN8r0fHasQcHVC4WaPnRotl9TvLrnLWQ
         U/ojjFhrGosvlLjvEOS4SiKLt6j6YZcsHnGw1xU6SB6LPY3hxg8s+Atkfykt4l5iusac
         9rSw==
X-Gm-Message-State: ABy/qLaamKXs9IhA0lRGn/97z4gqb/M9l9UwLPkOPcfMMSXeyWkQEVtn
        Fi2vvP2pJLLWEQmuskOqPamXjUMDkPa2mBWE/jar4A==
X-Google-Smtp-Source: APBJJlEajt4aVc6CuRc8TCx+yM+UYYfOrW0NRG2NsLH3+frhp/KMJRs6pc+HGpPbRnF5/LFCbQ1GEjdPFY+oFOOshCk=
X-Received: by 2002:a05:6808:1441:b0:3a4:1319:9af1 with SMTP id
 x1-20020a056808144100b003a413199af1mr24407262oiv.51.1689799064974; Wed, 19
 Jul 2023 13:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <CA+wXwBRdcjHW2zxDABdFU3c26mc1u+g6iWG7HrXJRL7Po3Qp0w@mail.gmail.com>
 <ZJ2yeJR5TB4AyQIn@casper.infradead.org> <20230629181408.GM11467@frogsfrogsfrogs>
 <CALrw=nFwbp06M7LB_Z0eFVPe29uFFUxAhKQ841GSDMtjP-JdXA@mail.gmail.com>
 <CAOQ4uxiD6a9GmKwagRpUWBPRWCczB52Tsu5m6_igDzTQSLcs0w@mail.gmail.com>
 <CALrw=nHH2u=+utzy8NfP6+fM6kOgtW0hdUHwK9-BWdYq+t-UoA@mail.gmail.com>
 <CAOQ4uxju10zrQhVDA5WS+vTSbuW17vOD6EGBBJUmZg8c95vsrA@mail.gmail.com> <20230630151657.GJ11441@frogsfrogsfrogs>
In-Reply-To: <20230630151657.GJ11441@frogsfrogsfrogs>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Wed, 19 Jul 2023 21:37:33 +0100
Message-ID: <CALrw=nFv82aODZ0URzknqnZavyjCxV1vKOP9oYijfSdyaYEQ3g@mail.gmail.com>
Subject: Re: Backporting of series xfs/iomap: fix data corruption due to stale
 cached iomap
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Daniel Dao <dqminh@cloudflare.com>,
        Dave Chinner <david@fromorbit.com>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-fsdevel@vger.kernel.org,
        Chandan Babu R <chandanrlinux@gmail.com>,
        Leah Rumancik <lrumancik@google.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Fred Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 30, 2023 at 4:17=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Fri, Jun 30, 2023 at 04:05:36PM +0300, Amir Goldstein wrote:
> > On Fri, Jun 30, 2023 at 3:30=E2=80=AFPM Ignat Korchagin <ignat@cloudfla=
re.com> wrote:
> > >
> > > On Fri, Jun 30, 2023 at 11:39=E2=80=AFAM Amir Goldstein <amir73il@gma=
il.com> wrote:
> > > >
> > > > On Thu, Jun 29, 2023 at 10:31=E2=80=AFPM Ignat Korchagin <ignat@clo=
udflare.com> wrote:
> > > > >
> > > > > On Thu, Jun 29, 2023 at 7:14=E2=80=AFPM Darrick J. Wong <djwong@k=
ernel.org> wrote:
> > > > > >
> > > > > > [add the xfs lts maintainers]
> > > > > >
> > > > > > On Thu, Jun 29, 2023 at 05:34:00PM +0100, Matthew Wilcox wrote:
> > > > > > > On Thu, Jun 29, 2023 at 05:09:41PM +0100, Daniel Dao wrote:
> > > > > > > > Hi Dave and Derrick,
> > > > > > > >
> > > > > > > > We are tracking down some corruptions on xfs for our rocksd=
b workload,
> > > > > > > > running on kernel 6.1.25. The corruptions were
> > > > > > > > detected by rocksdb block checksum. The workload seems to s=
hare some
> > > > > > > > similarities
> > > > > > > > with the multi-threaded write workload described in
> > > > > > > > https://lore.kernel.org/linux-fsdevel/20221129001632.GX3600=
936@dread.disaster.area/
> > > > > > > >
> > > > > > > > Can we backport the patch series to stable since it seemed =
to fix data
> > > > > > > > corruptions ?
> > > > > > >
> > > > > > > For clarity, are you asking for permission or advice about do=
ing this
> > > > > > > yourself, or are you asking somebody else to do the backport =
for you?
> > > > > >
> > > > > > Nobody's officially committed to backporting and testing patche=
s for
> > > > > > 6.1; are you (Cloudflare) volunteering?
> > > > >
> > > > > Yes, we have applied them on top of 6.1.36, will be gradually
> > > > > releasing to our servers and will report back if we see the issue=
s go
> > > > > away
> > > > >
> > > >
> > > > Getting feedback back from Cloudflare production servers is awesome
> > > > but it's not enough.
> > > >
> > > > The standard for getting xfs LTS backports approved is:
> > > > 1. Test the backports against regressions with several rounds of fs=
tests
> > > >     check -g auto on selected xfs configurations [1]
> > > > 2. Post the backport series to xfs list and get an ACK from upstrea=
m
> > > >     xfs maintainers
> > > >
> > > > We have volunteers doing this work for 5.4.y, 5.10.y and 5.15.y.
> > > > We do not yet have a volunteer to do that work for 6.1.y.
> > > >
> > > > The question is whether you (or your team) are volunteering to
> > > > do that work for 6.1.y xfs backports to help share the load?

Circling back on this. So far it seems that the patchset in question
does fix the issues of rocksdb corruption as we haven't seen them for
some time on our test group. We're happy to dedicate some efforts now
to get them officially backported to 6.1 according to the process. We
did try basic things with kdevops and would like to learn more. Fred
(cc-ed here) is happy to drive the effort and be the primary contact
on this. Could you, please, guide us/him on the process?

> > > We are not a big team and apart from other internal project work our
> > > efforts are focused on fixing this issue in production, because it
> > > affects many teams and workloads. If we confirm that these patches fi=
x
> > > the issue in production, we will definitely consider dedicating some
> > > work to ensure they are officially backported. But if not - we would
> > > be required to search for a fix first before we can commit to any
> > > work.
> > >
> > > So, IOW - can we come back to you a bit later on this after we get th=
e
> > > feedback from production?
> > >
> >
> > Of course.
> > The volunteering question for 6.1.y is independent.
> >
> > When you decide that you have a series of backports
> > that proves to fix a real bug in production,
> > a way to test the series will be worked out.
>
> /me notes that xfs/558 and xfs/559 (in fstests) are the functional tests
> for these patches that you're backporting; it would be useful to have a
> third party (i.e. not just the reporter and the author) confirm that the
> two fstests pass when real workloads are fixed.
>
> --D
>
> > Thanks,
> > Amir.

Ignat
