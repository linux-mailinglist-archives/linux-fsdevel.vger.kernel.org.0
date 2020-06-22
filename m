Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37500202F9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 08:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbgFVGEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 02:04:16 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:40675 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729114AbgFVGEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 02:04:16 -0400
Received: (qmail 4569 invoked from network); 22 Jun 2020 08:04:14 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.242.2.15]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Mon, 22 Jun 2020 08:04:14 +0200
X-GeoIP-Country: DE
Subject: Re: Kernel 5.4 breaks fuse 2.X nonempty mount option
To:     dhowells@redhat.com, ebiggers@google.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        "p.kramme@profihost.ag" <p.kramme@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>
References: <736d172c-84ff-3e9f-c125-03ae748218e8@profihost.ag>
 <87pn9rsmp2.fsf@vostro.rath.org>
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <c4b7e202-357a-c51c-2683-2596d908a713@profihost.ag>
Date:   Mon, 22 Jun 2020 08:04:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87pn9rsmp2.fsf@vostro.rath.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Am 22.06.20 um 07:18 schrieb Nikolaus Rath:
> On Jun 18 2020, Stefan Priebe - Profihost AG <s.priebe@profihost.ag> wrote:
>> Hi,
>>
>> while using fuse 2.x and nonempty mount option - fuse mounts breaks
>> after upgrading from kernel 4.19 to 5.4.
> 
> IIRC nonempty is not processed by the kernel, but libfuse. This sounds like
> you did a partial upgrade to libfuse 3.x (which dropped the option).

no for sure not. I already posted all details.

Greets,
Stefan

> 
> Best,
> Nikolaus
> 
