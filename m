Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176F93B2B71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 11:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhFXJdz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 05:33:55 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57041 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhFXJdy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:33:54 -0400
Received: from [192.168.1.155] ([77.7.27.132]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M1aQN-1lzNx301vv-0038oh; Thu, 24 Jun 2021 11:30:02 +0200
Subject: Re: [PATCH 09/14] d_path: introduce struct prepend_buffer
To:     Justin He <Justin.He@arm.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-9-viro@zeniv.linux.org.uk>
 <AM6PR08MB4376D92F354CD17445DC4EC1F7089@AM6PR08MB4376.eurprd08.prod.outlook.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <f9908c77-77e2-03fd-25a4-f7ce9802535e@metux.net>
Date:   Thu, 24 Jun 2021 11:29:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <AM6PR08MB4376D92F354CD17445DC4EC1F7089@AM6PR08MB4376.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sfvpKXDvULCjkaT9y937Ne5z1GzyOh9VPvzaOLJhF711BVKrxXE
 f7pUlG4so5Lu5QVaxlpQ2EL9HlPzxRK+AUMobdzoHIoDqRHY1aZB144FoW/ZwiXoEgl48ze
 AGdnd2i+XzkZyMjmzkqaZNScRJjYVhQ245nlW5NIEt2vw7fLjJq9X4kI4JwNVnJv+1YTwOq
 dC5faiBRfFkNqGZh+sv/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:veNOQNF1Dic=:Bw67innQLSKyp38PPApyoz
 qkcVF04DbgFNG6/wlk4Q6bSVdWbcXxklL5Rt32Vr1L0tXBqbrTfJAgsnBZkCHfqdYwIinD2xs
 Tn0x1VjHNWOT+9rOglTzxbnuSByKb2XDsa6CXqGPYo5cbiGdC/8aehbtBsftzci2SCZYBip/k
 TOrplAElsbpsxalCqChiK4APit7eK4g+l0Joen26PAMan8wD1N8j0ysMN2vVYdbk2qIYXUke/
 lyNh9KE70mmCBoteyuN5vBMikoAhincbsmp9SEjqiKS5De4DkIY1QH9UVxItKrIDlaI9pfEHD
 VZ5TJdTSlKliAEIdjj2G0dsofuk8GpnoYWg37blWDuMwESvj7/iSFa0bKbCaWiMuxuvEdD7Fr
 FBJJoe/Ulm0jSvmdh1WGloCnW7AbngUjUCVesgkNH780rg5CiIJ/Tz0YqFQ2mHTCPdKIjuywk
 eKqI1GOY3s6TzBTc8J/QXuYAs15vPEGjpuCWjpDXmCcCQk9UNe3Nubc+AIumK6pQTogzKJoam
 ZNIOVYJtMSeljuF3KU57jY=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

<snip>

>>         We've a lot of places where we have pairs of form (pointer to end
>> of buffer, amount of space left in front of that).  These sit in pairs of
>> variables located next to each other and usually passed by reference.
>> Turn those into instances of new type (struct prepend_buffer) and pass
>> reference to the pair instead of pairs of references to its fields.
>>
>> Declared and initialized by DECLARE_BUFFER(name, buf, buflen).
>>
>> extract_string(prepend_buffer) returns the buffer contents if
>> no overflow has happened, ERR_PTR(ENAMETOOLONG) otherwise.
>> All places where we used to have that boilerplate converted to use
>> of that helper.

this smells like a generic enough thing to go into lib, doesn't it ?


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
