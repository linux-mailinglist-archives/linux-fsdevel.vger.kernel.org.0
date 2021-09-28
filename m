Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACC941A6FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 07:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbhI1FVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 01:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233290AbhI1FVs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 01:21:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C7AC611BD;
        Tue, 28 Sep 2021 05:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632806409;
        bh=2uKzvK51puF8Oln5IF2YPCjjVN+UTh5PJAVkJSe8xHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELgHhzP4h2m0fkP2fCsWa3kOw0bayp3BJ51OLRc7Ka+XnfLRtSLByu+zlYI4sGBnc
         m8NOUrhz4MCc+NmtT7INetbPW2fTRKuRQWcK0vUusW7NJVVmja96SefhVhtKQ39idJ
         oro8vrVxzJFgBV3TE6yc88q5URpXCuy6ULAl00u3qnKFTTJhXHJ1X3GQdsfJnv+m8R
         fOOI9xUb/qIY4kGUSPtehW5ImAzDYEr9R3XYYvTLAHvCdgPtRZiXyeeajAQPD0wnjz
         2l+oOSjraoG96LPkWE4ciDWEET/7iv5NqBkTVdTvMdyXXoj+7wtAHnCFZktSuHE9Mb
         6YHWQ+QGGvtdA==
Date:   Mon, 27 Sep 2021 22:20:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [regression] fs dax xfstests panic
Message-ID: <20210928052009.GB2706839@magnolia>
References: <20210927061747.rijhtovxafsot32z@xzhoux.usersys.redhat.com>
 <20210927115116.GB23909@lst.de>
 <20210927230259.GA2706839@magnolia>
 <20210928043426.GA28185@lst.de>
 <20210928051610.GI570642@magnolia>
 <20210928051700.GA28820@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928051700.GA28820@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 28, 2021 at 07:17:00AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 27, 2021 at 10:16:10PM -0700, Darrick J. Wong wrote:
> > > > My test machinse all hit this when writeback throttling is enabled, so
> > > > 
> > > > Tested-by: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Do you mean the series fixed it for you?
> > 
> > Yes.
> 
> Thanks!  I was just a little confused this came in in this thread.

Yeah, I was too incoherent after arguing on #xfs to be able to form
complete sentences, sorry about that.

Also thank you for fixing this problem. :)

--D
