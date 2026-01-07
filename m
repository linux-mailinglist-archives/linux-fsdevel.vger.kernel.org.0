Return-Path: <linux-fsdevel+bounces-72675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA66CFF303
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 18:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 098FA3008C52
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 17:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEADB33D4FC;
	Wed,  7 Jan 2026 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Begs3do/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199003590C2
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767806618; cv=none; b=OQ9xBlPRrfXhzix05S9mSVM6/lFEwYoSuwU09jnAQhxXQnVHrxJsMQ9ZW20xPUisvYKNsmJeO0gIs/QaC1AF3U9ULr6qwmAoUTDAwInmMTjwRgn8myRW6ZNM8hHXHFhI6OziUzhGx8trerPtY6KpVQCIbFjR8LLs9p1pfdbhYlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767806618; c=relaxed/simple;
	bh=Iv8QEQFRzeBfeVTlG+UF1DvDWR96yJ8hOeXcNbevDAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXJDEin24Sa/8ldhTSZatJmdrI6tBlFjvBk1sgS6pwxJ7LsDROvLosPTBFhV5e+2on5iDltSzLYRvi6YuCJO3q+SuXWt95hByNHciA/Zf+VyQsDZO+8/1+Gmc2F6kqpXtnsZrrEAHYd67iz+AR9A3tcrFMpoeN3CrDEfB2B+vBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Begs3do/; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2ae53df0be7so2528953eec.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 09:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767806611; x=1768411411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByDlzKUbACiwWH3Dgtn+v+MBoRieZFlgupkDEPd2zG0=;
        b=Begs3do/pw/TCPmPoASRRbEIOSb/r4nbcxpmwsa738u9N8wS9NXylkI2S80BQ/9vXL
         NPqmsE5J9OaDrm1EwugajFzylzXGzHW0WmJs/DoD0z5RRp45HmRwEbMygQW7g6ooz28v
         o44Ok+GpZz1jrHBbZfDnBh+O1dfW8dofHwTrKoV0UgrawLt9SUx/753MAYSESasSJLel
         QIz6K7gDeF9QUjCwxZx/Rxv2RK85ErTsOxpXTocf1/EwYFAMIgFHHoLOcPeGPqHQRu9L
         Q9GCXs2co+mbnP9AIZT5pBlDr53ejxyO2pMVKN1pZrgUjUjS+IkgdidujPyO+1Sxl63F
         IJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767806611; x=1768411411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ByDlzKUbACiwWH3Dgtn+v+MBoRieZFlgupkDEPd2zG0=;
        b=NdmjYJEo4Nf/7PgxYAvmCuvdNcnUsgXmLZcrIRYfvZS2DEVU0OevOOIdIaWhlTH8KT
         6q049xTIZsAu33bywau0/QSNqit+Cierx84eVLmndAO6m8MB1t44Ot0anjAkxS8CC66a
         9/pPhEId89O+96WEcWl8eXJ+dTKqBvErbBgz3V8Dnanyx8KZk1rmFqlPEOI96wBfDscP
         ifD5pXOinPykSyo3UIiDyxwxnMNmoiBtKSCjzporlYrn1ea+rXV39749+poZwkr4snz1
         flbzdDsvFepCjzJ2zXHjLc5f/FEZupmzUmzG9AGCkk/mFPWDm39TBnQQcYdN7RAwIGlD
         I+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCowg3VNpZXaZk1IynOEEoKd8h/yagsScvqZcq0IEJB106Ox7nCsGvvI+8KCEILeFDmJePkwo453WlHLc3@vger.kernel.org
X-Gm-Message-State: AOJu0YyTXJnpIUtt1rB3tYcK1qmEuUru9PTgDHicOK1Yaq7BZBzaafsx
	1k0mXVo4m+zMw5xnR3r0f/6CgGmLklLhJP0r6+xgZqulcpNCjAdSbh6EnoH4n4qd
