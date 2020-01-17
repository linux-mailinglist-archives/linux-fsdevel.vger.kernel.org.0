Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C22491409CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 13:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgAQMcv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 07:32:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55250 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgAQMcv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:32:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id b19so7258199wmj.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 04:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=g5DFCMAiBJapRLzTIsCMfZO3t3lSrKhZ+V4rKfulm64=;
        b=eVoDV+dONYvQLQwiJwhekdTDxP4cfGNPdAjI9sDP6NRVAi86vANPOyWBWGUtx4yUL0
         kvFW/1reL8Fs3sIFwEKDWm7kfpaYl9mYgLTo3ajA4aD9qeXLapZ+hrJ9lXApx7flYzAV
         tntk/hHytxEH6LLjO0zR+V3zk6yIKeoEybock=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=g5DFCMAiBJapRLzTIsCMfZO3t3lSrKhZ+V4rKfulm64=;
        b=NAjVB7whLkccIv1OW3TevIP5SpcIYSUfOKHULeStMMbyFTODIInKPv2rZud0+jSYcN
         hlTLvn7ET//RhcG6HKImTWrwIlzGTay2FFxfTpoWhFCYKdj9ZbwEg+Efur2z3EG2NGPw
         uHHoRuieomNfsPrf4/vk8BpA5VGajrRw2VINz10IyM/FU15N9pwfNVciDEjZQgPkpz7i
         DC55PF/LY1jUu4sa9TI2QemKJPi+75NBu4MoPxurUQs6YvUTQ2ywdhn+Xh2w0hrY7bWN
         zh0ys8wl/8A+AChXeYGGNEVyMmBpRdxZEx/e3pVipOI3s8AxC8ErGj2Dn5P6BriAIukf
         08iQ==
X-Gm-Message-State: APjAAAUvJGpcv0A9LC5d+KGmhwMK9DtesZcJJeKsu22VMnvDMoFRFVZ7
        Aub6OSc7xwdC3siPliguLOVPR5G0EAJ6fA==
X-Google-Smtp-Source: APXvYqyC+rZ4Viq9eim4+IsFLrhTPqo65VnAf2kQZ/bQmE3Vm176tHGpzexlo/I2jEFU3kT5NDWB3g==
X-Received: by 2002:a1c:4b09:: with SMTP id y9mr4351730wma.103.1579264369055;
        Fri, 17 Jan 2020 04:32:49 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (94-21-206-225.pool.digikabel.hu. [94.21.206.225])
        by smtp.gmail.com with ESMTPSA id t125sm9755173wmf.17.2020.01.17.04.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 04:32:48 -0800 (PST)
Date:   Fri, 17 Jan 2020 13:32:43 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fix for 5.5-rc7
Message-ID: <20200117123243.GA14341@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.5-rc7

Fix a regression in the last release affecting the ftp module of the gvfs
filesystem.

Thanks,
Miklos

----------------------------------------------------------------
Miklos Szeredi (1):
      fuse: fix fuse_send_readpages() in the syncronous read case

---
 fs/fuse/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
