Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0528C389B28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 04:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhETCLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 22:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETCLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 22:11:18 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1F4C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 May 2021 19:09:57 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 27so9463582pgy.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 May 2021 19:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=v9bT6Q3KYnsKih8Ryw2Sd9OdkVAXXqCmJdrWbZ7beKc=;
        b=jCjWszy2BzCU8LhZunNvq+Xsjbty2JLJILsy3TP6FmGIVEnlJR1wZrMZDztS2rNBHw
         K7Fe5/gs5+1C+R0ihEoN04F7A9R/58R0bfGE+7TCjKVpbL1qRUxEBfhJUOuw5qeVLJOA
         9hLY9gdkzf73hdhH8/ElKofMpkA2ssv51kjrwBdNIUEk4haWgInhI2b4Ao6hL/z1KfYg
         MV434RgaKwiTJd09UVud7qdDqp0R7HcAkm7tsJrQPbjDhtrXDOiZXsxGwxjE71/y9vbl
         QW13E7alg15Y3oN73cHgUMqzoNqg9/YcLVNVyTaCcPNwsMLkhZxoMjUwEjvGwPDB93f8
         tOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=v9bT6Q3KYnsKih8Ryw2Sd9OdkVAXXqCmJdrWbZ7beKc=;
        b=d7QTTBTycAXP727T6jafBOeFh5lGbdg4Wp2TgK7BvbYRHICKIZQw/dGZqAioNi7e7Z
         rer0JxEJMqQxHgusjYELjqEjj/rPVjr41jxDml7hasj0ckHwoGb4urnVFiTRh5SDbuO4
         7yh6BzO5DlGJWBmYfmO4J9AueV+aIueH3nrGJnPheMdGJ03+Oasws+nnRRF7Lsd7zv90
         Oza6LDC9RJBeSMusFjy3YUVpdNBYzTrS/sxgfIKezrbtDuvqLTc+aZdwAK3H1H9qKpYg
         0s1dg0Q10mofvDB12bwjgYlIzl9Fd5FF32KNNuRZjOL3hiozvayjamjyzUvU8Ye1QjoJ
         aDOA==
X-Gm-Message-State: AOAM5321KhNMKMo0lIH8I1dXHNatNKxN2LcnOoDuxHohh9IdvIcNKcbe
        pGJR/w7/KjdkaLjJj/3iwJHcMg==
X-Google-Smtp-Source: ABdhPJwtKN+DU+G4XC58h+9SRI6r0teVKKx6VheVE5kkyUSjcS2+XwH5ALYLYf+tVp7pkR11CMkQ5w==
X-Received: by 2002:a63:d710:: with SMTP id d16mr2121337pgg.214.1621476597208;
        Wed, 19 May 2021 19:09:57 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c035:b02d:975d:1161])
        by smtp.gmail.com with ESMTPSA id i8sm546261pgt.58.2021.05.19.19.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 19:09:56 -0700 (PDT)
Date:   Thu, 20 May 2021 12:09:45 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 0/5] Add pidfd support to the fanotify API
Message-ID: <cover.1621473846.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Jan/Amir/Christian,

This is the updated patch series for adding pidfd support to the
fanotify API. It incorporates all the suggestions that had come out of
the initial RFC patch series [0].

The main difference with this patch series is that FAN_REPORT_PIDFD
results in an additional info record object supplied alongside the
generic event metadata object instead of overloading metadata->pid. If
any of the fid flavoured init flags are specified, then the pidfd info
record object will follow any fid info record objects.

[0] https://www.spinics.net/lists/linux-fsdevel/msg193296.html

Matthew Bobrowski (5):
  kernel/pid.c: remove static qualifier from pidfd_create()
  kernel/pid.c: implement checks on parameters passed to pidfd_create()
  fanotify_user.c: minor cosmetic adjustments to fid labels
  fanotify/fanotify_user.c: introduce a generic info record copying
    function
  fanotify: Add pidfd info record support to the fanotify API

 fs/notify/fanotify/fanotify_user.c | 216 +++++++++++++++++++----------
 include/linux/fanotify.h           |   3 +
 include/linux/pid.h                |   1 +
 include/uapi/linux/fanotify.h      |  12 ++
 kernel/pid.c                       |  15 +-
 5 files changed, 170 insertions(+), 77 deletions(-)

-- 
2.31.1.751.gd2f1c929bd-goog

/M
