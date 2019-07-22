Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86229703D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 17:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfGVPeH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 11:34:07 -0400
Received: from sonic315-54.consmr.mail.gq1.yahoo.com ([98.137.65.30]:35160
        "EHLO sonic315-54.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728794AbfGVPeH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1563809646; bh=EOZah5kUC13bHcvzbSgLDufxhi1Qe63umVH2WdpN0zc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=DxrhCFr0vEoGtuPSEwDUdKRq/z7am8XzmOEhxBQ5CcF7RRdcXbRXHw624852DQZYTJCRmVqL0XFOFwOMQjdmeIeaGqcZNTAd52g7yER4fSvvdjNwvFKqakZlgxliCe33kGPCgV5N0QiTNu85lWiKOlZ5eXOGa9xeC1yRd5rjpBPvUeSpL4GEaB2acJ7Gcbpw3ul2ZioPNlRleh8p/RBjpDTHwcrYre3BgNcY7D0LUj1PUongw01Bb/M+enFkJbM8S1R8sOT09nwG65+h4V055QjdmnNXJMWrgUpHonWrMkqkqHhwAJ9qN+t0muS5IKvgY4dPq9m2radPwtvZbOf1MA==
X-YMail-OSG: npDf6yEVM1l7Au6.Y9Yh_F.QhiCu80KA5a5gBgLLnq1JMpXQ8nbGuncLU.ihvVs
 6Q0yj9DSCBoNXyHCMiky2sHeXEzdNdrXblp30TLaWVW2R4twm9RDb82qGFnlJmCMyykggZTveFAS
 hoeOrUfypJKcIoaCkRO939wBppDieXbeNiLA0e0v2UCySWVRjtqun6uVhCfwiCzizTtpFrJDPXix
 AnHnPotG6JJ4nw5scbOcqzIEsqBEhtXvPzP6IQKq6nUqOGMTEmKZL1yif1Nhkgcu1DCQIcjSsD6o
 YjMbQwsb1M8OvaYfS0H5DCyp_zxgy55vcT.4wH8ywzZqcQulh4n4AK1TwWklOn.06WF3tp4zfAMm
 xnCWKvtZ1VymMxZqcht9D2ZMM9FiSA94JgQsP_0GRdz6n_OUEK3qGQToV9d4OihZm0Dh4pFx2tRz
 1cKRxnO8xzq3JrUqoeHGG49NsyiVOLDZqQtO7WyvYAzdxKnwea.hFpddwUXVV5bhTAQ4OHK2wJ4L
 bADYE6BZfEUVLJlTkGzRWK9ieZtwYZKx8iqorSrof.yONKWselSGlX9MT16UGc8JHb0J0lEc4i3E
 JeRRvayuQb74P5Rfqb0SLGrhewwXr6yRqUDX7SKH9.REnopvMEBElllg.8q02NNRVk0EQRTFwvyJ
 Tnkk6lfDJU2oHQARdJ9y.jijtVf.WBMXhkI4FZOu70u63CY6S9s.hicMwUxa5HybU6xt.hJ5lmDn
 Ush0VkPYJpl5MZ7pBkf4omcfdTBvf5vFkJPYa2UiFuvyYgFrfb95XpB4Flt2Htn5O8Jge0sZNuRo
 mg5qgdLxlPE4BBBuam28749g6L0dJAk2oNUThJaaknYZ_DTFF_2Qen5KWvrJ26U35FoLa2_idsTT
 rMG3M5E5Jg1GAZbVJnV7I3am6.KQ41Wn5KU4RitPSg08ZmwGTspQjWAFj.aDrGx0OdIMa02sEqZ8
 zumJf7lvMJzZOlfitRgFSD0p0tjWdsqDoPDnIEcUOM4IwN6_6pJYSvnZxeCj9sRyc3y.LR2PfApp
 6gxE.YkwFRl5tt7bep8s2idFnrEzKSdUemabNWb3oel3ELwpL38YYblKhnACGk06XBvw9fPdOO.r
 ly3EY3DVgBCl92GHVbypxGep.W_OJm6q3j.JqzFvMqoQbV_JkPzcNo7PPZZqxrdnUJEwG9pfe5OZ
 xjnWCXnGGAyHr_eth18VYfXJVcnOiHmBLxiiGDnoo6qnkezzmKh7vSqEXLtvsDGdRwA_pXT0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Mon, 22 Jul 2019 15:34:06 +0000
Received: by smtp415.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7d543092b26e4fc618ecf41b7b8d639f;
          Mon, 22 Jul 2019 15:34:04 +0000 (UTC)
Subject: Re: [PATCH v3 12/24] erofs: introduce tagged pointer
To:     Steven Rostedt <rostedt@goodmis.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-13-gaoxiang25@huawei.com>
 <CAOQ4uxh04gwbM4yFaVpWHVwmJ4BJo4bZaU8A4_NQh2bO_xCHJg@mail.gmail.com>
 <39fad3ab-c295-5f6f-0a18-324acab2f69e@huawei.com>
 <CAOQ4uxgo5kvgoEn7SbuwF9+B1W9Qg1-2jSUm5+iKZdT6-wDEog@mail.gmail.com>
 <20190722104048.463397a0@gandalf.local.home>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <0c2cdd4f-8fe7-6084-9c2d-c2e475e6806e@aol.com>
Date:   Mon, 22 Jul 2019 23:33:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722104048.463397a0@gandalf.local.home>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Steven,

On 2019/7/22 ????10:40, Steven Rostedt wrote:
>>> and I'm not sure Al could accept __fdget conversion (I just wanted to give a example then...)
>>>
>>> Therefore, I tend to keep silence and just promote EROFS... some better ideas?...
>>>  
>> Writing example conversion patches to demonstrate cleaner code
>> and perhaps reduce LOC seems the best way.
> Yes, I would be more interested in seeing patches that clean up the
> code than just talking about it.
> 

I guess that is related to me, though I didn't plan to promote
a generic tagged pointer implementation in this series...

I try to describe what erofs met and my own implementation,
assume that we have 3 tagged pointers, a, b, c, and one
potential user only (no need to ACCESS_ONCE).

One way is

#define A_MASK		1
#define B_MASK		1
#define C_MASK		3

/* now we have 3 mask there, A, B, C is simple,
   the real name could be long... */

void *a;
void *b;
void *c;		/* and some pointers */

In order to decode the tag, we have to
	((unsigned long)a & A_MASK)

to decode the ptr, we have to
	((unsigned long)a & ~A_MASK)

In order to fold the tagged pointer...
	(void *)((unsigned long)a | tag)

You can see the only meaning of these masks is the bitlength of tags,
but there are many masks (or we have to do open-coded a & 3,
if bitlength is changed, we have to fix them all)...

therefore my approach is

typedef tagptr1_t ta;	/* tagptr type a with 1-bit tag */
typedef tagptr1_t tb;	/* tagptr type b with 1-bit tag */
typedef tagptr2_t tc;	/* tagptr type c with 2-bit tag */

and ta a; tb b; tc c;

the type will represent its bitlength of tags and we can use ta, tb, tc
to avoid masks or open-coded bitlength.

In order to decode the tag, we can
	tagptr_unfold_tags(a)

In order to decode the ptr, we can
	tagptr_unfold_ptr(a)

In order to fold the tagged pointer...
	a = tagptr_fold(ta, ptr, tag)


ACCESS_ONCE stuff is another thing... If my approach seems cleaner,
we could move to include/linux later after EROFS stuffs is done...
Or I could use a better tagptr approach later if any...

Thanks,
Gao XIang



