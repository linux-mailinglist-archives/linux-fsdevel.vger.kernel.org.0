Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76F459B173
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Aug 2022 05:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiHUDkO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 23:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiHUDkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 23:40:06 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D181F62E;
        Sat, 20 Aug 2022 20:40:05 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 27L3e4lE023818;
        Sun, 21 Aug 2022 12:40:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Sun, 21 Aug 2022 12:40:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 27L3e4Bn023814
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 21 Aug 2022 12:40:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e834e724-32bc-c990-af96-56af044b72b1@I-love.SAKURA.ne.jp>
Date:   Sun, 21 Aug 2022 12:40:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/2] tomoyo: struct path it might get from LSM callers
 won't have NULL dentry or mnt
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <YwFDLhioFG5Mlwws@ZenIV> <YwFDfYcRKIYEkr43@ZenIV>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YwFDfYcRKIYEkr43@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/08/21 5:26, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Thank you. You can send this change via your tree if you like.

Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

