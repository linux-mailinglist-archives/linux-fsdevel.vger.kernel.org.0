Return-Path: <linux-fsdevel+bounces-29116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A87B975910
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 19:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D65288DBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 17:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8251B1D6E;
	Wed, 11 Sep 2024 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udrGNI6Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73011A3044;
	Wed, 11 Sep 2024 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074636; cv=none; b=pKBM1syRHHf/1uSB22H968AE3bRh3ZZDtDIPlZK+91Q5rWHo9fryt5qdnxI4umCkvyw5piGCG26HzZf2yaMmS7F9Tn+/DPiIYWa56Pg8BVy90tIBdmCORpNE9H89nT4XOw8Y3jrrrnxbRKj0CPtigy8yGMytMki7ro08z1po/nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074636; c=relaxed/simple;
	bh=SkhXE9jgPDxjfW68U1P73gWmiiBBXp+cGoO3tCOf7a4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HoCawtO03SEShTgqPTJiJXYE0KqylrWJRgc5uI11bVtiswDS4meWt0+Tr3Rc2K7vK58EV5zqNk18I6fewK5ipwGA6vlNf27gX423RlQKu0bP1Y9UNWXZQ4GbCAExjSFFa8nwG1nK9y53OyUuLwRKW342inO5jKW73jMOqGqPlLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udrGNI6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67501C4CEC0;
	Wed, 11 Sep 2024 17:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726074635;
	bh=SkhXE9jgPDxjfW68U1P73gWmiiBBXp+cGoO3tCOf7a4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=udrGNI6ZJLn5ZxUvWLwXzAsMmzI++VJEkEnCuzUeHQCTlDdcZtoOIEYCieyNAVXTt
	 euchjYwqMbuGZKZfgyDKI3/6YweWpzkUMz9JvVWUAsdHiacIuBJSUSaFg9kikb/s9U
	 uouAG2QlUjS1/9XJQYTAYoYJl24KfnAbt1xT/CDaYakGfAfMrQOCvaEl5UIub61hj/
	 hHgndV5VbHyED2dI+Fn8+pY3Pw/A5MYGw5Zxi/Uibj6J3x96KZHKM+FK8Y5mEd5olG
	 NPIEFb3uv0672RdrZHJoNvKxEBzXJWggzSN1OASiZuTHMfrOa3u7WVTCRrJtFstYEo
	 C2Tte/3puhRSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4833806656;
	Wed, 11 Sep 2024 17:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 bpf-next 00/10] Harden and extend ELF build ID parsing
 logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172607463652.988612.1114853675517715254.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 17:10:36 +0000
References: <20240829174232.3133883-1-andrii@kernel.org>
In-Reply-To: <20240829174232.3133883-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
 adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
 ak@linux.intel.com, osandov@osandov.com, song@kernel.org, jannh@google.com,
 linux-fsdevel@vger.kernel.org, willy@infradead.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 29 Aug 2024 10:42:22 -0700 you wrote:
> The goal of this patch set is to extend existing ELF build ID parsing logic,
> currently mostly used by BPF subsystem, with support for working in sleepable
> mode in which memory faults are allowed and can be relied upon to fetch
> relevant parts of ELF file to find and fetch .note.gnu.build-id information.
> 
> This is useful and important for BPF subsystem itself, but also for
> PROCMAP_QUERY ioctl(), built atop of /proc/<pid>/maps functionality (see [0]),
> which makes use of the same build_id_parse() functionality. PROCMAP_QUERY is
> always called from sleepable user process context, so it doesn't have to
> suffer from current restrictions of build_id_parse() which are due to the NMI
> context assumption.
> 
> [...]

Here is the summary with links:
  - [v7,bpf-next,01/10] lib/buildid: harden build ID parsing logic
    https://git.kernel.org/bpf/bpf-next/c/905415ff3ffb
  - [v7,bpf-next,02/10] lib/buildid: add single folio-based file reader abstraction
    https://git.kernel.org/bpf/bpf-next/c/de3ec364c3c3
  - [v7,bpf-next,03/10] lib/buildid: take into account e_phoff when fetching program headers
    https://git.kernel.org/bpf/bpf-next/c/d4deb8242341
  - [v7,bpf-next,04/10] lib/buildid: remove single-page limit for PHDR search
    https://git.kernel.org/bpf/bpf-next/c/4e9d360c4cdf
  - [v7,bpf-next,05/10] lib/buildid: rename build_id_parse() into build_id_parse_nofault()
    https://git.kernel.org/bpf/bpf-next/c/45b8fc309654
  - [v7,bpf-next,06/10] lib/buildid: implement sleepable build_id_parse() API
    https://git.kernel.org/bpf/bpf-next/c/ad41251c290d
  - [v7,bpf-next,07/10] lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
    https://git.kernel.org/bpf/bpf-next/c/cdbb44f9a74f
  - [v7,bpf-next,08/10] bpf: decouple stack_map_get_build_id_offset() from perf_callchain_entry
    https://git.kernel.org/bpf/bpf-next/c/4f4c4fc0153f
  - [v7,bpf-next,09/10] bpf: wire up sleepable bpf_get_stack() and bpf_get_task_stack() helpers
    https://git.kernel.org/bpf/bpf-next/c/d4dd9775ec24
  - [v7,bpf-next,10/10] selftests/bpf: add build ID tests
    https://git.kernel.org/bpf/bpf-next/c/3c217a182018

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