X-Gm-Gg: AY/fxX6MaqNdAdO6W6feSw8BdyuM7y37xVgPknqN7kMlLBu/wpBvs69Z3VJlTXI/Bt/
	XwEUSghMNWzdTNQm9Sbq5ifr8s8kJT8TfKof4Z06A6e+q16vd2shW5SIOK2yq2VsGAYL5k6n/KJ
	XJ6Sh6pUXf+0fu6EP3WcyayDdCjl+P7XTKIbFZ+iN9FIeQd9pGv2DUTmnSdxmk0Ym6QObyBzboV
	/gw21olpXSf9VhFNWlrmXcEEdMNnFIgfFHqY5CvKKHIvdEkj+9g1Pr0nVz41SJ3Ndv5IdA1K8MR
	ezpAMPvGD05IfR5VTBe/dUhnr8SBaUgXvAUcVwIRz4tw9YUEBylGxpDYm17mLWovItbsphivpsh
	Sof8/VqaD/0fKlFVSZvx1qKo+NlZAQgXKjXr7DvftVsYudDXNdVXmNvGXUvUANhZ8TJX+m4e3/p
	IrmwhOaViOBlyHxE/ZcZbkMykTFW3FcTtD+rwrRqk2skwZ
X-Google-Smtp-Source: AGHT+IHH6c3F0YfxvIazIzqmrv5Gfwpzb8ium784lL1LqhHDGR+rc1ftda1nHLwiQjItEG5YQPZNcQ==
X-Received: by 2002:a05:6808:6d91:b0:453:50af:c463 with SMTP id 5614622812f47-45a6bebb603mr920549b6e.41.1767800083021;
        Wed, 07 Jan 2026 07:34:43 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2f1de5sm2398106b6e.22.2026.01.07.07.34.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:42 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH V3 21/21] famfs_fuse: Add documentation
Date: Wed,  7 Jan 2026 09:33:30 -0600
Message-ID: <20260107153332.64727-22-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153332.64727-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Documentation/filesystems/famfs.rst and update MAINTAINERS

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: John Groves <john@groves.net>
---
 Documentation/filesystems/famfs.rst | 142 ++++++++++++++++++++++++++++
 Documentation/filesystems/index.rst |   1 +
 MAINTAINERS                         |   1 +
 3 files changed, 144 insertions(+)
 create mode 100644 Documentation/filesystems/famfs.rst

