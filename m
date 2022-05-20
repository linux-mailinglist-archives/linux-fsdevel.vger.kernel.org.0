Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9E152E366
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 05:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345265AbiETD4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 23:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345254AbiETD4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 23:56:14 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EC5381A2;
        Thu, 19 May 2022 20:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WvGjtR6qZ4Bar1EwTL1Ag7SU1XkDDUufcV0zIp+ja0M=; b=ed8YFKadAPDMbtpuAAxpC2O2e5
        JqUHl2Rce2Hg8+6+C9iItbDTT5gfUEeXSnTBQjaZGyLYUN85GqJFAG1SzPc080Ux98gCfFPmMk8Zb
        6Xt5h6ppqNnPXpf6Kp/Emjesp09WNDBQ03uQIth8XmkOv+g2XouBoJY1SQG7+QcgS+Y/g346gOrWh
        gcYP+Mnai404SaYeSS82RAboYN0xETfShy8z6s4ne0vRcsVkQ9SYXbwwZxgnQnErMck4yG80KpYB0
        pPmEF292U9CKNapNnhcGGD8snworgmsEqXWUFaKi9TAH7ty/V/LHZX6S5jio753rVT9e53JcXDjqz
        9F5xmFHg==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrtkG-00GUZu-Es; Fri, 20 May 2022 03:56:08 +0000
Date:   Fri, 20 May 2022 03:56:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     He Zhe <zhe.he@windriver.com>, Dave Chinner <dchinner@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Luis Henriques <lhenriques@suse.com>
Subject: Re: warning for EOPNOTSUPP vfs_copy_file_range
Message-ID: <YocRWLtlbokO0jsi@zeniv-ca.linux.org.uk>
References: <20f17f64-88cb-4e80-07c1-85cb96c83619@windriver.com>
 <CAOQ4uxiQTwEh3ry8_8UMFuPPBjwA+pb8RLLuG=93c9hYtDqg8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiQTwEh3ry8_8UMFuPPBjwA+pb8RLLuG=93c9hYtDqg8g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 04:53:15PM +0300, Amir Goldstein wrote:

> Luis gave up on it, because no maintainer stepped up to take
> the patch, but I think that is the right way to go.
> 
> Maybe this bug report can raise awareness to that old patch.
> 
> Al, could you have a look?

IIRC, you had objections to that variant back then...
