Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E486664F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 21:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjAKUqL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 15:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjAKUqJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 15:46:09 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3DE2AD6;
        Wed, 11 Jan 2023 12:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=VQ5n5qj5M+uiaUGKz3q5lG4wOwFcki/Sdq/M4M0zrcE=; b=MYsOORcsna5KxCkoYTgDCsHwdB
        uFUQBNQve5XOn4vXvpi3gI7n/FWKrUXU5ZXE5Ext2Rd1GHghmkJJlp65YZrOhyptDUwB0WYizq2U2
        bSv5hsKON5ehF53ECVrIkVoemAPaHnPDjjRICwe9RnFQvZVuiLAiEbG3ZhToJ5HNQLMH90DFQeUeo
        0JgoCeOZV5ez92Gws9TSXYG7qWYXXeBGi8Yzl6rWQboNDL5U/7jpwC7AOf/mX3oZnnMtTgz74CsNt
        YDe28lFD+843sstlJMRJXqlwrEq+3zebroCWTEq6xoPxtE+1h/u/Cmab+jvKQTilFnM5klvp0g3hF
        qpDv08LA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pFhyt-001Mlw-0T;
        Wed, 11 Jan 2023 20:45:55 +0000
Date:   Wed, 11 Jan 2023 20:45:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Andrey Vagin <avagin@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH RESEND v3] nsfs: add compat ioctl handler
Message-ID: <Y78gAyuFHtOcWKVB@ZenIV>
References: <20221214-nsfs-ioctl-compat-v3-1-dce2d26e1fec@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221214-nsfs-ioctl-compat-v3-1-dce2d26e1fec@weissschuh.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 11, 2023 at 04:46:30PM +0000, Thomas Weiﬂschuh wrote:
> As all parameters and return values of the ioctls have the same
> representation on both 32bit and 64bit we can reuse the normal ioctl
> handler for the compat handler via compat_ptr_ioctl().
> 
> All nsfs ioctls return a plain "int" filedescriptor which is a signed
> 4-byte integer type on both 32bit and 64bit.
> The only parameter taken is by NS_GET_OWNER_UID and is a pointer to a
> "uid_t" which is a 4-byte unsigned integer type on both 32bit and 64bit.
> 
> Fixes: 6786741dbf99 ("nsfs: add ioctl to get an owning user namespace for ns file descriptor")
> Reported-by: Karel Zak <kzak@redhat.com>
> Link: https://github.com/util-linux/util-linux/pull/1924#issuecomment-1344133656
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Applied...
