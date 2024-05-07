Return-Path: <linux-fsdevel+bounces-18962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A42B8BEFDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 00:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36136286565
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 22:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE1D80034;
	Tue,  7 May 2024 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEs0nlup"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89797F7CA;
	Tue,  7 May 2024 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715121415; cv=none; b=uz113eV/FkiPzKpUk6UOqZrs+X3GSruZ38zVtqzUCq/zzZTh97we+vZ/UE05Bn24UHhB8HzcQ85oDGzZpDp0hXZJSwHZ2/WwLyzzdafZzwwf8yedGEnbfMBqeQULLJKThDWvoUFBQ5/spoUTZzM+7Zl7d2f5LUB1w223vSemBFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715121415; c=relaxed/simple;
	bh=vZu8367hXU7oiXYTGuAa3tCsrA1jmnR/kKUKbwIWO24=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=PhPdAfHK2FTnsGvczKBetztyoR1/knNdJav30M38tg2JjINRNZCSRTOoOL8uEYyowJcVqq76V78B45wIZpOWtB3k6IsMzvEEICTvHDXvz3Vjg8nzHEd/zq54bkPdxwq9PSY9Po5t3HQ/3XqLApkQerGBy8Ne2/4q+VqfoIBKwJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEs0nlup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C46C2BBFC;
	Tue,  7 May 2024 22:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715121414;
	bh=vZu8367hXU7oiXYTGuAa3tCsrA1jmnR/kKUKbwIWO24=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=XEs0nlupa/YeV6+Z2Gc+n7c3pIBOkGGmDoCoT6KyVsBYgtXLiIdHulLvrs4YEs/4a
	 bPdoHs+8QRtFMZ/4gzAHp2vZ0me4r7CzqR/hvFNO1xvIqVWhc36VAXCAZWPLsUhnmu
	 P4pKvBUvUOxuyv/wka2jPIQy0lQGEB6ym4TAHzN/Nghm7jV2qsTTbggxdx1RLCjLZm
	 PEwPiir/nrivlQ45L+0JuHP+dxk8rfLOJyq24TPvS3+5GqucsW6YLdcPP8OrUDtb08
	 EqYSgXFs8+vnP+dGERNlOoRnLFhtM1eiU22yUWrF67SuFuyh5tALynyPQtKp1PEzgM
	 6xKlBBkuDjhWQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 01:36:35 +0300
Message-Id: <D13RSJRDTUQO.UA22FQGU3839@kernel.org>
To: "Edward Liaw" <edliaw@google.com>, <shuah@kernel.org>, "Mark Brown"
 <broonie@kernel.org>, "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai"
 <tiwai@suse.com>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Nhat Pham" <nphamcs@gmail.com>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Christian Brauner" <brauner@kernel.org>,
 "Eric Biederman" <ebiederm@xmission.com>, "Kees Cook"
 <keescook@chromium.org>, "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Darren Hart"
 <dvhart@infradead.org>, "Davidlohr Bueso" <dave@stgolabs.net>,
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, "Jiri Kosina"
 <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Kevin Tian" <kevin.tian@intel.com>, "Andy
 Lutomirski" <luto@amacapital.net>, "Will Drewry" <wad@chromium.org>, "Marc
 Zyngier" <maz@kernel.org>, "Oliver Upton" <oliver.upton@linux.dev>, "James
 Morse" <james.morse@arm.com>, "Suzuki K Poulose" <suzuki.poulose@arm.com>,
 "Zenghui Yu" <yuzenghui@huawei.com>, "Paolo Bonzini" <pbonzini@redhat.com>,
 "Sean Christopherson" <seanjc@google.com>, "Anup Patel"
 <anup@brainfault.org>, "Atish Patra" <atishp@atishpatra.org>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Janosch Frank"
 <frankja@linux.ibm.com>, "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
 "David Hildenbrand" <david@redhat.com>,
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Seth Forshee" <sforshee@kernel.org>, "Bongsu Jeon"
 <bongsu.jeon@samsung.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Steffen Klassert"
 <steffen.klassert@secunet.com>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, "Manivannan Sadhasivam"
 <manivannan.sadhasivam@linaro.org>, "Matthieu Baerts" <matttbe@kernel.org>,
 "Mat Martineau" <martineau@kernel.org>, "Geliang Tang"
 <geliang@kernel.org>, "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 "Fenghua Yu" <fenghua.yu@intel.com>, "Reinette Chatre"
 <reinette.chatre@intel.com>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Muhammad Usama Anjum"
 <usama.anjum@collabora.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-team@android.com>, <linux-sound@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
 <linux-input@vger.kernel.org>, <iommu@lists.linux.dev>,
 <kvmarm@lists.linux.dev>, <kvm@vger.kernel.org>,
 <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
 <linux-security-module@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-actions@lists.infradead.org>,
 <mptcp@lists.linux.dev>, <linux-rtc@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] selftests: Include KHDR_INCLUDES in Makefile
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240507214254.2787305-1-edliaw@google.com>
 <20240507214254.2787305-4-edliaw@google.com>
In-Reply-To: <20240507214254.2787305-4-edliaw@google.com>

On Wed May 8, 2024 at 12:38 AM EEST, Edward Liaw wrote:
> Add KHDR_INCLUDES to CFLAGS to pull in the kselftest harness
> dependencies (-D_GNU_SOURCE).
>
> Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
> Signed-off-by: Edward Liaw <edliaw@google.com>

Oops, this is not for this patch but for SGX. Pressed D by mistake
in aerch, so for SGX one:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

