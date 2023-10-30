Return-Path: <linux-fsdevel+bounces-1564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0A37DBEFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 18:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16BD1C20AFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 17:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C57199BC;
	Mon, 30 Oct 2023 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyYlixsi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A1A199A6
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 17:32:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B692E9C
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 10:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698687117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3g1TVhpzsOzzHHVoXez8JAaDO7pX06gUTyU2b4+L2DI=;
	b=IyYlixsiNWlGKrXB5enn4+dorl8uqg2Mts1Q9YjRWfwNiWp6Sk4VVg7Ma30ySQiMb8I0oN
	T4h9w8/24va4fKDcRUUrG+U6OPg9LAHU8N6z5NHVwvGVcLUgma6HoG0dzruKFBr5mudWm+
	TRXs3yRjBxxXzgzfYOju046hqrWAbMs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-a-SKHrDOOs6iHx6NEzWtlA-1; Mon, 30 Oct 2023 13:31:56 -0400
X-MC-Unique: a-SKHrDOOs6iHx6NEzWtlA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4084001846eso35339735e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 10:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698687115; x=1699291915;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3g1TVhpzsOzzHHVoXez8JAaDO7pX06gUTyU2b4+L2DI=;
        b=Ra8rhAlyYvuD259t/RMlUL3rJDBqUUy7F/r2nyXe4S7SCIlBdfS3AB0DI/Ud95XjJU
         27VTMBe7h4N/9POd0DeWeDKcsEMXEZtB6L9A23vH680BvnKDCD9MUDOEUvr6lqE7ZrdQ
         I5HLe2Q/qb1OSqIOME2xbYeO/Maa8AnEhGac8+ZzU/ja5ax4a0rWgZtHhGOErn14f/3W
         PinsoZsBoI2sUFe/+gHLQ+7nenw1mqSM+x9XPupSxQBBK4vcYY7potYWu7QuMicFH5Br
         DYWnIWK/OYvl59FM/Qy4VfIuRn6lAe8FbTWJQr9j73tuI4ot0SGBtdN/x2nM2dbB9Iqt
         qwIw==
X-Gm-Message-State: AOJu0Yy7M0dbuDnC+DqRTkgRAfUBG+yhyLsUOlRZnsc0PSSgH3OgyQa7
	hZy9HIfutJ2XrlMGD6PHEJ6aj+FXly1V7kl1ZdkzX6ijVrJ9DQqTjmCdOYyTENbjpDHURlMB0hc
	grZUq7RUvVRET1fOKabAepgrJYQ==
X-Received: by 2002:a05:600c:3b13:b0:405:3455:567e with SMTP id m19-20020a05600c3b1300b004053455567emr8489628wms.5.1698687115253;
        Mon, 30 Oct 2023 10:31:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOw2pwrz3emhHHPGzRcEZaKdyXE5ETYrjkl0hP08/axAOlUIY6MyqVTu78CJe3u248QTKzww==
X-Received: by 2002:a05:600c:3b13:b0:405:3455:567e with SMTP id m19-20020a05600c3b1300b004053455567emr8489569wms.5.1698687114826;
        Mon, 30 Oct 2023 10:31:54 -0700 (PDT)
Received: from [192.168.1.174] ([151.81.68.207])
        by smtp.googlemail.com with ESMTPSA id c5-20020a05600c0a4500b004094d4292aesm449246wmq.18.2023.10.30.10.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 10:31:54 -0700 (PDT)
Message-ID: <0731604e-8692-4c51-9427-78b4c629f9e9@redhat.com>
Date: Mon, 30 Oct 2023 18:31:50 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 18/35] KVM: x86: "Reset" vcpu->run->exit_reason early
 in KVM_RUN
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Huacai Chen <chenhuacai@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Anish Moorthy <amoorthy@google.com>,
 David Matlack <dmatlack@google.com>, Yu Zhang <yu.c.zhang@linux.intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>,
 Vishal Annapurve <vannapurve@google.com>,
 Ackerley Tng <ackerleytng@google.com>,
 Maciej Szmigiero <mail@maciej.szmigiero.name>,
 David Hildenbrand <david@redhat.com>, Quentin Perret <qperret@google.com>,
 Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>,
 Liam Merwick <liam.merwick@oracle.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20231027182217.3615211-1-seanjc@google.com>
 <20231027182217.3615211-19-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20231027182217.3615211-19-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/23 20:22, Sean Christopherson wrote:
> Initialize run->exit_reason to KVM_EXIT_UNKNOWN early in KVM_RUN to reduce
> the probability of exiting to userspace with a stale run->exit_reason that
> *appears* to be valid.
> 
> To support fd-based guest memory (guest memory without a corresponding
> userspace virtual address), KVM will exit to userspace for various memory
> related errors, which userspace *may* be able to resolve, instead of using
> e.g. BUS_MCEERR_AR.  And in the more distant future, KVM will also likely
> utilize the same functionality to let userspace "intercept" and handle
> memory faults when the userspace mapping is missing, i.e. when fast gup()
> fails.
> 
> Because many of KVM's internal APIs related to guest memory use '0' to
> indicate "success, continue on" and not "exit to userspace", reporting
> memory faults/errors to userspace will set run->exit_reason and
> corresponding fields in the run structure fields in conjunction with a
> a non-zero, negative return code, e.g. -EFAULT or -EHWPOISON.  And because
> KVM already returns  -EFAULT in many paths, there's a relatively high
> probability that KVM could return -EFAULT without setting run->exit_reason,
> in which case reporting KVM_EXIT_UNKNOWN is much better than reporting
> whatever exit reason happened to be in the run structure.
> 
> Note, KVM must wait until after run->immediate_exit is serviced to
> sanitize run->exit_reason as KVM's ABI is that run->exit_reason is
> preserved across KVM_RUN when run->immediate_exit is true.
> 
> Link: https://lore.kernel.org/all/20230908222905.1321305-1-amoorthy@google.com
> Link: https://lore.kernel.org/all/ZFFbwOXZ5uI%2Fgdaf@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/x86.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ee3cd8c3c0ef..f41dbb1465a0 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10963,6 +10963,7 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
>   {
>   	int r;
>   
> +	vcpu->run->exit_reason = KVM_EXIT_UNKNOWN;
>   	vcpu->arch.l1tf_flush_l1d = true;
>   
>   	for (;;) {

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


