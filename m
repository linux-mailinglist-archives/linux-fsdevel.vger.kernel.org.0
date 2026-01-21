Return-Path: <linux-fsdevel+bounces-74776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJCyOkZScGlvXQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 05:12:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B6550E19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 05:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D961B3EA0F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 04:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88389314B7F;
	Wed, 21 Jan 2026 04:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YC2zAEyJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50973ACF01
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 04:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768968749; cv=pass; b=jhQY3XUYvF7mlAVtkMwkNuBgtvp79lZsngpiKjc+RnG7dhNHrs6DeKKAno4ph44N9Vh5x4+kQp2HcjHNecD/B+S6TK1Zz+xVw7ivXlrvkrW+ffz1oNxNDtvPoKDx82BMHbhyhA4LjxcBLwFR3nuqdk5M9YRvZ1DUudGpl+TAais=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768968749; c=relaxed/simple;
	bh=3JikqCYZpKTLNdocKElqgy9mH0YJiaCS5IfZgNjHH+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3R1xtk/+yXmTNPSVhrSouQOFNk6bmuZlPbmdm0gD2Q/ezkKmtXJbqTpGEi+308GcE7hmXj9nukUHNb0S1RkMkKJ5LYyluFI7cTENBfoBdbczwtCJwQbEqH5+7RvNJQwj74Vuq9eAXm/GEwhWBF72sowCUu5SM5/EKv3BJuHnYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YC2zAEyJ; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5014e8a42aeso67091681cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 20:12:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768968742; cv=none;
        d=google.com; s=arc-20240605;
        b=KfldIYOZ+E0/KmeLoJMUJaHMfvju2rkxedWZ52EmMz4P/PIecZp3/hH93buZO+hV9B
         cNQioExR0uelTfUycORyIfKn+beyxAnMFbzaqlfd9c8ba86NnPQajYmKo5QrgBg1zXfZ
         61FYR8SKpVVVkJyX9h97GBhq6laZfJFf0iR9PM0lB0uqbKCsr3u/CKco5PORG5n51W2I
         97JjEUPGF/sWQGOrVDAcBaOHsS5+m0WopBzX5wqHC5ItHpiEHnHlC86EcsK7b94sO0w6
         HeaBZ4Hen3KIEWUrZNXbSX5zYX9TvjbhlXGUWLv5Tuw2L6hvL4GlCSnoQDDzbE7AXNnR
         xhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=86NsQBEwep6nz//fpgD/2Nx9D7ptCLO5b200+W69cCY=;
        fh=kOt8udAd7xT2gqgnG4+1syRwKMuQM3JT7BRPEohF7/0=;
        b=TDErYe5L2vYPrt/e+pRP/qxzUfDL8ZhPw0aZYIA6NX++G2s7zfXep7R6Z/YUbHH8ro
         xQT8Hp9UoYPONDznNBJ1avHFhyfYivdMB8rTbUeX35DmWFMaBeYhER6svC55LwwEztGs
         aEGKbN3M25u3hGRmsy/A/UOFee1VJpZFB90fbiebVpIn42V0+CXp9mwzJm6oYNb45rdA
         vtqyS8QYIMjuEAyxP9fJR4/DnvFs8k84IWvHIzURIMbXQ80N1opqOSLx0TAQ2DjSXU1D
         Muqg7sIAH0WFZZKAtVgHaRYoJfQ+2lKWudUznpAidFZjT3CGt8hAzweFnhkOzfnukAv9
         MGIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768968742; x=1769573542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86NsQBEwep6nz//fpgD/2Nx9D7ptCLO5b200+W69cCY=;
        b=YC2zAEyJg7kms/SzjzgFtRB/o+FGgOZQBnxnKdxBqLr1eRdkuQEMViQh3OXPa+MwCP
         Mpg6/bNyqALXt6yoPQUlOicfTYiVghWmQ3sBn5760jzwWf9jSMH5GvOQBjoy59OOI/lp
         6ICr7NLpYbx67511947JiDpGc/Xu2AWn1w76XZxXr39JhuTHbYfd6jcEgUhWFstOBAZi
         6B3I86HvgtiLmwYMDZJAu56VHE4BoJkQqDTJmDDmDHKy8vDMF2WgoLuVTZENPk+VSUTx
         Onz+vuYy8iRvSKFn1bCvFM+xiGVWwMEvktkSRx2tDZFoHt3UGT9YzBGxP6a1m9sT/a/0
         74XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768968742; x=1769573542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=86NsQBEwep6nz//fpgD/2Nx9D7ptCLO5b200+W69cCY=;
        b=cQa/+0IambMboOXYful3rU+lOCXkmr3dAlvi5U3HLgA5y4ni4YNSv3LCBF2QqzJmhK
         8QbpQdxlB/t+gC1xUp08a31idvMKfnTrGmykzPEogH+/kkEkVbfd2Op1ohAoCjOS3NDc
         vJsUsbS4uU+N2IP2OYns9Gd+VcGtELkBycRf00pvG8CA/CAu2EVB6jbr15SWu3LWaiKl
         QAk967lPcvO8p7zRRA90noF52/rMgvxOcCgZ2KlG6I6G+tM2YXyCSAEbS96AkV4qMq40
         rXlaEQkQLMNOibyri/iwo6nEshGdVEJV44dBTsEx78bqtlX5Y7yMAZjI+ACFcqG0hmwM
         Hjkg==
