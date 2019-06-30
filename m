Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B4E5B00C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 15:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfF3NzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 09:55:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43651 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfF3NzL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:55:11 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so22674815ios.10;
        Sun, 30 Jun 2019 06:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7zMd74bx/Xv7Zo5LdqAAYGmxxP86dBYLwSFhXla2k0=;
        b=cpemW+jE3e178p22/H+i7g/JuqMcfZ6eaQcOnkyduHjBnXtPPMw+US65sXF2jC68o2
         ac6qVvfGaQAleA0e40/4yiNZdYAGUMAgE3l4CJBGMlEmsat+a2Rz+L5F34zjiotyihWm
         NcCqnXZPevoW1pEJlIP7PItqc8uWWyhZx3AGbBJK6RPbDFZKB4fet0JJxqni6hCYMXTR
         PYlvf4aBPG+g49H+hvKzUj4RTlU3mLInRznLMOEBZ0/eYb3WFdv0zftjdB8VRZM5JW7e
         +5sKEH5SrHllyu67/KT8NBI3Lott7Q1GQE319If7zHtDIdwzW5sbAe6a7ZawpBJFzhTa
         5t3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7zMd74bx/Xv7Zo5LdqAAYGmxxP86dBYLwSFhXla2k0=;
        b=PiKQG6U4FnlLWqB4/wD0rhHoyplkPRhGqY+bTbprAuDwhHMPz7Qdy5iVivWQ1/zLZ/
         q/g35qsB31GM9Le//dRNvOVgBL5tRr8FnAZpI4pMbJ8o3GzwFavhHcAXVJjzGpRDykTg
         v3riDf7eEtKOddYZ3g05nG1q46ghWzpDaUw78hD6Yc5yIVMuL777ijP1d5YNdz1tD4aO
         BEAe0i3dNuAGy44nlLmORSKPKFTCDAYELhZJIes9B0POKtbyhsvd1RWi3DdTZuirQM7Y
         SCKYcGix8EJotKXw6Q83AP5LHDdv2rITeoWMMQy6DQs+ti5doMXnu285fXFNNZiZhwRY
         R+9A==
X-Gm-Message-State: APjAAAXRz0Xwfn3nDMxIAtjfGCWOrKW5UV4hZK0yfcLRKQu8nYQnfGjJ
        4w9u2eOjus/R8nraOUx4LA==
X-Google-Smtp-Source: APXvYqyUJdKamF/PYeWSYcxbDJX5H1HYb2xAkKbwvSyOTG8IbofYpvFnHLN7NN8doDmwXE7+MXGFZg==
X-Received: by 2002:a6b:fb10:: with SMTP id h16mr238711iog.195.1561902910221;
        Sun, 30 Jun 2019 06:55:10 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id z17sm11930378iol.73.2019.06.30.06.55.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 06:55:09 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/16] nfsd: Fix up some unused variable warnings
Date:   Sun, 30 Jun 2019 09:52:39 -0400
Message-Id: <20190630135240.7490-16-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630135240.7490-15-trond.myklebust@hammerspace.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs4xdr.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 80bace0271bb..91e0386fd724 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1431,7 +1431,6 @@ nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 			    struct nfsd4_create_session *sess)
 {
 	DECODE_HEAD;
-	u32 dummy;
 
 	READ_BUF(16);
 	COPYMEM(&sess->clientid, 8);
@@ -1440,7 +1439,7 @@ nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 
 	/* Fore channel attrs */
 	READ_BUF(28);
-	dummy = be32_to_cpup(p++); /* headerpadsz is always 0 */
+	p++; /* headerpadsz is always 0 */
 	sess->fore_channel.maxreq_sz = be32_to_cpup(p++);
 	sess->fore_channel.maxresp_sz = be32_to_cpup(p++);
 	sess->fore_channel.maxresp_cached = be32_to_cpup(p++);
@@ -1457,7 +1456,7 @@ nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 
 	/* Back channel attrs */
 	READ_BUF(28);
-	dummy = be32_to_cpup(p++); /* headerpadsz is always 0 */
+	p++; /* headerpadsz is always 0 */
 	sess->back_channel.maxreq_sz = be32_to_cpup(p++);
 	sess->back_channel.maxresp_sz = be32_to_cpup(p++);
 	sess->back_channel.maxresp_cached = be32_to_cpup(p++);
@@ -1749,7 +1748,6 @@ static __be32
 nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 {
 	DECODE_HEAD;
-	unsigned int tmp;
 
 	status = nfsd4_decode_stateid(argp, &copy->cp_src_stateid);
 	if (status)
@@ -1764,7 +1762,7 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 	p = xdr_decode_hyper(p, &copy->cp_count);
 	p++; /* ca_consecutive: we always do consecutive copies */
 	copy->cp_synchronous = be32_to_cpup(p++);
-	tmp = be32_to_cpup(p); /* Source server list not supported */
+	/* tmp = be32_to_cpup(p); Source server list not supported */
 
 	DECODE_TAIL;
 }
@@ -3230,9 +3228,8 @@ nfsd4_encode_create(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_
 	if (!p)
 		return nfserr_resource;
 	encode_cinfo(p, &create->cr_cinfo);
-	nfserr = nfsd4_encode_bitmap(xdr, create->cr_bmval[0],
+	return nfsd4_encode_bitmap(xdr, create->cr_bmval[0],
 			create->cr_bmval[1], create->cr_bmval[2]);
-	return 0;
 }
 
 static __be32
-- 
2.21.0

