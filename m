Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3C2211A63
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 05:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgGBDAy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 23:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGBDAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 23:00:54 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15525C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2020 20:00:54 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dr13so27344916ejc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2020 20:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirlab-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Wq3JslNYELazNdYN3d5ZECSZKjYJO3aCNgBZjhaXHs=;
        b=a+NSgxP/5gbvzac+43dVkFV5N+udyBau5Vkq6Lcge/c5HgfzTS9QLkOqp8f8Ez9Ptg
         yRrsq+VueZHeBR272Iii/zwYUNXw9tnSmXG3vYqbglGSHBG7wZnbaKq4EyUjanLwchdy
         hGH9r2jlHTDVCe6bUigP16w8kx/A2qtlOpKSbCKe+BStuwD/Iri9kvtE6BAVuvpvx7BG
         BAmDkHEkyV3WLkdTrDDis2cQ4G4Zxdd7RkemgTt4Kwd09dAd5KMcLGNZIaxkoSmYrq7s
         9H8y7v21oAbb8nTL2Kv6WBacixIh7vCw/yspZCiVTfo6f1LnvRAY60a/8QMmtqQXBs2D
         2zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Wq3JslNYELazNdYN3d5ZECSZKjYJO3aCNgBZjhaXHs=;
        b=Iu/5l5WMGgDJWenDt2rG3I5vA22RZzx9tzgxEv+PDwhNvc8oQGedOGeo5RKqhDl4po
         kRZ83W2y3wXtIuaG0exXkoLC0cpzzXx8fiMLiH+oz5t608JOU0qe556vwrtefo6QOBQq
         +0y3AQ0F5Db65Bjwbeo4mFPxfrsv+T4vMxBYdJ3OLZPWkkknArAfP+9BwG1rzyo16TXk
         cytKsfU5NTrS72HTpPm8cXL9X4tjYwKDcfxipDJ5jv3EPts1srHjFwRzLKKbBB9aa4S2
         f54lYzFx1hk7bSZVSvcfEGzNl0h4wbHxhf/isG1ydNGMZs1UMKCQIZzF9HWJukbK7HT0
         1QMw==
X-Gm-Message-State: AOAM530lJ9d3Bo6+2H1BxnIq52zbrNLJR2CQXLYMgfxby8AVDvIeVQl2
        M6uhNr+c0dkolwewyAvyejxuA5QLrbaePYsQODNYXgdud6A=
X-Google-Smtp-Source: ABdhPJy2Laxw28vFX8lT2vyBhVquCB1WCXcvESu05xt5Bw9Cxwd2GJcKH+uqynNYXl1pbCaAhCnjajzc6yYMAIbqW6s=
X-Received: by 2002:a17:906:5006:: with SMTP id s6mr24861034ejj.294.1593658852847;
 Wed, 01 Jul 2020 20:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAB3eZfsO0ZN_79oaFpooJ32WNZwwyaS4GBb+W6jR=buU-VczAA@mail.gmail.com>
 <20200701091622.GA5411@xiangao.remote.csb> <20200701160808.GA1704717@google.com>
In-Reply-To: <20200701160808.GA1704717@google.com>
From:   lampahome <pahome.chen@mirlab.org>
Date:   Thu, 2 Jul 2020 11:00:40 +0800
Message-ID: <CAB3eZftaTi9QCgbPfQ7dQdPCPJg+mN+4+pSO+Rt3VUVD4KPqVw@mail.gmail.com>
Subject: Re: Fwd: Any tools of f2fs to inspect infos?
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Gao Xiang <hsiangkao@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> # cat /sys/kernel/debug/f2fs/status ?
That's good, I saw info I need

And I also found a f2fs-tools which contains dump.f2fs
dump.f2fs -a will dump SSA info.

How to read the SSA entry info from the dumped file named dump_ssa?
It looks like:
segno: 0, Current Node

[0: d93][1: d95]...etc
[10: da2]...etc
...etc

Take [0: d93] for example, 0 means the first segment and d93 means what?
