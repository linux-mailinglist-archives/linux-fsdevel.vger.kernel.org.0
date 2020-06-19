Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93F2201AD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 21:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbgFSTCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 15:02:12 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:62463 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387818AbgFSTCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:02:11 -0400
Received: (qmail 4290 invoked from network); 19 Jun 2020 21:02:10 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.242.2.5]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Fri, 19 Jun 2020 21:02:10 +0200
X-GeoIP-Country: DE
Subject: Re: Kernel 5.4 breaks fuse 2.X nonempty mount option
To:     David Howells <dhowells@redhat.com>
Cc:     ebiggers@google.com, viro@zeniv.linux.org.uk, mszeredi@redhat.com,
        linux-fsdevel@vger.kernel.org,
        "p.kramme@profihost.ag" <p.kramme@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>
References: <736d172c-84ff-3e9f-c125-03ae748218e8@profihost.ag>
 <1696715.1592552822@warthog.procyon.org.uk>
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <4a2f5aa9-1921-8884-f854-6a8b22c488f0@profihost.ag>
Date:   Fri, 19 Jun 2020 21:02:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1696715.1592552822@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Am 19.06.20 um 09:47 schrieb David Howells:
> Stefan Priebe - Profihost AG <s.priebe@profihost.ag> wrote:
> 
>> while using fuse 2.x and nonempty mount option - fuse mounts breaks
>> after upgrading from kernel 4.19 to 5.4.
> 
> Can you give us an example mount commandline to try?

see fstab which daniel sent or:
ceph-fuse  /var/log/pve/tasks nonempty

Greets,
Stefan

> 
> Thanks,
> David
> 
