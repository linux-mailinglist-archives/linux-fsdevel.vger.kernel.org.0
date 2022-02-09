Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE7F4AFF7B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 22:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbiBIVwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 16:52:02 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbiBIVwA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:52:00 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009BCDF48F23
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 13:52:00 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id h9so3075652qvm.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Feb 2022 13:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=+KQV3KMSnnUOCfI2fkELTlqbV6pIH87B8EpZ9AiDcXo=;
        b=qy+icEr6KJhCohC425kW8gmaTjZ0ATgSiQzfjVUzvB+4E92YSb7gqUYEuvdO0gtGYU
         nW19DPlzilGzji2/wTnVu65KrVpJ2euZHOAjp9Nxt1SaF14HrYA9C+juWI9q24b58osU
         MFBGthlpfbNIHYx7T6j3DW14SR4CB70E+1KGNU7bvpxA4jU+aI6M2HWRmqO96YQ7f49P
         KadBoUIFca7+RRqrEZnKkYS3WXNaPpLHyDSO2/dKNa+j+pGOnx8BcxEknDdaj5sWFvGx
         dh02QQiJ9+vWbCgA4YBwucly5EAlArMQbLy4t+xybnSNC/PF8dGukX0WuR8WGvQL0ZfB
         aoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=+KQV3KMSnnUOCfI2fkELTlqbV6pIH87B8EpZ9AiDcXo=;
        b=P6umEx23Gm2XweZMUL8BonogpH6c0xGipgHA0X12OkMZEuFtWwBYA2LWHIo5l+mgXX
         g5YiPTGuBm1uFu1MGqFOBPgt/pkgvw5GhOlov5pz3jZE9f2lIXlD5YYFurDHWJ4dmyAX
         X3yiioN6ThYc85xueLzmztXY5HxR+hTWO5jWAmiG+LpDT1ptCYKx4xiinZXozreCW4Ic
         VHVWHy/nKcRqLbHxeKQZn6suxo1KVXpxSuAgAQmfkNaqOH97pPibOKUGNAG0NeEcZ0HE
         WelT9/Rd/3V9BHYtUOXF4V2GBVIqqM+u2i8cZjMZ7SXqMcHtc3X20lNN13DbDd/MJtoA
         GNXg==
X-Gm-Message-State: AOAM532qQEWcvxFFQZBXFwAqU+ikm0kvVUY9EibcvA6MaVLITH//yLkY
        mNy6i1bFojFJHqZcR7Tz4NT+tQ==
X-Google-Smtp-Source: ABdhPJyoMbI85IYVAWwegUJeGiQZ8AcYZmQuxyLdjq00t9sKA24p2TopQ232ctEQFtAHwVPwXJRPeg==
X-Received: by 2002:a05:6214:2306:: with SMTP id gc6mr3009292qvb.131.1644443520168;
        Wed, 09 Feb 2022 13:52:00 -0800 (PST)
Received: from smtpclient.apple ([2600:1700:42f0:6600:cd8a:8634:7b18:da1e])
        by smtp.gmail.com with ESMTPSA id bl1sm8887446qkb.16.2022.02.09.13.51.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Feb 2022 13:51:59 -0800 (PST)
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: [LSF/MM/BPF TOPIC] File system techniques for computational storage
 and heterogeneous memory pool
Message-Id: <E0E49215-1C61-48ED-8A89-889C2E65A53B@bytedance.com>
Date:   Wed, 9 Feb 2022 13:51:57 -0800
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Cong Wang <cong.wang@bytedance.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
To:     lsf-pc@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I would like to discuss potential file system techniques that could =
employ the computational storage=E2=80=99s capabilities and how =
computational storage would collaborate with the file system. File =
system plays the role of mediator between application and storage device =
by means of creating the file/folder abstraction. So, the file system =
still is capable of creating a good abstraction for the case of a =
computational storage device. What could such an abstraction look like? =
The responsibility of the file system would be to offload (send an =
algorithm on storage device side) or to initiate the existing algorithm =
execution on storage device side.

If we consider any algorithm then, usually, an algorithm is a sequence =
of actions that needs to be applied to some set of items or objects of =
some type. So, it is possible to see the necessity to consider: (1) data =
object, (2) algorithm object, (3) object type. Data and algorithm =
objects can still be represented by files. However, there is a tricky =
point of sharing file system knowledge about file=E2=80=99s content =
placement with computational storage. So, finally, what could be a basic =
item to represent an object inside of computational storage? Would it =
be: (1) logical block (LBA), (2) LBA range, (3) stream managed by =
storage device, (4) file system=E2=80=99s allocation group, (5) =
segment/zone? Technically, a folder could still be a namespace that =
groups a set of objects. And algorithm object can be applied by =
computational storage on a folder (set of objects) or file (one object). =
Or, maybe, a file/stream needs to be considered like a set of items?

The next question is when an algorithm execution can be initiated? One =
of the possible way is to execute such an algorithm at the moment of =
delivering the code from the host on the storage device side (eBPF =
way?). However, if the code is already inside of computational storage =
then a trigger model can be used (when some event could initiate the =
code execution). So, the file system could play the role of algorithm =
execution initiator and to define objects that should be processed. The =
trigger model implies that computational storage could register an =
action (algorithm) needed to apply on some object or data type in the =
case of an event. What potential events can be considered: (1) read =
operation, (2) write operation, (3) update operation, (4) GC operation, =
(5) copy operation, (6) metadata operation, and so on?

What potential mechanisms of function/algorithm delivering in =
computational storage? It is possible to consider: (1) SCSI/NVMe packet, =
(2) file/folder extended attribute, (3) DMA exchange, (4) special =
partition.

Any opinions, ideas?

Thanks,
Slava.

