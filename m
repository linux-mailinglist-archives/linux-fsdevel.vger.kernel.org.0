Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF29E11419B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 14:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfLENib (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 08:38:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbfLENib (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/zOhhsj0TF+2vJvyTuHdzp88oWZoS4k2GnHbq6L+gbQ=; b=WQ8Vdx+rYdfNKgHBZlpZyQEvg
        dNca2+MGoqL1J/cqdzWS1Iy8NU0rFag2GarJnG+2yjff7htStPVDfKNfFdHMFHbb913qyCkvh2Xv1
        5RB/o5sF918KgmAdOB+MVPse+TiqvW+lelx2xzUVeTeD/GRVn6mRV7373sHzp1eSKPH56Fb5unb+B
        Q4sDVZqEQMFuWA5wc+/Ihm0N9RKbaMi3ztB9OpyrmSkA+kXJutuL18ro74O4FAEwYiu/F1LJINJ1h
        QCconcly/Ku4jLN0cic7bifTVe2TdrxxFV/R3RKslMRsWfHsztZU+D1S9WY2Dh/66GC38AeqpeCGS
        Sqgum2peQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icrKw-00015o-Gj; Thu, 05 Dec 2019 13:38:30 +0000
Date:   Thu, 5 Dec 2019 05:38:30 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, jlayton@kernel.org,
        viro@zeniv.linux.org.uk, ceph-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        devel@lists.orangefs.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 1/1] fs: Use inode_lock/unlock class of provided APIs in
 filesystems
Message-ID: <20191205133830.GB29612@bombadil.infradead.org>
References: <20191205103902.23618-1-riteshh@linux.ibm.com>
 <20191205103902.23618-2-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205103902.23618-2-riteshh@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 04:09:02PM +0530, Ritesh Harjani wrote:
> This defines 4 more APIs which some of the filesystem needs
> and reduces the direct use of i_rwsem in filesystem drivers.
> Instead those are replaced with inode_lock/unlock_** APIs.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
