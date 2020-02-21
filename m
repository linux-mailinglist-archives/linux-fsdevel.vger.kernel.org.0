Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A963316835D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 17:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgBUQ3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 11:29:55 -0500
Received: from verein.lst.de ([213.95.11.211]:56324 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgBUQ3z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:29:55 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CD39968BFE; Fri, 21 Feb 2020 17:29:52 +0100 (CET)
Date:   Fri, 21 Feb 2020 17:29:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs: remove the kuid/kgid conversion wrappers
Message-ID: <20200221162952.GA9938@lst.de>
References: <20200218210020.40846-1-hch@lst.de> <20200218210020.40846-4-hch@lst.de> <20200221012616.GF9506@magnolia> <20200221155450.GA9228@lst.de> <20200221161943.GY9506@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221161943.GY9506@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 08:19:43AM -0800, Darrick J. Wong wrote:
> Ok, we were doing it wrong.  Should this series have fixed that as the
> first patch (so that we could push it into old kernels) followed by the
> actual icdinode field removal?

Maybe I could squeeze that in after patch 1.  Before that we'd get weird
mismatch, which is how I arrived at the current series.

> (Granted nobody seems to have complained...)

Right now the use case seems entirely theoretical, but there are multiple
series out on fsdevel that aim to change that.
