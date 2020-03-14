Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAA818585A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 03:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgCOCEq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Mar 2020 22:04:46 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54034 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgCOCEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:04:44 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02E4RG0I007339;
        Sat, 14 Mar 2020 13:27:16 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Sat, 14 Mar 2020 13:27:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02E4RFiB007324
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 14 Mar 2020 13:27:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kernel/hung_task.c: Introduce sysctl to print all traces
 when a hung task is detected
To:     Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org, yzaikin@google.com,
        tglx@linutronix.de, kernel@gpiccoli.net
References: <20200310155650.17968-1-gpiccoli@canonical.com>
 <ef3b3e9a-9d58-60ec-d638-88ad57d29aec@canonical.com>
 <202003132011.8143A71FE@keescook>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c4b05b32-216a-e130-259f-0d9506ff9244@i-love.sakura.ne.jp>
Date:   Sat, 14 Mar 2020 13:27:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <202003132011.8143A71FE@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/03/14 12:12, Kees Cook wrote:
> On Fri, Mar 13, 2020 at 02:23:37PM -0300, Guilherme G. Piccoli wrote:
>> Kees / Testsuo, are you OK with this patch once I resend with the
>> suggestions you gave me?
> 
> I think so, yes. Send a v2 (to akpm with us in CC).
> 
>> Is there anybody else I should loop in the patch that should take a
>> look? Never sent sysctl stuff before, sorry if I forgot somebody heheh
> 
> akpm usually takes these kinds of things.
> 

Well, maybe sysctl_hung_task_all_cpu_backtrace = 1 by default is better for
compatibility? Please CC or BCC kernel-testing people so that they can add
hung_task_all_cpu_backtrace=1 kernel command line parameter to their testing
environments if sysctl_hung_task_all_cpu_backtrace = 0 by default.
