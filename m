Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE08486AAB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 20:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243469AbiAFTtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 14:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243464AbiAFTtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 14:49:46 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB3FC061245
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jan 2022 11:49:46 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id e202so10567770ybf.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jan 2022 11:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WbhQRKPGAPIggyJ9g0z3APWYzIh00WCb+c/Ib6TJvS0=;
        b=sDxbFfhK1nEmkRcTPx63AQ977Nu23761bQrToW1bQHcWatqJH7SfH878mibQ9GMd7V
         CCyl2heLhLtiEnasD2XmAJpX8ca9VlqIlksG7LkCNihEB4k2kSn61zG601UvBTzOM/kK
         Ued+kUloR25hJeZCRSZhc2aF546992zyUQLvWtZJhFPa2owFdlUpBJyZs5U4hSEYvxua
         QX40oSECEmvH+d5pu3CzKkS+Aa/OjpwKMFxwyIpwsSRCwcQ5RQS9biF0g08QbHYssAvq
         NWJavuW3WlE6cbFHgTK/QkHxbG9KCszCEfTJrlBpJ4o2VJETyN3TrY/LGQ6gE2AKvNv3
         g+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WbhQRKPGAPIggyJ9g0z3APWYzIh00WCb+c/Ib6TJvS0=;
        b=ej9T7FGKnHSnRBdx+G6tJYFDNiv6OzAv9J2Zus6Cv4+lcE9+/2+wcSA7CtyX5H0A68
         gLzWUmJOC3tSiAreaT3sXv9A4g7k62TzME7piEkXyars4Ow5VmbWAAxl1WDgpQ5Mk4Xw
         jCVVF5difX+hyBLt0Xc8MhbX39lqnOy524T5vCtvGIZD3Fi9CmEbK13BhvY/xlOV9H3+
         //LH/9fHyCVTYQ8JTarQADljQyZUNn3/xCwtg/VJ5BdPJnvaD8xUHVYynmRnpXVmescI
         fv8Lb/GmOL6K+PoDPINXDjsjmQqmvGJi80hhvedioCB7Sk79je8c9ugjhstH5ioamz2K
         2v6w==
X-Gm-Message-State: AOAM5335J6IXLJAcxnq6OGkZl1pUGfxS8vfWO8cTVoo++B2pg87+HpH8
        rbn8GHMQwndYP+J/BnCSHdpLj/fUQ6fqhS6zBaVpHA==
X-Google-Smtp-Source: ABdhPJzhLhBTrEscfrMN5lRJwFkPPO7E04w4k35eQVF99NqhWbVBKh8uSp+2s1JWppRIKs1+fNz0nXBVpSOTS1jwJD0=
X-Received: by 2002:a25:ef50:: with SMTP id w16mr2171464ybm.192.1641498585390;
 Thu, 06 Jan 2022 11:49:45 -0800 (PST)
MIME-Version: 1.0
References: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1640262603-19339-2-git-send-email-CruzZhao@linux.alibaba.com>
 <CABk29NvPJ3S1xq5xm+52OoUGDyuMSxGOLJbopPa3+-QmLnVYeQ@mail.gmail.com>
 <b02204ea-0683-2879-5843-4cfb31d44d27@linux.alibaba.com> <CABk29Nts4sysjmRcnZ_DWmMzhUrianp55Zgf-Nod8m+aUKiWeA@mail.gmail.com>
 <b7b06597-b3f1-677d-863b-e6cbf6664389@linux.alibaba.com>
In-Reply-To: <b7b06597-b3f1-677d-863b-e6cbf6664389@linux.alibaba.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 6 Jan 2022 11:49:34 -0800
Message-ID: <CABk29Nv9TmfP8oN=bm_2rNvK32AVAZ4TjsGZCQUGQ8ZhgdM4kA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/core: Cookied forceidle accounting per cpu
To:     cruzzhao <cruzzhao@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 6, 2022 at 4:10 AM cruzzhao <cruzzhao@linux.alibaba.com> wrote:
>
> >
> > That motivation makes more sense to me. Have you considered
> > accumulating this at the cgroup level (ie. attributing it as another
> > type of usage)?
>
> I've already read the patch "sched: CGroup tagging interface for core
> scheduling", but it hasn't been merged into linux-next. IMO it's better
> to do this at the cgroup level after the cgroup tagging interface is
> introduced.
>
> Best,
> Cruz Zhao

There are no plans to introduce cgroup-level tagging for core sched.
But the accounting is a separate issue. Similar to how tasks account
usage both to themselves and to their cgroup hierarchy, we could
account forced idle in a similar way, and add another field to
cpu_extra_stat_show. That still gives you the total system forced idle
time by looking at the root cgroup, and allows you to slice the
accounting by different job groups. It also makes the accounting a
single value per cgroup rather than a per-cpu value (I still don't see
the value of attributing to specific cpus, as I described in my prior
reply).
