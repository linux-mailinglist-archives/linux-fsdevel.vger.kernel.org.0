Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E464037E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 12:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348884AbhIHKeK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 06:34:10 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:58507 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234958AbhIHKeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:34:09 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id AD687808EB;
        Wed,  8 Sep 2021 13:33:00 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1631097180;
        bh=bEIHNRfkQLVOb8OVfwOJchCdmltfMN+AbEre3I6fz6U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RfGspP6RecjiDoOt+E94QdUT2MjC/0P05nwiP/+/Dj+5rQXWoOOuuhszKZj98AMgU
         3plIxLQBskJiHs9jAvk5TJhS0mz69P7eAT/fNVzeY7sqt8HrQOTb4F5G3c/WJHkptS
         pgjiP2ByU5s4uQN88b1MicCYvhZuJy4SS5043OIY=
Received: from [192.168.211.176] (192.168.211.176) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 8 Sep 2021 13:33:00 +0300
Subject: Re: [PATCH v3 0/9] fs/ntfs3: Use new mount api and change some opts
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kari Argillander <kari.argillander@gmail.com>
CC:     "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20210829095614.50021-1-kari.argillander@gmail.com>
 <20210907073618.bpz3fmu7jcx5mlqh@kari-VirtualBox>
 <69c8ab24-9443-59ad-d48d-7765b29f28f9@paragon-software.com>
 <CAHp75Vd==Dm1s=WK9p2q3iEBSHxN-1spHmmtZ21eRNoqyJ5v=Q@mail.gmail.com>
 <CAC=eVgTwDsE+i3jG+iwZJhFDBXzCyPprRnGk5tjUKXP+Ltrw4w@mail.gmail.com>
 <CAHp75VetzFedGyqaB5TmsBH5UjBYpR8rimGmt8scn5fZ4FRbqg@mail.gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Message-ID: <c62ee307-d2ca-a3b5-ceea-fd8afa1b2bf8@paragon-software.com>
Date:   Wed, 8 Sep 2021 13:32:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VetzFedGyqaB5TmsBH5UjBYpR8rimGmt8scn5fZ4FRbqg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.176]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 08.09.2021 12:00, Andy Shevchenko wrote:
> On Tue, Sep 7, 2021 at 11:47 PM Kari Argillander
> <kari.argillander@gmail.com> wrote:
>> On Tuesday, September 7, 2021, Andy Shevchenko
>> (andy.shevchenko@gmail.com) wrote:
>>> On Tuesday, September 7, 2021, Konstantin Komarov <almaz.alexandrovich@paragon-software.com> wrote:
>>>> On 07.09.2021 10:36, Kari Argillander wrote:
> 
> ...
> 
>>>> Yes, everything else seems good.
>>>> We tested patches locally - no regression was
>>>
>>> The formal answer in such case should also contain the Tested-by tag. I would suggest you to read the Submitting Patches document (available in the Linux kernel source tree).
>>
>> He is a maintainer so he can add tags when he picks this up.
> 
> It's a good practice to do so. Moreover, it's better to do it
> patch-by-patch, so tools like `b4` can cope with tags for *anybody*
> who will use it in automated way.
> 
>> This is not
>> really relevant here.
> 
> Why not?
> 
>> Yes it should be good to include that but I have already
>> sended v4 which he has not tested. So I really cannot put this tag for him.
>> So at the end he really should not even put it here.
> 
> For v4 I agree with you.

My answer doesn't contain Tested-by tag because author of patch already said
that there will be next version of patch.
Thanks for Submitting Patches document suggestion.

> 
>> Also usually the maintainers will always make their own tests and usually
>> they will not even bother with a tested-by tag.
> 
> If it's their own code, yes, if it's others', why not? See above as well.
> 
>> Or do you say to me that I
>> should go read Submitting Patches document as I'm the one who submit
>> this?
> 
> It's always good to refresh memory, so why not? :-)
> 
