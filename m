Return-Path: <linux-fsdevel+bounces-46895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D6FA95F5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 09:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C58DC7A2F86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 07:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1014238C02;
	Tue, 22 Apr 2025 07:28:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2121ABBA;
	Tue, 22 Apr 2025 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306885; cv=none; b=um+yU1YavKrdic2NgutcclLwyy86HRtbl+zEOm9AucAh0Q0JI6zrTBaf0YQDHGPU/8rdlOuCTViPNT9ma3btrwvWGG8M5V9nuKw9RhhXtxqPSuK8KAS6S/9GR9GImo/S8+wyHQwkm4q+s8XcsBLTHOBMWSltTtIHrnF4nQxUk74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306885; c=relaxed/simple;
	bh=XfG9K5hw6SmY0nn9JtKBfddQoiaBK6Xm5w+/aQYWELA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTKrZLBku9iOdk13DLrBT712jklfFRMMcDkjgqRbXpP+N5R6ltKoGK/EAlNFJ71ORmIbxRbFeGBDKi5feLtTtE0DYPv3xA95pwmhkMei4V2xQlhiZA4oG9rOXnG/Pqo23VmckHy9Bfzn6u+fQBPyU6m4Zb2iS28ulEiQ4SVu8FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9A76968C4E; Tue, 22 Apr 2025 09:27:58 +0200 (CEST)
Date: Tue, 22 Apr 2025 09:27:58 +0200
From: hch <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: hch <hch@lst.de>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"djwong@kernel.org" <djwong@kernel.org>,
	"ebiggers@google.com" <ebiggers@google.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
Message-ID: <20250422072758.GA31626@lst.de>
References: <20250417064042.712140-1-hch@lst.de> <xrvvwm7irr6dldsbfka3c4qjzyc4zizf3duqaroubd2msrbjf5@aiexg44ofiq3> <20250422055149.GB29356@lst.de> <20250422-auswies-feinschliff-b89c231316db@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422-auswies-feinschliff-b89c231316db@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 22, 2025 at 09:25:24AM +0200, Christian Brauner wrote:
> Can you send this as a proper patch so I can pick it up, please?
> It needs to go upstream.

I'll wait for a tested-by tag from at least on of the reports while
I'm running more tests.  The previous one was obviously a bit hurried
so I'm all for not rushing this round.


