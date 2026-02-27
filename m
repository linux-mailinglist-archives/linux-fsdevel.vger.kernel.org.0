Return-Path: <linux-fsdevel+bounces-78806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGnKCK8pomkO0gQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 00:33:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A47E21BF062
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 00:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BDD5308C5A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 23:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBC83A7F63;
	Fri, 27 Feb 2026 23:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dfinity.org header.i=@dfinity.org header.b="I7/+Z/r9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B272D47E9
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235178; cv=pass; b=t6eGIKxtzcln7dfeOe9lZvE/zdNqcYhwPbytAk5VzMPof2dhYkmlMph+DGbPwGLVIoIf+3LqQKE77sZFAaNt+qY62CNc0R2dpQf1CTXcYgERT4b5lFGVdssye3pV9Hr9KqCLfsHHdindZ+R3g1reKeuXc4Xv5P2lzy0QThcRYNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235178; c=relaxed/simple;
	bh=Jl6qVoawnojYxXKy+mpIEK2wzTG7xBRL73TA3AR7Rxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8hOUfbfllvZe/V01Ktr9Ci2j4GGlYU36LzRynGsujO65a1gBNfmSwkY4rSYRWluOMdkkV4wbY83CuwaY5EAXI9raNYaHcXP3L1rfkezOl0yDs2zoUnsikGk9zpr57NL5wN2yiJHiLBwRA9sBkptt1yDw7pjpEZyEtKk8md/E28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dfinity.org; spf=pass smtp.mailfrom=dfinity.org; dkim=pass (2048-bit key) header.d=dfinity.org header.i=@dfinity.org header.b=I7/+Z/r9; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dfinity.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dfinity.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65f767a8d62so4981777a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:32:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772235175; cv=none;
        d=google.com; s=arc-20240605;
        b=bRXk/mbAdYrOgp3Hz2KgSRoG0zQpdH05x1hLlfLoAb109rsWPTlj1VRRcyYS9QSKjn
         mE0f1d8XyXhCHwunNpgzgrD/Nw/4zk+MSQGYL2F3mXkT3V3BG7dyxAWFq7pB2HrVjyyQ
         HX/o19wHyjrakCLa22URqolMa68nWjb8Xq7VMzVN+DoohhdutM4bYdjdf42aD7QFC+4t
         GRuG2ZY35lMME0PsfHT6a2KP85MhMQlaNtR+NiLVRU52InSc6roxPekZCyzp40Nu0jPa
         Qx5fia3UUc7zNwzbKAYBT1nk9hWCYxAVm/9XuOzv7ac1Dky8NwIGPH9yLOs0cjjvlXB7
         W64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e/eLIE3ND8oKfgZ51wtjS+hjmkhRyVh6yadLObJYXaA=;
        fh=yiBS3+rmqE54izdSsCEWHkgh2aAUg37ZZOjNcDeYgSc=;
        b=Y9HBlm6hPFUXK3VghEUYAl4u4XN8mCI+o3uPL3YCB7Mhxq4UIlyzgoZLbyRuKc4kSo
         4kn8si5l3ZYMkX+coN4jc+PSwKea9NEiLcL6Da3Smgb0PjtpNbogaN6LyfNI75tVAAku
         OBKtrRHSdOG2oU6a0OlthoA1eaLmlO615+eNBxvjOEUhbzf2fjB3fQm9kNfYNm26OqY2
         JsYHd7tsnwhlj7f/WQzSDmJDifuBPr593r466v66moiRgo63aVjIIp/V5D6+e9vyisEk
         PzKVmblJFcnBHsmQ5tq0demQ4MPklVIihHKQ6Lz0Vcf95MbAhd0ZpZVeXQhuEVNz8nfi
         zrqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dfinity.org; s=google; t=1772235175; x=1772839975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/eLIE3ND8oKfgZ51wtjS+hjmkhRyVh6yadLObJYXaA=;
        b=I7/+Z/r9mVFbNBjZHTulZjaZ2ABzN0aHHRnNGwJQ2BTH1ts/k/nG9LKrXlmfZV2hmt
         pom403zx8ZwIUUj9Jd5PrFpf7wHVKEgiKjApi+f1G87gG2rmizsbJDJ0XqeL7TIfV1Cy
         cMWaMGLccpYWV9uBHPcg3r7p4mxEolUh09r13RSkbdjmDMU4HIyaSPB3zThyLgjtktT3
         fjZ/2tTiUpvj/lcvbepSnk9Ovo1d06syUUaYXzEtOBAEdWpa9W80Rd3D/G7L3pAc4m1w
         zyLO4X6CjXmSTAn/cpGM0bQS7QhGMwOl6GjWTqWXGHfSc8O+mnDON8dVi0eYjEavt/kX
         J1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772235175; x=1772839975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e/eLIE3ND8oKfgZ51wtjS+hjmkhRyVh6yadLObJYXaA=;
        b=BFiyw0XwNGuJhsRhFFlTuJlpHr7bnFGPx5FiTtjnHuDAaa3TH0VSofb/WYb3WprEm3
         T+PqqBSry43t8bO7E3sfwyEWSVGgSNXaMOKdsDzsjvHi7xxG7+V4sKR110XbPYx6lidG
         paNF9HENu65zDl3yxJp3m0/uLc3rnjbd83iOn42NfBFQaikmN2UrseawYDDYBlJTDQPH
         YYLQz1Npwm3GRbDiEW9t+Aeuj7uAFOPkOkrfxWvilAOCfpS0Os0cb8eYNWwnXaCinDaw
         vWwWsIxh+CBW4JrkXxSKqfzrVN3+OX1YjDo2i5KozTUjsEfixy2vssDAllwNMiiOkb6O
         ADhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJcD8mkwMUVaUvr2su0EG2rSXvqHFOpNEeJ/huHvmILBCjKuExryMc66XalqXFKCOcVN1vYQ4L32nA9Bki@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv69godRF5/YceyCwz5IC12GpwinVX4/QOeyGBdbxpWH+dJfPD
	X2If2SNkyIGPS/SNlkfrwUfl039YEeTBLo9Bex/uFrjeM575SxWqY/lBDvKhYFwm/GTp00B+N1G
	5vADNn+/pNsOlRhlK45yPkQ+NA3xrmU1vSCOzQBsseQ==
