Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6ABD484F84
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 09:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbiAEIqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 03:46:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41997 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238589AbiAEIqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 03:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641372369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NHbWblWLX7w+qNgr4qrq0wrqLLwfMancNfbrSbaZv0U=;
        b=bPrKDHywmWGEKRTrlCwzVASBl0G9fkwYOotYeodf1XqQK2pvYMiOMA5rAgZEfFu/uatgKu
        /YzeWTMgh+Kk80O3GSXhXU/96cA0huhwcAM5+gWEUKaC+7ZFALDmFsjwWqQXgZrRFcc6fi
        ylMPUvIoCYGeRkjVg0SDhJH4VGd4Yow=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-r-ECCmArOfiUb3he7ffXOA-1; Wed, 05 Jan 2022 03:46:08 -0500
X-MC-Unique: r-ECCmArOfiUb3he7ffXOA-1
Received: by mail-wm1-f71.google.com with SMTP id k40-20020a05600c1ca800b00345bf554707so194880wms.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jan 2022 00:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=NHbWblWLX7w+qNgr4qrq0wrqLLwfMancNfbrSbaZv0U=;
        b=Tvf/NR3QGHGM11DgvQJQMQ4VLhPxN/BK+HBNe7IstRx0zxqlEloaYYHP8orah2Ioui
         ym2hnqxcmmq+VlAIxQVXwJLRDIlQwn4ekoQtyjk/BDT8ZnPTXXZcpshNuh4X8RhUQFpx
         ff9PF0PB4zh4thX8Xpz+aBbmDdd/vy30i/pAdkKlObr5XQuFFSaAKyXCqaNN/MPcf3K5
         fY2g5OqY812ogZ9m91gVK0OuElwETOl3xU4romoQFxaJ1wUerS85Frr0kj5bz9dWStDW
         mPGiBqnaTTS+4+ogRh5LlTmoGHcqtanWuulI3/CG61vptIw988XjeGUZ1HEgnMvu/ZHt
         RU0Q==
X-Gm-Message-State: AOAM531t9SUuOdf3GXopvpt47re4kbjGv9OXbrCtkxlhZr7tA/gosAAF
        5lzsfy+ON2Bg8UcGYEmolIOAM0zous4CxD8BytxY0gzHoM+AW7UQ4sDSkFgraAwSO6XqwtN7Dkl
        awYmhWGdOf1+mZbDi+BYv751zEA==
X-Received: by 2002:a05:600c:4410:: with SMTP id u16mr1885213wmn.46.1641372367322;
        Wed, 05 Jan 2022 00:46:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTtf+7plRNRmAYJnxjkla9v82xRqQI6wowda7YsLF+PqrpHkU59+UbgLvlksNTqDo6QkR1BQ==
X-Received: by 2002:a05:600c:4410:: with SMTP id u16mr1885198wmn.46.1641372367128;
        Wed, 05 Jan 2022 00:46:07 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6cd6.dip0.t-ipconnect.de. [91.12.108.214])
        by smtp.gmail.com with ESMTPSA id c13sm39482052wrt.114.2022.01.05.00.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 00:46:06 -0800 (PST)
Message-ID: <93a8e489-5ca5-7593-5d2b-59280187e2a1@redhat.com>
Date:   Wed, 5 Jan 2022 09:46:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: remove Xen tmem leftovers
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20211224062246.1258487-1-hch@lst.de>
 <10ec73d4-6658-4f60-abe1-84ece53ca373@redhat.com>
 <82dbdc2c-20c2-d69b-bdc9-efc54939d54c@suse.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <82dbdc2c-20c2-d69b-bdc9-efc54939d54c@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05.01.22 07:08, Juergen Gross wrote:
> On 04.01.22 15:31, David Hildenbrand wrote:
>> On 24.12.21 07:22, Christoph Hellwig wrote:
>>> Hi all,
>>>
>>> since the remove of the Xen tmem driver in 2019, the cleancache hooks are
>>> entirely unused, as are large parts of frontswap.  This series against
>>> linux-next (with the folio changes included) removes cleancaches, and cuts
>>> down frontswap to the bits actually used by zswap.
>>>
>>
>> Just out of curiosity, why was tmem removed from Linux (or even Xen?).
>> Do you have any information?
> 
> tmem never made it past the "experimental" state in the Xen hypervisor.
> Its implementation had some significant security flaws, there was no
> maintainer left, and nobody stepped up to address those issues.
> 
> As a result tmem was removed from Xen.

Interesting, thanks for sharing. I know tmem mostly from the papers and
thought it was an interesting approach in general. There was even papers
about a virtio implementation, however, actual code never appeared in
the wild :)

-- 
Thanks,

David / dhildenb

