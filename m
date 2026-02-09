Return-Path: <linux-fsdevel+bounces-76722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHKuMDwaimkjHAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 18:32:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A51711312F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 18:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4306B30265AE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 17:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33355261B80;
	Mon,  9 Feb 2026 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSGFpZi0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F72274FEB
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658319; cv=pass; b=g3Gli2yAFnJouwBSMOYSVxP/WGwpfTQ/69iRW9/ZUbO5blSbE8+V2JFTYw6QAgnzdKzhEUSaxPSRBKd5gojtAZ2uWzPluyd2TJIpkvw/D6yGX1U/ThfiXvfoPim8SLE/f1x2RFk0pkBc6dMe+c/0GZp+B1uFvDeiFvCEc0tuevc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658319; c=relaxed/simple;
	bh=A7Bemy7E0jyiRqsRJXizeGyfe9brY6d0bZ1gI/sSMQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUoc5DHMIY7oQtGQWiVbkyWQvfyOp4mG/yqfePcRUUTWF/qfGOUxqILdLDHRRW8n6tlpSFkfRJRDt/Crr5hpFTqGaUNZ/G8cQhrmSYHDvZ+msVLTAOP1Y4w61/RUR5ZnL2EDQIzclQL/4LvNZL+IJ5OYTswIi+3LadXFnGZ3dDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSGFpZi0; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50146483bf9so50853491cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 09:31:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770658318; cv=none;
        d=google.com; s=arc-20240605;
        b=aD/dmSg4CM1jyDj+Z0xtvrfoibmKs6OnmrOERN5VBM6oojnh6UItL3O4Zxtix5COWn
         KODex5Q57ow2kCCJ3+CsVC7+EveUPEUPYRRkXBHpcGhWQsNYx7qzy8ayABg4Sm5d+Vo3
         7tLygkDVWLmXj9LYO5FuLP7i8FJmtO0xDrUpG9U4toMe9LGWVbjBy9/F9RrCYDfb9NKC
         VEd4nuTig+TTBZ829InMB4iC7EZQoMxdfcbOXjoKMzl+UWYI4jhlLU11HJ70NodukeAz
         TyYdk/8nMCHIIWRvxoZtPBbdtOhB8SixyEv1lq32T9c9Z9ckJE6Cuzurn3xXwVBMv0H0
         cHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A7Bemy7E0jyiRqsRJXizeGyfe9brY6d0bZ1gI/sSMQs=;
        fh=IwLVdiOBfDVPmqJkN8kKsW0U4urD3+WYquTiZyXv+3E=;
        b=DEHxCpIP3Dzacrj3zU4lWdL8qHSgPO77ClS8yL2oSlHIzuaiM9+WxeJxIOmtPqWWBO
         E0LGrwyL+rf2BHnIdqNN9ShxARCgYUxs2BgbmiMAtJ252Mcmbbkmrh3uTIl/dfjHN5h5
         YuD0UM10DgzbAq3eHGUvZcEDmN9o27PoBiTG/+SCiQiTfdO4iszWHuKcMy1gi4aI1ZEK
         zKn3BwU/PndEddltVmghOzTtEa4ZAvP1auboE2woZmNWRU0kTHovvGQzgXM19nP/khTv
         jfbB171EMp40x5e38HW0gneCFULKiWpZHTk2MdN/YxuTfc6x906SoW39SDrgXK85/plT
         sp7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770658318; x=1771263118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7Bemy7E0jyiRqsRJXizeGyfe9brY6d0bZ1gI/sSMQs=;
        b=DSGFpZi06+Ifj8xMUmopTDeYKSp4ZfQrL7UDxzTGKNglm9L3ackg7CkUChFTLeaQGL
         zdOyVYzF51+OBuBVdqGf81qjBAHYVkIxtlxCUg8rjGG+eQ0Ypyb0qg3koteZz3wlHU+h
         Nq4yNoXOB5DCm1o/AGuqHNZ7tQNefgXDnDa48Zc6L01CWn9JVc8TU6r2E3rqYLBx6c5o
         DpH9iOHTS3YLRz2K+PmodEhUyZl5PxArn1P3eJZBL3LCf7ReqBAojesarOlXdljRm9yT
         n5C1rKtKwPDU73HSD+8ler1ipNOhYw+0pD5Dt2QV/P10+Wb/qs7IXFgXOu+3vEyAakhl
         4znQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658318; x=1771263118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A7Bemy7E0jyiRqsRJXizeGyfe9brY6d0bZ1gI/sSMQs=;
        b=vU4loch7IPyPzh+mwSi6k4sY38e9FJ4rhi5yWxGdj+xT4kVp3lUuz2wC6cVsdr4VFf
         7D9JgBz7QFNcpAvLFrQP9iKdbUjUc8IP43NQEUdGfM/2UbuTDeWRBcUgNUlUudknE/hC
         04IP7SB3l/EZEYyFsUKJHhFbn5do19/alB11pZ/VIGq3P5FqyJt9NeY6V061rLMaMRQn
         8MBmoQ3M4VRReWjFzlBH5r4ku01/OxlnAdnNrByhayUt9c26tn6jdRt+bkUVG4QECXeR
         ugByGGK2b2vSaFXeK5gnZnL0s+PU5ZodtNHFELytu2VU3dNX/XJBo2JHt0wT8PbOhR+F
         ATEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO3PDAVTR5plEM+S8Rjve8OMlPpbKWWL1kSMMxgftiaOLgSR5byw1xupTP6iVd+uc8Fei0kkrP+Fdo/XS+@vger.kernel.org
