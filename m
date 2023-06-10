Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A0672A6FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 02:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjFJAWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 20:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjFJAWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 20:22:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E317E19BB;
        Fri,  9 Jun 2023 17:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=HZvL0AVSKR7jJKndT6J3KioN2BGrycG/XhYHqz3bYec=; b=M6n17cdFh94bT5xy9wq13Tp++S
        ukuZPpcYNni11peN4ClYCLcJJff98KTuzsW19AaE2yvT6/8QspesVQdXqWw22/d6H7CyTwXKrKnRN
        /wo4IuJoeCztNzeMnJGFkVaTpl3ZGmKiEpSe6OLnM/NwQP1fhVUHhzarPtb6q61ZZIV85BK1Hzx97
        y7vW8TSon9XNJ7J5L2c3Go7foU7ZK9arvzKdtNFF3Voqm6aTuFXrdBXO4t0pFYwrSePOAfIqzInsZ
        VI3WTMSK5Tb4z4prXJ1IMU5OCyzJY9JsdxPq9o4fCQJHrAI3gZ2zyNrk5hjLeiDYkAk+UxiqxKinj
        QoDPvgCA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q7mMc-00HHo0-KZ; Sat, 10 Jun 2023 00:21:54 +0000
Date:   Sat, 10 Jun 2023 01:21:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei-chin Tsai =?utf-8?B?KOiUoee2reaZiSk=?= 
        <Wei-chin.Tsai@mediatek.com>
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mel Lee =?utf-8?B?KOadjuWlh+mMmik=?= <Mel.Lee@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        Ivan Tseng =?utf-8?B?KOabvuW/l+i7kik=?= 
        <ivan.tseng@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 1/1] memory: export symbols for process memory related
 functions
Message-ID: <ZIPCIpWPQbVqoI4q@casper.infradead.org>
References: <20230609110902.13799-1-Wei-chin.Tsai@mediatek.com>
 <ZIMK9QV5+ce69Shr@shell.armlinux.org.uk>
 <5cc76704214673cf03376d9f10f61325b9ed323f.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cc76704214673cf03376d9f10f61325b9ed323f.camel@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 04:09:01PM +0000, Wei-chin Tsai (蔡維晉) wrote:
> > You haven't included any users of these new exports, so the initial
> > reaction is going to be negative - please include the users of these
> > new symbols in your patch set.
> We use these two export functions from our kernel module to get a
> specific user process's memory information and heap usage. Furthermore,
> we can use such information to detect the memory leak issues. 
> 
> The example code is as follows:

No.  You need to be submitting the code that will use the symbol *at the
same time* as the patch to export the symbol.  No example code showing
how it could be used.  Because if the user isn't compelling, the patch
to export the symbol won't be applied either.
