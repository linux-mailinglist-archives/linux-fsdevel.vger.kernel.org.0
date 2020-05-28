Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A9E1E5672
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 07:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgE1FWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 01:22:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53939 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725811AbgE1FWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 01:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590643353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J+iKV2WQ6lOBXo37IQKk0z/KDQxyIDc+E74qSJBHsLY=;
        b=fmMMpN5zq9WxGYd3BlLKOuwp1jPI18Y6IsCNOM/SyPPfP/FEpCxD6edkCZI35Pr0y68S+V
        i5jIuYSO/UJlX9F9MUb7ahM5mrZfoqHB0ocp2FlnlHvmWwQ5dZErlGjs8X6jY3EMUKs73T
        KeCheblfPme+Rf4Zu2l6gs+ov4Cyox8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-6VqPMcmbNz-CLh_3uEDHpg-1; Thu, 28 May 2020 01:22:30 -0400
X-MC-Unique: 6VqPMcmbNz-CLh_3uEDHpg-1
Received: by mail-ej1-f71.google.com with SMTP id d14so1758991ejt.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2020 22:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J+iKV2WQ6lOBXo37IQKk0z/KDQxyIDc+E74qSJBHsLY=;
        b=j97c4oi0aSd2EYFY2ojq8v8SD33nQI3mzlqrh7yH4rICxf6fcohtRdPIAAoB7OcQzK
         hOjFYGwFrVhr8xNV0yho/ZMY956v8fxWksw3eWsQrMQpB4f+EvAMy7dhIumN6lShN2jC
         3VvRf4uAGNMyXioax2Tc7KNj22gI6b/5D7CKa94jkqHvaG1v0QROWyPAzNbutAxIJPez
         tzB/plOSEf8KBp4leF/idMU9OOkwRKzCgOX9BjeRKiWM0JPsewdQrWkH4VQuV/+FQkZp
         vc9tni/cahnpCEseICXQm5G5k3toXjJU8QSnB0Fc3J8S0T3Ky1YpbwjKmrbquvmEr/Vg
         pG4g==
X-Gm-Message-State: AOAM531hd1YBEjarGIWGEnwbLJqiKVqAo6Gklk51wFRLnI97h+XfbLNZ
        6lD7sQe3JlurFc20IV1eqTUtApjVyJMdnIOPkmHLqcKgNR+uNFNiqdfiOAOjkT+yNY6G+VHTtIK
        k7HooJZVU7UEeSC/ni+24mq66qg==
X-Received: by 2002:a50:d6d0:: with SMTP id l16mr1387307edj.317.1590643348991;
        Wed, 27 May 2020 22:22:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJyu6Bj2R7xQtg6fbTx+WdDfElhcWjvy2DluItTe1wU0Un+QkFMtlI7BVZ+bXqt+0zrNq85A==
X-Received: by 2002:a50:d6d0:: with SMTP id l16mr1387289edj.317.1590643348729;
        Wed, 27 May 2020 22:22:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id g23sm4521316ejo.28.2020.05.27.22.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 22:22:28 -0700 (PDT)
Subject: Re: [PATCH v3 0/7] Statsfs: a new ram-based file system for Linux
 kernel statistics
To:     David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Jonathan Adams <jwadams@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>
References: <20200526110318.69006-1-eesposit@redhat.com>
 <20200526153128.448bfb43@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <6a754b40-b148-867d-071d-8f31c5c0d172@redhat.com>
 <20200527132321.54bcdf04@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <af2ba926-73bc-26c3-7ce7-bd45f657fd85@redhat.com>
 <b6fa4439-c6b8-63a4-84fd-fbac3d4f10fd@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c33f59e4-36ca-8fa9-af8f-b4cec4896b00@redhat.com>
Date:   Thu, 28 May 2020 07:22:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b6fa4439-c6b8-63a4-84fd-fbac3d4f10fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/05/20 00:21, David Ahern wrote:
> On 5/27/20 3:07 PM, Paolo Bonzini wrote:
>> I see what you meant now.  statsfs can also be used to enumerate objects
>> if one is so inclined (with the prototype in patch 7, for example, each
>> network interface becomes a directory).
> 
> there are many use cases that have 100's to 1000's have network devices.
> Having a sysfs entry per device already bloats memory usage for these
> use cases; another filesystem with an entry per device makes that worse.
> Really the wrong direction for large scale systems.

Hi David,

IMO the important part for now is having a flexible kernel API for
exposing statistics across multiple subsystems, so that they can be
harvested in an efficient way.  The userspace API is secondary, and
multiple APIs can be added to cater for different usecases.

For example, as of the first five patches the memory usage is the same
as what is now in the mainline kernel, since all the patchset does is
take existing debugfs inodes and move them to statsfs.  I agree that, if
the concept is extended to the whole kernel, scalability and memory
usage becomes an issue; and indeed, the long-term plan is to support a
binary format that is actually _more_ efficient than the status quo for
large scale systems.

In the meanwhile, the new filesystem can be disabled (see the difference
between "STATS_FS" and "STATS_FS_API") if it imposes undesirable overhead.

Thanks,

Paolo

