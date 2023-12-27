Return-Path: <linux-fsdevel+bounces-6974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE5181F237
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 22:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACE6282009
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 21:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DF9481C8;
	Wed, 27 Dec 2023 21:35:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F83481BA
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Dec 2023 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7baffaff3b2so185800239f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Dec 2023 13:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703712906; x=1704317706;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbQTOD/Ltd9C2PJIubwu4JdPZB/ZwoLzMfKrTF30tQM=;
        b=nQc+GLr/zL02rHvRZIdk0p3qLjgeVuw4sVgMao09tANNAsHchHxmwfdfXJJUh3WLb/
         572Um9Jb9uQZfXrgUug+G0GLiYjm6YRs2qpOq4hp+764dLt/FwEbXCC5pxPLMWnKmO8Z
         hCqLgOKXtYGcZmezDWvEkmXTzORh9KI1fGwRAl0TFAYTJz5adeZs6yGyJm5p3PVxBqku
         8pu4rtFQ8ANJ427nZLlF+FyIZl5sKBAIZD7V/4ut8a9cM2PZGsy1erWG4Px6003+r/Yp
         6PTgLFooMjmvWpUVi9+Tbv2dJHvXQV/uvykozwlK1tSbX0BVYfSDo0hZA8cHwG9Uh0WV
         /P/Q==
X-Gm-Message-State: AOJu0YwC5L1RL6+xcmflU1FOytbMhwpLUkX3A42RFXgtFsByW5qNeNzV
	dwKmRexHbyj+e7A60nFPj6cvqFBTjhdCctR5ss0HlQ46ZMWR
X-Google-Smtp-Source: AGHT+IESHqvKiy/A8nyx+QaDLdqzH3R119TI4RChAvP2HWtKKFejDSNQtJ99zWFHavl5JUAy63E8bzvuHwUfhDOcGBA24lRJ6556
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c28:b0:35f:d4dc:1b1d with SMTP id
 m8-20020a056e021c2800b0035fd4dc1b1dmr1007441ilh.1.1703712905942; Wed, 27 Dec
 2023 13:35:05 -0800 (PST)
Date: Wed, 27 Dec 2023 13:35:05 -0800
In-Reply-To: <00000000000046566805e997132d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008edf40060d8492e2@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in xtInsert
From: syzbot <syzbot+55a7541cfd25df68109e@syzkaller.appspotmail.com>
To: brauner@kernel.org, dave.kleikamp@oracle.com, ghandatmanas@gmail.com, 
	jfs-discussion@lists.sourceforge.net, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liushixin2@huawei.com, mirimmad17@gmail.com, mushi.shar@gmail.com, 
	nogikh@google.com, osmtendev@gmail.com, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a779ed754e52d582b8c0e17959df063108bd0656
Author: Dave Kleikamp <dave.kleikamp@oracle.com>
Date:   Thu Oct 5 14:16:14 2023 +0000

    jfs: define xtree root and page independently

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=104e23c9e80000
start commit:   830b3c68c1fb Linux 6.1
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b610daf3807bd5c
dashboard link: https://syzkaller.appspot.com/bug?extid=55a7541cfd25df68109e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175d3e57880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: jfs: define xtree root and page independently

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

