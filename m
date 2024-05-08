Return-Path: <linux-fsdevel+bounces-19110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C3C8C0238
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 18:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7992286343
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BB7F507;
	Wed,  8 May 2024 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6T4Vx0y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13441633;
	Wed,  8 May 2024 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715186700; cv=none; b=RjWEvBLj8kuO7x31YkqGMm1cy/d1/cIKPMvYDEIdJmWH0VUUULuifWcdFVEcG97GU3tSO6XPb0wB8HBYbZtrBCtgo/4L6V8WmxCFI0WiZcHdXrfndlRUQ/TYdsztHZLYA4hHgh08b+HT9cqO5s/IlxEPGeBgEIIxky+VOwMNc6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715186700; c=relaxed/simple;
	bh=0vXy5kTUEu7Jx0jxctDNvQbCc0ApL3aWNbp3Y8Ze7FM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=U0mN3p+TENNrVE3SV+SQlpiEcgZ7LDr6Iawqp7KVWGb8EnEqpTsNS1AGzc+A7N9JaORPilNxShAbfAO1aw6iz5xTv6lVqOBGW6Yul1eCzLUCteUgz3rMbFvqq/O8zF4Kyi5VltezECJrMaWfkV4O9YVmBVUnpbhUfeYCtyal6OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6T4Vx0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A392AC113CC;
	Wed,  8 May 2024 16:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715186699;
	bh=0vXy5kTUEu7Jx0jxctDNvQbCc0ApL3aWNbp3Y8Ze7FM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=r6T4Vx0y4QOnGwpBQOgFUY2eu34NThzwvqE9iWCIEwfBWxfBXLKwMeMXC2MZkCWgE
	 sSy8eWZ2B09C4cJWuUtyV7pp1xxjYBJcb9dKqRcNcRwWuRWNUhvaX8ZZNACrQ8akj+
	 fVsf0Qgb7/q7++0jy9wmy9zGxZ08j6Zv4QRrw0dL1nzsSXULP5hHSA299xoBM9AD05
	 6riemVsfFd1imBZpGu8mE+0OdEWqZvuhuWPeX4o1a5jHgyaeVks/tD4RoFmGk5XVgC
	 it22dgUxqoUlvZZ7CdgHHzCOiO9So64lLxbdbeLXKuMGmV15xh0wplv/ZWkSBTpDGK
	 EGKaRAElv3B+A==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 19:44:40 +0300
Message-Id: <D14EXNEBOKFY.8SJ7SOCABM01@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-team@android.com>, <linux-sound@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
 <linux-input@vger.kernel.org>, <iommu@lists.linux.dev>,
 <kvmarm@lists.linux.dev>, <kvm@vger.kernel.org>,
 <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
 <linux-security-module@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-actions@lists.infradead.org>,
 <mptcp@lists.linux.dev>, <linux-rtc@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <bpf@vger.kernel.org>, "kernel test robot"
 <oliver.sang@intel.com>
Subject: Re: [PATCH v2 2/5] selftests/sgx: Include KHDR_INCLUDES in Makefile
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Dave Hansen" <dave.hansen@intel.com>, "Edward Liaw"
 <edliaw@google.com>, <shuah@kernel.org>, "Mark Brown" <broonie@kernel.org>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon"
 <will@kernel.org>, "Nhat Pham" <nphamcs@gmail.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Christian Brauner" <brauner@kernel.org>, "Eric
 Biederman" <ebiederm@xmission.com>, "Kees Cook" <keescook@chromium.org>,
 "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Darren Hart" <dvhart@infradead.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>, =?utf-8?q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, "Jiri Kosina" <jikos@kernel.org>, "Benjamin
 Tissoires" <bentiss@kernel.org>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Kevin
 Tian" <kevin.tian@intel.com>, "Andy Lutomirski" <luto@amacapital.net>,
 "Will Drewry" <wad@chromium.org>, "Marc Zyngier" <maz@kernel.org>, "Oliver
 Upton" <oliver.upton@linux.dev>, "James Morse" <james.morse@arm.com>,
 "Suzuki K Poulose" <suzuki.poulose@arm.com>, "Zenghui Yu"
 <yuzenghui@huawei.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Sean
 Christopherson" <seanjc@google.com>, "Anup Patel" <anup@brainfault.org>,
 "Atish Patra" <atishp@atishpatra.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Janosch Frank" <frankja@linux.ibm.com>,
 "Claudio Imbrenda" <imbrenda@linux.ibm.com>, "David Hildenbrand"
 <david@redhat.com>, =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Seth Forshee" <sforshee@kernel.org>, "Bongsu
 Jeon" <bongsu.jeon@samsung.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Steffen Klassert"
 <steffen.klassert@secunet.com>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, "Manivannan Sadhasivam"
 <manivannan.sadhasivam@linaro.org>, "Matthieu Baerts" <matttbe@kernel.org>,
 "Mat Martineau" <martineau@kernel.org>, "Geliang Tang"
 <geliang@kernel.org>, "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 "Fenghua Yu" <fenghua.yu@intel.com>, "Reinette Chatre"
 <reinette.chatre@intel.com>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Muhammad Usama Anjum"
 <usama.anjum@collabora.com>
X-Mailer: aerc 0.17.0
References: <20240507214254.2787305-1-edliaw@google.com>
 <20240507214254.2787305-3-edliaw@google.com>
 <c3fc5396-bc71-4dee-a3e0-d59dbbc6eda1@intel.com>
In-Reply-To: <c3fc5396-bc71-4dee-a3e0-d59dbbc6eda1@intel.com>

On Wed May 8, 2024 at 6:33 PM EEST, Dave Hansen wrote:
> On 5/7/24 14:38, Edward Liaw wrote:
> > Add KHDR_INCLUDES to the CFLAGS to pull in the kselftest harness
> > dependencies (-D_GNU_SOURCE).
> >=20
> > Also, remove redefinitions of _GNU_SOURCE in the source code.
>
> From an x86 and SGX perspective, looks fine.  I assume Shuah is planning
> on taking this pile.
>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Yep,

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I also quickly tested with NUC7 for what it is worth:

Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

