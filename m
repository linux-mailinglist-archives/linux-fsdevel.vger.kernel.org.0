Return-Path: <linux-fsdevel+bounces-55623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 011F4B0CCA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 23:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED793BFCF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 21:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F5A23E325;
	Mon, 21 Jul 2025 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qz+GXexG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0B3223338;
	Mon, 21 Jul 2025 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133491; cv=none; b=FuojApbAqNnwN77e5LyL/zOkamjdpph2Pix7OB9e/GphIlbHNFmNHhFJh/uGMWEIPilxx7/OTGxGUwIkxSZFcS7IhvH8l8loDl/ZOKxNo4UJ68LMqJJwtHJIp6BRaYUZNRXVjQT1Yl6Q7OP4uBYnebDf0tJtef2gEh7RxdN8UiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133491; c=relaxed/simple;
	bh=jpFKKrxoHQ+R4YzBRCtRLDwIFEq9Yi9l4zj6/QFsx5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0toCoBrhTVoDPcIIHO1QPU5k2AmKgl5p3IZEL+pl4Lv3omDwn9TUCb6e9wJlkmHSZ1WFzcdySqZ6lokiOOgbI4QCb9Q09y6X6F2DxmvHirE9k0ckiLf6ZEeLHpu5DRzn9lba6WoD7OS/lIW99iPdhWSCxp1V3lVOEHuG1ui1M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qz+GXexG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8T8B4Jtap16v+NSjiTua6HgfSaTc7lZEvW2Hzt/OJTA=; b=qz+GXexGriEvIRcCUDnllLOWTP
	xgEDR13KbIg0XK4H5DoQ2ibi5m3pL6MZAOG7HYpvgWJ+FPgM42pNoD93mDaNGoKyNECRUJb1AaMzA
	L60rsrxOcRq7o8L/qPnHuGYWxkzgsRvEkGgVdfSbYp10Cg7UM04ESO5DpSAZLuX0yIX4r58oeT/1l
	6JECpD2xT8vaV1YVVCMfs3l390cu+T7DwZf0WoHcD79ISI1sSudsSSxCFJak4/C94LcwDbWimTU8s
	qrJ7z9pEJsP7kwt5LUpDvaTPGriakWuLmpjdDyNxM8vz2LJ6XlD2puUuUnYZV+2bgEfisuxnkiwLA
	POcwGJ+Q==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udy6Y-00000000jgy-0tGF;
	Mon, 21 Jul 2025 21:31:26 +0000
Message-ID: <b555f01c-4e9e-4b42-aa5a-2d35ef9c1c50@infradead.org>
Date: Mon, 21 Jul 2025 14:31:25 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jul 21 (fs/erofs/*.c)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
 Bo Liu <liubo03@inspur.com>
References: <20250721174126.75106f39@canb.auug.org.au>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250721174126.75106f39@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/21/25 12:41 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20250718:
> 

on i386 (i.e., 32-bit):

In file included from ../include/linux/bits.h:5,
                 from ../include/linux/string_helpers.h:5,
                 from ../include/linux/seq_file.h:7,
                 from ../fs/erofs/super.c:8:
../fs/erofs/internal.h: In function 'erofs_inode_in_metabox':
../include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
    7 | #define BIT(nr)                 (UL(1) << (nr))
      |                                        ^~
../fs/erofs/internal.h:305:38: note: in expansion of macro 'BIT'
  305 |         return EROFS_I(inode)->nid & BIT(EROFS_DIRENT_NID_METABOX_BIT);
      |                                      ^~~


Only super.c is shown here, but the warnings happen any time that the macro:
#define EROFS_DIRENT_NID_METABOX_BIT	63
is used (on 32-bit), all (or mostly) from internal.h erofs_nid_to_ino64():
	return ((nid << 1) & GENMASK_ULL(63, 32)) | (nid & GENMASK(30, 0)) |
		((nid >> EROFS_DIRENT_NID_METABOX_BIT) << 31);


-- 
~Randy


