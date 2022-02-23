Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D934C0E73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 09:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbiBWIro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 03:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbiBWIrn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:47:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF8250B19
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 00:47:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFF1E61610
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 08:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B18C340E7;
        Wed, 23 Feb 2022 08:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645606036;
        bh=Y2CJkUrGZVX38H8IfdE2XnxMTPmEoM2IiK1EZvUkT7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVS4KwYLne0ZnGUVpSxiJF6qjLJ53lisSoxwTucoQMyR3IEeImkF29f01QL1mUV2/
         LV/8uIguTlo7vOjC73nIKW5ql5ZlabLcCZxCfGcY2+Tzd+eIOVA3My1igtWOiMlgL4
         myM6e0VQHu9K6N4DXg+fLC91qJPGXX4amER8JNUrtu8qlYyE8t6VsEDU9Om+XEN6pt
         5/3728hOJa1g6ODlbnqHohJcrwobat2mxBUmAZyOb80pFmJm3AXnfVdfDmHiYiInRL
         I/qUga1VTb0x2iB385NQcuFEsY6FXYfbe2Qh89yxHiRn29Zb4DA/RoTD542BsXd2LL
         NK1olT+WMTdLQ==
Date:   Wed, 23 Feb 2022 09:47:12 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/22] fs: Pass an iocb to generic_perform_write()
Message-ID: <20220223084712.rwqsemceotm6vqb4@wittgenstein>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-2-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 22, 2022 at 07:47:59PM +0000, Matthew Wilcox wrote:
> We can extract both the file pointer and the pos from the iocb.
> This simplifies each caller as well as allowing generic_perform_write()
> to see more of the iocb contents in the future.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Nice simplification,
Reviewed-by: Christian Brauner <brauner@kernel.org>
