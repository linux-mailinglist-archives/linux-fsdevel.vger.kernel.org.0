Return-Path: <linux-fsdevel+bounces-17521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00948AE9DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 16:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921A31C21583
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 14:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A781D13AD36;
	Tue, 23 Apr 2024 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="XVkeJNM6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3BC8F5E
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713883888; cv=none; b=XTHMZPhfYtOdi0dsq84qlm5kw9gSjL9Lvz8AVjcCIxnr6kq9bqy9gpB4yyJWvAvVHMxkGjBYxrFpz6FX1hXUfL0vSE6a2OmNBIG143QgtAJSruaz3tEr42MzEL6HkesiFS6C/GqqWpb7zsfdj48mooRVdqiMGY80oaPfxg0MeN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713883888; c=relaxed/simple;
	bh=YbQ9e9tApjawQ5Nk84S9pyUgLTtGWTzpkvusLEc8/fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UglYt6GOnTAt5mV5caZIchZEQZrkGTWItAv1SIMmhIHEebA7X47A7lkaXMnO+yv2jayhNtyKWdjCeTRhbQ3xA9e2xNIpaWqCXuDejtlQ0Xt91istEw4bH7c5/At3LZsAgqHK+svuwBz2O7zv0+hUqs2vwqtLVCw51wYEvys4kqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=XVkeJNM6; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id E96C82111;
	Tue, 23 Apr 2024 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713883433;
	bh=5uYFnvgPiUl6XMEmFp4LcliQX+HRnjXT+LHZjpgVvEs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=XVkeJNM6mRBdfz17fEHpUJkHaKExfmDKzmwsAnb+KxpYWl+mKNpyP959ZJ2BMTaws
	 Ti6zpEF2DTycBxEiwIoVBniwGJETHHOiyqzrkUMOBGpEWi9bVXNfJVZ55vC3jUt/6J
	 lzqcnBuxQbx/DrJo2BUvb/hKq4xfTh9FXPFCY1a8=
Received: from [192.168.211.186] (192.168.211.186) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 23 Apr 2024 17:51:24 +0300
Message-ID: <85317479-4f03-4896-a2e1-d16b912e8b91@paragon-software.com>
Date: Tue, 23 Apr 2024 17:51:23 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] Convert (most of) ntfs3 to use folios
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
References: <20240422193203.3534108-1-willy@infradead.org>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20240422193203.3534108-1-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 22.04.2024 22:31, Matthew Wilcox (Oracle) wrote:
> I'm not making any attempt here to support large folios.  This is just
> to remove uses of the page-based APIs.  There are still a number of
> places in ntfs3 which use a struct page, but this is a good start on
> the conversions.
>
> v2:
>   - Rebase on next-20240422
>   - Drop "Convert reading $AttrDef to use folios", "Use a folio to read
>     UpCase", "Remove inode_write_data()" and "Remove ntfs_map_page and
>     ntfs_unmap_page" due to changes.
>   - Add "Convert inode_read_data() to use folios", "Remove calls to
>     set/clear the error flag", "Convert attr_wof_frame_info() to use a
>     folio", "Convert ntfs_get_frame_pages() to use a folio", "Convert
>     ni_readpage_cmpr() to take a folio"
>
> Matthew Wilcox (Oracle) (11):
>    ntfs3: Convert ntfs_read_folio to use a folio
>    ntfs3: Convert ntfs_write_begin to use a folio
>    ntfs3: Convert attr_data_read_resident() to take a folio
>    ntfs3: Convert ntfs_write_end() to work on a folio
>    ntfs3: Convert attr_data_write_resident to use a folio
>    ntfs3: Convert attr_make_nonresident to use a folio
>    ntfs3: Convert inode_read_data() to use folios
>    ntfs3: Remove calls to set/clear the error flag
>    ntfs3: Convert attr_wof_frame_info() to use a folio
>    ntfs3: Convert ntfs_get_frame_pages() to use a folio
>    ntfs3: Convert ni_readpage_cmpr() to take a folio
>
>   fs/ntfs3/attrib.c  | 94 ++++++++++++++++++++--------------------------
>   fs/ntfs3/file.c    | 17 +++++----
>   fs/ntfs3/frecord.c | 29 +++++++-------
>   fs/ntfs3/inode.c   | 73 ++++++++++++++++++-----------------
>   fs/ntfs3/ntfs_fs.h |  8 ++--
>   5 files changed, 102 insertions(+), 119 deletions(-)
>
Hi Matthew,

We have started testing the switch to folio as you proposed in v1.
Some of our tests went down.

After adapting I will add your patches with some minor changes.


