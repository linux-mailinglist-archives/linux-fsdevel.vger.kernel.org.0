Return-Path: <linux-fsdevel+bounces-8141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FCD830112
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 09:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4277AB23912
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 08:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098D1D310;
	Wed, 17 Jan 2024 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Qdo3YOpE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36CD26B
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705479137; cv=none; b=jcd7FLKKEXguW8+qb+p5y2Cz6t1zbEHTu2vgiQ0tDVaT/FANrbcjJewj4C0dw6gRMCnzU6/XehHJ9R3o9tfB70+AcvEqfBzyGnHFZdpV5zcUYSlv7+q8ijPgER1LqyfaS5nyxD8azhEwSi/iNbcoTpGqEkLmheK5OEFDQQQaEhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705479137; c=relaxed/simple;
	bh=+zYWbcvoAjP23imjGJNfMVtHCU1pJ09psuvoDn4c5VM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=P0s1d7dGKobb2d8kcqRXkT+JzT+o+h5wRCb0tFOGl733ePfXbvXr20g2w5HXcrg8ENmUxq0Ru29Cy4uXWfVG85R5dyYVrH5UjVC6rem8UulKX8+7Agp0mYdzvWFYKIweeQm0k8Au572gsf9kJEHCqAm6miAXlJKsHZ78yLUCj4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Qdo3YOpE; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cca5d81826so139938691fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 00:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1705479133; x=1706083933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CL0/51SFyxSBXvd08BvIvd2GhG6gC9HlQXY+Oj5Agt8=;
        b=Qdo3YOpEc7f9dm/H5FjiovYHb7u2/ztIlBYq+bHf+wRL5rkbTlfwNJ7k4UwPdohUXl
         BZUcOrC8PLvlcSgTfotcMGZpYCAUJriI5/eV2+lQl15r0g9SYm3MmlpTZoVsTnNsjEfw
         xmiCwCHDyXT4ZgaR96euqomny7tSTsPHZgYyMb2fYiCu2EPJVmJU2b7zOrGbhlfnSRec
         vCY/2//Pp39Iz0HwRCkY1++Mji/ylmGiT82VmIr6rL0P/9MIOGRyQquLFHBqQYNkKgWD
         Yuzztp4ad6ZVSz4PnLJrigB/Wkm4xsRWuWTBMOcHkWuRH/zZmY+nhXRYJIGJseGUY4UF
         kLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705479133; x=1706083933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CL0/51SFyxSBXvd08BvIvd2GhG6gC9HlQXY+Oj5Agt8=;
        b=Rh6OEMOdiOz1FHbtyoSVVs5ayr13cetmDiKWirHZ5ZwJI2okr7Ak+EKa81+Id/6k1Y
         VDsPCJHD7WqQtXTFc1yVioSYYExtGoSfjzI8r8O0+wefSoj4BCSP561l63hoD2nPxWAU
         Yt1+3td+pNG8ntxq+kC1Qk9FUwy87qIzaU2x7YAsSTQ3zxiwsf2TszF+1tmT4nqL/Gi/
         z9aFG6MgGy/if+ZM70/0Cc4NCJGyT8cK11wZl9CUeCdFY2Jj1bmSntfXaqgpWPzVIo7P
         cgu74yQ4+Prnwg8HSUDfC6AzOzrXKy9tssfZBvMQ2UJFDA8wvAXvI65VRjhrOhpVtTrC
         Km3w==
X-Gm-Message-State: AOJu0Yy1LSxufzwomIa2WNs00Ic/u7x5M5pvAjK0Q7fbShcQdiathKdJ
	tXafUxt1KXwBc/8W3vN1EOGVVOU25CxUq+nuYrZGLRobbSoriQ==
X-Google-Smtp-Source: AGHT+IGazDA1QaoGQDTGbuiVsSrXQlqefiKKn7cFUVXGcYQpcoY88lXP0Rkg357V03PgppCg09loHw==
X-Received: by 2002:a2e:8514:0:b0:2cd:4a84:2b2f with SMTP id j20-20020a2e8514000000b002cd4a842b2fmr4489196lji.57.1705479132699;
        Wed, 17 Jan 2024 00:12:12 -0800 (PST)
Received: from system76-pc.. ([2a00:1370:81a4:169c:37e:4ad0:ef51:2844])
        by smtp.gmail.com with ESMTPSA id f4-20020a2ea0c4000000b002cd9005979dsm1757937ljm.102.2024.01.17.00.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 00:12:12 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org
Cc: Matias.Bjorling@wdc.com,
	javier.gonz@samsung.com,
	luka.perkov@sartura.hr,
	bruno.banelli@sartura.hr,
	slava@dubeiko.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [LSF/MM/BPF TOPIC] : SSDFS - flexible architecture for FDP, ZNS SSD, and SMR HDD
Date: Wed, 17 Jan 2024 11:11:43 +0300
Message-Id: <20240117081143.305317-1-slava@dubeyko.com>
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

I would like to share the current status of SSDFS stabilization and
new features implementation. Also I would like to discuss how
kernel-space file systems can adopt FDP (Flexible Data Placement)
technology on the example of SSDFS architecture.

[DISCUSSION]

SSDFS is based on segment concept and it has multiple types of segments
(superblock, mapping table, segment bitmap, b-tree nodes, user data).
The first point of FDP employment is to use hints to place different segment
types into different reclaim units. It means that different type of
data/metadata (with different “hotness”) can be placed into different
reclaim units. And it provides more efficient NAND flash management
on SSD side.

