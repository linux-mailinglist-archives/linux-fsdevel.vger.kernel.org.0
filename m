Return-Path: <linux-fsdevel+bounces-70459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD36C9BF1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 16:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B65964E324F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 15:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4319226773C;
	Tue,  2 Dec 2025 15:29:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386FE257AD1
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689363; cv=none; b=Vlmb2DE52GKiHD6ptCESuyGqBBbuE5m38Pxuan2y0jXyyTVpNw6s+bnKUW2HweFhYri95WKKXgQirRf7Xi3s8EafMcSMapb0QW+wecG4i3/2owHsGOJSMSB7m8QAoTCbc+VJ96OFC1God35SJQvGrDUS4xrdcRrViV8xFYc9QHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689363; c=relaxed/simple;
	bh=2uFsDpqq/ViHlXDJHGHyC0YbbbBA4cCaUec80Nl1zC4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AR83GRbC76eYLGJLGc19IbyXRxDEI7DSTDYcgXWrfkDmHHlQdP9gVdaEmL7bW3THFJ99oLc22O2tXAp8orfs89uBn4VkXb53z3zFBtlt262l5tEUzc/8KdgNrkZbZB9mhUumarJYpp2MPJwHwhqr9okObkPG6LlvkmGuUmoIz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-657490df6f3so2282374eaf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 07:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764689361; x=1765294161;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZI0glXaDFhF3YfXt3h99EbqIxzmy1eUUZ0Jtger038=;
        b=Y1sLAaPUMUVqOd5Zjwh1n8voERpom7A77g0wvgwgCxqdmo0c2FEGMpudUZ8kDz04jt
         qu4Mdle9hasv+oGSGSjLN1LBRLvj3spnzW4CYYWuvto3OKm9HkXTxaeHEi9ArrIEnFt8
         umAIh8NM0pKcXBmXGZ1QCvI01GNkb7dTfAxqICnHLqV9sa0zvyg7GzFb+S8aE7XbSD8v
         h9hsZqn+DNe/iD00RM5g7iLvDYaxb5POyjUBhOES/ShoGu4BdZxvIzVtMQktzSGtYm5v
         CS7q1PjCqpEanGazFHOo9ecC7Zi3gQ8UYxL09p3Nhp2FA4UhgVyEVtxmlAh6Xq5I9bV8
         Lk6w==
X-Forwarded-Encrypted: i=1; AJvYcCU46fd3RCms1OEg1Zk4fx+LtHhw/uXXAxwc9JJTldJzHk5hN9aM8LHLxn0wf8bTV1Rlvjto+xhjuUOcJ8hL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0/n73Fo39g7y2MrUgUVnG8McfA2cZO7QvEFe/9lJk+EXjDR4V
	z7WYdSbjakuiH5DM1WyRjqr7AKWK2hAMq05assRrLpPCKz+wYyhzM+Tn33MoLLyr
X-Gm-Gg: ASbGncvmmKGgigMBmRS4xzQ9Gm2phIZ4y00+SdI7uDlnIrLmyv5iuCTcMvvStwR8rTw
	/Y1Ad0MOorCMfEWUBQNZtEISXxns6tFKsph24DmU90uFhrvFodOcg5zmIdtxp8+3WwsdSOOs/1h
	QqnBreGeHZUVCRHNrIYCDjz97Qs2mqGn8psNoYTEaw94Iu2btgz93oUMJvdLtNpnIcUbksEsE2R
	29YZKM8MCiRVmgStgLTdmfJfhASJadhUW4oMqkV1FGJH8t5VjW10o6eW+IdpvMM6zgO2Dp5sojP
	Lm3EOJYAaKiKB9oZc+e7aB4fZMk4dNrIcyhYLbp0TxPD5i8jZEfHykqneIFcKWwl4kn0W/+ma5I
	9sRFEG+9xGRLjYBp/93YzbRd42f/yWyCMZEDsEXwqijEisF/E2/b1NI1N4fPP2SOeI2kyoMht3M
	qB2J27tJamG6IBXmjvo/vG/fo=
X-Google-Smtp-Source: AGHT+IHXixNv/yN+x/Lx+X46K72SZQcXiBxyGUgFYi/XwH8Xby5TuuCM6SuGiGG4V7QchUrXtunl7g==
X-Received: by 2002:a05:6820:4c09:b0:657:61da:5089 with SMTP id 006d021491bc7-65790b6080fmr16132011eaf.7.1764689361229;
        Tue, 02 Dec 2025 07:29:21 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:9::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65933ced474sm4196314eaf.13.2025.12.02.07.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 07:29:20 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH RFC 0/2] configfs: enable kernel-space item registration
Date: Tue, 02 Dec 2025 07:29:00 -0800
Message-Id: <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALwFL2kC/x3MQQqDMBAF0KsMf22gSbSUbAs9QLciRcaJnc2kJ
 FIK4t0LvgO8HU2qSkOiHVW+2rQYEvmOwO/ZVnG6IBHCJQzeh5vjYlnX3F4mGxdzeYjCPc8xXiM
 6wqdK1t85jng+7piO4w/2NA0/ZgAAAA==
