Return-Path: <linux-fsdevel+bounces-76693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LhpJBgexiWnJAwUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 11:03:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A9A10DF1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 11:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2478E301C6F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8303644C4;
	Mon,  9 Feb 2026 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV7dtvyw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0981B4138
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770631410; cv=none; b=pqiKEoVOvfqW1L6evu0jYiFMnaGnG5R0Qii3VZZwFo20oOkYgFu9cVyfZqdJdRVYAqjShGuaqfd4j1N7lKdOcVmUQncbkQyBOPR1w7/zCsTDjZZrPbBi4SFt4aUXAlJIgG+YelYaGVbGZbv/yvyd1xhHzNsyTtDl/VxLxmS7u5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770631410; c=relaxed/simple;
	bh=xE3j8NVU0S43Vi8Kms5RnGUIbpIPaxuF9l00xrrETBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaoTTX7UZK9vsEXWVrT5zVl0+P4NkKzRx7WX6CoqBRdeWfoU4NBL9Y/D4UlCyA4KWIoG3uJtO3XOBjHwrvFkmxQD/eP8rBFwFf4TsF5JHJ/qfX2KPTzCig3uy5qhZMYLWBM8VcPk9ISol+qZtY+2B728Rai8U4+TaA7ieJdC5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mV7dtvyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8119CC116C6
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 10:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770631410;
	bh=xE3j8NVU0S43Vi8Kms5RnGUIbpIPaxuF9l00xrrETBk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mV7dtvywDcK4sdTYnpzZZQuVwucy8E1GLlNUJTwp1CG8uVaqrXWuEKoS3ZjYuFMoa
	 EZrljNF3VLwKvqQvVrzHao2TqI5a2GQTEVjNuQWeFhXKerBfgQxc6rMYPMCXqyZNbR
	 vXu8UW/K8bTVQu7fgqs6B/p0XI8hXtoaExv5SBCulTjW9Ms86tcfyuQPXfK5W8CpDf
	 Yv5SDO8afqoQYuSKao7FvYKK95mJhStPK3qggtxiJ0nDr3BpJawteKfQsp3ogcqstd
	 f/z1p7B6nCAVAcoClHH6WHVfvJCBH+L/FSopgXSvy+5XBay2YGNEJW76Cn67g+c/rJ
	 6UZ9ZHyMCktag==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-790b7b3e594so45309877b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 02:03:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWl54v6Sob9dGV4cY/HV0ay8Tl3djxIDfBZADQQ0ZEViSMjy7VRiqYHnrwsrpYZ+OUDCK1c/aAV4l4mIVnB@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ2421vn/MUnhupvq+QH52MXdtq9drWYxW4DacJ93UxVGCYQgV
	9qDDp27OebXl9tWToSFfJ8Xoza+qFwbjyWf0VXdSTVxwRjBc7rc7X3Sy5jDV9OlrG5Bt4cdQjb7
	enH4UdAtDnxCGc6MZ9UeMLRWDi4HxByQU7RkAyZSxfw==
X-Received: by 2002:a05:690c:a96:b0:795:e10:3c9c with SMTP id
 00721157ae682-7952aaa780dmr100866807b3.29.1770631409841; Mon, 09 Feb 2026
 02:03:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <47d21a6821c4b2d085f7b97bcdaa205bfcb0e0ad.camel@ibm.com>
In-Reply-To: <47d21a6821c4b2d085f7b97bcdaa205bfcb0e0ad.camel@ibm.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 9 Feb 2026 02:03:18 -0800
X-Gmail-Original-Message-ID: <CACePvbVH0ovOcBqCN7kJ3n0QFmvuf+_5tMeRXs-JAQ+m5fdoCg@mail.gmail.com>
X-Gm-Features: AZwV_Qjeos_xGeoSPEqb_Nm-xUatLudlVqnasCFc34nCWxZ9Bx_b5Ln4iDFXUhQ
Message-ID: <CACePvbVH0ovOcBqCN7kJ3n0QFmvuf+_5tMeRXs-JAQ+m5fdoCg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Machine Learning (ML) library in Linux kernel
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	Viacheslav Dubeyko <vdubeyko@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76693-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99A9A10DF1B
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 11:38=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> Hello,
>
> Machine Learning (ML) is approach/area of learning from data,
> finding patterns, and making predictions without implementing algorithms
> by developers. The number of areas of ML applications is growing
> with every day. Generally speaking, ML can introduce a self-evolving and
> self-learning capability in Linux kernel. There are already research work=
s
> and industry efforts to employ ML approaches for configuration and
> optimization the Linux kernel. However, introduction of ML approaches
> in Linux kernel is not so simple and straightforward way. There are multi=
ple
> problems and unanswered questions on this road. First of all, any ML mode=
l
> requires the floating-point operations (FPU) for running. But there is
> no direct use of FPUs in kernel space. Also, ML model requires training p=
hase
> that can be a reason of significant performance degradation of Linux kern=
el.
> Even inference phase could be problematic from the performance point of v=
iew
> on kernel side. The using of ML approaches in Linux kernel is inevitable =
step.
> But, how can we use ML approaches in Linux kernel? Which infrastructure
> do we need to adopt ML models in Linux kernel?

