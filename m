Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3606F732C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 21:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjEDT3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 15:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEDT3p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 15:29:45 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 May 2023 12:29:43 PDT
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8987AB4
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 May 2023 12:29:43 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.135.124])
        by smtp-18.iol.local with ESMTPA
        id ued3pDrlenRXQued3p35zG; Thu, 04 May 2023 21:28:38 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1683228518; bh=IVpux6fOCgjwqTexCyxhnJse4F6g8UGb4x/MYJPNzXA=;
        h=From;
        b=UmAEzWWYJzJ3j5vmEwppGczt9awoHi8AAXDhFCRVNKkBSyLZmlkAZLgC5/D020kf/
         PAD+LtWoZBLTlLUlkirHD9fdEPX5Bz9GHJsutVlg3Fn8HxKmxVFn/119Vyzz1p1jUX
         iTNPSN5dobhJhOHKRAmkkBo/ipJlrr22EOir8lxbq1uQ2kVlHmfVyHfI+Dbsl+ZC4X
         DpJMIaU/lZrdZvMGjLDTivhXO647IcEIyvUeQUPeyhKveyTp796Eke9/UmdKftcLVU
         nca4pnnOKI9iNRK+jMIeRdYKXnB/wVHtHmSoLwDxLVEpMPD95UjesFdtMaKomJomJ6
         IMnxQ+gCtDPcg==
X-CNFS-Analysis: v=2.4 cv=P678xAMu c=1 sm=1 tr=0 ts=64540766 cx=a_exe
 a=qXvG/jU0CoArVbjQAwGUAg==:117 a=qXvG/jU0CoArVbjQAwGUAg==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=V2sgnzSHAAAA:8 a=kyqgP9lRw7menAOuLDkA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Z31ocT7rh6aUJxSkT1EX:22
Message-ID: <5056b834-077c-d1bb-4c46-3213bf6da74b@libero.it>
Date:   Thu, 4 May 2023 21:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 0/2] Supporting same fsid filesystems mounting on btrfs
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <20230504170708.787361-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFKmpG0uDuUno+fMKxjYyfi1Ril/yz+PXHVJJZqmeWLX9vLxkicUZP5obspbPupsVdCRYCLnPy3T0g8iPL4+TrCG/SsRNlB3MEYUDaNMfwTbVk4425A6
 j4RxxQKUngGL3C/kwV2nqN0q7lgeC8OUulQBxhnUTE6Xif7HYJWcJuLQXws2zqxHHHhtN9bHCupa5zuZWHZJuv+qFKGN2ITVlmieNBRUlo70DvJ0xrZSNPr4
 flrLe/AipFFO53ORHgeT5ge5iShKu+JhsqwJE/mi+YNXEIsSFKy4l/wnHaZBNUC5jGdreg6LpOA0s6mwwdOp4CpCAg46LPs1fCPnj/yo59NpeUJ6PgLqoChB
 erx5GPDDkq2dL8Sd097tSPH1xvdRM9SOwiI8UioH+QotJqcuiToc4D50Rmbr3mpw3ZyDHQh5SqYEDE84TlnHUpOH/8BEZUFOqhn6q42S6w+i+2cyj/HKRmG0
 iGnbeE67c1JwdAK+lqOiD3jQYLCHVN7MadiKgHNWuUC6zcxJPdbgHUaUFhX9yIVBm1JNivxIBtsiQ17cy3rOBqcpMJatKJWwnkvVUA==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/05/2023 19.07, Guilherme G. Piccoli wrote:
> Hi folks, this is an attempt of supporting same fsid mounting on btrfs.
> Currently, we cannot reliably mount same fsid filesystems even one at
> a time in btrfs, but if users want to mount them at the same time, it's
> pretty much impossible. Other filesystems like ext4 are capable of that.

Hi Guilherme,

did you tried to run "btrfs dev scan --forget /dev/sd.." before
mount the filesystem ?

Assuming that you have two devices /dev/sdA and /dev/sdB with two btrfs
filesystem with the same uuid, you should mount /dev/sdA

btrfs dev scan --forget /dev/sdB # you can use event /dev/sdA
mount /dev/sdA /mnt/target

and to mount /dev/sdB

btrfs dev scan --forget /dev/sdA # you can use event /dev/sdB
mount /dev/sdB /mnt/target

I made a quick test using two loop devices and it seems that it works
reliably.

Another option should be make a kernel change that "forget" the device
before mounting *if* the filesystem is composed by only one device (
and another few exceptions like the filesystem is already mounted).

This would avoid all the problem related to make a "temporary" uuid.

> 
> The goal is to allow systems with A/B partitioning scheme (like the
> Steam Deck console or various mobile devices) to be able to hold
> the same filesystem image in both partitions; it also allows to have
> block device level check for filesystem integrity - this is used in the
> Steam Deck image installation, to check if the current read-only image
> is pristine. A bit more details are provided in the following ML thread:
> 
> https://lore.kernel.org/linux-btrfs/c702fe27-8da9-505b-6e27-713edacf723a@igalia.com/
> 
> The mechanism used to achieve it is based in the metadata_uuid feature,
> leveraging such code infrastructure for that. The patches are based on
> kernel 6.3 and were tested both in a virtual machine as well as in the
> Steam Deck. Comments, suggestions and overall feedback is greatly
> appreciated - thanks in advance!
> 
> Cheers,
> 
> 
> Guilherme
> 
> 
> Guilherme G. Piccoli (2):
>    btrfs: Introduce the virtual_fsid feature
>    btrfs: Add module parameter to enable non-mount scan skipping
> 
>   fs/btrfs/disk-io.c |  22 +++++++--
>   fs/btrfs/ioctl.c   |  18 ++++++++
>   fs/btrfs/super.c   |  41 ++++++++++++-----
>   fs/btrfs/super.h   |   1 +
>   fs/btrfs/volumes.c | 111 +++++++++++++++++++++++++++++++++++++++------
>   fs/btrfs/volumes.h |  11 ++++-
>   6 files changed, 174 insertions(+), 30 deletions(-)
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

