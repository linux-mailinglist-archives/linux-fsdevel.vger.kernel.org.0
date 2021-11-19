Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AAD456A79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 07:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhKSG6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 01:58:03 -0500
Received: from verein.lst.de ([213.95.11.211]:50036 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229922AbhKSG6C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 01:58:02 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BAD8C68AFE; Fri, 19 Nov 2021 07:54:57 +0100 (CET)
Date:   Fri, 19 Nov 2021 07:54:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 02/29] dm: make the DAX support dependend on
 CONFIG_FS_DAX
Message-ID: <20211119065457.GA15524@lst.de>
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-3-hch@lst.de> <CAPcyv4iPOcD8OsimpSZMnbTEsGZKj-GqSY=cWC0tPvoVs6DE1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iPOcD8OsimpSZMnbTEsGZKj-GqSY=cWC0tPvoVs6DE1Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 09:23:44AM -0800, Dan Williams wrote:
> Applied, fixed the spelling of 'dependent' in the subject and picked
> up Mike's Ack from the previous send:
> 
> https://lore.kernel.org/r/YYASBVuorCedsnRL@redhat.com
> 
> Christoph, any particular reason you did not pick up the tags from the
> last posting?

I thought I did, but apparently I've missed some.
