Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA3C2B7042
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 21:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgKQUiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 15:38:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbgKQUiU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605645499;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DUPF+9bNm2EMgx4/e8UDCTy5nIDtLC2Xx5lpaZyO1mg=;
        b=H//Sn4Qi9cNn+OAcnXRsXZh4bXiW4P39l4n6YA11j+CyvBK0tTJs7+wYMYgZCjYE9cTwMh
        /Wo/YEBiMeAViHtOxI/50bohlmvFvyuPhKyRngKl8QvSIfSte40vkfdpmmvoFWTFAIXUDh
        53c55pfALUycFrGFh6MAG7k7y/KcQ/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-Yc2ClJHKP9Oiq52U406y-w-1; Tue, 17 Nov 2020 15:38:15 -0500
X-MC-Unique: Yc2ClJHKP9Oiq52U406y-w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B8085F9E3;
        Tue, 17 Nov 2020 20:38:13 +0000 (UTC)
Received: from [10.10.112.190] (ovpn-112-190.rdu2.redhat.com [10.10.112.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C00E35B4A2;
        Tue, 17 Nov 2020 20:38:12 +0000 (UTC)
Reply-To: tasleson@redhat.com
Subject: Re: [PATCH] buffer_io_error: Use dev_err_ratelimited
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201026155730.542020-1-tasleson@redhat.com>
 <CAHp75Vfno9LULSfvwYA+4bEz4kW1Z7c=65HTy-O0fgLrzVA24g@mail.gmail.com>
 <71148b03-d880-8113-bd91-25dadef777c7@redhat.com>
 <ec93ba9e-ead9-f49a-d569-abf4c06a60eb@redhat.com>
 <CAHp75VfngLah7nkARydc-BAivtyCQbHhcEGFLHLRHpXFSE_PwQ@mail.gmail.com>
From:   Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <8fc251fd-4ec5-b5d5-8193-c8a59e30b6fa@redhat.com>
Date:   Tue, 17 Nov 2020 14:38:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfngLah7nkARydc-BAivtyCQbHhcEGFLHLRHpXFSE_PwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/28/20 6:22 PM, Andy Shevchenko wrote:
> Staled documentation. You may send a patch to fix it (I Cc'ed
> Christoph and Jonathan).
> It means that it doesn't go under this category and the example should
> be changed to something else.

I'm looking into a suitable replacement example.  Will post
documentation patch when I find one.

Thanks,
Tony

