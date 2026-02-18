Return-Path: <linux-fsdevel+bounces-77595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHEOAqHulWlTWwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 17:53:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B996157EDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 17:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EFC1300D45D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF79344050;
	Wed, 18 Feb 2026 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebLIDNhG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB2F344058
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771433624; cv=pass; b=eJH6+cTivaKeWxHmQzXjPSR67PXYkalW+6dPdGOVn403sh4X9i6cihFULoD85Zl+p41PwJD1+o46LwwWlZow5GLQOW1MIoDRovGXOBsPlpAEVsDy0aaceYzKB1cz/s4/AHXsUK0pmDvVzEcy+PAXQUNW5CeLj6cDhvqMtaIzWkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771433624; c=relaxed/simple;
	bh=g3yqfUCC0w8uhWh0gaCulJ42wSE3w0NYVYfUc0m+/LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=rL17HUoOnCpgUwXd4JFH68ee39sAEUL9zQNIWCxxuElLHEUDAPvYaHcX3v8PDu/SU4JF9mwmdPUhg5coVp/wDPug3tqrV1QE84P1al7V585RWe/UrqWVBaOogpNeUdrEYp0crKB2dQOYSaE520nWDStsH15B7RSc/49Yga4qRcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebLIDNhG; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d4c4b494fcso56856a34.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 08:53:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771433622; cv=none;
        d=google.com; s=arc-20240605;
        b=PZ9JWILi4Wq3PwFj5x/CzqD/G9Ow48OKeLBCq+Xg+k9V+eaVF1rT0dVJef6OmBUw9a
         uWlr8F4nCpuyc662GJvY5gccOoHrL4Oe1i7BPQWcyTTZuFWKcGYaaQY4ntBlIxhJS3Lj
         yGdjN5GjsnqgruGyaveOD68PjhZY1gwFTOYfHaiS93qj86AGlk7tuWCPidi1RyRfmwyW
         UtoNWiDkic/OHFF0qC/xyZqwe7J/wsw7NIlNqe+gw4pbmONF3ZenW8E/IHye0hcLtSpx
         7nftTjn7RlYMKT5qfMqeNm55uLwfLq2KJ2lj8vxHd/+G0IZ0fIbT7PJCPjGiLKxYl6YL
         U6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=xvG8EkoppJSFqigSB69hRsruZ4tvURNxVZr5SRYMfV4=;
        fh=oEeoMWgXIgSwq8TDsNoGVJnt2S+dN1dEd2LOtjvfD1M=;
        b=CHtZeF2vel2Rf6R8JIKYHxe1h0Z9Wy8Ts3x1mM5YbltngrGhtKUrwdrPqyjZA6PVUP
         CNDLm/v1rqJrsXN8Z0OCOgvjTQZwJjE1wn4VtBGEClO4L1zcq9Ra9nO2Ymd2AJqZuP3n
         nn3BQBxgUjmBhk7XtyiiMblyu2tkncAtgzTRdXeugPVH3dPLTdadAaCly3Vn1SgM7voP
         tXBv3mBlWvi1HvcD2QYyExz5yNeD+5ASWxfS3bCgas5XRg9i+Slj5mzBCt2vErv/3WRX
         WQC0cXGEHFh0G6f6P5m+GQ6XtzZ1uI9OFvLy2DKI11jqLHc7xfCxYs8I84Kw3droA9GC
         gTTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771433622; x=1772038422; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xvG8EkoppJSFqigSB69hRsruZ4tvURNxVZr5SRYMfV4=;
        b=ebLIDNhGXU7Ck75r77ihItsK+pdo0zjlh3YqOfAbxCjPQDkKIdoA4Swi9OltCMxiLZ
         7Qxf2vsU3g22D6HqmxU9LWgxzoj5pDSY7xrm0nHwqJ0izcDxZCo0xGnNz/5Mh1L2Bzeq
         l4tne4ftJcpoSAB2SnQfh0Rm8jMDVxT5VeG5k1piGO3PVJEaEPHVnLL3ZHRx3XWglQPr
         EOlVZ5PFca0CgSPGufEqEwOoQmvaSi+D0MfOGvTty/NiW0S+6BAp4xQTcBYUy5CxQQoq
         ouuD7ELZYFJAAlzYUCBHzjk/xRWWPKj89geuXV9E9KSEwXv/NvlwMjN56MDv0mncpHwX
         hmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771433622; x=1772038422;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvG8EkoppJSFqigSB69hRsruZ4tvURNxVZr5SRYMfV4=;
        b=utFODZGDeniO6VMkw4m8WHTDapNm1gik6NCGSJQEBtgtFt3xptxe8XntJKeIGqfFvd
         8s+FFLP+LjINuhKKl8BbrRY0BzFpN5BIrmPY9YKgeuWpFaN6Q4NLg1zTXDLVgdgMSIOe
         32DMd6RqfAqF1w1Ls7aO/P2NfzUTCSb3C5PjdazaPemT05qNQx6Q890Qx1s1ZpAJe2+Y
         o1xxv8FJgi8UGNTdKKFXi1Lv0AY0pv8rB+2iLiC52JFOLNZoQ3xBkDTzwIDJtg+w3/RZ
         ZFwU4a8Ez5DhrBFk0sAtifK/g9rfjd1ACXQ9KE0N2UGjcz/qM4eE/Ae2d9Fqlh8vdQQ5
         8ZOw==
