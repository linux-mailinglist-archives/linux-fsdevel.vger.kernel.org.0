Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01063705C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 18:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbfGVQwb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 12:52:31 -0400
Received: from sonic316-54.consmr.mail.gq1.yahoo.com ([98.137.69.30]:39107
        "EHLO sonic316-54.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727021AbfGVQwb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1563814350; bh=+/7np4FvOppMR9Hf/eQxNoXzqpdKSRbs1I6bZt2UJ40=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=X6sWygAGuqfUgp75ROg5xSq7l5O2IjRks7AVIlvspODL2N9BhL1kDzaRObLFMlu8emxd2RLdH53eDGjWoMCoW2D6KbF2FE8pMxXTJhsR76v/Ozz4VGbTdCBBJ/WRVZ/fcEvjpoP+z9BeM5kEdCpLzbQsL6JcUrBTGhlusK8JJ7lLNsmPxqnUHw3OcLw+WCu2TgEtVZr52Yc1pjEP8/qIhJ9NnirSU2eCEdI7S3ATGA3dR2yD3zkx2v6MW2qcF2pDZ5EHW1AcFkzs7yEU1E6lJptYoiAjsfP3ho3TRJADVWl0lh3YuS+jI1hgY8uAF1xk45T/ICG8CRkJ/HUQgrPiNw==
X-YMail-OSG: 7mUnhZ0VM1mdbBsgLOwGGOHmwMtvDtQE7eENg83jN0mkP4RUNMNHU9GIn.Ll8dy
 szGhTNA0ZIbinU.B9RfRBHEL80BMJRj4Eue5nnUmw6nOUbHhskhcSuVtttowGK4q5Yu9H4Vpd_3d
 hGeM4yB.cfwoSlnMf_zFR14nbjPo2Ba1VU1MkqAcsErp5SA_MztAYz9ZC_ysVHoUTxo_gm00jUp2
 9JCdGciZuYS4n4YOFa.nC_ZvXPA22I_8YlCBULrdV4KBqArqO1Ii0aogVpa_ZhugGM6lBH42hGt7
 0F2.tWIVP6X10DiMFp96o3lck69dLmScvYTOW5uivlW_kup42JMbTyEBRgiUyFN6tDw5DGii3t41
 ZJEjyNu0b7Il4Gyo6nZft9dcj.oro21Riof99754opovfYziPReDh9CH2k38ADyTdnG1x1ZSELtm
 44iysiZBcw1BvdnPIDnvk2uD1qKsxlxYueoK9LBBDSYuH8_GZxskpwDowsee0JPEygILzBqV1Dj7
 FrBkF7NxwYbqKXGmBsdHLrGaxpVpU1fUjrTbC5sTEr.gHiDswsTjybvlu7MMfmZoViHEW7P.aVmX
 mHKUk5Hij9WgPOuOK23aSuu9XkVHg.tn5RGKj42doquhRnYNWZ_EDpSHMKyQYOzd4QxcgaNchubC
 oWI_uaW21cfwMokc8lHvSRi.Lq8wOxzLTWdEHtoAzvdXdjTVi7e2LY_8Zt5q0sK7N3KrQH1vZQcz
 xlZGZ.sdhvkSLYW31e9xm6QVKixcUepKmtNKjD8wt.qczdyJ_L1MRZ2BI5EBkfEmfNpAI9cyDc9I
 bM3y6eg_w4vz4t9llHdpxVloO2nqvg5_W.X7C6kL.OzWepycJ9O0H8.cjrEqxbk5dXRyQCdvdj3o
 6ZlcLeadJlxY0bAh6XSG7LYq1YstpiopTW5P0clR2P9KDlRKwf.1su7WasPLe8j0mt.QH_cbN1fy
 tw6_tyiUlI9GcNBrUV.b_lHdQd_9LIb8ss9HitVzA6PpXX6DwzL85wmMtjZ4XYfy8m7e0pKnSUxI
 epITVX5BALgw0ynLy1HXHEWw79qlBj9udhJ_l0ZnmGRhHDxRcQwOsRmbQjgeNwHAT.uXm2raNpyf
 vQkYb9Mm4r3Ko9x8IRG.Nyt4GfwPSQ1l7N599PvuP0sDCx1MFBRbgwiBDeXE2TNsrQsT_guJ1Uq0
 NMWS7m1REosIvBs_QxPK4Sq22II3YEeVRvi3FFTbqk3PX5DhkoeeB7uPtloCJEw_HmrIEIKgupcU
 FctUVfufA
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Mon, 22 Jul 2019 16:52:30 +0000
Received: by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d88bfb998e3ead874cbe21f5d0ea57ed;
          Mon, 22 Jul 2019 16:52:26 +0000 (UTC)
Subject: Re: [PATCH v3 12/24] erofs: introduce tagged pointer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, devel@driverdev.osuosl.org,
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
 <0c2cdd4f-8fe7-6084-9c2d-c2e475e6806e@aol.com>
 <20190722123502.328cecb6@gandalf.local.home>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <25e5dd99-b110-45f8-f769-5372ff01510f@aol.com>
Date:   Tue, 23 Jul 2019 00:52:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722123502.328cecb6@gandalf.local.home>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/7/23 ????12:35, Steven Rostedt wrote:
> On Mon, 22 Jul 2019 23:33:53 +0800
> Gao Xiang <hsiangkao@aol.com> wrote:
> 
>> Hi Steven,
>>
>> On 2019/7/22 ????10:40, Steven Rostedt wrote:
>>>>> and I'm not sure Al could accept __fdget conversion (I just wanted to give a example then...)
>>>>>
>>>>> Therefore, I tend to keep silence and just promote EROFS... some better ideas?...
>>>>>    
>>>> Writing example conversion patches to demonstrate cleaner code
>>>> and perhaps reduce LOC seems the best way.  
>>> Yes, I would be more interested in seeing patches that clean up the
>>> code than just talking about it.
>>>   
>>
>> I guess that is related to me, though I didn't plan to promote
>> a generic tagged pointer implementation in this series...
> 
> I don't expect you to either.

Beyond my expectation, I think I will (could) learn some new knowledge
from this topic, thanks you and Amir :)

