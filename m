Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2384F66B7B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 08:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjAPHCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 02:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjAPHCR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:02:17 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3AF7EEB
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Jan 2023 23:02:16 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5986E68D05; Mon, 16 Jan 2023 08:02:12 +0100 (CET)
Date:   Mon, 16 Jan 2023 08:02:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 01/25] f2fs: project ids aren't idmapped
Message-ID: <20230116070211.GA15498@lst.de>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org> <20230113-fs-idmapped-mnt_idmap-conversion-v1-1-fc84fa7eba67@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-1-fc84fa7eba67@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 13, 2023 at 12:49:09PM +0100, Christian Brauner wrote:
> Project ids are only settable filesystem wide in the initial namespace.
> They don't take the mount's idmapping into account.
> 
> Note, that after we converted everything over to struct mnt_idmap
> mistakes such as the one here aren't possible anymore as struct
> mnt_idmap cannot be passed to functions that operate on k{g,u}ids.

So wht do we even pass a user namespace to make_kprojid?  That only
asks for this kind of confusing.