I think there are two different things, I think you want the latter
but I am not sure

1) using ML model to help kernel development, code reviews, generate
patches by descriptions etc. For example, Chris Mason has a kernel
review repo on github and he is sharing his review finding the mailing
list:
https://github.com/masoncl/review-prompts/tree/main
It is kernel development related, but the ML agent code is running in
the user space. The actual ML computation might run GPU/TPUs. That
does not seem to be what you have in mind.

2) Run the ML model computation in the kernel space.
Can you clarify if this is what you have in mind? You mention kernel
FPU usage in the kernel for ML model. It is only relevant if you need
to run the FP in the kernel CPU instructions. Most ML computations are
not run in CPU instructions. They run on GPUs/TPUs. Why not keep the
ML program (PyTorch/agents) in the user space and pass the data to the
GPU/TPU driver to run? There will be some kernel instructure like
VFIO/IOMMU involved with the GPU/TPU driver. For the most part the
kernel is just facilitating the data passing to/from the GPU/TPU
driver then to the GPU/TPU hardware. The ML hardware is doing the
heavy lifting.

> What is the goal of using ML models in Linux kernel? The main goal is
> to employ ML models for elaboration of a logic of particular Linux kernel
> subsystem based on processing data or/and an efficient subsystem
> configuration based on internal state of subsystem. As a result, it needs=
:
> (1) collect data for training, (2) execute ML model training phase,
> (3) test trained ML model, (4) use ML model for executing the inference p=
hase.

As far as I can tell, a lot of those don't need to be in the kernel's
business. It is more of a GPU/TPU driver user space interface thing,
might be easier to allow the driver to convert their own kernel/user
space API then expose common user space library API. Are you trying to
define something like Nvidia CUDA at the kernel level?

> The ML model inference can be used for recommendation of Linux kernel
> subsystem configuration or/and for injecting a synthesized subsystem logi=
c
> into kernel space (for example, eBPF logic).

That again sounds very much like a userspace issue, the above 1) usage case=
.

> How ML infrastructure can be designed in Linux kernel? It needs to introd=
uce
> in Linux kernel a special ML library that can implement a generalized
> interface of interaction between ML model=E2=80=99s thread in user-space =
and kernel
> subsystem. Likewise interface requires to have the means:
> (1) create/initialize/destroy ML model proxy in kernel subsystem,
> (2) start/stop ML model proxy, (3) get/preprocess/publish data sets
> from kernel space, (4) receive/preprocess/apply ML model recommendation(s=
)
> from user-space, (5) execute synthesized logic/recommendations in kernel-=
space,
> (6) estimate efficiency of synthesized logic/recommendations,
> (7) execute error back-propagation with the goal of correction ML model
> on user-space side.

Unfortunately a lot of those will be tight to the internal
implementation of the GPU/TPU. The model needs to be compiled into
GPU/TPU machine instructions. So forcing a common interface will be
hard because the lower interface requirement might be very different.
Maybe having some common user space library or ML description language
is better than forcing a kernel interface.

> The create and initialize logic can be executed by kernel subsystem durin=
g
> module load or Linux kernel start (oppositely, module unload or kernel
> shutdown will execute destroy of ML model proxy logic). ML model thread
> in user-space will be capable to re-initialize and to execute
> the start/stop logic of  ML model proxy on kernel side. First of all,
> ML model needs to be trained by data from kernel space. The data can be
> requested by ML model from user-space or data can be published by ML mode=
l
> proxy from kernel-space. The sysfs interface can be used to orchestrate
> this interaction. As a result, ML model in user-space should be capable
> to extract data set(s) from kernel space through sysfs, FUSE or character
> device. Extracted data can be stored in persistent storage and, finally,
> ML model can be trained in user-space by accessing these data.

Currently a lot of those are happening in the GPU/TPU drivers and user
space library. One challenging aspect is the hardware interface is
very different between GPUs/TPUs, and might be challenging to expose
common interfaces.

> The continuous learning model can be adopted during training phase.
> It implies that kernel subsystem can receive ML model recommendations
> even during training phase. ML model proxy on kernel side can estimate
> the current kernel subsystem state, tries to apply the ML model
> recommendations, and estimate the efficiency of applied recommendations.
> Generally speaking, ML model proxy on kernel side can consider several
> modes of interaction with ML model recommendations: (1) emergency mode,

That sounds like user space interaction again. Not sure it is for the
kernel space.

Chris

