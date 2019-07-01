Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1948C5C2CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 20:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfGASUT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 14:20:19 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42222 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfGASUS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:20:18 -0400
Received: from jaskaran-Intel-Server-Board-S1200V3RPS-UEFI-Development-Kit.corp.microsoft.com (unknown [131.107.160.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 28A9620425FF;
        Mon,  1 Jul 2019 11:20:18 -0700 (PDT)
From:   Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
To:     gmazyland@gmail.com, ebiggers@google.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org, scottsh@microsoft.com,
        mdsakib@microsoft.com, mpatocka@redhat.com
Subject: [RFC PATCH v6 0/1] Add dm verity root hash pkcs7 sig validation.
Date:   Mon,  1 Jul 2019 11:19:57 -0700
Message-Id: <20190701181958.6493-1-jaskarankhurana@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes in v6:

Address comments from Milan Broz and Eric Biggers on v5.

-Keep the verification code under config DM_VERITY_VERIFY_ROOTHASH_SIG.

-Change the command line parameter to requires_signatures(bool) which will
force root hash to be signed and trusted if specified.

-Fix the signature not being present in verity_status. Merged the
https://git.kernel.org/pub/scm/linux/kernel/git/mbroz/linux.git/commit/?h=dm-cryptsetup&id=a26c10806f5257e255b6a436713127e762935ad3
made by Milan Broz and tested it.


Jaskaran Khurana (1):
  Add dm verity root hash pkcs7 sig validation.

 Documentation/device-mapper/verity.txt |   7 ++
 drivers/md/Kconfig                     |  12 +++
 drivers/md/Makefile                    |   5 +
 drivers/md/dm-verity-target.c          |  43 +++++++-
 drivers/md/dm-verity-verify-sig.c      | 133 +++++++++++++++++++++++++
 drivers/md/dm-verity-verify-sig.h      |  60 +++++++++++
 drivers/md/dm-verity.h                 |   2 +
 7 files changed, 257 insertions(+), 5 deletions(-)
 create mode 100644 drivers/md/dm-verity-verify-sig.c
 create mode 100644 drivers/md/dm-verity-verify-sig.h

-- 
2.17.1

