Return-Path: <linux-fsdevel+bounces-19213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 760A08C14A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 20:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992211C21CF0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 18:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8BF7BAE4;
	Thu,  9 May 2024 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y0vwhbgp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E2770FE;
	Thu,  9 May 2024 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715278820; cv=none; b=FMnsZIY44/vqA75SH/j64Qx9W8BkojnH0OKF/6pHkqu+PSJXJZw3KgOwzamhxeDDDd2UoJjPJ4El4zKeCoTPZXmZo4wYuCKbM9qDoCzMro2p7Q2N6LhcUDD4xBfWsG0O9b66ynchtn0OhjY2aPSdQzdUIauiyXuQhEJW2oA0v74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715278820; c=relaxed/simple;
	bh=JCJaK6QpOrmmUJdi/1h2/P/m5VnuJoQJ8ijlBJBZs2E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E8cxY7+zC++X+urFqgMQxq9ZHtP3Hq7NmNm/UjICxXOYm1BDbRQBrLLrvkcx4eevo3SS4zdA7JPsxuskc651xjxDmubUe41XgC+ZoOYcC5nW0OBgZSnXB0PfR7hC1vsJ14nkqv5QoQeYiiGCoshy1wqB//9TaELbAy9RKwmTkVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y0vwhbgp; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715278815;
	bh=JCJaK6QpOrmmUJdi/1h2/P/m5VnuJoQJ8ijlBJBZs2E=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Y0vwhbgpxSGiErJBlZANaCoV14K1sUaA4F/ooMPA8bO48t72Fpno5DrnfALIMJiFY
	 oMSvCEfOkwdTnfzldtNTgWgnNeYnX0lnmSBwYV+uUcXI50biIzPUgTSdbJDAk9h9/N
	 bVUTOACTMW2U5cMSjfFt9b0R/BiIAN1Kzg0OIMCCtoqr8O1bj2D1Led/rtVGtGTVC8
	 kz3S35qqjR2mswHsIzoVynyPqK+vGV6uTv4IAVR+VARRqE/hZwUo8M6kQ1/zzNJO7N
	 IQqLkWeZKdjhwuxngilpfTAlT58QqNdElQbuZGDixBXFgx76yRt8hchoMtP4P0BWps
	 4uG5Wxt7oOVIg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3ED82378214F;
	Thu,  9 May 2024 18:19:55 +0000 (UTC)
Message-ID: <57f47bc1-972c-45b5-81ef-d8269dcadebb@collabora.com>
Date: Thu, 9 May 2024 23:20:19 +0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, shuah@kernel.org,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Christian Brauner
 <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 Kees Cook <keescook@chromium.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Andrew Morton <akpm@linux-foundation.org>, Seth Forshee
 <sforshee@kernel.org>, Bongsu Jeon <bongsu.jeon@samsung.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@android.com,
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-input@vger.kernel.org, iommu@lists.linux.dev,
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
 linux-actions@lists.infradead.org, mptcp@lists.linux.dev,
 linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Define _GNU_SOURCE for sources using
To: Edward Liaw <edliaw@google.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240507214254.2787305-1-edliaw@google.com>
 <f4e45604-86b0-4be6-9bea-36edf301df33@linuxfoundation.org>
 <CAG4es9XE2D94BNboRSf607NbJVW7OW4xkVq4jZ8pDZ_AZsb3nQ@mail.gmail.com>
 <946ae22f-a4af-448a-92e1-60afb6ed9261@linuxfoundation.org>
 <CAG4es9V2CcBJr0josSoGNsD+ZPQ6vasVXh_Hc_j88oeSqn__yQ@mail.gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CAG4es9V2CcBJr0josSoGNsD+ZPQ6vasVXh_Hc_j88oeSqn__yQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/9/24 10:45 PM, Edward Liaw wrote:
> On Thu, May 9, 2024 at 7:37 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 5/9/24 00:13, Edward Liaw wrote:
>>> On Wed, May 8, 2024 at 4:10 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>
>>>> On 5/7/24 15:38, Edward Liaw wrote:
>>>>> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
>>>>> asprintf into kselftest_harness.h, which is a GNU extension and needs
>>>>> _GNU_SOURCE to either be defined prior to including headers or with the
>>>>> -D_GNU_SOURCE flag passed to the compiler.
>>>>>
>>>>> v1: https://lore.kernel.org/linux-kselftest/20240430235057.1351993-1-edliaw@google.com/
>>>>> v2: add -D_GNU_SOURCE to KHDR_INCLUDES so that it is in a single
>>>>> location.  Remove #define _GNU_SOURCE from source code to resolve
>>>>> redefinition warnings.
>>>>>
>>>>> Edward Liaw (5):
>>>>>     selftests: Compile kselftest headers with -D_GNU_SOURCE
>>>>>     selftests/sgx: Include KHDR_INCLUDES in Makefile
>>>>
>>>> I appled patches 1/5 and 2.5 - The rest need to be split up.
>>>>
>>>>>     selftests: Include KHDR_INCLUDES in Makefile
>>>>>     selftests: Drop define _GNU_SOURCE
>>>>>     selftests: Drop duplicate -D_GNU_SOURCE
>>>>>
>>>>
>>>> Please split these patches pwe test directory. Otherwise it will
>>>> cause merge conflicts which can be hard to resolve.
>>>
>>> Hi Shuah,
>>> Sean asked that I rebase the patches on linux-next, and I will need to
>>> remove additional _GNU_SOURCE defines.  Should I send an unsplit v3 to
>>> be reviewed, then split it afterwards?  I'm concerned that it will be
>>> difficult to review with ~70 patches once split.
>>
>> Please send them split - it will be easier to review and apply. You
>> might as well wait until the merge window is done. I don't think
>> anybody would have time to review now since merge window starts
>> next week.
> 
> Sorry, I have them split already; is it ok if I send them now?  I will
> be on leave soon and may not be able to get back to it in a while.
Feel free to send the patches. There is no restriction on that.

> 
> Thanks,
> Edward
> 
>>
>>
>> thanks,
>> -- Shuah
> 

-- 
BR,
Muhammad Usama Anjum

