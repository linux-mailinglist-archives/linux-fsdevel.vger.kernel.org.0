Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568C1304C59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 23:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbhAZWjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbhAZU6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:58:55 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77BFC061573;
        Tue, 26 Jan 2021 12:58:14 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id y72so3975341ooa.5;
        Tue, 26 Jan 2021 12:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=HL3VqEikgkfbBKxOdllFUs11iyqK0VDF7muvbyZnt9w=;
        b=lVNiBUirYdwR/wrr9pVUToCPKGYcOgnqjZCe41rle7QQ4Ttd8kSOGIStY1LyvdWgu0
         7qsGEIMV38zCXdTHeXpwzF39U9mJqnJoMBIeD+/3vLoQjvII7qto0B194dbkfL2Jn3Dm
         WqPWpT6pKfm4Z8U4yMNxLlccttYbyTs0rOu+zHRyNCf8oQlxRMS479qbvj0CWOFFb8zo
         TFkcZCLTTD2CFKRBKHYDHMSNYYthxvbLRJTsM8WpcMUzTYHyHg5bAKNlJUYdFfoq9dEC
         uaj8fOVwzvOOWBm8mEkc4GeiD7iAX//3pnHpkONL/we0MFjH+8450y/Y7aesSCDXrjLM
         h8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HL3VqEikgkfbBKxOdllFUs11iyqK0VDF7muvbyZnt9w=;
        b=FYnNEsTq9mry/ePcMo53TlnbIvFexntaM23lOoCaTf3ZioNUR0yhQ3AQZ+7R765PK9
         eEdOALJzQOzAlqBuKI5PT2vExkBKfUBd6fHIIo8YdChwsJgTfVVKAx2/Oaa0IOZB49d+
         bGgLjkIJo7PzMLcgM3vGON++koOWhx+eqximHCstOso6nob32PgCsxYEZ7oTrVSM0Yff
         a/y044dP88htoyighJEgGCNgArUHjhZ6UA24i3fZZ8ir+jPjlhYOC66ZbnD0p95WPRqa
         y+HMeSb1FBl6FW1UEK/DhjsQj/b92stsHtIiZUk9CJ7JYjjECcqkcM8/M+OoSVOf1DHS
         Hlgw==
X-Gm-Message-State: AOAM531IaTRnSOqeAGowduQEP2TVAuT0I4Uo8Lj0BfsI9eNI0AYCohgm
        YW7dOHmk8pkZIQB2fc1YSD+v+T/SpDIKIRhpA1lwcMVXRetQPQ==
X-Google-Smtp-Source: ABdhPJxyIe18Q/ih9qXn9BUHg7UenfjESQGmUv95mx7qgVNB9Dc3f79Awu6EvEylPoHWdRjJWq23M0QdWfDtLzvTytk=
X-Received: by 2002:a4a:dcc6:: with SMTP id h6mr5326951oou.89.1611694694121;
 Tue, 26 Jan 2021 12:58:14 -0800 (PST)
MIME-Version: 1.0
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 26 Jan 2021 12:58:02 -0800
Message-ID: <CAE1WUT7BrRUiA_Cupy2ya4aBPhdcdaZ7uvUfgaW1MpTTj-M0Dw@mail.gmail.com>
Subject: [PATCH 0/2] Clean up various style guide violations for EFS
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset simply cleans up a few violations of the style guide I
found searching through the EFS filesystem drivers. There are no
changes to code logic, just the style, so this should be all good to
go.

EFS isn't exactly used anymore as it was replaced by XFS, but should
anyone need to come and fix up something in EFS in an emergency,
probably a good idea to have the code as neat as possible.

Amy Parker (2):
 fs/efs/inode.c: follow style guide
 fs/efs: fix style guide for namei.c and super.c

fs/efs/inode.c | 64 +++++++++++++++++++++++++-------------------------
fs/efs/namei.c |  2 +-
fs/efs/super.c | 13 +++++-----
3 files changed, 40 insertions(+), 39 deletions(-)

--
2.29.2
