Return-Path: <linux-fsdevel+bounces-79128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePNAMBWopmk7SgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 10:21:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEA51EBC26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 10:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18382303C538
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 09:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D9C38C2D2;
	Tue,  3 Mar 2026 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGuTpO3B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA3389452
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529678; cv=pass; b=tAyUot6b0xtGNITovV39axpJkSs1Q3iJCdGyTisu8EJtnzoqYMN/pZ9iYBQqYzOSkYaa/8X/79Gczeo8Yd16yBz/0ewzSuwGyKRd6CAYf/hm9DhhFOKSuItZYy+zl81CaChY+wculVzyi8cBe8elzAwrbWzgRHILqrYkPjSqiJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529678; c=relaxed/simple;
	bh=bb64YLXIy3oPeHwsvS7m0P33nEAT9WuWSYWp276y4dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbKXVa/mmzAF8bdxsAV+rSgt+OPFv8MXjMzIgWILMqtXPIpDURd5dsJx76brgpFpga0fDNWNRIvJ7Ri4/Xf5o89KeCyxSA44FS6hxZ79iiE0xybrXShQviiEQR7ipHkQWH7giwau9O1jt6o291yMQj3tM4rkAEHHXbR1aELhyeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGuTpO3B; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8f97c626aaso950311666b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 01:21:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772529676; cv=none;
        d=google.com; s=arc-20240605;
        b=JfWEWjQ0ybve45HVJKXhvf57lzDHf9v3Nhjdic7/hT259+FLFpwGE9WeUJKULsVKhx
         EA9n/dCIJiOGzcsj0W5OqmSlF5mN2MZtSJ8eEAsXTPAPMBlqffClFb1jqv6/sQ7SykHW
         nwHS3rdhOoEHeFiiFEzZ01upg1E/vV1gqYnr/6CmnLgitdH/PkIk6eAFxkoKvufayjSh
         42y+O1/ZhpAxTJHyFuzPJ4VdSb+aDiIcTQuYX0UNbbDdB88YDQl6BE4mkiWmDsybConh
         Dto2lOoeqkIIusFTetCAsEKYbbE96oyzUCcex79NNW4QA5pcOlH8jLeWrlSEqpUh0zCp
         iJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pkig2duPJVssDkbWxtWOY0gHaOnkUNJGF+RUH4/MX7E=;
        fh=QCPNGZ5a99vhKIVpnprwbCRii3ObIHvoBr+ex0WDjGk=;
        b=DPDTnb1VOYnoKDvEgtb67cgNrLYhQ34nF9TrCynFvubmnWsc2BdX2IVpmKObAIShUF
         IioieYqdIuIQfo4brgO7d/3XIiRa43ZzWG1Qj3jO0QMPFyx4bD9PSgPstoj+gItmH5HY
         TvN32jK//sz9smTNezRrP4MnukU+IXlEqsNp9UA/Y8HEH1wmZjRhin8LLJlNSXP1o9ap
         xJ86KR0eFYdMvjdFtJGih4TnIyJPYh+eoVEBvILR6Q3nqmPrJ/1FoATxYmOEF/fuB2TH
         tho6lRb/+E3HZMgBTDzZVtx9xXyEFtPlAAP7D+u053UYd/SoobD/jlsS/3ZaBrnL2VOZ
         BghQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772529676; x=1773134476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkig2duPJVssDkbWxtWOY0gHaOnkUNJGF+RUH4/MX7E=;
        b=nGuTpO3ByxyjjWH2tKgvQehhnLj3L1VHUegh6UFn9Z60eQlD1tg/xJBb10Kh4bUSEP
         YTjjKDswEqoZwpFvPZ9wIEOzbSzGwROyp3rx9ovIDwepfY2GhImOgdmCxodjRVrXVz+p
         Se/gSpfm7dx72pfJ62GfD7/Hnz3LVKnhKgoumXg5urpBgVDYH2wkfY+iybIvkkamghzJ
         LJaIdWxjTKCfKDtR4uiswi+skWBpIYFkW0Xy9l63k9aQd5d460EZrTss88JRcasaZEtA
         HPkRxCpIbSQjQoGYQa1mzndXxuD3h5wu6WZf/iSgaHQeg8pEaNzxZJhWI6Tciu6TqduC
         Y1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772529676; x=1773134476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pkig2duPJVssDkbWxtWOY0gHaOnkUNJGF+RUH4/MX7E=;
        b=g06N8DcsqYz/yTpuznFU9WNHoe11HNDHIloIHwNeMrcp1h21OkzEBxoHAnCVxVaSPn
         /1VDOLcf3iPtGTp2Ey8fgAG1/XUNyxBG61xCRmEUakJjUdKNWOcmjYr/9V7S5OQMFrpy
         cK1v0zqbcPFlFystuPB8qlrCovD+aKczgLh1OyB4lNenZz8pMl7d7MO4zvLX2tBSfJ2r
         76kd1GGk6eUjUKe0wXMbUmapmQv8ckCsA0s19VBOoRfqsO3rZG6dIBYXwGKF3Ck70JVY
         zLu0XTPFZbkcHPIBppO9aO8hX9lldvkyaYRMqO0zMW2eUbqWM2W9Uj7UaT870Y4E65aM
         s/RA==
