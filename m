Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5D34F04C9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 18:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357896AbiDBQT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Apr 2022 12:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiDBQTZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:19:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102D514866A;
        Sat,  2 Apr 2022 09:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JINKbqhOzJGOEsZNaR/VHXOnA2Rg4duv9P14QYv3WG0=; b=EWjokUVlhn2V99hAQ3xR0mH/KM
        q3bFC7P6giYJXUD1dDMrC+iSfKLCM20bGHp0lYh2x0r5rhsLEznoKjxsrukDKHQY1bIUCb7jQXqie
        8vBSZ35+W7vez0smEPXfJdadZ4BM15YMYpp67RPDTDu6D2IM1q+kNyOK6aWe7ClFHFTSfhUHlrGYE
        NGlsc5mf/TWE2+3pKzY+UWDNYax23Zq/QTMlHHlusAHHX5coejg+vp2bIqUJVHonaxy6iI4f1Ca51
        A3jzUVOJ84WRhNSmGLr9+STlFlLEooSlSfo4MHHwZFmg44x1v9mH1v6/wZQniZxmb+wgSmRAUolQy
        FY/Rv3Jw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nagRJ-004Dbq-C6; Sat, 02 Apr 2022 16:17:25 +0000
Date:   Sat, 2 Apr 2022 17:17:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, yangtiezhu@loongson.cn,
        amit.kachhap@arm.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 1/3] vmcore: Convert copy_oldmem_page() to take an
 iov_iter
Message-ID: <Ykh3FVUFQH0x11Zw@casper.infradead.org>
References: <20220402043008.458679-1-bhe@redhat.com>
 <20220402043008.458679-2-bhe@redhat.com>
 <YkffO7QHuR2vq3gI@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkffO7QHuR2vq3gI@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 02, 2022 at 01:29:31PM +0800, Baoquan He wrote:
> On 04/02/22 at 12:30pm, Baoquan He wrote:
> 
> It's odd. I cann't see the content of patches in this series from my
> mailbox and mail client, but I can see them in lore.kernel.org.

Yes, Red Hat have screwed up their email server again.  David Hildenbrand
already filed a ticket, but you should too so they don't think it's
just him.

https://lore.kernel.org/linux-mm/6696fb21-090c-37c6-77a7-79423cc9c703@redhat.com/

> https://lore.kernel.org/all/20220402043008.458679-1-bhe@redhat.com/T/#u
> 
