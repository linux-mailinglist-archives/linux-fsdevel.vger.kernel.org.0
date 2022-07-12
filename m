Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DC4571B4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 15:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiGLNbf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 09:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiGLNbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:31:34 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B6EB628E
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 06:31:32 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id fd6so10113024edb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hPJjqua15ah0sn3T7jWS+IFyxkya2Msc4Z32Nn2kGoc=;
        b=rg5QfwIufOpJub8XP1Do/yDFjwLo/4t6z3t0MVStmetmWBYwLZdVZFAfcHoRgYuULQ
         dhca7EmYKW/nyw6Emq5yMl47pmsCvL5eqqRyQjI6t+cTZL46Rqp67OGPqy7T1nBYdMAc
         EjhvJ817SyhMg+YYsqMuMFZA3gyJyQl0gJC3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hPJjqua15ah0sn3T7jWS+IFyxkya2Msc4Z32Nn2kGoc=;
        b=VjAzpkjW2SElki7qDvAP6jVxsOgu6n/7qi0tmG0ztFWnFDrFOWBiRaefPsXwnKhlkF
         /koYDf9+BgfTf2a2Q0kTg/BXZjK/Lp/qX5Nty0afOiDI5zflh8dn+yHGQoxO1BTd8npf
         DXTOU/z05x2jfFS2CdrJb3GugZZWRg1xtcrqfdAydJjdnD79FaPd2U6hlseuDjLFBa0+
         FYoupLuMbBTiBthu9vmCGIW5yqS8gECC+i1dX1JKeAvL6orLItgMODMlrKxeGDIWeypA
         Ts6faAowaRC7/NRiGQIXZENurcJUPUm6yF+O/QMKyAVJRsmwSm4e55Q3Yb6mdtkX+bnZ
         78Wg==
X-Gm-Message-State: AJIora8MTK0HKY7+VVyX1G0d9uR7YW4XZI3H9maQ4cBgQ9dfkCHk+qSA
        gwDizNbbQWivnjQmvGd3UiVr8Q==
X-Google-Smtp-Source: AGRyM1usO+07EFR5sCIZbvQcc/IsObDEBI0KLY3SELHUhBKsdOKF7QwU9BBoz3qsp+Ku7g593e0m5A==
X-Received: by 2002:a05:6402:5201:b0:43a:d797:b9c with SMTP id s1-20020a056402520100b0043ad7970b9cmr13125486edd.343.1657632690892;
        Tue, 12 Jul 2022 06:31:30 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (82-144-177-44.pool.digikabel.hu. [82.144.177.44])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709063d3200b0072af3c59354sm3850822ejf.146.2022.07.12.06.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:31:30 -0700 (PDT)
Date:   Tue, 12 Jul 2022 15:31:24 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 5.19-rc7
Message-ID: <Ys13gTA+irEuI+OA@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.19-rc7

Add a temporary fix for posix acls on idmapped mounts introduced in this
cycle.  Proper fix will be added in the next cycle.

Thanks,
Miklos

---
Christian Brauner (1):
      ovl: turn of SB_POSIXACL with idmapped layers temporarily

---
 Documentation/filesystems/overlayfs.rst |  4 ++++
 fs/overlayfs/super.c                    | 25 ++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)
