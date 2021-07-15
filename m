Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B857F3C97F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhGOFEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237177AbhGOFEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626325275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WtjoUKLcgmL3bnw/gxqCJv6EYfcYaY0E3bn8JDpe3PI=;
        b=HGBLkOX+IZpd9PDeczkUWAdzxkUB6jF+BaMjpI7N1m38DiQuOUKRwW869N/rf4muIE+R7N
        9KBfNt4KWhZWBDpNk6+kT1JzHD6SZAzlLmJfX1/HrHyGMdmNNnF5OIw4cQPu7VkM/IlxX6
        ZxmEcM+pWRmcoghNunOq3wxIMhDCZpE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-k-oCfqRUMHSl_6ZdORUq8A-1; Thu, 15 Jul 2021 01:01:14 -0400
X-MC-Unique: k-oCfqRUMHSl_6ZdORUq8A-1
Received: by mail-pf1-f200.google.com with SMTP id q22-20020a62e1160000b029032b880fc048so3395795pfh.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 22:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WtjoUKLcgmL3bnw/gxqCJv6EYfcYaY0E3bn8JDpe3PI=;
        b=aa07RKMmUD54b/elW2qSafNbZUZVZXqWRknHvZjcZwqreFGuaxRTEGqdBIIt5bUQUF
         zBccfB+5G1Hinr2gyV8W+vS9mAbwfFZK9119GSZPbDNdHji7Ywi08MmyLfHa7zbG4pue
         9gB6cAtVBpBzBgsZoJg5LZaXQwWpTcrwmCFgSI/FlEDk6BpgrT1KlS0OYltKchd3Eg8f
         XLqH3QmGGfRiyYfOPItkcMNaGBS0u8gycH3u7HnE8ZuEukYHQNC0Hv0T9A6xTYqEMJjd
         EVPgiiEgvTw0DD3XuCbmpM/xy63MBvoyiJUsOjf4AieJJFhgjUuJfUzLg49ljPFp+Vnj
         c+hg==
X-Gm-Message-State: AOAM533ZPnDp94JNGCxPhLEBNiTLzwGezen28hGsttjhNMekMYMDKwkG
        i08Yl0nXrdU87LuQPKiZ8XDJV1vx7ygx7zTZ4vPmhmnObcYULw++0XHfGCdVIQQ9/8qUNqlCTvI
        rCUPN2EhX/+bR++P3/TuPAI6fpA==
X-Received: by 2002:a63:1e5c:: with SMTP id p28mr2391186pgm.3.1626325272858;
        Wed, 14 Jul 2021 22:01:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkpF4TSDI5DZm/B2bv9bWVuNXDKhmhRtseurS2rxggrCDnmBokVeS6bdawuICnE0MaFRu/xw==
X-Received: by 2002:a63:1e5c:: with SMTP id p28mr2391148pgm.3.1626325272634;
        Wed, 14 Jul 2021 22:01:12 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o20sm5070990pgv.80.2021.07.14.22.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 22:01:12 -0700 (PDT)
Subject: Re: [PATCH v9 16/17] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org,
        Greg KH <gregkh@linuxfoundation.org>,
        He Zhe <zhe.he@windriver.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-17-xieyongji@bytedance.com>
 <26116714-f485-eeab-4939-71c4c10c30de@redhat.com>
 <CACycT3uh+wUeDM1H7JiCJTMeCVCBngURGKeXD-h+meekNNwiQw@mail.gmail.com>
 <ec3e2729-3490-851f-ed4b-6dee9c04831c@redhat.com>
 <CACycT3vTyR=+6xOJyXCu_bGAKcz4Fx3bA25WfdBjhxJ6MOvLzw@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <5d756360-b540-2faf-6e52-e7e6e863ca0b@redhat.com>
Date:   Thu, 15 Jul 2021 13:00:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3vTyR=+6xOJyXCu_bGAKcz4Fx3bA25WfdBjhxJ6MOvLzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/7/15 下午12:03, Yongji Xie 写道:
>> Which ioctl can be used for this?
>>
> I mean we can introduce a new ioctl for that in the future.


Ok, I see.


>
>>>> I wonder if it's better to do something similar to ccw:
>>>>
>>>> 1) requires the userspace to update the status bit in the response
>>>> 2) update the dev->status to the status in the response if no timeout
>>>>
>>>> Then userspace could then set NEEDS_RESET if necessary.
>>>>
>>> But NEEDS_RESET does not only happen in this case.
>> Yes, so you need an ioctl for userspace to update the device status
>> (NEEDS_RESET) probably.
>>
> Yes, but I'd like to do that after the initial version is merged since
> NEEDS_RESET is not supported now.


Right.

Thanks


>