diff --git a/Documentation/filesystems/famfs.rst b/Documentation/filesystems/famfs.rst
new file mode 100644
index 000000000000..0d3c9ba9b7a8
--- /dev/null
+++ b/Documentation/filesystems/famfs.rst
@@ -0,0 +1,142 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _famfs_index:
+
+==================================================================
+famfs: The fabric-attached memory file system
+==================================================================
+
+- Copyright (C) 2024-2025 Micron Technology, Inc.
+
+Introduction
+============
+Compute Express Link (CXL) provides a mechanism for disaggregated or
+fabric-attached memory (FAM). This creates opportunities for data sharing;
+clustered apps that would otherwise have to shard or replicate data can
+share one copy in disaggregated memory.
+
+Famfs, which is not CXL-specific in any way, provides a mechanism for
+multiple hosts to concurrently access data in shared memory, by giving it
+a file system interface. With famfs, any app that understands files can
+access data sets in shared memory. Although famfs supports read and write,
+the real point is to support mmap, which provides direct (dax) access to
+the memory - either writable or read-only.
+
+Shared memory can pose complex coherency and synchronization issues, but
+there are also simple cases. Two simple and eminently useful patterns that
+occur frequently in data analytics and AI are:
+
+* Serial Sharing - Only one host or process at a time has access to a file
+* Read-only Sharing - Multiple hosts or processes share read-only access
+  to a file
+
+The famfs fuse file system is part of the famfs framework; user space
+components [1] handle metadata allocation and distribution, and provide a
+low-level fuse server to expose files that map directly to [presumably
+shared] memory.
+
+The famfs framework manages coherency of its own metadata and structures,
+but does not attempt to manage coherency for applications.
+
+Famfs also provides data isolation between files. That is, even though
+the host has access to an entire memory "device" (as a devdax device), apps
+cannot write to memory for which the file is read-only, and mapping one
+file provides isolation from the memory of all other files. This is pretty
+basic, but some experimental shared memory usage patterns provide no such
+isolation.
+
+Principles of Operation
+=======================
+
+Famfs is a file system with one or more devdax devices as a first-class
+backing device(s). Metadata maintenance and query operations happen
+entirely in user space.
+
+The famfs low-level fuse server daemon provides file maps (fmaps) and
+devdax device info to the fuse/famfs kernel component so that
+read/write/mapping faults can be handled without up-calls for all active
+files.
+
+The famfs user space is responsible for maintaining and distributing
+consistent metadata. This is currently handled via an append-only
+metadata log within the memory, but this is orthogonal to the fuse/famfs
+kernel code.
+
+Once instantiated, "the same file" on each host points to the same shared
+memory, but in-memory metadata (inodes, etc.) is ephemeral on each host
+that has a famfs instance mounted. Use cases are free to allow or not
+allow mutations to data on a file-by-file basis.
+
+When an app accesses a data object in a famfs file, there is no page cache
+involvement. The CPU cache is loaded directly from the shared memory. In
+some use cases, this is an enormous reduction read amplification compared
+to loading an entire page into the page cache.
+
+
+Famfs is Not a Conventional File System
+---------------------------------------
+
+Famfs files can be accessed by conventional means, but there are
+limitations. The kernel component of fuse/famfs is not involved in the
+allocation of backing memory for files at all; the famfs user space
+creates files and responds as a low-level fuse server with fmaps and
+devdax device info upon request.
+
+Famfs differs in some important ways from conventional file systems:
+
+* Files must be pre-allocated by the famfs framework; allocation is never
+  performed on (or after) write.
+* Any operation that changes a file's size is considered to put the file
+  in an invalid state, disabling access to the data. It may be possible to
+  revisit this in the future. (Typically the famfs user space can restore
+  files to a valid state by replaying the famfs metadata log.)
+
+Famfs exists to apply the existing file system abstractions to shared
+memory so applications and workflows can more easily adapt to an
+environment with disaggregated shared memory.
+
+Memory Error Handling
+=====================
+
+Possible memory errors include timeouts, poison and unexpected
+reconfiguration of an underlying dax device. In all of these cases, famfs
+receives a call from the devdax layer via its iomap_ops->notify_failure()
+function. If any memory errors have been detected, access to the affected
+daxdev is disabled to avoid further errors or corruption.
+
+In all known cases, famfs can be unmounted cleanly. In most cases errors
+can be cleared by re-initializing the memory - at which point a new famfs
+file system can be created.
+
+Key Requirements
+================
+
+The primary requirements for famfs are:
+
+1. Must support a file system abstraction backed by sharable devdax memory
+2. Files must efficiently handle VMA faults
+3. Must support metadata distribution in a sharable way
+4. Must handle clients with a stale copy of metadata
+
+The famfs kernel component takes care of 1-2 above by caching each file's
+mapping metadata in the kernel.
+
+Requirements 3 and 4 are handled by the user space components, and are
+largely orthogonal to the functionality of the famfs kernel module.
+
+Requirements 3 and 4 cannot be met by conventional fs-dax file systems
+(e.g. xfs) because they use write-back metadata; it is not valid to mount
+such a file system on two hosts from the same in-memory image.
+
+
+Famfs Usage
+===========
+
+Famfs usage is documented at [1].
+
+
+References
+==========
+
+- [1] Famfs user space repository and documentation
+      https://github.com/cxl-micron-reskit/famfs
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index f4873197587d..e6fb467c1680 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -89,6 +89,7 @@ Documentation for filesystem implementations.
    ext3
    ext4/index
    f2fs
+   famfs
    gfs2/index
    hfs
    hfsplus
diff --git a/MAINTAINERS b/MAINTAINERS
index 16b0606a3b85..b74ac9395264 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10380,6 +10380,7 @@ M:	John Groves <John@Groves.net>
 L:	linux-cxl@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported
+F:	Documentation/filesystems/famfs.rst
 F:	fs/fuse/famfs.c
 F:	fs/fuse/famfs_kfmap.h
 
-- 
2.49.0


