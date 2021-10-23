Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECAF4383F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Oct 2021 16:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhJWObT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Oct 2021 10:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhJWObS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Oct 2021 10:31:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA77C061714;
        Sat, 23 Oct 2021 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/GpXbf5mv36tQwc/bTcJYuehy8KVgYrO7OXGBic3rVM=; b=WfeKEetaNauyIRfLFF7zoE+sHK
        1H4TQQkf2An5p+RXqSoPLo5BLKlbbnXCsIItwbd8NbTMgId+cUl0mSwcf3rYPUX8ZnK6ctn83nOV4
        bxoImy/LlrzcAk6TuixjAckaSkze/SVieW1iC9LHGKt/v90lNjxNPI3Q4R0DzHQSDPkmDsohsknFA
        Huxj5mX2ZPjY5F4zh0DMdAqn08uGogkUP23NUCP6H5OHeqdFUVFiOy+yKibozozmJKRWROEeuA5+X
        rKT3WKQD9VqZTbbJLIO119L4QqUsaFdgwlfU07M6vcE47TqsAjDeBtvLBbAimgeiEKfa2DZA/FS6x
        a8J4s35A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1meHzR-00EgNJ-Tf; Sat, 23 Oct 2021 14:27:37 +0000
Date:   Sat, 23 Oct 2021 15:27:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2][next] sysctl: Avoid open coded arithmetic in memory
 allocator functions
Message-ID: <YXQbxSSw9qan87cm@casper.infradead.org>
References: <20211023105414.7316-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211023105414.7316-1-len.baker@gmx.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 23, 2021 at 12:54:14PM +0200, Len Baker wrote:
> Changelog v1 -> v2
> - Remove the new_dir_size function and its use (Matthew Wilcox).

Why do you think the other functions are any different?  Please
provide reasoning.
