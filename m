Return-Path: <linux-fsdevel+bounces-34616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8749C6C6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A955281E3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7FE1FB8A3;
	Wed, 13 Nov 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0ExhXRQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A351FAC48;
	Wed, 13 Nov 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492621; cv=none; b=N0rZQpH3db7W+HcAavqmseorzb8R7BuyRaAF5n3q7923vnAL79U491mUtl/dDSxhrjpxenl2cGR9WOttqQCBitB6mlNpVs+pdoF4Nnp+SkGGcCuo/RxYfErRDepZ7XskdcXkYJVDceYWSLQZmwCEWuoVU2eV/4OF37XaTBWNzzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492621; c=relaxed/simple;
	bh=uRkZHq++6vvJc5c1lt0G40BH0cQ9qm5OLQOSpRTY2cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbLWBi1STJnRY8B+6Yv8Nq7Uh/mDNAHoPrgAJCWHNex57zmemEkAoRn7MShGqGTkBvupIbm3P7l72kUT0FR99XlKv+ZzHYC4VY/ZLL7OHbJyziYPXw+4EVzAx9FvaAg/hinKaTxDIlhxhvgNIo3B5ZvfmLJCNZxZD/52MTtdRqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0ExhXRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B77AC4CECD;
	Wed, 13 Nov 2024 10:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731492620;
	bh=uRkZHq++6vvJc5c1lt0G40BH0cQ9qm5OLQOSpRTY2cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G0ExhXRQ/syQ4PB/dKESinm7LkjILOZhKeguEcVdKtVYhqvPX6SOXiuw5TQ4K9PmE
	 dtC8t5vryTXqu6MOlf0Ox6ksmC5mCMWj+HtGNyhEaYRoBtCqF7t7WSW3nF4UDpIWQk
	 ax0z+9VAo6ktn2LhxB1W4LntvwfAQ2geTsc90p9Mfd509bxPJ9ATePu1I0XU2lRrxX
	 LQ2z1bPGZCwyIVpVxtwb6z3oTQb6Zr2Woa1kmgE76DNT2jiAkY0sj7hQk62f97pk1e
	 Uxs17lXHY7WuNVQwkFnrHEHsEQA4ozV8Gx5t7TXRRY1+Yv+JF4yJmc31YLQunXfjyb
	 gHGDOKYVDbxgA==
Date: Wed, 13 Nov 2024 11:10:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission
 events
Message-ID: <20241113-beraten-ausformuliert-a2ddcc576d64@brauner>
References: <cover.1731433903.git.josef@toxicpanda.com>
 <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>

On Tue, Nov 12, 2024 at 03:48:10PM -0800, Linus Torvalds wrote:
> On Tue, 12 Nov 2024 at 15:06, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > I am fine not optimizing out the legacy FS_ACCESS_PERM event
> > and just making sure not to add new bad code, if that is what you prefer
> > and I also am fine with using two FMODE_ flags if that is prefered.
> 
> So iirc we do have a handful of FMODE flags left. Not many, but I do
> think a new one would be fine.

I freed up five bits and commented which bits are available in
include/linux/fs.h.

