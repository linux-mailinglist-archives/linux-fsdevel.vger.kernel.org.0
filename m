Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A36F82B20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 07:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbfHFFj5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 01:39:57 -0400
Received: from verein.lst.de ([213.95.11.211]:53279 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfHFFj5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:39:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 85C9868B05; Tue,  6 Aug 2019 07:39:54 +0200 (CEST)
Date:   Tue, 6 Aug 2019 07:39:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] fs: Move start and length fiemap fields into
 fiemap_extent_info
Message-ID: <20190806053954.GI13409@lst.de>
References: <20190731141245.7230-1-cmaiolino@redhat.com> <20190731141245.7230-6-cmaiolino@redhat.com> <20190731232837.GZ1561054@magnolia> <20190802095115.bjz6ejbouif3wkbt@pegasus.maiolino.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802095115.bjz6ejbouif3wkbt@pegasus.maiolino.io>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 11:51:16AM +0200, Carlos Maiolino wrote:
> Christoph, may I keep your reviewed tag by updating the comments as above?
> Otherwise I'll just remove your tag

Feel free to keep them for any trivial changes.  Indentation changes and
adding comments always qualify as trivial.
