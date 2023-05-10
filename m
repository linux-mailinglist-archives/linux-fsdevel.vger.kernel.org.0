Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B1F6FE449
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 20:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbjEJS7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 14:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjEJS7O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 14:59:14 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEAA19B
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 11:59:13 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-33338be98cdso41961855ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 11:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683745153; x=1686337153;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSmlt1pubYFv1U6NX+BxCqpmANLnkI4L70JDSkZJ7ws=;
        b=J6sFUB9MfQtk1YVGJU3DcbsrtVwS0tBz04PjHfTKMZ8SFjW4JOvc/rjz99tpMeCzjQ
         W+RRSxqACagpSZG7gnW/yL3wZ/+buxC3nRIMnmL0NqtMdKRtd94tPUtxB3nCI/NdCWIw
         yAuDo3dQRsOVxAIylEPKCIN9InHbXeGGS+S+DMiTPIzFdtoI03bxd7w/aALHwze4sFdi
         +FNC+mO+yrhDPTZB6p9u8BK/HOL+5QyaH/itnDhbNpmy3lw09Fe3qipzUPRS7ex9rkw9
         bcFNyg+Ybrh8UXPJLkwjHaGWekSn+cfEkkVUpWv++VyaYfDv8pc73dqvwGyoUFtCMBAX
         Wf3A==
X-Gm-Message-State: AC+VfDzCAIjitlaavsOsjwe96cFK7pxZd8dMObNKYuTghy4g7s4qGdgs
        yGMAHot5smCDs6AO5G+TyYhr/KW0AnX9QGzPvuWEZGMNfQL0
X-Google-Smtp-Source: ACHHUZ7L0sj91t3luFFP8vY4i8KSPqBQttp+O9MHIEEp89O+Lz1OHryGtpUH9w4xMQMhkvYVP+I4jYAvZhT+WRe1yrcdv+Fw1PQr
MIME-Version: 1.0
X-Received: by 2002:a92:c04e:0:b0:335:908b:8fc with SMTP id
 o14-20020a92c04e000000b00335908b08fcmr3369299ilf.1.1683745153048; Wed, 10 May
 2023 11:59:13 -0700 (PDT)
Date:   Wed, 10 May 2023 11:59:13 -0700
In-Reply-To: <ZFvpefM2MgrdJ7v4@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd687205fb5b7714@google.com>
Subject: Re: [syzbot] [ext4?] BUG: sleeping function called from invalid
 context in alloc_buffer_head
From:   syzbot <syzbot+3c6cac1550288f8e7060@syzkaller.appspotmail.com>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> #syz set: subsystems mm

The specified label "mm" is unknown.
Please use one of the supported labels.

The following labels are suported:
missing-backport, no-reminders, prio: {low, normal, high}, subsystems: {.. see below ..}
The list of subsystems: https://syzkaller.appspot.com/upstream/subsystems?all=true

