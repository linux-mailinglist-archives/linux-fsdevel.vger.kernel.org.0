Return-Path: <linux-fsdevel+bounces-6164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43689814039
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 03:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F2828374A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 02:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FCF15D0;
	Fri, 15 Dec 2023 02:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n49iH/+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519F8EBC
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5c664652339so133845a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 18:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702608614; x=1703213414; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=oDvaa/loPXs8QqeKn/dbAir7W2iAEYYDHF7svcomArc=;
        b=n49iH/+0kxXivgE6iAXzj7+czwvv55cWQL9kTg0UMM4Lx/eMGtHI1DY8iyS8AUEKyc
         BRyF3R+lr2nr3Vdnna2E+4ITdULkAfxiVVSi1egPPzx9cc9RKKU09AdH3La6VvFIhJLV
         NztT/Dsg6me6YeSagWmh0YN2ZkfbUtN3yau7YTlkXto/l3MqOlL8Y6vOHLU9SqD1AeJu
         iV/bo/zfgnAIHCKtzeu+Qa60mcIRlQ8Yjfel6QOpAq0cZInCayks+NuaHEjGfmlRUPyf
         wCz8iT7/6SnM0/GVqvmyOCKCIc8+f3rZkxydiD808p9jvFdkDQWbXihRSBSYUvQQTd4P
         wJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702608614; x=1703213414;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDvaa/loPXs8QqeKn/dbAir7W2iAEYYDHF7svcomArc=;
        b=GCtFLWW2r623jgLigqi1I1Mp6TdOlGIHrjboMQpSf5itONPZ5IkuVIyPP0PmBSFh+m
         1v9oFkzuznoMruv7f5fDEM3ZTw7B++qFLT+OEoJRAMVkggB/KcFq0IDkJ7HZxj26iaxL
         vJENZ6yCsAJyMFPjxBLcanLLop0CXBUN0V1uy62IejJyV9l2oMY+g5IALzTqcmM1HGht
         BvVCawUEhmRap1qGnGxk8f38Kh5/402MwdE1N+vK4plJ2VXZ46v4T0HoFsEJ8qlyTZJe
         kk4jCoCuKiD5TXHe9Ti86PYWgRM5nfOk6KCYkrHKntaxsZuKpCiSY2jHUXcpx1CXPEDg
         9bkQ==
X-Gm-Message-State: AOJu0YzWknIBofXBJzxhfLdfNoIGW0OJpeu+F0yhcFl2EowpwWoM6DGs
	++nUYyyAklyrpRG2FmpanXYLwQ==
X-Google-Smtp-Source: AGHT+IE99vQkPCzS0fUw2+RGCuARu2aeWphX23kJyqBn5JyJXY6hondFJhuQ9dhnml5rfwoe6hL5lw==
X-Received: by 2002:a05:6a00:cd0:b0:6cd:e046:f3f0 with SMTP id b16-20020a056a000cd000b006cde046f3f0mr7542035pfv.13.1702608614486;
        Thu, 14 Dec 2023 18:50:14 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8470:c901:5e00:3dbe:d1bd])
        by smtp.gmail.com with ESMTPSA id r25-20020aa78b99000000b006d2738a2510sm384321pfd.146.2023.12.14.18.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:50:14 -0800 (PST)
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-34-201c483bd775@kernel.org>
User-agent: mu4e 1.10.8; emacs 29.1
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, Oleg
 Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees
 Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, "Rick P.
 Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta
 <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, Szabolcs Nagy
 <Szabolcs.Nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Florian Weimer <fweimer@redhat.com>, Christian
 Brauner <brauner@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 34/39] kselftest/arm64: Add a GCS test program built
 with the system libc
In-reply-to: <20231122-arm64-gcs-v7-34-201c483bd775@kernel.org>
Date: Thu, 14 Dec 2023 23:50:11 -0300
Message-ID: <875y1089i4.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Mark Brown <broonie@kernel.org> writes:

> +	/* Same thing via process_vm_readv() */
> +	local_iov.iov_base = &rval;
> +	local_iov.iov_len = sizeof(rval);
> +	remote_iov.iov_base = (void *)gcspr;
> +	remote_iov.iov_len = sizeof(rval);
> +	ret = process_vm_writev(child, &local_iov, 1, &remote_iov, 1, 0);
> +	if (ret == -1)
> +		ksft_print_msg("process_vm_readv() failed: %s (%d)\n",
> +			       strerror(errno), errno);

The comment and the error message say "process_vm_readv()", but the
function actually called is process_vm_writev(). Is this intended?

Also, process_vm_writev() is failing when I run on my Arm FVP:

# #  RUN           global.ptrace_read_write ...
# # Child: 1150
# # Child GCSPR 0xffffa210ffd8, flags 1, locked 0
# # process_vm_readv() failed: Bad address (14)
# # libc-gcs.c:271:ptrace_read_write:Expected ret (-1) == sizeof(rval) (8)
# # libc-gcs.c:272:ptrace_read_write:Expected val (281473401005692) == rval (281473402849248)
# # libc-gcs.c:293:ptrace_read_write:Expected val (281473401005692) == ptrace(PTRACE_PEEKDATA, child, (void *)gcspr, NULL) (0)
# # ptrace_read_write: Test failed at step #1
# #          FAIL  global.ptrace_read_write
# not ok 4 global.ptrace_read_write

