Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7046AA34A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 12:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfH3KLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 06:11:38 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57300 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfH3KLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 06:11:37 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7UABDNV087716;
        Fri, 30 Aug 2019 19:11:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Fri, 30 Aug 2019 19:11:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7UAB7vl087552
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 30 Aug 2019 19:11:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC][PATCH] fix d_absolute_path() interplay with fsmount()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     John Johansen <john.johansen@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-security-module@vger.kernel.org
References: <20190708131831.GT17978@ZenIV.linux.org.uk>
 <874l3wo3gq.fsf@xmission.com> <20190708180132.GU17978@ZenIV.linux.org.uk>
 <20190708202124.GX17978@ZenIV.linux.org.uk> <87pnmkhxoy.fsf@xmission.com>
 <5802b8b1-f734-1670-f83b-465eda133936@i-love.sakura.ne.jp>
 <1698ec76-f56c-1e65-2f11-318c0ed225bb@i-love.sakura.ne.jp>
 <e75d4a66-cfcf-2ce8-e82a-fdc80f01723d@canonical.com>
 <7eb7378e-2eb8-c1ba-4e1f-ea8f5611f42b@i-love.sakura.ne.jp>
 <16ae946d-dbbe-9be9-9b22-866b3cd1cd7e@i-love.sakura.ne.jp>
 <20190822035134.GK1131@ZenIV.linux.org.uk>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e97e7371-09a7-a7ba-4cc3-ab0d2bde9314@i-love.sakura.ne.jp>
Date:   Fri, 30 Aug 2019 19:11:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822035134.GK1131@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/08/22 12:51, Al Viro wrote:
> [bringing a private thread back to the lists]
> 
> There's a bug in interplay of fsmount() and d_absolute_path().
> Namely, the check in d_absolute_path() treats the
> not-yet-attached mount as "reached absolute root".

I think you can send this patch to linux-next.
