Return-Path: <linux-fsdevel+bounces-19035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB9F8BF7DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 09:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED1C3B2426C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 07:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCC641748;
	Wed,  8 May 2024 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d+6Wlldu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE503F8F0;
	Wed,  8 May 2024 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155104; cv=none; b=gQ4T2L0LXhqW/pB+iPtxRhC2vQXpUkZORoctNgSKFqiwpu82JG31vKlnrXFkq5gS1NUDo3zNgLjfHCumcCS8W1PpwNK7H8ckUIzBfWJ2kDZWQzZvlDhg3d3v0L4VBmsMw80dDmbO5s7GQyBalxCj+Gks06aXedKEu9V1B+fGf8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155104; c=relaxed/simple;
	bh=W8h0zv7fM5rho2qCrJQe63u3RrkuJY8jHMl1xzQ0llk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IjU25Xg9gPe5MqgyNQI+U3t/5SVR1EJeHEUhkho0498dTu6O/PwyMaXW/1V8dqTMNciDI3/Ib7JxDW4bGVwTxeFpb9L0irSuXYBlYHPO7p5/4qsnQIxnJ3cc+vzZGpmgGXU6AJRQn8PXpSLDRpfFxbisyejQSs7AqMsrCk1ga40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=d+6Wlldu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715155100;
	bh=W8h0zv7fM5rho2qCrJQe63u3RrkuJY8jHMl1xzQ0llk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=d+6WlldukdN+eWmS3sBsn4libaX2zcJvXa/ngL+dhdc+DchosZSUl43ALM0fKrizz
	 ysZ99uHC/8UpNmyFE4hOPapdp0NUzrlzrQjGLrkMDMqYNps7lgHGiCM7grlVWeqvuL
	 e5HkvXoNYPhMwpb30PKIuWAHw1A/b8v33oat12Wn15tu738O33/VYc94jtdztajScu
	 4J+5rFyzWIZ90H5CzrX9B4Ib32RGjnbcFX2KDX2Cv9yM6dA7sRVQyStsK2OIpLFTHR
	 MsAgmoQsx7QhT2c2rNTU9MLlxEjijsJQpah0OPot4l0rd5cOVPx4wu8rShkkg7Xmln
	 rRM76zFaWDvsw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5163A378107C;
	Wed,  8 May 2024 07:57:56 +0000 (UTC)
Message-ID: <e3f6bb2a-a9bd-43c2-9468-85242eab0390@collabora.com>
Date: Wed, 8 May 2024 12:58:20 +0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, linux-sound@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-input@vger.kernel.org, iommu@lists.linux.dev, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
 linux-actions@lists.infradead.org, mptcp@lists.linux.dev,
 linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 5/5] selftests: Drop duplicate -D_GNU_SOURCE
To: Edward Liaw <edliaw@google.com>, shuah@kernel.org,
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
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20240507214254.2787305-1-edliaw@google.com>
 <20240507214254.2787305-6-edliaw@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240507214254.2787305-6-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/24 2:38 AM, Edward Liaw wrote:
> -D_GNU_SOURCE can be de-duplicated here, as it is added by
> KHDR_INCLUDES.
> 
> Signed-off-by: Edward Liaw <edliaw@google.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/futex/functional/Makefile | 2 +-
>  tools/testing/selftests/iommu/Makefile            | 2 --
>  tools/testing/selftests/net/tcp_ao/Makefile       | 2 +-
>  tools/testing/selftests/resctrl/Makefile          | 2 +-
>  4 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
> index a392d0917b4e..f79f9bac7918 100644
> --- a/tools/testing/selftests/futex/functional/Makefile
> +++ b/tools/testing/selftests/futex/functional/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
> -CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES) $(KHDR_INCLUDES)
> +CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
>  LDLIBS := -lpthread -lrt
>  
>  LOCAL_HDRS := \
> diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
> index 32c5fdfd0eef..fd6477911f24 100644
> --- a/tools/testing/selftests/iommu/Makefile
> +++ b/tools/testing/selftests/iommu/Makefile
> @@ -2,8 +2,6 @@
>  CFLAGS += -Wall -O2 -Wno-unused-function
>  CFLAGS += $(KHDR_INCLUDES)
>  
> -CFLAGS += -D_GNU_SOURCE
> -
>  TEST_GEN_PROGS :=
>  TEST_GEN_PROGS += iommufd
>  TEST_GEN_PROGS += iommufd_fail_nth
> diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
> index 522d991e310e..c608b1ec02e6 100644
> --- a/tools/testing/selftests/net/tcp_ao/Makefile
> +++ b/tools/testing/selftests/net/tcp_ao/Makefile
> @@ -26,7 +26,7 @@ LIB	:= $(LIBDIR)/libaotst.a
>  LDLIBS	+= $(LIB) -pthread
>  LIBDEPS	:= lib/aolib.h Makefile
>  
> -CFLAGS	:= -Wall -O2 -g -D_GNU_SOURCE -fno-strict-aliasing
> +CFLAGS	:= -Wall -O2 -g -fno-strict-aliasing
>  CFLAGS	+= $(KHDR_INCLUDES)
>  CFLAGS	+= -iquote ./lib/ -I ../../../../include/
>  
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index 2deac2031de9..5073dbc96125 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE
> +CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
>  CFLAGS += $(KHDR_INCLUDES)
>  
>  TEST_GEN_PROGS := resctrl_tests

-- 
BR,
Muhammad Usama Anjum

