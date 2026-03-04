Return-Path: <linux-fsdevel+bounces-79334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML4xHDsCqGkpnQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 10:58:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 069751FDFD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 10:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FD96301E5E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 09:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E8339F181;
	Wed,  4 Mar 2026 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="L/5hpOlo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0853B39EF3B;
	Wed,  4 Mar 2026 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618287; cv=none; b=r5wHRtbUbpvyk40DbV60NJ2S//6JqmV70J1x3F9VNb9cjg1JKTKySkBvxb5vzReEvA6aHzKiUJW9u32OJqgI92rqMB7Y2RL9QkBMB8QUoRi2XjIvqQQJgXQU7jDuGfrSf5FUKKo6HJVNQi1/NVhL4+uRLllxGbP9VZaB4m8tLtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618287; c=relaxed/simple;
	bh=fI+vexsTPJVCqZpKkMJGR83uuJfFm+zjxRoLgV/4HRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dAveup5w0P3C2luG7gwGwot8nbua4wSfQDiBFEIzAGWmJ9GaGmcPy4/p/beFaGOs0wNIrffSOzRL2zO2Y0qcGyA3NxTGdMNunpB9prBlKinz6ydVT33Vlt44NV6cqWRaWCjSJpNcUgZiqAHSryfzPs6NSCNzHFoMxc1LJ2VBL3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=L/5hpOlo; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 1E8BA1D40;
	Wed,  4 Mar 2026 09:56:24 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=L/5hpOlo;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 11067455;
	Wed,  4 Mar 2026 09:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1772618283;
	bh=rLSjnmY/cT6MyNJrkorgVkW/EiWZZxD40n/yPLgNYgA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=L/5hpOlo2ThTyN5JgtP+XTVcc/qsumK9z6Pi3+yyFWzq2fvgmTcJnyfSjI8HS/ecR
	 8oIsYSLE+dU3kwYhKA90eNkcp8/rhILO0FzNH8jT2z27+F/WcZe6LRWs+iPgy/q6sW
	 086dqkk8pB162t3OmbwM353L7I0Tpm3D3bPyadUo=
Received: from [192.168.95.128] (172.30.20.150) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 4 Mar 2026 12:58:01 +0300
Message-ID: <c70472ec-02b8-4c56-9806-1a9ef7e65d3d@paragon-software.com>
Date: Wed, 4 Mar 2026 10:57:59 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] ntfs3: remove copy and pasted iomap code
To: Christoph Hellwig <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta
	<anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
	<ntfs3@lists.linux.dev>, <linux-block@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-xfs@vger.kernel.org>
References: <20260223132021.292832-1-hch@lst.de>
 <20260223132021.292832-13-hch@lst.de>
 <449fd474-0b61-42ff-afbe-56b728d69262@paragon-software.com>
 <20260303152141.GB5281@lst.de>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260303152141.GB5281@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Rspamd-Queue-Id: 069751FDFD0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[paragon-software.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[paragon-software.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-79334-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[paragon-software.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almaz.alexandrovich@paragon-software.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,paragon-software.com:dkim,paragon-software.com:mid]
X-Rspamd-Action: no action

On 3/3/26 16:21, Christoph Hellwig wrote:

> On Fri, Feb 27, 2026 at 02:46:08PM +0100, Konstantin Komarov wrote:
>> Thanks for the note. The iomap helper was copied because
>> `iomap_bio_read_folio_range` is defined `static` in iomap/bio.c and thus
>> not available for reuse; that prevented using the exported helpers in this
>> tree.
> Please talk to maintainers and authors before copy and pasting their
> code.  There's usually a better way.
>
Understood. In future I will contact the authors and maintainers before
copying code.

Regards,
Konstantin


