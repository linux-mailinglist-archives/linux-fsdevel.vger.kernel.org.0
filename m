Return-Path: <linux-fsdevel+bounces-195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E277C7540
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 19:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4DC61C210AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 17:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077D437147;
	Thu, 12 Oct 2023 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u05oCMn+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7230F9D
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 17:56:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5ACB8;
	Thu, 12 Oct 2023 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=sgLQgFGbhBa3OWMLEXQ5AgPAbvhy379YNkqJpx9j8Ig=; b=u05oCMn+HurfCZPIECBMmQyZKB
	JAKo7BJeKKkMi+JefRlAvhCt8AFE9smjdYSL0ZWekUep5gWu2FYgD3mEttz+FLNh8vFeWpdLT4kuy
	1o4eP0wQ7gHQWL5vAHeYiZ5nU+LD+L2OcKRzyDB3SIgtM2PjNp9+gjPaa1v5jy1XmbazQqRqo8tBH
	iPehbvDHwHoLgkhGWlE0tgOBBgMBf4Vlr1NKlVQNPa6FNiCYH3ZroZwznDOQNFX/uq1FIR0KNgv5R
	aO3UMY7Cmt407L3zgpyjkGMnZ9z+oPpKXEWXp1cegdhI+j5fIGuE8gShnFXGXaaqOqUKGANvz8zGW
	Ieqiyh2Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qqzv6-001ZBt-1H;
	Thu, 12 Oct 2023 17:56:24 +0000
Date: Thu, 12 Oct 2023 10:56:24 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-mm@kvack.org,
	Hannes Reinecke <hare@suse.de>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>, mcgrof@kernel.org
Subject: Large Block Sizes update and monthly sync ups
Message-ID: <ZSgzSPAF8VpC9PPD@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Folks working on LBS met up at this year's ALPSS 2023 conference and
we have started to put effort to merge our efforts together so that the
next patch iteration is done in coordination as a group effort. The first
order of work is to merge the minorder stuff on the page cache with its
respective huge set of testing requirements. In parallel other work can go.
There has been enough interest in this topic, so to this end top help sync
with folks we're going to be putting together a monthly sync up where we can
review progress, blockers, questions, and next steps before we post the next
patch series.

The first sync up will take place on Halloween October 31st 2023 at
5pm CEST / 8 am PST. If you're in Asia we apologize in advance, but
given at least one person's expressed interest in that region in the
future we could pivot the next meeting to acomodate that time zone and
then alternatate every other month so we all suffer equally.

This sync up will take place over zoom, if you'd like to attend please
let me know and I'll add you to the calendar invite.

  Luis