X-Forwarded-Encrypted: i=1; AJvYcCVRhAxvm8/oecpVVUj478LRMRKSDgNxqftCAGTeljfJfKHXtQltgovqmyLBLTJeTmfA9mnQteKiWhPoRSoY@vger.kernel.org
X-Gm-Message-State: AOJu0YwbCzempp6puypnW6eB7XASal+OZbCNVRQE7IJngj4fJ9FvmDHB
	RHGpOT6fgB7HQfGQKb9RK+hdfdRD6KNgNTeIviho/S4+aqaW0liKjPTy3qKsK/TRZN5/TfInGVi
	uGQq31/MYKX2qvfp1lLYoD1SuN8Ndfeo=
X-Gm-Gg: ATEYQzzIn31L83amx5l9tUHsaaBan+RPDdhyZoKZ15qoeqgcfepgaq+P9MNTeCyUVXQ
	2qFlhJYzAtx6pCovSAMQgwEFYI++axyORYlhxE5Yahg3u9MAJyXoQX7x6B2fMqvQJAeUvo0IoDM
	tbeXmgX774YyStW1E8Rqs57mqdymrJvGO38/8HT+n+tLBJbSm6HJX3RMWOaaUmiosubk1YBXzb6
	/UqiaPbsi2gbXfgPo8U47SMRC2HOuOfXUrdDeBxarqNE53uWvAGKM7+49ZqZ9b5iHnrsVetMkS/
	IEyAq6IKhwF9YWyW0xrh6spKMsMSxOi3J6K12fSJSZsHSlIQnL0=
X-Received: by 2002:a17:907:3d51:b0:b87:10fd:b590 with SMTP id
 a640c23a62f3a-b9376590b83mr865582266b.60.1772529675436; Tue, 03 Mar 2026
 01:21:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177249785452.483405.17984642662799629787.stgit@frogsfrogsfrogs> <177249785472.483405.1160086113668716052.stgit@frogsfrogsfrogs>
In-Reply-To: <177249785472.483405.1160086113668716052.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Mar 2026 10:21:04 +0100
X-Gm-Features: AaiRm535KwsgAVHj6EheTjrAtrSsGztnAGaoLe1OJY2V4Cm-WW3-sgOnbmd3S6E
Message-ID: <CAOQ4uxgmYNWCs18+WU9-7QDkhp0f_xX6nvKiyDhS8gZzfUXXXA@mail.gmail.com>
Subject: Re: [PATCH 1/1] generic: test fsnotify filesystem error reporting
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, hch@lst.de, 
	gabriel@krisman.be, jack@suse.cz, fstests@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3FEA51EBC26
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79128-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 1:40=E2=80=AFAM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Test the fsnotify filesystem error reporting.

For the record, I feel that I need to say to all the people whom we pushed =
back
on fanotify tests in fstests until there was a good enough reason to do so,
that this seems like a good reason to do so ;)

But also for future test writers, please note that FAN_FS_ERROR is an
exception to the rule and please keep writing new fanotify/inotify tests in=
 LTP
(until there is a good enough reason...)

>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  src/Makefile           |    2
>  src/fs-monitor.c       |  155 +++++++++++++++++++++++++++++++++
>  tests/generic/1838     |  228 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/generic/1838.out |   20 ++++
>  4 files changed, 404 insertions(+), 1 deletion(-)
>  create mode 100644 src/fs-monitor.c
>  create mode 100755 tests/generic/1838
>  create mode 100644 tests/generic/1838.out
>
>
...

> diff --git a/tests/generic/1838 b/tests/generic/1838
> new file mode 100755
> index 00000000000000..087851ddcbdb44
> --- /dev/null
> +++ b/tests/generic/1838
> @@ -0,0 +1,228 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2024-2026 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test No. 1838
> +#
> +# Check that fsnotify can report file IO errors.
> +
> +. ./common/preamble
> +_begin_fstest auto quick eio selfhealing
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +       cd /
> +       test -n "$fsmonitor_pid" && kill -TERM $fsmonitor_pid
> +       rm -f $tmp.*
> +       _dmerror_cleanup
> +}
> +
> +# Import common functions.
> +. ./common/fuzzy
> +. ./common/filter
> +. ./common/dmerror
> +. ./common/systemd
> +
> +case "$FSTYP" in
> +xfs)
> +       # added as a part of xfs health monitoring
> +       _require_xfs_io_command healthmon
> +       # no out of place writes
> +       _require_no_xfs_always_cow
> +       ;;
> +ext4)
> +       # added at the same time as uevents
> +       modprobe fs-$FSTYP
> +       test -e /sys/fs/ext4/features/uevents || \
> +               _notrun "$FSTYP does not support fsnotify ioerrors"
> +       ;;
> +*)
> +       _notrun "$FSTYP does not support fsnotify ioerrors"
> +       ;;
> +esac
> +

_require_fsnotify_errors ?

> +_require_scratch
> +_require_dm_target error
> +_require_test_program fs-monitor
> +_require_xfs_io_command "fiemap"
> +_require_odirect
> +
> +# fsnotify only gives us a file handle, the error number, and the number=
 of
> +# times it was seen in between event deliveries.   The handle is mostly =
useless
> +# since we have no generic way to map that to a file path.  Therefore we=
 can
> +# only coalesce all the I/O errors into one report.
> +filter_fsnotify_errors() {
> +       _filter_scratch | \
> +               grep -E '(FAN_FS_ERROR|Generic Error Record|error: 5)' | =
\
> +               sed -e "s/len=3D[0-9]*/len=3DXXX/g" | \
> +               sort | \
> +               uniq
> +}

move to common/filter?

Apart from those nits, no further comments.

Thanks,
Amir.

