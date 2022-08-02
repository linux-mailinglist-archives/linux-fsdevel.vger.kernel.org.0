Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1BD588272
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 21:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiHBTWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 15:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiHBTWv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:22:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61ED1A3A4;
        Tue,  2 Aug 2022 12:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YIXycbzkgX75AYn5Z2wPO396ysN8f8fDUuCOSzYTdjU=; b=ZPovnBz00P+VOFse/WxI65uh4/
        nFyTcE0a5fNyqzacbKHRIUuSuKPlt51Lk8EwVKyQiR5qATCkWJHxs6QFiMi0Pw7WB07vEQ9wlfT/O
        H9pZLHj7sr+T81Wp6+1qjJuGGMBw1ZKKfbKOaYmVnwyl3mz09avfBHJawJQ85oCEzTu54NQu7rvZg
        92Y93uYGK0wnKf9Ghnc83QqFoPNigWJOuu0YxiPovchEE5MyP7sOnq22fdHInLgtMYvTumq1nXzhe
        gmOgUlbIO44Cgbvz5xggW4fRH86mmMyDSh7Jdcszw0c14xxFH55kLwtOaHZXz9RumRnMFx2/KFAl6
        GTH41SrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oIxTY-008cZO-Jo; Tue, 02 Aug 2022 19:22:44 +0000
Date:   Tue, 2 Aug 2022 20:22:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@cjr.nz,
        ronniesahlberg@gmail.com, nspmangalore@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tom@talpey.com, samba-technical@lists.samba.org,
        pshilovsky@samba.org, jlayton@kernel.org, rpenny@samba.org
Subject: Re: [RFC PATCH v2 0/5] Rename "cifs" module to "smbfs"
Message-ID: <Yul5hBFmwoOQ0cxG@casper.infradead.org>
References: <20220802190048.19881-1-ematsumiya@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802190048.19881-1-ematsumiya@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 02, 2022 at 04:00:43PM -0300, Enzo Matsumiya wrote:
> Hi,
> 
> As part of the ongoing effort to remove the "cifs" nomenclature from the
> Linux SMB client, I'm proposing the rename of the module to "smbfs".
> 
> As it's widely known, CIFS is associated to SMB1.0, which, in turn, is
> associated with the security issues it presented in the past. Using
> "SMBFS" makes clear what's the protocol in use for outsiders, but also
> unties it from any particular protocol version. It also fits in the
> already existing "fs/smbfs_common" and "fs/ksmbd" naming scheme.
> 
> This short patch series only changes directory names and includes/ifdefs in
> headers and source code, and updates docs to reflect the rename. Other
> than that, no source code/functionality is modified (WIP though).

Why did you not reply to Jeff Layton's concern before posting a v2?
