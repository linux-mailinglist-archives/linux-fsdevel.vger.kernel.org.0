Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC6130FA94
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 19:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbhBDSCr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 13:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbhBDSCD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:02:03 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B33C061797;
        Thu,  4 Feb 2021 10:01:21 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id hs11so7005221ejc.1;
        Thu, 04 Feb 2021 10:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4vEWKfVyXddEcmIwDsmAMioH5pXqruvacKLPcoG5Ql8=;
        b=DWmB6ieI5TAKfC4FmpwtrQYz0GP9IVExbX63XNlLVwCureeQ7SIvmaBWUxuwL049QH
         3DVhZ2Roz0DO8jZZW8prH/hYpKKJl7Q051TL4BbzZJO009KV1mr7VkTNx+erUwNxVvoa
         WQ7T3ntGrenStGHyVL/+VmYzZdqdp2SbbYhAWDO66nN2rkU4kXJr/WKlk/mp8TM8XRus
         xkYyZN7T5sRVDr44r1vtFQWAs9eiy2pZRvLddXnw00Skw9crkuplGJciZR122ACpRoJf
         UVMDMpSEZ+SC/69TySz/Xj5sFx+FWyuFC0WTC+TDdIazDSSuwf4HEpiifLmc1VyaVrZT
         Ch1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4vEWKfVyXddEcmIwDsmAMioH5pXqruvacKLPcoG5Ql8=;
        b=ZTUfjlOI62mlS8swrsvXBXJwERSM5I87VxIjw0UJfSLX4+SDl+rNjfVD5nmcNpH8jx
         3kXQ/aW49uHiWYOxsYoZkKMPSMheTvkEj6cn/Jjm25YpGANg0vvn9e/T5K81iGVPvWrm
         NVKE7+0EWlFy3BuWqrcPxuHJdD8BYTc6YPUvryCujzf1A+wNISW7ySLQxYtK8egEDU4v
         DTtI0szuqnGI8RulgiD0gM5teeh5PlBn4L8ObdNEJoZ8b2TCMHNSC6MIg2EYABVIvL7s
         ON+BNz1Gjj1kFTdkw9TBpDT83rTuvPzNTHyE1LVlrXw0P9Y4pnpejMkGlKqQHAxOY+gZ
         75uA==
X-Gm-Message-State: AOAM5317rJ1b4UB4LSt/CblmX+W9AjRDJzi3MwEs4ARk8Da9C5NAQxDp
        LkovSBjR5Euyso8ZP/S5Bkw=
X-Google-Smtp-Source: ABdhPJxYmSDdOZHPbd04k+tJrMjysRmLhzuKeHh+bt3SQ25rGeflDROeQUkt9lnWZ4CYb0UCvzu3Rg==
X-Received: by 2002:a17:906:2747:: with SMTP id a7mr320988ejd.250.1612461679846;
        Thu, 04 Feb 2021 10:01:19 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2de7:9900:24e0:4d40:c49:5282])
        by smtp.gmail.com with ESMTPSA id bo24sm2810326edb.51.2021.02.04.10.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 10:01:19 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 3/5] fs: update kernel-doc for may_create_in_sticky()
Date:   Thu,  4 Feb 2021 19:00:57 +0100
Message-Id: <20210204180059.28360-4-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204180059.28360-1-lukas.bulwahn@gmail.com>
References: <20210204180059.28360-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit ba73d98745be ("namei: handle idmapped mounts in may_*() helpers")
refactors may_create_in_sticky(), adds kernel-doc for the new argument,
but missed to drop the kernel-doc for the removed arguments.

Hence, make htmldocs warns on ./fs/namei.c:1149:

  warning: Excess function parameter 'dir_mode' description in 'may_create_in_sticky'
  warning: Excess function parameter 'dir_uid' description in 'may_create_in_sticky'

Drop removed arguments from kernel-doc of may_create_in_sticky().

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 fs/namei.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 98ea56ebcaf0..64a841dfbb3e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1121,8 +1121,6 @@ int may_linkat(struct user_namespace *mnt_userns, struct path *link)
  *			  should be allowed, or not, on files that already
  *			  exist.
  * @mnt_userns:	user namespace of the mount the inode was found from
- * @dir_mode: mode bits of directory
- * @dir_uid: owner of directory
  * @inode: the inode of the file to open
  *
  * Block an O_CREAT open of a FIFO (or a regular file) when:
-- 
2.17.1

