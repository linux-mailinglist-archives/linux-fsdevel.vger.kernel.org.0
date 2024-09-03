Return-Path: <linux-fsdevel+bounces-28445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AE696A542
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 19:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D781F256C1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE09F18DF7E;
	Tue,  3 Sep 2024 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYpH3V/M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EE96F315;
	Tue,  3 Sep 2024 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383833; cv=none; b=fYmah9bRkU0jbshqaXB4VNajmFe5ejOGlUwYimVuzZQG+K8D08Ee417aTFQUkwOWLi9jpYNsHE2mSij+OqGoAXhEbnVq78CoscV51lo9QlIOQbHXwDlelV2s0MebZocoayUeRAN0rbnJTEncDD74AQ5uH+HTZthJ5iiz/Pzp2wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383833; c=relaxed/simple;
	bh=fqmTGz8O7zkXIZo/mwtdtQWoFNMOlT/1uVo0v7jeQfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3Zymv3z2f5rB+R01VrNechMNWOXxvojBZK9rVQARKmj8iCFNKggAzij0T+XeQYxoVtkIMpDlwo+/9F6ByuY+yZOBTrm9xyFia0G5CKO5YMFh9OCx9jEGA1IhaVSdBeRAJqPBAwBSaR+YHJiA8WMEFF33ZWdN0In2HrABn7+q8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYpH3V/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704C7C4CEC4;
	Tue,  3 Sep 2024 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725383832;
	bh=fqmTGz8O7zkXIZo/mwtdtQWoFNMOlT/1uVo0v7jeQfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYpH3V/MFR5Jkqe8hCAQOprPhrvuE53hh4mycQBMYTL9usRUFqBhst9A9u5rmqejD
	 8e0uC6YsuB1VB4D0C5ttbp79llNj1JWYC5uGpasoleuPUtV039UOzmITDcjLwvXbaV
	 hcg483CQhhmdWccBL0C+odZTZ75guiLXVnwrR/aj47skDiqZ5aTgFnDaEhVY5meILP
	 k39JOrVB5KERg+eXtCDbPx0Ym5+BKxm0jbTUOGhkst3oSU/J5ImuVKwgOX1OJfiQ0F
	 5p6l9BxFXmNpPUJ4PEW7pYHM7+C7pdlzq+Rqu88s6fQoI/h/nZFU1Mm1SLy7flammT
	 Lh6zeZq5WP0dQ==
Date: Tue, 3 Sep 2024 10:17:10 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc6
Message-ID: <20240903171710.GA1164261@thelio-3990X>
References: <erydumpfxcjakfllmh3y4d7wtgwz7omkg44pyvpesoisolt44v@kfa4jcpo7i73>
 <CAMuHMdWknzcmc1DZ3HSB9qp4poaEO5_ViCESvQChuAaiOBdr7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWknzcmc1DZ3HSB9qp4poaEO5_ViCESvQChuAaiOBdr7Q@mail.gmail.com>

On Tue, Sep 03, 2024 at 03:53:56PM +0200, Geert Uytterhoeven wrote:
> Hi Kent,
> 
> Replying here, as there is (again) no patch email to reply to to report issues.
> 
> noreply@ellerman.id.au is reporting several build failures[1] in linux-next:
> 
>     fs/bcachefs/sb-members.c: In function ‘bch2_sb_member_alloc’:
>     fs/bcachefs/sb-members.c:503:2: error: a label can only be part of
> a statement and a declaration is not a statement
>       503 |  unsigned nr_devices = max_t(unsigned, dev_idx + 1,
> c->sb.nr_devices);
>           |  ^~~~~~~~
>     fs/bcachefs/sb-members.c:505:2: error: expected expression before ‘struct’
>       505 |  struct bch_sb_field_members_v2 *mi =
> bch2_sb_field_get(c->disk_sb.sb, members_v2);
>           |  ^~~~~~
> 
> Apparently this fails with gcc-10 and older, but builds with gcc-11
> and gcc-12.

Just noting this also happens with clang. Depending on the version, it
is either a hard error like this or a warning (that gets upgraded to an
error with CONFIG_WERROR).

Clang 15:

  fs/bcachefs/sb-members.c:503:2: error: expected expression
          unsigned nr_devices = max_t(unsigned, dev_idx + 1, c->sb.nr_devices);
          ^
  fs/bcachefs/sb-members.c:507:42: error: use of undeclared identifier 'nr_devices'
                                       le16_to_cpu(mi->member_bytes) * nr_devices, sizeof(u64));
                                                                       ^
  include/linux/math.h:37:22: note: expanded from macro 'DIV_ROUND_UP'
  #define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
                       ^
  fs/bcachefs/sb-members.c:513:30: error: use of undeclared identifier 'nr_devices'
          c->disk_sb.sb->nr_devices = nr_devices;
                                      ^

Clang 19:

  fs/bcachefs/sb-members.c:503:2: error: label followed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
    503 |         unsigned nr_devices = max_t(unsigned, dev_idx + 1, c->sb.nr_devices);
        |         ^

Cheers,
Nathan

