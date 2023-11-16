Return-Path: <linux-fsdevel+bounces-2983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE1C7EE85C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 21:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6590AB20B09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 20:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABD931A74;
	Thu, 16 Nov 2023 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="caV8eIDq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3CE98;
	Thu, 16 Nov 2023 12:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1700166790; x=1700771590; i=quwenruo.btrfs@gmx.com;
	bh=UlvD9PGn5EeAgcPVj3AcH8dAHCrhpIHllLBvL/VBHYI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=caV8eIDqv77+t5yf1R+qL3gPGVm7UtEQbHggxWjltJ7OwKxXAWzdRSp2CWRr2AV1
	 vmvl1SEsT8rouM6KEKI3jeZINRpuuikTIaFuNuN+W0obTrCJOjhSv7v0M3yUSbor8
	 rRX6cadkqzxqkYsfBqml5NlOK8C/DqOuAeWvK3Pqk+gCwxj6FOHmrCCJhA9UZO5ZH
	 2PpP5VAt+ntXLSdP+lLDcGIBSmj3cr2szGXzR/fhHv8q21zrBuP5MeqXsPNV1RuPU
	 oaFV6p134sny4zXrN+FS9wlCW7jQKYMQ2x3UuRyFcyUTJgqEA77KwomavJRdAak92
	 Qb/KW6l9YaaLIM7KSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5VHG-1rRNuu06zS-016yo6; Thu, 16
 Nov 2023 21:33:10 +0100
Message-ID: <d46dbdc2-4a30-4ead-90f8-b4902cfa0bed@gmx.com>
Date: Fri, 17 Nov 2023 07:03:05 +1030
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
X-Provags-ID: V03:K1:YbJJwv2+okE+hE7lAW+u9uGdt53aKIAgQi8cFjbAluqpRWh+6tK
 D1v4hz2EKbT5hvBEOg6+mm0hL5HuXEfSZ5Y3BH29EUfFTbWvPcM+aOYieHKH85eoInqetF9
 QanlaqLcGr/w87iiiBe+WzSdw10TtJvAN700ATn22AekTBT2RYiqbeJsGHsoRKphNwex4xo
 dr/m5H6RlCs/BwysT1w7g==
UI-OutboundReport: notjunk:1;M01:P0:Ks3hQPZkQlM=;aPd0+8KTwZ3c36UlGrnFKjzRmCJ
 H8jnqixkouhYYRU0HehBqG1Jk4Wcd8oh8urPClK/bMXLpWh31mvSZplG0PVtKoc9n4ioIB2mk
 IGMjqoonoKY6WnwBzV32Q33QNw61PpDT8VcM2jlzrnkQgbdQ8vk3fb2lv5sEz3W+tHeVkpc3H
 VciLlr0W5eoJQoRK9Jq+cM4m1G53QLo3MY6mwLVshIcdYCiWefzHLqiIRyqO6yT3s0HIcxJtJ
 ayFIJoWAnXuZS8h8L4HydbOZSl2zFFVsMSZatyhRG+ZJMIorx/gRgE+IDaCvh4LT1YaiTS+4+
 lfL9hNzHUUV6Dz16LyMZ1le0VtT7DWU7f/ugB2zut4s362ScHUxIiRLsnV6X+IyL5EWnrSlu6
 u+xgIUXt+1NGPXpQWWbd5Tt7PQeajzBe1ofk4jZxPrbTR+CdSHVTTgWzKkWpeBpctBeuuHYfi
 2bM3PubyaxdrhWaAzQwIOqWaPZSCZai2BJRQ14wpvsWC5PXarLEAbGhNS5GKeS+mWsdE3tJeV
 O5bGJujuDqv0FvMl9u8LGZ/Zag31EC6lw0RuslqA9kG15qbvofZTWVcWMzBgIh7GddBU/mOSy
 eIgyVxnBxVAfY8YZUWXgi4TMJ8chlzCLBKWWxbXZyc+/TzgqgV3wVs7lRK5KXzd0aTt87MuFQ
 aPezneywrUvSRmhUb5P3cdJwgJOfFtXmSfERRiuAT/0D6QDS9WjvG2Z1f7nz8p2Z+aDv/uANr
 7zh18MwHOmnhUKg6ziqLZT2sMdDesTxlRA6yatfJrNZeIQ5aJCmq4nVOMeiLhFxDMbPtgZOOS
 sBhfXt7BdCkfa3Jl3PKeHg03vZSVkXGdX60ERQxKQPW1nGVbpE9jiZfhAZ5JYP1oM+Z/udKtM
 32Oru+cJoFiZP+wQtbF0RYhhT9rzNF9XPSO8iWMv8bcbdtt5CaiAiHEH2sidblTuAanJYMlXu
 61HhJNXFaHoPBc9AuRH+XTt+uOI=



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
> performance?

The ultimate goal is to make nodesize (metadata block size) > PAGE_SIZE
case to go higher order folio by default, for better performance.

But use order 0 folios if we failed get higher order folios.

The current problem is the metadata allocation  here is always going
page based, and using page->private.

>  If the latter, you can always fall back to order-0 folios.
> If the former, well, we need to adjust a few things anyway to handle
> filesystems with a minimum order ...
>
> In general, you should be using folio_private().  page->private and
> page_private() will be removed eventually.

OK, that sounds good, we can do the cleanup first inside btrfs.

Thanks,
Qu
>
> The GFP_NOFAIL warning is:
>
>          WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
>

