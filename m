Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBD53D79A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 17:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbhG0PZR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbhG0PXy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:23:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3B4C061757;
        Tue, 27 Jul 2021 08:23:40 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id m13so22300834lfg.13;
        Tue, 27 Jul 2021 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pv8Xg1UA/7fyTc8laa/BULTDLowBOTs+1yEN3epTYrc=;
        b=k1rZzZE6xcYi05EXrs4BUpn5+NWrXsCgMXx9Jh7jyRxpfmdG5gGSegc1GAgHUmueGk
         zbjWmhL9vCPf6rULaA9f7eOS08DUjzTIEPuDBJdi8HHqV5MW9B3K4AtcpNnYm2C2eVmO
         +bebb5Fq/OBgJ/fbng6BdbbK2JSJkxVJD1pM3ZvukhltkIyHYkG1NJfAI6yJl8pTVnLB
         x82qUN1w6r0H0qYqjWpgypsVhaRnNAFG8W5wDI2B5U6yBh8k0UzJr7J2LgzJaAhPPJyV
         UX/qJgsbFfd4Xx8vFylNt+BPqkkbKYTbi/tPVwNfvooaMcgIK+UvAr1PXGw01DtsuLRG
         +VCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pv8Xg1UA/7fyTc8laa/BULTDLowBOTs+1yEN3epTYrc=;
        b=hUJN9UfqfndyRLSKlziW3sxzTw9ivTinNLsZv3LxKfwFW3qyYVJCfXKvdiTqYNTy6f
         bWDmGkKnlotgDZ1pgfXcQOD1WM53SMUU/c5w0Nxpulja0lE5XxcrpiD9AOKhO5ZmZLlX
         rmP4omMsfNrErmfW1X0oV3AdO2Q4RrjqPwa3vlW1xK4OD3Nt8Ey0lEaK9UsaQK3dLs64
         kcTUzxPpQcKrPynxs4+UlgZskIwFqGo7X8h2u6qdQlLV2CAsuMTQlmNoIaPqjsOwXrNs
         WPrViIylePNZ3nx1Ar5zIOyabxj52MNO9mVcCRefPUhDqZ+HlkNs54qOsQn62IXgbrRY
         b0Dg==
X-Gm-Message-State: AOAM530asROaACSE+821ErpJp0ZEL2oFcgzp/X2SSnFVLWB1SynFv5D+
        B9zKjcHGbISRdwq/Uy5DWb8oAJrPFyp35ZcmJQo=
X-Google-Smtp-Source: ABdhPJyVDbvQ7qncQhs4SVaYYBTv9KMgYQvTwvyKtxlDr16izB9z9m67AoqweJ0AbPriRysFKNAlhLR4SIpnStFfwX4=
X-Received: by 2002:a05:6512:70a:: with SMTP id b10mr16786306lfs.166.1627399418758;
 Tue, 27 Jul 2021 08:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210727025956.80684-1-hsiangkao@linux.alibaba.com> <20210727151051.GH8572@magnolia>
In-Reply-To: <20210727151051.GH8572@magnolia>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 27 Jul 2021 17:23:25 +0200
Message-ID: <CAHpGcMJ2znSzZOEVZmFNDy-Yh+0HbkgRKs_jhGpRRwHUW3VxXg@mail.gmail.com>
Subject: Re:
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Di., 27. Juli 2021 um 17:11 Uhr schrieb Darrick J. Wong <djwong@kernel.org>:
> I'll change the subject to:
>
> iomap: support reading inline data from non-zero pos

That surely works for me.

Thanks,
Andreas
