Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738D92A83F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 17:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbgKEQte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 11:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgKEQte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:49:34 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B490AC0613D2
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2020 08:49:33 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id k21so2447344ioa.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2020 08:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Cz/0efJa6VyuLLQAH22EOsXRr8OamKv2SmfGi3I6JzI=;
        b=rCu45Ryxn6gGc9X5LdmjA0u/Q4Jbg0vA1rMDCdnYyNztnYwci60mQfHs72C8DrvxoJ
         IJq9/KzXvNF9hVnpgVT3bCmEc5+Ucjo641doqEEix5u77VqQ6aIIkpaLu6IrWaw/QYFx
         MtoRILvCiMzLRoIVeBVNsZqBYR5OjPNGzI4d2kMlUv2GYIivCAfe+SaxtNURIE22UxCJ
         hu5GCF4injdEfIlx0OAwaOEqhJTkmIrmbtWTlDU+ACt6pIGzA/vl+5P3bQ5YoUghKZpa
         dUVMrFjQqy9do6u2YqrfCYvwD4UnpZUFOqjlYXsIkurQHHiK38sZxDNaMfkTqjS/qeuk
         bJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cz/0efJa6VyuLLQAH22EOsXRr8OamKv2SmfGi3I6JzI=;
        b=fq5LTHWQSbgj+yyxyFs8b2xvZd5hKs2Gko1U4COcffomxvcprv0734Bybwapcl1tPx
         dDuNwV0G/RejDmnU2l3u/fINURDKFECPQOBiKabw+bj6Rs1ND4/t5CzerWhXFedUm5mB
         Miqnj/v1eDJhO96XTLWg+csDNFB1CjXfS3QD4roLhEh2SdsAdS+ymUjYUiztBmMMqqqB
         vu4i7S8iqQW2mTpptOr0tEDIkpBTYC5aIo2ZNYh0bZFnKrwkh4VyBXk0R4AP64al5JsW
         wSGz7qrtM4pMeqBsMDMcygHhItxKUzGQ44cOG5+ovuarXx6UxnbhILVds3UbMybz9Ah1
         oEqA==
X-Gm-Message-State: AOAM531Q68CQ/2CmUkH/XKScgyZKlO3dMnRwceXAoo1+XPu5w9bYiAuG
        5DOZeC+NhjicxECawvTya0woEw==
X-Google-Smtp-Source: ABdhPJwas+ZmyEBKBDsHrh2GHthcnq3oz20+EbGU+Q7BLDPkwZWvcaDRmWhiwFLKecTHyFIWFAOmLA==
X-Received: by 2002:a6b:3e83:: with SMTP id l125mr2369145ioa.151.1604594972962;
        Thu, 05 Nov 2020 08:49:32 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o19sm1449425ilt.24.2020.11.05.08.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 08:49:32 -0800 (PST)
Subject: Re: general protection fault in io_uring_show_cred
To:     syzbot <syzbot+a6d494688cdb797bdfce@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <0000000000003afa6905b35e6386@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1390bb94-a400-8e17-3c39-06c38277f091@kernel.dk>
Date:   Thu, 5 Nov 2020 09:49:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0000000000003afa6905b35e6386@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/5/20 9:14 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4ef8451b Merge tag 'perf-tools-for-v5.10-2020-11-03' of gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12bf23a8500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=61033507391c77ff
> dashboard link: https://syzkaller.appspot.com/bug?extid=a6d494688cdb797bdfce
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11022732500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13649314500000
> 
> The issue was bisected to:
> 
> commit 1e6fa5216a0e59ef02e8b6b40d553238a3b81d49
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Thu Oct 15 14:46:24 2020 +0000
> 
>     io_uring: COW io_identity on mismatch

Gah, stupid braino in that patch. Below should fix it.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3d489cf31926..29f1417690d5 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -8974,7 +8974,8 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 #ifdef CONFIG_PROC_FS
 static int io_uring_show_cred(int id, void *p, void *data)
 {
-	const struct cred *cred = p;
+	struct io_identity *iod = p;
+	const struct cred *cred = iod->creds;
 	struct seq_file *m = data;
 	struct user_namespace *uns = seq_user_ns(m);
 	struct group_info *gi;

-- 
Jens Axboe

