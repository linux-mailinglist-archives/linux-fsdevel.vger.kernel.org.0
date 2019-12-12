Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C60411C9F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 10:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfLLJzf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 04:55:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbfLLJzf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eDIed+Zi+5UTjYPK4Ba5LwS+W5X2j//mWbmGXa+L2Fk=; b=mOV02aD9hNY6wre2zZRyh2idB
        Lv9rZtS2GcgcVn2hq3sClU7V63UF96AHZIQfmyvIlqxAu7CcKsD7sbMI/YCbCYqwtgA0riQoie29E
        PG7nyVDuvvGbzKoVYepEEYaFlyLdVpzoD5F76YdoWhlmtyPrWZLzN6l5CK1X/bDRGuWmrU+re39rM
        ukH4j7MXLue6jLkrgu3Cib/7YQwbMQOJ/jmHuhaoHa0wuyFgWO/RAkeJhx3eHeCaXCVhEL/bQAb4e
        8FoiS/awvumXM32M8p1+TFDOQBPX/KLqG/t/dp0mnHPlmxUhFtytjT/QXXWJBkf6DIXlqdV7RkoJp
        4E21ESQoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifLC1-0007uW-Kb; Thu, 12 Dec 2019 09:55:33 +0000
Date:   Thu, 12 Dec 2019 01:55:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH] iomap: Export iomap_page_create and
 iomap_set_range_uptodate
Message-ID: <20191212095533.GA23944@infradead.org>
References: <20191210102916.842-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210102916.842-1-agruenba@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At very least this needs to be a EXPORT_SYMBOL_GPL in sent in a series
with the actual user.  But I'm not all that happy about exporting such
low-level helpers.  Can't we come up with a useful higher level
primitive instead?
