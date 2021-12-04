Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D336E468326
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Dec 2021 08:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344694AbhLDH3b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 02:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbhLDH3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 02:29:30 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C2BC061751;
        Fri,  3 Dec 2021 23:26:05 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id l22so12020163lfg.7;
        Fri, 03 Dec 2021 23:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKXLQ9gHG+VwWgKmawT+1iVxntMhMorLWDtObfKTJaY=;
        b=iaERzSc94lLN64X46TwEU50tG7ldJJ1PTceUhWyN0IJ3LQQ9VCA5VmUZEP4Lzjl9sY
         R+RxKF6TyNRyuVIWRK4fl61oOmmnMCwVpSJKSuRpmihcDn8D0KAMe98/BSxVPIx9XEL9
         7G7eDbI91f01HD332ifRFwShK0fAM0ZQvlmIV+O8MPqaFK0E76RV+NwORTxPLHmdedDY
         8wtsbv68PGVPJ72QeQGp4Ym2t4uvV6XG5HsIYb5kPua44fTKcjl9fy88qKHuoKBNsVcb
         g5ER6j99bjZtVRGfblyLJqgAQ7csrfbWKAL++ZX91bpRJL29AyY+3zRGtkrpJY5smeV1
         dIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKXLQ9gHG+VwWgKmawT+1iVxntMhMorLWDtObfKTJaY=;
        b=o+pHXsyah5jfndpm3KlxKgg+GYt4b2mVjw96mQv3IoGxSW9A6JcNW8IV/32oRfemn9
         HOO18el4BpMAjkJNqMZuMQT0obHCsgiiPcryDZC6yqx6itqBtrvL1EK+nazLkqOavN2L
         aa+4j7ipDyC85Z2iUajr0BENNQHARnugMP1+Dk64zGM4nSRTLO0w6vQOiqiC5e5KtgOG
         Uns59qBwFgrpGFm2y+C9XbR4zkoSVO+XB1dMGA+G1j8bwldLjEAE9/d3HpxXSF5d7V1K
         Tdb0KOiGtdSBzghhwjvLBTTvq4K/tpIsyHInoQG2iO27olNxIFk5C1SFQ+xSpsbK/7yg
         RkUA==
X-Gm-Message-State: AOAM533X0kMa8mpHrAYXIhbUXzgjEe9H2RaZIseNeav7g0fn9lzKpRJg
        ubCLsYsfuzn8AoA+7P+/pVsul/Gp3QmDsvsFfPJFiSbOQTE=
X-Google-Smtp-Source: ABdhPJxKMEAUCc2qhrrhlFfQkvLLgc6RZtiAgjZLDQfWulWjshoCTWg3SDBncylJyljduQP0Ykk/pyCNGZ1eLIFOHMA=
X-Received: by 2002:a05:6512:15a2:: with SMTP id bp34mr22495629lfb.65.1638602763609;
 Fri, 03 Dec 2021 23:26:03 -0800 (PST)
MIME-Version: 1.0
References: <CAMBWrQnfGuMjF6pQfoj9U5abKBQpaYtSH11QFo4+jZrL32XUEg@mail.gmail.com>
 <CAOQ4uxipkWdJaBTYem_VVyZpxkgf5yfrY5xru8Agfe+BS7S0eQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxipkWdJaBTYem_VVyZpxkgf5yfrY5xru8Agfe+BS7S0eQ@mail.gmail.com>
From:   Stan Hu <stanhu@gmail.com>
Date:   Fri, 3 Dec 2021 23:25:52 -0800
Message-ID: <CAMBWrQnD0ksdfZOW3LV78ouMayuTEbmrXrQ-4gCodkC+Db0KQw@mail.gmail.com>
Subject: Re: overlay2: backporting a copy_file_range bug fix in Linux 5.6 to 5.10?
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 3, 2021 at 11:15 PM Amir Goldstein <amir73il@gmail.com> wrote:

> So you'd need to backport both to end up with the correct
> implementation of ovl_splice_write()

Thanks! Both commits have already been queued for the stable 5.10
branch: https://lore.kernel.org/stable/Yanx6KobwiQoBQfU@kroah.com/#t
