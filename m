Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAD589242
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 17:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfHKPQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 11:16:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48846 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfHKPQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 11:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dkqleU2Uhb668XuNcqpWkpBGGTRILaYqyCoWZyKRgHQ=; b=RTZr1Td80D/qMTrBkDUD8SSsqi
        Nk0EktHG59Mii4abIHioOUFP7V92S9ERUi8hmtZmxB+SbjpDYEWe5yAp4P2ETIqemDhYOYzTbjfpb
        noFF5xfgcSqcrwGITRIGXtzVqEgoyO1n4cTvVcirDWoDmXLwmHCLtLWIYN6DTknQ1tL3jJufenwhH
        bVcYCYJfKCPInIrGeeZPvGlywdF5i1uBRosq17gy7A2KF8gUSaVcfMZFA1brDEdiV4n6Qcxwrz6YW
        PWw67mBusrelbZLUxA8Niwx9HlCKKm1s7UZfWnU4xN476tH9Jw0SnVoW1UjtuDXtVrCHSp3Izuj95
        uVUB1ZJQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hwpZy-0004u7-D3; Sun, 11 Aug 2019 15:16:18 +0000
Subject: Re: [PATCH v12 resend 0/1] fs: Add VirtualBox guest shared folder
 (vboxsf)
To:     Hans de Goede <hdegoede@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
References: <20190811133852.5173-1-hdegoede@redhat.com>
 <8277d9de-4709-df2d-f930-d324c5764871@infradead.org>
 <68fecb6e-7afa-d39d-2f0f-5496aeff510a@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <973451c9-1681-1c73-9190-75d8ef529916@infradead.org>
Date:   Sun, 11 Aug 2019 08:16:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <68fecb6e-7afa-d39d-2f0f-5496aeff510a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/11/19 8:09 AM, Hans de Goede wrote:
> Hi,
> 
> On 8/11/19 5:07 PM, Randy Dunlap wrote:
>> On 8/11/19 6:38 AM, Hans de Goede wrote:
>>> Hello Everyone,
>>>
>>> Here is a resend of the 12th version of my cleaned-up / refactored version
>>> of the VirtualBox shared-folder VFS driver. It seems that for some reason
>>> only the cover letter of my initial-posting of v12 has made it to the list.
>>>
>>> This version hopefully addresses all issues pointed out in David Howell's
>>> review of v11 (thank you for the review David):
>>>
>>> Changes in v12:
>>> -Move make_kuid / make_kgid calls to option parsing time and add
>>>   uid_valid / gid_valid checks.
>>> -In init_fs_context call current_uid_gid() to init uid and gid
>>> -Validate dmode, fmode, dmask and fmask options during option parsing
>>> -Use correct types for various mount option variables (kuid_t, kgid_t, umode_t)
>>> -Some small coding-style tweaks
>>>
>>> For changes in older versions see the change log in the patch.
>>>
>>> This version has been used by several distributions (arch, Fedora) for a
>>> while now, so hopefully we can get this upstream soonish, please review.
>>
>> Hi,
>> Still looks like patch 1/1 is not hitting the mailing list.
>> How large is it?
> 
> Thank you for catching this:
> 
> [hans@dhcp-44-196 linux]$ wc 0001-fs-Add-VirtualBox-guest-shared-folder-vboxsf-support.patch
>   3754  14479 100991 0001-fs-Add-VirtualBox-guest-shared-folder-vboxsf-support.patch

That size shouldn't be a problem AFAIK.
Maybe there is something else in the patch that vger doesn't like.

  http://vger.kernel.org/majordomo-taboos.txt

-- 
~Randy
