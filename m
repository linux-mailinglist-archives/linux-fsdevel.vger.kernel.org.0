Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD2BC1C8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 10:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfI3IKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 04:10:17 -0400
Received: from verein.lst.de ([213.95.11.211]:35253 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfI3IKQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:10:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A94AC68C4E; Mon, 30 Sep 2019 10:10:12 +0200 (CEST)
Date:   Mon, 30 Sep 2019 10:10:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/9 V6] New ->fiemap infrastructure and ->bmap removal
Message-ID: <20190930081011.GA6601@lst.de>
References: <20190911134315.27380-1-cmaiolino@redhat.com> <20190927085909.fexdzlrmsf6wdj4p@pegasus.maiolino.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927085909.fexdzlrmsf6wdj4p@pegasus.maiolino.io>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 27, 2019 at 10:59:10AM +0200, Carlos Maiolino wrote:
> On Wed, Sep 11, 2019 at 03:43:06PM +0200, Carlos Maiolino wrote:
> 
> Hi Folks.
> 
> Is there anything else needed here to get a review on the remaining patches?

Well, we'll need to sort out the don't allow bmap on the rtdev problem
somehow.
