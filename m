Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55676B34E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 04:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCJDoQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 22:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjCJDoP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:44:15 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49142E6D96;
        Thu,  9 Mar 2023 19:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bVXg3/N0udKCRyKcsw/ty2s14jHV9mY2+I33imZcLao=; b=vUKPxgJ5uqxNJjdH0hJnYDyhha
        QwQdRmnMCgcMqHCQzq4FmWkg3VYymlYNC7ykzdJezJppbejaYvl4f63dNzgWmdILzBQiqYCwQgXRQ
        aUAuyqur+dMhLJxXI2MlLo3HsqAFLwidxmssrtpGGb0wMG2B50ibu5LkV3raH6N5XwzIaFyq312xK
        Px5vsgSpOCjZleK0yQZbAEqcOGBo/kUKUN2rEf67qhGgvGgmjhn2Aw7O2qbtHtCptkucEjuYb91qq
        YOySJBvBGtfVsOyXm81NKUDCtrSQ6OUINOWSdZy1HfBbtQHHpAXnc5FHYCY+3rioUZqleAq2fmhzo
        10g8dunA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1paTfr-00FCi4-0t;
        Fri, 10 Mar 2023 03:44:07 +0000
Date:   Fri, 10 Mar 2023 03:44:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH] fs: Fix description of vfs_tmpfile()
Message-ID: <20230310034407.GI3390869@ZenIV>
References: <20230306103531.1298202-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306103531.1298202-1-roberto.sassu@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 06, 2023 at 11:35:31AM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Update the description of vfs_tmpfile() to match the current parameters of
> that function.
> 
> Fixes: 9751b338656f ("vfs: move open right after ->tmpfile()")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Christian Brauner <brauner@kernel.org>

Applied (#work.misc)
