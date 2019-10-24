Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43576E27CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 03:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405242AbfJXBl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 21:41:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfJXBl6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 21:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/RZyOplo4Vzg/tN89QSKqs0ssda+fjT7ejhMXK0g/cs=; b=VyDgkyd0sjoWJBuXVvMKEwSku
        iD261+iWHUyrB/0sBdl8D7lXQ+7OrCJMoFsrAq6SblmuTaKhvJT1mYaOBMqLpRqOZ32MEp6yxQZei
        xl+p42LUY2x0CHkz0fI8NE5AGyrKl4yrD2rpK8ozsRaJOHoR5NIjvfkb9wQrfDJNGxvPTIVBS7OJf
        UVA/VJj2anYkpuDnTKy94TGD33j/5Q0sieXafRKU5OhfjekyIL7KuknhUVgJPMwNY89VuDkR0cxUl
        bIsbKXcHKRvkfa3a8L4FWwdlunj3sc4/F9wHzObqnpdnbXxptvg2ByFXYkUiHQzk1BhSRbZ+lrLNL
        49JeBsbNQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNS8P-0005Zz-QN; Thu, 24 Oct 2019 01:41:53 +0000
Date:   Wed, 23 Oct 2019 18:41:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     mbobrowski@mbobrowski.org
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 05/12] iomap: Allow forcing of waiting for running DIO
 in iomap_dio_rw()
Message-ID: <20191024014153.GA14940@infradead.org>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <5dc3085af89a3e7c20db22e9e7012b4676b440a9.1571647179.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc3085af89a3e7c20db22e9e7012b4676b440a9.1571647179.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 08:18:18PM +1100, mbobrowski@mbobrowski.org wrote:
> This patch has already been posted through by Jan, but I've just
> included it within this patch series to mark that it's a clear
> dependency.

You probably want to resend the next iteration against the
iomap-for-next branch, which includes this plus an iomap_begin
API change.  Darrick plans to have it as a stable branch, so that it can
also be pulled into the ext4 tree.
