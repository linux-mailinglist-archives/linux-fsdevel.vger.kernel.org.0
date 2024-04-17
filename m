Return-Path: <linux-fsdevel+bounces-17136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C788A83CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B1A1C21F30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDCCEDC;
	Wed, 17 Apr 2024 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="MOUjvk3f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B8213D535;
	Wed, 17 Apr 2024 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359207; cv=none; b=W8Lk39MPaxY5rx7n11w40zJgEWezSjrHvKg0ZyYN6F9IKZOj5npP86JSUyRm9Eu5BDF8DnlxFgi36YRihgHDH4c8Y0/wewq/+vazsT3eI3S36VXowpuVwf6dTJTjlnHrh5bDhPCxCCpW0+7/YvyolozfhqREEDkWqRRzkS4pc9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359207; c=relaxed/simple;
	bh=moeDjildggmPtbyTfn+Q7Du1kw3N5TGihlzFDNAJ9g0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=TdDxKDbHhSewM+IxTgQSH1Ove9k3JS9ksJJpqr46CWiFHXNH4Vp+4IQYFDV8wKHaM+6VbKl1QaksfYMOydQJk4LDs2FCyhKxGJD3SO8IjrCEYVTHDEJGy+7WxzIruQBkoUAdyzJR0RXv/nAEpAAFXyAxMW1DG9k7QS7P8JKCq4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=MOUjvk3f; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 4D9D92126;
	Wed, 17 Apr 2024 12:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713358752;
	bh=ztdNdcA2+6+PqSRE5LqvWFbFaw0Bru7dBXFKo7QG3k4=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=MOUjvk3fwEdepmtANtqrXePrW6As6j09nx3ChkKCcs/Cgx3a+7hDqCMd6Lm9KQENj
	 UlToG/RMWmlMnvgEEh0S6xn0RzLSCl1U1bXa24jc/spzy5zkmwUq1hj4EpXoroJzPq
	 s9dyDFhZP5VFsoGDchI91Qmg9tp9V+6xQsUgeHQM=
Received: from [192.168.211.39] (192.168.211.39) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 17 Apr 2024 16:06:40 +0300
Message-ID: <4e9cb4a5-202d-45db-846f-17ef74bd2a5b@paragon-software.com>
Date: Wed, 17 Apr 2024 16:06:40 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 05/11] fs/ntfs3: Use 64 bit variable to avoid 32 bit overflow
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
Content-Language: en-US
In-Reply-To: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/fslog.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index d9d08823de62..d7807d255dfe 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -1184,7 +1184,8 @@ static int read_log_page(struct ntfs_log *log, u32 
vbo,
  static int log_read_rst(struct ntfs_log *log, bool first,
              struct restart_info *info)
  {
-    u32 skip, vbo;
+    u32 skip;
+    u64 vbo;
      struct RESTART_HDR *r_page = NULL;

      /* Determine which restart area we are looking for. */
-- 
2.34.1


