Return-Path: <linux-fsdevel+bounces-79346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOJSKr4pqGkdpAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 13:46:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9B51FFCB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 13:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEED430530CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F94F1E633C;
	Wed,  4 Mar 2026 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Cj/QcuCV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6B1E98EF;
	Wed,  4 Mar 2026 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628365; cv=none; b=LwrGbMPkB4l4nQuAiH+0QZpnEzunylBDhOJ12ep5VTdk7i2OJDWHo/O9aYoH0ecjWtodroMTDPciZOKFgGIn09Zlzc0qK7SAJeSgVhW1JgW/dZcHeFpzA5HVv5zlyR0wLsOvDJyWsgtobENofxmXEMJB2ZkHLgBmxn1eiUdakGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628365; c=relaxed/simple;
	bh=zj2/ICvhGCBGEwMwKchCfB7c2rppeX7syVoJpSPEtJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDZFIQOhWv21piZUN1pCSCHn58QF4z7juStqpm2XTg9YxIzxEIFitmRUw0K15diWTUsXGlUEEYFHJ/pjWPS5xc7hZgFLwL37/V91HRHFXAOBXHBTDYsJ1uOqRyQt3DC7jnea9q1HNBOODsXknuJjuzwBs2YNqadKwrVhM0nRbRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=Cj/QcuCV; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=P5RHYo37iETZoGj6eC/S3WoCb1hQ0nUZ+eqg1/M+t5w=; b=Cj/QcuCVGZueMtiODic16AI4o9
	LImMSPXqYuyRndCxIbdkUfpqlq05FvNv+0DkvsKnIW1lTV2tDxFKcBojgukvrOMEY/9eD2odCvXas
	iZt6J7Rvh3NK5qOjnlY2NAIPpgKzLcjkDcA6EL/zKB/Kp/0P3LSe0ypHqYpjAVFBW+Ph3nVTOwG0Z
	oNu5i95kW5GVe95wRbrILZ2KxDlbyPYBk7jWLLpWE13BcS/qjDrNaOXcxrFT3ds0CSJtPoD3+ZsEk
	9RvlqqMC3WgVXbqhaRpVK2O8MMq2ze7UmXOZE2d5SKR6uhcGetcoJ9Vnwsx1X+s8v3wi4ZNUL0Yra
	HVLx/5srNS7N4TeAoFcNtCtXeLCvmd98xWaHo/EGcIHgv+kZVsebw8XibQLNFp0fnUbTneelAL0Zn
	c0HHNRTRc/DZ9GKigPUIlk54kkIx4Kdvym2oJ8Jjxoq8ceMfVun8Etqj2TNjJ9AMBGMV+nKPezZcw
	XacHC6ZM5wj/O+O/HttS3C29dWjeHA3/+mbh7qdltdc09j8D86HkeLTkIxpOEz3tqeIZHQTmQtBzJ
	zJ6uD5y/572ftPvSiZjkuPo/eGg1sr/Kj3MmkKMo1fvfQ3OjxaoTVfRJ6kwt9GKEOjy66sX1bpwNh
	WdofayVLiQJ8buFVZE3qLSBZj1R+rchMq8UrfEcfk=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: v9fs@lists.linux.dev, Remi Pommarel <repk@triplefau.lt>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject:
 Re: [PATCH v3 2/4] 9p: Add mount option for negative dentry cache retention
Date: Wed, 04 Mar 2026 13:45:55 +0100
Message-ID: <9636991.rMLUfLXkoz@weasel>
In-Reply-To:
 <7c2a5ba3e229b4e820f0fcd565ca38ab3ca5493f.1772178819.git.repk@triplefau.lt>
References:
 <cover.1772178819.git.repk@triplefau.lt>
 <7c2a5ba3e229b4e820f0fcd565ca38ab3ca5493f.1772178819.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 2D9B51FFCB1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crudebyte.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[crudebyte.com:s=kylie];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79346-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[crudebyte.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux_oss@crudebyte.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,crudebyte.com:dkim]
X-Rspamd-Action: no action

On Friday, 27 February 2026 08:56:53 CET Remi Pommarel wrote:
[...]
> diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
> index 8410f7883109..2e42729c6c20 100644
> --- a/fs/9p/v9fs.h
> +++ b/fs/9p/v9fs.h
> @@ -24,6 +24,8 @@
>   * @V9FS_ACCESS_ANY: use a single attach for all users
>   * @V9FS_ACCESS_MASK: bit mask of different ACCESS options
>   * @V9FS_POSIX_ACL: POSIX ACLs are enforced
> + * @V9FS_NDENTRY_TMOUT_SET: Has negative dentry timeout retention time been
> + *			    overriden by ndentrycache mount option

Nit: misaligned indention due to tabs. :-)

/Christian



