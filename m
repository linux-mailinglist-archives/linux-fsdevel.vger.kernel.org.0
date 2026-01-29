Return-Path: <linux-fsdevel+bounces-75895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJM5LfnLe2lHIgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:07:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 568F7B47D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87CD8305BFC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 21:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4F735C193;
	Thu, 29 Jan 2026 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VKTj1/Ct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A40035C19C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720692; cv=none; b=VhA/7fAvya/h1WvDNGm+8y/esHfDaGNe1YMtqMKauWVmGvVyF7lO/DGuR7WagOylgiG6T0wCBaRklP4LwmatUxjifzYQU6pN87Zc5me8wTvOcbYY+hoCCo36I3YlcGogqE7wG1wJSQC7W2Sa3fbD+jlSzgLEoeUDB0KTcq59mOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720692; c=relaxed/simple;
	bh=akrBn4JPwvLBEstJQ9HeJN9q5u1vwp5xfi2e9tVFX44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mk58wa1Dy/6YS2b5EWDqjkCKhuQfSEgdSfndkUeXYWe4qUBOZu3YRcJk+hoT5tp8ZGVsW/dqWtkS12ZXypwvYLh0VZRVJoT1ikwO3wWZB4VelcwmZ6VeuD8HNmiGTdc1LRGm7KXAioEQXwYUihHGzEPScs+5tI9hVevvYXbjazw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VKTj1/Ct; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c70ab3b5fcso185871285a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 13:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769720688; x=1770325488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p7dwhjhUx8amshGTbVFKhqWt51EOp/YvCZDul2or7c8=;
        b=VKTj1/CtthKjNpOH14Qy/AaDCYqFfxyeMsekxnh5rv/USxlWS1YmyR4tjvh3AgVh79
         5bm9Ug8rSMbn1VpSDe66i939pqWE5T8Eeyjv4xye+AfRlq67BCP7onpfV7YzWrzr+S+H
         w8OAFmEgyr0QgA/4IWRELcaKjn9k3Ceui0Zk88sOL73DA6nKp8k9+EbIHvn+713narDF
         3J0dm+a/KXchagXdnES2uYVuNIKX9EstUMnaZk9DcgyjqaVHN+TBpumR1+YxGdbV5wuD
         YAm9calgriXtTNFrKQlghJR3Upds3CKQLjwNYW+kt3vITS2Jf/HSP5oldfUSgAUVSaCt
         hCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769720688; x=1770325488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7dwhjhUx8amshGTbVFKhqWt51EOp/YvCZDul2or7c8=;
        b=U7ag4dtUBgTZ0MJbUOEeJb432bJpuKwsD+5cCgBATH76urCGfYnSR2DuzpvS1Gn7Rq
         OXHGpdEJZkVpbJaK4vQgAoHwqdgDVEkKRHI5N+ZYUIPPjLDeDs8shqJ6QYAIhfLbZXnz
         3AOtxwz007VGEXSadINWbPfAoVXTJHkULZA7XQrD6QF5bPmlF6ibXCoOdUKTVYsiQGYe
         n8I9WhVw14+vlvdq3UBO8rARhfMk3g3gicdYSS7N4a5HfT+0ybhUUYAq0LXlTIvFzw2j
         8aMUaC8X1SpVk7b2v8xrJHSFBczVgT6V4s6qt2wAHW1KfDD5cAYSqqrfK5I34Jdq7wAk
         dIZA==
X-Forwarded-Encrypted: i=1; AJvYcCVIo/nAihNVBWgHk92tlupnKtyDlUGh8pcolmrHZcqwKmxk2SG+/UUWk3OeAn+K6p8XFZ+gO2FKGnz0z2VK@vger.kernel.org
X-Gm-Message-State: AOJu0YyeR0XsZS5sWDeqVNS0LFnONXQZL7GOO+xriYjkWqfZ1Gqio8d3
	nWdZtT8cxVrp/2+CVl+sq/3w1xhYu3fTav9ABehpnABWdFzZZHtIbD/sT5WdpY4y0TE=
X-Gm-Gg: AZuq6aJH5lTdSzWOjwYXOKCnk8r/SZfWZ6m6wr0ebUkmPvE+dG0wTJ3l2L3ECJ4qSRi
	wcGCHw9yIhCcCNibIjFSgmyUlsSe30As5H7fgzbRCzv0x/OZVv8Y8zF12tVAVLspihl6Dxi2bTB
	cZ8Zeahna4oAgr0KWU82pCfe989JyXugtFazhn/MrtOJfuLCDwDpLFTUbcFQYYpU3GwMjkkHXZO
	gwT+5gCs+r8IFAtIm7TfUAAjg52lpUBneMv9s8xvr5PGuSRLGWqC3Cq08ceCRmlmMolBfM892zc
	PcueXGKLDncwnpE1kWQK8XoyNnQI7kNIxJ1D7Ggr1QjUV+yKH11xtUKiWI3UzEXIfmVTWIKCxV4
	H4rO/3Is0PuH0a4SMVBnkT8w9ntE+UD5HKk9ucLGzISmTlsvoiXiWDvS2kwux21KTmjNV+Rnm6v
	LcOYlCt55aqFIEXnMLeQ/mMhki1/Fh3YkDQ2fUkM84+kdtyO6FU+k9fQdKjBfqdhLzyoJk9h3bA
	eqvYj3S7kAlYQ==
