Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72B3C76A67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 15:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfGZN6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 09:58:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35607 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbfGZN6f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:58:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id y4so54581572wrm.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2019 06:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OHBqTEA6lm/JyJiQHKcANS/JCJ/e3JQqEWDJmrbUQX8=;
        b=Uiw5+9bNmAM4UoMLYPW0DyT5q8WxsTQ98haz0DI/oYrW9Ni1Fo2qC+aF1bskzVD0tV
         oaTtx+iW1QRcTATPc52pQFg9Ebz3UQUO0E5vITEsehKfUg22lyS1baDcR9GTuqfv97jk
         1/BQUvCMYYavyPQrvWnxOiSugy1u2it0VyhMotl/O3VpNs/aq0qmpiPXHY2dyl69xISe
         p3AIfObIW3cI/iQTObKMbYawNp4PVZVuR62Qv1YfzQUAw2QON4DIw2dv8e6tlXioR75n
         1w9KRIhlxRiHAIUfna0HWkdlEJxSC9f6/0v9IfZAFWDvK/KB9TgB+6xGeyq2fXnNjBon
         AeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OHBqTEA6lm/JyJiQHKcANS/JCJ/e3JQqEWDJmrbUQX8=;
        b=gQ+0Fc1DEDX/wDz80LGOY5bjIwsXwvlB+VYCV3tEpOx6auQVIWIE+hLtBKPMq2uU5w
         OBfiPGNU4H9OQ2RLaCzFrCZ24jsVybEgQLYAud4peZRytwaG8ZmEcjBc26M4QNL5TKK+
         KGanIcJhGQePX4Zl/5hOkoWOtXfB+upZkdaLMHNn8so29++NrcPRG8tqbjtKLOA8sj1Y
         nCYvUAvuHKdsRt84JfwPOTQ8NQ045GJSqMZ4GuKT+tEoIjfXUMCRDbToXQh1xYjP9KBy
         ISapqWfSyAc1RoTxgpmDHSq5FIuZ9qYHu4FycRkN8FCtmzm1fhHmFOGYrDS064U0xTZJ
         c4WA==
X-Gm-Message-State: APjAAAVejUILnDppUNzyGtdj5p+n9ysbaMgclIkl9/wLCSnQb4s2rCne
        drXcgd0QXtDWdBidi6OAKp0lR5v27IBncsIhpSapmZaKplA728Wb/G1MPvCvSlTIqcG+4P5M/sU
        fJOFGY8DYjFrMGXmLtrsbELBBKbD1OAyBOD+yusdZPIbY+CdNafIbJ4zbouxP1/Kns6rEl8Vfqr
        EmjJMRXzc1258pvwF5R0ncSiZMvFiJU2Hc32xY
X-Google-Smtp-Source: APXvYqwvJxhcLQvBBrKt39JjVYUcq6uNPBpS9CONWcVP/QiYDpLv187OimwvKYfe9H7d+gWH3MwvIA==
X-Received: by 2002:adf:f186:: with SMTP id h6mr777980wro.274.1564149513322;
        Fri, 26 Jul 2019 06:58:33 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r123sm48645151wme.7.2019.07.26.06.58.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 06:58:32 -0700 (PDT)
Subject: Re: [PATCH] hung_task: Allow printing warnings every check interval
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190724170249.9644-1-dima@arista.com>
 <2964b430-63d6-e172-84e2-cb269cf43443@i-love.sakura.ne.jp>
 <aa151251-d271-1e65-1cae-0d9da9764d56@arista.com>
 <9a919c32-4e0e-ca1b-887f-c329543913d3@i-love.sakura.ne.jp>
 <41fd7652-df1f-26f6-aba0-b87ebae07db6@i-love.sakura.ne.jp>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <eb3d9058-a623-3c10-68e2-f11498a7c174@arista.com>
Date:   Fri, 26 Jul 2019 14:58:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <41fd7652-df1f-26f6-aba0-b87ebae07db6@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/26/19 2:28 PM, Tetsuo Handa wrote:
> On 2019/07/26 20:29, Tetsuo Handa wrote:
>> On 2019/07/25 23:25, Dmitry Safonov wrote:
>>> Yes, also current distributions already using the counter to print
>>> warnings number of times and then silently ignore. I.e., on my Arch
>>> Linux setup:
>>> hung_task_warnings:10
>>
>> You can propose changing the default value of hung_task_warnings to -1.
>>
>> Current patch might be inconvenient because printk() from hung_task_warning(t, false)
>> fails to go to consoles when that "t" was blocked for more than "timeout" seconds, for
>>
>> 	if (sysctl_hung_task_panic) {
>> 		console_verbose();
>> 		hung_task_show_lock = true;
>> 		hung_task_call_panic = true;
>> 	}
>>
>> path which is intended to force printk() to go to consoles is ignored by
>>
>> 	/* Don't print warings twice */
>> 	if (!sysctl_hung_task_interval_warnings)
>> 		hung_task_warning(t, true);
>>
>> when panic() should be called. (The vmcore would contain the printk() output which
>> was not sent to consoles if kdump is configured. But vmcore is not always available.)

Fair enough.

>>> Yes, that's why it's disabled by default (=0).
>>> I tend to agree that printing with KERN_DEBUG may be better, but in my
>>> point of view the patch isn't enough justification for patching
>>> sched_show_task() and show_stack().
>>
>> You can propose sched_show_task_log_lvl() and show_stack_log_lvl() like show_trace_log_lvl().

I'll try, not sure how well it will go..

>>
>> I think that sysctl_hung_task_interval_warnings should not be decremented automatically.
>> I guess that that variable should become a boolean which controls whether to report threads
>> (with KERN_DEBUG level) which was blocked for more than sysctl_hung_task_check_interval_secs
>> seconds (or a tristate which also controls whether the report should be sent to consoles
>> (because KERN_DEBUG level likely prevents sending to consoles)), and
>> hung_task_warning(t, false) should be called like
>>
>> 	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ)) {
>> 		if (sysctl_hung_task_interval_warnings)
>> 			hung_task_warning(t, false);
>> 		return;
>> 	}
>>
>> rather than
>>
>> 	if (sysctl_hung_task_interval_warnings)
>> 		hung_task_warning(t, false);
>> 	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ))
>> 		return;

Good point, will do.

> Well, another direction is to disassociate sysctl_hung_task_panic from
> sysctl_hung_task_timeout_secs. Since nobody would want to call panic() when
> a thread was blocked for only one second, allow sysctl_hung_task_panic to
> specify larger than 1, and interpret it as sysctl_hung_task_timeout_secs for
> calling panic(). Roughly speaking:
> 
> -	if (sysctl_hung_task_panic) {
> +	unsigned long panic_timeout = READ_ONCE(sysctl_hung_task_panic)
> +	if (panic_timeout == 1 || (panic_timeout > 1 &&
> +	     (jiffies - t->last_switch_time) / HZ >= panic_timeout)) {
>  		console_verbose();
>  		hung_task_show_lock = true;
>  		hung_task_call_panic = true;
>  	}
> 
> If use of different loglevel is not a requirement for you, this would be the simplest.

No, we consider such messages as notifications/warnings, rather than
complete failures. So, it would be better to hide them from console.
They're also not rate-limited which is a bummer with slow serial
consoles that we've on some devices (9600).

Thanks for the review,
          Dmitry
