Return-Path: <linux-fsdevel+bounces-6831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBF481D437
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 14:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 677A3B229EB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 13:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5A4D51C;
	Sat, 23 Dec 2023 13:39:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4472D302;
	Sat, 23 Dec 2023 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3BNDciW3093314;
	Sat, 23 Dec 2023 22:38:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sat, 23 Dec 2023 22:38:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3BNDci1f093311
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 23 Dec 2023 22:38:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <867f02d5-7f1e-494c-99ba-b76c0d263fa6@I-love.SAKURA.ne.jp>
Date: Sat, 23 Dec 2023 22:38:41 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: fix warning in ntfs_load_attr_list
Content-Language: en-US
To: Edward Adam Davis <eadavis@qq.com>,
        syzbot+f987ceaddc6bcc334cde@syzkaller.appspotmail.com
Cc: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com
References: <0000000000006ee8fe060d16e2a5@google.com>
 <tencent_C789B86EF5AED70CAF27CF06EF52C1C66106@qq.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <tencent_C789B86EF5AED70CAF27CF06EF52C1C66106@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/12/23 13:05, Edward Adam Davis wrote:
> kvmalloc needs to check __GFP_NOWARN, so this flag should be passed before
> applying for memory.
> 
> Fixes: fc471e39e38f ("fs/ntfs3: Use kvmalloc instead of kmalloc(... __GFP_NOWARN)")
> Reported-and-tested-by: syzbot+f987ceaddc6bcc334cde@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Nack. Please don't apply this patch.

See https://lkml.kernel.org/r/bca8d526-2397-4ca5-b1d6-5758c9334a81@I-love.SAKURA.ne.jp for reason.


