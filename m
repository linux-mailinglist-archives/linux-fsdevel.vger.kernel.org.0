Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993FB6094D2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Oct 2022 18:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiJWQnC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 12:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJWQm5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:42:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A478B7287D;
        Sun, 23 Oct 2022 09:42:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id i3-20020a17090a3d8300b00212cf2e2af9so6111390pjc.1;
        Sun, 23 Oct 2022 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FA3CfjwFWzAnFbI8NyRJA0/XOu8yldPHiMeYItKgCg=;
        b=WZP8Cgm6X9azLSrPQ0HfKLqBJx6cVZQTs6bFNuPdAPDFm+wb2k0DxmDjIXLvbCVD2M
         TzCZ2ZDyGjj5RKoDyRP5qaS+p2RkFeU9q480aQCim/cG39I+0ke181O26mAEaV/5tmtt
         97q+H6+pEVdIUo9jlXSi8pC7MpzCHb8gR0KwY04HBIEZLG1YkCafnRzlqypz4AE2eOoB
         nCiVUfKe993XIUA31VDPfKURNOmX7sme/Vv6jieFtFPhLWvo7tNWSvPEXFmCEHFYjlFI
         P9UZcExgtnoYgC1P2Vgvp6cD1szLzzuP24KDCyCN8BjN+n4RlAM1X9dcz91fJqKl+k1B
         /s+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FA3CfjwFWzAnFbI8NyRJA0/XOu8yldPHiMeYItKgCg=;
        b=dqA8FgiIm7gG91ntZsY2wuOkgAElJlUNmAyT50im0AoVL/qQ7NUHGUtj593Of++yCO
         ug3FqlB/77PQWK+pv+kTLwSFSS28OSSpq8N0QMf/VdzjNgC8cfORKWnEsgMzqhVvX1vt
         TWZyJZmonSTa81tGhzLohJIjwKBSZiUk9nC/+fW8IOODk4xH6upN0qt+ckDi7u/0mx2P
         L97NmygVByHKCqK4yt17KBxlwduv/hyJ/ZaZoLFAdWhfd0ljHZSDn1q4a2pNC7Iku7vT
         Tqym3avT+2OMfYPKm9AaYOJSi+8ifQVhg90uZJJDuCWXKMrZKcDdx+27IiBVbqlUU02E
         47OA==
X-Gm-Message-State: ACrzQf2gTGMlkfjlfPIC727d3C+kjMCAh6mpbvToj3ejzdziJ0zZ0IbJ
        8Bd6SuOLb7MVe32uwkNamBI=
X-Google-Smtp-Source: AMsMyM40fDEaMu1U8tJRTMY+sHRA0xmLSZnl9K9jBoNEYmEqS9JOVVwXD5ULmpHw6bBd6ChXhql8sQ==
X-Received: by 2002:a17:90b:2241:b0:20d:b273:26af with SMTP id hk1-20020a17090b224100b0020db27326afmr32726399pjb.245.1666543372029;
        Sun, 23 Oct 2022 09:42:52 -0700 (PDT)
Received: from localhost ([223.104.41.250])
        by smtp.gmail.com with ESMTPSA id l14-20020a65560e000000b004411a054d2dsm16327345pgs.82.2022.10.23.09.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 09:42:51 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     yin31149@gmail.com, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     18801353760@163.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        syzbot+da97a57c5b742d05db51@syzkaller.appspotmail.com,
        cluster-devel@redhat.com, syzkaller-bugs@googlegroups.com
Subject: [PATCH -next 4/5] gfs2: fix possible null-ptr-deref when parsing param
Date:   Mon, 24 Oct 2022 00:39:49 +0800
Message-Id: <20221023163945.39920-5-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221023163945.39920-1-yin31149@gmail.com>
References: <20221023163945.39920-1-yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

According to commit "vfs: parse: deal with zero length string value",
kernel will set the param->string to null pointer in vfs_parse_fs_string()
if fs string has zero length.

Yet the problem is that, gfs2_parse_param() will dereferences the
param->string, without checking whether it is a null pointer, which may
trigger a null-ptr-deref bug.

This patch solves it by adding sanity check on param->string
in gfs2_parse_param().

Reported-by: syzbot+da97a57c5b742d05db51@syzkaller.appspotmail.com
Tested-by: syzbot+da97a57c5b742d05db51@syzkaller.appspotmail.com
Cc: agruenba@redhat.com
Cc: cluster-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
Cc: rpeterso@redhat.com
Cc: syzkaller-bugs@googlegroups.com
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 fs/gfs2/ops_fstype.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index c0cf1d2d0ef5..934746f18c25 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1446,12 +1446,18 @@ static int gfs2_parse_param(struct fs_context *fc, struct fs_parameter *param)
 
 	switch (o) {
 	case Opt_lockproto:
+		if (!param->string)
+			goto bad_val;
 		strscpy(args->ar_lockproto, param->string, GFS2_LOCKNAME_LEN);
 		break;
 	case Opt_locktable:
+		if (!param->string)
+			goto bad_val;
 		strscpy(args->ar_locktable, param->string, GFS2_LOCKNAME_LEN);
 		break;
 	case Opt_hostdata:
+		if (!param->string)
+			goto bad_val;
 		strscpy(args->ar_hostdata, param->string, GFS2_LOCKNAME_LEN);
 		break;
 	case Opt_spectator:
@@ -1535,6 +1541,10 @@ static int gfs2_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		return invalfc(fc, "invalid mount option: %s", param->key);
 	}
 	return 0;
+
+bad_val:
+	return invalfc(fc, "Bad value '%s' for mount option '%s'\n",
+		       param->string, param->key);
 }
 
 static int gfs2_reconfigure(struct fs_context *fc)
-- 
2.25.1

