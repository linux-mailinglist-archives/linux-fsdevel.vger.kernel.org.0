Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A1639F933
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 16:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhFHOdp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 10:33:45 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35020 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhFHOdc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:33:32 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by linux.microsoft.com (Postfix) with ESMTPSA id C05AB20B83C5;
        Tue,  8 Jun 2021 07:31:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C05AB20B83C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623162698;
        bh=JnlE/ASrWteshDyQ1tFpfq9txCyaobzxnJrsAw9CmbY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tPgL4q9mybkLrEqqr7lydsUTbK69v8Hr3mCYEsNSKEbIv+fNxoMYwEIx89Eh8OeRZ
         BlVXzrowlasib7cfyS25H9YYWG9lrS8Cv2D0BS+sKFF82/1O9vXpt+OCtbWp0pjTDS
         XDNAcvd+hURQg02X9RRmCU2rer2mqvkEJDg7BxvQ=
Received: by mail-pj1-f44.google.com with SMTP id k7so12022202pjf.5;
        Tue, 08 Jun 2021 07:31:38 -0700 (PDT)
X-Gm-Message-State: AOAM533LsPzXamqa8B7rIidQMMbk8c8uN3q9U/8CL6CSxmKVrl0Qf2AD
        QJVznbveNLo/s86aK6wAz8/fQpiMkRRmWSUEEOs=
X-Google-Smtp-Source: ABdhPJwPTRlQRIgsSDssfFRFzD1jTFn3f0nQELvDQHcXEKHqdpABjcjOa5jBr4FS/1YArSUaseYWm2IEK7XSaA+RwJk=
X-Received: by 2002:a17:90b:4b49:: with SMTP id mi9mr25971333pjb.187.1623162698348;
 Tue, 08 Jun 2021 07:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210520135622.44625-1-mcroce@linux.microsoft.com>
In-Reply-To: <20210520135622.44625-1-mcroce@linux.microsoft.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Tue, 8 Jun 2021 16:31:02 +0200
X-Gmail-Original-Message-ID: <CAFnufp3k7-8FGnFyqushBHq6-bf=b5D-sxOKT7dWx1VKW9hDTw@mail.gmail.com>
Message-ID: <CAFnufp3k7-8FGnFyqushBHq6-bf=b5D-sxOKT7dWx1VKW9hDTw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] block: add a sequence number to disks
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        JeffleXu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 20, 2021 at 3:56 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> From: Matteo Croce <mcroce@microsoft.com>
>
> With this series a monotonically increasing number is added to disks,
> precisely in the genhd struct, and it's exported in sysfs and uevent.
>
> This helps the userspace correlate events for devices that reuse the
> same device, like loop.
>
> The first patch is the core one, the 2..4 expose the information in
> different ways, the 5th increases the seqnum on media change and
> the last one increases the sequence number for loop devices upon
> attach, detach or reconfigure.
>
> If merged, this feature will immediately used by the userspace:
> https://github.com/systemd/systemd/issues/17469#issuecomment-762919781
>

Hi Christoph,

I just noticed that the series doesn't apply anymore. Before
refreshing it, I wish to know what are your opinion on this one, as
nobody expressed one on latest submission.

-- 
per aspera ad upstream
