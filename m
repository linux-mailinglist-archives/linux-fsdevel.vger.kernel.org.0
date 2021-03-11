Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A42C337AC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 18:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhCKRZu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 12:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhCKRZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:25:23 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B3AC061760
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Mar 2021 09:25:22 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z1so3984177edb.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Mar 2021 09:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yG/vJmP1bt9V/zcHq9LX/hDiqMUciXWcy0fyRaWMlUE=;
        b=0YX0R0Q2hP+VRr62VJBofrj5bwB+MCjUnWO/PvCvGfcEsYGhMMejCqBm8Pfj5e8TdI
         tREJb6S5wxcQOrnVPKESltVTqt698WVEwkHUhw6f646QkClKEo46BT5Pnx4PgGwwzpO3
         tmo5tkrk/yQ2sRylmuPQmAPVuX47NBSI2bBBy2oVNLI2mE2W9cw46R8sHkRC8vbvs8aM
         fJk54uUOb4JlfqsCahno6tBFIGSrTM11D1eXjVahUlcYLWXbPEs/bKkZIqkR95ZVBOgP
         gfHGo42KJ88F0zo9mQ7JNr4WkHjSitiNGvkyRqyfELfoh99GZtkbGnaEih5B1EUO51t6
         eiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yG/vJmP1bt9V/zcHq9LX/hDiqMUciXWcy0fyRaWMlUE=;
        b=HLs0RDCYmaKYeEDVabwWOnj+Fa5n8jUcjKJmItXwD7g/SkpJtmtXINNc1PdfivlsZC
         sMQUYO6Kyg31Zs8ihE/c8GHF/B+600oDydXoKvOrfIo7hNtRBv5wFsDUS89eh/1FKe5l
         ZBrvoZ+E/HvNuWtFxI+teAqQ02owz08n6hYMkcEVqR1+/bHh1I/78EUVypMk5MSeqmD/
         F2S4mvrPOnqOhKvJXyUOMHcgHy/142ltvmsTP3igNZANT2M1ktKU42VQuvhkUepo973I
         4X0W6FOYQtx2S2IUwVeqtJZrRcTshCDdn5iTX76j19lAJQGZPCX0xKr/0SmJVCokx4Nm
         lHDg==
X-Gm-Message-State: AOAM532vcdXaK+my6lqU3OoN5cmPJmZSmKxaM1V1sPijSOzkfqBHRIcq
        cvaaGLJkHSseDfuWKu85aehYuDmNwRaQKM3bsWV4Pg==
X-Google-Smtp-Source: ABdhPJy90akk7moyg6odTY/2ggxqCFkjHdNlPxywRl8kvBDuR1hqSnlJiDWgzS2rTOPef79+7VRiSHGqGyssrZy3vH4=
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr9971780edc.210.1615483521452;
 Thu, 11 Mar 2021 09:25:21 -0800 (PST)
MIME-Version: 1.0
References: <CE1E7D7EFA066443B6454A6A5063B50220D0B849@dggeml509-mbs.china.huawei.com>
 <20210311121923.GU3479805@casper.infradead.org>
In-Reply-To: <20210311121923.GU3479805@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 11 Mar 2021 09:25:10 -0800
Message-ID: <CAPcyv4jz7-uq+T-sd_U3O_C7SB9nYWVJDnhVsaM0VNR207m8xA@mail.gmail.com>
Subject: Re: [question] Panic in dax_writeback_one
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "chenjun (AM)" <chenjun102@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>,
        "lizhe (Y)" <lizhe67@huawei.com>, yangerkun <yangerkun@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 11, 2021 at 4:20 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Mar 11, 2021 at 07:48:25AM +0000, chenjun (AM) wrote:
> > static int dax_writeback_one(struct xa_state *xas, struct dax_device
> > *dax_dev, struct address_space *mapping, void *entry)
> > ----dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);
> > The pfn is returned by the driver. In my case, the pfn does not have
> > struct page. so pfn_to_page(pfn) return a wrong address.
>
> I wasn't involved, but I think the right solution here is simply to
> replace page_address(pfn_to_page(pfn)) with pfn_to_virt(pfn).  I don't
> know why Dan decided to do this in the more complicated way.

pfn_to_virt() only works for the direct-map. If pages are not mapped I
don't see how pfn_to_virt() is expected to work.

The real question Chenjun is why are you writing a new simulator of
memory as a block-device vs reusing the pmem driver or brd?
