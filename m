Return-Path: <linux-fsdevel+bounces-77037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDxTIdQOjmmS+wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:33:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1963C12FF60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DF1D303EFE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 17:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422A521D3F2;
	Thu, 12 Feb 2026 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="UZTVNTcp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6403820299B
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917556; cv=pass; b=rusAYxJOYUII8Uk2ZUGd3JkKoP+bi3gE5WhiK1m62p0XfYGVzRSF7JHezLu+yQd2Zgtm2o3k+pr5iJrxua32GY9syFwYRG/h7V4EQSNM+RHrvw0qx2VGJ7Zd6tOIKFCcJrdyV4Nswt0GnDC3o/KlqndCw1lEMz9IxCkJxV0yEzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917556; c=relaxed/simple;
	bh=jA3vKtvIe29yuhDoNQ+3kLGUSzJYS7igXV3C81VNVcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oq1sH+4HN1H0oBs/UweyTqJw5fMT7j5ruD1PrRjtA0UTbAMM6sJ0gKzp07V9FziE99Ewn4bjlPmKowVjfyd1N1djOYAOSYHaDwBP86u4obeWMPlPE4z9eQMIgWL5SZJf3i8oHEl6x7kg3mrB6OfOWANivQKAhimDj2FxXwzvSUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=UZTVNTcp; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b4520f6b32so111282eec.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 09:32:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770917554; cv=none;
        d=google.com; s=arc-20240605;
        b=dyZbZo9TCMKjz3VSnmDFCd9nloyEjSLtpzYWBR3QmQuuRy3XwLa7UJpmkriQDSqgyK
         l7n7Qcf+lrz62t+yQDU3KyH4uPg5CjeePgwRearYBCzIjupD2SUJhq76FeyDcparigfX
         BG4bgSR9j4ms50E8H0Tqs/Hf041nQx2hRy9a68hIbWcKguNjyxolkUD/H12YllCac2j1
         sM2JuaPVExB5HxdNmYiTEox7EeJ/YWmuBC2po1XJ6ze/qS0gHZbKmyDL2RYTmsue1rcD
         z8zNDzABUIUKo313c6FLcHRBpD5rX55JQuX7ZOnQAcyn6Brgbq+pfFyuQXnaNMJvj9sN
         auSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g4+TDkRhQp/+yy4ZBpH7qG5m9hlxN2cdFm2kx5yzMr0=;
        fh=blKc9ajCF9wpgHB+PzKcKzM4bt+j2xFU2XGGXxDCrf8=;
        b=fgA9QG1H3TVejlnPZlhgnRKYZ3nYpQNV8eb8HgvKdw41OPo0KMrUmE00Dz+GYK5/f6
         97MNMF0+cNjRgJrx0v1a21qOLb69cI8r7s+NCldR9ni6SZX8QbSWtjiEuyP9qrwJAbDZ
         zpxIzIxjJigF6vojJwWrZco1XU0qy/b8owKyIm59XWOeWU41CFIRxkzPogelHHVtQJ/2
         IDxMMZAWljNKvY4vtdn1921SjqVp8RxSdaA9lSrqerLI+Sjcq7w9ZBAFg2WcWR/IMMiF
         B7RFRVy40Zl4VSGH+vkz8owTzF7G6Ih1b7/JqtbxXQg3TUd3tSoF47P7Bc8jc72xlyho
         Svvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1770917554; x=1771522354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4+TDkRhQp/+yy4ZBpH7qG5m9hlxN2cdFm2kx5yzMr0=;
        b=UZTVNTcpRUbmaROh8WT1+tvdTMq1UDX8sZNRsen2hcgRxffzrewEpwu8TPXiM8etqr
         ju4MsJwpEfm5U/rslVYX97pDlN9NiXt81qIMjJtW5ldQlMIiEd+eKYYfQln1tYwoCqf2
         OGFSlZlFTHP6HNH1G4y3jQvrHW2ZiNzGvGTSqXvVzNejUxruiwDuu8hpw+3DUasMNFrZ
         o8YwmhxEONFTEcnq45ZOhFp2PYD+So9UjTZvZxwn/x4pXYooTUOfcSaslSh/X5IIaLkK
         QYQpZiUbDiBuf1ya3cPIMcTJAJjMfmZ0S3xisgrP0lFW5UW6zmfoiY9lkBOafXUn94Yw
         0Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770917554; x=1771522354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g4+TDkRhQp/+yy4ZBpH7qG5m9hlxN2cdFm2kx5yzMr0=;
        b=E8N0HOP7zfLTVIW5EW0TLqVhWKh39C0zGCwHJ+N6z08TsQG+9qUGF26Pn22Ur+uHvN
         /HMiExZdSBpwAwHUqASMcG6bYpep3AxSxHbgfHwWBpCq7sXnaa3SjSheA2lO0uooFUXd
         QcVuBXRpYAQXxSAjQafv3RLV1z2AkcrQtHUq7v8Nmo8O1LJKhWTns3t5p9Fs9ysHY1iX
         hkVnmSuoMmkNjVj0Npvk0QMOb0dVeTRP0r/2vau6vnnmC4SW9L46QrahaBwivzaJHLmp
         D7FsHTbnYIQiaUZ8CT0y/o+sXmiKhc6IyMi8P5i/e+/H65FJpAGlBshG3+G+LdTJGLCJ
         ASBw==
