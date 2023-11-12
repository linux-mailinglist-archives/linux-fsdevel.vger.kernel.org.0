Return-Path: <linux-fsdevel+bounces-2779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9AA7E9156
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 16:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE589280A99
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 15:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CBA14286;
	Sun, 12 Nov 2023 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069D912B8D
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 15:09:05 +0000 (UTC)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEED82D64
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 07:09:04 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5bd18d54a48so3272841a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 07:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699801744; x=1700406544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srdz066tvvTdM4CmNeOwelm2biHAQtgJiKmsTshSsQM=;
        b=QAH4Kt1JQWxVf0UATqXguBBqN3k1cZuUyB3ILq9CYbBtNCuHhO+A1namFslNUCKD9i
         L2lqVNSZOTB7RhvBF8/vSpI52VS/OXiakA1SmfJZYKaUWzhOqaFWp4cLB9DT90WbnEdz
         1cIABosTXfdfuHykO/H+T57KekoDJJ6BVIyaVF+y7QaH6lcOwag11nyAwG4EoN/AxYxY
         SnBa1YXJRHo2v7HKhikYiUZnO5WnnXsbp/fNNWJys4yHEAtermDv9qRvoyiL8AIgMPdv
         lXBK6P+IlhY8TJqjCiCgYRD3u6EwtrEigL6B5XTv/gfHsFRUI97oixZWEKsF3hiij1dj
         lq1Q==
X-Gm-Message-State: AOJu0YwH4xc4/XUaUqz2fYpy8RK5v4AQoHzZM0XTUXOctg1RwQJm6bZP
	BoJnLQPiTt7n7IJpuyB+zTpA/G9vhgUUkHO7/kXw+T1xq8TE
X-Google-Smtp-Source: AGHT+IGs5Bkh6t4mkKR/0xr7IdzglfJ6hUWB8xmVEG9vXFMRG6t/rR+LHznVq6ba/NS14YuOHKxykcNXYixm3z/LZbZCrCy89uco
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a02:523:b0:5bd:9b7f:b08d with SMTP id
 bx35-20020a056a02052300b005bd9b7fb08dmr1552203pgb.0.1699801744211; Sun, 12
 Nov 2023 07:09:04 -0800 (PST)
Date: Sun, 12 Nov 2023 07:09:04 -0800
In-Reply-To: <CAOQ4uxhnY+hzfCA7A2aTfVKsveR9g6Hn=FbFrjFuXs8w3sYX5Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000271e420609f5eff0@google.com>
Subject: Re: [syzbot] [overlayfs?] memory leak in ovl_parse_param
From: syzbot <syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com

Tested on:

commit:         97d58994 ovl: fix memory leak in ovl_parse_param()
git tree:       https://github.com/amir73il/linux ovl-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=12394b97680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ecfdf78a410c834
dashboard link: https://syzkaller.appspot.com/bug?extid=26eedf3631650972f17c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

