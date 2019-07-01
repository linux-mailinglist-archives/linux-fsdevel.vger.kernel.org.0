Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAFED5BEB7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 16:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfGAOwF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 10:52:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfGAOwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iNgGMHAOMdwbYrGUW9dUANMTp/OnqfmLFCUXKRGNhqU=; b=tKAdlaBkc6+ZhWNkkzk5/6n+v
        9FLtdiXQhfQnlRJPwhhhuN7r6QAfd7K2X5s5fBgSViAS+piJS1JIqKLf5tSXkUX7FiFrdWYlm9lJj
        n3HotnqonJghfRMa66zYF+c+C7dhQ9LdhW2e6HSNiiYicixA9R9pBedgTX+fkOdHoXGm/GCUxVzAp
        QoR1IcodhQcJLz8OwyX7ucYFio2hkDTxx9SilsZ+OYRaq1W+3vt3E5/K8meT3t3JW7Zf8Q8YtxMzO
        1/eSFB0FTnl950+jA4eE2B+XQW27I0BXn10RSPUY+W144d/BPUjMMLME8n2VoMPHixcfv0MJvtVUs
        rf9M2wc9Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhxf1-0008LD-9H; Mon, 01 Jul 2019 14:52:03 +0000
Subject: Re: [PATCH 2/6] Adjust watch_queue documentation to mention mount and
 superblock watches. [ver #5]
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7a288c2c-11a1-87df-9550-b247d6ce3010@infradead.org>
 <156173701358.15650.8735203424342507015.stgit@warthog.procyon.org.uk>
 <156173703546.15650.14319137940607993268.stgit@warthog.procyon.org.uk>
 <8212.1561971170@warthog.procyon.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <90d07cf5-5ba4-1fb6-72b3-f120423a7726@infradead.org>
Date:   Mon, 1 Jul 2019 07:52:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8212.1561971170@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/1/19 1:52 AM, David Howells wrote:
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> I'm having a little trouble parsing that sentence.
>> Could you clarify it or maybe rewrite/modify it?
>> Thanks.
> 
> How about:
> 
>   * ``info_filter`` and ``info_mask`` act as a filter on the info field of the
>     notification record.  The notification is only written into the buffer if::
> 
> 	(watch.info & info_mask) == info_filter
> 
>     This could be used, for example, to ignore events that are not exactly on
>     the watched point in a mount tree by specifying NOTIFY_MOUNT_IN_SUBTREE
>     must not be set, e.g.::
> 
> 	{
> 		.type = WATCH_TYPE_MOUNT_NOTIFY,
> 		.info_filter = 0,
> 		.info_mask = NOTIFY_MOUNT_IN_SUBTREE,
> 		.subtype_filter = ...,
> 	}
> 
>     as an event would be only permissible with this filter if::
> 
>     	(watch.info & NOTIFY_MOUNT_IN_SUBTREE) == 0
> 
> David
> 

Yes, better.  Thanks.

-- 
~Randy
