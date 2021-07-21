Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197213D08BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 08:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhGUFhM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 01:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbhGUFhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:37:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B864DC0613DC
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jul 2021 23:17:26 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gp5-20020a17090adf05b0290175c085e7a5so3421217pjb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jul 2021 23:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8uCp46ImvOgWa9UyjUPDoGLTVj3tcqAJCj1XniwrNiw=;
        b=B9IlnaRBuRNB1oSr1pJNEQidkE7pZe8zqpMHRKXNd6jcCE84xR1FHOK9neFtl8W5Jx
         h7kWNJaJLNP0CClLcsXK7x3DqRD7VSsyMMQhrZX3fQV8SXGTTaebbsJs/Uv0xAILgN3D
         6Ihkf62IdEbaDRoD0pAq7OF0Z+S8qEU0iJw0dHu19U2CPE96He33msgBzM4fRDzh+xzY
         SniIS0akPTw5RvbT+ctATwAmw5EmTX9IRlaZCyHfNpVXssDwtGB7aN3Fy/bMtLHCqevI
         seeMkLttKTEKkB7YgehaPpqvssVEnCryb9SdbbfbzExP+vXOkl3d1qpNkptuPw9HcP0k
         lVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8uCp46ImvOgWa9UyjUPDoGLTVj3tcqAJCj1XniwrNiw=;
        b=E6GNmqxoMkd9opvg9SwLr4B/O17zP+0ZSVZZg39tOopTpjIbXhfk5hs2bNXoWkabkJ
         a1YCAOC5OVMHihv9SIfeESu3s+dUkBpsuXRldODwZgbVB6ROzn+P02H8cYGD32VUxFn+
         zTD6VLOBwm5YTUEt0qF1u0CSCjghfmqQmY0qYlDpBBb+V77CEmOWfPJDyo7KPqRxDX2C
         HinEJuknFRkS28MplOu6YRUCGz8ysFe3ZrdUtLPnF3ShSR6xxXBBtERKsQtXFm7zo7Yq
         xyh5/59Zp5eC7cIrNQag+vv0eD7NqiKwepJjtcAKXBHccr8zlRa8/Cwo26avVnfUpY5B
         hlIA==
X-Gm-Message-State: AOAM5320EUPtD3eeWHr194b1DIKyw94oqppFgOjyojV3Xgln+WN6Wieu
        G02sNVPecacZiQ27zIvgcOysoQ==
X-Google-Smtp-Source: ABdhPJwYCRdq0WmMoZOc63NSNJYVoR/qId1AztX5GG9Kzwe/jnOzR5O7IsdEvJw3k8ol/+ciwYIXMw==
X-Received: by 2002:a17:90b:310a:: with SMTP id gc10mr33523912pjb.173.1626848246088;
        Tue, 20 Jul 2021 23:17:26 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c03c:a42a:c97a:1b7d])
        by smtp.gmail.com with ESMTPSA id g71sm1384542pfb.139.2021.07.20.23.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 23:17:25 -0700 (PDT)
Date:   Wed, 21 Jul 2021 16:17:12 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v3 0/5] Add pidfd support to the fanotify API
Message-ID: <cover.1626845287.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Jan/Amir/Christian,

This is an updated version of the FAN_REPORT_PIDFD series which contains
the addressed nits from the previous review [0]. As per request, you can
also find the draft LTP tests here [1] and man-pages update for this new
API change here [2].

[0] https://lore.kernel.org/linux-fsdevel/cover.1623282854.git.repnop@google.com/
[1] https://github.com/matthewbobrowski/ltp/commits/fanotify_pidfd_v2
[2] https://github.com/matthewbobrowski/man-pages/commits/fanotify_pidfd_v1

Matthew Bobrowski (5):
  kernel/pid.c: remove static qualifier from pidfd_create()
  kernel/pid.c: implement additional checks upon pidfd_create()
    parameters
  fanotify/fanotify_user.c: minor cosmetic adjustments to fid labels
  fanotify/fanotify_user.c: introduce a generic info record copying
    helper
  fanotify: add pidfd support to the fanotify API

 fs/notify/fanotify/fanotify_user.c | 252 ++++++++++++++++++++---------
 include/linux/fanotify.h           |   3 +
 include/linux/pid.h                |   1 +
 include/uapi/linux/fanotify.h      |  13 ++
 kernel/pid.c                       |  15 +-
 5 files changed, 205 insertions(+), 79 deletions(-)

-- 
2.32.0.432.gabb21c7263-goog

/M
