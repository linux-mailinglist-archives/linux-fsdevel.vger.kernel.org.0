Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D1373D75C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 07:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjFZFzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 01:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjFZFzj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:55:39 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D331E48;
        Sun, 25 Jun 2023 22:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687758927; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aQnuDz/XBuzSZ3LWUcwUNly1AAPclqlAlchZ+nfH2TQqNJkrRABXbXTPFtQwhvR8Dl
    36HRTcGjFtf0aItO7SO746s0Rp2AJ5Uv3lKfbRiGozGFYlt/Tx+BS5nxXsbvUVdyXhFk
    3B0TCaqosEfQ76zGA5HFGZpwg4y4slq5c5U379aspbk/w5FCQQz66AP2ErfAmyZlhnQh
    7X25h+X4WvcsD9gbmwD7al7YYbrxq4m6tyAlJ5uM40dh7MTbgDyNbzGwAi5x9W1i7Oa0
    JQuXu9ZnRDlSF/fz11B3CBcmSxSujDGFBGxy2XrCJ18SeeY25hs27t+XECNbsjrrFZCT
    WUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687758927;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=uGLdz3S1xYOcf7/Hp5FiA7LT6elpVU7X4yht5ubS848=;
    b=Et28lcPwyiozhcpks+fxVKJIGR8B/Y5urmyCB1k9VkluIY9qtrgvBVt0R8ffdbv/z3
    O+4bnKdVOuBfaeCoM84ZDgpspBSIyaVdibShhnV2lbiJyNsW1liBFyQrGmt5dTYUvRrB
    mubLw/wsF4Yo6FbFFHrelOGMA7W5hmdWHsc2ngGZD3paZuTOFPaXXBosinJw6IvZ87CI
    qPDcYwARKDiufHzvcUEMQZTz6RwQAoxNuDoKE2Zqasd4COWM3G63jxPIf4haWs3eETLb
    4MNjGNhw/BR7rQvwxRu9luczVX+EWPSYqm3FiH6yBfQIWbsnjJfibd66bfFc/pokRPVB
    l3+w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687758927;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=uGLdz3S1xYOcf7/Hp5FiA7LT6elpVU7X4yht5ubS848=;
    b=FHio1GDrW3lWX1xVIMoYFB5eF+8yuHoMFyHQzgBeBtfGtXDzU7rrakxD+BcbcdeQgx
    EuHdnYpiLoxDAmDdis66Kkcln+PAuY0R6/vFWhOHpObjx05nYkbD53wnJvwunEYysGIB
    vBfcTloI045nLO6VswtSOKOZQsFiju+jOJdFEv7hdRCgmsNZxyQ1YkTE6uaaAGmeGAZI
    pCDFzTJQtknCztHYCl6ogsghjjj/Ngc36bP9z4cc9Zb3L7DnhfQzOaEPbI/mmMIEaTGT
    Y8XOAxGsqLb3Y2MkB4ruQA35ZxYtUtDc9G1javxjvueTRneOlnMW1fgh7J1uZwqVgSPQ
    LrdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687758927;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=uGLdz3S1xYOcf7/Hp5FiA7LT6elpVU7X4yht5ubS848=;
    b=EvMfs2CATMuB7t0GopD93Ats62L8e4gJ7IhZOs+sBP+lGaJLfoH8waE21HbYVEE6sc
    okUDGs5b450223rUf+BQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1RrW5o+P9bSFaHg+gZu+uCjL2b+VQTRnVQrIOQ=="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id zb0c8bz5Q5tQVy4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 26 Jun 2023 07:55:26 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        willy@infradead.org, hch@infradead.org
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com, Bean Huo <beanhuo@iokpp.de>
Subject: [RESEND PATCH v3 0/2] clean up block_commit_write
Date:   Mon, 26 Jun 2023 07:55:16 +0200
Message-Id: <20230626055518.842392-1-beanhuo@iokpp.de>
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

change log:
    v1--v2:
        1. reordered patches

    v2--v3:
        1. rebased patches to git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next

Bean Huo (2):
  fs/buffer: clean up block_commit_write
  fs: convert block_commit_write to return void

 fs/buffer.c                 | 20 ++++++++------------
 fs/ext4/move_extent.c       |  7 ++-----
 fs/ocfs2/file.c             |  7 +------
 fs/udf/file.c               |  6 +++---
 include/linux/buffer_head.h |  2 +-
 5 files changed, 15 insertions(+), 27 deletions(-)

-- 
2.34.1

