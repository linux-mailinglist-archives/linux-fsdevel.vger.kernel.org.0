Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A55DFB3B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 16:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfKMP25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 10:28:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45288 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbfKMP25 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 10:28:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id n21so3010080ljg.12;
        Wed, 13 Nov 2019 07:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=eHN3oJvzngOstWucvggCQJs1qVsjrYE0aT79wNfZxF0=;
        b=PiT6v1oF/z8ndRDu3IQtqwt0ZdFOMuDJOjQ+lQB72WcqYjuNuQt0UMCAe7d5Hof1PX
         U4c1VBSlM+hCFIR4cLnofV+c6dBtiWBwts3PReuIXYKKFTYUgzMKMmdyjEaKIlsJ4qHb
         OfgOOsw4WwXuGX5g5llS/V0Cmz4kdA8YGntyO9mZ2FuK0TEZJ6D0gLPbrN3Oqp5R8e3r
         wG6aDCatmrm4IiZjQiwa+MKQKex+NoncYNQqIxnr9TwfnyDkGhtq/7fvZdg6HmzWRMdK
         ESy1m8TK+1asOnj9PB+17tscXlzbCHRp6J2xUreitjqYJ+pw42Sls4sS3FCtM6pHzVBA
         ngDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=eHN3oJvzngOstWucvggCQJs1qVsjrYE0aT79wNfZxF0=;
        b=cxvmHnjYkfGNnhno/5eMN0FiGGWNV5zcFm7QUWsXy8ACV9y+1h10BGra/X8hM2j7s1
         bhGzoYxYmlrYbcMbJGnmMryIDlhUZnlerMqcsXlzPOdgrhLBcqVKdGuMeT+vrxKDV3GE
         IuWxvIUJ/3MQmdQPyucyGDcXmP8fd7wEh5wKLvBns0t64orVYogEk+XJY4iwKkgJD0XJ
         CEaINT6ixE8xnycBm20h7sbWadntUWGRFQ/FSh1Ov3Ot/Jluw3ViRQjEzEoQNlMNClPq
         HitnVU+Bb7YCO2ir/MC4HZ+JJANlm0hQcZ3m0pclbRI9IZF3CcBW3VxaXV/G50VvAIge
         pmBg==
X-Gm-Message-State: APjAAAUNfkKOzLdJXAcjjdQHByfhaDnP3tLnC9Q1cHMLIaXdTuW0Rnym
        NN2F8eRo2Z8iIvouwQBL94TfNeR1
X-Google-Smtp-Source: APXvYqwn0dKaDZr1L/PaEHdOkc9Kj+A99l6tgP4djrlK7yDVVK/GNCweEoa1AslDT7gTcFY+eN14dw==
X-Received: by 2002:a05:651c:38f:: with SMTP id e15mr3030692ljp.107.1573658934687;
        Wed, 13 Nov 2019 07:28:54 -0800 (PST)
Received: from [192.168.1.36] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id a1sm1261762lfg.11.2019.11.13.07.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 07:28:54 -0800 (PST)
Subject: Re: [PATCH] proc: Allow restricting permissions in /proc/sys
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>
References: <ed51f7dd-50a2-fbf5-7ea8-4bab6d48279e@gmail.com>
 <201911121523.9C097E7D2C@keescook> <87ftir7rrw.fsf@x220.int.ebiederm.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <128e6282-8fa5-0d4b-62f2-0d7408b0d184@gmail.com>
Date:   Wed, 13 Nov 2019 17:28:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87ftir7rrw.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13.11.2019 16.52, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
>> Ah! I see the v2 here now. :) Can you please include that in your
>> Subject next time, as "[PATCH v2] proc: Allow restricting permissions
>> in /proc/sys"? Also, can you adjust your MUA to not send a duplicate
>> attachment? The patch inline is fine.
>>
>> Please CC akpm as well, since I think this should likely go through the
>> -mm tree.
>>
>> Eric, do you have any other thoughts on this?
> 
> This works seems to be a cousin of having a proc that is safe for
> containers.
> 
> Which leads to the whole mess that hide_pid is broken in proc last I
> looked.
> 
> So my sense is that what we want to do is not allow changing the
> permissions but to sort through what it will take to provide actual
> mount options to proc (that are per mount).  Thus removing the sharing
> that is (currently?) breaking the hide_pid option.
> 
> With such an infrastructure in place we can provide a mount option
> (possibly default on when mounted by non-root) that keeps anything that
> unprivileged users don't need out of proc.  Which is likely to be most
> things except the pid files.
> 
> It is something I probably should be working on, but I got derailed
> by the disaster that has that happened with mounting.    Even after
> I gave code review and showed them how to avoid it the new mount api
> is still not possible to use safely.

Are you perhaps referring to proc modernization patch set:

https://lkml.org/lkml/2018/5/11/155

Getting that reviewed and committed would be awesome!

-Topi
