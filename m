Return-Path: <linux-fsdevel+bounces-76634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LJMEO8+hmnzLAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:20:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D01102A1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13A9D309989B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 19:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B61429816;
	Fri,  6 Feb 2026 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Lw5RQFPs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083A142884C
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405189; cv=none; b=uDz78ZSYCe7K1pIzVCHKgz01TUDXodigGboNEKX/29VZG0CAr440y7l9FqTRBLlYSmgZNwphj/fLl2nYaL3TvKyCOLH2sWzpUodSTeRd/pEsIxnckhoSHr4CAOqijM9f/T4lKdpKMBsVvLo8Tfl25bZoWQBxvzwx/9/3fdJI1Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405189; c=relaxed/simple;
	bh=sqVfhQKOoX//8UMrB+n9EJdt1c01mJ+RznOwitCGzcc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=a0SKmQOoViw2td7s72CpNC0gDVLTrTBfYJyKGwOWMeEHb0YmrxsSqgbrK1vF95G7Z0no8it14MZaoAH+Dk86ZbnRpyzbyXPI2CZ0NwkMN7SAW5OBLE3W6CZQdHo8hMy8o7NXO2NoybHLRrEc5++O40izKNjs0e6YPzbUYlbeyHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Lw5RQFPs; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-794911acb04so11668897b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 11:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1770405188; x=1771009988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu1z48KYD2GkC4sgRYY/gR/q5v6MBccc8TbuVDHZ7mU=;
        b=Lw5RQFPsLgd8rJYVlJ7Tv+O5up8pm/gR5sDevtc1F42a9Tj4moHpz2WTE1BoYr1rBZ
         7alMDdx0fenFTg63KC9DPoPIN3PZfEK7fmK5XqcWZE8JfBQJdc4+qxQHrLONklW3v8Cj
         A0FvCY5kHNU8CqKVF2d2UnqyxPQD17/MUZNYzEgOWvGkusXXrCyKaiR/gB701wLItxIW
         nmpZSBEVmOTe5uUSq+kgyfchdUU8zOwMIzO7XfeLyEmVWuBpxtG5pG/u+ME7UMYzK+xm
         CdlWKbAYRRINRSCQecR7FQ/zJx2EKxWXAatgMt3tSxEMVORgkTSNpIIq2P4PbczwJO7R
         E6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770405188; x=1771009988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bu1z48KYD2GkC4sgRYY/gR/q5v6MBccc8TbuVDHZ7mU=;
        b=he4Cn9l+mVtovjv9pEpr15NDSeMO4dZM6ca9m42FqKleQwhPnzPNtDDQfcYTTGxB5z
         0DejslD+cl7Qumi+hpcDm7fI6DypID3Pygkp+1UTdRncdkYkUPsVwedh2n2MxFFNRglk
         LJig0m9pUcVbHq8HDgNKOZu5Jgh09qwShOSkUeGnB0whxnZLEMbkF9zHiPmGKQKZ+tHW
         iH9UPpwOT6uaxiLo+Z7z4eopXZtMcGBWhfXxiQzGt6eFFRVldQlr3DdzPe1qjZWaNYGL
         r0OM88P/LNjDFnYc0hdZ4UDN4ejGVUG/mHxOZER0NMCu+RgACSlz8K7kzEEfHdpNO+sk
         qgQg==
X-Gm-Message-State: AOJu0Yzid2EgTww3JJGTeXgGbvGvQ/XrHoOagPmC5UASFKKe+wzZAg8Q
	Yfym3XGmSaJO3wfvbFfSLOyWwwnVuwyj74FVAGOvLC8n8PCz+77a0fk3OETYymmYsEb7SF9xbpr
	x4zOlfCQ=
