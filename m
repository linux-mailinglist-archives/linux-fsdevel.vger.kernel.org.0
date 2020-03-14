Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAD2185783
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 02:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCOBjN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Mar 2020 21:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgCOBjM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:39:12 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E76F22071B;
        Sat, 14 Mar 2020 20:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584219193;
        bh=nlaaveyfQbhFKfwiAaphWpQDQEdEAujbuJUQUWFnHF0=;
        h=From:To:Cc:Subject:Date:From;
        b=0iSH8Q5D+Ml4kWit103vNhqqB1ao1wz8fX85tuNaSR98NmuiY+2hC1jyJD/ruJ/V1
         199VRhsa+r9bu1MzO7xz9Tr7s0TnpAj5smS4RburSHj7ylnB0x9tbam9/SzEee07yX
         pQtOWhG8kxmo09f3EZX3BsptKW71I9wsopcIgkek=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH 0/4] fscrypt: add ioctl to get file's encryption nonce
Date:   Sat, 14 Mar 2020 13:50:48 -0700
Message-Id: <20200314205052.93294-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset adds an ioctl FS_IOC_GET_ENCRYPTION_NONCE which retrieves
the nonce from an encrypted file or directory.

This is useful for automated ciphertext verification testing.

See patch #1 for more details.

Eric Biggers (4):
  fscrypt: add FS_IOC_GET_ENCRYPTION_NONCE ioctl
  ext4: wire up FS_IOC_GET_ENCRYPTION_NONCE
  f2fs: wire up FS_IOC_GET_ENCRYPTION_NONCE
  ubifs: wire up FS_IOC_GET_ENCRYPTION_NONCE

 Documentation/filesystems/fscrypt.rst | 11 +++++++++++
 fs/crypto/fscrypt_private.h           | 20 ++++++++++++++++++++
 fs/crypto/keysetup.c                  | 16 ++--------------
 fs/crypto/policy.c                    | 21 ++++++++++++++++++++-
 fs/ext4/ioctl.c                       |  6 ++++++
 fs/f2fs/file.c                        | 11 +++++++++++
 fs/ubifs/ioctl.c                      |  4 ++++
 include/linux/fscrypt.h               |  6 ++++++
 include/uapi/linux/fscrypt.h          |  1 +
 9 files changed, 81 insertions(+), 15 deletions(-)


base-commit: 98d54f81e36ba3bf92172791eba5ca5bd813989b
-- 
2.25.1

