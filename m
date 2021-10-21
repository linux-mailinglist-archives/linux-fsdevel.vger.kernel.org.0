Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A34435C99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 10:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhJUIJW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 04:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhJUIJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:09:22 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6283DC061749
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 01:07:06 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id f4so11625810uad.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 01:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=no9cEcbIs5Y7LX0bbr/2ARsL8owG5qfnj1gxm7bjNJ8=;
        b=YH4Rd8xGVzs1lojatFcKEfHwJ1oeB3KZizRZEHvPbyvW40Nn/dS7lYtcfoMICAFvy1
         JjAvEFL7kHwo5ljQ/s1ogrloht++yqpAwtNTs1Jcmn2Rja83Jo+VMY5x6BT4e9qY6UwP
         mmmu6g3v7vdCi+eSOUfGi+P+JQb6ujkkNMrl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=no9cEcbIs5Y7LX0bbr/2ARsL8owG5qfnj1gxm7bjNJ8=;
        b=8IRR5BEyrt/ui2xEp47lCinQXXi2AC3PyavwvictNpKtUsrSAdm91ektq18eMVwUA6
         pERgahcVcg6DLooOjK46mbE0DsuQYoSd2Wl9DarwAsDIPajw53OJkF+Y2UWNOFx1vXhj
         TYTc5V+awZCiTFTqw4anI/KL9bOhlTvJYRFVCpbYb3E9MOyVfdccNo1tApCQckRQHbpO
         +QxYRcsZE9V9wuULUALIqTY85Vz06wbvO+yFWnIwxo/orAjtLFa2tXpDFsd+s8e05OHg
         lUU2HVUOfWutHYuGaTwcIVk1naI5k/15MdMPnVUcQCSpsmoLjXpy72kB+yjs3SN+Zus1
         bKzw==
X-Gm-Message-State: AOAM533k5i4JkUOlQIGCcZNbLKpeEAOmnL+ae0HSIpryqV4r0IW5uHD/
        YGbr83JVY3QtGKWXEST1PTcHOxoVozY/Lm2d4P9sZQ==
X-Google-Smtp-Source: ABdhPJwOzrU1ve1DcUpTmbtyQFG/OPWr0caKKjsjHToUIfpZYxivocWHmeVwGTZ2iJudsXl2h0Vl+86kFC73/E7MV+Q=
X-Received: by 2002:ab0:5741:: with SMTP id t1mr4545300uac.72.1634803625576;
 Thu, 21 Oct 2021 01:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000354def05cc0185ab@google.com>
In-Reply-To: <000000000000354def05cc0185ab@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 21 Oct 2021 10:06:54 +0200
Message-ID: <CAJfpegskcCEZAX+EbnBZyva2NDyhJ9k97ZM_E9OBeXRjDsC_BQ@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in fuse_test_super
To:     syzbot <syzbot+74a15f02ccb51f398601@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
80019f1138324b6f35ae728b4f25eeb08899b452
