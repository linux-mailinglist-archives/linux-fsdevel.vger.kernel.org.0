Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03F6517FECF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 14:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgCJNks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 09:40:48 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:39386 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgCJNks (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:40:48 -0400
Received: by mail-qt1-f176.google.com with SMTP id e13so9644441qts.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5vu1i6JU9zdD/JCzCOO+f8X/TnDT40+qLiG1pRNeZis=;
        b=Iq0NtN8iD4XI731ngV4spLqbk12fnGylmVITnZ9bxj57mUoRVxK+PwvvLPM/3tAibN
         gBoInvL2JHteW6v2glnccwOP0mraO0+z90GVHrCGy7WbKgT6IRWLcRpvLhCN8UIFZ3YT
         +fJKcI1b+B2tANT1L4y58qeoCR906gvWzfhI3HQQd/7LH8fPWPc42pLuLzpGUnlfPvbS
         r1nWj7/gZKUiN4mNDc/iC6LgZcTuqggj1UpNx0xfrZWiaN97k9FhC/+t6q/06RBDX3in
         5gW5xH151Mk+BVxx5QlvJYZaAaVfbk1qPd0l4LURVqryvAMCk85iACLBrHmhf3S8ym83
         8ZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5vu1i6JU9zdD/JCzCOO+f8X/TnDT40+qLiG1pRNeZis=;
        b=eZeAPAcj4kAXEkG3pk8yuBBG3sXfoWJA4tOTrRTuZIO+uhv/AjrDRXk8Ot41KYc/8R
         +AiO7aocZK+YDibnZuOBiN36Wvz3Uu+6R247f2tdh8pz8UfbDodSdOKt9dzHC6oEei4P
         eNOkdvzzT3L+BG0g74Oo/BLmGitRPbwO8tbTvKotqY2pQum5BZns6GgN2tnJpaVsk89A
         Te2C8F0X3ONPloPEG5vPavRfaZQFy2gVY5Pl/6lA1rXJ10VL0MeEW0/e3mOfe+1KoInD
         +o0PzrV2pE9I8+MMG0H/jKxt4AWI27vADcVNCIPG1rFydMwE1osd9o0Yqejh1xQ4kWCX
         0i7Q==
X-Gm-Message-State: ANhLgQ06uwMscqhi8An84puzMG1Fvy5qDrq07vyghuDpSNUjG8LFwpx0
        dc3vBvEE8l0pWCabCHEVY6pb4A==
X-Google-Smtp-Source: ADFU+vvXpqPLW9e1zszFsYrKPp4ZWimWnYZzklyddrU/6qoFJquPIgbZA2vWptCYb3Gq5Q8poW2WOg==
X-Received: by 2002:ac8:6753:: with SMTP id n19mr18773081qtp.193.1583847645476;
        Tue, 10 Mar 2020 06:40:45 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w132sm1652276qkb.96.2020.03.10.06.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 06:40:44 -0700 (PDT)
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
To:     Michal Hocko <mhocko@kernel.org>
Cc:     lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
 <20200310131339.GJ8447@dhcp22.suse.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8b09da1d-d170-3857-4478-78afb647b551@toxicpanda.com>
Date:   Tue, 10 Mar 2020 09:40:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310131339.GJ8447@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/10/20 9:13 AM, Michal Hocko wrote:
> On Fri 06-03-20 09:35:41, Josef Bacik wrote:
>> Hello,
>>
>> This has been a topic that I've been thinking about a lot recently, mostly
>> because of the giant amount of work that has been organizing LSFMMBPF.
> 
> There is undoubtedly a lot of work to make a great conference. I have hard
> time imagine this could be ever done without a lot of time and effort on
> the organizing side. I do not believe we can simply outsource a highly
> technical conference to somebody outside of the community. LF is doing a
> lot of great work to help with the venue and related stuff but content
> wise it is still on the community IMHO.
> 
> [...]
>> These are all really good goals, and why we love the idea of LSFMMBPF.  But
>> having attended these things every year for the last 13 years, it has become
>> less and less of these things, at least from my perspective.  A few problems
>> (as I see them) are
>>
>> 1) The invitation process.  We've tried many different things, and I think
>> we generally do a good job here, but the fact is if I don't know somebody
>> I'm not going to give them a very high rating, making it difficult to
>> actually bring in new people.
> 
> My experience from the MM track involvement last few years is slightly
> different. We have always had a higher demand than seats available
> for the track. We have tried really hard to bring people who could
> contribute the most requested topic into the room. We have also tried to
> bring new contributors in. There are always compromises to be made but
> my recollection is that discussions were usually very useful and moved
> topics forward. The room size played an important role in that regard.
> 
>> 2) There are so many of us.  Especially with the addition of the BPF crowd
>> we are now larger than ever.  This makes problem #1 even more apparent, even
>> if I weighted some of the new people higher who's slot should they take
>> instead?  I have 0 problems finding 20 people in the FS community who should
>> absolutely be in the room.  But now I'm trying to squeeze in 1-5 extra
>> people.  Propagate that across all the tracks and now we're at an extra
>> 20ish people.
> 
> Yes, BPF track made the conference larger indeed. This might be problem
> for funding but it didn't really cause much more work for tracks
> organization (well for MM at least).
> 
>> 3) Half the people I want to talk to aren't even in the room.  This may be a
>> uniquely file system track problem, but most of my work is in btrfs, and I
>> want to talk to my fellow btrfs developers.  But again, we're trying to
>> invite an entire community, so many of them simply don't request
>> invitations, or just don't get invited.
> 
> I do not have the same experience on the MM track. Even though the whole
> community is hard to fit into the room, there tends to be a sufficient
> mass to move a topic forward usually. Even if we cannot conclude many
> topics there are usually many action items as an outcome.
> 
> [...]
> 
>> So what do I propose?  I propose we kill LSFMMBPF.
> 
> This would be really unfortunate. LSFMMBPF has been the most attractive
> conference for me exactly because of the size and cost/benefit. I do
> realize we are growing and that should be somehow reflected in the
> future. I do not have good answers how to do that yet unfortunately.
> Maybe we really need to split the core agenda and topics which could be
> discussed/presented on other conferences. Or collocate with another
> conference but I have a feeling that we could cover more since LSFMMBPF
> 

