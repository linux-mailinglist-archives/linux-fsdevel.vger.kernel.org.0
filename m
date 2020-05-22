Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81ED91DEC63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 17:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgEVPr0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 11:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730058AbgEVPr0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 11:47:26 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09540C061A0E
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 08:47:26 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jc9tH-00DZe0-SX; Fri, 22 May 2020 15:47:20 +0000
Date:   Fri, 22 May 2020 16:47:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Remove duplicated flag from VALID_OPEN_FLAGS
Message-ID: <20200522154719.GS23230@ZenIV.linux.org.uk>
References: <20200522133723.1091937-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200522133723.1091937-1-kw@linux.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 01:37:23PM +0000, Krzysztof Wilczynski wrote:
> From: Krzysztof Wilczyński <kw@linux.com>
> 
> Also, remove extra tab after the FASYNC flag, and keep line under 80
> characters.  This also resolves the following Coccinelle warning:
> 
>   include/linux/fcntl.h:11:13-21: duplicated argument to & or |

Now ask yourself what might be the reason for that "duplicated argument".  
Try to figure out what the values of those constants might depend upon.
For extra points, try to guess what has caused the divergences.

Please, post the result of your investigation in followup to this.
