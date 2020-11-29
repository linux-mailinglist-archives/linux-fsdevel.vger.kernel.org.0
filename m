Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCAE2C7788
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Nov 2020 05:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgK2Eh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 23:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgK2Eh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 23:37:29 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22657C0613D4
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2020 20:36:43 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id i7so1966121oot.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2020 20:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EAojnF4t5DRg2ANKGYyPD+m7P2SzoKfdrt8RRTLUrjc=;
        b=i937HvJCOE5kRkQVkNmOI1nqD+BtqUVKfm5rxTmdUXbOXHdgZhYMhBw7uxmWPZ6Iah
         wUr3KvvWpfziaVHX3Cj7DE7nTgGKXZlHgEzwnISt8be7m66WNjuePgVx4lJuA+L2/UO+
         yIOAruGI/UnyItFfYzWg14NDeebg3nBmflyZfVE0HV7bi72ocFYiqj8iNydnCS3F5o3g
         BV3OrixKnMla4Wa61fiAcHxrkzCapPFh9DUZhCungqcTuzFPzZYCX/pYAlsyyBjYptk4
         fjzPS+q+1FPlICGC7zuP9HtqPbC4NAXagLovl1McAQ50KC7whmgNstBLNcB05OL59/f9
         oJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EAojnF4t5DRg2ANKGYyPD+m7P2SzoKfdrt8RRTLUrjc=;
        b=f8YmrjAzZ59lF9BPc5C1Ly2TqT2/o4HZZxtFv7fSg0iG3qozIb3vqIpCNnZ+gbSg+l
         ZQIgTQF795HxZ6y9V3xUPwV3IhczoV6AW0Im81dun9wDQfPtYZfG4H6Z4B1ryjoYCPXY
         U7pQPIWt/NoHNUluBSaDltMwQKae6QwHofCViO/tX1pRnV3URLsE2h6GKQsqVjBP7ThC
         IG9kH82aaDNkuGRSnLPu5OOpDTiMEZOyaFK02a3At2NHX5+7HZ96TXk+bipS1YIlgmoE
         82+anuxAXBAWdKdvdUIwcRYAE+jHKTMn79N/xzr7I/6/8W0ZFXHXqG7A97UlmZRT4BkW
         c4EA==
X-Gm-Message-State: AOAM533cdFihkV00Qnd39lnkWSH6mBMRUJkttKGbSuBvYg/QQ36OJ8WZ
        Kn4RpvbKuWbSlMQfuROrHibT/cg3DDmCRJEPuNtqHYxPPtyC4A==
X-Google-Smtp-Source: ABdhPJyK3VgPYV3WHp6k8LdcP+3Vb/uyGiAuqsVI5MeqbR5ow0ZRhcZG9DKyGDv0+0/kaFFBTsAUSJgwiysbTBuIK04=
X-Received: by 2002:a4a:4e87:: with SMTP id r129mr11050293ooa.4.1606624602474;
 Sat, 28 Nov 2020 20:36:42 -0800 (PST)
MIME-Version: 1.0
From:   Amy Parker <enbyamy@gmail.com>
Date:   Sat, 28 Nov 2020 20:36:32 -0800
Message-ID: <CAE1WUT5HT4oZkWw87ADw53AOSygkZKEzF00joe+ZXq=mKH-fiw@mail.gmail.com>
Subject: [RFC PATCH 3/3] fs: dax.c: correct terminology used in DAX bit definitions
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     dan.j.williams@intel.com, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DAX_ZERO_ENTRY is no longer the bit for zero entries - XA_ZERO_ENTRY is.
The documentation above should be accurate to the definitions used accordingly.

Signed-off-by: Amy Parker <enbyamy@gmail.com>
---
 fs/dax.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index c2bdccef3140..ec23a4f9edd5 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -66,13 +66,13 @@ fs_initcall(init_dax_wait_table);

 /*
  * DAX pagecache entries use XArray value entries so they can't be mistaken
- * for pages.  We use one bit for locking, one bit for the entry size (PMD)
- * and two more to tell us if the entry is a zero page or an empty entry that
- * is just used for locking.  In total four special bits.
+ * for pages.  We use one bit for locking, one bit for the entry size (PMD),
+ * and one to tell if the entry is an empty entry just for locking. We use
+ * XArray's ZERO_ENTRY to tell us if the entry is a zero page.
  *
- * If the PMD bit isn't set the entry has size PAGE_SIZE, and if the ZERO_PAGE
- * and EMPTY bits aren't set the entry is a normal DAX entry with a filesystem
- * block allocation.
+ * If the PMD bit isn't set the entry has size PAGE_SIZE, and if the EMPTY
+ * and ZERO_ENTRY bits aren't set the entry is a normal DAX entry with a
+ * filesystem block allocation.
  */
 #define DAX_SHIFT    (4)
 #define DAX_LOCKED    (1UL << 0)
-- 
2.29.2
