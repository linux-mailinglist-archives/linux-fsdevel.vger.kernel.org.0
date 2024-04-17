Return-Path: <linux-fsdevel+bounces-17134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E618A83C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CAF3B23D72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 13:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F7D13D60D;
	Wed, 17 Apr 2024 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="NVHiYSx9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271DC13D265;
	Wed, 17 Apr 2024 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359169; cv=none; b=ftJyV8faNFrwahK2FLp+RqUISs65CsOgqORoBc5wcH5ZfzYQU4QQecFZHNHdOAd3qjfddzagD0uA0ecDjNjyfadcBUvABbk+NFzNPd0quk4WlNWZqxPkwwaef7WYtreoM5KUUWpQY7Ibf3Im3A8Lkz0R4Kwf+sbvepcsr1ilsKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359169; c=relaxed/simple;
	bh=9Ie/YLM/joywAkgY5c4+CnSqKB8Gr3vixzyksohbcTw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=h7sXqRBU0fKt7sycjP3M7B8HPgFaZNhb5TBcVX+sfi+PL3nO1XViLC/vjJ6N8/j9Sp/0QEjF0sW+s6lsFxcOMkZFZy7iEBajb9Y24HJJ1VubTXYzXJH36U+WvGNP7Lj8TsBhFpaFuo156VuWZlvKgxUd/QX4Ja2yeh5KrU29cQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=NVHiYSx9; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 213B32126;
	Wed, 17 Apr 2024 12:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713358713;
	bh=sstzwDA7HJF1SbYTI7fJ3qkhbZk4t2Sju46k98cE9Mk=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=NVHiYSx9A3Qy8ga9U6cPD4ucTqsztbDPJ3G1vOyNDXOz4qvhmIox/kSwJLwFDFEOt
	 L83ygnznR6U2/UJcQVTvOOlXrMcPoTcFpTwHCHf+G5qoUYWKD0VZkBTOwObmRfBjRg
	 pAhiJejHIrPpDsVwzcRb+XZDWj1UXcYwewVnNQUM=
Received: from [192.168.211.39] (192.168.211.39) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 17 Apr 2024 16:06:01 +0300
Message-ID: <dd3781f1-ca7f-4e7f-a7e3-453c8c29573e@paragon-software.com>
Date: Wed, 17 Apr 2024 16:06:01 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 03/11] fs/ntfs3: Mark volume as dirty if xattr is broken
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
Content-Language: en-US
In-Reply-To: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/xattr.c | 17 +++++++++++------
  1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 53e7d1fa036a..872df2197202 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -200,6 +200,7 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, 
char *buffer,
      int err;
      int ea_size;
      size_t ret;
+    u8 name_len;

      err = ntfs_read_ea(ni, &ea_all, 0, &info);
      if (err)
@@ -215,28 +216,32 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, 
char *buffer,
      for (off = 0; off + sizeof(struct EA_FULL) < size; off += ea_size) {
          ea = Add2Ptr(ea_all, off);
          ea_size = unpacked_ea_size(ea);
+        name_len = ea->name_len;

-        if (!ea->name_len)
+        if (!name_len)
              break;

-        if (ea->name_len > ea_size)
+        if (name_len > ea_size) {
+            ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+            err = -EINVAL; /* corrupted fs. */
              break;
+        }

          if (buffer) {
              /* Check if we can use field ea->name */
              if (off + ea_size > size)
                  break;

-            if (ret + ea->name_len + 1 > bytes_per_buffer) {
+            if (ret + name_len + 1 > bytes_per_buffer) {
                  err = -ERANGE;
                  goto out;
              }

-            memcpy(buffer + ret, ea->name, ea->name_len);
-            buffer[ret + ea->name_len] = 0;
+            memcpy(buffer + ret, ea->name, name_len);
+            buffer[ret + name_len] = 0;
          }

-        ret += ea->name_len + 1;
+        ret += name_len + 1;
      }

  out:
-- 
2.34.1


