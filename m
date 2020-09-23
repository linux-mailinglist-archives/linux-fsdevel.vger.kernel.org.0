Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B8527644D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 01:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIWXEL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 19:04:11 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47754 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWXEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 19:04:10 -0400
Received: from [192.168.254.38] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8074320B7179;
        Wed, 23 Sep 2020 16:04:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8074320B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600902250;
        bh=HgpNPjY5iVu1CzxgcR4kgt+n2CI09GHM7/xa0p1o1Kk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=muj4KSg6D89EDGio3heOxHCQwEdt6gWLUvMQcKlmrgOQqUz62EUPYL8kaIGhY51c7
         BiX3Nbq3xO6O7AV7JtpP/RXJguNQGwEe7nrqG4qvPO8M3K1jLBNuvwOX52gI+DcYSx
         kyoUN+2J9pxrSBa9emDc+4CJsNIRwh9UwZhyvp0k=
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, luto@kernel.org, David.Laight@ACULAB.COM,
        fweimer@redhat.com, mark.rutland@arm.com, mic@digikod.net
References: <210d7cd762d5307c2aa1676705b392bd445f1baa>
 <20200922215326.4603-1-madvenka@linux.microsoft.com>
 <20200923084232.GB30279@amd>
 <34257bc9-173d-8ef9-0c97-fb6bd0f69ecb@linux.microsoft.com>
 <20200923205156.GA12034@duo.ucw.cz>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <fe30c3bc-8bdb-4bf7-328d-84c9d449bc67@linux.microsoft.com>
Date:   Wed, 23 Sep 2020 18:04:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923205156.GA12034@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/23/20 3:51 PM, Pavel Machek wrote:
> Hi!
> 
>>>> Scenario 2
>>>> ----------
>>>>
>>>> We know what code we need in advance. User trampolines are a good example of
>>>> this. It is possible to define such code statically with some help from the
>>>> kernel.
>>>>
>>>> This RFC addresses (2). (1) needs a general purpose trusted code generator
>>>> and is out of scope for this RFC.
>>>
>>> This is slightly less crazy talk than introduction talking about holes
>>> in W^X. But it is very, very far from normal Unix system, where you
>>> have selection of interpretters to run your malware on (sh, python,
>>> awk, emacs, ...) and often you can even compile malware from sources. 
>>>
>>> And as you noted, we don't have "a general purpose trusted code
>>> generator" for our systems.
>>>
>>> I believe you should simply delete confusing "introduction" and
>>> provide details of super-secure system where your patches would be
>>> useful, instead.
>>
>> This RFC talks about converting dynamic code (which cannot be authenticated)
>> to static code that can be authenticated using signature verification. That
>> is the scope of this RFC.
>>
>> If I have not been clear before, by dynamic code, I mean machine code that is
>> dynamic in nature. Scripts are beyond the scope of this RFC.
>>
>> Also, malware compiled from sources is not dynamic code. That is orthogonal
>> to this RFC. If such malware has a valid signature that the kernel permits its
>> execution, we have a systemic problem.
>>
>> I am not saying that script authentication or compiled malware are not problems.
>> I am just saying that this RFC is not trying to solve all of the security problems.
>> It is trying to define one way to convert dynamic code to static code to address
>> one class of problems.
> 
> Well, you don't have to solve all problems at once.
> 
> But solutions have to exist, and AFAIK in this case they don't. You
> are armoring doors, but ignoring open windows.
> 

I am afraid I don't agree that the other open security issues must be
addressed for this RFC to make sense. If you think that any of those
issues actually has a bad interaction/intersection with this RFC,
let me know how and I will address it.

> Or very probably you are thinking about something different than
> normal desktop distros (Debian 10). Because on my systems, I have
> python, gdb and gcc...
> 
> It would be nice to specify what other pieces need to be present for
> this to make sense -- because it makes no sense on Debian 10.
> 

Since this RFC pertains to converting dynamic machine code to static
code, it has nothing to do with the other items you have mentioned.
I am not disagreeing that the other items need to be addressed. But
they are orthogonal.

Madhavan
