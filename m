Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55C3206F29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 10:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgFXIpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 04:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgFXIpP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:45:15 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34693C061573
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 01:45:15 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q19so1692515lji.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BqaLUtl/X7a4g0u53ohS9LpEPRGxCSpsENOwnH2o2ws=;
        b=BaMR/TH7PhsFO1Q34q1x2qClsI7LOGwkyGbEQspz9ojX212XoSbqRRFRth4Meo/ssf
         2uSK2GFHyed2vxpCFS8nAdnPkaKfIeDec0YV9QxJi/0DZp4NUqctsee+ogS3Fl1BjDdr
         a660g7JU0oHL6NyFbXA5+GIkWejIuD89yS0M8Tc8lB+t0JgR/JNVCSHJf9uU9wrnuIDa
         47xkwZFkFxCVyhO1vbBzMyIe1gFadRmPD50scOKKWKTaSZrjIBowcWgIjP9XbV8XY1GP
         3JSamKeGQOntN1He/c6PG2bUnQGEpAvzaZq9ATvao350qg1CFz7ECK/Ha/Dx5Jbn102c
         XDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BqaLUtl/X7a4g0u53ohS9LpEPRGxCSpsENOwnH2o2ws=;
        b=dT12qihjz9ySqkNoM7MXp0G2iYgme/ToaN561nkcdOrycFcLp3CSBZvTO/PVyqJp1G
         hs7wp+KwhGVNeov9EzVgc/2Gz9p/jKre1UEnXvbblgmolTr5wonuiX4mr/RFjP/C0guR
         UZzEIbPg1QkEwmd5C84C72/og2Y1THCDRB2HrXlSUZ03EqTdIeLwucZkQAfbTf0V8OTI
         iY4MPBcrsGxLplJq2p+B7TwvSrxEEIPzNVD49vLYipWX5PwlW6V/xoH50gTmnEwYpyhY
         XXY3Txo4r0Bh+wKtBA+TZ+xbaRFBQxRdkh/tBtJl8JUGGnZNM1sFt4qsaNfpHWD+X8Sr
         6SJw==
X-Gm-Message-State: AOAM532t0m+XTAKjz2sAHOUYlaNuVxNW5PlcVMhB7XeJBl+23JlInSJE
        05wuKnrS1xquANn+Cc09LweIQwawo3dBa3JHimDvUw==
X-Google-Smtp-Source: ABdhPJxliTcfapcUjxrmriw5iNjCcnVllOZAHYWf8QkB0iGUvYcf1ODkhqeeAxo4eRsnXoHPY0AN5BRFBvz+CFJpz5M=
X-Received: by 2002:a2e:7f10:: with SMTP id a16mr13972228ljd.69.1592988313570;
 Wed, 24 Jun 2020 01:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com> <87v9k84knx.derkling@matbug.net>
 <20200603101022.GG3070@suse.de> <CAKfTPtAvMvPk5Ea2kaxXE8GzQ+Nc_PS+EKB1jAa03iJwQORSqA@mail.gmail.com>
 <20200603165200.v2ypeagziht7kxdw@e107158-lin.cambridge.arm.com>
 <CAKfTPtC6TvUL83VdWuGfbKm0CkXB85YQ5qkagK9aiDB8Hqrn_Q@mail.gmail.com>
 <20200608123102.6sdhdhit7lac5cfl@e107158-lin.cambridge.arm.com>
 <CAKfTPtCKS-2RoaMHhKGigjzc7dhXhx0z3dYNQLD3Q9aRC_tCnw@mail.gmail.com>
 <20200611102407.vhy3zjexrhorx753@e107158-lin.cambridge.arm.com>
 <CAKfTPtDnWuBOJxJP7ahX4Kzu+8jvPjAcE6XErMtG1SCJMdZZ-w@mail.gmail.com> <20200623154402.jfv5yhhrsbx7toes@e107158-lin.cambridge.arm.com>
In-Reply-To: <20200623154402.jfv5yhhrsbx7toes@e107158-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 24 Jun 2020 10:45:01 +0200
Message-ID: <CAKfTPtBfFkmBRP+6vZaX9sEK+4ABpJrp2qZj18LKzu2t+Q=gGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Qais,

On Tue, 23 Jun 2020 at 17:44, Qais Yousef <qais.yousef@arm.com> wrote:
>
> Hi Vincent
>
> On 06/11/20 14:01, Vincent Guittot wrote:
> > On Thu, 11 Jun 2020 at 12:24, Qais Yousef <qais.yousef@arm.com> wrote:
>
> [...]
>
> > > > Strange because I have been able to trace them.
> > >
> > > On your arm platform? I can certainly see them on x86.
> >
> > yes on my arm platform
>
> Sorry for not getting back to you earlier but I have tried several things and
> shared my results, which you were CCed into all of them.
>
> I have posted a patch that protects uclamp with a static key, mind trying it on
> your platform to see if it helps you too?

I have run some tests with your latest patchset and will reply to the
email thread below

>
> https://lore.kernel.org/lkml/20200619172011.5810-1-qais.yousef@arm.com/
>
> Thanks
>
> --
> Qais Yousef