X-Received: by 2002:a05:620a:4801:b0:8c5:2d4c:4f0e with SMTP id af79cd13be357-8c9eb26aabbmr143736485a.25.1769720688060;
        Thu, 29 Jan 2026 13:04:48 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c71b859eaesm282041685a.46.2026.01.29.13.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:04:47 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	willy@infradead.org,
	jack@suse.cz,
	terry.bowman@amd.com,
	john@jagalactic.com
Subject: [PATCH 0/9] cxl: explicit DAX driver selection and hotplug
Date: Thu, 29 Jan 2026 16:04:33 -0500
Message-ID: <20260129210442.3951412-1-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	TAGGED_FROM(0.00)[bounces-75895-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gourry.net:mid,gourry.net:dkim]
X-Rspamd-Queue-Id: 568F7B47D5
X-Rspamd-Action: no action

Currently, CXL regions that create DAX devices have no mechanism to
control select the hotplug online policy for kmem regions at region
creation time. Users must either rely on a build-time default or
manually configure each memory block after hotplug occurs.

Additionally, there is no explicit way to choose between device_dax
and dax_kmem modes at region creation time - regions default to kmem.

This series addresses both issues by:

1. Plumbing an online_type parameter through the memory hotplug path,
   from mm/memory_hotplug through the DAX layer, enabling drivers to
   specify the desired policy (offline, online, online_movable).

2. Adding infrastructure for explicit dax driver selection (kmem vs
   device) when creating CXL DAX regions.

3. Introducing new CXL region drivers that provide a two-stage binding
   process with user-configurable policy between region creation and
   memory hotplug.

The new drivers are:
- cxl_devdax_region: Creates dax_regions that bind to device_dax driver
- cxl_sysram_region: Creates sysram_region devices with hotplug policy
- cxl_dax_kmem_region: Probes sysram_regions to create kmem dax_regions

The sysram_region device exposes an 'online_type' sysfs attribute
allowing users to configure the memory online type before hotplug:

    echo region0 > cxl_sysram_region/bind
    echo online_movable > sysram_region0/online_type
    echo sysram_region0 > cxl_dax_kmem_region/bind

This enables explicit control over both the dax driver mode and the
memory hotplug policy for CXL memory regions.

In the future, with DCD regions, this will also provide a policy step
which dictates how extents will be surfaces and managed (e.g. if the
dc region is bound to the sysram driver, it will surface as system
memory, while the devdax driver will surface extents as new devdax).

Gregory Price (9):
  mm/memory_hotplug: pass online_type to online_memory_block() via arg
  mm/memory_hotplug: add __add_memory_driver_managed() with online_type
    arg
  dax: plumb online_type from dax_kmem creators to hotplug
  drivers/cxl,dax: add dax driver mode selection for dax regions
  cxl/core/region: move pmem region driver logic into pmem_region
  cxl/core/region: move dax region device logic into dax_region.c
  cxl/core: add cxl_devdax_region driver for explicit userland region
    binding
  cxl/core: Add dax_kmem_region and sysram_region drivers
  Documentation/driver-api/cxl: add dax and sysram driver documentation

 Documentation/ABI/testing/sysfs-bus-cxl       |  21 ++
 .../driver-api/cxl/linux/cxl-driver.rst       |  43 +++
 .../driver-api/cxl/linux/dax-driver.rst       |  29 ++
 drivers/cxl/core/Makefile                     |   3 +
 drivers/cxl/core/core.h                       |  11 +
 drivers/cxl/core/dax_region.c                 | 179 ++++++++++
 drivers/cxl/core/pmem_region.c                | 191 +++++++++++
 drivers/cxl/core/port.c                       |   2 +
 drivers/cxl/core/region.c                     | 321 ++----------------
 drivers/cxl/core/sysram_region.c              | 180 ++++++++++
 drivers/cxl/cxl.h                             |  29 ++
 drivers/dax/bus.c                             |   3 +
 drivers/dax/bus.h                             |   7 +-
 drivers/dax/cxl.c                             |   7 +-
 drivers/dax/dax-private.h                     |   2 +
 drivers/dax/hmem/hmem.c                       |   2 +
 drivers/dax/kmem.c                            |  13 +-
 drivers/dax/pmem.c                            |   2 +
 include/linux/dax.h                           |   5 +
 include/linux/memory_hotplug.h                |   3 +
 mm/memory_hotplug.c                           |  95 ++++--
 21 files changed, 826 insertions(+), 322 deletions(-)
 create mode 100644 drivers/cxl/core/dax_region.c
 create mode 100644 drivers/cxl/core/pmem_region.c
 create mode 100644 drivers/cxl/core/sysram_region.c

-- 
2.52.0


