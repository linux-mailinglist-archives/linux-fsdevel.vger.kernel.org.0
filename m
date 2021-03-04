Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E947332D2C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 13:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbhCDMVh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 07:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237383AbhCDMVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:21:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24452C061574;
        Thu,  4 Mar 2021 04:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=48o+7Ew2TEHGhvXnSGIxTpLjlrQRRnA22kMV8wVA6Xw=; b=hKdnZ3TF7fJIicyODRx49bYmzm
        Rq2kGOJGMYUS/xHuikVhIFGSVSlVjlpsYjmqSj2SxmVmyxfEMnd7zhmQ4xSwkasfyC96RwabICyJv
        9wniy/m0TSnUp7ZJtwM0HqhWOpN+LD3uggn5MngrkJFMrpcChnHLCJH3nqN/ch6pRCCdTKP3/7897
        kLneOM40LamBpBCKxkcriN8L7eXU0rcnWagzJoAk5ZR1hkhN2B+uGejvfdzMS3c42V2yGi35zo3XC
        Q1mXPKOkipbNVTn9EP8oRVWkt/b/A34EMn5Q4Ksgt+xzBkqUuuva2kP0m33b+fsfriAxbxoKN5k0x
        iSCRrasg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lHmvT-006ynq-Ex; Thu, 04 Mar 2021 12:18:06 +0000
Date:   Thu, 4 Mar 2021 12:17:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xattr: switch to vmemdup_user()
Message-ID: <20210304121755.GJ2723601@casper.infradead.org>
References: <1614666741-16796-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614666741-16796-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:32:21PM +0800, Yang Li wrote:
> Replace opencoded alloc and copy with vmemdup_user()
> 
> fixed the following coccicheck:
> ./fs/xattr.c:561:11-19: WARNING opportunity for vmemdup_user
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
