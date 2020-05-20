Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954B91DB692
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 16:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgETOZp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 10:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbgETOZl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 10:25:41 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1675C05BD43
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2020 07:25:40 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l5so3244734edn.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2020 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wMA33dnba4I1xySChm1PiZx/HzxTpqEY+2IJD7PaIUo=;
        b=UXPruK/n94mCL0Cf+r1Ubc53NG+qGqAjJZ3m1rxiheqyt+TgR43B2MZbM3G5oGBvzH
         AOmqtTnWkh5iqqbiEkcBoF/eGI9s12ijRF5DSEFdXYqldqojRK/RtnCu58WVNOX+2pRm
         wgliTMuFTtUZrWBUOF9mxC0NFJq5ZwsahXtew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wMA33dnba4I1xySChm1PiZx/HzxTpqEY+2IJD7PaIUo=;
        b=Nf6UkS3/Eo44YuPo3PCYRZi2UbG2xnh6z2DKTQtwwsjtjHcJ48+IzcWJhJmrhFcym/
         ZIkj77A9ekM6mIl9yLZ8jcCQAnIgVFQTxrc3A3u0wZSkOpaASu9quqicibSxWuByuc9B
         s2Q39HA3VHkKr6T6JOF54MmQwqcwt/Nw4rb3gsKTxYsMfmSQTbOhspucElsZsAbGOuMj
         UQQEMRpebdFs7ZAyNNUQpIZRh3LK9HqYkN0rfJGK6SUhOrChDP8g+1ifVnte7oa6tN2L
         a3bz+3b9PKYqGDP2I3gCBgk8KVFDj6WAkO5hfo99pzYbdl2sNXMEk90W1NXiaBCdF0I1
         JPcA==
X-Gm-Message-State: AOAM531GrPPuZfCtj0yKaIdnCpowMl1pfh7ygPJXGQ+YOpwm9FBMHTzW
        1z6ZZrt3wQsxeYJ1o6HBYdTtxQ==
X-Google-Smtp-Source: ABdhPJy10hSN7EIWDkG1mJa1W1U+NkhQqewSXt1VJ7mXWUfgHVHzkudGM39RqPLVe4KIr1tJs9kLSA==
X-Received: by 2002:aa7:d042:: with SMTP id n2mr1976267edo.226.1589984739557;
        Wed, 20 May 2020 07:25:39 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id o18sm2029759eji.97.2020.05.20.07.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 07:25:38 -0700 (PDT)
Date:   Wed, 20 May 2020 16:25:37 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 5.7-rc7
Message-ID: <20200520142537.GD13131@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.7-rc7

Fix two bugs introduced in this cycle and one introduced in v5.5.

Thanks,
Miklos

----------------------------------------------------------------
Dan Carpenter (1):
      ovl: potential crash in ovl_fid_to_fh()

Vivek Goyal (2):
      ovl: clear ATTR_FILE from attr->ia_valid
      ovl: clear ATTR_OPEN from attr->ia_valid

---
 fs/overlayfs/export.c |  3 +++
 fs/overlayfs/inode.c  | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)
