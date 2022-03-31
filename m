Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853284EE4D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 01:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243018AbiCaXel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 19:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240168AbiCaXek (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:34:40 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E986C24F291
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Mar 2022 16:32:52 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1na4Hb-001MRk-U7; Thu, 31 Mar 2022 23:32:52 +0000
Date:   Thu, 31 Mar 2022 23:32:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/12] Additional patches for 5.18
Message-ID: <YkY6I8VzLe2Seagb@zeniv-ca.linux.org.uk>
References: <20220330144930.315951-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330144930.315951-1-willy@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 30, 2022 at 03:49:18PM +0100, Matthew Wilcox (Oracle) wrote:
> These are some misc patches that I'm going to send to Linus in a
> couple of days.  Nothing earth-shattering, but no reason to delay them
> to the next merge window.  I've pushed them out to
> https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next
> so they'll get a bit of testing in -next.

Looks sane.  Feel free to slap my Reviewed-by: and Acked-by: on those
