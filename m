Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A18820D81E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 22:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbgF2TgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 15:36:14 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:42657 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729568AbgF2TgN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:36:13 -0400
Received: (qmail 16158 invoked from network); 29 Jun 2020 14:24:10 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.242.2.21]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Mon, 29 Jun 2020 14:24:10 +0200
X-GeoIP-Country: DE
Subject: Re: Kernel 5.4 breaks fuse 2.X nonempty mount option
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        "p.kramme@profihost.ag" <p.kramme@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>
References: <736d172c-84ff-3e9f-c125-03ae748218e8@profihost.ag>
 <1696715.1592552822@warthog.procyon.org.uk>
 <4a2f5aa9-1921-8884-f854-6a8b22c488f0@profihost.ag>
 <2cfa1de5-a4df-5ad3-e35b-3024cad78ed1@profihost.ag>
 <CAJfpegvLJBAzGCpR6CQ1TG8-fwMB9oN8kVFijs7vK+dvQ6Tm5w@mail.gmail.com>
 <bffa6591-6698-748d-ba26-a98142b03ae8@profihost.ag>
 <CAJfpegur2+5b0ecSx7YZcY-FB_VYrK=5BMY=g96w+uf3eLDcCw@mail.gmail.com>
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <1492c31e-9b0c-64b5-8dd9-d9c0b4372f29@profihost.ag>
Date:   Mon, 29 Jun 2020 14:24:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegur2+5b0ecSx7YZcY-FB_VYrK=5BMY=g96w+uf3eLDcCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

Am 26.06.20 um 10:34 schrieb Miklos Szeredi:
> On Thu, Jun 25, 2020 at 10:10 PM Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>>
>> Does a userspace strace really help? I did a git bisect between kernel
>> v5.3 (working) und v5.4 (not working) and it shows
> 
> I cannot reproduce this with the libfuse2 examples.  Passing
> "nonempty" as a mount(2) in either v5.3 or v5.4 results in -EINVAL.
> So without an strace I cannot tell what is causing the regression.

the exact mount command is:
ceph-fuse /var/log/pve/tasks -o noatime,nonempty

so you mean i should just run strace -ff -s0 on it and throw the output
to pastebin?

Greets,
Stefan
