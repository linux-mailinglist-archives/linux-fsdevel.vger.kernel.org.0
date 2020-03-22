Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCE018EC18
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Mar 2020 21:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgCVURk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Mar 2020 16:17:40 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:36860 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgCVURk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Mar 2020 16:17:40 -0400
Received: by mail-pj1-f49.google.com with SMTP id nu11so5057474pjb.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2020 13:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=siZlRY8txSUJlhMo281aqD2ignUiFBwzsrA1ioFeCWc=;
        b=yQsE9jPoqIE9Ks0/g5mEGQfzQRvi2zC1UrkHqEfQrKl7cYDPxrg0ybOQtJlrEavwmC
         RsZZNBMfy6UuHKQjbibMDBT6BJ2crbcFTEIwo901wd5yLuuMjMJ0ofccfXoE4ni1ghvp
         3goncK7uf946Eu2zbw6d+OEMh/Py+tLu+PE0QPUhr15T5IEK01y5puXj0gIEueoulD+K
         isqP7MzEm5dSlrhiKDPyWintlWnKPgUROL2vz5ypj6hndnDAnCGK1dGMCtdScaBDRaUa
         h23JHJuit7ThaSEbGLPHCHiD2jVbb2veVPOXbXR2dmyjtSQK9faa1pdRV5JU9jBGJLqr
         W2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=siZlRY8txSUJlhMo281aqD2ignUiFBwzsrA1ioFeCWc=;
        b=iMbh5Slwudg1+K/kGA6YObW1O8nlx/hmIrPrI6bL9mGCmsmGm8Z1ZlBcNyMwoxXOnH
         RxwYUGo2P07iFmj8fCGUKyYUnZ+Ss0QSk5Tq1vF9Z2/mGiZIrgumlYmuAXtDd3pzi3Gf
         WzcDqHg9pSZpAl98aNOBkrVBZJaSv2onlhLQVpvHvSTQe/GbCs4cIYs9QqQdOFsHFU4T
         7DM2A0sz0nyc/m80RfDoJZJ7n/+T+CJM07fnHU/E7QNdhFD9bVO1bo78q7ygGN/qOjHU
         AXnSu3/nqFT6yZse3qr5NTdZUjnsQAkF5MAyIY+kuYD12MzEhATFpZa3UU4DBsY6XT6I
         u9EQ==
X-Gm-Message-State: ANhLgQ1Zj2RAauGUWHYAOvzTS7omB5Z3DFrhJ2kA0Slp96HhebMgBG2j
        6ppCd2+nvYGylLMqTXR8igJZOQ==
X-Google-Smtp-Source: ADFU+vs0g2AtePxKPH5/W1n2yu4vnWRlEivkRnKOvETnf9xMebrSFe6mc4pQWf0hdeBcXIZXZDgCOw==
X-Received: by 2002:a17:90b:3656:: with SMTP id nh22mr3943791pjb.71.1584908258528;
        Sun, 22 Mar 2020 13:17:38 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id m29sm963701pgl.35.2020.03.22.13.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2020 13:17:37 -0700 (PDT)
Subject: Re: INFO: task hung in io_queue_file_removal
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+538d1957ce178382a394@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <20200321123827.15256-1-hdanton@sina.com>
 <20200322020601.5136-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5f48249b-19f9-6c18-b849-d77db0b2f247@kernel.dk>
Date:   Sun, 22 Mar 2020 14:17:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200322020601.5136-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/21/20 8:06 PM, Hillf Danton wrote:
> 
> On Sat, 21 Mar 2020 14:03:24 -0600 Jens Axboe wrote:
>>
>> On 3/21/20 6:38 AM, Hillf Danton wrote:
>>>
>>> Flush work before waiting for completion.
>>>
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -5823,8 +5823,8 @@ static bool io_queue_file_removal(struct
>>>  
>>>  	if (pfile == &pfile_stack) {
>>>  		percpu_ref_switch_to_atomic(&data->refs, io_atomic_switch);
>>> -		wait_for_completion(&done);
>>>  		flush_work(&data->ref_work);
>>> +		wait_for_completion(&done);
>>>  		return false;
>>>  	}
>>>  
>>> --
>>>
>>> And perhaps a tiny cleanup: no deed to wait for completion as
>>> flushing work itself will wait until the work is done.
>>
>> Care to send this version as a real patch? Seems kind of pointless to
>> just do the above change with that in mind. And then at the same time
>> turn ->done into ->do_file_put or something, and make it a bool.
> 
> Have trouble making a patch with the ideas in your mind all folded in so
> it may be better that you do it this time leaving me a chance to learn
> a lesson.

Maybe my explanation wasn't quite clear! What I meant was that since
we're no longer using pfile->done, turn that ->done into a ->needs_kfree
or something, and make that a bool. So basically the same patch as the
one you posted, just making that naming (and type) change as well.

Does that help? Would prefer if you sent a patch, you already did
99% of the hard work.

-- 
Jens Axboe

