Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F4E17C303
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 17:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCFQbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 11:31:49 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:45626 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgCFQbt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:31:49 -0500
Received: by mail-qt1-f182.google.com with SMTP id a4so2102102qto.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 08:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UUSOJf+zzacEOEP9td3eEtXJWkTaibOb7Kq1LOm7AIg=;
        b=Sa9/tVXXId0i+ZkGnCOQqMm/YwmWBR6mR5Ert555HnfoqDYeWAyStfmeKNig1vQ6lT
         JSU6LwefTLFnXO059CxcX5hoSrgXp3DK+ZvC8+0f2Ndb9Oh8zKuNn8QjdZ5YIBpwsN1A
         Y3b6owF+xPxDq3J2FpHKeYk4ACb7Z6VDzWTXGRU5cN+PRbM1SVWIOGaL2iDpJP0XNXG1
         6r0Con0dYegUQQcNrLBwhemitVup6gffpqAolIUljsz710Bol1blQvCKg+k+eSNFdzHT
         u67YAxGd0FuG40KNnSbaPS/hNPtqCiccdXcDxhu9d4e9ozFh/hYCI31Uv9Qd0AalNCla
         E1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UUSOJf+zzacEOEP9td3eEtXJWkTaibOb7Kq1LOm7AIg=;
        b=dNmumIe4xvAPwtFcXwxLoq8Sf1ylVAmP7nF+Vq9NmY/KeuPfjhxkFOTe7zVaLM5yk7
         ZXHbmrBSs5k+yawsiz66L9+0GtO/a1nSDIInmtp+VGqKhAnTwEj5F6GKO989k1C3x1BQ
         0NBKKPzf8Bnq3J6rKQgFAjdJv7WW1xyj7GN5lkHilg3V4P4eZOGmpTXaeI96vtTigxgd
         NJosFFDlzyBFUgggomgAcWkOnRtLXHXEop577l15drtQZ7/UXgdbxaK5odSV84AkZt8q
         NzcPtb5r4P7p3lR0XkIiz7nbtv4Qu2+o8asMBgzSUUDuwKDqi42Qbz82miuna3i7Ohq1
         KYPw==
X-Gm-Message-State: ANhLgQ2YaDzO6NihYqSlomVXmIbImRbY5MmBhvReCYMrVoxEi80bULOX
        3U9mhKv46g79nlWn/gmUPS1zkw==
X-Google-Smtp-Source: ADFU+vvDeMAzUoSiB4u1rD7bbt/71U5nIFGqZVf2AiNnhdP0rj/eFgB6XllAkXoq6eYBnOKu7Yp1Gg==
X-Received: by 2002:ac8:3027:: with SMTP id f36mr3638204qte.76.1583512307131;
        Fri, 06 Mar 2020 08:31:47 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 17sm995481qkm.105.2020.03.06.08.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 08:31:46 -0800 (PST)
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
 <1583511310.3653.33.camel@HansenPartnership.com>
 <20200306162858.zy6u3tvutxvf27yw@wittgenstein>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e928fa83-3076-8c7a-7c99-91bf63f3c8ee@toxicpanda.com>
Date:   Fri, 6 Mar 2020 11:31:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306162858.zy6u3tvutxvf27yw@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/6/20 11:28 AM, Christian Brauner wrote:
> On Fri, Mar 06, 2020 at 08:15:10AM -0800, James Bottomley wrote:
>> On Fri, 2020-03-06 at 09:35 -0500, Josef Bacik wrote:
>>> Many people have suggested this elsewhere, but I think we really need
>>> to seriously consider it.  Most of us all go to the Linux Plumbers
>>> conference.  We could accomplish our main goals with Plumbers without
>>> having to deal with all of the above problems.
>>
>> [I'm on the Plumbers PC, but not speaking for them, just making general
>> observations based on my long history helping to run Plumbers]
>>
>> Plumbers has basically reached the size where we can't realistically
>> expand without moving to the bigger venues and changing our evening
>> events ... it's already been a huge struggle in Lisbon and Halifax
>> trying to find a Restaurant big enough for the closing party.
>>
>> The other reason for struggling to keep Plumbers around 500 is that the
>> value of simply running into people and having an accidental hallway
>> track, which is seen as a huge benefit of plumbers, starts diminishing.
>>   In fact, having a working hallway starts to become a problem as well
>> as we go up in numbers (plus in that survey we keep sending out those
>> who reply don't want plumbers to grow too much in size).
>>
>> The other problem is content: you're a 3 day 4 track event and we're a
>> 3 day 6 track event.  We get enough schedule angst from 6 tracks ... 10
>> would likely become hugely difficult.  If we move to 5 days, we'd have
>> to shove the Maintainer Summit on the Weekend (you can explain that one
>> to Linus) but we'd still be in danger of the day 4 burn out people used
>> to complain about when OLS and KS were co-located.
>>
>> So, before you suggest Plumbers as the magic answer consider that the
>> problems you cite below don't magically go away, they just become
>> someone else's headache.
>>
>> That's not to say this isn't a good idea, it's just to execute it we'd
>> have to transform Plumbers and we should have a community conversation
>> about that involving the current Plumbers PC before deciding it's the
>> best option.
> 
> It's unlikely that this could still be done given that we're also facing
> a little uncertainty for Plumbers. It seems like a lot of additional
> syncing would be needed.
> But the main concern I have is that co-locating both is probably quite
> challenging for anyone attending both especially when organizing
> something like a microconference.
> 

Yeah I want to be clear I'm not talking about this years conference, I'm talking 
about future conferences and if/how we want to make changes.

I picked plumbers because by-in-large the overlap between plumbers attendance 
and LSFMMBPF attendance is pretty large, but obviously it doesn't have to be 
just that.  Ted and others have suggested having a larger more inclusive 
conference opposite of plumbers, which I think is a really cool idea.  Thanks,

Josef
