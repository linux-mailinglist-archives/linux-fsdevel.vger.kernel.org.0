Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D514D7206
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Mar 2022 02:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbiCMBHE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 20:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiCMBHE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 20:07:04 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAB459A50;
        Sat, 12 Mar 2022 17:05:58 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTCgF-00ATsC-T0; Sun, 13 Mar 2022 01:05:55 +0000
Date:   Sun, 13 Mar 2022 01:05:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: remove fs.f_write_hint
Message-ID: <Yi1Dc0x9j5bPAlQz@zeniv-ca.linux.org.uk>
References: <20220307104701.607750-1-hch@lst.de>
 <20220307104701.607750-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307104701.607750-3-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 07, 2022 at 11:47:01AM +0100, Christoph Hellwig wrote:
> The value is now completely unused except for reporting it back through
> the F_GET_FILE_RW_HINT ioctl, so remove the value and the two ioctls
> for it.

Obvious question - which userland code issues these ioctls?  I obviously
like the series, but...