LSFMMBPF is still by far the most useful conference I attend, so much so that 
it's basically the only thing I attend anymore.

My point is less about no longer having a conference at all, and more about 
changing what we currently have to be more useful to more people.  For MM, and I 
assume BPF, it's much different as you guys are all on the same codebase.  You 
get 25 people in the room chances are a much larger percentage of you are 
interested in each individual topic.

File systems and storage?  Way less so.  We've expanded to 3 days of conference, 
which has only exacerbated this issue for me.  Now I have a full day that I'm 
trying to fill with interesting topics that we're all interested in, and it's a 
struggle.  If instead we had everybody from the file system community there then 
I could just say "OK day 3 is BoF day, have your FS specific meetups!" and be 
done with it.  But as it stands I know XFS is missing probably 1/3 of their main 
contributors, and Btrfs is missing 1/2 to 2/3 of our developers.

In order to accomplish that we need to radically change the structure of the 
conference, hence my hyperbolic suggestion.  I think what Ted suggested is 
probably my ideal solution, we have a kernel focused spring conference where the 
whole community gets together, and then we have tracks that we carve up.

But is it a problem worth solving?  I'm not sure.  I know how I feel, but maybe 
I'm the crazy one.  I think its worth discussing.  If more people like how we 
currently do it then we can just keep trucking along.  It's not like I'll stop 
showing up, this is still a tremendously useful conference.  I just think we can 
do better.  Thanks,

Josef
