Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBD63CB47B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 10:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbhGPIiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 04:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbhGPIiI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:38:08 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9168EC06175F;
        Fri, 16 Jul 2021 01:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Date:Message-ID:From:Cc:To;
        bh=jl+NkA9fA5Rg9bdkaq+zVKa+FZ+5+W26KsIZaVf7W70=; b=RFVdPJCXdpo9/3fSI/aqJuyzph
        5kKuyZ04qbbYFDHMjrZofUKbAotj8QKNggx88Q2m0jUsbIUSXm5OM6UCnm5GPKbRuWk7efg/+ujDw
        4stNKfU3n6sZ6g9tuXi2IAWzUVnvuWinvfO0Iec+9jIc69WOWFcxto+BvRLTSsm5oSBHblZ3iX/IO
        BIm5m9IHjUGz89j3ZQpZ2PuRsWqpXr7E59nH7JBG5ZFBUdJkoVP6B6+KAyHpjrOdv1AjCbHEAYnCI
        Rbl+Jc48r30KhE1Q5wSMy78n6gSglok4bsfoHvvL3kKhBJOkbYzFoG1ESM5x2iuHS7Y+zTIH9h2bX
        I3hKEVqiRDEzEbYikQYH0GnwGFqUk3vLPmjsISANxvOsbqS0HYOMdjZkVgh6MS9hWhGx2fvHAORWP
        nHOAVVDBcsnG+jeV+O8tgC7BuyJa8RexhXdYFE+NmKOclqPC5qJY+S2pOQxzU7CJ/7M8R/UUHLUaj
        TMEgNn+6R/++KAmoXa8AF98D;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1m4JJG-0001aY-NV; Fri, 16 Jul 2021 08:35:02 +0000
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, aurelien.aptel@gmail.com,
        senozhatsky@chromium.org, sandeen@sandeen.net, willy@infradead.org,
        hch@infradead.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, dan.carpenter@oracle.com, hch@lst.de,
        christian@brauner.io, smfrench@gmail.com, hyc.lee@gmail.com
References: <CGME20210716000346epcas1p4fecf8bdde87dd76457b739fc3c1812a3@epcas1p4.samsung.com>
 <20210715235356.3191-1-namjae.jeon@samsung.com>
From:   Stefan Metzmacher <metze@samba.org>
Subject: Re: [PATCH v6 00/13] ksmbd: introduce new SMB3 kernel server
Message-ID: <69f734b3-7e1a-6c9c-d2cc-4debf6c418ca@samba.org>
Date:   Fri, 16 Jul 2021 10:35:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715235356.3191-1-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Namjae,

> Mailing list and repositories
> =============================
>  - linux-cifsd-devel@lists.sourceforge.net

Wasn't the latest idea to use linux-cifs@vger.kernel.org?

>  - https://github.com/smfrench/smb3-kernel/tree/cifsd-for-next

I think you should also include https://git.samba.org/?p=ksmbd.git;a=summary here.

>  - https://github.com/cifsd-team/ksmbd (out-of-tree)
>  - https://github.com/cifsd-team/ksmbd-tools

I would be great to have an actual branch with the posted patches,
I didn't found any in the above repos.

I would make it easier to have a look at the whole set.

Thanks!
metze
