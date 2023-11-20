Return-Path: <linux-fsdevel+bounces-3256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACC17F1D0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 20:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58BF2819C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 19:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91213454A;
	Mon, 20 Nov 2023 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL/PTBTU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C81D9;
	Mon, 20 Nov 2023 11:05:29 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso4522203b3a.2;
        Mon, 20 Nov 2023 11:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700507128; x=1701111928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vwNNy/z5Hd4Xf3EX/0BYR2ko6plMSB8B+z2NZobueCk=;
        b=OL/PTBTUkGLXxE4z8/WFH4m1PMMPTxLDw3WI9IYoFoagFhJxaw5GlcSantgq/f9ukO
         DHos1uo28KS3FaowjSoqdS1mXUPNzWNG8SF3F52c0RZB1SYjZUSgiCOovG+5FfcgeJPC
         PAJjfz9zMq8vYhjFEFBwkOJr2EK2t8oiajrWWVZTG3UyGfnBxiyfXXkyj+QcMNB1BPBU
         m8bXm83fDrEDNy85SWgnZ1x4ac5quG08goMGkaSRVM5ewGsgdBf6bbxEktxTFMm1A3kk
         IicRG2bQ0egUKeylg6Sr9NU15gWkLq9gIVaKw23GvbQyicY4WKEFBkJnzvBeXn8mRTOs
         UWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700507128; x=1701111928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vwNNy/z5Hd4Xf3EX/0BYR2ko6plMSB8B+z2NZobueCk=;
        b=FXi5yGUKOLJMj/6Oftf9wy8iyYH1/QwMO9lswqnHEZXm+t1jlq4rosln9c+Y5Mv/r0
         xDaMqcb1f+PKyb+whdmhPvFaPP8YgWGQxmTTo6ZCnLaxzOvuhJP7PZJ+Lh1m+PL/CHqv
         J4cSiwXsaL0lvOxq3muzw6aS4N79H5rKXVReUBKtdj2KidtnuMFFhVAu+ILtDFfoSA1T
         x4oqVeutmHUvEZKrx3GwywA0GFZqr4y8TPhRmXPlgMG4qfdhRcnPjxNpgbjqfM6Ki6VW
         S1NaqVgBNtPL5Mc8+wXNPZpn5AlOLiSYcRFW7guRHYUdv06cbPxI8DycgoGqriuvxPpf
         tGzA==
X-Gm-Message-State: AOJu0YwgXQzPsxNvkw7J3wYgQSLvrqG+8A64v9Fs+hdHPHjJZjrywArr
	B4wz4crQN8YUTeS2xV0yZ5yCG3DcbJU=
X-Google-Smtp-Source: AGHT+IEQsLqpWFNVgLUDP1i5JO7U3TcFiOnILEMTubAiPwrE5qPHdN0PEIlvWwBlBLZ6tqbLzCJnFg==
X-Received: by 2002:a05:6a21:328a:b0:187:1c5c:49e4 with SMTP id yt10-20020a056a21328a00b001871c5c49e4mr11683032pzb.46.1700507128220;
        Mon, 20 Nov 2023 11:05:28 -0800 (PST)
Received: from dw-tp.localdomain ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id y10-20020a62f24a000000b006c69851c7c9sm6353699pfl.181.2023.11.20.11.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 11:05:27 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 0/3] ext2: Use iomap in buffered-io for regular files and enable large folio support
Date: Tue, 21 Nov 2023 00:35:18 +0530
Message-ID: <cover.1700505907.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, 

Please find this RFC series which converts ext2 regular file's buffered-io
path to iomap. The idea behind doing this work is to identify work required
to move ext* filesystems to iomap. 

Patch-1 is a fix which was identified while working on this series. 
It causes inode->i_size inconsistency, which also fails generic/091.

Patch-2 is a RFC patch which converts ext2 regular file's buffered-io path
to use iomap. The commit msg of that patch gives more details.

Patch-3 is finally a straight forward patch to enable large folio support on
ext2. 

Note: This series only converts regular file to iomap and not dir or any other type.
While doing the conversion, I observed that ext2 uses page cache for directories
and it uses fs/buffer.c API - block_write_begin()/block_write_end() for doing so.
(look into ext2_prepare_chunk() and ext2_commit_chunk())
We currently don't have an equivalent APIs in iomap for doing the same which
can be called from users. So, next I will be spending sometime on ext2 dir conversion.

For now it was discussed to continue the conversion of ext2 regular file's
buffered-io path to iomap which is what this series does.

Testing
=========
I have done some minimal testing of the series and haven't found any issue so far.
I will test 1k and 4k block size configuration with -g auto and update the results. 
Meanwhile I wanted to get the series out for an initial review.


Ritesh Harjani (IBM) (3):
  ext2: Fix ki_pos update for DIO buffered-io fallback case
  ext2: Convert ext2 regular file buffered I/O to use iomap
  ext2: Enable large folio support

 fs/ext2/file.c  | 21 ++++++++++++--
 fs/ext2/inode.c | 74 +++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 84 insertions(+), 11 deletions(-)

-- 
2.41.0


