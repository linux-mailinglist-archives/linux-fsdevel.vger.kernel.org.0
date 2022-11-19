Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E886311F3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Nov 2022 00:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiKSXU2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Nov 2022 18:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiKSXU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Nov 2022 18:20:27 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE1E1A222;
        Sat, 19 Nov 2022 15:20:26 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p8so13703860lfu.11;
        Sat, 19 Nov 2022 15:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PnhRnJNAyjU6feAu0abzX3ol/WrQz0Qd4vkqXDr2Luw=;
        b=idpQMRnwoQfYlxRNRoka53gYOGZ6pWpnaVYc1ceez2qA1VcLtmcaJ2GOwms2IhgX1f
         9lS9v9gCaHTA7LCU9uhjkPiX1SU5XOZY2uenWG2FkDla/RE6V1LP30BGHRFgy71ZAQFr
         iSMHbYi9+vSZc/l8lpXsROX2EWcAIDwlxVC4KW2JBW8PyeynRHEpfhOCykSJA8A1bm3K
         JFftd8VUl9/z5Zb6XQPtlWpaYYqyVaUP3YYj/kphtdIDLHZUZTUwaNqzEjjTR88rclzn
         vpyLvUIwoXamHmKQEjO9SI/wGa1bhT0zXrvFvKxEDWFWqoGorqB3IVfvxQB15acJzkK+
         40ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnhRnJNAyjU6feAu0abzX3ol/WrQz0Qd4vkqXDr2Luw=;
        b=HDj0n19ZG1diyMC3jsr64O3DQ75xheloo/wWZ2J0AWEDgRxXve7o+s6jzqb1fi5mwF
         aq2YV5EuGppGvMjCup+fVMxB+ptR5QoSRLJ0+MgZF6aCIIA4oZ9Vn4gObJNKpUUMYDol
         PDiSPQ5pFBaVqvR/jeek66IGtr4Q7lxNKZfZF8Nk2tlIrVLdubgobgQqVRIpYg9ciAhE
         TT0TuMk8T7KRGzd+dIzVCxLEdx2U0GTdxyYhC1SG1BNm7Yc4AQiRe6pusSNSRRkUpCoA
         RfqIYYQuiJsOtKZVIUITUn3tVrqSOuZ59UkI08Yt7OwgI3Va7v0pI9jjjl7CsSajkqjn
         40Dw==
X-Gm-Message-State: ANoB5pl28+ssBoXIdMjGM4yC24TG7x4MZjcqU6rVzVL730hOVftNPLA9
        kX/hj2SdzuDiEVBFfdD1/BWwlNV7NkmicNxMpeqqVXuddEpF1Q==
X-Google-Smtp-Source: AA0mqf4bTD56V41OFfrKfmfQa/7rNrYxbA0at0tfetRTfzYEzZJLSj6Xe3A2SrjfR2RZC3eV+wtTD8ZPaIknFKCUjSo=
X-Received: by 2002:a05:6512:484:b0:4a2:33f8:2d0f with SMTP id
 v4-20020a056512048400b004a233f82d0fmr3999702lfq.140.1668900024725; Sat, 19
 Nov 2022 15:20:24 -0800 (PST)
MIME-Version: 1.0
References: <CAHWihb_EYWKXOqdN0iDBDygk+EGbhaxWHTKVRhtpm_TihbCjtw@mail.gmail.com>
 <Y3h118oIDsvclZHM@casper.infradead.org>
In-Reply-To: <Y3h118oIDsvclZHM@casper.infradead.org>
From:   Jorropo <jorropo.pgm@gmail.com>
Date:   Sun, 20 Nov 2022 00:20:13 +0100
Message-ID: <CAHWihb_HugpV44NdvUc2CV_0q2wk-XWyhmGdQhwCP6nDmo1k7g@mail.gmail.com>
Subject: Re: [REGRESSION] XArray commit prevents booting with 6.0-rc1 or later
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, nborisov@suse.com
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

Matthew Wilcox <willy@infradead.org> wrote :
>
> On Sat, Nov 19, 2022 at 05:07:45AM +0100, Jorropo wrote:
> > #regzbot introduced v5.19-rc6..1dd685c414a7b9fdb3d23aca3aedae84f0b998ae
> >
> > Hi, I recently tried to upgrade to linux v6.0.x but when trying to
> > boot it fails with "error: out of memory" when or after loading
> > initramfs (which then kpanics because the vfs root is missing).
> > The latest releases I tested are v6.0.9 and v6.1-rc5 and it's broken there too.
> >
> > I bisected the error to this patch:
> > 1dd685c414a7b9fdb3d23aca3aedae84f0b998ae "XArray: Add calls to
> > might_alloc()" is the first bad commit.
> > I've confirmed this is not a side effect of a poor bitsect because
> > 1dd685c414a7b9fdb3d23aca3aedae84f0b998ae~1 (v5.19-rc6) works.
>
> That makes no sense.  I can't look into this until Wednesday, but I
> suggest that what you have is an intermittent failure to boot, and
> the bisect has led you down the wrong path.

I rebuilt both 1dd685c414a7b9fdb3d23aca3aedae84f0b998ae and
the parent commit (v5.19-rc6), then tried to start each one 8 times
(shuffled in a Thue morse sequence).
0 successes for 1dd685c414a7b9fdb3d23aca3aedae84f0b998ae
8 successes for v5.19-rc6

This really does not look like an intermittent issue.
