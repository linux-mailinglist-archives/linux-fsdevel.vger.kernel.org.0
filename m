Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0031223AE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 13:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgGQLzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 07:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgGQLzj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:55:39 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D86C08C5CE
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 04:55:38 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n26so10468905ejx.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 04:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=SY5s40KDlTkVmobOCCx6aYJt7MG1YIiLKIV6kOLpFQA=;
        b=OxCuPXgyZIAHVUj+Boo9+0c//JRD/o6zIuuL8L7wQB+y76sO/C6pzBznTpXie+69KA
         xW2lIQK4LckwD0iqD5ynYxiPol4VEtZtNSvM1oZ3Mem+1do2Pk/jQQTarIgfPnsRVAxG
         dv9QyxhuBJtjyTid9qTpeUe5bkxSv3mQ0iNuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SY5s40KDlTkVmobOCCx6aYJt7MG1YIiLKIV6kOLpFQA=;
        b=aTB2pgAnqFL4V3TPxzFXMatafdx8eUru5To/+mOUwghZNYM7RznpbD/9Du61mAcL2A
         ZAXAQKI2sW1Kp9LR73mK2dLBXZkv1Cc7k76jL1OCdRLcA1RkaAf5tITPDQq8Wa4KMTAv
         NEyhaQ7N3nMfO6ADwuXDHBMWtFC4juyF1kTvXPbauZXZb323qH7Sf/mEvuxafxGIRpSv
         YY12ryXNzt8PWJtpAHtGVIR0jTnUrBuQ1c0VnhuzPaJ16aPUUgmP2yhHLr5Mvw+EWX9t
         ZgXCn7NlX3MKYI24tmRbNajNGi2TXlF2PyDRqBILxUmOESKavS+gG1+RhX3ikyIRjxXZ
         2NYA==
X-Gm-Message-State: AOAM531N+An4LuBqjIdi/ziund/Y0HnzYXimIjKSkdpjRQK9XMr4jYJv
        /HFnrkNbFmrYxh1G3rGiv5OX7v62yRT9ZQ==
X-Google-Smtp-Source: ABdhPJySh71wp6796TmdDtBpVZ+KxutnWoBAeRuPzy7j1N2cRKyvxXeJH/RrvQMbTssXQFrRYM9LHA==
X-Received: by 2002:a17:906:af6d:: with SMTP id os13mr7925043ejb.57.1594986937686;
        Fri, 17 Jul 2020 04:55:37 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id u13sm8008061eds.10.2020.07.17.04.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 04:55:37 -0700 (PDT)
Date:   Fri, 17 Jul 2020 13:55:30 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 5.8-rc6
Message-ID: <20200717115237.GD6171@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.8-rc6

Fix the following:

 - a regression introduced in v4.20 in handling a regenerated squashfs
   lower layer

 - two regressions in this cycle, one of which is Oops inducing

 - miscellaneous issues.

Thanks,
Miklos

----------------------------------------------------------------
Amir Goldstein (7):
      ovl: relax WARN_ON() when decoding lower directory file handle
      ovl: fix oops in ovl_indexdir_cleanup() with nfs_export=on
      ovl: fix regression with re-formatted lower squashfs
      ovl: force read-only sb on failure to create index dir
      ovl: fix mount option checks for nfs_export with no upperdir
      ovl: fix unneeded call to ovl_change_flags()
      ovl: fix lookup of indexed hardlinks with metacopy

youngjun (3):
      ovl: inode reference leak in ovl_is_inuse true case.
      ovl: change ovl_copy_up_flags static
      ovl: remove not used argument in ovl_check_origin

---
 Documentation/filesystems/overlayfs.rst |  4 +-
 fs/overlayfs/copy_up.c                  |  2 +-
 fs/overlayfs/export.c                   |  2 +-
 fs/overlayfs/file.c                     | 10 +++--
 fs/overlayfs/namei.c                    | 15 +++----
 fs/overlayfs/overlayfs.h                |  1 -
 fs/overlayfs/super.c                    | 73 ++++++++++++++++++++++-----------
 7 files changed, 65 insertions(+), 42 deletions(-)
