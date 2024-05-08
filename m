Return-Path: <linux-fsdevel+bounces-19032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4781E8BF7B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 09:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E39283442
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 07:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C0C4EB42;
	Wed,  8 May 2024 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TyCeEKfi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6E3E493;
	Wed,  8 May 2024 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154663; cv=none; b=bAuVM5SdF7sMbqTKAmVfDc1H5DMIwa8347TqyZg3VX/tSlLWxnCva17JL97kQKQY2v/WpQOOTthD36m35Vtz6DRYl7IrFF0cfj0p3kCqwi+zqlAz0pRlIuqG8jQh0CKsiY7KHqTnhgwf+YYD6MJlVzfVIk+PqxlTtP7+SE9n9zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154663; c=relaxed/simple;
	bh=ER1Z4aI2riqIkflza4C4e1PlWp6zX494INQCy0XREMI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jVYvRPy4Jm/8Qly0IrAVG8f4yvgrbYPdUOgv0xVo9VAwLGDTi8hwgjKc9nT8f3aM5feChXAQeu1Ykk7J0lNen81+V9H9Zjd7+gFAxZDpjgkp4pDqeq5he5VeLUBV5Of/xdvFm0rvXlIDDSHu43a/18Qq8gjokRT43xmnrdsBObU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TyCeEKfi; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715154660;
	bh=ER1Z4aI2riqIkflza4C4e1PlWp6zX494INQCy0XREMI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=TyCeEKfi6CYhIwEaqOEpH25jFs6qvBUVq945IAEJX0ygECWU589cyU+MvgoMTwPux
	 6/BdQxBfA97+L51tiYYuC6Z019EIYhFF3sdDZuG2WVBm/WaUFyhWfjl8go6V74ihZL
	 zBcgP46R18osAyST9mJimRCt5HPROCQi3DU7kLTMECfOKz73i5JJsM6E5KBVualcXQ
	 5gzkdSfbaSw8tyRODR4he2DEGEVliGska4eIsPBcU5tlE50l57QHTt63UZ0CRXcg2U
	 D0N9WjN6eZpiBY81Z85YXE8KEKC/rooS7M1+Qvq169eoVStaDUIn3LxqthwG70lAAM
	 pCsLg40TYView==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7EA2C378216D;
	Wed,  8 May 2024 07:50:16 +0000 (UTC)
Message-ID: <9b54b87f-f761-4e4f-8df3-993e426ebc27@collabora.com>
Date: Wed, 8 May 2024 12:49:58 +0500
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
Subject: Re: [PATCH v2 3/5] selftests: Include KHDR_INCLUDES in Makefile
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
 <20240507214254.2787305-4-edliaw@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240507214254.2787305-4-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/24 2:38 AM, Edward Liaw wrote:
