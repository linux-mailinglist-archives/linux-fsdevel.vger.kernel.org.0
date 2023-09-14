Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9707A0C0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 19:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbjINR5G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 13:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjINR5F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:57:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC961FF6;
        Thu, 14 Sep 2023 10:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UCSAnfDQZSe/uOw7DpXU/BcBg2LGDIRrSZJxohdLxgo=; b=mltWCpd4ixTs64AGjV2zp9HKuk
        VCAkIfKfTuJzh+AFfA9TgPdUW7EuHkfLcHjL0RNWyY8ZkECMLdrdPJjaPG8x9jlnMztZiWUZbNWAc
        dw6aBWQOTEueze9zspCWYCMnawb8LmPluyLl4Jogei0UJworXclbcOCgomZkue6vgf266lWFZYlMp
        ZMXw0BfIfzt9qXThwx6as+g1i4dOpyjjuv+FsmMnUzl9BZZ8Tb776B9u023bMHyZBX2MlUusgaT7q
        qbJ0onE29i8E9YpfFasTkjteJZFODJIEOq3Jfgadt+o2+hHNGgqYFFLpqcQyZEteWOUGEzn38JuZ+
        CHmiNnQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgqZv-004K1u-R4; Thu, 14 Sep 2023 17:56:36 +0000
Date:   Thu, 14 Sep 2023 18:56:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, david@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/3] userfaultfd: UFFDIO_REMAP: rmap preparation
Message-ID: <ZQNJU67eDoZqffEQ@casper.infradead.org>
References: <20230914152620.2743033-1-surenb@google.com>
 <20230914152620.2743033-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914152620.2743033-2-surenb@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 14, 2023 at 08:26:11AM -0700, Suren Baghdasaryan wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
> 
> As far as the rmap code is concerned, UFFDIO_REMAP only alters the
> page->mapping and page->index. It does it while holding the page

folio->mapping and folio->index.  It does it while holding the folio

No other objections ...
