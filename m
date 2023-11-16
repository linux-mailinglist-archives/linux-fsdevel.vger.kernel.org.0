Return-Path: <linux-fsdevel+bounces-2997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8717EE967
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 23:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E52DB20BFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 22:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEF214AB2;
	Thu, 16 Nov 2023 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ttlAA6m+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CA1D4D;
	Thu, 16 Nov 2023 14:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1700174415; x=1700779215; i=quwenruo.btrfs@gmx.com;
	bh=FGy/fz1ZDkLXiSf9UT7wedokQxCPJmFYAXb+PdGb614=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ttlAA6m+3OhsravnRnhTbt4BBHPh6tByT/PdtGFerZWueeBm9kSoZNy5nyFKgs2w
	 IAvOESshlFao8E0fdaaJpbBwLtLOMnMD0Z46G3LmgAuyNqcWa+CbX87Yz1rdT2FPO
	 N8EEtPSKpgavu9tItk7UB3chS7iHu/ZiEwcyYp+RliGLG4+aWbFqTlf6+nViRZOwG
	 Iy0kCCe77DEhw2XF/hi4g6lOtUnIcL5aCDwPMLp9iP+fcFnu9LIJWINicf7qzud5q
	 xUl6fr7g6gWrIbN6ULkfSAWCQJ6FfmwA7ns0Yu+OKRSwnggMVhVAtDtdpnz/TuLIr
	 wifFc4g31o4E1nQyFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7QxL-1rR4ol3LRt-017kjV; Thu, 16
 Nov 2023 23:40:15 +0100
Message-ID: <9ecbebd3-4dc1-4560-9616-1af861c376e1@gmx.com>
Date: Fri, 17 Nov 2023 09:10:10 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Mixed page compact code and (higher order) folios for filemap
To: Matthew Wilcox <willy@infradead.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <ec608bc8-e07b-49e6-a01e-487e691220f5@gmx.com>
 <ZVWjBVISMbP/UvGY@casper.infradead.org>
 <0e995d32-a984-4b65-b9e3-67fc62cc2596@gmx.com>
 <ZVYl8z5A1ucf/GYt@casper.infradead.org>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <ZVYl8z5A1ucf/GYt@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tq3Qxc3YvvFvSyvyR/z7cbLil6IhBzrFgVyBtOH688XkOmWyOjx
 n11U7xp1SGI/Yztaox0Z9+5+E77KDHXey1uZa9jedjCcOzc2KrBZa9FbyaK3W2fQVBhjlV9
 A/INiw+roVbn93J195vCFYA5qZaqJFiLifnT/4HSpqHNHVMchB4x5CNiUAw+PFEDvzYs2O/
 KQt/Yno/YLWPzeX7iifqA==
