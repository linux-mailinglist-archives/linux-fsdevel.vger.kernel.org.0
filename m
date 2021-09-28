Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8492D41A6FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 07:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhI1FSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 01:18:42 -0400
Received: from verein.lst.de ([213.95.11.211]:50067 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233681AbhI1FSm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 01:18:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 14DF367373; Tue, 28 Sep 2021 07:17:01 +0200 (CEST)
Date:   Tue, 28 Sep 2021 07:17:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Murphy Zhou <jencce.kernel@gmail.com>, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [regression] fs dax xfstests panic
Message-ID: <20210928051700.GA28820@lst.de>
References: <20210927061747.rijhtovxafsot32z@xzhoux.usersys.redhat.com> <20210927115116.GB23909@lst.de> <20210927230259.GA2706839@magnolia> <20210928043426.GA28185@lst.de> <20210928051610.GI570642@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928051610.GI570642@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 10:16:10PM -0700, Darrick J. Wong wrote:
> > > My test machinse all hit this when writeback throttling is enabled, so
> > > 
> > > Tested-by: Darrick J. Wong <djwong@kernel.org>
> > 
> > Do you mean the series fixed it for you?
> 
> Yes.

Thanks!  I was just a little confused this came in in this thread.
