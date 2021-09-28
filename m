Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC46E41A69F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 06:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhI1EgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 00:36:08 -0400
Received: from verein.lst.de ([213.95.11.211]:49991 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231785AbhI1EgI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 00:36:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 15E1067373; Tue, 28 Sep 2021 06:34:26 +0200 (CEST)
Date:   Tue, 28 Sep 2021 06:34:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Murphy Zhou <jencce.kernel@gmail.com>, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [regression] fs dax xfstests panic
Message-ID: <20210928043426.GA28185@lst.de>
References: <20210927061747.rijhtovxafsot32z@xzhoux.usersys.redhat.com> <20210927115116.GB23909@lst.de> <20210927230259.GA2706839@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927230259.GA2706839@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 04:02:59PM -0700, Darrick J. Wong wrote:
> > > Looping xfstests generic/108 or xfs/279 on mountpoints with fsdax
> > > enabled can lead to panic like this:
> > 
> > Does this still happen with this series:
> > 
> > https://lore.kernel.org/linux-block/20210922172222.2453343-1-hch@lst.de/T/#m8dc646a4dfc40f443227da6bb1c77d9daec524db
> > 
> > ?
> 
> My test machinse all hit this when writeback throttling is enabled, so
> 
> Tested-by: Darrick J. Wong <djwong@kernel.org>

Do you mean the series fixed it for you?
