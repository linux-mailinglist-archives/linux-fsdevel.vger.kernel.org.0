Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D3F23F125
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 18:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgHGQXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 12:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgHGQXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:23:11 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E788C061756;
        Fri,  7 Aug 2020 09:23:11 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4597-00BE3G-Tq; Fri, 07 Aug 2020 16:23:05 +0000
Date:   Fri, 7 Aug 2020 17:23:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: srvfs: file system for posting open file descriptors into fs
 namespace
Message-ID: <20200807162305.GT1236603@ZenIV.linux.org.uk>
References: <55ef0e9a-fb70-7c4a-e945-4d521180221c@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55ef0e9a-fb70-7c4a-e945-4d521180221c@metux.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 07, 2020 at 01:09:30PM +0200, Enrico Weigelt, metux IT consult wrote:
> Hello folks,
> 
> 
> here's the first version of my "srvfs" implementation - a synthentic
> filesystem which allows a process to "publish" an open file descriptor
> into the file system, so other processes can continue from there, with
> whatever state the fd is already in.
> 
> This is a concept from Plan9. The main purpose is allowing applications
> "dialing" some connection, do initial handshakes (eg. authentication)
> and then publish the connection to other applications, that now can now
> make use of the already dialed connection.

Yeah, but...  Linux open() always gets a new struct file instance; how
do you work around that?  Some variant of ->atomic_open() API change?
Details, please.
