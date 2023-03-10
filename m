Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087FE6B34FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 04:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCJDsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 22:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjCJDsf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:48:35 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE34144AD;
        Thu,  9 Mar 2023 19:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C1CBGLBwvaGa3mgx0DmiI5qj4lO1PYLdZhzQTypCtXI=; b=REnKRcvd4eO3mi3I4E1kyq51h8
        DA6HL6l+BmP4swUeeE0kopQpwx7zWQk7WwhRWcouMWtv9CbB02/DLxJWuorWYmYYlvWuJv0XsprPB
        f+DZosqbO+MKgSZiCcNdANsrYmv/fhdtzoZ/HdqbWIS6WG1SaFtvX3zYauOt1agLy7RxSHpGVzpO7
        TbbYJ6OGDcg/0aB5f1g/wlqr5LV6i/PrA1BrM1Di7mOi7TBi/6xuhTYHR5FlBf6FFQISnnS4jurOP
        YQ7MTM5QgtUfviCa9k5itrvMWnYOEdJ4tADeHhnXJcUfhs+XCjg28gS71dc6C03XkLgXgTlYbfd7S
        AVj9JovA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1paTk0-00FClY-36;
        Fri, 10 Mar 2023 03:48:25 +0000
Date:   Fri, 10 Mar 2023 03:48:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] splice: Remove redundant assignment to ret
Message-ID: <20230310034824.GK3390869@ZenIV>
References: <20230307084918.28632-1-jiapeng.chong@linux.alibaba.com>
 <167835324320.766837.2963092716601467524.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167835324320.766837.2963092716601467524.b4-ty@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 10:15:46AM +0100, Christian Brauner wrote:
> From: Christian Brauner (Microsoft) <brauner@kernel.org>
> 
> 
> On Tue, 07 Mar 2023 16:49:18 +0800, Jiapeng Chong wrote:
> > The variable ret belongs to redundant assignment and can be deleted.
> > 
> > fs/splice.c:940:2: warning: Value stored to 'ret' is never read.
> > 
> > 
> 
> Thanks for the cleanup. Seems ok to do so I picked this up,
> 
> [1/1] splice: Remove redundant assignment to ret
>       commit: c3a4aec055ec275c9f860e88d37e97248927d898

Which branch?
