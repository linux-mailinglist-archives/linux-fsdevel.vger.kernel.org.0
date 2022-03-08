Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B324D1B05
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 15:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347643AbiCHOyV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 09:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346368AbiCHOyU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:54:20 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BAA2A267
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 06:53:22 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s10so3588697edd.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 06:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=XoO8zLUTv+cM6BwEk+1Jo0X1DFvUiXaxYAUtrqwgI4U=;
        b=AZvpWPgbJyvXhvAQNiuMdtLVy/K8nTmV+CiW76oTtPW5n4tWR2OIljpmgscrugyv2I
         UL6ao2ozUI9lrBo/+vTmwZVWJAKzfmkrbAzwAmz7hIsLTZ4+3FMRCiJ+Pbe8uYtOcPk6
         wX5tva+WDKmZMjsRM67WP/G17V53WgFV4Pt8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XoO8zLUTv+cM6BwEk+1Jo0X1DFvUiXaxYAUtrqwgI4U=;
        b=bQ+VLnCwbT9PgEE8kzWDRQmkcG9qWm9fOSk+b5Jky2P2RfKuz2cbEFaf8gsd9p5lxW
         Q6vl7PXu65TyBtkPbzLofx0mx87L+OTQ/k4Ir4nhZZfwRMITHfkhYRI9hA6tfRC1AIVf
         PQguH3v4IGYFMgcpr6t7TM0xpMb781c2WEDi6xZxXu8x1abWhRgCliTxn/VR5QYuEPy5
         H/ACIy1YmA95xjKhOWm3R6XrXeqorKJC2u9Q18v2iUZYNPDehEIZiiV3YeOOQ+SUgw7x
         ZQ7nrHnzOhExyaOBS0b3p4XeGtwhrOMP5gAMTHTNyk4fG9HRWcrHpi4oEUE/BTq+5hxj
         sI9Q==
X-Gm-Message-State: AOAM533e00zv2RI4xtPEBo4BRiaK7euiJCcFOEYtfw88jEz/Y6LfMycJ
        ytnlCxOeHP0mNAVOPMQvFQ9LmA==
X-Google-Smtp-Source: ABdhPJz8LnWuSkpe+EPUTLsS2xcxj+A3WdKibZ3AUchF7ce3n523bn5mXkoGmvq4RRql0CqDEFr9sg==
X-Received: by 2002:a50:d498:0:b0:416:2b00:532 with SMTP id s24-20020a50d498000000b004162b000532mr14816924edi.396.1646751200751;
        Tue, 08 Mar 2022 06:53:20 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-178-48-189-3.catv.fixed.vodafone.hu. [178.48.189.3])
        by smtp.gmail.com with ESMTPSA id h20-20020a1709060f5400b006d6d54b9203sm5931349ejj.38.2022.03.08.06.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:53:19 -0800 (PST)
Date:   Tue, 8 Mar 2022 15:53:17 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.17-rc8
Message-ID: <Yidt3VEGFzuZwe1g@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.17-rc8

- Fix an issue with splice on the fuse device

- Fix a regression in the fileattr API conversion

- Add a small userspace API improvement

Thanks,
Miklos

----------------------------------------------------------------
Jeff Layton (1):
      fuse: move FUSE_SUPER_MAGIC definition to magic.h

Miklos Szeredi (2):
      fuse: fix fileattr op failure
      fuse: fix pipe buffer lifetime for direct_io

---
 fs/fuse/dev.c              | 12 +++++++++++-
 fs/fuse/file.c             |  1 +
 fs/fuse/fuse_i.h           |  1 +
 fs/fuse/inode.c            |  3 +--
 fs/fuse/ioctl.c            |  9 ++++++---
 include/uapi/linux/magic.h |  1 +
 6 files changed, 21 insertions(+), 6 deletions(-)
