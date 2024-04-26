Return-Path: <linux-fsdevel+bounces-17865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F418B316D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 09:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9D41F2269E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 07:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65AB13C667;
	Fri, 26 Apr 2024 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6EVUWWW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB8313BC2B;
	Fri, 26 Apr 2024 07:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116840; cv=none; b=DxGqRVGP92GH5PlWbKy+xoyHBGoVeohpsLcVO0cU5uTjuizVWX14TsYgGX6GUuEZbmIsdmOomBNzsTv9t5f+KGdxZVDM3mTS+g3t3ITV1vvQOmKuaI1Ydieby3t9k0Fm8iOM9XslsoReeXjFOQjM3aAMAwRxOqKhKhfJnd55RSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116840; c=relaxed/simple;
	bh=gksl38yx9eZzDHDXbUKTYhZmDGqlaFTVA8MzoHCjPSQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hK2bnoeCZoVdT08nfXK04YIJzhD3hdQAngLjqGbpUaF5Vw74jGyPpqimK0QS512Zeuzjk7Tb8wyXf7m3tAMsJehbnhUDlZkS0iIfff1DWOsWfVJkiTsgti5z+n4pK/eQPh0LPM4ECOWo8m9ydm9uE0kPlCiSScUHk+8uZj4usCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6EVUWWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A6EC113CD;
	Fri, 26 Apr 2024 07:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714116839;
	bh=gksl38yx9eZzDHDXbUKTYhZmDGqlaFTVA8MzoHCjPSQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=r6EVUWWWwqWuB2/4TPNdaGpUi5w/svatLiUkQPW7jg/Kqfz+v9PjTsqhHX0V5+EAd
	 O9Q7MLhBBw+u+yC3YJdVVaI93yGyVAyg60gYgQw+aYYn1jycUg0XiChWp0Iu1VFKMv
	 DwPywl0dLcmeXRt7ZEBqHGpgzLkfbaLNMsfQI9WfrWSOqgHI+raXZsInlkpmvx5zN2
	 Aw4iSz/F3PrrMtthz0B2wb3NwCnmeHWiHSYEJZOSeSYq9iQITvYdPXRUZEGz3Zp6OT
	 dsVslJOA6lLCpSJkkdCeyvYqDh4fWotWkzTVM/CVN72PQmXal5hJg3KuZB1fRSHKNY
	 lVwcEZNrXTKCg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Apr 2024 10:33:40 +0300
Message-Id: <D0TVP8ILJMO0.HERRWR4PA7N6@kernel.org>
Cc: "Dan Carpenter" <dan.carpenter@linaro.org>, "Shuah Khan"
 <shuah@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Marc Zyngier" <maz@kernel.org>,
 "Oliver Upton" <oliver.upton@linux.dev>, "Huacai Chen"
 <chenhuacai@kernel.org>, "Michael Ellerman" <mpe@ellerman.id.au>, "Anup
 Patel" <anup@brainfault.org>, "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, <kvm@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
 <linux-mips@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, "Xiaoyao Li" <xiaoyao.li@intel.com>, "Xu
 Yilun" <yilun.xu@intel.com>, "Chao Peng" <chao.p.peng@linux.intel.com>,
 "Fuad Tabba" <tabba@google.com>, "Anish Moorthy" <amoorthy@google.com>,
 "David Matlack" <dmatlack@google.com>, "Yu Zhang"
 <yu.c.zhang@linux.intel.com>, "Isaku Yamahata" <isaku.yamahata@intel.com>,
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, "Vlastimil Babka"
 <vbabka@suse.cz>, "Vishal Annapurve" <vannapurve@google.com>, "Ackerley
 Tng" <ackerleytng@google.com>, "Maciej Szmigiero"
 <mail@maciej.szmigiero.name>, "David Hildenbrand" <david@redhat.com>,
 "Quentin Perret" <qperret@google.com>, "Michael Roth"
 <michael.roth@amd.com>, "Wang" <wei.w.wang@intel.com>, "Liam Merwick"
 <liam.merwick@oracle.com>, "Isaku Yamahata" <isaku.yamahata@gmail.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, "Naresh Kamboju"
 <naresh.kamboju@linaro.org>, "Anders Roxell" <anders.roxell@linaro.org>,
 "Benjamin Copeland" <ben.copeland@linaro.org>
Subject: Re: [PATCH v13 25/35] KVM: selftests: Convert lib's mem regions to
 KVM_SET_USER_MEMORY_REGION2
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Sean Christopherson" <seanjc@google.com>, "Shuah Khan"
 <skhan@linuxfoundation.org>
X-Mailer: aerc 0.17.0
References: <20231027182217.3615211-1-seanjc@google.com>
 <20231027182217.3615211-26-seanjc@google.com>
 <69ae0694-8ca3-402c-b864-99b500b24f5d@moroto.mountain>
 <3848a9ad-07aa-48da-a2b7-264c4a990b5b@linuxfoundation.org>
 <ZipyPYR8Nv_usoU4@google.com>
In-Reply-To: <ZipyPYR8Nv_usoU4@google.com>

On Thu Apr 25, 2024 at 6:09 PM EEST, Sean Christopherson wrote:
> +       __TEST_REQUIRE(kvm_has_cap(KVM_CAP_USER_MEMORY2),
> +                      "KVM selftests from v6.8+ require KVM_SET_USER_MEM=
ORY_REGION2");

This would work also for casual (but not seasoned) visitor in KVM code
as additionl documentation.

BR, Jarkko

