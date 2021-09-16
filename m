Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B72B40EAC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 21:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhIPT2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 15:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhIPT2Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:28:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DF9B610E9;
        Thu, 16 Sep 2021 19:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1631820413;
        bh=cj4YYql3ialFH5a3FIsQKbEh3n2waZxbKmXBYlo5ynk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wdf67NTnj8bDQNSnGOX2sXk1GF2gDGSOttrakL9aAa7bg20ZWrn1C5mEpcQd9Vw1r
         K14k1JMqcRv2/wJBiXdHtKJ6WEM8L6rNW8lcAaoV0/6Z5nLmt5E/tjLUeErUhnajMU
         Rm7FKOONV0I+tiPRTX5DNzKLBHBEXAYdfQ8Q5QwQ=
Date:   Thu, 16 Sep 2021 12:26:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Subject: Re: [MAINTAINER SUMMIT] Folios as a potential Kernel/Maintainers
 Summit topic?
Message-Id: <20210916122652.b6ab789e968263eb4ab31626@linux-foundation.org>
In-Reply-To: <YUOX0VxkO+/1kT7u@mit.edu>
References: <YUIwgGzBqX6ZiGgk@mit.edu>
        <f7b70227bac9a684320068b362d28fcade6b65b9.camel@HansenPartnership.com>
        <YUI5bk/94yHPZIqJ@mit.edu>
        <17242A0C-3613-41BB-84E4-2617A182216E@fb.com>
        <f066615c0e2c6fe990fa5c19dd1c17d649bcb03a.camel@HansenPartnership.com>
        <E655F510-14EB-4F40-BCF8-C5266C07443F@fb.com>
        <33a2000f56d51284e2df0cfcd704e93977684b59.camel@HansenPartnership.com>
        <YUOX0VxkO+/1kT7u@mit.edu>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 16 Sep 2021 15:15:29 -0400 "Theodore Ts'o" <tytso@mit.edu> wrote:

> What typically happens is if someone were to try to play games like
> this inside, say, the Networking subsystem, past a certain point,
> David Miller will just take the patch series, ignoring people who have
> NACK's down if they can't be justified.  The difference is that even
> though Andrew Morton (the titular maintainer for all of Memory
> Management, per the MAINTAINERS file), Andrew seems to have a much
> lighter touch on how the mm subsystem is run.

I do the Dave thing sometimes.  We aren't at that point with folios
though.  The discussions and objections and approvals are all
substantial and things are still playing out.