X-Forwarded-Encrypted: i=1; AJvYcCXtMxN1VRR2YGGgH4hP5AwtEtw5Dd/5ttaAb8yMWfK8blKkZFcgGmWURyam29l1em/L+0fw/uZ2Iu01OtJi@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb1RiqYjcpDp/cbwoPgsFZcho7H1hbfDMErDfLcapEPqcf1+2P
	kOKK9kRaI1rH8S8j+uSOAaUBx+wp18hWw6CNiC3veEw+ozYWUMB0nE0wdnYveaPeDwEX6cZ47j0
	VZASsVRkTmc5+F2nfUMXj9g9l1V8S7BI=
X-Gm-Gg: AZuq6aJFaxfFkJUvxuVPVM0ywKilOBsn2hSlF4AjDkuXPRkyYCYM8o9Y7O6zGaQOv2r
	m+71oCm8sfhplmfjCwWhPp7xUKCIZ2hzr9TnCm1Cy62gSwysrr/kJrAH0FgE2vSDU+rGoIQsveX
	NY263yg9gw676ToGlG8N3My3DBzeU9/xManOw1X0lmunL/EEoXRAL07fh/1j4aLZtduPamowZKp
	CyhO/m4pKrqI+WwggOWSAdCPBUtMzcX94nVtXAnfdKSyADJ3R3+rG9bSztvULBrYvp/sKv0pFg6
	JC08
X-Received: by 2002:ac8:7149:0:b0:502:9d:ec61 with SMTP id d75a77b69052e-502e047a4d4mr17492881cf.29.1768968742345;
 Tue, 20 Jan 2026 20:12:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116015452.757719-1-joannelkoong@gmail.com>
 <20260116015452.757719-2-joannelkoong@gmail.com> <aWmn2FympQXOMst-@casper.infradead.org>
 <CAJnrk1Zs2C-RjigzuhU-5dCqZqV1igAfAWfiv-trnydwBYOHfA@mail.gmail.com>
 <aWqxgAfDHD5mZBO1@casper.infradead.org> <CAJnrk1YJFV5aE2U6bK1PpTBp5tfkRzBK5o24AhidYFUfQnQjNQ@mail.gmail.com>
 <20260117023002.GD15532@frogsfrogsfrogs> <CAJnrk1ZSnrMLQ-g4XCAhb1nXBWE_ueEM_uTreUNxuT-3z_z-DA@mail.gmail.com>
 <aXAmwHNte1TvHbvj@casper.infradead.org>
In-Reply-To: <aXAmwHNte1TvHbvj@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 20 Jan 2026 20:12:10 -0800
X-Gm-Features: AZwV_QgHupmoyxspVBE8E0aDxXfxYe6eQnZX7QaMC3qdnrdQwI-tmIztRDi1MNM
Message-ID: <CAJnrk1Z-eTJGMEJfAcJG0T3gwVcO7C1vayYaK9Rb3POar2=Jcw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] iomap: fix readahead folio refcounting race
To: Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, hch@infradead.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74776-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 95B6550E19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 5:07=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Jan 20, 2026 at 04:34:22PM -0800, Joanne Koong wrote:
> > But looking at some of the caller implementations, I think my above
> > implementation is wrong. At least one caller (zonefs, erofs) relies on
> > iterative partial reads for zeroing parts of the folio (eg setting
> > next iomap iteration on the folio as IOMAP_HOLE), which is fine since
> > reads using bios end the read at bio submission time (which happens at
> > ->submit_read()). But fuse ends the read at either
> > ->read_folio_range() or ->submit_read() time. So I think the caller
> > needs to specify whether it ends the read at ->read_folio_range() or
> > not, and only then can we invalidate ctx->cur_folio. I'll submit v4
> > with this change.
>
> ... but it can only do that on a block size boundary!  Which means that
> if the block size is smaller than the folio size, we'll allocate an ifs.
> If the block size is equal to the folio size, we won't allocate an IFS,
> but neither will the length be less than the folio size ... so the return
> of -EIO was dead code, like I said.  Right?

Maybe I'm totally misreading this then, but can't the file size be
non-block-aligned even if the filesystem is block-based, which means
"iomap->length =3D i_size_read(inode) - iomap->offset" (as in
zonefs_read_iomap_begin()) isn't guaranteed to always be a
block-aligned mapping length (eg leading to the case where plen <
folio_size and block_size =3D=3D folio_size)? I see for direct io writes
that the write size is enforced to be block-aligned (in
zonefs_file_dio_write()) and seq files must go through direct io, but
I don't see that this applies to buffered writes for non-seq files,
which I think means inode->i_size can be non-block-aligned.

Thanks,
Joanne

