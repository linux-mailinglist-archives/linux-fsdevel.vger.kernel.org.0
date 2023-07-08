Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A4D74BD80
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jul 2023 14:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjGHMpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jul 2023 08:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjGHMpN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jul 2023 08:45:13 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DABAEC;
        Sat,  8 Jul 2023 05:45:12 -0700 (PDT)
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 368Cj5SS073574;
        Sat, 8 Jul 2023 21:45:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sat, 08 Jul 2023 21:45:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 368Cj5dW073570
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 8 Jul 2023 21:45:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a2596c0a-ad77-d70d-0b26-5d2ff01d1857@I-love.SAKURA.ne.jp>
Date:   Sat, 8 Jul 2023 21:45:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [syzbot] [tomoyo?] [hfs?] general protection fault in
 tomoyo_check_acl (3)
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     syzbot <syzbot+28aaddd5a3221d7fd709@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <000000000000fcfb4a05ffe48213@google.com>
 <8bacb159-6512-b2d0-d015-a9c4f141df8b@I-love.SAKURA.ne.jp>
In-Reply-To: <8bacb159-6512-b2d0-d015-a9c4f141df8b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/07/08 20:29, Tetsuo Handa wrote:
> This is not a bug in TOMOYO, for booting with security=none results in crashing at other locations.
> 
> This might be a bug in HFS's error handling. But since there are several bugs
> which have been added as "mm" in the last few days, let's change this as "mm".
> 
> #syz set subsystems: mm
> 

Bisect log says that 6.3 and 6.4 crashed similarly. Thus, assume that this is a HFS problem.

#syz set subsystems: hfs

