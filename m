Return-Path: <linux-fsdevel+bounces-79470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK7pGaNUqWkj4wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:02:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 838B020F3C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 175F430A08A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 09:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D7937BE7C;
	Thu,  5 Mar 2026 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQA4Sj9i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F1637BE62
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704642; cv=pass; b=ZLh7Y8iuubzraqYp+TEGGNn2boE+YUVQanTaVHQJW+N21SNP8jXQkfGrbGsNCslxs/l7MgecHpMlUbIBRh+h/RS9qqdZYIWyb4pKKm7qazfWVI9CGXaMoxVtvJgb6ekxefFyRRA3eNg2y6yyspsoRDBy0SUzoVEqXLZNFMozqnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704642; c=relaxed/simple;
	bh=kGfo8Aie4bXGavt4A6ifBiJzJwYtXzI72SeAOXgEtfU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Rm3sUtndEJlulE2a9EaoFgdXlyKf9VydfY30FTbWgj0xUUIaN8OSOS3pKl+id89KaEuhQE+1REcDV+z62Ez/ePLplO9aJCg2oYA05zzsNXF0j6qdB028ux2kQ4XqCcx/473IQh5ga4mCPfV2CA86UvRM3a/sORBLplmBzdL962g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQA4Sj9i; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-359a5d8b3f8so1095926a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 01:57:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772704640; cv=none;
        d=google.com; s=arc-20240605;
        b=OGQ9nFvUAgxD+Hp7YMkgDkg24+XOpV9tTr92tyOFu4b7O4aZk3R6LCgAAvKMldDWQL
         H9cSDiwp+O1iOZthTd1PfpDiWeLYN9BZ8PG2YBus4TXFkhlgd7B/UEuVNGPBxjb7bptT
         5pKaEayhNAGjxjaTDkHJDbEA51htiXOcYMXQ31BRDlFvlMweLIPAJWU0IC5lludkZ9s2
         tglMNKy5pNxrr5l1o2DdcHPGchV1Cne0kTeeTszEijke7DLP4OkHUe42R3MXSKswOxKW
         pGxlgfy0LCsBKvP++zmHo7f+A4q+X+U5a6jjM065/PHBiyUPWlYfXjUxTLWb/TwypmgV
         cz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=kGfo8Aie4bXGavt4A6ifBiJzJwYtXzI72SeAOXgEtfU=;
        fh=on5so1iZ1tYm751VXv8x5u+l+XerJy9A4qWb/XOx/D0=;
        b=AOB2AHUSWAiRzWxX1ut9Ibwzsh25zfw5xY2P87xZ+QBojtLw18qMFRxedKYKaVpjRF
         dABfppJVm2p73F/cjVW30J2oReovz4OEhuHr4BH0IUvZc1g9tQie/fFxbz3UJ1BvjXBM
         a5heWeUOf94aydVD5tD3+hGc3Ks8aHDAEZPvd9BuMD+7uX4dYDxZJnk3ntTuzktXwDJz
         OiA2COlvDbxBHyJYilIRj05oJsxZHnskOmkC3CnUbYmjNw4EmNBpTMaS84PUeLro7flx
         g1G7VGaxDImrSlqIwuSPRQNba5zdkLImbqrNtX3nnGENvNym3bD9NXvGfvFg839yUrBT
         a4WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772704640; x=1773309440; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kGfo8Aie4bXGavt4A6ifBiJzJwYtXzI72SeAOXgEtfU=;
        b=TQA4Sj9ikfozEiJ8uNLXVxuGiRU39LXl+I0+7X+B+buKRl22dHnOzTNz0SFqiRKs7N
         FwD9BHrZoBvJ/3zTirckoEA+y2OShpFKtMVs1HnIMVM/uUOwCdnr/EprPqFW7+zLjHjc
         oWGPQeuE2r7QynoOW2P5ViDLOe7vNs0yj5Tcs6xiJCawmnhMpZGoox2OqBxkQOjbXUnm
         cTVJM8isB6FCKy7qo/4H8P0AHc8vIhm12QbfXEmN/M+qzyQNFHi4iPpjVxpiT73msckV
         kD/mZSHvwAYcJWAgV31adLl+59xh5MJIFHpzupBP6gQbBrMAxya5wGJEdlMfSqIWG/hb
         529Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704640; x=1773309440;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGfo8Aie4bXGavt4A6ifBiJzJwYtXzI72SeAOXgEtfU=;
        b=tgtYogrCodxRUPWjchz34cneHqdRkUIhphsUU/Uh2oYpP3nlcOeMNse8INRttCeQDV
         zLu/32heNiMXlaSogrIfiE6rlkM164s8wgdVc1TuCByxRN/82BaRJt4xFYZge4e0wGR9
         C20uETjoxTTlVBS+GWmp2hYgnZzFZkhaQodPY9KV5fZdZ2i1oNuohpbDwM2TrUjAqOLj
         MoQoT3Yjy3o0bn3OftFQ+GKEURcnmW9tW0U0pj8cqMjmUtnes2rTa3PjFkYN/sP3Gkng
         HK5lOkJNB3ym26Ovr17LR1W8NObFbgLMzUrkGnWYtT6+r5NIY0J3h5wuHTdbZr47TkB+
         av3Q==