X-Gm-Gg: ATEYQzzQ+/2tTEF5m43kDY8Y50GwuXcrvwAsvF5WdGLjJvs0/B8M4XiErRY3Jz+dzqf
	lpcGXoANlMdlzZ+GG/0M8JZTCSdS54LBE6ajqxpkWdimIquqCCX5VNI9bo24UYTcyY7bRs8uZ8D
	TR8X2uDbGrpGV8/WOay6RhU5LnlzJQ3n2oH5ildcODRfB1zN9Ourj8wc9Af/ywMsjufqXmUmhF5
	llFC+VY8iIeyvykLf1cPFOZs3tScljnYKjfAJVSNKuYVDKerWFfHkJ374HyUX/3F8+zpBCvEBUj
	VFiBQQ/I7AkNOHRWQw==
X-Received: by 2002:a05:6402:3810:b0:65f:a47f:6e98 with SMTP id
 4fb4d7f45d1cf-65fddcf17a2mr2834242a12.27.1772235174690; Fri, 27 Feb 2026
 15:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com>
 <CB5EF1C4-6285-4EEC-ABD0-A8870E7241E8@nvidia.com> <D4BD80F5-6CA2-42E1-B826-92EACD77A3F3@nvidia.com>
 <CAKNNEtwZzt3xWh_b1pn4X4FG+cq6FLOP5rR4+G=WUsjHsJRjaA@mail.gmail.com> <2EECA9B4-E1F0-42FF-9E61-3E4AC4B4DC13@nvidia.com>
