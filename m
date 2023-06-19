Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F97735EE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 23:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjFSVSv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 17:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFSVSu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 17:18:50 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFCE10E;
        Mon, 19 Jun 2023 14:18:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687209521; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qpjhPsoZtT3zx6c1qT4HP38r7NJBMDykzaZw9Kph+ZvXbQN/u7gnWbk0e6ePlaSplK
    fOADWya9FACkoKWMqp9CXjFhwc8vo/jISH2wVv9d7mi+QcGU114HfutvgLNoEZ6W6+3O
    zsNIR/yoP24XSmw7B83+nDrtBRINwdRKUaBX0MayRKA6NeQA4b3GksyrwNcl6uW1Yslp
    ily+E/v+kQFGheC06p5NfMy9/NQZrQ890/7T67de9xhqtBElKcM/RMb7yDZ+bqsJ/6O6
    TQVvIElGMXGUA5bpP6OQV2u1H1Mkxmgja9ZQzuizp89bv5amlZ70zGaPXCldPZMLmPJ3
    zAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687209521;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=nj2Y7Ri4R0W6QZ4x2JuvJ33FXiLCKwjJhdChI0lOxtU=;
    b=gCyV3+OIWY0sFKCFHhcS2Ax3BYVApgKCV2t/uDD6qMGHAP7R2ZzgAS5GGIYo8X9hwW
    kD5KYYl+s1nJ23xqyznIFVztEFJ/SlZVvzTriwAWrbXtd/GisRWipk56sGbrjMuXiHav
    2U2NYXaPsrNRI0pz6ETjkYlqmgOWAyONzdorNO1P2fVURvPJ5rnpbUSUYnKn+4RF2GDI
    hezjbDQpmvj34Yuy/51ijZ5WfLK4UogAVl3B7fx4jlWu7QXQGlZBhKvIWRr+OnAm0I6Q
    QE9cnJgfQX5SQ/YGXI3RvUer6cBs4oQWyoHh3V8jriEc559vcbSWWgCMcPzcL2vqLFmI
    E4GQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687209521;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=nj2Y7Ri4R0W6QZ4x2JuvJ33FXiLCKwjJhdChI0lOxtU=;
    b=EmOMBLh84jYGENmMw3FiyMU8uDlEPBla7puVnJ3lV0SsuxVVd2zrF623gfUbjdMCed
    1xQ0x8T17uQHeljRKoMLetbLd2J16qvOaUzCQa+hXk1gSPq3lj39wGfXxCN4cDmP0dhh
    Pk+SgkznnufrzX0+ZTvd7IW5IyJP7hd2oPK6R9Jj2vrwCxY8Own4wVRFoLJvJLQAPZbg
    +DZd5lNuo9dL9ucE2XIfBYag6o/xMIqKcIexf4kyB7Au9ibE9exxXxPQPmgCZOHNcONv
    XEBEmcc+6LXF2izjII8i0BXKmx0YTlUfqRBnYIqj5mivUILmo8MUkQXXsKvxHcSQQfGj
    Zu6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687209521;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=nj2Y7Ri4R0W6QZ4x2JuvJ33FXiLCKwjJhdChI0lOxtU=;
    b=grxmVO2oXqYiWN0i48AewPi5wFOOtkL09drX1sgR8KqfkktewI0o0eR9KLCe3gO6OV
    1yAtzccL2EdNXHC01wCA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1EQ33bneoxgmq7ABeEwyjghc0WGLJ+05px4XK4px0+bSzE8qij5Q="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id zb0c8bz5JLIcDvf
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 19 Jun 2023 23:18:38 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com, Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v2 0/5] clean up block_commit_write
Date:   Mon, 19 Jun 2023 23:18:22 +0200
Message-Id: <20230619211827.707054-1-beanhuo@iokpp.de>
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

Changelog:

    v1--v2:
        1. Re-order patches to avoid breaking compilation.

Bean Huo (5):
  fs/buffer: clean up block_commit_write
  ext4: No need to check return value of block_commit_write()
  fs/ocfs2: No need to check return value of block_commit_write()
  udf: No need to check return value of block_commit_write()
  fs/buffer.c: convert block_commit_write to return void

 fs/buffer.c                 | 24 +++++++-----------------
 fs/ext4/move_extent.c       |  7 ++-----
 fs/ocfs2/file.c             |  7 +------
 fs/udf/file.c               |  6 +++---
 include/linux/buffer_head.h |  2 +-
 5 files changed, 14 insertions(+), 32 deletions(-)

-- 
2.34.1