X-Gm-Gg: AZuq6aJM7Gn+HEsmKsy8pIPYDyEsAqmsHcDvQCecd3NPts0fkgFuc0z5g7BkeVshw4R
	8wY1TguwFSH+m4V2tFpyD6gKRTRYuQwfJKZL2xiJ2zvRlP/7GPqAj/E/h2tYulEYxURWWvXsSjO
	KKf4P3gnF8NTGaJUJkc2oddAX0IV436DmPgyvtnnNSZmYOX6rAfgNWZlCwXs1tE71kNysyvzaFF
	ePxBJSBWfxSrPQb70EU9rO2ZhLF8MpOO4e2nXcGFz9KWdjML0bb/83011WPrChqSYUPS2A1aE39
	osyH+8S/TDomZcSFGNjzCib5npqx+1P9h6TjNKGxxVkHgTrLuxvJF+RoPyVkTjf7fZ6hqQEPNrh
	abkojGWKLzcqEDEkpMUe9zd89d+wBLqAgcZ7f06ZPBpMfM0kpzC/EhI/I/9Li3ZH8dWBliyPZFz
	Gxdt71WvacS6/5BknqZ87DbncRYy+smfR+ibsQwbi7rGPKOFJWC1hDQ69Q+bH3L1hXZmjNWcPpd
	DVF54CC/qht
X-Received: by 2002:a05:690c:4510:b0:794:e3c2:f338 with SMTP id 00721157ae682-7952ab1a634mr38039097b3.42.1770405187694;
        Fri, 06 Feb 2026 11:13:07 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:9fc0:ed7d:72bd:ecd1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a28697fsm29051277b3.50.2026.02.06.11.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 11:13:07 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/4] Machine Learning (ML) library in Linux kernel
