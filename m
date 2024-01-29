Return-Path: <linux-fsdevel+bounces-9382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E3B8408B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 15:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD201C22E86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 14:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A321552E4;
	Mon, 29 Jan 2024 14:37:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2AE152E10;
	Mon, 29 Jan 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539035; cv=none; b=G1Da3E7tt39+7l6UUv0yEGY9C4r1xEUVwpKnHYXPonH/XC0piBzd7ka+OLMGMNXAq23rZ8IYNGU345HyypcHKkKRAh0uBGAPFvE2oleBA3WFFJDW7FIIoTD6DS7cuFo5ESM1ZwCQ4EbvVgzzZia9ZcyT5+DU1sfIbhxwZbNKaas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539035; c=relaxed/simple;
	bh=bmXVNuOPge1J/StJnQ+VQC7BT5ZG4PXJMcmIBK288Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4mGqWSzpqIXEtG/dDVKODNe53RG6+nVSusDMCCkE1xg0DcgUO31OO0pmK4wUdu2gL2TqjjG6801D/w7M509x8RzFwx32I1fFVKCMHvMLAkhksAq1aqLUG4VUr+74ox5lOPc4ZCZw7jfSXu/dDeT4Szs/Y5mAfi+dfndZU/xx8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3A04968C4E; Mon, 29 Jan 2024 15:37:09 +0100 (CET)
Date: Mon, 29 Jan 2024 15:37:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] fs,drivers: remove bdev_inode() usage outside
 of block layer and drivers
Message-ID: <20240129143709.GA568@lst.de>
References: <20240129-vfs-bdev-file-bd_inode-v1-0-42eb9eea96cf@kernel.org> <20240129-vfs-bdev-file-bd_inode-v1-2-42eb9eea96cf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129-vfs-bdev-file-bd_inode-v1-2-42eb9eea96cf@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Most of these really should be using proper high level APIs.  The
last round of work on this is here:

https://lore.kernel.org/linux-nilfs/4b11a311-c121-1f44-0ccf-a3966a396994@huaweicloud.com/