> 
>>
>> I try to describe what erofs met and my own implementation,
>> assume that we have 3 tagged pointers, a, b, c, and one
>> potential user only (no need to ACCESS_ONCE).
>>
>> One way is
>>
>> #define A_MASK		1
>> #define B_MASK		1
>> #define C_MASK		3
>>
>> /* now we have 3 mask there, A, B, C is simple,
>>    the real name could be long... */
>>
>> void *a;
>> void *b;
>> void *c;		/* and some pointers */
>>
>> In order to decode the tag, we have to
>> 	((unsigned long)a & A_MASK)
>>
>> to decode the ptr, we have to
>> 	((unsigned long)a & ~A_MASK)
>>
>> In order to fold the tagged pointer...
>> 	(void *)((unsigned long)a | tag)
> 
> And you need a way to clear the flag.

Considering one potential user, we could refold the tagged pointer.
or we could refold the tagged pointer and update the value in atomic
(like atomic_t does).

a = tagptr_fold(ta, tagptr_unfold_tags(a), tag);

> 
>>
>> You can see the only meaning of these masks is the bitlength of tags,
>> but there are many masks (or we have to do open-coded a & 3,
>> if bitlength is changed, we have to fix them all)...
>>
>> therefore my approach is
>>
>> typedef tagptr1_t ta;	/* tagptr type a with 1-bit tag */
>> typedef tagptr1_t tb;	/* tagptr type b with 1-bit tag */
>> typedef tagptr2_t tc;	/* tagptr type c with 2-bit tag */
>>
>> and ta a; tb b; tc c;
>>
>> the type will represent its bitlength of tags and we can use ta, tb, tc
>> to avoid masks or open-coded bitlength.
>>
>> In order to decode the tag, we can
>> 	tagptr_unfold_tags(a)
>>
>> In order to decode the ptr, we can
>> 	tagptr_unfold_ptr(a)
>>
>> In order to fold the tagged pointer...
>> 	a = tagptr_fold(ta, ptr, tag)
>>
>>
>> ACCESS_ONCE stuff is another thing... If my approach seems cleaner,
>> we could move to include/linux later after EROFS stuffs is done...
>> Or I could use a better tagptr approach later if any...
> 
> Looking at the ring buffer code, it may be a bit too complex to try to
> use a generic infrastructure. Look at rb_head_page_set(), where it does
> a cmpxchg to set or clear the flags and then tests the previous flags
> to know what actions need to be done.

The current code supports cmpxchg as well, but I don't look into
rb_head_page_set... (although I think it is not the critical thing if we
decide to do some generic tagged pointer approach...)

> 
> The ring buffer tag code was added in 2009, the rtmutex tag code was
> added in 2006. It's been 10 years before we needed another tag
> operation. I'm not sure we benefit from making this generic.

Okay, that depends on your folks, actually...


Thanks,
Gao Xiang

> 
> -- Steve
> 
