Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340F26E9CFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 22:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjDTUU7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 16:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjDTUU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:20:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049844EC2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 13:20:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-506bdf29712so6018409a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682022023; x=1684614023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gG2Ql85L6iDQ8KDJtvyVB1US8rf766mBBw7kP/giR5M=;
        b=QAXp3RObgIJpNM6iA+LUaWs2XmoxP0ETyPn/Hb7hsyUsoITvm+q1rB3PzE6Mw/ofni
         ULxOJ87mYAgAGSCd3rekbSsk8DyQtNXFtFQKX4c/KlTgtFoi+yknLHSR2BFFuZOSunKq
         vBK7hVVH0rH87rWoaKvGR/8SG3U1jq4nukkkvYzR31hv46lsUWafURYe+lWJOzKqHdYR
         ZAcEjfCDqzAYgzB/a6n/luU94tpPH/nhhW4mPeWcH3Mz/nBvuqPerlcHlTs5HgcrAnuP
         vOri0/ZN87/rTD24tM0uo61TQtf23tLNmshMmIQgAi6qQbai3wi9w5y14dyzB74qxq9+
         Oyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022023; x=1684614023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gG2Ql85L6iDQ8KDJtvyVB1US8rf766mBBw7kP/giR5M=;
        b=k9VZvB9v1uLyiea1M6OCSjjHAP+5ktPhiE6Vic/ulc6prFRoFgOsUhNBB52sJWpszy
         If335AvD8J9xXrmuXJmGbFd9XX0PLkcVhnEvCRV9+pUfGBXd7tbAs0tgm/KCymhQgdhp
         tOBX/RKVtWxiwYlRcL4kn33WrotpiwwSOdgQ4vs55XdY1G5cyDmhacnldUAxyaD7iM3J
         8Y4MXhWdnUAH6aSIOVmErsbsYoQAyndvsqGH73QZlQ8FyBnMpJ+LhOOYqMv5hZP4RIwR
         35zrHiNjHsdVopGRnJ47ZimymNZ9xRJcs1m0bI7C+aaH0vl0UA3d0wBSl5RKhYc/gbKg
         9cLw==
X-Gm-Message-State: AAQBX9cK+TCs9iPd75NQ8k72IRGxc4IVCncftR/01Kx8jZq+5kKqy5dz
        bRq8WCVPo/x4O0iaDeG7Adp/KdB8K2eaBkSmIzYCLw==
X-Google-Smtp-Source: AKy350Zqqjhf63hrvxZCBfDJ+G0AGIpxZ0fOO09uTH99ETeQpYhmD9A0SBuIcV8kXVY7fmQbcwTq+21dl2Cyg9I05mM=
X-Received: by 2002:a05:6402:4413:b0:4af:7bdc:188e with SMTP id
 y19-20020a056402441300b004af7bdc188emr6254738eda.16.1682022023268; Thu, 20
 Apr 2023 13:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com>
 <20230403220337.443510-6-yosryahmed@google.com> <CALvZod79Au=Fw9MTW7fP0P7KwQQ_NUiKgRHsNUFnv9v61pKnZA@mail.gmail.com>
 <ZEGXHvEPsfORq36_@slm.duckdns.org>
In-Reply-To: <ZEGXHvEPsfORq36_@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 20 Apr 2023 13:19:46 -0700
Message-ID: <CAJD7tkZkPsBi2RH2b2WXZn=Q+uQJY5-+-MaPnrrNfZcjXo+xhA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable RFC 5/5] cgroup: remove cgroup_rstat_flush_atomic()
To:     Tejun Heo <tj@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 20, 2023 at 12:48=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Thu, Apr 20, 2023 at 12:40:24PM -0700, Shakeel Butt wrote:
> > +Tejun
> >
> >
> > On Mon, Apr 3, 2023 at 3:03=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> > >
> > > Previous patches removed the only caller of cgroup_rstat_flush_atomic=
().
> > > Remove the function and simplify the code.
> >
> >
> > I would say let cgroup maintainers decide this and this patch can be
> > decoupled from the series.
>
> Looks fine to me but yeah please cc me on the whole series from the next
> round.


Thanks for taking a look, I don't know how I missed CC'ing you on this
RFC. If I have to guess, my initial draft did not have this patch, so
I did not include you or linux-cgroups, then I added this patch. Sorry
for that :)

>
>
> Thanks.
>
> --
> tejun