Date: Fri,  6 Feb 2026 11:11:32 -0800
Message-Id: <20260206191136.2609767-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[dubeyko-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[dubeyko.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dubeyko-com.20230601.gappssmtp.com:+];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail,dubeyko-com.20230601.gappssmtp.com:server fail,dubeyko.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76634-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava@dubeyko.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: A8D01102A1B
X-Rspamd-Action: no action

Hello,

This patchset introduces initial vision of Machine Learning (ML) library
in Linux kernel. It is an effort to define the ML library API and
to elaborate the way of running ML models in Linux kernel.

Linux kernel is a huge code base with enormous number of subsystems and
possible configuration options. Complexity and changing nature of modern
workloads result in complexity of elaborating an efficient configuration
and state of running Linux kernel.

Machine Learning (ML) is approach/area of learning from data,
finding patterns, and making predictions without implementing algorithms
by developers. The number of areas of ML applications is growing
with every day. Generally speaking, ML can introduce a self-evolving and
self-learning capability in Linux kernel.  There are already research works
and industry efforts to employ ML approaches for configuration and
optimization the Linux kernel. However, introduction of ML approaches
in Linux kernel is not so simple and straightforward way. There are multiple
problems and unanswered questions on this road. First of all, any ML model
requires the floating-point operations (FPU) for running. But there is
no direct use of FPUs in kernel space. Also, ML model requires training phase
that can be a reason of significant performance degradation of Linux kernel.
Even inference phase could be problematic from the performance point of view
on kernel side. The using of ML approaches in Linux kernel is inevitable step.
But, how can we use ML approaches in Linux kernel? Which infrastructure
do we need to adopt ML models in Linux kernel?

What is the goal of using ML models in Linux kernel? The main goal is
to employ ML models for elaboration of a logic of particular Linux kernel
subsystem based on processing data or/and an efficient subsystem
configuration based on internal state of subsystem. As a result, it needs:
(1) collect data for training, (2) execute ML model training phase,
(3) test trained ML model, (4) use ML model for executing the inference phase.
The ML model inference can be used for recommendation of Linux kernel
subsystem configuration or/and for injecting a synthesized subsystem logic
into kernel space (for example, eBPF logic).

How ML infrastructure can be designed in Linux kernel? It needs to introduce
in Linux kernel a special ML library that can implement a generalized
interface of interaction between ML model’s thread in user-space and kernel
subsystem. Likewise interface requires to have the means:
(1) create/initialize/destroy ML model proxy in kernel subsystem,
(2) start/stop ML model proxy, (3) get/preprocess/publish data sets
from kernel space, (4) receive/preprocess/apply ML model recommendation(s)
from user-space, (5) execute synthesized logic/recommendations in kernel-space,
(6) estimate efficiency of synthesized logic/recommendations,
(7) execute error back-propagation with the goal of correction ML model
on user-space side.

The create and initialize logic can be executed by kernel subsystem during
module load or Linux kernel start (oppositely, module unload or kernel
shutdown will execute destroy of ML model proxy logic). ML model thread
in user-space will be capable to re-initialize and to execute
the start/stop logic of  ML model proxy on kernel side. First of all,
ML model needs to be trained by data from kernel space. The data can be
requested by ML model from user-space or data can be published by ML model
proxy from kernel-space. The sysfs interface can be used to orchestrate
this interaction. As a result, ML model in user-space should be capable
to extract data set(s) from kernel space through sysfs, FUSE or character
device. Extracted data can be stored in persistent storage and, finally,
ML model can be trained in user-space by accessing these data.

The continuous learning model can be adopted during training phase.
It implies that kernel subsystem can receive ML model recommendations
even during training phase. ML model proxy on kernel side can estimate
the current kernel subsystem state, tries to apply the ML model
recommendations, and estimate the efficiency of applied recommendations.
Generally speaking, ML model proxy on kernel side can consider several
modes of interaction with ML model recommendations: (1) emergency mode,
(2) learning mode, (3) collaboration mode, (4) recommendation mode.
The emergency mode is the mode when kernel subsystem is in critical state
and it is required to work as efficient as possible without capability of
involving the ML model recommendations (for example, ML model
recommendations are completely inadequate or load is very high).
The learning mode implies that kernel subsystem can try to apply
the ML model recommendations for some operations with the goal of
estimation the maturity of ML model. Also, ML model proxy can degrade
the mode to learning state if ML model recommendations becomes inefficient.
The collaboration mode has the goal of using ML recommendations in
50% of operations with the goal of achieving mature state of ML model.
And, finally, ML model proxy can convert kernel subsystem in recommendation
mode if ML model is mature enough and efficiency of applying
the ML recommendations is higher than using human-made algorithms.
The back-propagation approach can be used to correct the ML model
by means of sharing feedback of efficiency estimation from kernel
to user-space side.

[REFERENCES]
[1] https://lore.kernel.org/linux-fsdevel/20240605110219.7356-1-slava@dubeyko.com/
[2] https://www.youtube.com/watch?v=E7q0SKeniXU
[3] https://github.com/kernel-ml-lib/ml-lib
[4] https://github.com/kernel-ml-lib/ml-lib-linux

Viacheslav Dubeyko (4):
  ml-lib: Introduce Machine Learning (ML) library declarations
  ml-lib: Implement PoC of Machine Learning (ML) library functionality
  ml-lib: Implement simple testing character device driver
  ml-lib: Implement simple user-space testing application

 include/linux/ml-lib/ml_lib.h                 | 425 ++++++++++
 lib/Kconfig                                   |   6 +
 lib/Makefile                                  |   2 +
 lib/ml-lib/Kconfig                            |  18 +
 lib/ml-lib/Makefile                           |   7 +
 lib/ml-lib/ml_lib_main.c                      | 758 ++++++++++++++++++
 lib/ml-lib/sysfs.c                            | 187 +++++
 lib/ml-lib/sysfs.h                            |  17 +
 lib/ml-lib/test_driver/Kconfig                |  22 +
 lib/ml-lib/test_driver/Makefile               |   5 +
 lib/ml-lib/test_driver/README.md              | 233 ++++++
 lib/ml-lib/test_driver/ml_lib_char_dev.c      | 530 ++++++++++++
 .../test_application/ml_lib_char_dev_ioctl.h  |  21 +
 .../test_application/test_ml_lib_char_dev.c   | 206 +++++
 14 files changed, 2437 insertions(+)
 create mode 100644 include/linux/ml-lib/ml_lib.h
 create mode 100644 lib/ml-lib/Kconfig
 create mode 100644 lib/ml-lib/Makefile
 create mode 100644 lib/ml-lib/ml_lib_main.c
 create mode 100644 lib/ml-lib/sysfs.c
 create mode 100644 lib/ml-lib/sysfs.h
 create mode 100644 lib/ml-lib/test_driver/Kconfig
 create mode 100644 lib/ml-lib/test_driver/Makefile
 create mode 100644 lib/ml-lib/test_driver/README.md
 create mode 100644 lib/ml-lib/test_driver/ml_lib_char_dev.c
 create mode 100644 lib/ml-lib/test_driver/test_application/ml_lib_char_dev_ioctl.h
 create mode 100644 lib/ml-lib/test_driver/test_application/test_ml_lib_char_dev.c

-- 
2.34.1


