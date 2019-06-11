Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 339933C3AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 07:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403797AbfFKFyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 01:54:04 -0400
Received: from mail.quoscient.io ([80.244.248.206]:44978 "EHLO
        mail.quoscient.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403745AbfFKFyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:54:03 -0400
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jun 2019 01:54:02 EDT
Received: from mail.quo (localhost [127.0.0.1])
        by mail.quoscient.io (Postfix) with ESMTP id 16E511A00398;
        Tue, 11 Jun 2019 07:45:41 +0200 (CEST)
Received: from [10.43.134.50] (ath.ops-vpn.quo [10.43.134.50])
        by mail.quo (Postfix) with ESMTPSA id BEA335D6;
        Tue, 11 Jun 2019 05:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=quoscient.io; s=mail;
        t=1560231940; bh=PqhcKK46lnF57Zwj7bPXRQ0/vTUMOCKSwoLm6UTXZZU=;
        h=From:Subject:To:Cc:Date:From;
        b=ZpkxoMMe68nlWp6NXPvp/uCvN+1IKXU2AAurh4Jl/RVKSP/TGKKrJTalypI3aFtsW
         5bICsh6Db6xCR76sa+XD/tGgouCR7MqJDloq71syctcppqSkyMTZo4cXqSut7+8+VK
         AKgcJI8auSplAaGW9k9sePzuVffXK/zAHBZSnOe4=
From:   Aurelien Thierry <aurelien.thierry@quoscient.io>
Subject: [PATCH] fs: relatime update - Match comment with behavior
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Aurelien Thierry <aurelien.thierry@quoscient.io>,
        linux-fsdevel@vger.kernel.org, trivial@kernel.org
Openpgp: preference=signencrypt
Autocrypt: addr=aurelien.thierry@quoscient.io; prefer-encrypt=mutual; keydata=
 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
 UPiWe0aztzUFHpHi
Message-ID: <5553a3e1-bc49-4553-0648-91350be3ae9c@quoscient.io>
Date:   Tue, 11 Jun 2019 07:45:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2 comments right before code wrongly state that if (c|m)time is younger
than atime, then atime is updated (behavior is the other way around).

Fix aligns comments with actual behavior, function description and
documentation (man mount).

Signed-off-by: Aurelien Thierry <aurelien.thierry@quoscient.io>
---
 fs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index df6542ec3b88..1e5489288aa9 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1620,12 +1620,12 @@ static int relatime_need_update(struct vfsmount *mnt, struct inode *inode,
 	if (!(mnt->mnt_flags & MNT_RELATIME))
 		return 1;
 	/*
-	 * Is mtime younger than atime? If yes, update atime:
+	 * Is atime earlier than mtime? If yes, update atime:
 	 */
 	if (timespec64_compare(&inode->i_mtime, &inode->i_atime) >= 0)
 		return 1;
 	/*
-	 * Is ctime younger than atime? If yes, update atime:
+	 * Is atime earlier than ctime? If yes, update atime:
 	 */
 	if (timespec64_compare(&inode->i_ctime, &inode->i_atime) >= 0)
 		return 1;
-- 
2.17.1

