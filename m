Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6582D398012
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 06:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhFBERk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 00:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhFBERk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 00:17:40 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F82C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jun 2021 21:15:58 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id mw15-20020a17090b4d0fb0290157199aadbaso2646838pjb.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jun 2021 21:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3Qx5/477Yig5L61OFwMLDnCrLXWV7pw+VxgbIq/I9BM=;
        b=L4wMXF1m8uq8W5WDMHlMk9MaVK+4srL2mJ9ZomD/pApmJ9j+gxFXP7dDFyydmkacHH
         WacTdf81pGqdvLvoz5gZadfm2l2WKrMeDLO+BiFjZXYjAxarXm/5RJ6ba0Mbj4+FvlPL
         12VSAsoX/s/leIHxA7XELMO0/Y6NVtlv/w7FQIFKDdo9C7jZP5CpfKC46D1K9HPf5Gv0
         sFQWT7lFZtubTQF74Gj8SqrPY9HtpBPQ+UyoVXUB1vRDNaJ+wqdOSusVklrop/W4ZfIq
         3vud/O85q5mpKbn0PT99LL5qmb34Nr7VCwN9iOy3iGewPTUm6JOPmhdvvpwb5Y0PTzS0
         C7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3Qx5/477Yig5L61OFwMLDnCrLXWV7pw+VxgbIq/I9BM=;
        b=C6VqyJbmdT9fg4NKASUx5K7wCB92lGLTu1eZAKaJoqTvkikrMpAbCK3c9J1mN8zf0g
         XfSOVywX94CwKB8gXFPANiAPqujMraqsGJJeKp5qqzDcPY4p5LdA1t0GUQ7hf7yP8sam
         yLC/V4cUSZUugYlJVC9rKV1XRJ3Oe+YHoIgLU+POHu5WZyA+CLXgYYDHGElGAdtwlGUS
         aajyeF5LDYYjb7O6y3UQWQuXj7R7WM7unqfHuY6T0YcJDkmmMo8IFE3ZiHjhEPp4/nut
         BsYDChjhxFtTxL5A0+C+z/kFuV405aC00gO1U7+Y55NpKQA1j2yXvJpu6Egg54Cw6pKH
         OXmA==
X-Gm-Message-State: AOAM532zTf8fR388faUv2GYMkmh4l2GcMiIp8Qm3k7IohU8Zx+/CkUgH
        hLed9/GaJrCKSI/dXAFdi+kX/Ds/Ics=
X-Google-Smtp-Source: ABdhPJw5z7A0yAHelyWLEpnQXuueYkii5ep7MSUB4n11ebXmNMqnwoECb2sYiUUqoQDdLDNgwn/I6twKdPA=
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a05:6a00:882:b029:2de:b01d:755a with SMTP
 id q2-20020a056a000882b02902deb01d755amr25380274pfj.43.1622607357461; Tue, 01
 Jun 2021 21:15:57 -0700 (PDT)
Date:   Wed,  2 Jun 2021 04:15:37 +0000
Message-Id: <20210602041539.123097-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH 0/2] Fix up casefolding sysfs entries for F2FS
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These correct displaying support for casefolding only when that capability
is present, and advertise if encryption and casefolding are supported
together. Casefolding requires CONFIG_UNICODE, and casefolding with
encryption wasn't supported until commit 7ad08a58bf67
("f2fs: Handle casefolding with Encryption")

Daniel Rosenberg (2):
  f2fs: Show casefolding support only when supported
  f2fs: Advertise encrypted casefolding in sysfs

 fs/f2fs/sysfs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

