Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028D85031BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Apr 2022 01:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356349AbiDOWh5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 18:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiDOWh4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 18:37:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37FAB8221;
        Fri, 15 Apr 2022 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PVyEZSQLSR1NaLXbDUnQkPyRRRCDx872THQc6EzVVu8=; b=COp+AaTKD8gkC8NmZZcEaYufBk
        Dk7ASQjGWH2fIw3M94VIh/ifoJU88e0puL2aCCl0Nv0NxrsL8pK1FYpeRe9F2aEW73O5wmoBoRaRs
        Sq/8u5TXneETEG9ei7+A4veRR61FIN4I4P+Bjqcw2QTNKwznzHOCH8BFRVBo/ziZsfdk3Csc18k2F
        zYCwtH/BdcBJIRYZncL8Ytl4jPLGbLrECTxkcImnOCu3awMd44XbVFmW6cvMuHLUWyD+mnTZtbd4u
        xRX7fqueAqK5YkS+LVkKh5rN3w5W1Mtntz5wdsTMCxyOuR+KwdKUaHq/2eKBiJCWAHKcuEIJUjtkr
        wkSL595Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfUX9-00BbNz-AK; Fri, 15 Apr 2022 22:35:19 +0000
Date:   Fri, 15 Apr 2022 15:35:19 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Meng Tang <tangmeng@uniontech.com>
Cc:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] fs/proc: Introduce list_for_each_table_entry for proc
 sysctl
Message-ID: <YlnzJxHPqc96rFE+@bombadil.infradead.org>
References: <20220411051205.6694-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411051205.6694-1-tangmeng@uniontech.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 11, 2022 at 01:12:05PM +0800, Meng Tang wrote:
> Use the list_for_each_table_entry macro to optimize the scenario
> of traverse ctl_table. This make the code neater and easier to
> understand.
> 
> Suggested-by: Davidlohr Bueso<dave@stgolabs.net>
> Signed-off-by: Meng Tang <tangmeng@uniontech.com>

Thanks! Queued onto sysctl-testing [0].

Feel free to let start sending in the rest of the stuff you were working
on. But please note I'll wait to push this to sysctl-next to get testing
under linux-next until this gets at least some compilation testing
without issues from sysctl-testing.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-testing

  Luis