X-Gm-Message-State: AOJu0YzE+NJCX7v9DMbDDip/U9rc9Pd/YFGmoMO4GMFktMJbHMcKDdoN
	uRy6402i1RjYQtQEiB1u5fHcHgjc9UkvASoyz9nmTQfM48dpTtDQrF2UkVY6Zg9zHU3LYXm/aQ6
	obs+mGpDkJm9dRuo99ZPZ21fi7xxinIJBGQ==
X-Gm-Gg: AZuq6aKNfncaLR82H7/NFMws/QCpCWOOh/UPqb23BavmfbWsheoPR/IROIarjyJMFY4
	juK+VORISAIrUIMQ9urCV7/gixzthbgwIj6mN39cWbjG0cuBd8WrEb/OjsitdikeWdvjnyl/jdP
	cPDe5N3lM1H0jju6myqxHHrm0LbzYocuze6+aAelXwpLIwC5r9DRrwWM+cr/iJeEmuLidV7cAas
	T7gIzfoQGONbRlll+XlKVrqYph27Kj0JupCJcwV3UmCJva061k1ULgAbhUOCVPYGQznimi/Bj+Y
	aNeEH/4=
X-Received: by 2002:a05:6820:2906:b0:662:e066:73a1 with SMTP id
 006d021491bc7-6785bb6680cmr7685943eaf.57.1771433621536; Wed, 18 Feb 2026
 08:53:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217190630.19176-1-almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260217190630.19176-1-almaz.alexandrovich@paragon-software.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 18 Feb 2026 17:53:05 +0100
X-Gm-Features: AaiRm53mlLy345hnlV9B-BbxSP6_u1WFa04fVrul6o07J7U_NE0AnBbgAtp3MVA
Message-ID: <CALXu0Ufui+SPgpBz8pGOeZcB=RWDgjBChLiOHUqm3OGvy38h+A@mail.gmail.com>
Subject: Re: [GIT PULL] ntfs3: changes for 7.0
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77595-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricblancher@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paragon-software.com:email]
X-Rspamd-Queue-Id: 7B996157EDD
X-Rspamd-Action: no action

On Tue, 17 Feb 2026 at 20:07, Konstantin Komarov
<almaz.alexandrovich@paragon-software.com> wrote:
>
> Regards,
> Konstantin
>
> ----------------------------------------------------------------
> The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:
>
>   Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)
>
> are available in the Git repository at:
>
>   https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_7.0
>
> for you to fetch changes up to 10d7c95af043b45a85dc738c3271bf760ff3577e:
>
>   fs/ntfs3: add delayed-allocation (delalloc) support (2026-02-16 17:23:51 +0100)
>
> ----------------------------------------------------------------
> Changes for 7.0-rc1
>
> Added:
>         improve readahead for bitmap initialization and large directory scans
>         fsync files by syncing parent inodes
>         drop of preallocated clusters for sparse and compressed files
>         zero-fill folios beyond i_valid in ntfs_read_folio()
>         implement llseek SEEK_DATA/SEEK_HOLE by scanning data runs

Thank you for the sparse file support in NTFS3!

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

