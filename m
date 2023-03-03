Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319506AA452
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 23:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjCCW3l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 17:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjCCW32 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:29:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436F86A06D;
        Fri,  3 Mar 2023 14:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ta8NbV6xh96XFRK6QkpcNvtsb8leATV9ZUMVK/pqiW4=; b=MN0nz4mv3XiN3vGUGBw9DHBLZz
        KgGZsmYGI4gJH98GtS7DF6I/ejfGDDijv/FOEdzfG0vnXdxK9qFr+mXYZlJxEIsb5qhf1Qqqpauo7
        QOVL1zMs/tNpXfeXKiCWbVtHV6Fl3yk9diWpt7mB5AkYIXNL87POBOz5bDqx3g5vaWXSRDoAhPzFG
        VV8WVJA0RHTpMSZ+iDUdol+nE6R+EtBvIIaEnvKlfONEX5kscP97pbSHbi+e89uZlO4lViTylh4Bs
        QaFu9XRdiHTi1BjidybX3zaOvW6SQmGokeI0Ie5ZyEVKzU5OFHwG5GCNvwrYq25hun5D7wCtblcZo
        E89cFSHw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYDms-007iaP-4c; Fri, 03 Mar 2023 22:22:02 +0000
Date:   Fri, 3 Mar 2023 14:22:02 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 00/17] MODULE_LICENSE removals, sixth tranche
Message-ID: <ZAJzCvTI67NgbJiY@bombadil.infradead.org>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302211759.30135-1-nick.alcock@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stupid question, if you're removing MODULE_LICENSE() than why keep the
other stupid MODULE_*() crap too? If its of no use, be gone!

  Luis
