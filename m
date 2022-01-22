Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE931496D1B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jan 2022 18:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiAVRgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jan 2022 12:36:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230107AbiAVRgY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jan 2022 12:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642872983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xwHew9SxboNbzCrM/hfmKIAu85E2d0G6pYm1kGBbLRs=;
        b=X64OHwuWgvbYBMSUm5AC2i+8Iupn+OgUHeklfDPuYcNm1AOUa2z+oCZX80tJ+YPMAAg2JC
        RtX+EHGZxMFZdJycd2VwZwF0HtNrtFO0htBMIvJy0KXM/rwCB8pWIAqBLm/RhCLp6zC+x2
        bJTmwhwXpIjwLbV32paYBwH4yYfOCwA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-OG0THn4QO6CK9tvWwxxLsg-1; Sat, 22 Jan 2022 12:36:22 -0500
X-MC-Unique: OG0THn4QO6CK9tvWwxxLsg-1
Received: by mail-qk1-f198.google.com with SMTP id z188-20020a3797c5000000b0047cf1030280so2719621qkd.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Jan 2022 09:36:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=xwHew9SxboNbzCrM/hfmKIAu85E2d0G6pYm1kGBbLRs=;
        b=rrX7hMC1ixTsNWFKG1nlMVTZcKEoseyoBa4FxpbrGriiqwj5fZ/Q8hwKrtXw9Rd/wo
         BjzD0ooLFP6CbjAND5AgQolRJZ86tGpCtr6Z5xg/Yvc1HsYWxKbXDq+FBE5Zo3SyxvCV
         uhuVr9N13MNRbeZmLm9f3llS40naRylBi/P0ScGTXoAFf8M/widu05MPVCdVcvfQEJVF
         OmZ/L558cSRMOUprYvnxG1VRgAxOddDIEu9yK4GOHwITSDO/Mc+vveq7vgGRBfF2UDNx
         VYc7wXiM9F+jEzk662pg1V3m4zzNP/5q1ffz8GTWqz8Hbc4MSir/bmtbJujHzuUGVEfo
         hIBA==
X-Gm-Message-State: AOAM531eOSbFxu/v/KlPDrNVkHDPkp8eRjTOHROeN3I7PPpWhQrm5bQK
        EbzfhXvj/MVFQHq2XIohm0wyFkVsN1N5LRV0WXdmd8URvIrp8J2aejNJuPhT8elU9fBiniNOI+o
        n3OJyULBUgCXUHaWDyS1RZKD87A==
X-Received: by 2002:a05:6214:20ab:: with SMTP id 11mr2794965qvd.127.1642872981668;
        Sat, 22 Jan 2022 09:36:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnBja4x/zAUQMlFih5+XIchQa7hzS51WFIRsBS+a26+zgl17+WMzXJvBwaqPJv6o1ZIBI6sw==
X-Received: by 2002:a05:6214:20ab:: with SMTP id 11mr2794956qvd.127.1642872981473;
        Sat, 22 Jan 2022 09:36:21 -0800 (PST)
Received: from [172.31.1.6] ([70.109.152.127])
        by smtp.gmail.com with ESMTPSA id c11sm4810308qte.28.2022.01.22.09.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jan 2022 09:36:21 -0800 (PST)
Message-ID: <e5eaa806-af35-a54a-e4ed-f1edf53f03f8@redhat.com>
Date:   Sat, 22 Jan 2022 12:36:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
From:   Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.6.1 released.
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

My apologies for the confusion of the tagging
of the git tree... I moved from 2.5 to a 2.6
release because in this release NFSv2 is no longer
tolerated. Meaning it can not be enabled and will
error out if used on either the client or server.

I'm hoping this will not be a significant change
but I thought the versioning should reflect the
change.

A number of memory leaks were plugged up, changes
to make the tools a bit more arm64 friendly,
as well as a number of bug fixes...

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.6.1/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.6.1

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.6.1/2.6.1-Changelog
or
    http://sourceforge.net/projects/nfs/files/nfs-utils/2.6.1/

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.

