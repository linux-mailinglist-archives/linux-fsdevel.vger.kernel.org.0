Return-Path: <linux-fsdevel+bounces-30501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D169598BD71
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 15:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF701C23B3A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEFF1C3F04;
	Tue,  1 Oct 2024 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dupond.be header.i=@dupond.be header.b="WHLaNSVZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from apollo.dupie.be (apollo.dupie.be [51.159.20.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A78C2E3
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.20.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789156; cv=none; b=KwX3dhlna/Y0oRYKPlF0jmOTgz1yGDP0sfkca6GxNEECxbfV971JImLxescujUedTZHY5PB9hJs0UMFSTYlo+ZXkDJHPc8JrM26P2wdRR/nvpJWh3LCAsA59Np9nE+2ngOVAVFURlrEC24Cy2IGk6aDOdCp2ojWZhz24Qr7xpQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789156; c=relaxed/simple;
	bh=Dvqh0y8EXjkEl84pSD+lEgSPJ/HnMsQvoLuVRL1JMck=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=oLPqf+bcXIirHmfLU2dgb3KvTNZTVd8As2/1FMCIH0COFICkk7XRQsk6Q6JpOHVV4iEFKC1nH8PvhC19KsiPEGwTNsMsiKgkSFFbLZC62nHhnDrQQ6l388KBLr9ThD63AqUEA+KwFF9i74aYCg3KzYwxEJDi2DP99Sa/uDpbRuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dupond.be; spf=pass smtp.mailfrom=dupond.be; dkim=pass (2048-bit key) header.d=dupond.be header.i=@dupond.be header.b=WHLaNSVZ; arc=none smtp.client-ip=51.159.20.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dupond.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dupond.be
Received: from [IPV6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2] (unknown [IPv6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2])
	by apollo.dupie.be (Postfix) with ESMTPSA id DBEC51520F34
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 15:20:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
	t=1727788844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jNtzFFQL1kbQIy0wR8ln9ABLLz8k9bTFYVq1kCnsq/Q=;
	b=WHLaNSVZ/RiJpJaJnjaXXKVXWaOPtT0SWeihWS42zN/cw45ozWAVGLJNmdUTab/gH5JP+E
	2OmhH0ij1WQpoyNcHW9m/gjrcdc6yw8lbLei4ZMa6pYvo2htleFnXJVKalmv3K541LvsGW
	cpGx9f//5+QFa1cGQmO6DnaSzp7dHoifp3fZ230vi4S2V/K4KH0qofHGi8nVUxZHaU5vd2
	FoEHpaFFpUvAnkq7rwBXxxjjv8r1RXiipa1oCSZaT25LjKartnU3lrQg+2Zo4Repu8sDWt
	PnoaFaZd0+GvrjNLhcZiuBAZj2ddMaZoskg8dIim8l3mGY9IrjRx4V8abguBhA==
Message-ID: <67055f77-fb5e-4c2e-9570-4361ab05defa@dupond.be>
Date: Tue, 1 Oct 2024 15:20:43 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
From: Jean-Louis Dupond <jean-louis@dupond.be>
Subject: FIFREEZE on loop device does not return EBUSY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi All,

I've been investigating a hang/freeze of some of our VM's when running a 
snapshot on them.
The cause seems to be that the fsFreeze call before the snapshot gets 
locked forever due to the use of a loop device.

There are multiple reports about this, like [1] or [2].
Also there is a quite easy way to simulate it, see [3].

Now this seems to happen when you do a ioctl FIFREEZE on a mount point 
that is backed by a loop device.
For ex:
/dev/loop0      3.9G  508K  3.7G   1% /tmp

And loop0 is:
/dev/loop0: [2052]:25308501 (/usr/tmpDSK)

Now if you lock the disk/partition that has /usr, and then you want to 
lock /tmp, it will hang forever (or until you thaw the /usr disk).
You would expect that the call returns -EBUSY like the others, but that 
is not the case.

Is this something we want to solve? Or does somebody have better idea's 
on how to resolve this?
The Qemu issue is already a long standing issue, which I want to get 
resolved :)

Thanks
Jean-Louis

[1]: https://gitlab.com/qemu-project/qemu/-/issues/592
[2]: 
https://forum.proxmox.com/threads/snapshot-backup-not-working-guest-agent-fs-freeze-gets-timeout.99887/
[3]: https://gitlab.com/qemu-project/qemu/-/issues/520#note_1879103020