X-Change-ID: 20251128-configfs_netcon-f53ec4ca3363
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org, 
 hch@infradead.org, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, gustavold@gmail.com, asantostc@gmail.com, 
 calvin@wbinvd.org, kernel-team@meta.com
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3144; i=leitao@debian.org;
 h=from:subject:message-id; bh=2uFsDpqq/ViHlXDJHGHyC0YbbbBA4cCaUec80Nl1zC4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpLwXPBwLDYFRqGfALbzB4YsNM8kRJ26UiZeM9g
 GzfXqM9ZOyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaS8FzwAKCRA1o5Of/Hh3
 bZLMD/9uS5ZOI4Agzmiqw4QXONXb3cxWJhxwFsWcr5Nyg9e6zi1LS0Ktidxq5LBXvf7OvHya6/E
 VvjHwTVw3AcRJjH5HVIiAohZRDbabDi8/gJORFGLndrocK1g/h8CNrWB1MQxWjBaWkfbKMOTQId
 t2tN8u7DZHsef+AVpvlIgV+WGN/n8nKgc19CqWZ2WJ7EXwQfC80gC9NVVd2mkiHl9dC//YTvsHR
 4AIgITsWv793JfGhiXqbaTHP2+HqmxT9nvmpLNZF8jfF8UdHxe97kjeYz8RBNBN8o2j3KzihPb3
 UDA5KW7GHyfg3/HcDzjVzoZ628C1GXXDvEhd1QVo6QiTOPcEwVDd2hI0xCTPoFIjDamCWP0DLU2
 ES9w72+t5AGT3K+2z80QwkYr2c5l2tkJwd9UTJkPit6mG3wEBwnX5ohFBzCo0tT7NTse9i89WyR
 p4337I2NiF8eAHb1kFbq/gpcJuDeL47BDKOO/Oj92+K6gFSKN3XGQ88FRB20k65A7dyszxWvQvF
 fJfh1ZLn+o1Xg93+FqIgSf/dbzNWcOW0r00m9sUf9PYswZrO9JkvoqUvVAtAVRDG6Xo+5MsjXZd
 ghPFJtnmVr/3bJdQUooWDlXQrrfoTbf0vSZX5Q1hzYeO17AedboxQpLn58YtUMv29aVQ1xlgcKO
 Sdx3i0EnZrYGy8A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This series introduces a new kernel-space item registration API for configfs
to enable subsystems to programmatically create configfs items whose lifecycle
is controlled by the kernel rather than userspace.

Currently, configfs items can only be created via userspace mkdir operations,
which limits their utility for kernel-driven configuration scenarios such as
boot parameters or hardware auto-detection.

This discussion about this feature started 2 years ago[1], when netconsole needed to have
an configfs target that maps to what was passed by cmdline (something as
netconsole=+6666@192.168.1.1....)

The suggestion was to workaround configfs limitation by asking users to create
some pre-defined configfs entries specially named (such as "cmdlineX", where X
is the entry index in the list of targets), that would match entries coming from
cmdline.

That proved to be confusing in many ways, such as:

 1) if cmdline is not properly passed or parsed, then cmdline0 becomes a new
    and unrelated target
 2) If netconsole becomes a module, then cmdline0 is not populated, so, the
    creation of cmdline0 is something unrelated to what we have in cmdline.
 3) The admin needs to create X items properly matching the iterms from cmdline,
    which is error prone.

The solution proposed in this patchset is to manage the life cycle of an item by the
kernel (if the cmdline entry exists, it will populate the cofingfs
automatically), instead of by the user (mkdir-ing special names).

The new configfs_register_item() and configfs_unregister_item() functions fill
this gap by allowing kernel modules to register items that appear in configfs
but are protected from userspace removal. These items are marked with the
CONFIGFS_USET_DEFAULT flag, making them behave similarly to default groups that
are automatically created but cannot be removed via rmdir.

The primary motivation for this work is to support dynamic netconsole target
registration from boot parameters.

Currently, netconsole can be configured either statically at boot time
(cmdline) or dynamically via userspace manipulation of configfs directories.

However, there is no way to create netconsole targets from kernel command line
parameters that persist in configfs for runtime inspection and modification.

This series addresses that limitation by providing the necessary configfs
infrastructure, making netconsole management easier, and simplifying the
code.

Link: https://lore.kernel.org/all/ZRWRal5bW93px4km@gmail.com/ [1]

---
Breno Leitao (2):
      configfs: add kernel-space item registration API
      netconsole: Plug to dynamic configfs item

 drivers/net/netconsole.c |  63 +++++++++++++++-----------------------------
 fs/configfs/dir.c        | 134 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/configfs.h |   4 +++
 3 files changed, 159 insertions(+), 42 deletions(-)
---
base-commit: e538109ac71d801d26776af5f3c54f548296c29c
change-id: 20251128-configfs_netcon-f53ec4ca3363

Best regards,
--  
Breno Leitao <leitao@debian.org>


