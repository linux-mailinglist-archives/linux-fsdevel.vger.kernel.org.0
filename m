Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95256A88B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 19:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjCBSt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 13:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCBSt4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:49:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F7811149;
        Thu,  2 Mar 2023 10:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=agqc831C8v4FMtdYpZfvj2AmsMmIWRE9gM+fVerrSqc=; b=JeanFOxt8sJYlvsUJtWVjlquNR
        UUH3VAdW2tXhESxQ55dI0UK/B+tyQ03zcJJuCX8HSa6odH6LQXpITsUgoJn5Vlg9kwN1eLhJmMfhr
        Wdsu7Dc5N4Bd1gHJr2CDMIX9jSN5GINinQRYsMMI2b4Pa6Xyo5QgUlq142pTTVNW4ukylTsWYrSag
        mH1+ad8gvvHJHD15jIoH4vYpTuSUQQSeuGsXd8bMvnDNfr41n8y13nW/jMmdGTn5+ivEiWdgvdU3r
        DpNxQEREXqMrIbO0JyyTaCFG1alUrEOuJXeWS4sfGq7dLckcu5YdLJdPREm6lpo0pm6UjbZkwoTmm
        Hf8omiCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXnzs-002aR2-Gi; Thu, 02 Mar 2023 18:49:44 +0000
Date:   Thu, 2 Mar 2023 18:49:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        joe.jin@oracle.com
Subject: Re: [PATCH 3/3] kernfs: change kernfs_rename_lock into a read-write
 lock.
Message-ID: <ZADvyJcIazbpCnPu@casper.infradead.org>
References: <20230302043203.1695051-1-imran.f.khan@oracle.com>
 <20230302043203.1695051-4-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302043203.1695051-4-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 03:32:03PM +1100, Imran Khan wrote:
> kernfs_rename_lock protects a node's ->parent and thus kernfs topology.
> Thus it can be used in cases that rely on a stable kernfs topology.
> Change it to a read-write lock for better scalability.
> 
> Suggested by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
