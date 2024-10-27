Return-Path: <linux-fsdevel+bounces-33023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8B79B1DCA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 14:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43D9281C6D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 13:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5F5156F45;
	Sun, 27 Oct 2024 13:11:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB551E493;
	Sun, 27 Oct 2024 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730034706; cv=none; b=AcDLmMsKNj08y2jGRjdHJCZ61jo9X+qPsQY1YMzVrNgBlUujzviVLqWnZNQGTerr6gyiPNT0W9nhO8RurtOs5RvJtMDAT4w5rwlB7LL0e28FE40M+B8lIJ4fwa+cmoq0gmvkcFhirERpwvPww4oVsqLLLuUCU7rNlb6jEMtbBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730034706; c=relaxed/simple;
	bh=FyHoYGFbWTamC7/YRq7XJbj+xniyhRWqgqDOZwyc8k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Atzx85seXn+/0cB+Jz7J2/8vhjRcQ4bqXlVCVOvlt88+va0jMotExw/Pt4hlk9WogObkC3/zNUcDYYzq+CRrBL7DC/BXFjniVRMlHViJ/HrT726hHZv53RwxmKgg429Gg6jkshPAfoYr8+gWh2Ept+uUddhuv2yJyfgz2c2Hmro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Guan Xin <guanx.bac@gmail.com>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>
Subject:
 Re: Calculate VIRTQUEUE_NUM in "net/9p/trans_virtio.c" from stack size
Date: Sun, 27 Oct 2024 14:11:33 +0100
Message-ID: <2894536.PhyXTn6laM@silver>
In-Reply-To: <1921500.ue69UQ14vC@silver>
References:
 <CANeMGR6CBxC8HtqbGamgpLGM+M1Ndng_WJ-RxFXXJnc9O3cVwQ@mail.gmail.com>
 <ZxwTOB5ENi66C_kq@codewreck.org> <1921500.ue69UQ14vC@silver>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, October 26, 2024 11:36:13 AM CET Christian Schoenebeck wrote:
[...]
> I have also been working on increasing performance by allowing larger 9p
> message size and made it user-configurable at runtime. Here is the latest
> version of my patch set:
> 
> https://lore.kernel.org/all/cover.1657636554.git.linux_oss@crudebyte.com/
> 
> Patches 8..11 have already been merged. Patches 1..7 are still to be merged.

Sorry, it's been a while, I linked the wrong version of this patch set (v5).
Latest version is actually v6 here:

https://lore.kernel.org/all/cover.1657920926.git.linux_oss@crudebyte.com/

Accordingly patches 7..11 (of v6) have already been merged, whereas patches
1..6 are not merged yet.

/Christian



