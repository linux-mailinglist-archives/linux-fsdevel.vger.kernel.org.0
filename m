Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2636E3F43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 08:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjDQGBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 02:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDQGBN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D782D62;
        Sun, 16 Apr 2023 23:01:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B745561492;
        Mon, 17 Apr 2023 06:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD47C433EF;
        Mon, 17 Apr 2023 06:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681711271;
        bh=6FFhy1MA0NOpYvy0dbAS0WVVaRt74jiB9mX3xaybZMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBfAiKGIQNXZzznGHxErw8IweVa0cUcaGrMeeysVA7d/EPdxyZfT4HiFcIaVw/AVe
         YqYAeRCen1uEK3QLjPj0QQTq9I6lu8FueKNcbc8aHwfJGoxsqNu2Yp0SVlpn854oHD
         f5Vob/mo8ZYptXBxVLXb0OQgD+f+H/OVyj8BYAYQ=
Date:   Mon, 17 Apr 2023 08:01:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Sanderson <kyle.leet@gmail.com>
Cc:     linux-btrfs@vger.kernel.org,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: btrfs induced data loss (on xfs) - 5.19.0-38-generic
Message-ID: <ZDzgojYAZXS_D_OH@kroah.com>
References: <CACsaVZJGPux1yhrMWnq+7nt3Zz5wZ6zEo2+S2pf=4czpYLFyjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsaVZJGPux1yhrMWnq+7nt3Zz5wZ6zEo2+S2pf=4czpYLFyjg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 16, 2023 at 10:20:45PM -0700, Kyle Sanderson wrote:
> The single btrfs disk was at 100% utilization and a wa of 50~, reading
> back at around 2MB/s. df and similar would simply freeze. Leading up
> to this I removed around 2T of data from a single btrfs disk. I
> managed to get most of the services shutdown and disks unmounted, but
> when the system came back up I had to use xfs_repair (for the first
> time in a very long time) to boot into my system. I likely should have
> just pulled the power...
> 
> [1147997.255020] INFO: task happywriter:3425205 blocked for more than
> 120 seconds.
> [1147997.255088]       Not tainted 5.19.0-38-generic #39~22.04.1-Ubuntu

This is a distro-specific kernel, sorry, nothing to do with our releases
as the 5.19 kernel branch is long end-of-life.  Please work with your
distro for this issue if you wish to stick to this kernel version.

good luck!

greg k-h
