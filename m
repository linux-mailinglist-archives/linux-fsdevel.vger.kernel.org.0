Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D99D4EE519
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 02:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243297AbiDAAQB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 20:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiDAAP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:15:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F082B18F;
        Thu, 31 Mar 2022 17:14:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B89A617C0;
        Fri,  1 Apr 2022 00:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B039C340EE;
        Fri,  1 Apr 2022 00:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648772048;
        bh=cB2+tbosRq8L3yfmkv+WTUtuoBp4Gw8BBp4ppcta9sQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EwWbqYfwSEMoskMAQfRa2v3lOCi5W70ttitd4Pl5/DTnQy+JUWne05iUJmzHH76MA
         HUiDCvYAQ8qG448H3dJZYmLIh7knxWWYoPF0BLwvkv/ueWhVrxtuZQfosUGD8S4bxt
         zSDWCDDAStbchgcQaIBIDKwgfeOqmtEWKco/XjFU=
Date:   Thu, 31 Mar 2022 17:14:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, yangtiezhu@loongson.cn,
        amit.kachhap@arm.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 0/4] Convert vmcore to use an iov_iter
Message-Id: <20220331171407.0f7458c480e1c9406ca9337e@linux-foundation.org>
In-Reply-To: <YkW8d/HuXewjSuXs@casper.infradead.org>
References: <20220318093706.161534-1-bhe@redhat.com>
        <YkWPrWOe1hlfqGdy@MiWiFi-R3L-srv>
        <YkW8d/HuXewjSuXs@casper.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 31 Mar 2022 15:36:39 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Thu, Mar 31, 2022 at 07:25:33PM +0800, Baoquan He wrote:
> > Hi Andrew,
> > 
> > On 03/18/22 at 05:37pm, Baoquan He wrote:
> > > Copy the description of v3 cover letter from Willy:
> > 
> > Could you pick this series into your tree? I reviewed the patches 1~3
> > and tested the whole patchset, no issue found.
> 
> ... I'd fold patch 4 into patch 1,

I think so too, please.  The addition then removal of a
read_from_oldmem() implementation is a bit odd.

> but yes, Andrew, please take these patches.

And against current -linus please.  There have been some changes since
then (rcu stuff).

