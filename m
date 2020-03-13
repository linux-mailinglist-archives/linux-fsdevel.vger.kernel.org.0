Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E9E1850EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 22:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCMVW1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 17:22:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40834 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgCMVW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 17:22:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id f3so6882774wrw.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 14:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=u/As81EyZrntuNgJKlbKQgyjl02SHiQYq3mu31UtGaM=;
        b=EApjgvHkraPqTujXYIeIs7uddFGQHVktFG9/9WMHetJkGfd65z0Ej4D33C8XwxQm7i
         oEcauFIN3G42Iq/jdr3vgB9ZGYdBjIHfxzuB1uU49LwZfu2lZSVmFXrnuJQJEREAJsDN
         WLjuWjTw9XocO9tfm/LqsWCWBaOWTG+4uHS70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=u/As81EyZrntuNgJKlbKQgyjl02SHiQYq3mu31UtGaM=;
        b=mTeiqq3OaLXKVIv14AIwaF5XaAkkvR576ib9pmshORbbrjLQ07p66iBaY3Rw9djHnt
         TntfOuX8Uffb01Rii2/pUQPo9t1YN9mbDNU7EcUCsLkfbM7yilLX93Js55PaTxbQ5v53
         cBuCHbvJj3gpxG23VI8g+gYgQsoO0VCmJofmk0I2WcaQZOOTr2ZZ4hFhB4gjWhVWjJr2
         wlfOM2a+BLnp92iwlJxqEGAvN0AQAdkRIOSC3Bn+/AARxgpA3tx6zg2N9vX4LtDwT2Kq
         YiLfEPPmHZVZDwBRVSojK23OZvV/mhTxKjCRL14FtPCeJcESggim7ddAFxOv2wbVA9HZ
         GuRA==
X-Gm-Message-State: ANhLgQ3suo4OgWlprRClS7FPMRo0FJ2zkjDjGx1zUoQ7X1e+02eomDen
        UjJpE97wFv0f9abXqbN7uED8FA==
X-Google-Smtp-Source: ADFU+vs2LTPEPBmNY4UbQfY1yiOeCJumZuSexjeMELStR2bv6c3DS8UBgz737MqbwVjhuEF0q568cg==
X-Received: by 2002:adf:f289:: with SMTP id k9mr13459520wro.220.1584134545757;
        Fri, 13 Mar 2020 14:22:25 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id q13sm30222861wrs.91.2020.03.13.14.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:22:25 -0700 (PDT)
Date:   Fri, 13 Mar 2020 22:22:22 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.6-rc6
Message-ID: <20200313212222.GD28467@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.6-rc6

Fix an Oops introduced in v5.4.

Thanks,
Miklos

----------------------------------------------------------------
Miklos Szeredi (1):
      fuse: fix stack use after return

---
 fs/fuse/dev.c    | 6 +++---
 fs/fuse/fuse_i.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)
