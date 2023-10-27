Return-Path: <linux-fsdevel+bounces-1289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A45D7D8E03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 07:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E747E2811AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 05:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA548C0B;
	Fri, 27 Oct 2023 05:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA68883C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 05:11:06 +0000 (UTC)
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9501B6
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 22:11:05 -0700 (PDT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-581d766cc15so2367924eaf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 22:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698383464; x=1698988264;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYRbdaBgJS+wSJ4gmYrUGgqbPKYTSmw6Nqiyq4u7xTs=;
        b=qDtYNyj9NoYb7HP55v7VarZ81PYSkDtYBqRNrFc3BdPpjbSLcUHgYXVXDnVTCzQLPr
         JvJb3tEAcjtpD0NLGXW80QvpaFUBWJUq4VDG0Lh8sK7debbvqQbmhu5p87nD+krIKxRg
         HHRvlBN0lOjpXTcUoKv94auuPnROsibaIYbrqvrQVC5JKBq1h2yehfzUh1EEual4A9by
         kuvGwXUyMGH4LWOIFvBfsxqpMcdQ9F6Drxq1lJwmlWe0ywh7Ynvy67nC33jnAozS2ZhH
         EJA1gLuemRZWTMEib8t/8o9Nq29sksSVSlx+13V7W+m45IFycPsEWciJ1DzMZFDziRn7
         sKOA==
X-Gm-Message-State: AOJu0Yw0w0nlD2YVPcjCynwGCRE+CXYsuhGG1uKSHPyfad8yw3OGQbgO
	oIPFGLFdsBIfyrv1TGp7eHk6wzUyY6t/FpagE2H2wFb2fo9f
X-Google-Smtp-Source: AGHT+IFdDepfBdz8j2YWRcZSFB2dfFx87KPOrv4q6e9N8Ug/QH/LE98GYKgHIneccbhlUkeKjg1dLUe+WtPm2/q9DIqUn81hzVTW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ea4a:0:b0:581:e2d5:a088 with SMTP id
 j10-20020a4aea4a000000b00581e2d5a088mr478614ooe.0.1698383464607; Thu, 26 Oct
 2023 22:11:04 -0700 (PDT)
Date: Thu, 26 Oct 2023 22:11:04 -0700
In-Reply-To: <000000000000f3aeec05f025c6b8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019b7280608abb7f8@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in unlock_page (2)
From: syzbot <syzbot+9d014e6e0df70d97c103@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, almaz.alexandrovich@paragon-software.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, n.zhandarovich@fintech.ru, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 013ff63b649475f0ee134e2c8d0c8e65284ede50
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Jun 30 12:17:02 2023 +0000

    fs/ntfs3: Add more attributes checks in mi_enum_attr()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10677ddb680000
start commit:   18940c888c85 Merge tag 'sched_urgent_for_v6.3_rc4' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
dashboard link: https://syzkaller.appspot.com/bug?extid=9d014e6e0df70d97c103
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bf0adec80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1391fcd5c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Add more attributes checks in mi_enum_attr()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

