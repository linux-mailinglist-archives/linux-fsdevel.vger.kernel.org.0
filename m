Return-Path: <linux-fsdevel+bounces-5140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70AA8085A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 11:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCEE8B21105
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 10:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E91637D07
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 10:35:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8E2132
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 01:56:21 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b9ced51358so1366812b6e.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Dec 2023 01:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701942980; x=1702547780;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScwbojD04F2at3hLMumIFTXdjPyNKsTIy2RhBT11T1o=;
        b=hcU81zABASl8JDCEtGcZdfi8sesHd+mZjoigY9WVa9kFOfc+rNLcvIzKZXWErizgMv
         1dtcKiSj9Ixu+Kf9/xYKUg+XK0AJbdxekyaSw6s6O10QU1Zn08gozE/Cl3U2ZIYsIBku
         WwiM/EOsMkinJH5NeczwfldAFJkXtqinPJUA6J9GydzFVe9iIAYr8lDmCv9KTzMNbuWD
         izUukOPzxsNV3WGtV1jzLHfRFWYM6C6XGoYKiypOe2YiKXDRxUeRukEqMU2EV2eEBChj
         /36pOPxsfEu7YJDMLAeNZqzv8bYk9GzElBMCNEEcQBt0Dd1gFzqErjrgaQVO70hcCi+Q
         9etg==
X-Gm-Message-State: AOJu0Yw4SAcleMWL7hTo/959MB5ZQ0IgGOwsgCDNYqvuyIh1/531spsl
	2rHnziSrzZHA0wPRMrXZxNV/Ic+5MlSUTDwVP3p96V/D7HBX
X-Google-Smtp-Source: AGHT+IE2CB85UZCMHKfz8FuIzMEfBv2d88hnYymoGoXVFebV0bh8KsWkEDw4SOmC5VaO0teGgmDorKGoPqlnKVgBtLwTm6W0EtlU
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:200c:b0:3b8:5dc1:3177 with SMTP id
 q12-20020a056808200c00b003b85dc13177mr2212198oiw.1.1701942980419; Thu, 07 Dec
 2023 01:56:20 -0800 (PST)
Date: Thu, 07 Dec 2023 01:56:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6a5df060be87a45@google.com>
Subject: [syzbot] Monthly gfs2 report (Dec 2023)
From: syzbot <syzbot+list7414194430be1506e979@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 0 new issues were detected and 0 were fixed.
In total, 20 issues are still open and 22 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4739    Yes   WARNING in __folio_mark_dirty (2)
                   https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2>  3678    Yes   WARNING in folio_account_dirtied
                   https://syzkaller.appspot.com/bug?extid=8d1d62bfb63d6a480be1
<3>  668     Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<4>  55      Yes   WARNING in gfs2_check_blk_type
                   https://syzkaller.appspot.com/bug?extid=092b28923eb79e0f3c41
<5>  37      Yes   general protection fault in gfs2_dump_glock (2)
                   https://syzkaller.appspot.com/bug?extid=427fed3295e9a7e887f2
<6>  9       Yes   BUG: unable to handle kernel NULL pointer dereference in gfs2_rgrp_dump
                   https://syzkaller.appspot.com/bug?extid=da0fc229cc1ff4bb2e6d
<7>  9       Yes   INFO: task hung in write_cache_pages (3)
                   https://syzkaller.appspot.com/bug?extid=4fcffdd85e518af6f129
<8>  5       Yes   WARNING in gfs2_ri_update
                   https://syzkaller.appspot.com/bug?extid=f8bc4176e51e87e0928f
<9>  4       Yes   BUG: unable to handle kernel NULL pointer dereference in gfs2_rindex_update
                   https://syzkaller.appspot.com/bug?extid=2b32df23ff6b5b307565
<10> 2       Yes   memory leak in gfs2_trans_begin
                   https://syzkaller.appspot.com/bug?extid=45a7939b6f493f374ee1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

