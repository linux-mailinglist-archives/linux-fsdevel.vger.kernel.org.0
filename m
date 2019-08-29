Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69005A2A48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 00:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfH2WuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 18:50:00 -0400
Received: from mail.phunq.net ([66.183.183.73]:51320 "EHLO voyager.galaxy"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727686AbfH2WuA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:50:00 -0400
X-Greylist: delayed 1989 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Aug 2019 18:49:59 EDT
Received: from [172.16.1.14]
        by voyager.galaxy with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.92.1)
        (envelope-from <daniel@phunq.net>)
        id 1i3Sim-00062X-Fo; Thu, 29 Aug 2019 15:16:48 -0700
From:   Daniel Phillips <daniel@phunq.net>
Subject: [ANNOUNCE] Three things.
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        daye <daye@dddancer.com>
Message-ID: <8ccfa9b4-d76c-b25d-7eda-303d8faa0b79@phunq.net>
Date:   Thu, 29 Aug 2019 15:16:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks, how's it going? Over here, we have been rather busy lately,
and for the last five years or so to be honest. Today it is my pleasure
to be able to announce three GPL open source projects:

1) Shardmap

Shardmap is the next generation directory index developed for Tux3, and
which we are now offering as a much needed replacement for Ext4 HTree.
Shardmap meets but usually beats HTree at all scales, has way better
readdir characteristics, and goes where HTree never did: up into the
billions of files per directory, with ease. Shardmap also is well on
its way to becoming a full blown standalone KVS in user space with sub
microsecond ACID operations in persistent memory.[1]

Code for Shardmap is here:

    https://github.com/danielbot/Shardmap

2) Teamachine

Teamachine is a direct threaded code virtual machine with a cycle time
of .7 nanoseconds, which may just make it the fastest interpreter in the
known universe. Teamachine embeds Shardmap as a set of micro ops. With
Teamachine you can rapidly set up a set of Shardmap unit tests, or you
can build a world-beating query engine. Or just kick back and script
your game engine, the possibilities are endless.

Code for Teamachine is here:

    https://github.com/danielbot/TeaMachine

3) Tux3

Tux3 is still alive, is still maintained against current mainline, and
is still faster, lighter, and more ACID than any other general purpose
Linux file system. Inasmuch as other devs have discovered that the same
issue cited as the blocker for merging Tux3 (get user pages) is also
problematic for kernel code that is already merged, I propose today that
we merge Tux3 without further ado, so that we can proceed to develop
a good solution together as is right, proper and just.

Code for Tux3 is here:

    https://github.com/OGAWAHirofumi/tux3/tree/hirofumi

Everyone is welcome to join OFTC #tux3 and/or post to:

   http://tux3.org/cgi-bin/mailman/listinfo/tux3

to discuss these things, or anything at all. Fun times. See you there!

STANDARD DISCLAIMER: SHARDMAP WILL EAT YOUR DATA[2] TEAMACHINE WILL HALT
YOUR MACHINE AND SET IT ON FIRE. DOWNLOAD AND RUN OF YOUR OWN FREE WILL.

[1] Big shoutout to Yahoo! Japan for supporting Shardmap work.

[2] Tux3 is actually pretty good about not eating your data, but that is
another thing.

NB: followup posts are in the works re the detailed nature and status of
Shardmap, Teamachine and Tux3.

Regards,

Daniel
