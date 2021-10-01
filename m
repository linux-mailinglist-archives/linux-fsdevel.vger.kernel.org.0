Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9148E41EEC6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 15:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353876AbhJANou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 09:44:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42622 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbhJANou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:44:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 29D4222618;
        Fri,  1 Oct 2021 13:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633095785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Vp9MNLMt6ZxPe3s0tPbZwy0Z7Q9QNdY4N5TIKWunCik=;
        b=frbQCjj++MqRWxOh6hsNkgq9cOwlbQ9RUpBCBSf2h7pJrRmvqExX0+dInT1uFYZfnIclXn
        cedToqnDkLcRZUziTswRuA+vG/RrKlEQ5AsxKW8Djh5YeoSDaUXiCnlPrlB11cs+6iyoPu
        fgohlaNPeRMj+ZImRppEA+vSCd1bync=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633095785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Vp9MNLMt6ZxPe3s0tPbZwy0Z7Q9QNdY4N5TIKWunCik=;
        b=J4f2ZQZZ5y14W7N7OgTixk99CqUj3NZ9vjRFM7hqDqFFqv73M/EA/Og232ojnZMhNYMZaf
        Ms/6BhUIFIEEupCA==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D6079A3B88;
        Fri,  1 Oct 2021 13:43:04 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org
Subject: [PATCH v3 0/5]: initramfs: "crc" cpio format and INITRAMFS_PRESERVE_MTIME
Date:   Fri,  1 Oct 2021 15:42:51 +0200
Message-Id: <20211001134256.5581-1-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset does some minor refactoring of cpio header magic checking
and corrects documentation.
Patches 4/5 and 5/5 allow cpio entry mtime preservation to be disabled
via a new INITRAMFS_PRESERVE_MTIME Kconfig option.

Changes since previous version:
- curb enthusiasm in 1/5 commit message
- add cover letter

 .../early-userspace/buffer-format.rst         | 24 +++-----
 init/Kconfig                                  | 10 ++++
 init/Makefile                                 |  3 +
 init/initramfs.c                              | 57 +++----------------
 init/initramfs_mtime.c                        | 49 ++++++++++++++++
 init/initramfs_mtime.h                        | 11 ++++
 6 files changed, 88 insertions(+), 66 deletions(-)

