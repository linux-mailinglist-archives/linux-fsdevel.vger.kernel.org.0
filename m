Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC0775A2D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 01:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGSX0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 19:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGSX0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:26:34 -0400
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C2FA2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 16:26:32 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5668c477b8dso382336eaf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 16:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689809192; x=1692401192;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDOSJedoPxepoA025WtTczNfxj6NuTnlUwyZGaEdBWQ=;
        b=kVED5Tjkmo8L+72+TrO3iwTtSIky3wHqWcLwekhtqxZL490n/65YnG1h2dxMTQ0lWa
         O55x8s7P1g3ybWMsnebIaoTt91RZfBD4rKnBNeRu1+NHTRpphu61Q7/aRTenaCskvAu2
         WaNx0ssyzzG0LUz+rw2we7JDB6rcLbAmAwqarzkQ1b/8jtM3E2Fi+ax/Hw5p0PTgtteK
         WWYbqMqR9WA5mutPzcjqzfl8iYoyh1UsZU8n16N0YyQT6H5lyxojNA2Gh1bT8g8C/sZB
         ONyT9az5UEx5l5UG2xcz+lSv55fIexf/Tyq0YBRMRS2TMw3/czv5c2wy0Sn+a8zY3iuo
         tIrA==
X-Gm-Message-State: ABy/qLYPXQcPf7MiPVf8w092cCp6RIJuL4Lpi6UODKkGjxT66QIosCoA
        VwzApZMg8pWK2sGc8zuSj+2vr4gT/FBpTewl+ReZ8IvppZQ9SBI=
X-Google-Smtp-Source: APBJJlFC2ZIZQe11DY4AlEV9XSZwIkOQl6yUaNY2ZQXgFznDb77YxI28US8bJG3TeSgFAXTXgYl/lIQ0iX2MD1PcZjIVGEgz2emD
MIME-Version: 1.0
X-Received: by 2002:a05:6808:13d5:b0:3a3:fa78:415d with SMTP id
 d21-20020a05680813d500b003a3fa78415dmr7381617oiw.9.1689809192346; Wed, 19 Jul
 2023 16:26:32 -0700 (PDT)
Date:   Wed, 19 Jul 2023 16:26:32 -0700
In-Reply-To: <e5c7184e93d32d44196e3ac23d88f1fa@disroot.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5e9f60600df5c80@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfsplus_show_options
From:   syzbot <syzbot+98d3ceb7e01269e7bf4f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sel4@disroot.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file include/linux/fortify-string.h
patch: **** unexpected end of file in patch



Tested on:

commit:         aeba4568 Add linux-next specific files for 20230718
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
dashboard link: https://syzkaller.appspot.com/bug?extid=98d3ceb7e01269e7bf4f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10bbdd92a80000

