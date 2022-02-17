Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D294B9A2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 08:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbiBQHx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 02:53:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbiBQHx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:53:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AE0184639;
        Wed, 16 Feb 2022 23:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j3r7Sjy2s/K4ZABbnDEoBuac9NC82bvfdRC+YKUKQe4=; b=h+AQsWVCUUGjY2kStTlIVl9afN
        6GA6M7563AQ+BVffl31GhaKxA3X7iuULO30vtcqjim8Kw3o03w2CyP214ODVuSn91s+P9OjOKQfaa
        vrSwGDYoOys3MJh6XPJ2j2bEUSH9bMylpDsVtRnAOfaVxKzREwKz7eOvpnygMs9yuzO28O1hBjBPA
        lGiemGg4AEJN6tmvA2ClM2eKKMoDVYlm7Uij7vq8coxP7WnkDiIKkU6iQ+RaHVln9jjHheHobYIeT
        OxLrlnbrXkcMUw70ijgaDU0JVR25z6nPxqL5iJgwNImDaDOvpTQCATnCn9X1GFqFu+7xUqEEA+7w/
        hQIUI87Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKbbc-009HMh-NI; Thu, 17 Feb 2022 07:53:36 +0000
Date:   Wed, 16 Feb 2022 23:53:36 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tangmeng <tangmeng@uniontech.com>, Zhen Ni <nizhen@uniontech.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, peterz@infradead.org
Cc:     keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] kernel/reboot: move reboot sysctls to its own file
Message-ID: <Yg3/AByca1X4EJHo@bombadil.infradead.org>
References: <20220217042321.10291-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217042321.10291-1-tangmeng@uniontech.com>
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

On Thu, Feb 17, 2022 at 12:23:21PM +0800, tangmeng wrote:
> kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
> dishes, this makes it very difficult to maintain.
> 
> To help with this maintenance let's start by moving sysctls to places
> where they actually belong.  The proc sysctl maintainers do not want to
> know what sysctl knobs you wish to add for your own piece of code, we
> just care about the core logic.
> 
> All filesystem syctls now get reviewed by fs folks. This commit
> follows the commit of fs, move the poweroff_cmd and ctrl-alt-del
> sysctls to its own file, kernel/reboot.c.
> 
> Signed-off-by: tangmeng <tangmeng@uniontech.com>

Queued onto sysctl-next [0]. This tree is intended to queue up all of
the sysctl changes, get them tested.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next

  Luis
