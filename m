Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CBE41A6F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 07:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhI1FRu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 01:17:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234148AbhI1FRt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 01:17:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1B4E61153;
        Tue, 28 Sep 2021 05:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632806170;
        bh=WmxPPV62KaG2zFfOZV1wHgC3rJsSCIy35+4cNxHrtXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ioo5noKryLD7apNBqMA6BJJ5GbV5Y7AirwSLR13zpfKEqI4/2bOSpQ9tAHNRFiKxm
         GXGkI4frJm3sq3KnUjdRE4zJBjVDTtvG4nrzWN7Te58KvnrT5/3gqzeAtsKHHVF36D
         neffue/lEOjLOS054QUqGyyNuUS3u+IfYaZtgwqG/UHBZ3EmBx27NivoLQMLxJ0mdm
         CRwWPRXNv21X7Oa5DD3hYsmkEI9cxZHdE5skCHHc8EXw30OkXbefuE1jMR3kyshy2U
         yzHxCZkIC5NahYTigi6bJSBy9U5RfE0Kesx61X5ZUWashvUyU3YnkGvT/HpNUXXGaG
         sLcXHRKSMhT5A==
Date:   Mon, 27 Sep 2021 22:16:10 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [regression] fs dax xfstests panic
Message-ID: <20210928051610.GI570642@magnolia>
References: <20210927061747.rijhtovxafsot32z@xzhoux.usersys.redhat.com>
 <20210927115116.GB23909@lst.de>
 <20210927230259.GA2706839@magnolia>
 <20210928043426.GA28185@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928043426.GA28185@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 28, 2021 at 06:34:26AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 27, 2021 at 04:02:59PM -0700, Darrick J. Wong wrote:
> > > > Looping xfstests generic/108 or xfs/279 on mountpoints with fsdax
> > > > enabled can lead to panic like this:
> > > 
> > > Does this still happen with this series:
> > > 
> > > https://lore.kernel.org/linux-block/20210922172222.2453343-1-hch@lst.de/T/#m8dc646a4dfc40f443227da6bb1c77d9daec524db
> > > 
> > > ?
> > 
> > My test machinse all hit this when writeback throttling is enabled, so
> > 
> > Tested-by: Darrick J. Wong <djwong@kernel.org>
> 
> Do you mean the series fixed it for you?

Yes.

--D
