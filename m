Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2968430FA88
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 19:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbhBDSCC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 13:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238714AbhBDSBv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:01:51 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5C6C061788;
        Thu,  4 Feb 2021 10:01:11 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id jj19so6957165ejc.4;
        Thu, 04 Feb 2021 10:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WhDas3aKRKv20DNJUyBwIONOBzhE999JVBpX0AA/vVo=;
        b=P+75rCL+WlRzWz0HkF2wGCC8NYMK3eVGzDr8SbGvgo3wLOOI3pdrwlveEJ1R/YW0ur
         VpEzzdJR0GVC0G0gv8BON+BPHw1XQyyOXIVfcVhi+X7LGQ6TCBSaJzeytcMcRPQGbAZv
         K259BpixQkYCng1io2DDSzd91T5T2JyUdqKuSoU8B4kZhoDYVOzFR7qqFgx8KWpz2/8v
         WLwGIY6apiJc5zdRnxmwozzsILJ++B+5c/WMA1yWP71OTjLUgt4gvVc69rJE+MoSoKYf
         YQCwiPw8fNSofT7aVxgmk1AW+9Mk9avNZlMycqUOEGf4KZbDBtOyg8zPMJlQwvVCv50E
         PyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WhDas3aKRKv20DNJUyBwIONOBzhE999JVBpX0AA/vVo=;
        b=Hbwoq3BeANqjo6XL4HG3oFJbjketekwpBMhgaOpdKNR/0H1Gkz39J0MT/IYVVBXASA
         NsJPOxZ/5uQpeAGfbor6LHjQ1oOBK3N/OzREGmEtpA3Pe3dnVeju4fPw45GUiQoM1ezJ
         P/d+gkEJoHssqnpsFmWPiwHW0Xaeb6x+zZ4YhR6X/2dKPWIB2WKdKcwvB8z9CnIerThf
         wjsPdvxPOlTGAmSVAX+pfIvSTvgAGdIWiHS92KULfm+884GGRH3fea+nTebXI0Q3TThE
         eakHq2nNvLHoPQQYDAmtTE/9el2fdL4OaGMXhpCD829vXQzNwg/Jp7wAeENFcYoser7O
         msxA==
X-Gm-Message-State: AOAM533V9vAfbacTglVCAcB01DNmE5mw2u02JWt1KVGgbM4hXz2ezFtD
        ZvSFDS6X/vFDfJjn/2RnDuA=
X-Google-Smtp-Source: ABdhPJwmqNbYdlXjgmFdZ+areF5rOutBWVPEgvOuZK3MiGmTWbNKZFhWNQ2WhcrOtOB+ZhqAINLZCA==
X-Received: by 2002:a17:906:3719:: with SMTP id d25mr319155ejc.256.1612461670229;
        Thu, 04 Feb 2021 10:01:10 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2de7:9900:24e0:4d40:c49:5282])
        by smtp.gmail.com with ESMTPSA id bo24sm2810326edb.51.2021.02.04.10.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 10:01:09 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 0/5] kernel-doc fixes to latest fs changes
Date:   Thu,  4 Feb 2021 19:00:54 +0100
Message-Id: <20210204180059.28360-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

this patchset was motivated by new warnings with make htmldocs appearing on
linux-next in the last week.

Please apply this on top of your latest work in fs on top of the mount user
namespace refactoring, cf. the commits referred in the individual commit
messages.


Lukas Bulwahn (5):
  fs: turn some comments into kernel-doc
  fs: update kernel-doc for vfs_rename()
  fs: update kernel-doc for may_create_in_sticky()
  fs: update kernel-doc for vfs_tmpfile()
  fs: update kernel-doc for new mnt_userns argument

 fs/libfs.c         |  1 +
 fs/namei.c         | 13 ++-----------
 fs/xattr.c         |  2 ++
 include/linux/fs.h | 17 ++++++++++++++---
 4 files changed, 19 insertions(+), 14 deletions(-)

-- 
2.17.1

