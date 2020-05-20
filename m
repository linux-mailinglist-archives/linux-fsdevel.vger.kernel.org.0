Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C361DB8E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 17:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgETP7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 11:59:43 -0400
Received: from verein.lst.de ([213.95.11.211]:50490 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgETP7n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 11:59:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EB05F68BEB; Wed, 20 May 2020 17:59:40 +0200 (CEST)
Date:   Wed, 20 May 2020 17:59:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: clean up kernel_{read,write} & friends v2
Message-ID: <20200520155940.GA4313@lst.de>
References: <20200513065656.2110441-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513065656.2110441-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping?

On Wed, May 13, 2020 at 08:56:42AM +0200, Christoph Hellwig wrote:
> Hi Al,
> 
> this series fixes a few issues and cleans up the helpers that read from
> or write to kernel space buffers, and ensures that we don't change the
> address limit if we are using the ->read_iter and ->write_iter methods
> that don't need the changed address limit.
> 
> Changes since v1:
>  - __kernel_write must not take sb_writers
>  - unexported __kernel_write
---end quoted text---