In-Reply-To: <2EECA9B4-E1F0-42FF-9E61-3E4AC4B4DC13@nvidia.com>
From: Bas van Dijk <bas@dfinity.org>
Date: Sat, 28 Feb 2026 00:32:43 +0100
X-Gm-Features: AaiRm52i5X9PI75r_CXw7oqvsR4nJ7O2YOcRO4y6Kt2G9VuPp0acJ2VcRalSCjk
Message-ID: <CAKNNEtziooemhq3Yb8OpOjg4N0bV+Kc+1in0P7L1i_NBWS-q=A@mail.gmail.com>
Subject: Re: [External Sender] [REGRESSION] madvise(MADV_REMOVE) corrupts
 pages in THP-backed MAP_SHARED memfd (bisected to 7460b470a131)
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, regressions@lists.linux.dev, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Eero Kelly <eero.kelly@dfinity.org>, 
	Andrew Battat <andrew.battat@dfinity.org>, 
	Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[dfinity.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[dfinity.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78806-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dfinity.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bas@dfinity.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A47E21BF062
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 8:29=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 26 Feb 2026, at 16:16, Bas van Dijk wrote:
>
> > On Thu, Feb 26, 2026 at 10:06=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On 26 Feb 2026, at 15:49, Zi Yan wrote:
> >>
> >>> On 26 Feb 2026, at 15:34, Bas van Dijk wrote:
> >>>
> >>>> #regzbot introduced: 7460b470a131f985a70302a322617121efdd7caa
> >>>>
> >>>> Hey folks,
> >>>>
> >>>> We discovered madvise(MADV_REMOVE) on a 4KiB range within a
> >>>> huge-page-backed MAP_SHARED memfd region corrupts nearby pages.
> >>>>
> >>>> Using the reproducible test in
> >>>> https://github.com/dfinity/thp-madv-remove-test this was bisected to=
 the
> >>>> first bad commit:
> >>>>
> >>>> commit 7460b470a131f985a70302a322617121efdd7caa
> >>>> Author: Zi Yan <ziy@nvidia.com>
> >>>> Date:   Fri Mar 7 12:40:00 2025 -0500
> >>>>
> >>>>     mm/truncate: use folio_split() in truncate operation
> >>>>
> >>>> v7.0-rc1 still has the regression.
> >>>>
> >>>> The repo mentioned above explains how to reproduce the regression an=
d
> >>>> contains the necessary logs of failed runs on 7460b470a131 and v7.0-=
rc1, as
> >>>> well as a successful run on its parent 4b94c18d1519.
> >>>
> >>> Thanks for the report. I will look into it.
> >>
> >> Can you also share your kernel config file? I just ran the reproducer =
and
> >> could not trigger the corruption.
> >
> > Sure, I just ran `nix build
> > .#linux_6_14_first_bad_7460b470a131.configfile -o kernel.config` which
> > produced:
> >
> > https://github.com/dfinity/thp-madv-remove-test/blob/master/kernel.conf=
ig
>
> Hi Bas,
>
> Can you try the patch below?

The test passes twice with the patch manually applied to the latest
master (4d349ee5c778). Thank you!

I had trouble applying the patch using `git am` to 7460b470a131 or
7.0-rc1 but this is the first time I've used `git am`, so I might have
done something wrong.

> I was able to use your app to reproduce the issue after change my shmem T=
HP config from never to always.

Yes I had to write "advise" to
/sys/kernel/mm/transparent_hugepage/shmem_enabled since it's set to
"never" by default in NixOS. See:
https://github.com/dfinity/thp-madv-remove-test/blob/d859609820113c69023848=
452bdba8b619d78a8a/flake.nix#L93

It would be great if the patch could be backported to 6.17 used in
Ubuntu 24.04 LTS since that's what we use for the Internet Computer
and where our tests first started crashing.

Cheers,

Bas

