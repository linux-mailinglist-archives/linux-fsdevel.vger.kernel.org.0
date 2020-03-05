Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E09B817A27D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 10:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCEJus (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 04:50:48 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61231 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgCEJus (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:50:48 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0259nRau006066;
        Thu, 5 Mar 2020 18:49:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Thu, 05 Mar 2020 18:49:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0259nKcd006026
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 5 Mar 2020 18:49:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: fs/buffer.c: WARNING: alloc_page_buffers while mke2fs
To:     Jan Kara <jack@suse.cz>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>, ak@linux.intel.com,
        jlayton@redhat.com, tim.c.chen@linux.intel.com,
        willy@infradead.org, LTP List <ltp@lists.linux.it>,
        Jan Stancek <jstancek@redhat.com>, chrubis <chrubis@suse.cz>,
        lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYs==eMEmY_OpdhyCHO_1Z5f_M8CAQQTh-AOf5xAvBHKAQ@mail.gmail.com>
 <20200305093832.GG21048@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c875cdda-212e-d88c-6456-c270586be1ef@i-love.sakura.ne.jp>
Date:   Thu, 5 Mar 2020 18:49:20 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305093832.GG21048@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/03/05 18:38, Jan Kara wrote:
> On Tue 03-03-20 14:15:24, Naresh Kamboju wrote:
>> [Sorry for the spam]
>>
>> Linux-next 5.6.0-rc3-next-20200302 running on arm64 juno-r2 device while
>> running LTP syscalls chown tests.
>>
>> Suspecting commits are (did not do git bisect),
>> b1473d5f3d0 fs/buffer.c: dump more info for __getblk_gfp() stall problem
>> b10a7ae6565 fs/buffer.c: add debug print for __getblk_gfp() stall problem
> 
> These are almost certainly unrelated. If I'm looking right, the warning is
> coming from memalloc_use_memcg() called from alloc_page_buffers()
> complaining that memcg to charge is already set. But I don't see how that
> would be possible (at least with today's linux-next). Can you reproduce the
> problem with today's linux-next?
> 

Already handled as
https://lore.kernel.org/linux-mm/20200303162948.a383cb88c4a1b0bfd3817798@linux-foundation.org/ .
