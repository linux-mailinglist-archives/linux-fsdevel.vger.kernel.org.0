Return-Path: <linux-fsdevel+bounces-53044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30D1AE936C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 02:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3360D16C744
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 00:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D930215B0EC;
	Thu, 26 Jun 2025 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A2gLGXhk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92202F1FC6;
	Thu, 26 Jun 2025 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750897803; cv=none; b=nO2+5Re9wgJMc1/RNgXoUktiS4tGs6wXd/AuqElQJD359Ml8WksntuK5CuH3w3VaiD7H1Cmfj2HS/3l7nm31QB0yB64GgGjo60+prodJmbkQaiE3iKwfYf6VCxfPF19wuiTDgX1tKpYlSwKmHsDW+Re1ejTe/dbUJXlks8mKs7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750897803; c=relaxed/simple;
	bh=rQVlwmiRyQSv075kPvUyrgQeXP16QvD+Pp6G7Fgm8Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rooqeUCVxqBlx5X/tyODig5eoHwey5PLDj+HD2bil1JGJOmBT2kVPAVRZJNyheyxcRwgyhOLetddjnEdx0kx/cD/Xb68k0HwJQ26p6rjwbAHqRW8+IMRCdhHoR8joCJSaUX0a7fkO/2BMD7u6BoIBGKtCblllJswivJt/tztRWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A2gLGXhk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=asEZ63uNdqnRmgnYrhTIGz393/XojMchHHXovIsLp68=; b=A2gLGXhkiJRwKraD1mBY5wWyCL
	GeOZiJPwZvqcEt0qCRpRQMvepDgFVG03f30rNTBwO+RF3qi2U3CFi6jByUPjAzwg5zYnxkPOaNgq7
	Osgw+RaQ71nqD9xutiRw9bBJUMzc3rPK4eRSEcC5MGy+0ppopQyaD1/NFX7S793wLpu7yUn7YrH6B
	aclVA3UqCsQ/Q/kaxvG6A7zwrf+X+c/dC/db1atMMDdQJnLN7GbfgY0ViwOpvvrpgwiPPWNo0Y21M
	YiSenSJp3vlkoDOoWzkCoZgPtjIIowycD8O23zl9ISm5G13ORwdKhhrfgniolA/D+Tr8ztFXarVLO
	HcgDD7kA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUaUZ-000000060m1-18Zj;
	Thu, 26 Jun 2025 00:29:27 +0000
Message-ID: <d6e44430-ec9c-4d77-a00b-15e97ab9beab@infradead.org>
Date: Wed, 25 Jun 2025 17:29:15 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 17/32] liveupdate: luo_sysfs: add sysfs state
 monitoring
To: Pasha Tatashin <pasha.tatashin@soleen.com>, pratyush@kernel.org,
 jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
 rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
 ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org,
 aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org,
 tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com,
 roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk,
 mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org,
 hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com,
 joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com,
 song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
 gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org,
 cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com,
 Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
 aleksander.lobakin@intel.com, ira.weiny@intel.com,
 andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
 bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
 stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
 brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
 <20250625231838.1897085-18-pasha.tatashin@soleen.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250625231838.1897085-18-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,


On 6/25/25 4:18 PM, Pasha Tatashin wrote:
> diff --git a/Documentation/ABI/testing/sysfs-kernel-liveupdate b/Documentation/ABI/testing/sysfs-kernel-liveupdate
> new file mode 100644
> index 000000000000..4cd4a4fe2f93
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-liveupdate
> @@ -0,0 +1,51 @@
> +What:		/sys/kernel/liveupdate/
> +Date:		May 2025
> +KernelVersion:	6.16.0
> +Contact:	pasha.tatashin@soleen.com
> +Description:	Directory containing interfaces to query the live
> +		update orchestrator. Live update is the ability to reboot the
> +		host kernel (e.g., via kexec, without a full power cycle) while
> +		keeping specifically designated devices operational ("alive")
> +		across the transition. After the new kernel boots, these devices
> +		can be re-attached to their original workloads (e.g., virtual
> +		machines) with their state preserved. This is particularly
> +		useful, for example, for quick hypervisor updates without
> +		terminating running virtual machines.
> +
> +
> +What:		/sys/kernel/liveupdate/state
> +Date:		May 2025
> +KernelVersion:	6.16.0
> +Contact:	pasha.tatashin@soleen.com
> +Description:	Read-only file that displays the current state of the live
> +		update orchestrator as a string. Possible values are:
> +
> +		"normal":	No live update operation is in progress. This is
> +				the default operational state.

Just an opinion, but the ':'s after each possible value aren't needed
and just add noise.

You could just drop the ':'s -- or you could make a table here, like
Documentation/ABI/testing/sysfs-hypervisor-xen does, by adding

                ===========     ================================================


> +		"prepared":	The live update preparation phase has completed
> +				successfully (e.g., triggered via the
> +				/dev/liveupdate event). Kernel subsystems have
> +				been notified via the %LIVEUPDATE_PREPARE
> +				event/callback and should have initiated state
> +				saving. User workloads (e.g., VMs) are generally
> +				still running, but some operations (like device
> +				unbinding or new DMA mappings) might be
> +				restricted. The system is ready for the reboot
> +				trigger.
> +
> +		"frozen":	The final reboot notification has been sent
> +				(e.g., triggered via the 'reboot()' syscall),
> +				corresponding to the %LIVEUPDATE_REBOOT kernel
> +				event. Subsystems have had their final chance to
> +				save state. User workloads must be suspended.
> +				The system is about to execute the reboot into
> +				the new kernel (imminent kexec). This state
> +				corresponds to the "blackout window".
> +
> +		"updated":	The system has successfully rebooted into the
> +				new kernel via live update. Restoration of
> +				preserved resources can now occur (typically via
> +				ioctl commands). The system is awaiting the
> +				final 'finish' signal after user space completes
> +				restoration tasks.

and

                ===========     ================================================

Or just disagree or ignore. :)

-- 
~Randy


