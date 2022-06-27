Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AEB55C1B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiF0HEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 03:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbiF0HEn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:04:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42875273D;
        Mon, 27 Jun 2022 00:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=glQQdrWI1pE97+BrtfWxRqj88uSRGIIFBYFFDbcQBcI=; b=gD3RB5+kJx6ipyfqWYr1CKSprJ
        y+z5+b6nRrFJhnG4uYhlvJKN4HYQ16b5o2VcQZNruY7Pf3wcpd2jH6a9zjS8c529IeuEh18TkESLs
        OawKrkVcZ+XBRFMdAhKNnL/E/8tyA7ue6k8GAnhzmo7oUq0IfZYp5blQXfFtLcTR7bJ3kOaAaqAEN
        2RViX9oc3HlnDvY3Y1Jgs8nTkkVF/vi2qu+d4jcm5HemZza3TYbbkU4QzhxPlOr8TEBPNZlTa7DgL
        Q1SPazKBpp5jUmJn6jOW8idx1BkB11CMataKjswKHKawBwRsukWHdjKUK2P6cCBUrTXCxC/z0VMKO
        qEsD1oow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o5ina-00GIqH-Ps; Mon, 27 Jun 2022 07:04:42 +0000
Date:   Mon, 27 Jun 2022 00:04:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 0/5] Add bpf_getxattr
Message-ID: <YrlWirdsnlw30D64@infradead.org>
References: <20220624045636.3668195-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624045636.3668195-1-kpsingh@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This needs to have a proper discussin on linux-fsdevel.  Please
resend the whole there.  Adding the lsm list in addition would not be
bad idea either.
