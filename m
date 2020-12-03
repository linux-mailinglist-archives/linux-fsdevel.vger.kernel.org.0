Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511C52CDCA9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 18:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbgLCRsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 12:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgLCRsE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:48:04 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E494C061A4F
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 09:47:24 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id 142so3451184ljj.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Dec 2020 09:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+/34BW6LzHF6hZqDfON22QZfOwULMcJz5mgoFc2n/kU=;
        b=MsWsYuKNvKACORS8E1s6T8larMX8mUsiP9GStx4+PH4R/8GKanJ7dmyxFt2sOejpvg
         lJYFBzL5o8xNmk+X0wFulbuSDXgwNrOaXIagjg37+KIoGO9/xwvWN9Ycq3yYVYbgnQ/Z
         53K8yeK7Vith5UFq1DQvSKASmjvGeDSn3t91g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+/34BW6LzHF6hZqDfON22QZfOwULMcJz5mgoFc2n/kU=;
        b=YQirOhIM0csuzOWXzWy4xLvvno7WIiw1d0qXQGBkWdT6sFAL/r3P1lJHbOrIG5Urnq
         A3BMpLvGRR/gim/q4AmWHQxUrOv3dOT60w/26c9qrQTwPgiqTYzpBgiHg93631kHvHgu
         u3M0BEzSub000GeX9u3l8PPyEVCY+lOuRHizxlbisv/0Qtl9p1j0YUXgARPBdj1ZycPI
         28CJd/uwB643C92TKT3KsUueRf9+zPV/2R/FZyE/T5GL774SGXy9fnGNjKvQPnPS/njX
         ynTSVNmFe8vy6fDioxNr0axXGEYot0B7ssowSNcs55GXUb+4/mRCmrheJEk7EPWxzKJJ
         AzRA==
X-Gm-Message-State: AOAM531WKGtpiirtWvik5uVRj5jBxnHrfIT2y74Bc80hNNpNC7nDGDAW
        NtsmtsEYGxCF1H3MtuLX8S1vmRxM3Zk6cA==
X-Google-Smtp-Source: ABdhPJwZvqk2qaEtNDMh84q2vpXZBxqU/uSi4j+RH2z/kjZQQI0zYqCMewPcq4i6n9WzU1ZlDety0Q==
X-Received: by 2002:a2e:7803:: with SMTP id t3mr1733819ljc.176.1607017642046;
        Thu, 03 Dec 2020 09:47:22 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id v22sm637307ljd.9.2020.12.03.09.47.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 09:47:21 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id l11so4004402lfg.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Dec 2020 09:47:20 -0800 (PST)
X-Received: by 2002:a19:f243:: with SMTP id d3mr1702463lfk.534.1607017640414;
 Thu, 03 Dec 2020 09:47:20 -0800 (PST)
MIME-Version: 1.0
References: <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
 <20201203064536.GE27350@xsang-OptiPlex-9020>
In-Reply-To: <20201203064536.GE27350@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Dec 2020 09:47:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wif1iGLiqcsx1YdLS4tN01JuH-MV_oem0duHqskhDTY9A@mail.gmail.com>
Message-ID: <CAHk-=wif1iGLiqcsx1YdLS4tN01JuH-MV_oem0duHqskhDTY9A@mail.gmail.com>
Subject: Re: [iov_iter] 9bd0e337c6: will-it-scale.per_process_ops -4.8% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     David Howells <dhowells@redhat.com>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com,
        Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 2, 2020 at 10:31 PM kernel test robot <oliver.sang@intel.com> w=
rote:
>
> FYI, we noticed a -4.8% regression of will-it-scale.per_process_ops due t=
o commit:

Ok, I guess that's bigger than expected, but the profile data does
show how bad the indirect branches are.

There's both a "direct" cost of them:

>       0.55 =C4=85 14%      +0.3        0.87 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.__x86_retpoline_rax
>       0.12 =C4=85 14%      +0.1        0.19 =C4=85 14%  perf-profile.self=
.cycles-pp.__x86_indirect_thunk_rax
>       0.43 =C4=85 14%      +0.3        0.68 =C4=85 15%  perf-profile.self=
.cycles-pp.__x86_retpoline_rax

The actual retpoline profile costs themselves do not add up to 4%, but
I think that's because the indirect costs are higher, because the
branch mis-predicts will basically make everything run slower for a
while as the OoO engine needs to restart.

So the global cost then shows up in CPU and branch miss stats, where
the IPC goes down (which is the same thing as saying that CPI goes
up):

>  1.741e+08           +42.3%  2.476e+08        perf-stat.i.branch-misses
>       0.74            -3.9%       0.71        perf-stat.overall.ipc
>       1.35            +4.1%       1.41        perf-stat.overall.cpi

which is why it ends up being so costly even if the retpoline overhead
itself is "only" just under 1%.

           Linus
