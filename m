Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6392212D9A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 16:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfLaPOR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 10:14:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaPOQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 10:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=39W0H9Zs3OcFaRg2cR06jIcqUU5fmmJTqF6aDqyS3lg=; b=dxWv+wR5WfWjjFXNTFxek69Ah
        9pbYkPxY/I442fPZ4NARKNFT74KQk0aHBVZH5gHbcO4ERc6j0oFRuO+a3TRAG0zxfCHfobnh73gvR
        /Nl+9MpCs+PoesnZlA5lk1Zro4QHzcrNJGu1KAhWwKlaMnPPZbGOa8rNp9eZZ5HLdLLXjPsZ+Y17p
        BRuunX+Rre7pTD+Q/TsJ4P4ctFYlJpiyP4mzseXYnHertf62fpwrz/kQUbzMSKedDceMXo+Ed7pln
        9bCG3cxGWAB872GwKSQK+Np0zzDGduLPVHYwhMT0BpCxlS952djmW2pLA591KfMgR94iTw4zLu/nf
        te6HBk/Fg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1imJDr-0007P3-DZ; Tue, 31 Dec 2019 15:14:15 +0000
Date:   Tue, 31 Dec 2019 07:14:15 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v8 00/13] add the latest exfat driver
Message-ID: <20191231151415.GE6788@bombadil.infradead.org>
References: <CGME20191220062731epcas1p475b8da9288b08c87e474a0c4e88ce219@epcas1p4.samsung.com>
 <20191220062419.23516-1-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220062419.23516-1-namjae.jeon@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 20, 2019 at 01:24:06AM -0500, Namjae Jeon wrote:
> This adds the latest Samsung exfat driver to fs/exfat. This is an
> implementation of the Microsoft exFAT specification. Previous versions
> of this shipped with millions of Android phones, and a random previous
> snaphot has been merged in drivers/staging/.

Can one run xfstests against this filesystem?  Or does it require
other tools, eg mkfs.exfat?
