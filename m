Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A48B605501
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 03:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiJTBbK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 21:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiJTBbI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:31:08 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D7686F88;
        Wed, 19 Oct 2022 18:30:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d6so31034383lfs.10;
        Wed, 19 Oct 2022 18:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yJ87aDPEGTeaHnfrYNL1PdpyB4+D4BDv2/4OYt77PL8=;
        b=Y7IMT5Nava8658aIV/9QO13ByfJULYRCalDQklkwzr7W57i1tzFrfxO4BZxUSLNI1Q
         0RsVQ2+++MTkLbnYW6UXTUaPVgUE0pLsrk2PU5O2S5tps/fuF9dInT+Ek5+TUoMmA2lM
         ksmOC76QO/P5imLzP6MDc22UAiZqlz2WOb7E347E2pwxgjrhHuh+849ikUlWkP24Kmf6
         z5LRXnMuyZaGWMQ+T8YWo21W5HPV/nXuNidE4IzDt/OouGzE2dWIGPCSYeUeTAHs2I1I
         KWwSqOGe+tnckInL1M1FjJp9ZBfdygrcDWMKURef+V4FURVzPU5KgiSn3X8XyT9OEnJ2
         KKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJ87aDPEGTeaHnfrYNL1PdpyB4+D4BDv2/4OYt77PL8=;
        b=uxdzIWoEcJOx7PcDMUVrRPklXsl6o44F5bt2ck9NBPehzFqdihszSwfYKFgsBL2d7Y
         35Ga4anELzGungU1E4easVLAnT7IgYWl9fQM7B4jJSbpoTryM+uxjrMlGkbtfG4BMiI4
         4BW37tgPBxNtPEPl+aNvBTB5rGsuacoeeb/7nyhuB5ECGfzlI59tKhhKhUOsrMMdmwKv
         x1w2gBt0meITA1+M3XX1R6EAGLtRyp9XSsZAAVLsimuJYGVn08WF1/S5vwCg1EzCdat+
         9pm5E1zPzv3ooeTjva+2O8vH+VHYT9fl2aZWaadY/rmL9igkjC8vAbHYXEbADOv8m2pM
         dy2g==
X-Gm-Message-State: ACrzQf2AYJJyrCNlaaGitzj7ONxakT28yAIEHSvpIMHAqx5JBoKxcXwp
        BidcbYOAeL655Uhv4PN0L7YVjasX+HtSMRy8BMw=
X-Google-Smtp-Source: AMsMyM5lgPVYZzSz+ecmDAbZuQ5Xqy7gZatRR+i8Pveg+5vwjKrJ70pd22RAtoDevwIUmkPxwNNcyA3B8s5c2j/DYW4=
X-Received: by 2002:a05:6512:158c:b0:4a2:5cf6:5338 with SMTP id
 bp12-20020a056512158c00b004a25cf65338mr3845266lfb.81.1666229288238; Wed, 19
 Oct 2022 18:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y0lSChlclGPkwTeA@casper.infradead.org> <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
 <Y017BeC64GDb3Kg7@casper.infradead.org> <CAGWkznEdtGPPZkHrq6Y_+XLL37w12aC8XN8R_Q-vhq48rFhkSA@mail.gmail.com>
 <Y04Y3RNq6D2T9rVw@casper.infradead.org> <20221018223042.GJ2703033@dread.disaster.area>
 <20221019011636.GM2703033@dread.disaster.area> <20221019044734.GN2703033@dread.disaster.area>
 <CAGWkznEGMg293S7jOmZ7G-UhEBg6rQZhTd6ffhjoDgoFGvhFNw@mail.gmail.com> <Y0/2T5KpFurV2MLp@casper.infradead.org>
In-Reply-To: <Y0/2T5KpFurV2MLp@casper.infradead.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 20 Oct 2022 09:27:39 +0800
Message-ID: <CAGWkznF3y0BFi-9+1GhBv8NS5P7TZKvdbX0qSbaGVR2BmvD3Ew@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022 at 9:06 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Oct 19, 2022 at 01:48:37PM +0800, Zhaoyang Huang wrote:
> > On Wed, Oct 19, 2022 at 12:47 PM Dave Chinner <david@fromorbit.com> wrote:
> > > I removed the mapping_set_large_folios() calls in the XFS inode
> > > instantiation and the test code has now run over 55,000 iterations
> > > without failing.  The most iterations I'd seen with large folios
> > > enabled was about 7,000 - typically it would fail within 2-3,000
> > > iterations.
> > hint from my side. The original problem I raised is under v5.15 where
> > there is no folio yet.
>
> But 5.15 does use 2MB pages in shmem.  You haven't really provided
> any information, so I don't know whether the inode that you're having
> problems with is a shmem inode.
No, it is a f2fs inode using 4KB pages.
