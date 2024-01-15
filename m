Return-Path: <linux-fsdevel+bounces-7926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C8C82D548
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 09:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5616CB21141
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 08:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EA9C123;
	Mon, 15 Jan 2024 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="mrJr1WKx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352DE882F
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50eaabc36bcso10333918e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 00:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1705308412; x=1705913212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=af0c4qw0ceHWmNUQwBLGyaQWzbBLs0yH9j68AMi/ymM=;
        b=mrJr1WKxJ7BRhwXIMQlAIDZhNNwh6HPwY8oGKhaTMNgYoZQM8k3E6VV3EYGkWy9wsh
         bg7vzl0vQ5NrFT34yRUsWKs1bSgktjeShsLP4sn7/SWXSuQ8EtYD5HkDQLgQzYSl3fCd
         wUnCH4TU80jTvjKkUDDB+QbXafgneqkyNM9jCWvyG9pRjbY6utZivtaou320oYL99nzt
         jOIRK8VKBvqVQQUd2NcMna7i4NtBYaX9/GbChAn4NvAw1SckAaQNLwch22Hg2pB1JTYc
         7Jxyjw17LugKrNVoO7e4u8yQTOSolQChKBXLP+Yxih04UgfVLjllbITJOpikAODpx1Q0
         nUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705308412; x=1705913212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=af0c4qw0ceHWmNUQwBLGyaQWzbBLs0yH9j68AMi/ymM=;
        b=lMWcoyG+FicbrFfl8/ApFiXRvtQgVnnhyzqr1r+UnW/Wu5O7zXGdQl6Uqt85VtsjLh
         G8gvNGoFjkbrvEvf4WanY+riF9braCJU6bn+z79a+OdNM8/XhrpL4PNVBju7h5/oPd0t
         16253upvlkIcYiKwfY2LsgtGmLym+aYLHXT2WZfIJDXlQBtuOGQI/rqwLz54DRlSRNzm
         34MQ+3GwXHAXntnAOtMgAlmEeMEzJF36RkH52ieCBPE2urI6eyi2FscQtMpTfqHR+5M1
         ir7w8anmZNgwO+19SAHMWJ97BK89CgpdOO/jExaqCemgSQFspKHTkK3uywxJx+Y2yT4/
         Dy1A==
X-Gm-Message-State: AOJu0YxmDB6UrhTGJFQxJOdEzKzY6hzYHgniENF2qdszht6GNXIDJmSQ
	FujI3Vn1j9XedY71C75nA5UKo7HP6Opj3w==
X-Google-Smtp-Source: AGHT+IGK8MH+CazDutDh5KhUA91iPm2QS3HgOT+gj3DZbv72Ccmc46G2CeN6HPpan13U+rWLqo9+kg==
X-Received: by 2002:a05:6512:234e:b0:50e:6457:2bc2 with SMTP id p14-20020a056512234e00b0050e64572bc2mr3307332lfu.71.1705308411949;
        Mon, 15 Jan 2024 00:46:51 -0800 (PST)
Received: from system76-pc.. ([2a00:1370:81a4:169c:b283:d681:9baf:afcf])
        by smtp.gmail.com with ESMTPSA id y22-20020a056512335600b0050eea9541casm970160lfd.44.2024.01.15.00.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 00:46:51 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	javier.gonz@samsung.com
Cc: a.manzanares@samsung.com,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	slava@dubeiko.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [LSF/MM/BPF TOPIC] : Flexible Data Placement (FDP) availability for kernel space file systems
Date: Mon, 15 Jan 2024 11:46:31 +0300
Message-Id: <20240115084631.152835-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Javier,

Samsung introduced Flexible Data Placement (FDP) technology
pretty recently. As far as I know, currently, this technology
is available for user-space solutions only. I assume it will be
good to have discussion how kernel-space file systems could
work with SSDs that support FDP technology by employing
FDP benefits.

How soon FDP API will be available for kernel-space file systems?
How kernel-space file systems can adopt FDP technology?
How FDP technology can improve efficiency and reliability of
kernel-space file system?
Which new challenges FDP technology introduces for kernel-space
file systems?

Could we have such discussion leading from Samsung side?

Thanks,
Slava

