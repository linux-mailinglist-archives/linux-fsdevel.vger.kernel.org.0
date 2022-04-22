Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4385050C2FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 01:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiDVWfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 18:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiDVWfN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:35:13 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FC12CC18C
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 14:27:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d15so13527134pll.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9AKK/wGlnxig+lE3h4LHV/aZa9ukqQjCgIygmyWAnI=;
        b=68ZELSGoErna6Kx0I1rr70ZevaMAPMnUYlggojQeGdeNtet7Hum0m7txFWvhbVCPoh
         Lpfn1c1GUzjoDoqF3atTMDyB/W54WSq09ZqEMstjj/nD57yi3McP45zUESmlBRcMSayd
         RCzz4ipAytYtGQe71XITH8QJ3AOzILuXAM8yhmiGgJ7WF+oGlf5airqmyAOM2HGknwiH
         NL8jDL6gpoJPBQW7EeAY6wZ4C88AXehvjWq8bqkos1IivsjngJ9pqrOMVpnTljE1x58T
         I93xuOolWlJ6WC9weiHMQEfCyYC7FH5wSxSWXUOcug8i2eaQtc0PgYHeEI3sT7IioZIr
         TevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9AKK/wGlnxig+lE3h4LHV/aZa9ukqQjCgIygmyWAnI=;
        b=BCdyjf8oMzGsCSI1LBXGPPLNyh1Bs0gxV3zIXwU3BR9Q0v3ysJgP2baw64KJ+f+w+a
         91D9kD8tmDAYk8w2mkm9U2xM88syOeRdFpsFwo3ztTEniy1Dhim6LbVo1UOK1CXZLuGi
         td1Xnnqs/GAYzJuOdJuwJTrO1PWz6SiJ7CgpOtFRdFAHo/kTYhzV4nBLHrCsZEXiSj2/
         ueXwDKyCYsYM1fHimzIBtb/4GYhFVqywZkwSDCrfmNfMb1buos1FJUSeH+X7ZEta3Gbt
         UE1Peqi8F8TMgXfw3aqDhGydQL3RB2jI5f7qSPNk6yHymYDFQT71LZqxBbeJjtXDvMhu
         u2LQ==
X-Gm-Message-State: AOAM53073qvwXyuFwaHKEzrrRjri0f5yn3QM6Hfx0J2MRRTgp7DLDPGJ
        7AARLuoZgzSjscOc65m6AohR9cgee552u2BEwsopLg==
X-Google-Smtp-Source: ABdhPJwBmyn23Epq/35EZiri4tm6JvqSiIIERB77yO45Op+oQcI+/5ahmZRwLntOQrNzhYN0N3NhjEndaBvuqb3gpmc=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr6342011pll.132.1650662863976; Fri, 22
 Apr 2022 14:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
 <20220421012045.GR1544202@dread.disaster.area> <86cb0ada-208c-02de-dbc9-53c6014892c3@fujitsu.com>
 <CAPcyv4i0Noum8hqHtCpdM5HMVdmNHm3Aj2JCnZ+KZLgceiXYaA@mail.gmail.com>
 <20220421043502.GS1544202@dread.disaster.area> <YmDxs1Hj4H/cu2sd@infradead.org>
 <20220421074653.GT1544202@dread.disaster.area>
In-Reply-To: <20220421074653.GT1544202@dread.disaster.area>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Apr 2022 14:27:32 -0700
Message-ID: <CAPcyv4jj_Z+P4BuC6EXXrzbVr1uHomQVu1A+cq55EFnSGmP7cQ@mail.gmail.com>
Subject: Re: [PATCH v13 0/7] fsdax: introduce fs query to support reflink
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jane Chu <jane.chu@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 21, 2022 at 12:47 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Apr 20, 2022 at 10:54:59PM -0700, Christoph Hellwig wrote:
> > On Thu, Apr 21, 2022 at 02:35:02PM +1000, Dave Chinner wrote:
> > > Sure, I'm not a maintainer and just the stand-in patch shepherd for
> > > a single release. However, being unable to cleanly merge code we
> > > need integrated into our local subsystem tree for integration
> > > testing because a patch dependency with another subsystem won't gain
> > > a stable commit ID until the next merge window is .... distinctly
> > > suboptimal.
> >
> > Yes.  Which is why we've taken a lot of mm patchs through other trees,
> > sometimes specilly crafted for that.  So I guess in this case we'll
> > just need to take non-trivial dependencies into the XFS tree, and just
> > deal with small merge conflicts for the trivial ones.
>
> OK. As Naoyo has pointed out, the first dependency/conflict Ruan has
> listed looks trivial to resolve.
>
> The second dependency, OTOH, is on a new function added in the patch
> pointed to. That said, at first glance it looks to be independent of
> the first two patches in that series so I might just be able to pull
> that one patch in and have that leave us with a working
> fsdax+reflink tree.
>
> Regardless, I'll wait to see how much work the updated XFS/DAX
> reflink enablement patchset still requires when Ruan posts it before
> deciding what to do here.  If it isn't going to be a merge
> candidate, what to do with this patchset is moot because there's
> little to test without reflink enabled...

I do have a use case for this work absent the reflink work. Recall we
had a conversation about how to communicate "dax-device has been
ripped away from the fs" events and we ended up on the idea of reusing
->notify_failure(), but with the device's entire logical address range
as the notification span. That will let me unwind and delete the
PTE_DEVMAP infrastructure for taking extra device references to hold
off device-removal. Instead ->notify_failure() arranges for all active
DAX mappings to be invalidated and allow the removal to proceed
especially since physical removal does not care about software pins.
