Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03807348A6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jun 2023 23:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjFRVgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 17:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjFRVgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 17:36:08 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BA5E1;
        Sun, 18 Jun 2023 14:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687123982; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EUvxIJsXeq/+3VNu36tGkHV2ixv0BVbNgN5kkxLYSJre3M5QOx/vRRAtehK4/uRs+7
    pdVVIdp1onJ7yQXDqlpH+WIMQcRHvk3PJT2cN7eA7NTSqL6anxiqzWVdaJiv6FmtZbYN
    cs8y0SEZ/F5pLfMMJ6F3blMkSavzPnajdai9slDgAndml04w4/iu2I6accGYqj0xNHW0
    14QuVRvufbU4r+rcCr3N/GJgQ9X9reAI1vGzOaMfvOabrstuRDcrjph6FrOYcC0WsJVN
    eIom3JRxc7pSYm3BT+os9PX4z/d5gEadrgOuGJLIAW3VvkTAARY6M5gDa3J7YPmcUafT
    qgGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687123982;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=oqCKd+CNjdzbLYFDJSrbVFBUX2kYJx0eW04RCZgiOf4=;
    b=RQF9P9gJ17Ki6/4vOtmSpTWd47fA2+itNvDhalgwjMJ1ky3tid/kNUQzPavDpQH0br
    QT+vJZO+yhRf3V3q6um3TPgUXQRZ5tk4um3tJN1jDgiFOvYCNqIkCb4vrTzfIzsrA/4N
    krulaMKVwue+xBzqEg5CiWdDYDhNvKwuSJohc2G05aegt/UHBQfQ2Ocsma5qt4ERq66c
    Viwvvd6ErIwDGaoT2v7cJV+Mkg0lQKteWxB0zp+Z6JgMbYo9I3TUT3ji6HeXjiLpnRB7
    5IIGUjYl59c6WusVocNH/f3f8S/PUpMaeVzYPLXHXZ3Lxy7sGHy38rqQULbAwLmxGPmm
    P/mw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687123982;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=oqCKd+CNjdzbLYFDJSrbVFBUX2kYJx0eW04RCZgiOf4=;
    b=SynOk+PpYuDNqLDoeQwxQPc4vsJAXAgVBd+7b/a8CziL205VAhRmSRD/sdLbUkcMpS
    M+4tmpvng/YlcZyJjMr3E65swgDv23gduW+EcKjeZbcbhJ93xdqEim01XBlu9I/AGlJM
    yeze88ReWHTqTIGTIBR6Glm/8gbvhGocPyw2ljfPWcrKAO24+YrTcYOyj8zi8belbVNd
    HDshJlGvCW9EZXuN0uOYQikANPGFp9Ute3MQy2NixS/dc/3eg0FztlTNKFdShNumrRaS
    od98ttTrZCBKdAX5UD53JVVfMWD11WM1nfT50T4hIm+aqyaDfb1u6GFyiWYgl3g24V2o
    w5TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687123982;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=oqCKd+CNjdzbLYFDJSrbVFBUX2kYJx0eW04RCZgiOf4=;
    b=imtXATNJCZgF2HR552RAsHOy451el7nsNuByG4+Cv1D0rWKwKHPRTXoyWLciYtOULd
    y6F9bSYQOrbQ9mmSQkCA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1EQ33bneoxgmq5ARfEwes1hW/CxwfjqKzP/cKnUXGNs35zouFQhI="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id zb0c8bz5ILX0AHI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 18 Jun 2023 23:33:00 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com, Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v1 0/5] clean up block_commit_write
Date:   Sun, 18 Jun 2023 23:32:45 +0200
Message-Id: <20230618213250.694110-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

*** BLURB HERE ***

Bean Huo (5):
  fs/buffer: clean up block_commit_write
  fs/buffer.c: convert block_commit_write to return void
  ext4: No need to check return value of block_commit_write()
  fs/ocfs2: No need to check return value of block_commit_write()
  udf: No need to check return value of block_commit_write()

 fs/buffer.c                 | 24 +++++++-----------------
 fs/ext4/move_extent.c       |  7 ++-----
 fs/ocfs2/file.c             |  7 +------
 fs/udf/file.c               |  6 +++---
 include/linux/buffer_head.h |  2 +-
 5 files changed, 14 insertions(+), 32 deletions(-)

-- 
2.34.1

