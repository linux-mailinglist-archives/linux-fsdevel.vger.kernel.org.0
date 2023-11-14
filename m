Return-Path: <linux-fsdevel+bounces-2812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A3C7EA87E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 02:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86F51C20C09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 01:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C60D8488;
	Tue, 14 Nov 2023 01:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOIWy/rS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC9A6101;
	Tue, 14 Nov 2023 01:58:08 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F5BD45;
	Mon, 13 Nov 2023 17:58:07 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c7c7544c78so57128361fa.2;
        Mon, 13 Nov 2023 17:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699927084; x=1700531884; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8fqNNt5CJDoqCiL1Q4B3/x2//+Oyq8c8Q1YRIA7KRwE=;
        b=iOIWy/rSDhTERb4k2cE9uBonIdmnNymf1vQNlrFXVBgDKtEXokP0mSpf7fH+TOWDXl
         D0MqH2RuGNbsfdiV0GOFYroaVAZW1ESxxVhZiUgTB0nSFU5Cd1w7lcfGCcr4cikd19Ho
         RQ5sZw0s9XGQBeWN4/I+7IKoD/SqmdGFma54TckiUr4kiOeUaUG9Xtvs9f1Yr7p7mtI7
         YK1VJ45USKAvxUQeQFLpTvo/ndW1NMtIXGSatzJpUe/N8cxZp7n56155iYtAJxB20ZsN
         vc6qvgewteozvc5Yvouyse6sMY/2TC3ECmeT/7InebX3UHGfgPjQBLsoq3P9TT7zOunN
         FFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699927084; x=1700531884;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8fqNNt5CJDoqCiL1Q4B3/x2//+Oyq8c8Q1YRIA7KRwE=;
        b=dOv2og+TEkrNlBZPY7piTTItEG4UbABXSsLS9LwBjL0jAiSTmtj58tXVLvsdNnUKA7
         VupsU+sOB+YpEAwSN5gw9CAFK+Z3YiT9zOXMX8eT3odC3WcKTEN7soiTFIv4Sxu/6nWe
         jpzWWApJmP1VvZOm8eLWpe+mkDGXb8CYMMrYsZVBnDXL/m1GdKfFl0fALvJJc7DBSdwY
         Fwgw4W0VxcOPwkAHCJSdHHSzUtMrpli/YkA4ONymmnKk/eP3rLpd3VWjprcNRyKHZYKc
         atKKJW//Uep5Uusyaocj1bgIiYwyP9JKe9e8UR5lsb1FUfct7PfuN/UaMiwXTxHUBceS
         NpeQ==
X-Gm-Message-State: AOJu0YxUCr/hLOah6jN96dKRfS8mBbk3aBwTNzTNxthAJukpSIcrNZRL
	9LZGtdGgUALWH02EyQkX3R8nKz+C5wCE/seQyla60e4619s=
X-Google-Smtp-Source: AGHT+IFeqzKbIVemR5UzTQZkpXG7+seLjHzDrlyjfBw5pTiyO5KDiBL6r4WCMrRnSDMHy9lpK83WFiuutJ0Aev9nihc=
X-Received: by 2002:a05:651c:2204:b0:2c5:7afd:75a1 with SMTP id
 y4-20020a05651c220400b002c57afd75a1mr714966ljq.44.1699927084329; Mon, 13 Nov
 2023 17:58:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ming Lin <minggr@gmail.com>
Date: Mon, 13 Nov 2023 17:57:52 -0800
Message-ID: <CAF1ivSY-V+afUxfH7SDyM9vG991u7EoDCteL1y5jurnKSzQ3YA@mail.gmail.com>
Subject: Performance Difference between ext4 and Raw Block Device Access with buffer_io
To: linux-block@vger.kernel.org, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

We are currently conducting performance tests on an application that
involves writing/reading data to/from ext4 or a raw block device.
Specifically, for raw block device access, we have implemented a
simple "userspace filesystem" directly on top of it.

All write/read operations are being tested using buffer_io. However,
we have observed that the ext4+buffer_io performance significantly
outperforms raw_block_device+buffer_io:

ext4: write 18G/s, read 40G/s
raw block device: write 18G/s, read 21G/s

We are exploring potential reasons for this difference. One hypothesis
is related to the page cache radix tree being per inode. Could it be
that, for the raw_block_device, there is only one radix tree, leading
to increased lock contention during write/read buffer_io operations?

Your insights on this matter would be greatly appreciated.

Thanks,
Ming

