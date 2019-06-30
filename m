Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6615B010
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 15:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfF3NzP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 09:55:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33170 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfF3NzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:55:12 -0400
Received: by mail-io1-f67.google.com with SMTP id u13so22796152iop.0;
        Sun, 30 Jun 2019 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VUwPM6qkTe20wOn5lPwb0Iqpxbl8HYOZk/dLgRQsZok=;
        b=UTbcCv3+1Anbt3RFhZZFoDpU6Cn4zvq2ROqEF0jiGkEA3cxOFZFkzKlvf1QGaHcrzM
         +lESPAh9+iTNKFZzOhp/XNItqt3BEYwWldOKfvK+ffn95E67LYRiIiKBBBY8SAKVxab+
         ahQHO5hWmxNqcpCIalw5XaQZ4aQX4t+ye+zMkzdRe7hrAwavyaWA14D1G1v2Vr+ngUeC
         dYt7Kzk0Q4NUe7qUjk4WMTaTKkmn7IC892vCJ4CQ5vV4CpKv0YwGkBDusJzaKlIInd8j
         TLgEv5YYrBd8qFnTOonyWzW9RW+MVFGVJVROK6RjNIHdPfh0YbHbX3D7tYsKm3Z2g2p2
         MOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VUwPM6qkTe20wOn5lPwb0Iqpxbl8HYOZk/dLgRQsZok=;
        b=bq9SU9k2hE8kmE14NhX76BGuhnRUMnVh3cn5sorwmg1xnoNrcN4Gifs6BtL1UcOcIB
         eF1kySk0emMvZ+oajvYb9Jn7oSHLkhaFfTfAbsmDvlQiK7vGmc8QWQI6CBgHi+T4tP5v
         WbbcouGKAOsIsJ3r46htIItxRCFEBEra1d1KIKyvU4tG9JwMBGhSazz28HQJAZxwFO1t
         bPplNIlFJnU2bNQL3saupsNljAVLI0tMcbpEZdaw8YK/bs75koutaAXsRF2i71ltpx9x
         DGOnzkdwXhtL+j+rY+xuZrq5ODlafNETpRz+RnzccG0N7tvOfjee5yGOhaDD8SBEzOu/
         l+Aw==
X-Gm-Message-State: APjAAAWS1nL0dsl++n34BYxTbrGRtg/dGKVvvJJ3jmmxctAVGrVlW71H
        PEvnTygliLy7W0uPmjxpgA==
X-Google-Smtp-Source: APXvYqz7D93zyjJjq8CSqPIAmKGw+FrPVnfJ6CuLDBSjp/tQQbzYcN8HVUw3XDH/uMJi7TaTaEdVHA==
X-Received: by 2002:a5d:96cc:: with SMTP id r12mr19149025iol.99.1561902911531;
        Sun, 30 Jun 2019 06:55:11 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id z17sm11930378iol.73.2019.06.30.06.55.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 06:55:10 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/16] nfsd: Fix the documentation for svcxdr_tmpalloc()
Date:   Sun, 30 Jun 2019 09:52:40 -0400
Message-Id: <20190630135240.7490-17-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630135240.7490-16-trond.myklebust@hammerspace.com>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
 <20190630135240.7490-2-trond.myklebust@hammerspace.com>
 <20190630135240.7490-3-trond.myklebust@hammerspace.com>
 <20190630135240.7490-4-trond.myklebust@hammerspace.com>
 <20190630135240.7490-5-trond.myklebust@hammerspace.com>
 <20190630135240.7490-6-trond.myklebust@hammerspace.com>
 <20190630135240.7490-7-trond.myklebust@hammerspace.com>
 <20190630135240.7490-8-trond.myklebust@hammerspace.com>
 <20190630135240.7490-9-trond.myklebust@hammerspace.com>
 <20190630135240.7490-10-trond.myklebust@hammerspace.com>
 <20190630135240.7490-11-trond.myklebust@hammerspace.com>
 <20190630135240.7490-12-trond.myklebust@hammerspace.com>
 <20190630135240.7490-13-trond.myklebust@hammerspace.com>
 <20190630135240.7490-14-trond.myklebust@hammerspace.com>
 <20190630135240.7490-15-trond.myklebust@hammerspace.com>
 <20190630135240.7490-16-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs4xdr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 91e0386fd724..15d031d942cc 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -212,10 +212,10 @@ static int zero_clientid(clientid_t *clid)
 /**
  * svcxdr_tmpalloc - allocate memory to be freed after compound processing
  * @argp: NFSv4 compound argument structure
- * @p: pointer to be freed (with kfree())
+ * @len: length of buffer to allocate
  *
- * Marks @p to be freed when processing the compound operation
- * described in @argp finishes.
+ * Allocates a buffer of size @len to be freed when processing the compound
+ * operation described in @argp finishes.
  */
 static void *
 svcxdr_tmpalloc(struct nfsd4_compoundargs *argp, u32 len)
-- 
2.21.0

