Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB866143EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 05:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiKAEdX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 00:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKAEdW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 00:33:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7294384;
        Mon, 31 Oct 2022 21:33:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E0E860F72;
        Tue,  1 Nov 2022 04:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE2CC433D6;
        Tue,  1 Nov 2022 04:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667277200;
        bh=S6J6gnx37ncA0g8KRYAs0JwCn4toE/be+QwSrIPnqQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SO9YmAEDID2KF10xGyqYOVrKWDXo4LusNHXlBf6l7nTk6KwAKJzlCxn8Fvx+J6ccp
         lXDKy/i1UXaGErldQn0eY0zmYow4MA/+JH2xlMS5Gq0d/XqbPym5WEiLc1R0TdOwb0
         9J6KT1K2aD/sc3O0IZ/gNa2qQa3dABcOzaK2WWIM=
Date:   Tue, 1 Nov 2022 05:34:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karel Zak <kzak@redhat.com>,
        Masatake YAMATO <yamato@redhat.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH] proc: add byteorder file
Message-ID: <Y2Chv8uO04ahV9W8@kroah.com>
References: <20221101005043.1791-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101005043.1791-1-linux@weissschuh.net>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 01:50:43AM +0100, Thomas Weiﬂschuh wrote:
> Certain files in procfs are formatted in byteorder dependent ways. For
> example the IP addresses in /proc/net/udp.
> 
> Assuming the byteorder of the userspace program is not guaranteed to be
> correct in the face of emulation as for example with qemu-user.
> 
> Also this makes it easier for non-compiled applications like
> shellscripts to discover the byteorder.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Why not put this in /sys/kernel/ instead?  What does this have to do
with /proc/ other than it's traditionally been the dumping ground for
stuff like this?  :)

thanks,

greg k-h