X-Forwarded-Encrypted: i=1; AJvYcCU0Qt5thfZ4VXRyqHpygJMAjg8nIHcexIUSc2/aBiBsMJcVA3Wu0qSIxFE8IQt+LHrTDXxxCrt+/Xj3NI8Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxgxERTwBLwRGwYT1AHOio8gwXj8dEerEaPJ6IbrtBNz/Gbh+vv
	IalB672t2gO69en/VTGe22t9leD43Qa/awIarKrvjRw1IgrgQvTK5rlDANteB8AwFplxcBrXM2o
	7GnIPiQAIFDwR1XnyudfGIceHW1Z/aMwCMsm8BUM/cw==
X-Gm-Gg: AZuq6aJiAhcredOZernwlzvfVRwh3645mRCGyFamLQfUkPPIj61a/RXSs4fZF+bb1h5
	z2j4oDGPH6lSGm38gpEQV9HUDnPV6cI1rPVLhefQMBbi3UNSvlRuuUCl6EtOEZoaAF04fkyCxG9
	Rkb4QpS+IBXVZxW6nJVeXuZ662OQu/r1mC7ZjJZ/X7P8uv/tD3/aiE2NOII1lGdHToHJNICINFK
	DUzzZI4by6FhDvnLXTQYR/Ofre8yyuUKONvXSqUidgBY8u69D2KEghIEx+dzl9ADLP98kB2wEIV
	miA4cro09BVF/gFrfIwabAq1o43CAtqRLCSSnhht
X-Received: by 2002:a05:7300:1907:b0:2ba:a3f2:958c with SMTP id
 5a478bee46e88-2baac4769bfmr959743eec.0.1770917554125; Thu, 12 Feb 2026
 09:32:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b9f6cd20-8f0f-48d6-9819-e0c915206a3f@wdc.com> <bcedbc03-c307-4de5-9973-94237f05cd85@wdc.com>
In-Reply-To: <bcedbc03-c307-4de5-9973-94237f05cd85@wdc.com>
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 12 Feb 2026 12:32:23 -0500
X-Gm-Features: AZwV_QhtervBLrhaMDFvDL7B82oTUlgUvlheHmYhHPJvAZHpalsxUWo4I8SLua4
Message-ID: <CAEzrpqd_-V691dQzVF1WmrvLNXnDR0THuxGCieDMZcWdRN5WEQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] A common project for file system performance testing
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, hch <hch@lst.de>, 
	Naohiro Aota <Naohiro.Aota@wdc.com>, "jack@suse.com" <jack@suse.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[toxicpanda.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[toxicpanda.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77037-lists,linux-fsdevel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josef@toxicpanda.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[toxicpanda.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,toxicpanda.com:dkim]
X-Rspamd-Queue-Id: 1963C12FF60
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 11:42=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 2/12/26 2:42 PM, Hans Holmberg wrote:
> > Hi all,
> >
> > I'd like to propose a topic on file system benchmarking:
> >
> > Can we establish a common project(like xfstests, blktests) for
> > measuring file system performance? The idea is to share a common base
> > containing peer-reviewed workloads and scripts to run these, collect an=
d
> > store results.
> >
> > Benchmarking is hard hard hard, let's share the burden!
>
> Definitely I'm all in!
>
> > A shared project would remove the need for everyone to cook up their
> > own frameworks and help define a set of workloads that the community
> > cares about.
> >
> > Myself, I want to ensure that any optimizations I work on:
> >
> > 1) Do not introduce regressions in performance elsewhere before I
> >     submit patches
> > 2) Can be reliably reproduced, verified, and regression=E2=80=91tested =
by the
> >     community
> >
> > The focus, I think, would first be on synthetic workloads (e.g. fio)
> > but it could expanded to running application and database workloads
> > (e.g. RocksDB).
> >
> > The fsperf[1] project is a python-based implementation for file system
> > benchmarking that we can use as a base for the discussion.
> > There are probably others out there as well.
> >
> > [1] https://github.com/josefbacik/fsperf
>
> I was about to mention Josef's fsperf project. We also used to have some
> sort of a dashboard for fsperf results for BTRFS, but that vanished
> together with Josef.
>
> A common dashboard with per workload statistics for different
> filesystems would be a great thing to have, but for that to work, we'd
> need different hardware and probably the vendors of said hardware to buy
> in into it.
>
> For developers it would be a benefit to see eventual regressions and
> overall weak points, for users it would be a nice tool to see what FS to
> pick for what workload.
>
> BUT someone has to do the job setting everything up and maintaining it.
>

I'm still here, the dashboard disappeared because the drives died, and
although the history is interesting it didn't seem like we were using
it much. The A/B testing part of fsperf still is being used regularly
as far as I can tell.

But yeah maintaining a dashboard is always the hardest part, because
it means setting up a website somewhere and a way to sync the pages.
What I had for fsperf was quite janky, basically I'd run it every
night, generate the new report pages, and scp them to the VPS I had.
With Claude we could probably come up with a better way to do this
quickly, since I'm clearly not a web developer. That being said we
still have to have someplace to put it, and have some sort of hardware
that runs stuff consistently.

I think A/B testing just makes more sense in the general use case.
Trends are interesting, but nobody pays attention to them. Thanks,

Josef

