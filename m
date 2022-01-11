Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FE548B5C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 19:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbiAKSfl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 13:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345424AbiAKSfi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:35:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085A1C061756
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jan 2022 10:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QfG/4XpAZ7+n8ggkrvmn9jr/l6cignYZy2B7mch2nnU=; b=C5A7y8agG14XwbgJ3b95fi+Fll
        1MwrafS+sCk/XKs7ID6JGZ7WZJgnAf2AwQHEapJuXD9c2Ug9RNFPjfhOufA3X7d6C2heH7e3QLlQT
        JrvMknJmYaettv+NyDbj3gL9DKQLYJnL4Vc/uXLGvVnnu3JCbO4lkQA2yh61EsDzZwbmfCoX8rmWW
        2ysY0ScYc6rEqCtie+sPdmKOfrR/bzeW5KeNtDcAH8WpBH6d+Qg+xKeQ2ln/74QRl9MFzbuc5VlA9
        eRZLov9c14JWpfDZIJ3BO+KoT/ASdcAi396kMlEifMBIQxludOUoPfe0x3vHKBuzGeVfphJOIRS1c
        hZ+cgz+w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7Lzb-00HHDw-Kx; Tue, 11 Jan 2022 18:35:35 +0000
Date:   Tue, 11 Jan 2022 10:35:35 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     cgel.zte@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux] sysctl: Remove redundant ret assignment
Message-ID: <Yd3N97I1Z9/uYcib@bombadil.infradead.org>
References: <20211230063622.586360-1-luo.penghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230063622.586360-1-luo.penghao@zte.com.cn>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 30, 2021 at 06:36:22AM +0000, cgel.zte@gmail.com wrote:
> From: luo penghao <luo.penghao@zte.com.cn>
> 
> Subsequent if judgments will assign new values to ret, so the
> statement here should be deleted
> 
> The clang_analyzer complains as follows:
> 
> fs/proc/proc_sysctl.c:
> 
> Value stored to 'ret' is never read
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: luo penghao <luo.penghao@zte.com.cn>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
