Return-Path: <linux-fsdevel+bounces-75448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOTfIDpJd2l9dwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 12:00:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F6A876D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 12:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EAB3301F2D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 10:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4CF331238;
	Mon, 26 Jan 2026 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3iPKmcd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA94432AAB6
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424951; cv=pass; b=PSnMuc12+Ha8isHPPwiXbqRRM5MfTbeZxjhF/XL1IO+YwcsCkw05mdlSRFqLPNCJCFhaT6kHKoTRX1gRRQ69X3KFZTFoZH0CzR5lmgG4hJAdnOKwjqwXYh2PzhfYh/W68tSYfIHjxf778iBZws8n/FuzJHXJXNuB94V0YWIuoWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424951; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzAc+bxxWwMftO8HlxGnzwXz8eHiRQPA8p9tPlNf2T1e95CbpEIjq0u5PYoYzeIbRSW/Hmz0PTBRoGXSsjM0+/Gpt3oblZU5qTD1cvyfdSX6sJ+/OkGqiPDJyz8yNte3HtA5U3kU3Szc6ITZe20e7h4l8kB6pc2Dof19jRoKK3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3iPKmcd; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6581234d208so8357037a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 02:55:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769424948; cv=none;
        d=google.com; s=arc-20240605;
        b=EuJRgXyY1kzgyXeX0eXGveXmjPTevQQ4+yGzNNONTz5WYIksU0zlBqYX5iJEgVJ3vH
         7DCILra7vT2LLxMEcC9LlZR4wTd5E6Id23NyDS+nHk6+dwH6Ear2SY5lNDvJJkZ04j1C
         Cj66l//l0NFYGOYRI08rVDgnsAyHU7CKDVXjTCGV0ho9eNVz/6X2xQzr85WvONI6OqQC
         1yDteM0DwOHJCnUufGCBxVv8OPr2R11Vm2HaYMVOUiy7Yh5nexfqXfZnSjvHaSGQITya
         hK3Npu1B/6ToMkbbIxkeGJ8QrS6uc6kv5vTTK/S7Ya1dbucmFm9MnSYJOS7XZ2V1/Q3G
         ng+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=6ywfniL4gOhGcoNtzC3hJDfs+p/THPAeCHoFLrQcEHY=;
        b=ctDPApnUJdItwfCDXzvwwCiHkaMOmhDeWUHtjBJ8BsM+zlJPeEe3aKKnWnMi5rTalV
         sc8RFT5LOQoBla9nFkVFLHuex+nidYb7IoIUfn3ocBtyiKsntBPbwmb21+SkmcLV4uk1
         4pbQPvqV8p+hT3VoEZY0C9o+whheOJ6JNXQdjajSo0GmmKkqgTithpvlcQimR4Vrm23u
         +sdlGnb+gl2r/JR3y/nC6eoRyQLz6Ggu+P/bkXGGt5HnKF6Cc8lvg5gXi5dAM7C0tp6P
         zAk/Hp2WVoAG4aKzZQiOcIFlFwapLgEvjKi2XN40TvjRIauzB3G5fMwZ/wQV3qVNXBd8
         q+Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769424948; x=1770029748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=c3iPKmcdWcrKJaAj/tOAIo5py1TPzrNQ5pnCQBDB5cDKZBqdHFmbS2cqW9rU4pd1BZ
         xo3+8zTVQNLKxD+hOyRZmewYR3RYRC3SyibdkCCyBnF7cuRF5YucN15R6RtEEWQlFxAy
         NpVZAC2tc0lG0F1smKvYG4EBrF/KdDlLJliGkZQgEFBs1rPPMFhas58k6dZf1FKOUDZ5
         7Ync/FiSACF5NS+fns8XGi/3p5YOQPPZGHI8gPSRF0EU/oz/phSYciODICKoCqgDNwSk
         +D+AXYHRfBa//b7v0zpEPo8lK2n/F4uwg0lBf/jxL/b7TlGtN1oAEnNixJE2uEk1k2e+
         S5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424948; x=1770029748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=tyqnIDtbIlwxW4vtFcrC6l/VLUQRM8nE/aRDh6T/1GstWmDoW7MUlTp+FobqLqfFpP
         FdgXLVrSCXx0XIexBwoXKvwi4XC0PEaHtk1UFiKYMRmcx7kKqPPZqxEpIDrnp+xD+u/V
         qTYq/EHpOZo4EVcL34842cKe5svIvR/TBUdvS/DMHnBRU44QeQQkiMiw7sc0RmPQ+ONp
         DkK18iE7rI1nD66fn5LxWD9KX3aUeiIJLj5SghO3EHyYxyCQzedhFB4gBrKVbXHX7VOz
         NGRty+7WAL48E2xXAP3sw0QzVrkUW3sYEl40Aaoknx6W22Ky5c+Lo9TRFJPE6U09SvKf
         4Evw==
X-Forwarded-Encrypted: i=1; AJvYcCVLhQPsPEgv31Ma+y27ldUmUp50YhFEZrPE/3AE7jIe0ZbxcwfCPKxgc+rrZK3nMb8jlGvExQUs4ZaK1yww@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9hhhv4COdrGsLNlmXUIbvJJXPOt1hKOQa8TvbjSSmwQhH9I4I
	Ps8UP6OXahfGsRN4iAdVinWH9v0Y2jfIan0FpGUX0Oh4VTvfRplefyl+UL/L+b3pRHTceINdKaR
	cL2ZUwgpPz6W2fQWby3R+ORGqducFVtnQijojjA==
X-Gm-Gg: AZuq6aJM/gfKlbJDj9MgPRIUReqqCQxGYJvUxyy7QAg9mowWaLwyC3KBzzHoUbtdpQs
	bvgGixn0OHsH+b4ULtG9jAzxUljD3BxxhvM0GskhQ/rz3F6kVBLIbPjzn+6qAyYsx4G6fjqhRWf
	sOlTfJ3FrjwrVsloOgl0voSGtWBre+sq+sUkq5jGULIT/PnvfYYwlJoxuVIq4NV2p/WQ2OkLrzh
	+A24cmgeLYG3CvNB5nuOChVv6KWVqCq356W7K+Ta9M6VXAS3h5alFApZ3svwwiHJ/vIDQ3G6yCb
	9vvCdr/FArdJntrQSQkvCra25JQPTqwjex2nzYxr6272GuPDhX0RgdbjXw==
X-Received: by 2002:a05:6402:380c:b0:655:a20a:a258 with SMTP id
 4fb4d7f45d1cf-6587069c213mr2486327a12.10.1769424947707; Mon, 26 Jan 2026
 02:55:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126055406.1421026-1-hch@lst.de> <20260126055406.1421026-2-hch@lst.de>
In-Reply-To: <20260126055406.1421026-2-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 26 Jan 2026 16:25:09 +0530
X-Gm-Features: AZwV_QjUgod4A74r99ZxhhMNDurfLjL6lQ1hQ8sz2YOsyYFIfGBA-FWn3r3zY7U
Message-ID: <CACzX3AuJb887ish66TQLWyDezFBW0-XiuOaq6E624s9hxEBhUg@mail.gmail.com>
Subject: Re: [PATCH 01/15] block: add a BIO_MAX_SIZE constant and use it
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75448-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anuj1072538@gmail.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	SINGLE_SHORT_PART(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,samsung.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1F6A876D5
X-Rspamd-Action: no action

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

