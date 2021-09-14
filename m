Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AAD40A3D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 04:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbhINCvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 22:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbhINCvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:51:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664EEC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Sep 2021 19:49:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t19so25402273ejr.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Sep 2021 19:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aejjrEwv9A+FPcsJO+PLrw1/sXo77HGUim4vKB8A0UY=;
        b=f+aGIr1i9uDO9K2p3Pu+ECfDcPuuEdkom0IueHSLkWgzWN/4++KG2va0YU7i7xb/FZ
         2n3dbwoLE/H7PPFkICccW4GZ/JxkPhxPAxwMVN6IdDd69JL6GG8xtXbPuqd4ECfZvhdK
         fGUqXN5q7SL0XuYkOR8oG6P96kfn71E3YSeYGAyRRjOr/PIPEQMoNmEBTRjHTers9coM
         +7RYZ17mTqOyIG5y8IefVcKuuqCmrmzybehWchOYiBH3rAum9ISaZ7jEGI2pm14upzp4
         y+O2tuYuEnUvkXcqHO1qbkVdAqhncNExwskSLHJ9QmQVRJ1SlV3cYLjXsgAkCdT8AYqO
         LdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aejjrEwv9A+FPcsJO+PLrw1/sXo77HGUim4vKB8A0UY=;
        b=unDteD3UTBHBJkOhEQAOITecNlfFct0V4GTSlu9qTlxFR8epuBtlcXHxvsY5Nf4qnT
         ABSY+yYL/+M/9NHbhuIBdcVILwLDywYBpWaANt+XCMj1x0XonjVZ0+Sg4w7LiQh1znod
         VQLgCGnsj2FNE8p1cwli4kOdq1QoOV29CxGH8abT9k5qurD/RuRnHSnqnBy08hRoZZsv
         4KrgvuIzQ6vUNFrSdkXXoVQ3szao+lreTBrtGHOhNd440FJW2ds3H3PcTK9T8mk7kyHX
         zRDJ2eqZu/z9HNKN2cOyOVqhoQbu6TjUDcdUNKaXrG3XyLIGSrqq9TBMPdn5meUKe9OH
         YXhg==
X-Gm-Message-State: AOAM530VnVBTXX8SddLqXpTPRRryBAMLEzn1nW1lTV51YUaDvfCpQ3rE
        6vj0U8AIacXE++ziA5OTKRQTTSnub8ZlyxAbfjur
X-Google-Smtp-Source: ABdhPJzGREiUiVKzvVPxM9sqNoXunURxF1kR0zzzJ//z122o5jvF5bA9S3XPoctVm87ri6rJSWdH2ONVnszgf1oYmh0=
X-Received: by 2002:a17:906:6011:: with SMTP id o17mr15793102ejj.157.1631587791643;
 Mon, 13 Sep 2021 19:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210824205724.GB490529@madcap2.tricolour.ca> <20210826011639.GE490529@madcap2.tricolour.ca>
 <CAHC9VhSADQsudmD52hP8GQWWR4+=sJ7mvNkh9xDXuahS+iERVA@mail.gmail.com>
 <20210826163230.GF490529@madcap2.tricolour.ca> <CAHC9VhTkZ-tUdrFjhc2k1supzW1QJpY-15pf08mw6=ynU9yY5g@mail.gmail.com>
 <20210827133559.GG490529@madcap2.tricolour.ca> <CAHC9VhRqSO6+MVX+LYBWHqwzd3QYgbSz3Gd8E756J0QNEmmHdQ@mail.gmail.com>
 <20210828150356.GH490529@madcap2.tricolour.ca> <CAHC9VhRgc_Fhi4c6L__butuW7cmSFJxTMxb+BBn6P-8Yt0ck_w@mail.gmail.com>
 <CAHC9VhQD8hKekqosjGgWPxZFqS=EFy-_kQL5zAo1sg0MU=6n5A@mail.gmail.com>
 <20210910005858.GL490529@madcap2.tricolour.ca> <CAHC9VhSRJYW7oRq6iLCH_UYukeFfE0pEJ_wBLdr1mw2QGUPh-Q@mail.gmail.com>
 <CAHC9VhTrimTds_miuyRhhHjoG_Fhmk2vH7G3hKeeFWO3BdLpKw@mail.gmail.com>
