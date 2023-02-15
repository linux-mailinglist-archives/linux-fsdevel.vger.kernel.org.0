Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8284697B4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 13:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbjBOMAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 07:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjBOMAw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:00:52 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2DB3801E
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 04:00:43 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id fi26so21678839edb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 04:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4VUdCGE49XRzHSapC26DVNo0zyTxpm/781TlQ/JM0hk=;
        b=WzXC4h4b9erT7h/NVTKsWubM7WnbXMEVDjLnATSbHHKXVr9Hue4pPMQhKxFKBzzZDe
         OwLX0YPR/wTYDjNQXTnJm0iXeo2bZq1SF38cjtgaYgAwA7VZfzmCONX0xZ/6iU+GLxbJ
         JVZ/WQL3g0v7hmdAdALL+HvjAAVAa2zpGBd9xAA7VQKHeUKKdRh5ZYkkxO7dj9TBpnyH
         Fkg95R4If1CaruvQdj8dV3vs+38lsOypQuTGQGos5IfQx0s/rBlQK6xEgD4glYr4Mnjm
         oELKMsBxoi29MDlefKELd4oXSzBgwTnAZL8DfAF53Q6lRW4zt9wh7wNqoFIcO/5tFEE7
         nKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VUdCGE49XRzHSapC26DVNo0zyTxpm/781TlQ/JM0hk=;
        b=UmO87HNJqrog0nwLYnOi4OCq3CXsd2/LW4zOuqRuk/ZRvRj6WK/nwJ6edrUFQdYlGj
         4adYw4RcogHdolj+EmEYPBc6gyqeDaYdloD8gWDUkwbhUaHJLJXZ1f9AvJjfmmdDBtqH
         hVjirJNxC98kkxDy7BNqdWMaperpVBgvgl+nMoDpGkmurj1ixwjWnb2Q4Jt8rqL9D7wH
         DmV5b3LJQRrveE9bkgNlhlTKE3UaAkjq+qLHsQ3LiKHpABLfC3szCFi7hZQoCIkGcDsT
         RQJ6aIVy2yX9h720AaRpwECdDgfZ8XDDPDSjptJgQcXDDj6TWuX0gdBFwhdBKO7n9iG8
         KjRQ==
X-Gm-Message-State: AO0yUKVCcOO+SXHYCv5aGsmmshb3gFkCKbuFgFFN8iYazcVXjKDnbEhS
        FrZdkZVGixNWiKoy4flrjilW2w==
X-Google-Smtp-Source: AK7set8mzMZsxIghYW+QneLMlPjJkUSgm+fCQZ/b0Mr+7o4w9F+smHLglwSGm487RKihYyCIuty67g==
X-Received: by 2002:aa7:d590:0:b0:4ac:bdf7:dffd with SMTP id r16-20020aa7d590000000b004acbdf7dffdmr1652543edq.12.1676462441534;
        Wed, 15 Feb 2023 04:00:41 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id h2-20020a056402094200b004acb42134c4sm7001477edz.70.2023.02.15.04.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 04:00:41 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Revert boot-breaking changes in fs/
Date:   Wed, 15 Feb 2023 13:00:37 +0100
Message-Id: <20230215-topic-next-20230214-revert-v1-0-c58cd87b9086@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGXJ7GMC/y2MQQqAMAzAviI9W3BTEfzNrFULUmWbIsj+bg8eE
 0heSByFE4zVC5FvSXKogasroC3oyiizMfjGt413PebjFELlJ+PvOrSQY0YibmlZ3EBdDzaYQmK
 cYlDabKHXvpfyAUrgY5dxAAAA
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mm@kvack.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676462440; l=1045;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Pk9Em+bfGAgf2e3KWWPVe2M5izGtozUbvqt4nZPzw3w=;
 b=AgaZWdOrEtG7yPe/2cMEuuiDpK04G3/UjW2o/dHw6W9oZj9z/YCE7ikh9viiSSH86j7Q6d+X3IiY
 nWs65LgUAJNmJKxkuOLxTpEfsmr3l+tO8KhzWcDEZ5bvH16X2poj
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

next-20230213 introduced commit d9722a475711 ("splice: Do splice read from
a buffered file without using ITER_PIPE") which broke booting on any
Qualcomm ARM64 device I grabbed, dereferencing a null pointer in
generic_filesplice_read+0xf8/x598. Revert it (and its dependency)
(or accept better solutions should anybody come up with such) to make
them bootable again.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      Revert "iov_iter: Kill ITER_PIPE"
      Revert "splice: Do splice read from a buffered file without using ITER_PIPE"

 fs/cifs/file.c      |   8 +-
 fs/splice.c         | 159 +++----------------
 include/linux/uio.h |  14 ++
 lib/iov_iter.c      | 435 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 mm/filemap.c        |   3 +-
 5 files changed, 479 insertions(+), 140 deletions(-)
---
base-commit: 3ebb0ac55efaf1d0fb1b106f852c114e5021f7eb
change-id: 20230215-topic-next-20230214-revert-cce3cff17c45

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

