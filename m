Return-Path: <linux-fsdevel+bounces-5092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78347807FA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 05:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6921C2082B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 04:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE72212B6E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 04:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cee1Opee"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26612110;
	Wed,  6 Dec 2023 19:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ikyQNDZSs7x392fCLkxFtZ8cjqbTuYZcw0JdF/jOx7Q=; b=cee1OpeemiJOyTxllx1VHwGK5e
	gmWahVa18cIhmTsUgG64nYuTzCmSPxOJvru3ApiVKKGcg67Mtz3q5aTSbzS/4Un+LjGjUng7u+iLY
	5PwKROUYBZ4p9SA3TGUQK+skkWDdO2xCsmZbDhsDLX73TSTEOdy7/083iPTO4WEvJtOPXXuU8ZXwm
	fdC25rldwh5Ug9yeRrINMkPFoJpA+mKmiu3+KSQypdhyKl757SbbFYnzj7eOENNFRdqAfLPrxKWeY
	PYQs8e+3J0bkxANfUcogshBBc4+XLdsC1t2RNjFi2cAIt9jHKvaptc/nEQoDM+B2SyjPPEsoaRx7t
	CjsSE29g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rB4r3-0083zj-0A;
	Thu, 07 Dec 2023 03:15:13 +0000
Date: Thu, 7 Dec 2023 03:15:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-cachefs@redhat.com, dhowells@redhat.com, gfs2@lists.linux.dev,
	dm-devel@lists.linux.dev, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] hash-bl: explicitly initialise hash-bl heads
Message-ID: <20231207031513.GX1674809@ZenIV>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-10-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206060629.2827226-10-david@fromorbit.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 06, 2023 at 05:05:38PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Because we are going to change how the structure is laid out to
> support RTPREEMPT and LOCKDEP, just assuming that the hash table is
> allocated as zeroed memory is no longer sufficient to initialise
> a hash-bl table.

static inline void init_bl_hash(struct hlist_bl *table, int shift)?

