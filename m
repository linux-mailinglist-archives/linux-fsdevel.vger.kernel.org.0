Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A08A4CEB2E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 12:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiCFLeO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Mar 2022 06:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiCFLeM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 06:34:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129DB642F;
        Sun,  6 Mar 2022 03:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nK6fc9sC8NZv7QaEVaxxTpIxTZq/SzNUDta5FD5I7jI=; b=h03YOdnltrDeha98gsHK8dkXur
        5WoXXbWj9PkQijgsFCid6H+5zSNuEWh5HeK1YhrMBrHf+71kA/oDixn2BUGWhQsYkcLEKl1EEFFAb
        yT27l+88Uc53FamnyVQeFQ/bdxrd4LcHjhphvkOuaSq+T2tznDtehp/m5HjPS2RFVECxEnIcR0mSb
        Jo/KP09BOhKIMryYd6TEejD8yn3IQ1txvcT7jyWhJqioiy2SYyfZRKLtxU4yFQvD36B10yUCdvd1L
        9+3zCnbLTPK2vsrUZhhqP2vVnO/FL6CZa9CI3XROhMMLD5U1DxF3iXCMbbV4oPLok2eUuDa75j9Ip
        CbR6J1Iw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQp8I-00EIzX-Hf; Sun, 06 Mar 2022 11:33:02 +0000
Date:   Sun, 6 Mar 2022 11:33:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        zhangyiru <zhangyiru3@huawei.com>,
        Alexey Gladkov <legion@kernel.org>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        linux-mips@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, codalist@coda.cs.cmu.edu,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] MAP_POPULATE for device memory
Message-ID: <YiSb7tsUEBRGS+HA@casper.infradead.org>
References: <20220306053211.135762-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220306053211.135762-1-jarkko@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 06, 2022 at 07:32:04AM +0200, Jarkko Sakkinen wrote:
> For device memory (aka VM_IO | VM_PFNMAP) MAP_POPULATE does nothing. Allow
> to use that for initializing the device memory by providing a new callback
> f_ops->populate() for the purpose.

As I said, NAK.
