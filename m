Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85463C792B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 23:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhGMVqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 17:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbhGMVqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 17:46:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2257AC0613DD;
        Tue, 13 Jul 2021 14:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=GQLeKRMWSRiW5L91ltmwseOQjtWUWzctumaRw62vMNI=; b=AETMyMWzyI6VZ69BWkij7PP4Op
        Dg90koNnUGFnsIERnPCVQeiJ52bpAprIaoscFh+LM81e5H42UJEp/UeMSPzbg/jZd9WCQq7zSbEre
        e0MEF+XFz5zM3mHnjt6utrri4fDlpsDbl5uNwzYC32hEbTBzIHCldPXnTCc5YJBQ7O4/r3jMJxLDX
        xggjBWT64DKgrPCLvZ+MtbIRjFQHGm7jKgZNk4J//MSYOJPre/ppC6vT0tk6QsOj/NqMiTAqabJpl
        I5wiq4lDG1Flnk9ygxGwHZkD9YQ4z1UClWuetbjSXAVpSgBlSEUxRUBl0FDs44jTOZ5BlPPP33mfh
        snFmU2Hg==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3QBn-00BPPy-73; Tue, 13 Jul 2021 21:43:39 +0000
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
 <CAHk-=wjW7Up3KD-2EqVg7+ca8Av0-rC5Kd7yK+=m6Dwk3D4Q+A@mail.gmail.com>
 <YO30DKw5FKLz4QuF@zeniv-ca.linux.org.uk>
 <YO31DWtFMZuqF8tm@zeniv-ca.linux.org.uk>
 <fac8ca82-8e9e-cbcf-2e68-b2b281ab0127@infradead.org>
 <YO34eTRpEQKuCzpW@zeniv-ca.linux.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <691ef4d4-c8aa-e953-5062-f238f139395e@infradead.org>
Date:   Tue, 13 Jul 2021 14:43:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YO34eTRpEQKuCzpW@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/13/21 1:32 PM, Al Viro wrote:
> On Tue, Jul 13, 2021 at 01:24:06PM -0700, Randy Dunlap wrote:
> 
>> Hi Al,
>>
>> Where would you prefer for kernel-doc changes in fs/*.[ch] be merged?
>>
>> E.g., from June 27:
>>
>> https://lore.kernel.org/linux-fsdevel/20210628014613.11296-1-rdunlap@infradead.org/
> 
> Umm...  I'd been under impression that kernel-doc stuff in general goes
> through akpm, TBH.  I don't remember ever having a problem with your
> patches of that sort; I can grab that kind of stuff, but if there's
> an existing pipeline for that I'd just as well leave it there...
> 

Jon Corbet has merged some of them, but I'll be glad to send them to
akpm. Thanks.

{adding Cc: akpm for his info}
