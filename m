Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C28E590E62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 11:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbiHLJsD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 05:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbiHLJr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:47:56 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB35CAA4C8
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Aug 2022 02:47:55 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a8so519875pjg.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Aug 2022 02:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=pEbCgyPCcR0Yncdt6vZqilvmKfzW6PUnw5i5AvY2i20=;
        b=EH4YAIAJnBpxEXITpDGwYHP5+qDwv/Lu5CoVvy5LZj7fnpHeKTTei3PO5SNXcMT/6u
         VopNWCqVChDKnijTb1jUPVr/xuT8frurFGeMEV0N37m9livEewJmzAiRKAOtJ8/yG+tU
         ll6YcakEpi37X6b3dx5fsa0QyGpvJV5N/U1/zRxA7IM3yZgSHN1JJjOvl4+kF0aBPgwk
         Ty4x5k+buCx+AOX/U8FxmSchA5FwZ2cjfD3fGwbwl8w5b1wtDbwf+lgUay5vDIV51NND
         HlwmLKcJs97G/taTd5draY1yBLtWNH4ceyDyBSCKZC8PwNgmiTrmlx8p+2a5WV67ViCP
         j1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=pEbCgyPCcR0Yncdt6vZqilvmKfzW6PUnw5i5AvY2i20=;
        b=bznOaCDkYQCwnlmbxmx/DSFwlZ9A9G6gYupss8rTEIW57QJVjIZ6AaewGmGAD3Zqfq
         L/TK7bN8tXltA0dJSOq6r/fE9dyM1+Kaiib8fzRmns8EOw8wc3uyMi7tCkkcREyLK18C
         pQpxheU3YGb2CR70cPAl43V0DYHXQwZjT4PoCbYyCY5QJcPCvB6189l7OLMBs0uCqTgJ
         T0K0YwVLzyroPTVDcrDPraztPUuPLS5StUggG2dVvbx3W5pxl34RGVrCR/z+TQxeQKta
         z2aa0sN5JWWmklvhC05+oLunu0mSkVXjG1GOwegWTF0NyIA3x7fTtn6gn2w2a4pTIT5k
         NG6w==
X-Gm-Message-State: ACgBeo0G7sc/SuEwHQZU/rMF335ZDzF44fjkxgFDdFGuFHfMLhdVjIUE
        VkkzveQOqvqiI4Lque3A/yo=
X-Google-Smtp-Source: AA6agR6/fK+otVpB3L1l9YP0pjx438pDwRA7qs/O7mwYCTwkcEVUf2yuFSQqucHwVPFd9F+mWDLf9A==
X-Received: by 2002:a17:903:244c:b0:16e:fa53:a54c with SMTP id l12-20020a170903244c00b0016efa53a54cmr3213438pls.46.1660297675274;
        Fri, 12 Aug 2022 02:47:55 -0700 (PDT)
Received: from autolfshost ([2409:4041:e93:d6ef:7c5:6a30:ff53:3228])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903120900b0016cf3f124e5sm1268557plh.131.2022.08.12.02.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 02:47:54 -0700 (PDT)
Date:   Fri, 12 Aug 2022 15:17:36 +0530
From:   Anup K Parikh <parikhanupk.foss@gmail.com>
To:     rdunlap@infradead.org, skhan@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] Doc fix for dget_dlock and dget
Message-ID: <YvYhuH66yfoi8Zxy@autolfshost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

1. Remove a warning for dget_dlock

2. Add a similar comment for dget and
   add difference between dget and dget_dlock
   as suggested by Mr. Randy Dunlap

Signed-off-by: Anup K Parikh <parikhanupk.foss@gmail.com>
---
 include/linux/dcache.h | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index f5bba5148..c7742006a 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -297,12 +297,15 @@ extern char *dentry_path(const struct dentry *, char *, int);
 /* Allocation counts.. */
 
 /**
- *	dget, dget_dlock -	get a reference to a dentry
- *	@dentry: dentry to get a reference to
+ * dget_dlock - get a reference to a dentry
+ * @dentry: dentry to get a reference to
  *
- *	Given a dentry or %NULL pointer increment the reference count
- *	if appropriate and return the dentry. A dentry will not be 
- *	destroyed when it has references.
+ * Given a dentry or %NULL pointer increment the reference count
+ * if appropriate and return the dentry. A dentry will not be
+ * destroyed when it has references.
+ *
+ * The reference count increment in this function is not atomic.
+ * Consider dget() if atomicity is required.
  */
 static inline struct dentry *dget_dlock(struct dentry *dentry)
 {
@@ -311,6 +314,17 @@ static inline struct dentry *dget_dlock(struct dentry *dentry)
 	return dentry;
 }
 
+/**
+ * dget - get a reference to a dentry
+ * @dentry: dentry to get a reference to
+ *
+ * Given a dentry or %NULL pointer increment the reference count
+ * if appropriate and return the dentry. A dentry will not be
+ * destroyed when it has references.
+ *
+ * This function atomically increments the reference count.
+ * Consider dget_dlock() if atomicity is not required or manually managed.
+ */
 static inline struct dentry *dget(struct dentry *dentry)
 {
 	if (dentry)
-- 
2.35.1

