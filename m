Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DDC1CB3DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 17:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgEHPrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 11:47:01 -0400
Received: from verein.lst.de ([213.95.11.211]:53307 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgEHPrB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 11:47:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A988C68C7B; Fri,  8 May 2020 17:46:58 +0200 (CEST)
Date:   Fri, 8 May 2020 17:46:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 10/11] fs: remove __vfs_read
Message-ID: <20200508154658.GA4200@lst.de>
References: <20200508092222.2097-1-hch@lst.de> <20200508092222.2097-11-hch@lst.de> <20200508154552.GB1431382@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508154552.GB1431382@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 08, 2020 at 08:45:53AM -0700, Ira Weiny wrote:
> On Fri, May 08, 2020 at 11:22:21AM +0200, Christoph Hellwig wrote:
> > Fold it into the two callers.
> 
> In 5.7-rc4, it looks like __vfs_read() is called from
> security/integrity/iint.c
> 
> Was that removed somewhere prior to this patch?

[PATCH 08/11] integrity/ima: switch to using __kernel_read