UI-OutboundReport: notjunk:1;M01:P0:3wwVXDwrmBA=;eD0D8eD93cbTgSigLGckCaESnYS
 AYDgzIx5czNE8cEigmjRc4+Bkwzfv5gO50AiEl8xqRXl8AaSYZIujtdjcbp1me22FeYiR+sO3
 NKuBH7SbMcwjLGnHU89eRHtSX531Zq4v/poKfotWlBEKLDHNGO0kR6qiS8UYQfn6rEh2EgsTG
 WTUKMNIbWkD/vwV1Kpk04i8eJagLBhc7AMAxJEosQWr4S8emeFe4R9Wct1JLWZdGiIoNAwcJe
 q9FEMuFszwJ4vDiCdHHyPp8iV9i3ej1AgN9tY85wSjUIJxUZ01RVfUIhWC5faT4En7eM2JkwT
 7V3Nri+0i6BGKsQuVXcp/1ZGRCdC5+i9i3wNTXmSuVjTEmTA95DUUdpQNMGsdA7+6hxH1ufAT
 H1SjiSwZJqusx6j7ujVTZPiZDLUKsbY0M2FSdMg508nY5WF8LdrYG6aNGOH8QG7Fd/ZYSpoH0
 Txjipu1/KrMZv7EOpg7DBT31QLWyqlaA3sl5YEWU8OvoCPdzlBmFhwaAIVG+fNudwCLlSfrgY
 bFOYZRUN1JNXFjyeqSjVakEW8A9fkXE+69Fpr7NLGlNyOKUnJH9j2CfMWhxUDEnwmBcieOiYH
 +A2sZq4wniI212JU/GfV9uuype2KeSo3rt6eMKZZnqi8JRGBxIuAsE4kcWNtkLJ4e628FYY/T
 zziJUwIshBiqvFa36BMsC/lQLJ67vXGnC4cJDnRSJgcWuDPKLHO7lZ0aa0DFzvUR4bB6D0nTz
 HECwlKrUZNJfDZZ6t7ydXs+aw7zcv3hoOExX2Alnry2XtYR6VAAPZJajXiQVrWph7GqXCzYku
 olE52gx9y23MD002XpouMVHrRbbbZ12cp+tNbglDgMB2Q3N9fQr6FAl8/s7INZ/LhF7iGm0sj
 h90Ve/Xv4sqADT9MkVPSMZewVKjIunjB2EsTIVMAMh6jBaXbfTD36D9yImd9Zo6s8V5NPSLNM
 qoAX+Q==



On 2023/11/17 00:53, Matthew Wilcox wrote:
> On Thu, Nov 16, 2023 at 04:00:40PM +1030, Qu Wenruo wrote:
>> On 2023/11/16 15:35, Matthew Wilcox wrote:
>>> On Thu, Nov 16, 2023 at 02:11:00PM +1030, Qu Wenruo wrote:
>>>> E.g. if I allocated a folio with order 2, attached some private data =
to
>>>> the folio, then call filemap_add_folio().
>>>>
>>>> Later some one called find_lock_page() and hit the 2nd page of that f=
olio.
>>>>
>>>> I believe the regular IO is totally fine, but what would happen for t=
he
>>>> page->private of that folio?
>>>> Would them all share the same value of the folio_attach_private()? Or
>>>> some different values?
>>>
>>> Well, there's no magic ...
>>>
>>> If you call find_lock_page(), you get back the precise page.  If you
>>> call page_folio() on that page, you get back the folio that you stored=
.
>>> If you then dereference folio->private, you get the pointer that you
>>> passed to folio_attach_private().
>>>
>>> If you dereference page->private, *that is a bug*.  You might get
>>> NULL, you might get garbage.  Just like dereferencing page->index or
>>> page->mapping on tail pages.  page_private() will also do the wrong th=
ing
>>> (we could fix that to embed a call to page_folio() ... it hasn't been
>>> necessary before now, but if it'll help convert btrfs, then let's do i=
t).
>>
>> That would be great. The biggest problem I'm hitting so far is the page
>> cache for metadata.
>>
>> We're using __GFP_NOFAIL for the current per-page allocation, but IIRC
>> __GFP_NOFAIL is ignored for higher order (>2 ?) folio allocation.
>> And we may want that per-page allocation as the last resort effort
>> allocation anyway.
>>
>> Thus I'm checking if there is something we can do here.
>>
>> But I guess we can always go folio_private() instead as a workaround fo=
r
>> now?
>
> I don't understand enough about what you're doing to offer useful
> advice.  Is this for bs>PS or is it arbitrary large folios for better
> performance?  If the latter, you can always fall back to order-0 folios.
> If the former, well, we need to adjust a few things anyway to handle
> filesystems with a minimum order ...
>
> In general, you should be using folio_private().  page->private and
> page_private() will be removed eventually.

Just another question.

What about flags like PageDirty? Are they synced with folio?

The declaration goes PF_HEAD for policy, thus for order 0 it makes no
difference, but for higher order folios, we should switch to pure folio
based operations other than mixing page and folios?

Thanks,
Qu
>
> The GFP_NOFAIL warning is:
>
>          WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
>
>

