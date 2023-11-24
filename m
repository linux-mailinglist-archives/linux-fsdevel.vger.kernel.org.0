Return-Path: <linux-fsdevel+bounces-3670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C3E7F7717
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2A75B21652
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 15:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F342E621;
	Fri, 24 Nov 2023 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F031B6
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 07:03:07 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c19a0a2fbfso1959467a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 07:03:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700838186; x=1701442986;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdOGYRw72XNJqmdPubXE3DN830RearWPfGL+ky1culY=;
        b=ZNMNOZUSdLuOSRzpX5ILddqZeXzYaa1R98d3GaV3T/lMVkDl4HSy11SI5WbrDgS1U2
         1JwZbNGPHjoh1ztO8ntbHC4x4njWp+37uIywm5PzKatkAcr0I10WGPy6r5V8hdQ//ISo
         LV8AMQt25LaCLD3MoTspFzVBJxGk2DvhepgBFBgPCgAC4OVIwJZyH4KH6LE2o8rLELmZ
         uZaWrjhpS37nqH/fFNJhW0O+ptGfaZOc5T7jXNsEz1d25J8/+XT3tDBAE456TitJGkMI
         q/InZKjc6qvIe+C9gDASQDmO1p4N8oiMi5KRYBbGVyFYFFU9dq5kwP1RFQ6kzatcESLo
         QtHQ==
X-Gm-Message-State: AOJu0YxHHe6PlWGqN4MHD4VQsPN9UVEfqFkthl/RIcSvJYqzD5ExhtQF
	IHURe1IAgRUg+GVkrPj54ouMQT0noM/Tvu8JSk9oxcW2UXA0
X-Google-Smtp-Source: AGHT+IF/OpCjhF/WWI5/IHCmdz64ebIxIlZdyR8GxPdJXc2tF7B4AjJYFdaK8E6F44vImX4ZB8se0iKG2x374ePup4X7r0EXlqZs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:4c:0:b0:5bd:d756:86d2 with SMTP id 73-20020a63004c000000b005bdd75686d2mr426223pga.10.1700838186595;
 Fri, 24 Nov 2023 07:03:06 -0800 (PST)
Date: Fri, 24 Nov 2023 07:03:06 -0800
In-Reply-To: <CAG48ez3AazYzfJCFgu2MKSoxMEpJXz0td+rbeCOhsM38i78m3A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eebb5d060ae73f1e@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in pipe_write
From: syzbot <syzbot+011e4ea1da6692cf881c@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jannh@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+011e4ea1da6692cf881c@syzkaller.appspotmail.com

Tested on:

commit:         56c486e6 fs/pipe: Fix lockdep false-positive in watchq..
git tree:       https://github.com/thejh/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=128b880ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e6a76f6c7029ca2
dashboard link: https://syzkaller.appspot.com/bug?extid=011e4ea1da6692cf881c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

