Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F1B6143F1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 05:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiKAEmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 00:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAEmp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 00:42:45 -0400
X-Greylist: delayed 13913 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Oct 2022 21:42:43 PDT
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF75815704;
        Mon, 31 Oct 2022 21:42:43 -0700 (PDT)
Date:   Tue, 1 Nov 2022 05:42:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1667277761;
        bh=e9z0cElkVGMTLnQzPC9CHfMFa2dDT0eoWbLJwxOR+sE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYWrKe0SvzIM0tLIk8qEyUaAG6jvI2FywxbcT4qO0PQ86GqhyjT4vIsMAR8rZGEZA
         mvmzBXwUybDHCJsu0eua6QxXNQ0pFWIlzYyJvbr72Qi8p37T7x1cikhAEuGjwbhUQR
         cMXvQ60dkUvCDckDbbvxjD7rOfQ/3W2cVBzbCV3o=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karel Zak <kzak@redhat.com>,
        Masatake YAMATO <yamato@redhat.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH] proc: add byteorder file
Message-ID: <cb411513-9cb0-482f-8642-43704c2bfa52@t-8ch.de>
References: <20221101005043.1791-1-linux@weissschuh.net>
 <Y2Chv8uO04ahV9W8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2Chv8uO04ahV9W8@kroah.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-11-01 05:34+0100, Greg KH wrote:
> On Tue, Nov 01, 2022 at 01:50:43AM +0100, Thomas Weißschuh wrote:
> > Certain files in procfs are formatted in byteorder dependent ways. For
> > example the IP addresses in /proc/net/udp.
> > 
> > Assuming the byteorder of the userspace program is not guaranteed to be
> > correct in the face of emulation as for example with qemu-user.
> > 
> > Also this makes it easier for non-compiled applications like
> > shellscripts to discover the byteorder.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> Why not put this in /sys/kernel/ instead?  What does this have to do
> with /proc/ other than it's traditionally been the dumping ground for
> stuff like this?  :)

The main reason to put it in /proc was because the data it helps to interpret
is also in /proc.

But /sys/kernel looks good, too. I'll change it to that.
