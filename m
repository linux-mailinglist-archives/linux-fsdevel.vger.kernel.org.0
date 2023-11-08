Return-Path: <linux-fsdevel+bounces-2452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2477E6111
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 00:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD17D1C2096C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 23:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E6F38DE6;
	Wed,  8 Nov 2023 23:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YjDT3b3V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1F9374EB
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 23:37:26 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BDD25A3
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 15:37:26 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5af592fed43so3375277b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Nov 2023 15:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699486645; x=1700091445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIcgmcP1EY6htEGo1pN6EVJRVE+qt/I8BKL1s/KEy5I=;
        b=YjDT3b3VA5LXmyfE5qxo4b0/zfiVxJVJeLNa3NwEIBTpx2nyLw1ZikWDHAFae/eh6Q
         qA89LqZRT7XLc837NgiEZ2ol0WfnDtajGMJD+X6zJbrA2rnbgrnLY78dxvgV2FmDLEzu
         u0nDiLzZsEHgTo2orj6d0Iu2zO5Wqonjpzy7A+Ylle05gUwsz6OVMrk8s/6EMRriEvC0
         uhW3GVwyXFcX4JO8e6PVeMUf0MJuwRCj1q1HcYeK1SWzAXE24wGtiTrq09bu1EqZAIzi
         k8YlqHi7Ige+g1TkzI9GToUx2g2Li8gC2Dn31k+9P+8XMJpGwhlHJ2YHoNzMhHoTdJea
         rT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699486645; x=1700091445;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oIcgmcP1EY6htEGo1pN6EVJRVE+qt/I8BKL1s/KEy5I=;
        b=PBm2A2qhjlP/sI948asZ000ycqJqc8jeouATlnlp0lZyV5WThax3pbF/zzk3JL2w0O
         /mr2sXFCpmokJvPjwMJmlqdm/6BYGrH6g8T07yAzQBWrGi4wXzoCsIt/lbVL0MLRWF1M
         FWf09xHbO9x285AUBb3R8GO5vMfzDnyEtQBlqPUu3AxE0aODjHuWG/xpl+n1GKzkPUnt
         2ZE7L0qgbCDY7/aGM8MwDSkg+lgivaCdQQiXMnVLEWBQwQtppBi/2BYc82GED70AJ0Sn
         BbaB0Nxvx2ebgRu3dC/t+/L+aqGyn82tOZx3gF0knAibyMmsCHFK1Te51jUybulHhNyV
         inVA==
X-Gm-Message-State: AOJu0Yy3GP83BnZRsTFkMGg1hd/5ltPJqZucTaIaV+W19bDA6D/x+ndR
	gMRicJ2Tas1FzwTac93xEGK9pXqgSwXvbQ==
X-Google-Smtp-Source: AGHT+IEQyf2yih5ALlCfgSEkVLSLt0Zq5IBGBmP/Cna+y8K3zSa/6bcCrG6olPCsXpdGmctjh3MSlNk2LvNOvw==
X-Received: from laogai.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2c9])
 (user=amoorthy job=sendgmr) by 2002:a05:6902:102:b0:da3:723b:b2a4 with SMTP
 id o2-20020a056902010200b00da3723bb2a4mr72222ybh.7.1699486645232; Wed, 08 Nov
 2023 15:37:25 -0800 (PST)
Date: Wed,  8 Nov 2023 23:37:19 +0000
In-Reply-To: <CAF7b7mrGYuyjyEPAesYzZ6+KDuNAmvRxEonT7JC8NDPsSP+qDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAF7b7mrGYuyjyEPAesYzZ6+KDuNAmvRxEonT7JC8NDPsSP+qDA@mail.gmail.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108233723.3380042-1-amoorthy@google.com>
Subject: Re: [PATCH 27/34] KVM: selftests: Introduce VM "shape" to allow tests
 to specify the VM type
From: Anish Moorthy <amoorthy@google.com>
To: amoorthy@google.com
Cc: ackerleytng@google.com, akpm@linux-foundation.org, anup@brainfault.org, 
	aou@eecs.berkeley.edu, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	chenhuacai@kernel.org, david@redhat.com, dmatlack@google.com, 
	isaku.yamahata@gmail.com, isaku.yamahata@intel.com, jarkko@kernel.org, 
	kirill.shutemov@linux.intel.com, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, kvmarm@lists.linux.dev, liam.merwick@oracle.com, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	mail@maciej.szmigiero.name, maz@kernel.org, mic@digikod.net, 
	michael.roth@amd.com, mpe@ellerman.id.au, oliver.upton@linux.dev, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	qperret@google.com, seanjc@google.com, tabba@google.com, 
	vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	wei.w.wang@intel.com, willy@infradead.org, xiaoyao.li@intel.com, 
	yilun.xu@intel.com, yu.c.zhang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 9:00=E2=80=AFAM Anish Moorthy <amoorthy@google.com> =
wrote:
>
> This commit breaks the arm64 selftests build btw: looks like a simple ove=
rsight?

Yup, fix is a one-liner. Posted below.

diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/=
testing/selftests/kvm/aarch64/page_fault_test.c
index eb4217b7c768..08a5ca5bed56 100644
--- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
+++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
@@ -705,7 +705,7 @@ static void run_test(enum vm_guest_mode mode, void *arg=
)
=20
 	print_test_banner(mode, p);
=20
-	vm =3D ____vm_create(mode);
+	vm =3D ____vm_create(VM_SHAPE(mode));
 	setup_memslots(vm, p);
 	kvm_vm_elf_load(vm, program_invocation_name);
 	setup_ucall(vm);

