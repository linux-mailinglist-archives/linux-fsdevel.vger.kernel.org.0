Return-Path: <linux-fsdevel+bounces-31573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A73C99880D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 15:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7B6DB26E58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C6B1CB317;
	Thu, 10 Oct 2024 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G7stIzi/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1647D1BDA90;
	Thu, 10 Oct 2024 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567710; cv=none; b=tg6khd/5zXNYL+MGOk5FGEq7TblrevYrMq1/tYUpO3tul178savv0OLvTj8Z4VQd09UGIeJugT/LG1jrr3JW5yuLBVGQZjPVRZkfMVIzGPE2s+GH8tQHCwtX/iXT54vVjtisu6DRJTmxpYfTFRqAlk0UjLLjfPBcgvLM4tmdHoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567710; c=relaxed/simple;
	bh=wrInKrhNB5L++HzSMy95BJXqnxEX0ZmYh/OxC2V09FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpNRagdpwlKHo1szbGHHHSb3K0cMGZGyvOmuL8gca3uicqBz43zxNMQFcdw6b+PNSCXC3IdaTRiFzFFixBIhRaGiFB/eiClyMCmGn35jQUaB8BYfpljb1VGOsuUevP41yYKQpfU+jtiYEIFa5XBB+DOxrhpBx/9ZeHotqNX/kY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G7stIzi/; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=1SRIN9/0TR2RG12zPpqOAV/SRSFtH+cmc/UM365JbN8=;
	b=G7stIzi/d3H+GZQpe99KXII6BLfmIT0NhPA+8mAncd1g5E8xnCLZBGK5H66HXA
	zXyKaacNmA+3PEGqnO9NgiDD91zFPndasSOQCyN02YFJJQh5hBo6nwNFtVPA0baI
	iQJnLtrYH9ynHnpC3C6m1e1Dm7tBp6vkdpJSGdVIaI9vI=
Received: from localhost (unknown [120.26.85.94])
	by gzsmtp4 (Coremail) with SMTP id sygvCgA3ljWS2Qdn1Mq8BA--.33798S2;
	Thu, 10 Oct 2024 21:41:39 +0800 (CST)
Date: Thu, 10 Oct 2024 21:41:38 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
Message-ID: <ZwfZkr_27ycafr7F@iZbp1asjb3cy8ks0srf007Z>
References: <66fbc081.050a0220.6bad9.0056.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66fbc081.050a0220.6bad9.0056.GAE@google.com>
X-CM-TRANSID:sygvCgA3ljWS2Qdn1Mq8BA--.33798S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RCzuADUUUU
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRRN0amcH1OdN1QAAsD

#syz test

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index ef9498a6e88a..e66cb6e9f1fa 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kcalloc(tree->max_key_len * 2 + 4, 1, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;

-- 
Best,
Qianqiang Liu


