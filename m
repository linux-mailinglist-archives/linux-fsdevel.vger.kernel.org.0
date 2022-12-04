Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA56B641B78
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Dec 2022 09:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLDIRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Dec 2022 03:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLDIRL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Dec 2022 03:17:11 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FE914D1C
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Dec 2022 00:17:10 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AA39768AFE; Sun,  4 Dec 2022 09:17:07 +0100 (CET)
Date:   Sun, 4 Dec 2022 09:17:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: remove ->writepage in ntfs3
Message-ID: <20221204081707.GA26937@lst.de>
References: <20221116133452.2196640-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116133452.2196640-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 16, 2022 at 02:34:50PM +0100, Christoph Hellwig wrote:
> Hi Konstantin,
> 
> this small series removes the deprecated ->writepage method from ntfs3.
> I don't have a ntfs test setup so this is untested and should be handled
> with care.

Did you get a chance to look into this?
