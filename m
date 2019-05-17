Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1A7B21F8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 23:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfEQVYz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 17:24:55 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:48715 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfEQVYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 17:24:55 -0400
Received: by mail-qt1-f201.google.com with SMTP id n21so7710590qtp.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 14:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HB+0pzs2H+PqPuc5KLht6uXFIm1Vk/TwRK9m9FPAxYg=;
        b=lfi2YKKxO6izIXsbXWpCBlCQvzTvT0j8k2+Uqu9osKrVQn04h5TUEGjxg99LZAZmOr
         //V9xKFuCayFrShdfG/JGUQV+cgW4T77q/yMrKT7sHyfLe3caBW3eOhKDI1AOIt/jlWb
         odT3DE5AX7ggFkqSjPpCBeDvRg+mLWB84sm8F63g+/jzv1aG0lQSZPb8HsJo8Qkz05i7
         MOi5SeegJxnX9w82DS2sTieoNbepZU6FIX5fyh0lgzvykOVWgaStIVY1uU54Z+L67keE
         2rrpXPboKfmeIc2khePuQvyXFdOibht7K8bg2kZ79kgi6nVhdD5YnPT3277Ity1iKnko
         xnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HB+0pzs2H+PqPuc5KLht6uXFIm1Vk/TwRK9m9FPAxYg=;
        b=gIuGXdAhlMvHMWxhpFhkQRg51mYejkkCoXG3kORU8x4iUR6Sl2Iy9ncXg+Vf+3pCkM
         zK7Oe/S5RFnfm9jFZOvq6bG5XdPzqOB30wb4waf6fVl7GXBxRUAepjOVBUXc/UeavpEP
         q2x0cTdlgJhNZ36lWxra4BrxfFauTQ0gzyLHcdCM72dVbafOMO5gQTo3mH1NBzcFKAH2
         B2OY7sJ2Nx89Jc4x3HgcF4b3zFPqxgYok+20rb7yFfxSUJ36bfuQTocd79v57qijYuxl
         hzAbcpdMQiHqHEbGFcHRYvZSfKuCBx88jfzuNeExBnSoCKXorhmxNkYg5ql9wLU2H3fJ
         DBwA==
X-Gm-Message-State: APjAAAUItzc4teafqcoJHBHy5QesUBqPD0U8yp1DY+FMEBLyQI+B29An
        DCjBFFPVAzj/8WNy1uQ+pVk44Tn26/HcUKnFyQXQVA==
X-Google-Smtp-Source: APXvYqynBa4Ia/HCGvB/s4ykvY7rpQ2Vbp0Lij6GV9CGDYwlRGF2Gt6bNHdp3bng2puR6ZhwJbsp9QPJHRD9Yabuv06Uig==
X-Received: by 2002:a0c:9283:: with SMTP id b3mr10140494qvb.229.1558128294610;
 Fri, 17 May 2019 14:24:54 -0700 (PDT)
Date:   Fri, 17 May 2019 14:24:42 -0700
Message-Id: <20190517212448.14256-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V3 0/6] IMA: Support asking the VFS for a file hash
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Updated to add a new template type and to allow templates to be
configured per-rule. This allows additional information about the source
of the hash to be provided without breaking any existing deployments.


