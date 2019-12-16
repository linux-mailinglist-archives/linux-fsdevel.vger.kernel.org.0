Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 843351206AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 14:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfLPNLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 08:11:07 -0500
Received: from sainfoin-smtp-out.extra.cea.fr ([132.167.192.228]:45096 "EHLO
        sainfoin-smtp-out.extra.cea.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727611AbfLPNLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:11:07 -0500
Received: from pisaure.intra.cea.fr (pisaure.intra.cea.fr [132.166.88.21])
        by sainfoin-sys.extra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP id xBGDB5YU013428
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 14:11:05 +0100
Received: from pisaure.intra.cea.fr (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 121A020637D
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 14:11:05 +0100 (CET)
Received: from muguet2-smtp-out.intra.cea.fr (muguet2-smtp-out.intra.cea.fr [132.166.192.13])
        by pisaure.intra.cea.fr (Postfix) with ESMTP id 05E89206093
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 14:11:05 +0100 (CET)
Received: from zia.cdc.esteban.ctsi (out.dam.intra.cea.fr [132.165.76.10])
        by muguet2-sys.intra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with SMTP id xBGDB4wi007212
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 14:11:04 +0100
Received: (qmail 20981 invoked from network); 16 Dec 2019 13:11:04 -0000
Subject: Re: open_by_handle_at: mount_fd opened with O_PATH
To:     Amir Goldstein <amir73il@gmail.com>
CC:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        MARTINET Dominique 606316 <dominique.martinet@cea.fr>,
        Andreas Dilger <adilger@whamcloud.com>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <2759fc54-9576-aaa0-926a-cad9d09d388c@cea.fr>
 <CAOQ4uxh6pMeNGXDCU2c1v9yRnCjbyr50mFF4y1FphjFM8+yYKQ@mail.gmail.com>
From:   BOUGET Quentin <quentin.bouget@cea.fr>
Organization: CEA-DAM
Message-ID: <2e87c19a-f169-d7e5-71db-c6bc7ed35b36@cea.fr>
Date:   Mon, 16 Dec 2019 14:11:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxh6pMeNGXDCU2c1v9yRnCjbyr50mFF4y1FphjFM8+yYKQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16/12/2019 13:28, Amir Goldstein wrote:
> On Mon, Dec 16, 2019 at 11:39 AM <quentin.bouget@cea.fr> wrote:
>> Hello,
>>
>> I recently noticed that the syscall open_by_handle_at() automatically
>> fails if
>> its first argument is a file descriptor opened with O_PATH. I looked at
>> the code
>> and saw no reason this could not be allowed. Attached to this mail are a
>> a reproducer and the patch I came up with.
>>
>> I am not quite familiar with the kernel's way of processing patches. Any
>> pointer
>> or advice on this matter is very welcome.
>>
> See similar patch by Miklos to do the same for f*xattr() syscalls that
> looks simpler:
> https://lore.kernel.org/linux-fsdevel/20191128155940.17530-8-mszeredi@redhat.com/
>
> Al, any objections to making this change?
>
> Thanks,
> Amir.

Much simpler, indeed (tested it, seems to work).

Thanks,
Quentin

