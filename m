Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077755AE282
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 10:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbiIFI2w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 04:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239025AbiIFI2j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:28:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B8B696E5
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 01:28:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9712D68BEB; Tue,  6 Sep 2022 10:28:34 +0200 (CEST)
Date:   Tue, 6 Sep 2022 10:28:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Subject: Re: [PATCH 3/6] acl: add vfs_set_acl_prepare()
Message-ID: <20220906082834.GA9377@lst.de>
References: <20220829123843.1146874-1-brauner@kernel.org> <20220829123843.1146874-4-brauner@kernel.org> <20220906045746.GB32578@lst.de> <20220906074532.ysyitr5yxy5adfsx@wittgenstein> <20220906075313.GA6672@lst.de> <20220906080744.3ielhtvqdpbqbqgq@wittgenstein> <20220906081510.GA8363@lst.de> <20220906082428.mfcjily4dyefunds@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906082428.mfcjily4dyefunds@wittgenstein>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:24:28AM +0200, Christian Brauner wrote:
> I think any data that requires to be interpreteted by the VFS needs to
> have dedicated methods. Seth's branch for example, tries to add
> i_op->{g,s}et_vfs_caps() for vfs caps which also store ownership
> information instead of hacking it through the xattr api like we do now.

Yes.  Although with LSMs this will become really messy, but then again
creating a complete unreviewable und auditable mess is what the LSM
infrastructure was created for to start with..