In-Reply-To: <CAHC9VhTrimTds_miuyRhhHjoG_Fhmk2vH7G3hKeeFWO3BdLpKw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Sep 2021 22:49:40 -0400
Message-ID: <CAHC9VhTUKsijBVV-a3eHajYyOFYLQPWTTqxJ812NnB3_Y=UMeQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/9] Add LSM access controls and auditing to io_uring
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     sgrubb@redhat.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-audit@redhat.com,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13, 2021 at 9:50 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Sep 13, 2021 at 3:23 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Sep 9, 2021 at 8:59 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2021-09-01 15:21, Paul Moore wrote:
> > > > On Sun, Aug 29, 2021 at 11:18 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > > On Sat, Aug 28, 2021 at 11:04 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > > I did set a syscall filter for
> > > > > >         -a exit,always -F arch=b64 -S io_uring_enter,io_uring_setup,io_uring_register -F key=iouringsyscall
> > > > > > and that yielded some records with a couple of orphans that surprised me
> > > > > > a bit.
> > > > >
> > > > > Without looking too closely at the log you sent, you can expect URING
> > > > > records without an associated SYSCALL record when the uring op is
> > > > > being processed in the io-wq or sqpoll context.  In the io-wq case the
> > > > > processing is happening after the thread finished the syscall but
> > > > > before the execution context returns to userspace and in the case of
> > > > > sqpoll the processing is handled by a separate kernel thread with no
> > > > > association to a process thread.
> > > >
> > > > I spent some time this morning/afternoon playing with the io_uring
> > > > audit filtering capability and with your audit userspace
> > > > ghau-iouring-filtering.v1.0 branch it appears to work correctly.  Yes,
> > > > the userspace tooling isn't quite 100% yet (e.g. `auditctl -l` doesn't
> > > > map the io_uring ops correctly), but I know you mentioned you have a
> > > > number of fixes/improvements still as a work-in-progress there so I'm
> > > > not too concerned.  The important part is that the kernel pieces look
> > > > to be working correctly.
> > >
> > > Ok, I have squashed and pushed the audit userspace support for iouring:
> > >         https://github.com/rgbriggs/audit-userspace/commit/e8bd8d2ea8adcaa758024cb9b8fa93895ae35eea
> > >         https://github.com/linux-audit/audit-userspace/compare/master...rgbriggs:ghak-iouring-filtering.v2.1
> > > There are test rpms for f35 here:
> > >         http://people.redhat.com/~rbriggs/ghak-iouring/git-e8bd8d2-fc35/
> > >
> > > userspace v2 changelog:
> > > - check for watch before adding perm
> > > - update manpage to include filesystem filter
> > > - update support for the uring filter list: doc, -U op, op names
> > > - add support for the AUDIT_URINGOP record type
> > > - add uringop support to ausearch
> > > - add uringop support to aureport
> > > - lots of bug fixes
> > >
> > > "auditctl -a uring,always -S ..." will now throw an error and require
> > > "-U" instead.
> >
> > Thanks Richard.
> >
> > FYI, I rebased the io_uring/LSM/audit patchset on top of v5.15-rc1
> > today and tested both with your v1.0 and with your v2.1 branch and the
> > various combinations seemed to work just fine (of course the v2.1
> > userspace branch was more polished, less warts, etc.).  I'm going to
> > go over the patch set one more time to make sure everything is still
> > looking good, write up an updated cover letter, and post a v3 revision
> > later tonight with the hope of merging it into -next later this week.
>
> Best laid plans of mice and men ...
>
> It turns out the LSM hook macros are full of warnings-now-errors that
> should likely be resolved before sending anything LSM related to
> Linus.  I'll post v3 once I fix this, which may not be until tomorrow.
>
> (To be clear, the warnings/errors aren't new to this patchset, I'm
> likely just the first person to notice them.)

Actually, scratch that ... I'm thinking that might just be an oddity
of the Intel 0day test robot building for the xtensa arch.  I'll post
the v3 patchset tonight.

-- 
paul moore
www.paul-moore.com
