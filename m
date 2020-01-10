Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99DB7136D14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 13:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgAJMbd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 07:31:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgAJMbc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 07:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B/rKaa819gyayiC8Xe2hoNfVxDFo4LjZMb+oCIBCt4A=; b=Mj1/cHpyNqAgv/lVJOV/TP+Zj
        egd1NiWTg95WnXdO8GzEGGiVWXwRU3H+E29g0uVUBnxj9ZG7x0fcYtVBTI//wNlkf+KsAOmx7axTf
        Gc8pv2zZYaPxRunSGtLY4RuN7jj+dSV2b5+aIhFylnGPxBelgs3smecSXa7E34ZnQngJ7W/2xA+1a
        NUzhU4twKo0iuaHP3wTcsVoqDE18tS5u72bzSdI5+qJSI+AHD+3TO72VAqUy9Zy0Y5FPdZH5P/N9h
        2KFuCwQdTla2L7GluHlni2Ux9OYIM+JCNP3jqnY6GtykRDI9mopYWyIA8zDezasfGBpIUQ8Ce3CYo
        VZkuzcBug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iptRn-0003UC-1r; Fri, 10 Jan 2020 12:31:27 +0000
Date:   Fri, 10 Jan 2020 04:31:27 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-nvdimm@lists.01.org, dan.j.williams@intel.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: dax: Get rid of fs_dax_get_by_host() helper
Message-ID: <20200110123127.GA6558@infradead.org>
References: <20200106181117.GA16248@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106181117.GA16248@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 06, 2020 at 01:11:17PM -0500, Vivek Goyal wrote:
> Looks like nobody is using fs_dax_get_by_host() except fs_dax_get_by_bdev()
> and it can easily use dax_get_by_host() instead.
> 
> IIUC, fs_dax_get_by_host() was only introduced so that one could compile
> with CONFIG_FS_DAX=n and CONFIG_DAX=m. fs_dax_get_by_bdev() achieves
> the same purpose and hence it looks like fs_dax_get_by_host() is not
> needed anymore.
>  
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
