Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFAD18914E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 23:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgCQW0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 18:26:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbgCQW0B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:26:01 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD93E20738;
        Tue, 17 Mar 2020 22:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584483960;
        bh=4Ks7GDs2QCvszmZUxjGR4IPokVQu3QCKQSlcJs2xjDY=;
        h=From:To:Cc:Subject:Date:From;
        b=uuLouKmhev+xKnAW9H+2rxxZRW23o2FePhcTXN0wv0NS/AMQacDDJjxes4gUABOuf
         MnqS6irsRwCHPm4PVYMg+eKX7D3uipoXk6XtEPBNGbZgG4uCTb3+ZFY1tapn06VM0H
         7cZTZiuSK++AwfL5DiJkGpQLWpLU0PUOEFXOZVHc=
Received: by pali.im (Postfix)
        id 69694700; Tue, 17 Mar 2020 23:25:58 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Fixes for exfat driver
Date:   Tue, 17 Mar 2020 23:25:51 +0100
Message-Id: <20200317222555.29974-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series contains small fixes for exfat driver. It removes
conversion from UTF-16 to UTF-16 at two places where it is not needed
and fixes discard support.

Patches are also in my exfat branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=exfat

Pali Rohár (4):
  exfat: Simplify exfat_utf8_d_hash() for code points above U+FFFF
  exfat: Simplify exfat_utf8_d_cmp() for code points above U+FFFF
  exfat: Remove unused functions exfat_high_surrogate() and
    exfat_low_surrogate()
  exfat: Fix discard support

 fs/exfat/exfat_fs.h |  2 --
 fs/exfat/namei.c    | 19 ++++---------------
 fs/exfat/nls.c      | 13 -------------
 fs/exfat/super.c    |  5 +++--
 4 files changed, 7 insertions(+), 32 deletions(-)

-- 
2.20.1

