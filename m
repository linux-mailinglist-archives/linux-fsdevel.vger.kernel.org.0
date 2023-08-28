Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F0F78BA7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 23:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjH1V5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 17:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjH1V4g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:56:36 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3732C186
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 14:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4//2ykhbmruhG0N2FUz+HFYJ3y4uvarKoSrJY30cP6M=; b=w3CRT+1Aqsrffm8uA0dH8LqHLy
        SoHLZx6QeRUnuM+PI95K9AJEW6QxuMN1RVlazEswcvstX1MAShrCDWisNiHDyrZBQZYZGTuxEzGXn
        FDb963Zi0RaW8tbkmuOgu1lz1jlqg4Fjqvvp78Hl17ou/s9cshnQMRf2hLBfOfKXEcOkfCGYaNr+z
        aPWvzyODGJ2vkMEqmVwPgnP+mAasjoeLcBSpFcEvjtdF5wlnNumc9OCPtJxsA+/t946eUFDYllV/c
        UOSdCmcc2kVaLm6ZsfajGGsJRSPQERaGn+Iw6D0QON6PbXgWE6jpJITtyz8Pxld4buqEW5DpDxVz/
        tv2m0u9A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qakDn-001fFm-03;
        Mon, 28 Aug 2023 21:56:31 +0000
Date:   Mon, 28 Aug 2023 22:56:30 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] remove call_{read,write}_iter() functions
Message-ID: <20230828215630.GA3390869@ZenIV>
References: <20230828151318.113478-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828151318.113478-1-mszeredi@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 28, 2023 at 05:13:18PM +0200, Miklos Szeredi wrote:
> These have no clear purpose.  This is effectively a revert of commit
> bb7462b6fd64 ("vfs: use helpers for calling f_op->{read,write}_iter()").
> 
> The patch was created with the help of a coccinelle script.
> 
> Fixes: bb7462b6fd64 ("vfs: use helpers for calling f_op->{read,write}_iter()")
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Grabbed (at the moment in #work.write_fixes - well, once it gets pushed out)