> Add KHDR_INCLUDES to CFLAGS to pull in the kselftest harness
> dependencies (-D_GNU_SOURCE).
> 
> Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
> Signed-off-by: Edward Liaw <edliaw@google.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/alsa/Makefile                  | 2 +-
>  tools/testing/selftests/arm64/signal/Makefile          | 2 +-
>  tools/testing/selftests/exec/Makefile                  | 2 +-
>  tools/testing/selftests/filesystems/overlayfs/Makefile | 2 +-
>  tools/testing/selftests/hid/Makefile                   | 2 +-
>  tools/testing/selftests/nci/Makefile                   | 2 +-
>  tools/testing/selftests/prctl/Makefile                 | 2 ++
>  tools/testing/selftests/proc/Makefile                  | 2 +-
>  tools/testing/selftests/riscv/mm/Makefile              | 2 +-
>  tools/testing/selftests/rtc/Makefile                   | 2 +-
>  tools/testing/selftests/tmpfs/Makefile                 | 2 +-
>  11 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
> index 5af9ba8a4645..9a0ef194522c 100644
> --- a/tools/testing/selftests/alsa/Makefile
> +++ b/tools/testing/selftests/alsa/Makefile
> @@ -6,7 +6,7 @@ LDLIBS += $(shell pkg-config --libs alsa)
>  ifeq ($(LDLIBS),)
>  LDLIBS += -lasound
>  endif
> -CFLAGS += -L$(OUTPUT) -Wl,-rpath=./
> +CFLAGS += $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=./
>  
>  LDLIBS+=-lpthread
>  
> diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
> index 8f5febaf1a9a..ae682ade615d 100644
> --- a/tools/testing/selftests/arm64/signal/Makefile
> +++ b/tools/testing/selftests/arm64/signal/Makefile
> @@ -2,7 +2,7 @@
>  # Copyright (C) 2019 ARM Limited
>  
>  # Additional include paths needed by kselftest.h and local headers
> -CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
> +CFLAGS += $(KHDR_INCLUDES) -std=gnu99 -I.
>  
>  SRCS := $(filter-out testcases/testcases.c,$(wildcard testcases/*.c))
>  PROGS := $(patsubst %.c,%,$(SRCS))
> diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
> index fb4472ddffd8..15e78ec7c55e 100644
> --- a/tools/testing/selftests/exec/Makefile
> +++ b/tools/testing/selftests/exec/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  CFLAGS = -Wall
>  CFLAGS += -Wno-nonnull
> -CFLAGS += -D_GNU_SOURCE
> +CFLAGS += $(KHDR_INCLUDES)
>  
>  TEST_PROGS := binfmt_script.py
>  TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
> diff --git a/tools/testing/selftests/filesystems/overlayfs/Makefile b/tools/testing/selftests/filesystems/overlayfs/Makefile
> index 56b2b48a765b..6c29c963c7a8 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/Makefile
> +++ b/tools/testing/selftests/filesystems/overlayfs/Makefile
> @@ -2,6 +2,6 @@
>  
>  TEST_GEN_PROGS := dev_in_maps
>  
> -CFLAGS := -Wall -Werror
> +CFLAGS := -Wall -Werror $(KHDR_INCLUDES)
>  
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
> index 2b5ea18bde38..0661b34488ef 100644
> --- a/tools/testing/selftests/hid/Makefile
> +++ b/tools/testing/selftests/hid/Makefile
> @@ -21,7 +21,7 @@ CXX ?= $(CROSS_COMPILE)g++
>  
>  HOSTPKG_CONFIG := pkg-config
>  
> -CFLAGS += -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT)
> +CFLAGS += -g -O0 -rdynamic -Wall -Werror $(KHDR_INCLUDES) -I$(OUTPUT)
>  CFLAGS += -I$(OUTPUT)/tools/include
>  
>  LDLIBS += -lelf -lz -lrt -lpthread
> diff --git a/tools/testing/selftests/nci/Makefile b/tools/testing/selftests/nci/Makefile
> index 47669a1d6a59..bbc5b8ec3b17 100644
> --- a/tools/testing/selftests/nci/Makefile
> +++ b/tools/testing/selftests/nci/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -CFLAGS += -Wl,-no-as-needed -Wall
> +CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
>  LDFLAGS += -lpthread
>  
>  TEST_GEN_PROGS := nci_dev
> diff --git a/tools/testing/selftests/prctl/Makefile b/tools/testing/selftests/prctl/Makefile
> index 01dc90fbb509..1a0aefec9d6f 100644
> --- a/tools/testing/selftests/prctl/Makefile
> +++ b/tools/testing/selftests/prctl/Makefile
> @@ -6,6 +6,8 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>  ifeq ($(ARCH),x86)
>  TEST_PROGS := disable-tsc-ctxt-sw-stress-test disable-tsc-on-off-stress-test \
>  		disable-tsc-test set-anon-vma-name-test set-process-name
> +
> +CFLAGS += $(KHDR_INCLUDES)
>  all: $(TEST_PROGS)
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
> index cd95369254c0..9596014c10a0 100644
> --- a/tools/testing/selftests/proc/Makefile
> +++ b/tools/testing/selftests/proc/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  CFLAGS += -Wall -O2 -Wno-unused-function
> -CFLAGS += -D_GNU_SOURCE
> +CFLAGS += $(KHDR_INCLUDES)
>  LDFLAGS += -pthread
>  
>  TEST_GEN_PROGS :=
> diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
> index c333263f2b27..715a21241113 100644
> --- a/tools/testing/selftests/riscv/mm/Makefile
> +++ b/tools/testing/selftests/riscv/mm/Makefile
> @@ -3,7 +3,7 @@
>  # Originally tools/testing/arm64/abi/Makefile
>  
>  # Additional include paths needed by kselftest.h and local headers
> -CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
> +CFLAGS += $(KHDR_INCLUDES) -std=gnu99 -I.
>  
>  TEST_GEN_FILES := mmap_default mmap_bottomup
>  
> diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
> index 55198ecc04db..654f9d58da3c 100644
> --- a/tools/testing/selftests/rtc/Makefile
> +++ b/tools/testing/selftests/rtc/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -CFLAGS += -O3 -Wl,-no-as-needed -Wall
> +CFLAGS += -O3 -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
>  LDLIBS += -lrt -lpthread -lm
>  
>  TEST_GEN_PROGS = rtctest
> diff --git a/tools/testing/selftests/tmpfs/Makefile b/tools/testing/selftests/tmpfs/Makefile
> index aa11ccc92e5b..bcdc1bb6d2e6 100644
> --- a/tools/testing/selftests/tmpfs/Makefile
> +++ b/tools/testing/selftests/tmpfs/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  CFLAGS += -Wall -O2
> -CFLAGS += -D_GNU_SOURCE
> +CFLAGS += $(KHDR_INCLUDES)
>  
>  TEST_GEN_PROGS :=
>  TEST_GEN_PROGS += bug-link-o-tmpfile

-- 
BR,
Muhammad Usama Anjum

