Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BDB340858
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 16:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhCRPBQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 11:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhCRPBO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:01:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168BAC06174A;
        Thu, 18 Mar 2021 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Iyxf77OheM5kOtD9NZGaWVVCS/e7cjWJKX/KPPKvDZM=; b=iVn4BEnf+7dhmNcnn8eWvqcKoC
        naBc9zq6WZo93JEKSucRhYMbsNQRO9d9/Nupd0e9OBTDLhM9S5J9vJWDNWHBRgJi7vynqLcev8kYq
        LeJwSoCS/PFvWiPxvsZX1Hin3HtKIKGk50dZU68FnjS7nS7qOQ2eHSTIVLi9xJx072okAbJy47VBV
        r1L3DbDp47pqT6htykDdXwMeWgt70nuQFs9xzm9D8aSdqd/JzK7tdmZafCvuDs4oLksQOo30pN1LK
        IUYyuhZE4Bf/9TFQOfjLuQRlkHoWYbHghmH7Es7PXYY3R+Pwvx/4NiZzua3jQFDGm6BPaMPgLSU+j
        0/wQdgUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMu8K-0036sK-SN; Thu, 18 Mar 2021 15:00:35 +0000
Date:   Thu, 18 Mar 2021 15:00:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Xiaofeng Cao <cxfcosmos@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: Re: [PATCH] fs/dcache: fix typos and sentence disorder
Message-ID: <20210318150020.GP3420@casper.infradead.org>
References: <20210318143153.13455-1-caoxiaofeng@yulong.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318143153.13455-1-caoxiaofeng@yulong.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:31:53PM +0800, Xiaofeng Cao wrote:
> change 'sould' to 'should'
> change 'colocated' to 'collocated'

uh.  collocated is incorrect.  colocated is correct.
https://www.merriam-webster.com/dictionary/colocate
https://www.merriam-webster.com/dictionary/collocate

The other changes are correct.
