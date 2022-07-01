Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681EE563A6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 22:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiGAUJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 16:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGAUJf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:09:35 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C9D4F1A9
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 13:09:34 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x20so3332581plx.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Jul 2022 13:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:cc:content-transfer-encoding;
        bh=i4eBf8QzgrUAcKJOsdrILLymAY2ZGGowAjTdtC1Ewic=;
        b=n8rwlNl7yVvtBGYYrSRwjN4s03X9LxLmi9Xwi3OHVifaQDN1ANKYzkLyQZ6TW+N/00
         rk9t04Q/rvDJp7k4/g9Y4maogVrMPOh2/XEJb5j+2IxCnePgnG5ArfFJvI2HnmHJwXg3
         NHA8mGm3KWV1gSbnDLC0WnGgh4qnDO6W8ZSRPoUs/wNSpObExR/7R7psRdkX3DZ7I5RP
         h13sEQLZLS1muIcFF7iMAAOoxmpA7PjixT128jeL0o5AxAa8vhSUPjIUJrs+YqTpjVRj
         SF/Hn67bR9GPzYzdbs+REwHjOStCF3OTJtXwaJCnIitbyNnAMtJyij3jpVQG9FPvF/KC
         JSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:cc:content-transfer-encoding;
        bh=i4eBf8QzgrUAcKJOsdrILLymAY2ZGGowAjTdtC1Ewic=;
        b=IWsmRt9luhnRld40UQMN3V0NlhbwDMly06WbNB+PIJ3zHTdUqMkT9mQWqxGGMYHE/d
         +BilEFQPF9pCIzSB/3Q23WzBuvilL9VcHJgjFdKzwQxzGfwTjgNIfyaQEfwRC4R0HZ9L
         piD0nZ3BtgtanSx/dX9vQTebqY8qjHPSUqkZo933uYI2SmrzFfzjn/z2pV5cktQzpuaU
         OLFG2WZceS+pKnOPnk+yy0HDzCghmfZW0fl7N9Nb59s2ezFuF3aKazSoA/td+qzSAm6L
         i0HoIc7Vb1VrqE58XqxCgbvB/gtZk9vaSdMyiQAZrcwZ2LQYxZeF3KcDqWvBWwqGaVAe
         221A==
X-Gm-Message-State: AJIora/I1j/ni+fWAfc70HeM+m4e2ifpr7aArvg5f1s4823hwdl7xymE
        JBZFOvP9yC/Hv7XKnT+nWcnpXa52/6Qd/Q==
X-Google-Smtp-Source: AGRyM1tNeBb6kHCkXQn8eNioVdfnfp4o1rOZBAajG2dFOIqsuDKczXB+ZZBJPxrJF2s/BgbxV4F9LA==
X-Received: by 2002:a17:902:ac90:b0:16a:1c0d:b586 with SMTP id h16-20020a170902ac9000b0016a1c0db586mr22762830plr.155.1656706174015;
        Fri, 01 Jul 2022 13:09:34 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a25-20020aa79719000000b0052551c1a413sm16123803pfg.204.2022.07.01.13.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 13:09:33 -0700 (PDT)
Message-ID: <39f8b446-dce3-373f-eb86-e3333b31122c@kernel.dk>
Date:   Fri, 1 Jul 2022 14:09:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] fs: allow inode time modification with IOCB_NOWAIT
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc:     Stefan Roesch <shr@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

generic/471 complains because it expects any write done with RWF_NOWAIT
to succeed as long as the blocks for the write are already instantiated.
This isn't necessarily a correct assumption, as there are other conditions
that can cause an RWF_NOWAIT write to fail with -EAGAIN even if the range
is already there.

Since the risk of blocking off this path is minor, just allow inode
time updates with IOCB_NOWAIT set. Then we can later decide if we should
catch this further down the stack.

Fixes: 4faa13bd5d3b ("fs: Add async write file modification handling.")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 259ebf438893..98a48fbfa0ad 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2150,8 +2150,6 @@ static int file_modified_flags(struct file *file, int flags)
 	ret = inode_needs_update_time(inode, &now);
 	if (ret <= 0)
 		return ret;
-	if (flags & IOCB_NOWAIT)
-		return -EAGAIN;
 
 	return __file_update_time(file, &now, ret);
 }
-- 
2.35.1

-- 
Jens Axboe

