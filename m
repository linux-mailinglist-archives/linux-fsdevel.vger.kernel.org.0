Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE70B241F0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 19:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgHKRSL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 13:18:11 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56798 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbgHKRSK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:18:10 -0400
Received: from [10.137.106.139] (unknown [131.107.174.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id 364D420B4908;
        Tue, 11 Aug 2020 10:18:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 364D420B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597166289;
        bh=4CUNuNiiePWf1WTPIiwYBL13LZ+7k2/9/J/jpcaXW7A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PoJFWvdJ1RO9aetIAjmD0rk7oHcgoNUd11mJAo6cf98zwa1+fMROHW9q/uMp6iMeX
         Gx9jAgsZekiKh7pxAVZrnSCW536fsoku8TARzOm+dS5qqA/BlR8Bpa7J8vLGhpHHRD
         Yi+yCyW66KZsN6+KFh8r2FianF/MQzdF5N+1bL7A=
Subject: Re: [PATCH v7 0/7] Add support for O_MAYEXEC
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20200723171227.446711-1-mic@digikod.net>
 <202007241205.751EBE7@keescook>
 <0733fbed-cc73-027b-13c7-c368c2d67fb3@digikod.net>
 <20200810202123.GC1236603@ZenIV.linux.org.uk>
 <917bb071-8b1a-3ba4-dc16-f8d7b4cc849f@digikod.net>
 <CAG48ez0NAV5gPgmbDaSjo=zzE=FgnYz=-OHuXwu0Vts=B5gesA@mail.gmail.com>
 <0cc94c91-afd3-27cd-b831-8ea16ca8ca93@digikod.net>
From:   Deven Bowers <deven.desai@linux.microsoft.com>
Message-ID: <77d685ec-aba2-6a2c-5d25-1172279ceb83@linux.microsoft.com>
Date:   Tue, 11 Aug 2020 10:18:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0cc94c91-afd3-27cd-b831-8ea16ca8ca93@digikod.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/11/2020 1:48 AM, Mickaël Salaün wrote:

[...snip]

>>> It is a
>>> good practice to check as soon as possible such properties, and it may
>>> enables to avoid (user space) time-of-check to time-of-use (TOCTOU)
>>> attacks (i.e. misuse of already open resources).
>>
>> The assumption that security checks should happen as early as possible
>> can actually cause security problems. For example, because seccomp was
>> designed to do its checks as early as possible, including before
>> ptrace, we had an issue for a long time where the ptrace API could be
>> abused to bypass seccomp filters.
>>
>> Please don't decide that a check must be ordered first _just_ because
>> it is a security check. While that can be good for limiting attack
>> surface, it can also create issues when the idea is applied too
>> broadly.
> 
> I'd be interested with such security issue examples.
> 
> I hope that delaying checks will not be an issue for mechanisms such as
> IMA or IPE:
> https://lore.kernel.org/lkml/1544699060.6703.11.camel@linux.ibm.com/
> 
> Any though Mimi, Deven, Chrome OS folks?
> 

I don't see an issue with IPE. As long as the hypothetical new syscall
and associated security hook have the file struct available in the
hook, it should integrate fairly easily.

[...snip]
