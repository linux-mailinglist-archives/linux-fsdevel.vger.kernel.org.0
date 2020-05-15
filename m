Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CFA1D531E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 17:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgEOPGG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 11:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgEOPGG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 11:06:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388D9C061A0C;
        Fri, 15 May 2020 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=7K6CdWf4N8dxVLXNgInfVtSHh5OYnenmWosUImu2nCs=; b=eKRCQooTT9w0nJQ/xGCYcjEsBX
        qdaZV40WsNTpJ+G0v+rd18Tq2j4Fdq6QdTA0L6mrVpwfTTklPCtK5Hs0GQGzXV3nF1ZvzXcCMBlVy
        JJyDMjNoz5kdfhUq06tvfZtW4wF99R4o3/rDLZWPlsZmlgfxzmd3P5EXP5XmCCXjrbTdHR3YMy49g
        ysZA9QIAXADeICE/fyr+KVWWq6OA9NBgsxRmwBHtk1MZV4mwySPBOLQhLp5V2z5fop6vJLLDnJVN3
        fb9nGOAE2lBfs4+pHENQGiZTlltaYDoz6/uW6c6n1I23rK8jU4uPZVexK+eiC9N0cN8eOtsMPJ6Zs
        rh5nDlrg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZbuV-0006VS-6f; Fri, 15 May 2020 15:06:03 +0000
Subject: Re: linux-next: Tree for May 12 (fs/namespace.c)
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>
References: <20200512225400.6abf0bda@canb.auug.org.au>
 <22d91c05-49ed-0c32-ba02-e2ded4947f46@infradead.org>
Message-ID: <12fa4586-a47d-4b6f-7b3c-23a036e45f8d@infradead.org>
Date:   Fri, 15 May 2020 08:06:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <22d91c05-49ed-0c32-ba02-e2ded4947f46@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/12/20 8:12 AM, Randy Dunlap wrote:
> On 5/12/20 5:54 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> News: there will be no linux-next release tomorrow.
>>
>> Changes since 20200511:
>>
>> New trees: notifications, fsinfo
>>
> 
> on i386 or x86_64:
> 
>   CC      fs/namespace.o
> ../fs/namespace.c: In function ‘fsinfo_generic_mount_topology’:
> ../fs/namespace.c:4274:42: error: ‘struct mount’ has no member named ‘mnt_topology_changes’
>   p->mnt_topology_changes = atomic_read(&m->mnt_topology_changes);
>                                           ^~
> 
> i.e., CONFIG_MOUNT_NOTIFICATIONS is not set/enabled.
> 
> Full randconfig file is attached.
> 

This build error is still present in linux-next 20200515.


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