If I swap process_vm_readv() and process_vm_writev(), then the read
succeeds but the write fails:

#  RUN           global.ptrace_read_write ...
# Child: 1996
# Child GCSPR 0xffffa7fcffd8, flags 1, locked 0
# process_vm_writev() failed: Bad address (14)
# libc-gcs.c:291:ptrace_read_write:Expected ret (-1) == sizeof(rval) (8)
# libc-gcs.c:293:ptrace_read_write:Expected val (281473500358268) == ptrace(PTRACE_PEEKDATA, child, (void *)gcspr, NULL) (0)
# ptrace_read_write: Test failed at step #1
#          FAIL  global.ptrace_read_write
not ok 4 global.ptrace_read_write

> +/* Put it all together, we can safely switch to and from the stack */
> +TEST_F(map_gcs, stack_switch)
> +{
> +	size_t cap_index;
> +	cap_index = (variant->stack_size / sizeof(unsigned long));
> +	unsigned long *orig_gcspr_el0, *pivot_gcspr_el0;
> +
> +	/* Skip over the stack terminator and point at the cap */
> + switch (variant->flags & (SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN)) {
> +	case SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN:
> +		cap_index -= 2;
> +		break;
> +	case SHADOW_STACK_SET_TOKEN:
> +		cap_index -= 1;
> +		break;
> +	case SHADOW_STACK_SET_MARKER:
> +	case 0:
> +		/* No cap, no test */
> +		return;
> +	}
> +	pivot_gcspr_el0 = &self->stack[cap_index];
> +
> +	/* Pivot to the new GCS */
> +	ksft_print_msg("Pivoting to %p from %p, target has value 0x%lx\n",
> +		       pivot_gcspr_el0, get_gcspr(),
> +		       *pivot_gcspr_el0);
> +	gcsss1(pivot_gcspr_el0);
> +	orig_gcspr_el0 = gcsss2();
> +	ksft_print_msg("Pivoted to %p from %p, target has value 0x%lx\n",
> +		       pivot_gcspr_el0, get_gcspr(),

Not sure about the intent here, but perhaps "get_gcspr()" here should be
"orig_gcspr_el0" instead? Ditto in the equivalent place at the
map_gcs.stack_overflow test below.

Also, it's strange that the tests defined after map_gcs.stack_overflow
don't run when I execute this test program. I'm doing:

$ ./run_kselftest.sh -t arm64:libc-gcs

I.e., these tests aren't being run in my FVP:

> +FIXTURE_VARIANT_ADD(map_invalid_gcs, too_small)
> +FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_1)
> +FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_2)
> +FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_3)
> +FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_4)
> +FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_5)
> +FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_6)
> +FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_7)
> +TEST_F(map_invalid_gcs, do_map)
> +FIXTURE_VARIANT_ADD(invalid_mprotect, exec)
> +FIXTURE_VARIANT_ADD(invalid_mprotect, bti)
> +FIXTURE_VARIANT_ADD(invalid_mprotect, exec_bti)
> +TEST_F(invalid_mprotect, do_map)
> +TEST_F(invalid_mprotect, do_map_read)

Finally, one last comment:

> +int main(int argc, char **argv)
> +{
> +	unsigned long gcs_mode;
> +	int ret;
> +
> +	if (!(getauxval(AT_HWCAP2) & HWCAP2_GCS))
> +		ksft_exit_skip("SKIP GCS not supported\n");
> +
> +	/* 
> +	 * Force shadow stacks on, our tests *should* be fine with or
> +	 * without libc support and with or without this having ended
> +	 * up tagged for GCS and enabled by the dynamic linker.  We
> +	 * can't use the libc prctl() function since we can't return
> +	 * from enabling the stack.  Also lock GCS if not already
> +	 * locked so we can test behaviour when it's locked.

This is probably a leftover from a previous version: the test doesn't
lock any GCS flag.

> +	 */
> +	ret = my_syscall2(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &gcs_mode);
> +	if (ret) {
> +		ksft_print_msg("Failed to read GCS state: %d\n", ret);
> +		return EXIT_FAILURE;
> +	}
> +	
> +	if (!(gcs_mode & PR_SHADOW_STACK_ENABLE)) {
> +		gcs_mode = PR_SHADOW_STACK_ENABLE;
> +		ret = my_syscall2(__NR_prctl, PR_SET_SHADOW_STACK_STATUS,
> +				  gcs_mode);
> +		if (ret) {
> +			ksft_print_msg("Failed to configure GCS: %d\n", ret);
> +			return EXIT_FAILURE;
> +		}
> +	}
> +
> +	/* Avoid returning in case libc doesn't understand GCS */
> +	exit(test_harness_run(argc, argv));
> +}


-- 
Thiago

