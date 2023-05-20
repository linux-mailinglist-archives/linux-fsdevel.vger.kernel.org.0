Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A0970A629
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 09:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjETHeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 03:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjETHeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 03:34:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0256118
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 00:34:20 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C658D68C4E; Sat, 20 May 2023 09:34:17 +0200 (CEST)
Date:   Sat, 20 May 2023 09:34:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yihuan Pan <xun794@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        vgoyal@redhat.com, hch@lst.de
Subject: Re: [PATCH] init: remove unused names parameter in split_fs_names()
Message-ID: <20230520073417.GA2463@lst.de>
References: <4lsiigvaw4lxcs37rlhgepv77xyxym6krkqcpc3xfncnswok3y@b67z3b44orar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4lsiigvaw4lxcs37rlhgepv77xyxym6krkqcpc3xfncnswok3y@b67z3b44orar>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 03:23:32PM +0800, Yihuan Pan wrote:
> The split_fs_names() function takes a names parameter, but the function actually uses the root_fs_names global variable instead. This names parameter is not used in the function, so it can be safely removed.
> 
> This change does not affect the functionality of split_fs_names() or any other part of the kernel.

Way too long line here.

But I actually have a major rework of this code pending, so let's
please keep off from touching it for now.