Another important point of FDP, that it can guarantee the decreasing
write amplification and predictable reclaiming on SSD side.
SSDFS provides the way to define the size of erase block.
If it’s ZNS SSD, then mkfs tool uses the size of zone that storage device
exposes to mkfs tool. However, for the case of conventional SSD, the size of
erase block is defined by user. Technically speaking, this size
could be smaller or bigger that the real erase block inside of SSD.
Also, FTL could use a tricky mapping scheme that could combine LBAs in
the way making FS activity inefficient even by using erase block or
segment concept. First of all, reclaim unit makes guarantee that erase
blocks or segments on file system side will match to erase blocks
(reclaim units) on SSD side. Also, end-user can use various sizes of
logical erase blocks but the logical erase blocks of the same segment
type will be placed into the same reclaim unit. FDP can guarantee that
LBAs of the same logical erase block will go into the same reclaim
unit but not to be distributed among various physical erase blocks.
Important difference with ZNS SSD that end-user can define the size
of logical erase block in flexible manner. The flexibility to use
the various logical erase block sizes provides the better efficiency of
file system because various workloads could require different logical
erase block sizes.

Another interesting feature of FDP is reclaim group that can combine
multiple reclaim units. SSDFS uses segment that could contain several
logical erase blocks. Technically speaking, different logical erase
blocks of the same segment can be located in different reclaim groups.
It sounds like different NAND dies can process requests for different
logical erase blocks in parallel. So, potentially, it can work as
perfomance improvement feature.

Technically speaking, any file system can place different types of
metadata in different reclaim units. However, user data is slightly
more tricky case. Potentially, file system logic can track “hotness” or
frequency of updates of some user data and try to direct the different
types of user data in different reclaim units. But, from another point of view,
we have folders in file system namespace. If application can place different
types of data in different folders, then, technically speaking,
file system logic can place the content of different folders into different
reclaim units. But application needs to follow some “discipline”
to store different types of user data (different “hotness”, for example)
in different folders. SSDFS can easily to have several types of user
data segments (cold, warm, hot data, for example). The main problem is
how to define the type of data during the write operation.

However, SSDFS is log-structured file system and every log could contain
up to three area types in the log's payload (main area, journal area, diff
area). The main area can keep initial state of logical blocks (cold data).
Any updates for initial state of logical blocks in main area can be stored
as deltas or diffs into the diff area (hot data). The journal area is the
space for compaction scheme that combines multiple small files or
compressed logical blocks into one LBA ("NAND flash page"). As a result,
journal area can be considered like warm data. Finally, all these areas
can be stored in contiguous LBAs sequences inside of log's payload
and for every area type is possible to provide the hint of placing
the LBA range in particular reclaim unit. So, as far as I can see,
this Diff-On-Write approach can provide better NAND flash management
scheme even for user data.

So, I would like to discuss:
(1) How kernel-space file systems can adopt FDP technology?
(2) How FDP technology can improve efficiency and reliability of
kernel-space file system?

[CURRENT STATUS]

(1) Issue with read-intensive nature has been fixed:
    - compression of offset translation table has beed added
    - offset translation table is stored in every log
(2) SSDFS was completely reworked for using memory folio
(3) 8K/16K/32K support is much more stable
    (but still with some issues)
(4) Multiple erase blocks in segment support is more stable
    (but still with some issues)
(5) Erase block inflation model has been implemented
    (patch is under testing)
(6) Erase block based deduplication has been introduced
(7) recoverfs tool has been implemented
    (not all features implemented yet)

[CURRENT ISSUES]

(1) ZNS support is still not fully stable;
(2) b-tree operations have issues for some use-cases;
(5) Delta-encoding support is not stable;
(6) The fsck tool are not implemented yet;

[PATCHSET]

Current state of patchset for the review:
https://github.com/dubeyko/ssdfs-driver/tree/master/patchset/linux-kernel-6.7.0

SSDFS is an open-source, kernel-space LFS file system designed:
(1) eliminate GC overhead, (2) prolong SSD lifetime, (3) natively support
a strict append-only mode (ZNS SSD + SMR HDD compatible), (4) guarantee
strong reliability, (5) guarantee stable performance.

Benchmarking results show that SSDFS is capable:
(1) generate smaller amount of write I/O requests compared with:
    1.4x - 116x (ext4),
    14x - 42x (xfs),
    6.2x - 9.8x (btrfs),
    1.5x - 41x (f2fs),
    0.6x - 22x (nilfs2);
(2) decrease the write amplification factor compared with:
    1.3x - 116x (ext4),
    14x - 42x (xfs),
    6x - 9x (btrfs),
    1.5x - 50x (f2fs),
    1.2x - 20x (nilfs2);
(3) prolong SSD lifetime compared with:
    1.4x - 7.8x (ext4),
    15x - 60x (xfs),
    6x - 12x (btrfs),
    1.5x - 7x (f2fs),
    1x - 4.6x (nilfs2).

[REFERENCES]
[1] SSDFS tools: https://github.com/dubeyko/ssdfs-tools.git
[2] SSDFS driver: https://github.com/dubeyko/ssdfs-driver.git
[3] Linux kernel with SSDFS support: https://github.com/dubeyko/linux.git
[4] SSDFS (paper): https://arxiv.org/abs/1907.11825
[5] Linux Plumbers 2022: https://www.youtube.com/watch?v=sBGddJBHsIo

