Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A132001B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 07:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgFSFkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 01:40:12 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:23641 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726005AbgFSFkM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 01:40:12 -0400
Received: (qmail 30233 invoked from network); 19 Jun 2020 07:40:10 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.242.2.10]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Fri, 19 Jun 2020 07:40:10 +0200
X-GeoIP-Country: DE
Subject: Re: Kernel 5.4 breaks fuse 2.X nonempty mount option
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
To:     dhowells@redhat.com, ebiggers@google.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        "p.kramme@profihost.ag" <p.kramme@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>,
        miklos@szeredi.hu
References: <736d172c-84ff-3e9f-c125-03ae748218e8@profihost.ag>
Message-ID: <e9fe0234-e815-78ff-00c3-f4e60c60b945@profihost.ag>
Date:   Fri, 19 Jun 2020 07:40:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <736d172c-84ff-3e9f-c125-03ae748218e8@profihost.ag>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

added: miklos@szeredi.hu

Am 18.06.20 um 22:38 schrieb Stefan Priebe - Profihost AG:
> Hi,
> 
> while using fuse 2.x and nonempty mount option - fuse mounts breaks
> after upgrading from kernel 4.19 to 5.4.
> 
> While everything works fine under 4.19 - a mount on kernel 5.4 gives me
> the following kernel message and an unmountable fuse mount:
> [  201.289586] fuse: Unknown parameter 'nonempty'
> 
> While nonempty is clearly a fuse 2.x mount option, which should be
> handled in userspace it seems it is passed to the kernel and older
> kernels just ignored it.
> 
> It might be that those reworks have caused this:
> 
> commit 9bc61ab18b1d41f26dc06b9e6d3c203e65f83fe6
> Author: David Howells <dhowells@redhat.com>
> Date:   Sun Nov 4 03:19:03 2018 -0500
> 
>     vfs: Introduce fs_context, switch vfs_kern_mount() to it.
> 
> ...
> 
> commit c7eb6869632a5d33b41d0a00d683b8395392b7ee
> Author: David Howells <dhowells@redhat.com>
> Date:   Mon Mar 25 16:38:31 2019 +0000
> 
>     vfs: subtype handling moved to fuse
> 
> Can anybody help?
> 
> Greets,
> Stefan
> 
