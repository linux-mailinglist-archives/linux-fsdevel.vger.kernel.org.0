Return-Path: <linux-fsdevel+bounces-73777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB0ED202E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95BB7308F84D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406413A35BF;
	Wed, 14 Jan 2026 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OcsDdENr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90D39E6E3;
	Wed, 14 Jan 2026 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407475; cv=none; b=YY2PiJVTFvacqy44wq2FsY0rhcZURWf/Afh9utYFC/+F90mybXVwsZqyOSWiLwQ4sprkVdei+iNlJrS2n4L6Oabr6UnwUhMe0keXB2VHdvMznZRfn1b8kgSMrEwazA1gy2TXsXARKjI5HAWbTXxJ+3e4j/GyG7+LUKSMENNvmqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407475; c=relaxed/simple;
	bh=avV6DdjDrtuFKREDh7dX8ULQNvaPCX6uL3Qy8HX2D5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6jvvkoJbOBNsKQ26q8r3gmP58ljqyweB6jd2XWoPHLssNiHblcow48rPYT84kXwe4zkjZP58MMc1d/78H301jq6EBwkr2g4GAhoFnKog2bebEfeW6VSXbGyPW0P4BfxqUp113/jviE1XOwkUdMqKoizB1CLm607U4GBjPUHPVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OcsDdENr; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HpQaoCUPT6wdxz4f7lIznu8aR6PeVr63P5GrMsQT2F8=; b=OcsDdENrSHsJ/1ut8FlIWKp2QS
	C+gkAkCbSozPUltRTogIib69+Q5pTZgaYnmchsaNUB1Y2ktTb6eGJQKJ6uSjGxrupnZqUHe18jucF
	9BR8mgKVtOpjOzK0ycGaD/bdztc9CFSWKUesUYAgwOkM9egQvkw0yKhN/yKa4gLzBO+/LRkD1I+mX
	Epzc4LTzPUeXlCLromTD02rQ6ZFZuWT6JUDbf8XdGpOE6Zuz1QuI4QgW5jIur4uKYJFQ/OSJa7Hqs
	WnQjg2ZQjkVw1nYS7Io5VyF+6EFgfBHV0YXFO76+H80STX38GdWrtlWSuFEVkYdo1laJpaBKS88K9
	XcCDdWDg==;
Received: from [177.139.22.247] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vg3Yi-005Lm6-3R; Wed, 14 Jan 2026 17:17:24 +0100
Message-ID: <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com>
Date: Wed, 14 Jan 2026 13:17:15 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
To: Christoph Hellwig <hch@lst.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Carlos Maiolino <cem@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
 <20260114062608.GB10805@lst.de>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20260114062608.GB10805@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 14/01/2026 03:26, Christoph Hellwig escreveu:
> On Wed, Jan 14, 2026 at 01:31:43AM -0300, André Almeida wrote:
>> Some filesystem, like btrfs, supports mounting cloned images, but assign
>> random UUIDs for them to avoid conflicts. This breaks overlayfs "index"
>> check, given that every time the same image is mounted, it get's
>> assigned a new UUID.
> 
> ... and the fix is to not assign random uuid, but to assign a new uuid
> to the cloned image that is persisted.  That might need a new field
> to distintguish the stamped into the format uuid from the visible
> uuid like the xfs metauuid, but not hacks like this.
> 

How can I create this non random and persisting UUID? I was thinking of 
doing some operation on top the original UUID, like a circular shift, 
some sort of rearrangement of the original value that we can always 
reproduce. Is this in the right direction do you think?

