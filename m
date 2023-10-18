Return-Path: <linux-fsdevel+bounces-670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38747CE1B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF91281E23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 15:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CF03B79E;
	Wed, 18 Oct 2023 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708AB31A86
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 15:52:29 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F39A111;
	Wed, 18 Oct 2023 08:52:25 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 652F067373; Wed, 18 Oct 2023 17:52:20 +0200 (CEST)
Date: Wed, 18 Oct 2023 17:52:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jan Stancek <jstancek@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, djwong@kernel.org, willy@infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] iomap: fix short copy in iomap_write_iter()
Message-ID: <20231018155220.GA26845@lst.de>
References: <8762e91a210f4cc5713fce05fe5906c18513bd0a.1697617238.git.jstancek@redhat.com> <20231018122220.GB10751@lst.de> <CAASaF6xHTv6iZd5ttHOJ_M=hpjaGZOnUCGSHkbGy_yLbe2G8nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAASaF6xHTv6iZd5ttHOJ_M=hpjaGZOnUCGSHkbGy_yLbe2G8nw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 04:32:19PM +0200, Jan Stancek wrote:
> On Wed, Oct 18, 2023 at 2:22 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Oct 18, 2023 at 10:24:20AM +0200, Jan Stancek wrote:
> > > Make next iteration retry with amount of bytes we managed to copy.
> >
> > The observation and logic fix look good.  But I wonder if simply
> > using a goto instead of the extra variable would be a tad cleaner?
> > Something like this?
> 
> Looks good to me. Would you be OK if I re-posted it as v2 with your
> Signed-off-by added?

Please skip my signoff.  This is really your work and I just a very
cosmetic suggestion.


