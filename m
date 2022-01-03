Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682BD482D6F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 02:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiACBaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jan 2022 20:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiACBaH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jan 2022 20:30:07 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BCAC061761
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jan 2022 17:30:07 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id 8so29091946qtx.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jan 2022 17:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=dJmlpeHSzmfPJzpdR8dElrYeKtTVZ8FFq7eOaPLKW50=;
        b=iEl8PTw5kxW9uQMR2htcKzRV7nuyoMH8TpFXVbLKnB/KaIGhkMcYarLoKVcz94oSWj
         dibvuEi1RGHrhu82DbFNanrdapY++qC1xeFYCi2amTLl8NKB/Jzhk/RfmdIeEl7Y8hi2
         te1tKtO51yPigpEgTWlZbvpFBlMh84mX2r7YebmOayfhPkGaok7lErBVmkEpkdGf0lHn
         Ry4iJxRVWheFObEkKqqWJPsANxhEUnqCTg4WYI6vnkcB9CIgsiFrOWNNdXo27l1TRvqT
         eY2Mj/Gj2ihJ1xrFTBTazvMgR7lXktPza4fQx6DUv8ktoTqaHGhAW+SfHiBDpSXSbqKa
         QECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=dJmlpeHSzmfPJzpdR8dElrYeKtTVZ8FFq7eOaPLKW50=;
        b=MXxYOrIJyJmoCXqvQtUtqJjHHXYFmmqAXdhfVtaGl9uGGtC/ym2yzG/YMOigxsySVV
         /2AOjufqwj6/TPw3DElWc275RfSiMZ9TbQC9lZ93ZsmiKa5yCv4u4r54szVGlMoESU7e
         x2J5DSEzYxMXEw4pxOv19e+mCmE493lR+oiFit3mtr19MDa6yc0dzCvPp/7o5sbbx2ty
         gw693/nuFzFfjZfQBB5W9s39n+HIKPi4s+I+ARL95JNXjoiUkC0oZdP5pt6wslqo2K4a
         QO9MHaS+x+keS9z8H62kOSt5x/9AvTcPuAJgltijfFs9zB/T5mS3XUjOnCikarxQj2tr
         xzIA==
X-Gm-Message-State: AOAM532AK+Q6gI4RV5A616qolu9pHanr7p/81wDJB0sVM0rcMHEM6D0h
        5tuk/UXBGm++KX5yWKepSvS7sb1RZAXIAw==
X-Google-Smtp-Source: ABdhPJy9i777qv46jr1hDVhdfsWKo7Ysd8uFrVYPh+XwMsYq08qLvk3ooVii0C7GvNqADjWWevLtfg==
X-Received: by 2002:a05:622a:14:: with SMTP id x20mr37442474qtw.671.1641173406157;
        Sun, 02 Jan 2022 17:30:06 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d17sm27315032qtb.71.2022.01.02.17.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 17:30:05 -0800 (PST)
Date:   Sun, 2 Jan 2022 17:29:54 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/48] Folios for 5.17
In-Reply-To: <YdHQnSqA10iwhJ85@casper.infradead.org>
Message-ID: <99f710fa-e5c3-18b3-51dc-bef89c989ed8@google.com>
References: <20211208042256.1923824-1-willy@infradead.org> <YdHQnSqA10iwhJ85@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2 Jan 2022, Matthew Wilcox wrote:
> On Wed, Dec 08, 2021 at 04:22:08AM +0000, Matthew Wilcox (Oracle) wrote:
> > This all passes xfstests with no new failures on both xfs and tmpfs.
> > I intend to put all this into for-next tomorrow.
> 
> As a result of Christoph's review, here's the diff.  I don't
> think it's worth re-posting the entire patch series.

Yes, please don't re-post.  I've just spent a few days testing and
fixing the shmem end of it (as I did in Nov 2020 - but I've kept
closer to your intent this time), three patches follow:

 mm/shmem.c    |   58 ++++++++++++++++++++++++++------------------------
 mm/truncate.c |   15 ++++++------
 2 files changed, 38 insertions(+), 35 deletions(-)

Those patches are against next-20211224, not based on your latest diff;
but I think your shmem.c and truncate.c updates can just be replaced by
mine (yes, I too changed "same_page" to "same_folio").

Hugh
