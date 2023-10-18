Return-Path: <linux-fsdevel+bounces-713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 085E27CEB1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 00:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2B31C20D30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 22:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA6E450F7;
	Wed, 18 Oct 2023 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B9C4293F
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 22:21:37 +0000 (UTC)
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEA0115
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 15:21:36 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6c22d8a0cecso10550677a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 15:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697667696; x=1698272496;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3EPpHXTERq+D2JCxH5Po5ARyBy/ijqQRwM7V/k2tt8=;
        b=xJnIK0mHRXIhvDyzEEdJ0kAzxzSyHEepvsfqeO8rrlNt78bM0A7wUKh92ezDjWisqW
         QcXl7YRBdpy9n2K3ZVMUEzKjyTPmYwE3lnphbfgcYdgL/d6wdT2r277RG14ZH53OJZp1
         im4q43Chnb62MQIh+3hyDipQCBwpySBc9B63YzSz3G3rMmiHXeH5R1TB8D2OWD1A8VtW
         PY3+yt2UltLFI71aVLJocB8fCbVIrrC4g8j9sS1KdcIX+NWg1vAAuL7lY59yHS+UhKrb
         26lsSq1MNOMgMn7nl/ZXwlzZ6mVFC5krGX/CRCiZJ2GC905KW9oHZnZL6aQ9/F1QoCvA
         JgqA==
X-Gm-Message-State: AOJu0Yz4aPfaQKMvGE/6GR/3nCe1aO7hidbcP5vuBf9I2LpTxmQeIVdG
	ZxNHTK7GFGlvB5CJ+wM7+lUTvFW/suCP8enVogMKZuwguh6+
X-Google-Smtp-Source: AGHT+IGEaGVuNuTersxZpbZ/i3hlLMkeGBtI/luOSEuaqEob9pquLVHBO68Qfh424vjT4D0DpFszoSL+jHEx7PRhCI+QsmSlhxZ2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a9d:7a93:0:b0:6cd:9d4:fd63 with SMTP id
 l19-20020a9d7a93000000b006cd09d4fd63mr180198otn.6.1697667696259; Wed, 18 Oct
 2023 15:21:36 -0700 (PDT)
Date: Wed, 18 Oct 2023 15:21:36 -0700
In-Reply-To: <CAOzc2pxr_Lzgbv-ddvifVdcOrA0X-2Y8Zz+WHjFWAuGu_CdZnA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb7b260608050f04@google.com>
Subject: Re: [syzbot] [mm?] [fs?] general protection fault in folio_flags
From: syzbot <syzbot+1e2648076cadf48ad9a1@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1e2648076cadf48ad9a1@syzkaller.appspotmail.com

Tested on:

commit:         34d60af8 syz-fix
git tree:       https://github.com/VMoola/kernel.git
console output: https://syzkaller.appspot.com/x/log.txt?x=146e70f5680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4894cf58531f
dashboard link: https://syzkaller.appspot.com/bug?extid=1e2648076cadf48ad9a1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

