Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39DB50CC99
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 19:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbiDWRf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Apr 2022 13:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbiDWRf6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Apr 2022 13:35:58 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4E11A61E9
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Apr 2022 10:33:00 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h5so9910064pgc.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Apr 2022 10:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xxYgAVRvbeskBRCc62b6dd1b3P0m/iQAjdEflJjZwEw=;
        b=cIGzVuvaHPW/VLTUuGNP05j8jEVx31lmj/3qbzCRsPPrbTPeSt32R9NgmplRr+LV2v
         TPG/LcGufNFw0M7teCiF+6fVAYn4/IZUkzhvU151c+DtN5zNP6ijWWFEX0r7a0X7hpZ6
         xO3b46N9BlD5HOH/6KjSBgqpCWBJDeBsMQZmm79J4gye6fRcxGTlCl4dKaFf6y1mAURp
         E5R7bt7AOI4nxW4Mui2PMh/dI9vZ6rNafeuVBGnANyufcFvtdgr6zL9cseyBu2DWlLef
         OiFipnPqxqKTZqc5cVuZn5+/7HX/WRUNoR6ULhHbqgV/g2kNVB4EiarR81JxPDgXZFsx
         xVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxYgAVRvbeskBRCc62b6dd1b3P0m/iQAjdEflJjZwEw=;
        b=1+oTsDxWXTsfpMTeCx5qQaeasWNV7MewNWJWb7gs7NDAxm1AK+V+N17A+kUk58NRXZ
         1KS44xTpYJTiGaHUVlZLDAWFGCDDCBRIO6PGCehAOqcYz7xhTOgk4jpaskg/Af6juVAG
         kAy/VuLrmtFm5fpazkjpgdI9mehEZQaCZv1eeQC3viu4sawCB95fm732+KVR668Drev/
         wUsIlIbypOPS6DycreiGZVQB8EbTMmhf9g2ju/rdJPIje1B0OembWKX71dkokcC8tYje
         WvvWFp1OGpj1aZAiEbjYX2z7NAT98DOOPMn9Cwm8xlKfcSHeOhbDcduGaAXhUyS2KIyE
         x4zg==
X-Gm-Message-State: AOAM533zIluqFbwa1P5HlMSbERsH5LGWDbuQOZqhAkm3RD7ev/gkzc2D
        z4qRcMSghutIkktuE66GwhB02EgXQqVBgP2XvelkiA==
X-Google-Smtp-Source: ABdhPJy0mhTUMjh9InWAjD5l2gEPa+UaJvVCIFLNzGQ3RNZPm0s50yYnG9o8IIvsa9ZqP9/kYJI8dbG4WyP4ubzay9s=
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id
 bk3-20020a056a02028300b00342703e1434mr8647836pgb.74.1650735179515; Sat, 23
 Apr 2022 10:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
 <20220421012045.GR1544202@dread.disaster.area> <86cb0ada-208c-02de-dbc9-53c6014892c3@fujitsu.com>
 <CAPcyv4i0Noum8hqHtCpdM5HMVdmNHm3Aj2JCnZ+KZLgceiXYaA@mail.gmail.com>
 <20220421043502.GS1544202@dread.disaster.area> <YmDxs1Hj4H/cu2sd@infradead.org>
 <20220421074653.GT1544202@dread.disaster.area> <CAPcyv4jj_Z+P4BuC6EXXrzbVr1uHomQVu1A+cq55EFnSGmP7cQ@mail.gmail.com>
 <20220423000121.GH1544202@dread.disaster.area>
In-Reply-To: <20220423000121.GH1544202@dread.disaster.area>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 23 Apr 2022 10:32:48 -0700
Message-ID: <CAPcyv4h0wv3ecXP3q2QM2gnpxMggb7XJoJZcFdJD-xJ==mRGFg@mail.gmail.com>
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

On Fri, Apr 22, 2022 at 5:02 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, Apr 22, 2022 at 02:27:32PM -0700, Dan Williams wrote:
> > On Thu, Apr 21, 2022 at 12:47 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Wed, Apr 20, 2022 at 10:54:59PM -0700, Christoph Hellwig wrote:
> > > > On Thu, Apr 21, 2022 at 02:35:02PM +1000, Dave Chinner wrote:
> > > > > Sure, I'm not a maintainer and just the stand-in patch shepherd for
> > > > > a single release. However, being unable to cleanly merge code we
> > > > > need integrated into our local subsystem tree for integration
> > > > > testing because a patch dependency with another subsystem won't gain
> > > > > a stable commit ID until the next merge window is .... distinctly
> > > > > suboptimal.
> > > >
> > > > Yes.  Which is why we've taken a lot of mm patchs through other trees,
> > > > sometimes specilly crafted for that.  So I guess in this case we'll
> > > > just need to take non-trivial dependencies into the XFS tree, and just
> > > > deal with small merge conflicts for the trivial ones.
> > >
> > > OK. As Naoyo has pointed out, the first dependency/conflict Ruan has
> > > listed looks trivial to resolve.
> > >
> > > The second dependency, OTOH, is on a new function added in the patch
> > > pointed to. That said, at first glance it looks to be independent of
> > > the first two patches in that series so I might just be able to pull
> > > that one patch in and have that leave us with a working
> > > fsdax+reflink tree.
> > >
> > > Regardless, I'll wait to see how much work the updated XFS/DAX
> > > reflink enablement patchset still requires when Ruan posts it before
> > > deciding what to do here.  If it isn't going to be a merge
> > > candidate, what to do with this patchset is moot because there's
> > > little to test without reflink enabled...
> >
> > I do have a use case for this work absent the reflink work.  Recall we
> > had a conversation about how to communicate "dax-device has been
> > ripped away from the fs" events and we ended up on the idea of reusing
> > ->notify_failure(), but with the device's entire logical address range
> > as the notification span. That will let me unwind and delete the
> > PTE_DEVMAP infrastructure for taking extra device references to hold
> > off device-removal. Instead ->notify_failure() arranges for all active
> > DAX mappings to be invalidated and allow the removal to proceed
> > especially since physical removal does not care about software pins.
>
> Sure. My point is that if the reflink enablement isn't ready to go,
> then from an XFS POV none of this matters in this cycle and we can
> just leave the dependencies to commit via Andrew's tree. Hence by
> the time we get to the reflink enablement all the prior dependencies
> will have been merged and have stable commit IDs, and we can just
> stage this series and the reflink enablement as we normally would in
> the next cycle.
>
> However, if we don't get the XFS reflink dax enablement sorted out
> in the next week or two, then we don't need this patchset in this
> cycle. Hence if you still need this patchset for other code you need
> to merge in this cycle, then you're the poor schmuck that has to run
> the mm-tree conflict guantlet to get a stable commit ID for the
> dependent patches in this cycle, not me....

Yup. Let's give it another week or so to see if the reflink rebase
materializes and go from there.
