Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF2601159BB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 00:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLFXn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 18:43:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfLFXn0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 18:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Bk39U4AprAV9W/n6oRzrf7ni+G23npbBzAJcX9fnbmk=; b=r2oULPifsD0T4HYqiXshebMWy
        XHDNVckZd4f9LTcL4dqzWyXIGH2uYwkx2JGllgnfFASKiJjQBB1L1nQkdUPgHK79pelMAoFgeZo+0
        NeeA1CPSaSkK2TLrtOq2QjEZRgkdMtYZk3Fr7X/NiOXVK5GNYnsQl6W3UTPu/tfzcVD7mst2Llt3y
        0H+OIFx+Sx60x5kSrIO8V0BlDp6eUxy//RI/TjeQcq3K7qa81HsVqpWyoN+V8ggd8n3aIND0zyX9R
        MFyfH1gvap2RBSs2IIIhTv6lzofIDjyrJlhICFxzfZbz/3a4yx2kjPgctDsQMUaCIIIbwIMok4nRt
        w4k8j+EDQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idNFm-0007Ul-CV; Fri, 06 Dec 2019 23:43:18 +0000
Date:   Fri, 6 Dec 2019 15:43:18 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, dhowells@redhat.com,
        matthewgarrett@google.com, jmorris@namei.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: Return -EPERM when locked down
Message-ID: <20191206234318.GA16467@bombadil.infradead.org>
References: <20191206225909.46721-1-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206225909.46721-1-eric.snowberg@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 06, 2019 at 05:59:09PM -0500, Eric Snowberg wrote:
> -static bool debugfs_is_locked_down(struct inode *inode,
> +static int debugfs_is_locked_down(struct inode *inode,

I might rename this function to debugfs_locked_down() to make it sound
less like it returns a boolean.

Other than that,

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

