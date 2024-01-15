Return-Path: <linux-fsdevel+bounces-7923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA0582D4FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 09:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01881C211D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 08:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A376763D1;
	Mon, 15 Jan 2024 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="r6T8lEKz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F256C63AA
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50eaabc36bcso10313213e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 00:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1705306972; x=1705911772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kVTDoIqL6CYlKzETPBmOt5Gu0I1nTmHVEOvMBLJmlXk=;
        b=r6T8lEKzrwpXjABgFiTMp8WADS/H9SUljSt4TVu5dF2hTRB3n9vi4iA5RUk73B1/G7
         1bEB1SiFypFLFuyx+HrWpIR7fI+5ZhxEE7FSu/EZviAW9jRrF3GA/qgltslB+FhjVVy+
         jXTG79V+cmanm4CpsnTe67uScUKy9CCLDq+WCNvDoPX5fdiQpCr+lW9aO/SNXiMrL0ik
         BpB5Yzg27Q4guCEeUXyQdffFXWCJv2CUGBU3aYXC9I6/+RV/+Ey+4tUVZxMJIGzxNdmb
         Kp8JJQRqRuskGMk0WusYlXzelY5D2lVv6xQm6WgA6jqUWqMZueGs4ReqsEkDNhJ/sQkE
         e7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705306972; x=1705911772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVTDoIqL6CYlKzETPBmOt5Gu0I1nTmHVEOvMBLJmlXk=;
        b=igT9viFgW94RGafKulOUNbTnZSwvPBaApZCUGD1OllCfnNmF1Cg/0J3yPmuW31wpVt
         KLFyexdofqoKnCI9kroqeUltvG93ynPQILWJZBOg/1ZplJQ5SyFqGvM1q0MbuXAv6bLX
         FzD2Dd86bEzRlNf+y4igsZEVzglv6JcUsk4THOw6axPvpOCDZ4mFR8+TUREXV4MgyBUx
         oD7nYKfkqnTXl3mCbKvogCWnY84u6mIVSx3G/oZH9zziTLwJa5woGmPbrBk0PAXsjYwu
         ZXHI2shlYPjmSJV3K+7AmaqlyX5F8tgEcXfUlHBpW8oEWmlqk+LUM/kzHaV/Tg1gyKkr
         xj/A==
X-Gm-Message-State: AOJu0Yxj97/46U7Z3OncykjISYRnvH3QhFLGZIYBUq7VMoLVTlS/xj9J
	oy7/DeeTxXDrHxeYX52gE6kEs1SFfCPXbpbCHhCfJNSiyezKEt3W
X-Google-Smtp-Source: AGHT+IGXR98XulC6JUj9iaNq+cfxjxccCNtirb9C5fquLnE4LAiPLo/v5gQH+ZMrqnQ2nHNHquJ2Lg==
X-Received: by 2002:a05:6512:2305:b0:50e:db50:3b84 with SMTP id o5-20020a056512230500b0050edb503b84mr2894004lfu.100.1705306971842;
        Mon, 15 Jan 2024 00:22:51 -0800 (PST)
Received: from system76-pc.. ([2a00:1370:81a4:169c:b283:d681:9baf:afcf])
        by smtp.gmail.com with ESMTPSA id m16-20020ac24250000000b0050e7be886d9sm1398555lfl.56.2024.01.15.00.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 00:22:51 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org
Cc: kent.overstreet@linux.dev,
	naohiro.aota@wdc.com,
	Matias.Bjorling@wdc.com,
	javier.gonz@samsung.com,
	bvanassche@acm.org,
	dlemoal@kernel.org,
	slava@dubeiko.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [LSF/MM/BPF TOPIC] : Current status of ZNS SSD support in file systems
Date: Mon, 15 Jan 2024 11:22:36 +0300
Message-Id: <20240115082236.151315-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I would like to suggest the discussion related to current
status of ZNS SSD support in file systems. There is ongoing
process of ZNS SSD support in bcachefs, btrfs, ssdfs.
The primary intention is to have a meeting place among
file system developers and ZNS SSD manufactures for sharing
and discussing the status of ZNS SSD support, existing issues,
and potential new features.

The goals of the discussion are:
(1) share the current status of ZNS SSD support,
(2) discuss any potential issues of ZNS SSD support in file systems,
(3) discuss file system's techniques required for ZNS SSD support,
(4) discuss potential re-using/sharing of implemented logic/primitives,
(5) share the priliminary estimation of having stable ZNS SSD support,
(6) performance, reliability estimation comparing ZNS and conventional SSDs.

Also, it will be great to hear any news from ZNS SSD vendors
related to new features of ZNS SSDs (zone size, open/active zone
limitation, and so on). Do we have any progress with increasing
number of open/active zones? Any hope to have various zone sizes, etc?

POTENTIAL ATTENDEES:
bcachefs - Kent Overstreet
btrfs - Naohiro Aota
ssdfs - Viacheslav Dubeyko
WDC - Matias Bjørling
Samsung - Javier González

Anybody else would like to join the discussion?

Thanks,
Slava

