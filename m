Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058D51E47BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 17:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgE0PlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 11:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgE0PlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 11:41:13 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9B6C05BD1E
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2020 08:41:13 -0700 (PDT)
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 049CD2E15C6;
        Wed, 27 May 2020 18:41:11 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id NGexgijeZg-f9xO3Yql;
        Wed, 27 May 2020 18:41:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1590594070; bh=GZ9x2ZWGySF4Uqa2Gprk7wuQyDm6zUMRUd8rMTt/U0M=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=AQjq/e77J+OVLRT4H021tGYF3Ii/ps+KJSby5kWi0IPv+7j8AvpvUslANbYdf7bsY
         ZbdE+y0nXcKxTXAwWeQCbjz4xwTLAQ/fGhn0yzzBMfp/bddO2Xl6xxI/2+LVWFlYCx
         HglSOODQqS47DmAukFgT6vUKiQOZifsEAqeTsY18=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:1324::1:4])
        by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id wv4sh5qY4F-f9X85OPB;
        Wed, 27 May 2020 18:41:09 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] vfs, afs, ext4: Make the inode hash table RCU searchable
To:     David Howells <dhowells@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <8ac18259-ad47-5617-fa01-fba88349b82d@yandex-team.ru>
 <195849.1590075556@warthog.procyon.org.uk>
 <3735168.1590592854@warthog.procyon.org.uk>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <8c74f334-3711-ea07-9875-22f379a62bb3@yandex-team.ru>
Date:   Wed, 27 May 2020 18:41:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3735168.1590592854@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27/05/2020 18.20, David Howells wrote:
> Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:
> 
>>> Is this something that would be of interest to Ext4?
>>
>> For now, I've plugged this issue with try-lock in ext4 lazy time update.
>> This solution is much better.
> 
> Would I be able to turn that into some sort of review tag?

This version looks more like RFC, so

Acked-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

this definitely will fix my problem with ext4 lazytime:
https://lore.kernel.org/lkml/158040603451.1879.7954684107752709143.stgit@buzz/

> 
> David
> 
