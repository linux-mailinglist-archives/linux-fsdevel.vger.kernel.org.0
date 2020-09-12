Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81F2267A42
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 14:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgILM0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 08:26:09 -0400
Received: from mout.gmx.net ([212.227.15.18]:42351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgILM0G (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 08:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599913491;
        bh=cyVUZti2CjaYGbyBo+/FrS/YkqKumirWsJ3OYoBuVZI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ZF95JOjXqYx9AJ4KoGxnCuPu4JILIy6LlDlprJhWoKsV5P+mPqEGRqg+wJIjEejsw
         Q23P6kPYr7DdcYSETv+a/wnV+8T1ZOtRsNI+iLkqjvEc/gmp6DG5pUr0JC8KJDmVap
         GwqE9oZbuM4YF9Xq05Zt3HIcMfDEwSnmQwPSNen8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M4JmN-1kHLhT3ay1-000OAT; Sat, 12
 Sep 2020 14:24:51 +0200
Date:   Sat, 12 Sep 2020 14:24:34 +0200
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, John Wood <john.wood@gmx.com>,
        Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RESEND][RFC PATCH 0/6] Fork brute force attack mitigation
 (fbfam)
Message-ID: <20200912101606.GB3041@ubuntu>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <202009101656.FB68C6A@keescook>
 <20200911144806.GA4128@ubuntu>
 <202009120053.9FB7F2A7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009120053.9FB7F2A7@keescook>
X-Provags-ID: V03:K1:npjZWnUf5TOz3ACicrJqbfTigA7qrI003qPlqypDTuPvgm+95jg
 YVCSKfru8/GIlF7z/GnQmjEwFn18T6mdKX+7Kq1cdpggQuT8QQGQLlWl8cizXN0QO2ImlWp
 lsK9Lh4rxK295qEcLuudCA1FoiK4uAHqvuFPFA7mxK0UwS7n2iKXVTejRXkMrPzz0a/DPWg
 jB7cnY0DAPVNYPNGHmFYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kM4SSDt4uQQ=:nBe8EQ3ju1FY8S52B8tufT
 SLY/PdHmHsxOukdrVgPSqeUShbvq8DRdaERY8a4NT7BpQbtnkpjbWU8mo5y3io4UUxNY5XDgV
 YF3rKRRa3nfY/9g2WJYT7q3RPCMFI3fhFX4ad4+G1FxWPS6DoX3KVs6LU304crJkil2dmNYge
 wHzqP25Rpct/MdgYTOgMQt64xxRTBJIJzDdUzqInPM0Z4hVmcFLBlpVkQ08bF3OwDRpa3ucZL
 AZRMq6H2xyNVZZGS8m8PgCF8u7Kp/NWRo7zpkuUUVSrrgUs4banrntqpog0lPiHGXE6LsHgSm
 Z014RPcLlPr+AjXK4OfqArHi4v7VNrQKVRnnTsgaf3J4YydkwR/i5XFwtxaWQbm/PGxl8jeSB
 jh2/gu1pqh7+R+H5nYuwBaPZJVvkfj7y4D6mmAcV/KvPWXpe4n3eF8Yc4YNy+lSDJw4VfUU/B
 qz9lu5WkxMFF+8Mj2zruobOloJSPBc4BDiiZNiNSngXqRypXFHXRg/YP4nJO9JLeqbSRzxI7J
 EVvwGkw3/FatpigE9YkQ8hm0727NIzsEyfvkutchG3zl2mzvbHTwfBwK0A1yY8Ur1SxCBPRzQ
 BDI0TGsbfxP7I5AmNHoI6rBWXeqJLgqGQAtp+eddcuv4qetkHTDwMx43p/aLbxbpgZXNx6Khi
 54Cy4wdMPX39chpt5nfh8jUxvmQu8VrBHnwwcaaS7IfmI+s5Xos3wDflrcSXjT3QxQmrfG0TN
 WdfMoJzXjFRn1k5xT96TDaZJ7OAI+/qUU+flkaTwUTMhDV9zztY8AnDq0As7D/rHs7ESVCUHZ
 hqpVkSzCOw17QSfHkPfGsDrxCShjzmuiyIzsgV8E1L/NbjldC5dKLdYMWRLne/c5dR1j0mrEB
 hTNXegbDyXLRcD5SiZ4tiPdySnPyfZYiaMQjVcqWQfsqj+qt69MEOoXWlHhorhaLQHdsh430d
 VmlLwcS5iDjeTkkDUizHhpsop+jxk2tqUbBsqnWfYSQ9OxH+XACFINzDlziIs/f7zTnYRHHLO
 03gMAODv5GF0vse0mOEI6uz1gfg84DmE6LlEPboPsPxypFBz8aWIpIXFzS7y80YjaGpb4IPEA
 i06V9hcC4dvueYqa6iR/bWftKb8j/m//xqw8W5VzG2XTBfayHF1AI9W5dHUnd/0NzUzITJwMb
 cFlL20/KWViropiQ8VZwCFU2q2dtJF0KJOQg0o2sdp3sisfv+DYnuoyXzfAA1s13Hy/WKV8B6
 6AajfiVfu9W8SL12enciU8YYeeZ33/JLgLu8XaA==
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 12, 2020 at 12:55:03AM -0700, Kees Cook wrote:
> On Fri, Sep 11, 2020 at 04:48:06PM +0200, John Wood wrote:
> > My original patch serie is composed of 9 patches, so the 3 lasts are l=
ost.
> > Kees: Have you removed them for some reason? Can you send them for rev=
iew?
> >
> > security/fbfam: Add two new prctls to enable and disable the fbfam fea=
ture
> > https://github.com/johwood/linux/commit/8a36399847213e7eb7b45b853568a5=
3666bd0083
> >
> > Documentation/security: Add documentation for the fbfam feature
> > https://github.com/johwood/linux/commit/fb46804541f5c0915f3f48acefbe6d=
c998815609
> >
> > MAINTAINERS: Add a new entry for the fbfam feature
> > https://github.com/johwood/linux/commit/4303bc8935334136c6ef47b5e50b87=
cd2c472c1f
>
> Oh, hm, I'm not sure where they went. I think they were missing from my
> inbox when I saved your series from email. An oversight on my part;
> apologies!

I sent the full serie to Matthew Wilcox <willy@infradead.org> only, as he
wanted to help re-sending the full serie. Then I saw that only 6 patches
appeared in the linux-doc mailing list.

I can try to send the three pending patches in different stages (for examp=
le
one patch every 4 or 5 hours) to avoid blocking my email. I hope. Or I can
send the three pending patches only to the kernel-hardening mailing list
and you re-send to all the people involved. Or any other solution you
propose. It's up to you.

> > Is there a problem if I ask for some guidance (replying to this thread=
)
> > during the process to do my second patch series?
>
> Please feel free! I'm happy to help. :)

It's a pleasure working with you. Thanks a lot.

> --
> Kees Cook

Regards,
John Wood