X-Gm-Message-State: AOJu0YySESzaISLkn7QtIlEAgv537RI5286SGxGYg0BBZB1RxvKahEmJ
	oGsJ5V+vaAxS+DjKeb1x7GmQj27FkBcF/B8Vm3QR4AGiKwrQyriK/eeH5aOonmCXLilxsShtWsk
	sq2cJdTRKjxTM9ZbjtVvqaU9UphxNxSeg3h0K
X-Gm-Gg: ATEYQzwIKauc1Ysi5wTZtvi2lrXJE8zgF7od2lKmvsJ3reHPYNO6D4ORjvrzDXGTMhU
	V2ybSO/l5mzEmPBY3hlEXm8Vlg94UuVkpNtXbl7ufOFXxd5kQpmtR9Del2x34r8O4IKrbvnGLgN
	oOubpcr93nd3dfsnZeb3Pc2XacUB+sX3qaBbDZ//QH5WbGY+C0L2y6sNmViUWTKz8r/qVVLOciC
	jxoGeUM/FgS7+d9tCAuMG1xTdAjj/Oo8uTr8TVjiyH2svbVI8/V+OLieU877yxr5f1EaE9DLKuY
	hLWasA==
X-Received: by 2002:a17:90b:2c86:b0:356:2872:9c5d with SMTP id
 98e67ed59e1d1-359a6a6648fmr5286163a91.24.1772704639806; Thu, 05 Mar 2026
 01:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rohit <rsingh.ind.1272@gmail.com>
Date: Thu, 5 Mar 2026 15:27:08 +0530
X-Gm-Features: AaiRm50XeHOLEwSmJ5mw37ZQepFgtKRMXiKCkrANO-kX2ENa_z53rksA6F69c9A
Message-ID: <CAD+278XmGAdCDL46vxhTuVLoVE4uSNXTz0LGSivjctyUDhWZMA@mail.gmail.com>
Subject: Missing Null Pointer check in seq_open
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 838B020F3C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79470-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rsinghind1272@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.952];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,

I would like to report a missing NULL pointer check in the fs/seq_file.c APIs.

The seq_open(struct file *file, const struct seq_operations *op) function
does not check whether the second argument is NULL or not.

Other functions, such as seq_read_iter(), directly dereference seq_operations
pointers, possibly resulting in a kernel NULL pointer dereference.

ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
{
struct seq_file *m = iocb->ki_filp->private_data;
....
....

p = m->op->start(m, &m->index);
....
}

