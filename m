Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB2B6094CD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Oct 2022 18:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiJWQmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 12:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJWQmR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:42:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095A130F7A;
        Sun, 23 Oct 2022 09:42:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so1650133pji.0;
        Sun, 23 Oct 2022 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/JN3nDWwlvz0zr+zWQj4q64audZwnviw+yHCDgZXPo=;
        b=gZsn90LXl5nV61F9U0RAcTQqSQZdYebM2knsbimY3UTaxWa5vVVyv5Nk2qgPQ22FBc
         R3+gW5rWNzdCx3xJ8nDUsQJCwpWKlLcPAk7rlAoMMIo92R4T+Z0iTtqBop0YDAWHs9uK
         2tan3wUNJhE0AA84wdSBWgHglSZuhsKsdV24N1z/dVDwodFJUJJohTdTb10aZ3q7kyzO
         HN8qm+ZCa2pmsgf1LrSkVov9bijdkrdeRB0k9Uia8aPI/O6KNyjbly4gzuWnPv9ZB2bF
         7ATVOQvh2cDtNLGkksEIYvsD7ENevD2AoUF08EZmvjHvK7eTsNXc9avLnmyMo0JJomzs
         onjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/JN3nDWwlvz0zr+zWQj4q64audZwnviw+yHCDgZXPo=;
        b=kTfl7I6DZkaUDpwh1ZHpudf8xmU4sVgiaaqKz2D108AxcV0O0tKm+jIngfO8IGpH7P
         /Ji8LZMgT1v5IC5LJ/EcMtr2AfQxejZur7VDmRGyT9XYLUwIkqh73WY+rS/ZuSwTy/Vq
         VqJkZRbffMI29aoi8Lt/35z4RTBYHFVfaZDbaDGRIPW7ZDU/10hNHUjvUrqVDX2Hhxcr
         DTQRqBHwXUkPnkbvH/ZnCTYvWpszDxmEF5Ys1XeGyCur/0IE46AqW0ZrSEIrAkK6pH4Q
         cw/7cwb78XmVHk1W/ZTo4XX0HXT6zjD7aZRHKsLj2UQR84j43qkeoU4m4ILuDayQl/XG
         EmYQ==
X-Gm-Message-State: ACrzQf3aTw9uhw+F9DoOn5itSi565IL5CbP8reuIlcOo+SMdGzT+NJuh
        9FtgPNV4ePV5911pbu6ItQo=
X-Google-Smtp-Source: AMsMyM5zNx6aq+Gv68lpF7ZJA9MebNHteDpkuxTUQkSuQuvYV7T9nBmrooZ0dTjV6fKFMK4f9zkD9Q==
X-Received: by 2002:a17:90b:38d1:b0:20d:8f2a:c4c4 with SMTP id nn17-20020a17090b38d100b0020d8f2ac4c4mr67611720pjb.192.1666543336554;
        Sun, 23 Oct 2022 09:42:16 -0700 (PDT)
Received: from localhost ([223.104.41.250])
        by smtp.gmail.com with ESMTPSA id y199-20020a6264d0000000b0056b9a740ec2sm2259225pfb.156.2022.10.23.09.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 09:42:16 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     yin31149@gmail.com, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     18801353760@163.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: [PATCH -next 3/5] ceph: fix possible null-ptr-deref when parsing param
Date:   Mon, 24 Oct 2022 00:39:47 +0800
Message-Id: <20221023163945.39920-4-yin31149@gmail.com>
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

Yet the problem is that, ceph_parse_mount_param() will dereferences the
param->string, without checking whether it is a null pointer, which may
trigger a null-ptr-deref bug.

This patch solves it by adding sanity check on param->string
in ceph_parse_mount_param().

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 fs/ceph/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 3fc48b43cab0..341e23fe29eb 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -417,6 +417,9 @@ static int ceph_parse_mount_param(struct fs_context *fc,
 		param->string = NULL;
 		break;
 	case Opt_mds_namespace:
+		if (!param->string)
+			return invalfc(fc, "Bad value '%s' for mount option '%s'\n",
+				       param->string, param->key);
 		if (!namespace_equals(fsopt, param->string, strlen(param->string)))
 			return invalfc(fc, "Mismatching mds_namespace");
 		kfree(fsopt->mds_namespace);
-- 
2.25.1

