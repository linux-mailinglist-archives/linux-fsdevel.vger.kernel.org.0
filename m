Return-Path: <linux-fsdevel+bounces-768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530677CFDD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 17:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E549282117
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577CE31595;
	Thu, 19 Oct 2023 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zg4/aLh6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2FD3158B
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 15:28:07 +0000 (UTC)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA8E124
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 08:28:05 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-4580a2ec248so1700796137.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 08:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697729285; x=1698334085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ePdjmTFlmWfaU2E17cd2rM20Zga7y8maCxRmtdGFBCc=;
        b=Zg4/aLh6AhTSDdo7KIdqEZgb4FAOnWiw4lafqI37kOB7W3Pl5eu4zSI4jMu1MXIVj0
         tBzG0LMB6tbXmSjcKkTSRf/ZxqBYxDJDUNDuZZB09T6HfA9x3Ooy7SGehpamTE9rtuJ7
         cGSsgZ7Nd+N1vntrIEKyFBn3nBSg6f8urI/5AEIbbnQ6Hr7a7vsIpD7GSjEoLU7x+xai
         P8GdgWo8oeIe2Z70ALxZcmQAoyTVrwqMW2VFHvDDejG2M3rQaYDBZSMYFmtO3+9e/7SY
         MO1YDKKbUWQ+SkTjUsojbIwpBr4Refge4Rt+efkrdvrWCSHOlf9bA1pWsyeu1cmMf2bn
         p2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697729285; x=1698334085;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePdjmTFlmWfaU2E17cd2rM20Zga7y8maCxRmtdGFBCc=;
        b=fkyH+V/rXDVxPOVZeErmdAlrNuwOPooV6WgpJ3Ls2S6T8Nba6fBs/MNndqMtdMr2ep
         VP6VkbfLU33GtoV7GZ/M7uz9WBTxB32EWYCHFiTShbtiqd9lAKOsjZKVALAcnmoAoYsj
         nYB/92RdFKEZb3hZ0l4hw32BT2jeU7SxiXsTIdXAMq8Z7GLJmpm5bwLGLpQySQ4Aqf0r
         5XYD2Q4TCT2RLOKcgxblgXv3RvXp0TjV0TI8B8x9DF099LFlsT7HwcUq4fKeICYcSxCD
         ynnRNGpuTZHJN84SBBsYsmMWpF/D8tHleBADapW0VyYqLaOwlI6nSBTCAK8ZDH5ydzHR
         xoIA==
X-Gm-Message-State: AOJu0YxhIEzlOv3tAG03aA1QcXj+heIeTxA/qtOTOQyBWAmUPX1zuPwN
	q3kOHJeQhppGOPwsPkP2WWxk07D6TH58hxTN/qPWHQ==
X-Google-Smtp-Source: AGHT+IFRtisHRQ8llbCtMKcbt98E2rge5LFbQnavaVa23CCczzG4eiu/FxAW29PkAGxdTosFN9IPxLiigCvq1crVf+A=
X-Received: by 2002:a05:6102:1009:b0:457:ce8f:ded8 with SMTP id
 q9-20020a056102100900b00457ce8fded8mr2492151vsp.3.1697729284825; Thu, 19 Oct
 2023 08:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 19 Oct 2023 20:57:53 +0530
Message-ID: <CA+G9fYt75r4i39DuB4E3y6jRLaLoSEHGbBcJy=AQZBQ2SmBbiQ@mail.gmail.com>
Subject: re: autofs: add autofs_parse_fd()
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	linux-fsdevel@vger.kernel.org, autofs@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>, "Bill O'Donnell" <bodonnel@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The qemu-x86_64 and x86_64 booting with 64bit kernel and 32bit rootfs we call
it as compat mode boot testing. Recently it started to failed to get login
prompt.

We have not seen any kernel crash logs.

Anders, bisection is pointing to first bad commit,
546694b8f658 autofs: add autofs_parse_fd()

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Anders Roxell <anders.roxell@linaro.org>

steps to reproduce:
----------------
# To install tuxrun to your home directory at ~/.local/bin:
# pip3 install -U --user tuxrun==0.49.2
#
# Or install a deb/rpm depending on the running distribution
# See https://tuxmake.org/install-deb/ or
# https://tuxmake.org/install-rpm/
#
# See https://tuxrun.org/ for complete documentation.
#

tuxrun --runtime podman --device qemu-x86_64 --boot-args rw --kernel
https://storage.tuxsuite.com/public/linaro/lkft/builds/2WyQyyM0OvXnnbI0d84HL0v1J56/bzImage
--modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2WyQyyM0OvXnnbI0d84HL0v1J56/modules.tar.xz
--rootfs https://storage.tuxboot.com/debian/bookworm/i386/rootfs.ext4.xz
--parameters SKIPFILE=skipfile-lkft.yaml --parameters SHARD_NUMBER=10
--parameters SHARD_INDEX=3 --image
docker.io/linaro/tuxrun-dispatcher:v0.49.2 --tests ltp-cve --timeouts
boot=15 --overlay
https://storage.tuxboot.com/overlays/debian/bookworm/i386/ltp/20230929/ltp.tar.xz


Please find related links to test and results comparison.

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231019/testrun/20695093/suite/boot/test/gcc-13-lkftconfig-compat/history/?page=1
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230926/testrun/20125035/suite/boot/test/gcc-13-lkftconfig-compat/details/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2WyR2MGbyTalC8rGugHIZXPMldC/reproducer
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2WyR2MGbyTalC8rGugHIZXPMldC
--
Linaro LKFT
https://lkft.linaro.org

