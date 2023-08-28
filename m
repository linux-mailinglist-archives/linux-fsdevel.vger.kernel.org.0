Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A5578A8CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjH1JVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 05:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjH1JUe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:20:34 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD43B124
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 02:20:26 -0700 (PDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1c0e161e18fso23600065ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 02:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693214426; x=1693819226;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NjVq1Z/oMa2sXmtYIkTscVFUho6LoOShE43iizaRVs=;
        b=F5P5/3oNsLiYFPUv1tb2TsYpzzcdw/bUKzpz5kBhXEuwR32yPMGct5c7XJ94EuRiuv
         c193V7FDK3qaKj9iYW/DjW2AgU8utYtF/jjIQaO65sS5TGiFbjjVbnQzEA6Cxax79n/0
         QPt5/me7MW7AeacUeyy5aC7b+zCRQsFsXdBYtw8b9ARx3hYJR55+fcOcfAyeseTKzB8O
         IU4hlRS0tbtaaUuA1iLQXYdYtJeKsqdfQ6XhArLFwv+4VQsgZgYr5EMyyMseO2eMIiED
         RhlS8IibI5Gce8Yhjtd2fKyYJ66GfUUARJN+gNec2gZobmPxIlbzp/sMhFSNviuP6leZ
         xVMg==
X-Gm-Message-State: AOJu0YyZeq4eDHsnIT6ZvyrMe4Un1v3Ta03LZ/aIB+2233GWuPNArE5F
        1KXAqigivXHDwikrAFWdsTYe30zUAbKyW5/XWECJYtza3DUg
X-Google-Smtp-Source: AGHT+IFwKeCBWgC1DX1LPBdk1QA9ny0nkU+5FxOLBCGi9TyKmLytzDKG906xwutAxEps8RwhnOht6aretJL+sMA6FaE8OnNW97B9
MIME-Version: 1.0
X-Received: by 2002:a17:902:cec4:b0:1bb:ad19:6b77 with SMTP id
 d4-20020a170902cec400b001bbad196b77mr9087222plg.2.1693214426325; Mon, 28 Aug
 2023 02:20:26 -0700 (PDT)
Date:   Mon, 28 Aug 2023 02:20:26 -0700
In-Reply-To: <20230828-storch-einbehalten-96130664f1f1@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068eb580603f834d3@google.com>
Subject: Re: [syzbot] [ceph?] [fs?] KASAN: slab-use-after-free Read in ceph_compare_super
From:   syzbot <syzbot+2b8cbfa6e34e51b6aa50@syzkaller.appspotmail.com>
To:     brauner@kernel.org
Cc:     brauner@kernel.org, ceph-devel@vger.kernel.org, idryomov@gmail.com,
        jack@suse.cz, jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> #syz dup: [syzbot] [fuse?] KASAN: slab-use-after-free Read in fuse_test_super

can't find the dup bug