X-Gm-Message-State: AOJu0YxIoOLkWOn8NIG+mBhm8NekKaLVkx/3TLDGjDnXthjtA0M8lqTm
	LiYwx9Sp7vXn5vJNjqPD+SCqSIDk14TMXn30yXwM15a3MU1mUcS/vNJ52UZXKAMBiEaIo8YSpry
	QJtHVrM21wQm/+2BfVHhTKLUrg78ogho=
X-Gm-Gg: AZuq6aLXXLmXyoaCUc6J8zOmVEjVrqpigtkF3aLM0JxeoDbld6JMo6KEwhVUWMh6EUQ
	008svaxwCo8x++lLOswE6L70huSxMasZEJxOGFtsWBiYSwCS2tV8BLpSgrzSlZT1s8sPgLvRZV/
	6gFzrslXDtDhIPeU3FxRpWYozGQ+8HWMl8pxQZf0bj35319VBxVdd/wnbH522uLyK9agBp7WUfE
	GmvORjKDT1m9EJcs3pRF+sy+b11mIaiQVTBkENkiF3NxHuRdoFSc3Z5fdb5U90YLrG//A==
X-Received: by 2002:ac8:7e82:0:b0:4ee:45e1:24e3 with SMTP id
 d75a77b69052e-5063999af40mr155510251cf.67.1770658318255; Mon, 09 Feb 2026
 09:31:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116233044.1532965-4-joannelkoong@gmail.com>
 <20260206133950.3133771-1-safinaskar@gmail.com> <CAJnrk1YEw2CJb5Vv__BX7DaZXmZMfTsH3WYtQ2s4RGDWNRW4_A@mail.gmail.com>
 <CAPnZJGCPNHS=R9s2dW4ebA2vtW5AQOmX7RLUtEiC2QOHKUdBmQ@mail.gmail.com>
In-Reply-To: <CAPnZJGCPNHS=R9s2dW4ebA2vtW5AQOmX7RLUtEiC2QOHKUdBmQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Feb 2026 09:31:47 -0800
X-Gm-Features: AZwV_QhnvPop5QG8SjbDcxI4POma1wqiv8UbGDbgwQQrh0tPm3hQ69v2uwM00-Y
Message-ID: <CAJnrk1Y_e1prLGX2Wo7VqRM8=upLqP29Cwv81J+bULRvCCbx_Q@mail.gmail.com>
Subject: Re: [PATCH v4 03/25] io_uring/kbuf: add support for kernel-managed
 buffer rings
To: Askar Safin <safinaskar@gmail.com>
Cc: asml.silence@gmail.com, axboe@kernel.dk, bschubert@ddn.com, 
	csander@purestorage.com, io-uring@vger.kernel.org, krisman@suse.de, 
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, hch@infradead.org, 
	xiaobing.li@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76722-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,ddn.com,purestorage.com,vger.kernel.org,suse.de,szeredi.hu,infradead.org,samsung.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2A51711312F
X-Rspamd-Action: no action

On Sat, Feb 7, 2026 at 8:13=E2=80=AFAM Askar Safin <safinaskar@gmail.com> w=
rote:
>
> On Sat, Feb 7, 2026 at 4:22=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> > I don't think this is related to kmbufs. Zero-copying is done through
> > registered buffers (eg userspace registers sparse buffers for the ring
>
> Thank you for your answer.
>
> Please, don't CC me when sending future versions of this patchset.

For context, your email address was cc-ed because you had left a
comment [1] on v1 of this patchset series. I'll make sure to remove
you from the cc list going forward.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20251213075246.164290-1-safinaska=
r@gmail.com/

>
> --
> Askar Safin

