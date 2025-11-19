Return-Path: <linux-fsdevel+bounces-69075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9116EC6DE5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 11:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5D55380B6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8ED346E5B;
	Wed, 19 Nov 2025 10:08:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212B0347BB6;
	Wed, 19 Nov 2025 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546939; cv=none; b=hUtKpVFvhwTqGHj+gGJ/HFCvpS2jzsnDLe8UzHk8UGkRQ/8IRdPgLjGQRwwMmro2yA031c1gWdDNHlVchVCJbD1WClCh3o3p/8NCPvzfVFBSjq9c7kZXXY2y3AfzGoTgHno9K/JqlB+W0IQUF7EFAmRe6MsaG3D4sezcJTSX6AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546939; c=relaxed/simple;
	bh=HFvmHp4KhRiQCaNoMFWITABAybDMBnC4eRfcG/H+Iok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgv2h2sG8EDyXx6t42l/r/uVqcSaKVe/WA6FKr1fjkIuFqtOJ9oOvvkYtFSfUzHKMpdbS2mtYO3Q4ebV7L6is5jdYTokpQGowTuMNGUB25MymKNdpcQQnV4URECsTCihhZ2iG7/kdaKgChWloZLj5EBG35miS34mOo3yJcFzrFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B90EF227A88; Wed, 19 Nov 2025 11:08:54 +0100 (CET)
Date: Wed, 19 Nov 2025 11:08:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
	okorniev@redhat.com, tom@talpey.com, hch@lst.de,
	alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are
 multiple layout conflicts
Message-ID: <20251119100854.GC25962@lst.de>
References: <20251115191722.3739234-1-dai.ngo@oracle.com> <20251115191722.3739234-4-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115191722.3739234-4-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

s/FSD/NFSD/ in the subject.


