Return-Path: <linux-fsdevel+bounces-9321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE1D83FF9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4355F282D92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D5E52F6F;
	Mon, 29 Jan 2024 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="U9WrV/6w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C8A524CE;
	Mon, 29 Jan 2024 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515610; cv=none; b=XWTEHel+5cShfottI0CTKzO9b9EGfznHweKzptEM0NObYQrkuemiKMO7EXeb3OsEM5qotsrfCAgk09bESYP88AxPdFr6oJBASeUdeOuq859pfk05WHP7b1rTzG92VJdCowdN7TfS9yE++m/bL2QHuPL+n8c7lcVn3bDZBdBVBWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515610; c=relaxed/simple;
	bh=LF5N/gq0SPzdbSYzaYYrlsY/I6AgKbgcnMri4Rx2UpQ=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=LXqX4f2I61/s6Hjs7qeYFGFpLWZNjExtHlF9bt12AMEzG90s5Mc3Pgqk0drX81QRkGA5w57PNOcd96CpG3Kg4LHnkOSqH012KppOPA3ATz7T9WLJYOorgWgGIFA/3SXuPof5SGYzp//UuMjGSzoaoS8h4ygj1xDKT2XaahbII5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=U9WrV/6w; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id E3BC8211A;
	Mon, 29 Jan 2024 07:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1706515190;
	bh=AP8esMiWFK6y2TLvg0O+4ZX9QRrXqEbXMr35AizMWwA=;
	h=Date:To:CC:From:Subject;
	b=U9WrV/6wCHC/1OVDyPHBpiWeRFKRKLDhTSDpbbY9zQBc0dYL1QPkrczSRQMJti/ee
	 ulVjD4mD5DKCMgULCyEHIFD2rIPs5XcqQFsbVgKjHZEv1dKNz4r2MpuojJBOcJJggX
	 fzi04Agf/C8bGTx2BC5GpOBSROcULYk27dlxMkHE=
Received: from [192.168.211.199] (192.168.211.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 29 Jan 2024 11:06:39 +0300
Message-ID: <dedce962-d48d-41d6-bbbf-e95c66daba80@paragon-software.com>
Date: Mon, 29 Jan 2024 11:06:39 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/5] fs/ntfs3: Bugfix
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)


This series contains various fixes for ntfs3.

Konstantin Komarov (5):
   fs/ntfs3: Prevent generic message "attempt to access beyond end of
     device"
   fs/ntfs3: Use i_size_read and i_size_write
   fs/ntfs3: Correct function is_rst_area_valid
   fs/ntfs3: Fixed overflow check in mi_enum_attr()
   fs/ntfs3: Update inode->i_size after success write into compressed
     file

  fs/ntfs3/attrib.c  |  4 ++--
  fs/ntfs3/dir.c     |  2 +-
  fs/ntfs3/file.c    | 13 ++++++++-----
  fs/ntfs3/frecord.c | 10 +++++-----
  fs/ntfs3/fslog.c   | 14 ++++++++------
  fs/ntfs3/fsntfs.c  | 24 ++++++++++++++++++++++++
  fs/ntfs3/index.c   |  8 ++++----
  fs/ntfs3/inode.c   |  2 +-
  fs/ntfs3/ntfs_fs.h | 14 +-------------
  fs/ntfs3/record.c  |  2 +-
  10 files changed, 55 insertions(+), 38 deletions(-)

-- 
2.34.1


