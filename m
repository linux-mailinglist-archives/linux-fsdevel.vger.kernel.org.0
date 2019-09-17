Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D78AB546A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 19:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfIQRkI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 13:40:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43048 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfIQRkI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:40:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 156F82604C3
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fs/unicode: Changes for v5.4-rc1
Date:   Tue, 17 Sep 2019 13:40:04 -0400
Message-ID: <85ef0eg6tn.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-next-v5.4

for you to fetch changes up to aa28b98d6dbcdb1c822b53f90e509565dfc450b0:

  unicode: make array 'token' static const, makes object smaller (2019-09-17 11:48:24 -0400)

----------------------------------------------------------------
fs/unicode patches for 5.4-rc1

This includes two fixes for the unicode system for inclusion into Linux
v5.4.

  - A patch from Krzysztof Wilczynski solving a build time warning.

  - A patch from Colin King making a parsing format static, to reduce
    stack size.

Build validated and run time tested using xfstests casefold testcase.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

----------------------------------------------------------------
Colin Ian King (1):
      unicode: make array 'token' static const, makes object smaller

Krzysztof Wilczynski (1):
      unicode: Move static keyword to the front of declarations

 fs/unicode/utf8-core.c     | 2 +-
 fs/unicode/utf8-selftest.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Gabriel Krisman Bertazi
