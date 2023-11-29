Return-Path: <linux-fsdevel+bounces-4258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A0B7FE365
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44721C20AEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2330B47A52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218A995
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 13:42:05 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5be10675134so270809a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 13:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701294124; x=1701898924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/NbCxHxoX/8oZaN5a+Csa1q9zeATXJUOImFIfAeLV9A=;
        b=n1qlYXYyq7u9vsDJnzSvDCey8iK/7usDBwlK6Kg5xHVuwAFLt9KMQKsb6MiCI1IJrQ
         Zb2zQBxLU75DEet+f+/SyCTd0dKEVlMiaMEwZKCkDk1+doo+yBCu1BlVGKhsYRko5vFO
         fLslAOoZfchSZRT3rXLA6mQlhuIg40C6h+fLLkvRtF6drKuq6GiQ5ahBEObrX5L6pcEu
         jbHECfHIH9fmmKJpzH/ww7U5V8P9Hjz0xb8VXF5RYNyvGdzU43CcRdfeUa256Fsfhs70
         ELOI5za9gT7+JI4+k1Z/vKqneIo+51wr/AMpOpgrYsnK0jhOAmg3ZgV7qR9U2N/FXe6T
         Kc+Q==
X-Gm-Message-State: AOJu0YyNYPmA42doGCzME/yKTaKUAD8Lp1AQYUDgoiKFdSug6ZLVGqg1
	DM2mUfh5uCas8QObjoLiZCZDI4j3GJ5YeC4MUOgo2D18l92W
X-Google-Smtp-Source: AGHT+IETi66dWW6/8wkIKVCpieF7K0d2+NGao1l0CjphPq9lMagnrVVW0dwnje+k6Qh7AN7/WuIPFTQPMEGbEwJR1N4giQSK5hhd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:1009:0:b0:5b9:6677:b8d with SMTP id
 f9-20020a631009000000b005b966770b8dmr3298317pgl.6.1701294124632; Wed, 29 Nov
 2023 13:42:04 -0800 (PST)
Date: Wed, 29 Nov 2023 13:42:04 -0800
In-Reply-To: <000000000000db858c05f06f30b0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5144d060b5167d8@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in exfat_write_inode
From: syzbot <syzbot+2f73ed585f115e98aee8@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, namjae.jeon@samsung.com, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 907fa893258ba6076f5fff32900a461decb9e8c5
Author: Namjae Jeon <namjae.jeon@samsung.com>
Date:   Thu May 21 23:10:10 2020 +0000

    exfat: add the dummy mount options to be backward compatible with staging/exfat

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138aca9ae80000
start commit:   f9ff5644bcc0 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=104aca9ae80000
console output: https://syzkaller.appspot.com/x/log.txt?x=178aca9ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c163713cf9186fe7
dashboard link: https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d6fe00480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d2fc63880000

Reported-by: syzbot+2f73ed585f115e98aee8@syzkaller.appspotmail.com
Fixes: 907fa893258b ("exfat: add the dummy mount options to be backward compatible with staging/exfat")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

