Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CD03A68DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 16:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhFNOWF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 10:22:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233727AbhFNOWE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623680401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F4r6zXU9JovBkh6SsFD5G5K6EvAJNO/7FLVKe9QAg28=;
        b=JbI4rXkEAIkTvnlDL9qSK13XolnQRuqnWOGjLzQT/S1KYaHcoLeiqypGoEYm9K9f6FhTDU
        Wq1lVstRJuIXpkorcnypwvoLBig2rvLrUc/hWecGzSXYbbAzCbuVBoHqLr7gpEM5SyR/gs
        5s4efNEn7S2HmMlDKp8GtnsAqcGQG20=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-wICxECGENImOtNNFpwScgw-1; Mon, 14 Jun 2021 10:20:00 -0400
X-MC-Unique: wICxECGENImOtNNFpwScgw-1
Received: by mail-qk1-f200.google.com with SMTP id u6-20020ae9c0060000b02903ab0c9eea47so8766256qkk.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jun 2021 07:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=F4r6zXU9JovBkh6SsFD5G5K6EvAJNO/7FLVKe9QAg28=;
        b=iQxj1kQi0gp6fd195/dtKbOWI/0QvqKpPeyqfOAMhWvVnBZLgnPtmGVl2tpnZBJOQR
         shCbV/rrjJRHXqOFf9n3HvaJCvmUWbUkTI0A9QJp1TcySHo+b3/dUnm+wSmBl7DP/4Ia
         /ysg2PXLI48WTFJbcWWSHxBnI8dMyw/D7Rt25NGFCrOVFQoKMGe2N+hv+HkJg6bgnsss
         mqCPD0PR2pI01UuJLmiI0sSkzAf6EDlZQn2nnI2dVqJw+iH35UwCVGHNMnVzpGAoAXD0
         5bCZXXwSyHuITCDmEFjkL5qUZAXejA9d2xVj6jRuALjKrV8RRmXg4/pQdESBdXfgwU/6
         XzLw==
X-Gm-Message-State: AOAM533ItMxqBbkeikTjlFwA6ukh4CFhTBVy3sakFxEr8an3WEJtmtcB
        dJ1woAt++1F6aGMf9ZxhF4DsyZSt4gU2jpuNnieTGFW/j8AbtE/kP0e9nLMxBrcWlTRi5lekNaj
        m6AGkCLzNgoAD20gBB5hBzW75/8DEUYzWYygDvmJHGkPryHdBJy0yTeWVG6CTcwcRgEVDUloman
        M=
X-Received: by 2002:a37:9f51:: with SMTP id i78mr16654516qke.345.1623680399616;
        Mon, 14 Jun 2021 07:19:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/6IEZ+QfVUK02KN9O4bl5mcthGlZiOTp4RNVssZ1tim/l1UA5wkakFDU2Ls8uv4MXDweuxg==
X-Received: by 2002:a37:9f51:: with SMTP id i78mr16654492qke.345.1623680399310;
        Mon, 14 Jun 2021 07:19:59 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([71.161.93.112])
        by smtp.gmail.com with ESMTPSA id w4sm9781676qtv.79.2021.06.14.07.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 07:19:59 -0700 (PDT)
From:   Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.5.4 released.
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Message-ID: <c8795653-7728-18a4-93dc-58943ad0fe09@redhat.com>
Date:   Mon, 14 Jun 2021 10:23:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

This release contains a number of bug fixes, man page
updates as well as updates to rpc.gssd that allows
the deamon to recover from thread creation failures
and threads hung in the Kerberos library.

Finally, a couple new flags were added to mountd
that allows the setting of the TTL and tweaks how
messages are logged.

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.5.4/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.5.4

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.5.4/2.5.4-Changelog
or
    http://sourceforge.net/projects/nfs/files/nfs-utils/2.5.4/

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.

