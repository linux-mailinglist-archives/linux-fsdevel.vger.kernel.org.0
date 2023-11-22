Return-Path: <linux-fsdevel+bounces-3438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 566587F4946
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 15:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E651C20AD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 14:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4938D15ACF;
	Wed, 22 Nov 2023 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1393112
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 06:48:13 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cf632d951fso42327145ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 06:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700664493; x=1701269293;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfUef9tj9kWRG/hnj63YvOvnIkXS0rMCQtJAytUlGk8=;
        b=PBy/eBG/Uk5aeypofMzhCFYfZi4DUMj/HYhw9kcQK1fmCIwiiq8E6OCKeA7jTas4nB
         Hjo/gTfHpRPqRusyLP2MiYRwfKDhipvtSDPirCx+lyo7jJM6rDasLvWxKg7Tv7LVzdVV
         X2XGmK1a3wOdypR2+rVCweHMdnrzhMglWUUdhQa8q5S334t5BfP6uuqawWPYKKkN6v9r
         CN/TmSxYEj5flOb8V27fGj4KIVUGYrbHdrGH6CIssT9PHDEITKVoa3emz7+INVFa+ZSm
         vrF9F1uEc19pdC31WHgb1+Oogan9A+GpNnjjqPruGSIffct/2FZA7RKMx3XmOx+SxBpj
         gRWQ==
X-Gm-Message-State: AOJu0YyqYphlgeMoOFmNnMPgJRNwAqogAQ9xAY5PBRxvaovTqWacTpiL
	csxdFDP993jA5jw9uVpvo/VxzqrgKhqreEJcApDaT3pQqyON
X-Google-Smtp-Source: AGHT+IGq7r6T25A3qPazOzUj0YDkw7al03zhP0GBv38qY3FOLZ1Idk9W9LaKs0J37RKiQ9EjayKjiAW3KL9Qkt9T7aav4YO9BgNV
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:dac8:b0:1cc:3147:6937 with SMTP id
 q8-20020a170902dac800b001cc31476937mr655370plx.4.1700664493183; Wed, 22 Nov
 2023 06:48:13 -0800 (PST)
Date: Wed, 22 Nov 2023 06:48:13 -0800
In-Reply-To: <0000000000009b49ce0606fd665a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff9bd1060abececf@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in attr_data_get_block (3)
From: syzbot <syzbot+a9850b21d99643eadbb8@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, 
	clang-built-linux@googlegroups.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nathan@kernel.org, ndesaulniers@google.com, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, tintinm2017@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 4ad5c924df6cd6d85708fa23f9d9a2b78a2e428e
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Sep 22 10:07:59 2023 +0000

    fs/ntfs3: Allow repeated call to ntfs3_put_sbi

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17484614e80000
start commit:   e402b08634b3 Merge tag 'soc-fixes-6.6' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=12da82ece7bf46f9
dashboard link: https://syzkaller.appspot.com/bug?extid=a9850b21d99643eadbb8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b684e6680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ede4d6680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Allow repeated call to ntfs3_put_sbi

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

